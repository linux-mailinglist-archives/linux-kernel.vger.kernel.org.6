Return-Path: <linux-kernel+bounces-558848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3FA5EC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946551762C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4981FBEA8;
	Thu, 13 Mar 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jHwgkxXK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190521F9F64;
	Thu, 13 Mar 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849222; cv=none; b=ZIwJQ7W5AzfBrZbV6NyknGgF5v+8xggQD1zOTJwtcOxXZc1yHmLwah7Xg/9cSTU7w6z14o7N2W/jlaGIBThqp2RY3NheKvSnj+n4BVuNB1BfJFeU4qRGa0KwtX61dHv20q/TW/n33QWiP7ouJrC0Fh2Wx656oLwlKi7hKfmxKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849222; c=relaxed/simple;
	bh=KUKqqdLbYYz+YQxACtiTVdx8IQKImEqAZ44w0hhKWZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LlV3KDmT/8n2VMfUatrJnxAUTvPFZrLddYT3W8MKSijdebQDob/UNwbTTI7M+lxtZ4a53tqy6eqWXSc1jon14kimobmx58GkvpD8yw/Bm5HTN4gvopRONl0cO2DzVtJAb3B9WRIwOhuTQxx9TVrIAzl63/inqQ6xGOMEtmTdybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jHwgkxXK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CKb5cR012319;
	Thu, 13 Mar 2025 06:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jVcnyrDqDVr1hNL05XJ3Q17WEb2JRVl/jFwHQ0FQgSM=; b=jHwgkxXKmZoW/Lti
	CZ67jrf5dVXB+uXXpp/inuM/ywswb/anlESV80hNJQJQrJCNmiaQrSt/6MkYuiW3
	8nGCIptNm6FyjYrrpOJHUzJuJD2o2rGx9YpPMMfWPxTi9CA3SprX3qCVvw8MRDVK
	u7frvj6RGqflkgBoOz/qR9yq+D3n1cV91q64v/4Pew4qOMYpMHODqOwaxHqCZ4aQ
	ZRrND9ETF1tGU9ct/lKQzh3Pd8bv2x8bcsYMqVsgMgtKa+TT4AQVpe2NxxPcOsNk
	k04HwyJwywVdX26Rhn1dVwpT6ArShfjb8zB14InvDHmXoEFf+BukR5wSLyEo3BUc
	M5WqCQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nmxkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 06:59:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D6xwFS009751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 06:59:58 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 23:59:53 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Thu, 13 Mar 2025 12:29:38 +0530
Subject: [PATCH v6 01/10] clk: qcom: clk-alpha-pll: Add support for dynamic
 update for slewing PLLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250313-qcs615-v5-mm-cc-v6-1-ebf4b9a5e916@quicinc.com>
References: <20250313-qcs615-v5-mm-cc-v6-0-ebf4b9a5e916@quicinc.com>
In-Reply-To: <20250313-qcs615-v5-mm-cc-v6-0-ebf4b9a5e916@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Taniya Das <quic_tdas@quicinc.com>
X-Mailer: b4 0.15-dev-aa3f6
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=67d2826f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=mqrKFzemJvgpN0bEk_AA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SzcFw0ytnZIOU-BqodjTQYE5QN3llw45
X-Proofpoint-GUID: SzcFw0ytnZIOU-BqodjTQYE5QN3llw45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130054

The alpha PLLs which slew to a new frequency at runtime would require
the PLL to calibrate at the mid point of the VCO. Add the new PLL ops
which can support the slewing of the PLL to a new frequency.

Reviewed-by: Imran Shaik <quic_imrashai@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 170 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |   1 +
 2 files changed, 171 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index cec0afea8e446010f0d4140d4ef63121706dde47..7d784db8b7441e886d94ded1d3e3258dda46674c 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2960,3 +2960,173 @@ const struct clk_ops clk_alpha_pll_regera_ops = {
 	.set_rate = clk_zonda_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regera_ops);
+
+static int clk_alpha_pll_slew_update(struct clk_alpha_pll *pll)
+{
+	int ret;
+	u32 val;
+
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE, PLL_UPDATE);
+	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+
+	ret = wait_for_pll_update(pll);
+	if (ret)
+		return ret;
+	/*
+	 * Hardware programming mandates a wait of at least 570ns before polling the LOCK
+	 * detect bit. Have a delay of 1us just to be safe.
+	 */
+	mb();
+	udelay(1);
+
+	return wait_for_pll_enable_lock(pll);
+}
+
+static int clk_alpha_pll_slew_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	unsigned long freq_hz;
+	const struct pll_vco *curr_vco, *vco;
+	u32 l, alpha_width = pll_alpha_width(pll);
+	u64 a;
+
+	freq_hz =  alpha_pll_round_rate(rate, parent_rate, &l, &a, alpha_width);
+	if (freq_hz != rate) {
+		pr_err("alpha_pll: Call clk_set_rate with rounded rates!\n");
+		return -EINVAL;
+	}
+
+	curr_vco = alpha_pll_find_vco(pll, clk_hw_get_rate(hw));
+	if (!curr_vco) {
+		pr_err("alpha pll: not in a valid vco range\n");
+		return -EINVAL;
+	}
+
+	vco = alpha_pll_find_vco(pll, freq_hz);
+	if (!vco) {
+		pr_err("alpha pll: not in a valid vco range\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Dynamic pll update will not support switching frequencies across
+	 * vco ranges. In those cases fall back to normal alpha set rate.
+	 */
+	if (curr_vco->val != vco->val)
+		return clk_alpha_pll_set_rate(hw, rate, parent_rate);
+
+	a = a << (ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll), a >> 32);
+
+	/* Ensure that the write above goes through before proceeding. */
+	mb();
+
+	if (clk_hw_is_enabled(hw))
+		return clk_alpha_pll_slew_update(pll);
+
+	return 0;
+}
+
+/*
+ * Slewing plls should be bought up at frequency which is in the middle of the
+ * desired VCO range. So after bringing up the pll at calibration freq, set it
+ * back to desired frequency(that was set by previous clk_set_rate).
+ */
+static int clk_alpha_pll_calibrate(struct clk_hw *hw)
+{
+	unsigned long calibration_freq, freq_hz;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct clk_hw *parent;
+	const struct pll_vco *vco;
+	u32 l, alpha_width = pll_alpha_width(pll);
+	int rc;
+	u64 a;
+
+	parent = clk_hw_get_parent(hw);
+	if (!parent) {
+		pr_err("alpha pll: no valid parent found\n");
+		return -EINVAL;
+	}
+
+	vco = alpha_pll_find_vco(pll, clk_hw_get_rate(hw));
+	if (!vco) {
+		pr_err("alpha pll: not in a valid vco range\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * As during slewing plls vco_sel won't be allowed to change, vco table
+	 * should have only one entry table, i.e. index = 0, find the
+	 * calibration frequency.
+	 */
+	calibration_freq = (pll->vco_table[0].min_freq + pll->vco_table[0].max_freq) / 2;
+
+	freq_hz = alpha_pll_round_rate(calibration_freq, clk_hw_get_rate(parent),
+					&l, &a, alpha_width);
+	if (freq_hz != calibration_freq) {
+		pr_err("alpha_pll: call clk_set_rate with rounded rates!\n");
+		return -EINVAL;
+	}
+
+	/* Setup PLL for calibration frequency */
+	a <<= (ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll), a >> 32);
+
+	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll), PLL_VCO_MASK << PLL_VCO_SHIFT,
+				vco->val << PLL_VCO_SHIFT);
+
+	/* Bringup the pll at calibration frequency */
+	rc = clk_alpha_pll_enable(hw);
+	if (rc) {
+		pr_err("alpha pll calibration failed\n");
+		return rc;
+	}
+
+	/*
+	 * PLL is already running at calibration frequency.
+	 * So slew pll to the previously set frequency.
+	 */
+	freq_hz = alpha_pll_round_rate(clk_hw_get_rate(hw),
+			clk_hw_get_rate(parent), &l, &a, alpha_width);
+
+	pr_debug("pll %s: setting back to required rate %lu, freq_hz %ld\n",
+		clk_hw_get_name(hw), clk_hw_get_rate(hw), freq_hz);
+
+	/* Setup the PLL for the new frequency */
+	a <<= (ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll), a >> 32);
+
+	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll), PLL_ALPHA_EN, PLL_ALPHA_EN);
+
+	return clk_alpha_pll_slew_update(pll);
+}
+
+static int clk_alpha_pll_slew_enable(struct clk_hw *hw)
+{
+	int rc;
+
+	rc = clk_alpha_pll_calibrate(hw);
+	if (rc)
+		return rc;
+
+	return clk_alpha_pll_enable(hw);
+}
+
+const struct clk_ops clk_alpha_pll_slew_ops = {
+	.enable = clk_alpha_pll_slew_enable,
+	.disable = clk_alpha_pll_disable,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.round_rate = clk_alpha_pll_round_rate,
+	.set_rate = clk_alpha_pll_slew_set_rate,
+};
+EXPORT_SYMBOL(clk_alpha_pll_slew_ops);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 79aca8525262211ae5295245427d4540abf1e09a..1d19001605eb10fd8ae8041c56d951e928cbbe9f 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -204,6 +204,7 @@ extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
 #define clk_alpha_pll_postdiv_rivian_evo_ops clk_alpha_pll_postdiv_fabia_ops
 
 extern const struct clk_ops clk_alpha_pll_regera_ops;
+extern const struct clk_ops clk_alpha_pll_slew_ops;
 
 void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);

-- 
2.48.1


