Return-Path: <linux-kernel+bounces-350193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B669A990151
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D608D1C23E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161815A85A;
	Fri,  4 Oct 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dHd+eTMV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA6156220;
	Fri,  4 Oct 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037877; cv=none; b=C45zEx1MASNqVxxuFxcyG+OLv2DpbNNHdYQhrRWfCTrD+nLPAiCYhS7fPZWScDCTMgNtwSW6t9AmCFZZBvFHFISKYlcwf92Ogm7y7XC4D3kIuXWhed5lRqwktbmSH5DWGgILOUF82gh8hPnXJ3plbka0gcYEo075eYP70PpiO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037877; c=relaxed/simple;
	bh=QwWbFbbdvqKYlpegD4ObfTwOC61utTi1EH50AXl5KR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OfeqsFdEP9P7puQGaPu8aZjsrP/FMpm8+TlBhxayXZ959iAJ7NCcpB6KA70C62nLaYbPYa5V/b/+X9zTI/lTSkr+KAjZKHqWfW+KgXc3utBRSWaHBF5fRxfwlXCmerMJuH9J+tsQYEFhTqtGfoD9ApAJX2nod6WnhT2WByhMSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dHd+eTMV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4949tiFJ026659;
	Fri, 4 Oct 2024 10:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=wofS2V5cOCn0YNSaz5NkaQtDc4eF8kvAYiZTvMfZpt4=; b=dH
	d+eTMVD9NIYi23AwhIXMPeBXmSdNY1u3keWQhbuX1TrDj+wOl+I/HBIHcVGETAkJ
	2ZgZzIw5mIpFzwTp/ZtlWDBuxhmbOr0kgYuwYMwwaOZryi5A779wdE3dbCcKa4qn
	7FJ8uB9Br/McXsE2my2gtVY4Gvch0Ehfb0qOstVkar8tghFVNzloBsTBcwAU5fMg
	VIAHUluLg6ZUpd2SyJAvkBuVfp3R7OKfNotVg7ufPDSB1WVRVYhZlUcehwidYRrP
	bqWsGNK3HXfTxkq/4gg3rLtC3r9ipiohMDd7UWzK9fGWYpJy5bNC2oq4I1nAufXB
	V/Y7fioRlajLQwa6vTVg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42207v1saa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:30:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 494AUoPo005782;
	Fri, 4 Oct 2024 10:30:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 41xavmrk0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 04 Oct 2024 10:30:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494AUbuN005260;
	Fri, 4 Oct 2024 10:30:49 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-mukhopad-hyd.qualcomm.com [10.147.244.250])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 494AUnWB005742;
	Fri, 04 Oct 2024 10:30:49 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3978529)
	id C5EBF5000B1; Fri,  4 Oct 2024 16:00:48 +0530 (+0530)
From: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
To: vkoul@kernel.org, kishon@kernel.org, konradybcio@kernel.org,
        andersson@kernel.org, simona@ffwll.ch, dmitry.baryshkov@linaro.org,
        abel.vesa@linaro.org, robdclark@gmail.com, quic_abhinavk@quicinc.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_khsieh@quicinc.com, konrad.dybcio@linaro.org,
        quic_parellan@quicinc.com, quic_bjorande@quicinc.com
Cc: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        quic_riteshk@quicinc.com, quic_vproddut@quicinc.com
Subject: [PATCH v4 3/5] phy: qcom: edp: Add support for eDP PHY on SA8775P
Date: Fri,  4 Oct 2024 16:00:44 +0530
Message-Id: <20241004103046.22209-4-quic_mukhopad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241004103046.22209-1-quic_mukhopad@quicinc.com>
References: <20241004103046.22209-1-quic_mukhopad@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Frg0cQoRh5vVCzpewOjk9Yb5YKLgAv50
X-Proofpoint-ORIG-GUID: Frg0cQoRh5vVCzpewOjk9Yb5YKLgAv50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040076
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for eDP PHY v5 found on the Qualcomm SA8775P platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
---
v2: Fixed review comments from Dmitry
	- Reused edp_swing_hbr_rbr and edp_swing_hbr2_hbr3 for v5.

v3: No change

v4: No change

---
 drivers/phy/qualcomm/phy-qcom-edp.c | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 2ecff164ec44..f1b51018683d 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -183,6 +183,31 @@ static const u8 edp_phy_aux_cfg_v4[10] = {
 	0x00, 0x13, 0x24, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03
 };
 
+static const u8 edp_pre_emp_hbr_rbr_v5[4][4] = {
+	{ 0x05, 0x11, 0x17, 0x1d },
+	{ 0x05, 0x11, 0x18, 0xff },
+	{ 0x06, 0x11, 0xff, 0xff },
+	{ 0x00, 0xff, 0xff, 0xff }
+};
+
+static const u8 edp_pre_emp_hbr2_hbr3_v5[4][4] = {
+	{ 0x0c, 0x15, 0x19, 0x1e },
+	{ 0x0b, 0x15, 0x19, 0xff },
+	{ 0x0e, 0x14, 0xff, 0xff },
+	{ 0x0d, 0xff, 0xff, 0xff }
+};
+
+static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg_v5 = {
+	.swing_hbr_rbr = &edp_swing_hbr_rbr,
+	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr_v5,
+	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3_v5,
+};
+
+static const u8 edp_phy_aux_cfg_v5[10] = {
+	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03
+};
+
 static int qcom_edp_phy_init(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
@@ -507,6 +532,13 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
 	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
 };
 
+static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
+	.is_edp = false,
+	.aux_cfg = edp_phy_aux_cfg_v5,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.ver_ops = &qcom_edp_phy_ops_v4,
+};
+
 static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v4,
 	.ver_ops = &qcom_edp_phy_ops_v4,
@@ -1101,6 +1133,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_edp_phy_match_table[] = {
+	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
 	{ .compatible = "qcom,sc7280-edp-phy", .data = &sc7280_dp_phy_cfg, },
 	{ .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
 	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
-- 
2.17.1


