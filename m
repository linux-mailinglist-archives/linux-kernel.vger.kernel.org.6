Return-Path: <linux-kernel+bounces-375254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E56649A93C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B2BB236DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A7F201107;
	Mon, 21 Oct 2024 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pxhMr+ny"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A89200B98;
	Mon, 21 Oct 2024 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551859; cv=none; b=CK5HJmvB3B72mS2o6iDzpgIDhuV7tdy9T5JhWVRpc7vonP4aoxRhzuK2Z62kfly/Y1y463/ymhCiCPeN892mtu4kFqBhp3XW21L1sYbIwLhU3Z0Y4VBARuG1b+9Pb/ubfB3xB3eORkv4QXFIlLYiuAybRX2jtMEz2Al60YD6UIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551859; c=relaxed/simple;
	bh=OJUkUEOqtwxentKd3FOmWyQQFSXl7YvNEcASWEnL8iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMRUcxXIaz4AD4fVX0tljVLxhrD31KVo6VyhsPlZGNSxEaUgjWG2ir2ckhynL/FPDRf1oMWBrvyxIA+NyDYYyaUAcoQG8ZRGEmHXy/GzMi0uuUt9e6Uzgv600N3T4hpySgGBiNRV5LGnuZWeIKz0WljD3rirBNjMLM80hCTkXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pxhMr+ny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LF7vIh009626;
	Mon, 21 Oct 2024 23:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OIhVE3J5amIUm/pzXGiG1WDFNG6MvNO/l7itl8BBxQw=; b=pxhMr+ny3Mg39YLD
	SOLgZOel9dw1ZUY0kgxgYOhu08xr8ynZMiebjZRRRVUWACv4uUsNSZys7zllzU7H
	BtYMXph8hd8EMM/HHflBG5tmNdnPsBNRjnbP/Tf8CMIqYRxrryRf6jcZYyJ7J2tT
	SYtXkPmGPLMhz6YpXRX6ROUKUUBcwcpYGPcgZQZuubtF0YFBtFVyxPGR9e8W30aJ
	Pg8iUlAtaQcZotrRtIVeJal6oj60lKV34TCTJghkxXC3Pe+AdtQ4eWKo6wY3mslE
	GIhUmvAuf0IEV8l83xpU/M6UKWSxqJKYN4/krKglD0NKJwkb4ixSlph4HKbPKoRj
	3o5k2w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkbt2hka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:04:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LN4CH5001501
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 23:04:12 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 16:04:11 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala --cc=linux-arm-msm
 @ vger . kernel . org" <quic_satyap@quicinc.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 2/7] clk: qcom: rpmh: Add support for SM8750 rpmh clocks
Date: Mon, 21 Oct 2024 16:03:54 -0700
Message-ID: <20241021230359.2632414-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021230359.2632414-1-quic_molvera@quicinc.com>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: etgNlWbMtzQio9jr2IMy0a4FdG7-Ihph
X-Proofpoint-GUID: etgNlWbMtzQio9jr2IMy0a4FdG7-Ihph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=904 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410210163

From: Taniya Das <quic_tdas@quicinc.com>

Add the RPMH clocks present in SM8750 SoC.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/clk/qcom/clk-rpmh.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 4acde937114a..245bdfe4827d 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -344,6 +344,7 @@ static const struct clk_ops clk_rpmh_bcm_ops = {
 DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 1);
 DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 2);
 DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 4);
+DEFINE_CLK_RPMH_ARC(xo_pad,  "xo.lvl", 0x3, 2);
 DEFINE_CLK_RPMH_ARC(qlink, "qphy.lvl", 0x1, 4);
 
 DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2, "lnbclka1", 2);
@@ -368,6 +369,10 @@ DEFINE_CLK_RPMH_VRM(rf_clk2, _d, "rfclkd2", 1);
 DEFINE_CLK_RPMH_VRM(rf_clk3, _d, "rfclkd3", 1);
 DEFINE_CLK_RPMH_VRM(rf_clk4, _d, "rfclkd4", 1);
 
+DEFINE_CLK_RPMH_VRM(rf_clk3, _a2, "rfclka3", 2);
+DEFINE_CLK_RPMH_VRM(rf_clk4, _a2, "rfclka4", 2);
+DEFINE_CLK_RPMH_VRM(rf_clk5, _a2, "rfclka5", 2);
+
 DEFINE_CLK_RPMH_VRM(clk1, _a1, "clka1", 1);
 DEFINE_CLK_RPMH_VRM(clk2, _a1, "clka2", 1);
 DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
@@ -795,6 +800,26 @@ static const struct clk_rpmh_desc clk_rpmh_x1e80100 = {
 	.num_clks = ARRAY_SIZE(x1e80100_rpmh_clocks),
 };
 
+static struct clk_hw *sm8750_rpmh_clocks[] = {
+	[RPMH_CXO_PAD_CLK]      = &clk_rpmh_xo_pad_div2.hw,
+	[RPMH_CXO_PAD_CLK_A]    = &clk_rpmh_xo_pad_div2_ao.hw,
+	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
+	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
+	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
+	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a.hw,
+	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
+	[RPMH_RF_CLK2]		= &clk_rpmh_rf_clk2_a.hw,
+	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_ao.hw,
+	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a2.hw,
+	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a2_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sm8750 = {
+	.clks = sm8750_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sm8750_rpmh_clocks),
+};
 static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 					 void *data)
 {
@@ -896,6 +921,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
 	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
 	{ .compatible = "qcom,sm8650-rpmh-clk", .data = &clk_rpmh_sm8650},
+	{ .compatible = "qcom,sm8750-rpmh-clk", .data = &clk_rpmh_sm8750},
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
 	{ .compatible = "qcom,x1e80100-rpmh-clk", .data = &clk_rpmh_x1e80100},
 	{ }
-- 
2.46.1


