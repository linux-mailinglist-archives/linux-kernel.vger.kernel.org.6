Return-Path: <linux-kernel+bounces-434396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D137E9E6639
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87F0169F46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E2201116;
	Fri,  6 Dec 2024 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i+6Jreua"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127371FECC6;
	Fri,  6 Dec 2024 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733459605; cv=none; b=JC6EECn2hNns84DOMNPunPieuo4QL948IMv1JsjN9KrAppzQ9FYkd1k937mdfYCu29B0rwXjChKNh6aVb40O2oM5eAFTobU2iJnJ/EQcJbZgwrXuUDQAnmNsVZv0MycW+RTc+ClcLG3j/oVV5CBMLe+DeAV3a+Tj5nQydP9llrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733459605; c=relaxed/simple;
	bh=9uIyBR/J+bTxjH2oogmzxhSc6stgbyO5G7N7RnPe4fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I/P06oXJl2vCKBPKnA0TdLQzVTZhlyprRdSQJ+VgubBD6g4VoTxXqHGTC6I7qigzHO1z20dG/tfWP+P+BG3NGkkBfyqIaoORTLMty/b+DJeg6mPo7GEkMYtyp5FxbYf6beFQY61BVJUaYkpb5ogrql2JL239S8NZVc3t3dyvcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i+6Jreua; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaGAE003720;
	Fri, 6 Dec 2024 04:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J7r05mCc5M58XVDMiEgxFBN7KVVAsTQkKHGv3BhtOQg=; b=i+6JreuaQXbf2EEC
	K6Od65PixSeAj1U6ayVRlu2gS2BUrgezjTDBLU/wEsGMdZdsxxLQ9CGgjT79RRgS
	jk01N31RARV64OKtm1r2Hpz4bv6OD1EvurMHtvBubavT/c6D15yoIMAdRc6DacbL
	x+vWqEax7GyFPB4ubAeQZ+H2NRt/ljoAlqVxebKj8WjmxLjhaEn1dAcyU7shmUPF
	zWLYmatP2WO2mtMsp9jdWxL0+vD8Xr5Y2cBs/DDzkUW8JjkB/ofkA8jSNkc9G/Eu
	h+gTNk0gPdOg9UUq11NzbwG5Oi9+MOnpXbzs1fzSnaYpM5QXG1+GhQecrihvn13S
	RNy5sA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0kjkkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 04:32:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B64WcHm006080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 04:32:38 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 20:32:37 -0800
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
Date: Thu, 5 Dec 2024 20:31:55 -0800
Subject: [PATCH 24/45] drm/msm/dp: abstract out the dp_display stream
 helpers to accept a panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-dp_mst-v1-24-f8618d42a99a@quicinc.com>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
In-Reply-To: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        "Chandan
 Uddaraju" <chandanu@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        Tanmay Shah <tanmay@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jessica Zhang
	<quic_jesszhan@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733459543; l=9227;
 i=quic_abhinavk@quicinc.com; s=20240509; h=from:subject:message-id;
 bh=9uIyBR/J+bTxjH2oogmzxhSc6stgbyO5G7N7RnPe4fM=;
 b=Ip8cI9oPn6Xg4X/eT5RGhDZoVdQG9Wr1sYLwrABLv022MCpCpaByx9ZlxIj8vIEIo5RlPXa9t
 2PpP3EMHrUgCI84539UIKftwLiKSLQf5xAErOE5cx+Cj/gRXhoEONZT
X-Developer-Key: i=quic_abhinavk@quicinc.com; a=ed25519;
 pk=SD3D8dOKDDh6BoX3jEYjsHrTFwuIK8+o0cLPgQok9ys=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UnuTpm1r8GBYB-sYq8O2sUnVJIDeXoWs
X-Proofpoint-GUID: UnuTpm1r8GBYB-sYq8O2sUnVJIDeXoWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060030

Currently the dp_display bridge helpers, in particular the
dp_display_enable()/dp_display_disable() use the cached panel.
To be able to re-use these helpers for MST use-case abstract the
helpers to use the panel which is passed in to them.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 96 ++++++++++++++++++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_display.h |  8 ++++
 2 files changed, 75 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1dfc82211c50bb4ed239f9730b91c33c4897c78f..e169cd22db960c0c30707ddbe6a79999dc2a273d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -868,7 +868,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 	return rc;
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp)
+static int msm_dp_display_enable(struct msm_dp_display_private *dp,
+				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -879,7 +880,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel, dp->max_stream);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, dp->max_stream);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -925,20 +926,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 	msm_dp_display->audio_enabled = false;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static int msm_dp_display_disable(struct msm_dp_display_private *dp,
+				  struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	if (!msm_dp_display->power_on)
 		return 0;
 
-	msm_dp_ctrl_clear_vsc_sdp_pkt(dp->ctrl, dp->panel);
+	msm_dp_ctrl_clear_vsc_sdp_pkt(dp->ctrl, msm_dp_panel);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_ctrl_psm_config(dp->ctrl);
 
-	msm_dp_ctrl_stream_clk_off(dp->ctrl, dp->panel);
+	msm_dp_ctrl_stream_clk_off(dp->ctrl, msm_dp_panel);
 
 	msm_dp_ctrl_off_link(dp->ctrl);
 
@@ -1607,7 +1609,7 @@ void msm_dp_display_atomic_prepare(struct msm_dp *dp)
 	mutex_unlock(&msm_dp_display->event_mutex);
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *dp)
+void msm_dp_display_enable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 
@@ -1620,16 +1622,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp)
 
 	mutex_lock(&msm_dp_display->event_mutex);
 
-	msm_dp_display_set_stream_info(dp, msm_dp_display->panel, 0, 0, 0, 0, 0);
-
 	if (dp->prepared) {
-		rc = msm_dp_display_enable(msm_dp_display);
+		rc = msm_dp_display_enable(msm_dp_display, msm_dp_panel);
 		if (rc)
 			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 		rc = msm_dp_display_post_enable(dp);
 		if (rc) {
 			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-			msm_dp_display_disable(msm_dp_display);
+			msm_dp_display_disable(msm_dp_display, msm_dp_panel);
 		}
 	}
 
@@ -1640,14 +1640,25 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp)
 	mutex_unlock(&msm_dp_display->event_mutex);
 }
 
-void msm_dp_display_atomic_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp)
+{
+	struct msm_dp_display_private *msm_dp_display;
+
+	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_set_stream_info(msm_dp, msm_dp_display->panel, 0, 0, 0, 0, 0);
+
+	msm_dp_display_enable_helper(msm_dp, msm_dp_display->panel);
+}
+
+void msm_dp_display_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
 	if (msm_dp_display->max_stream > DEFAULT_STREAM_COUNT)
-		msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
+		msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_panel);
 	else
 		msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
 
@@ -1658,21 +1669,30 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	}
 }
 
-static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+void msm_dp_display_atomic_disable(struct msm_dp *msm_dp)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *msm_dp_display;
 
-	if (!msm_dp_display->prepared) {
-		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
+	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_disable_helper(msm_dp, msm_dp_display->panel);
+}
+
+static void msm_dp_display_unprepare(struct msm_dp_display_private *msm_dp_display_priv)
+{
+	struct msm_dp *msm_dp = &msm_dp_display_priv->msm_dp_display;
+
+	if (!msm_dp->prepared) {
+		drm_dbg_dp(msm_dp->drm_dev, "Link already setup, return\n");
 		return;
 	}
 
-	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+	pm_runtime_put_sync(&msm_dp->pdev->dev);
 
-	msm_dp_display->prepared = false;
+	msm_dp->prepared = false;
 }
 
-void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	u32 state;
 	struct msm_dp_display_private *msm_dp_display;
@@ -1691,7 +1711,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_disable(msm_dp_display, msm_dp_panel);
 
 	state =  msm_dp_display->hpd_state;
 	if (state == ST_DISCONNECT_PENDING) {
@@ -1699,25 +1719,32 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 		msm_dp_display->hpd_state = ST_DISCONNECTED;
 	}
 
-	msm_dp_display_unprepare(msm_dp_display);
-
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
 
 	mutex_unlock(&msm_dp_display->event_mutex);
 }
 
-void msm_dp_display_mode_set(struct msm_dp *dp,
-			     const struct drm_display_mode *mode,
-			     const struct drm_display_mode *adjusted_mode)
+void msm_dp_display_atomic_post_disable(struct msm_dp *msm_dp)
 {
 	struct msm_dp_display_private *msm_dp_display;
-	struct msm_dp_panel *msm_dp_panel;
 
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
-	msm_dp_panel = msm_dp_display->panel;
+	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_atomic_post_disable_helper(msm_dp, msm_dp_display->panel);
+
+	msm_dp_display_unprepare(msm_dp_display);
+}
+
+void msm_dp_display_mode_set_helper(struct msm_dp *msm_dp,
+				    const struct drm_display_mode *mode,
+				    const struct drm_display_mode *adjusted_mode,
+				    struct msm_dp_panel *msm_dp_panel)
+{
+	struct msm_dp_display_private *msm_dp_display;
 
+	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
+	msm_dp_display_set_mode(msm_dp, adjusted_mode, msm_dp_panel);
 
 	/* populate wide_bus_support to different layers */
 	msm_dp_display->ctrl->wide_bus_en =
@@ -1726,6 +1753,17 @@ void msm_dp_display_mode_set(struct msm_dp *dp,
 		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
 }
 
+void msm_dp_display_mode_set(struct msm_dp *msm_dp,
+			     const struct drm_display_mode *mode,
+			     const struct drm_display_mode *adjusted_mode)
+{
+	struct msm_dp_display_private *msm_dp_display;
+
+	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_mode_set_helper(msm_dp, mode, adjusted_mode, msm_dp_display->panel);
+}
+
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 258c240de580b634c05cf5895a8e52160449eba1..2b23f2bf7535d3fd513d40a8411a1903fcd560b0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -56,5 +56,13 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 int msm_dp_display_set_stream_info(struct msm_dp *dp,
 				   struct msm_dp_panel *panel, u32 strm_id,
 				   u32 start_slot, u32 num_slots, u32 pbn, int vcpi);
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp, struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp, struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_mode_set_helper(struct msm_dp *msm_dp,
+				    const struct drm_display_mode *mode,
+				    const struct drm_display_mode *adjusted_mode,
+				    struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp,
+					       struct msm_dp_panel *msm_dp_panel);
 
 #endif /* _DP_DISPLAY_H_ */

-- 
2.34.1


