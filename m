Return-Path: <linux-kernel+bounces-337754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30C984E86
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A094282AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE325187FE3;
	Tue, 24 Sep 2024 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PCk0nrpK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E02183CCD;
	Tue, 24 Sep 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218814; cv=none; b=Frxv+jXQ3cvSmF4eFrnOgi+X+KwTv96LH07JI1gthJbJW6DbAw5t8OrdWS/35h65/wttU9x8dzdAzmVajq5I1Y12A28Xnthh5mZ4+I+y+v5aks3CNc81m2bmdmcVpDzT4RPWFSpIxPNsglENHDTZ5QBu/dAnSh3Co1/NaRu5bCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218814; c=relaxed/simple;
	bh=UC6dBLRduZ08SWt6OTH7JoljHIIUyp9PqbeWKl1rKEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q66mJvtW7acd6eIIaJRuTb85L2g5DcLUOBLr9ELoxU52hM8qk+LbD5lHtlXw8MIRqOqpGGe7rmIh/2OI63Vn4JWswMpxhJyPScIWRYyRXcsM8ImaxHonnTBYSioHwcjXHQxLwKDVMIFNmsvXKI0EsNPyJUpJBwitsE+3oD9Jcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PCk0nrpK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OIKdx8017495;
	Tue, 24 Sep 2024 23:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v2p2Da5YSVeHzBr+nYJB8FOWq+tyiw4fgRfu2tQT7Zg=; b=PCk0nrpKy1Ph5VUx
	37ktuOliViEgXMuSrB0sTa08t+ea5Z6wOfcBXAc91OOyqaNHHPmDJPTu78un75NQ
	6lVxFh1BzWv1Z/pXRCdvMKydOjoKG9LSwecig0iGAgu6t2JOXenFFwwkpJN/SITN
	aQptdoLw5FkSamUR63E7RifKOeU4p4g9HA5DINzr3yVimA/+0w9iFN8MxqIK/cJg
	rWKWKoiQd1jCU4pzvuMHQMEv3MF0js6ssw8HtaFiuyzRReCvFDdU3985iE6RSjS/
	GEB12ZbWYuYRERu6kofGhh34SaCcG2Qu0ZJcOXDQCdbC9ODbLpP1RU3a6SGiTfHD
	xEqA4g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuet6gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 23:00:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OMxxwV027338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 22:59:59 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 15:59:59 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Tue, 24 Sep 2024 15:59:37 -0700
Subject: [PATCH v2 21/22] drm/msm/dpu: Reorder encoder kickoff for CWB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240924-concurrent-wb-v2-21-7849f900e863@quicinc.com>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
In-Reply-To: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <quic_abhinavk@quicinc.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
CC: <quic_ebharadw@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        "Jessica
 Zhang" <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727218793; l=4266;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=UC6dBLRduZ08SWt6OTH7JoljHIIUyp9PqbeWKl1rKEE=;
 b=4iNwURWcFYgjbFKemgaiKBcqhTwCCsqmpfJY29E07Deic4Mz6A0xCbSKd7tWHAjTYOYx+QaOB
 bJiVzBC79oUDg2qXurTd1p58YIOLuHb+jZQirB+aEb6S6QOAavuxB4V
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BTSLJmly38oHPCcUOV1jgLlDFS_BMd0X
X-Proofpoint-ORIG-GUID: BTSLJmly38oHPCcUOV1jgLlDFS_BMd0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240160

Add a helper that will handle the correct order of the encoder kickoffs
for concurrent writeback.

For concurrent writeback, the realtime encoder must always kickoff last
as it will call the trigger flush and start.

This avoids the following scenario where the writeback encoder
increments the pending kickoff count after the WB_DONE interrupt is
fired:

If the realtime encoder is kicked off first, the encoder kickoff will
flush/start the encoder and increment the pending kickoff count. The
WB_DONE interrupt then fires (before the writeback encoder is kicked
off). When the writeback encoder enters its kickoff, it will skip the
flush/start (due to CWB being enabled) and hit a frame done timeout
as the frame was kicked off (and the WB_DONE interrupt fired) without
the pending kickoff count being incremented.

In addition, the writeback timer should only start after the realtime
encoder is kicked off to ensure that we don't get timeouts when the
system has a heavy load (ex. when debug logs are enabled)

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 74 ++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index e8c80ea12866..4365e9cf609d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -928,6 +928,45 @@ static int _dpu_crtc_wait_for_frame_done(struct drm_crtc *crtc)
 	return rc;
 }
 
+static int dpu_crtc_kickoff_clone_mode(struct drm_crtc *crtc)
+{
+	struct drm_encoder *encoder;
+	struct drm_encoder *rt_encoder = NULL, *wb_encoder;
+	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
+
+	/* Find encoder for real time display */
+	drm_for_each_encoder_mask(encoder, crtc->dev,
+				  crtc->state->encoder_mask) {
+		if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
+			wb_encoder = encoder;
+		else
+			rt_encoder = encoder;
+	}
+
+	if (!rt_encoder || !wb_encoder) {
+		DRM_DEBUG_ATOMIC("real time or wb encoder not found\n");
+		return -EINVAL;
+	}
+
+	dpu_encoder_prepare_for_kickoff(wb_encoder);
+	dpu_encoder_prepare_for_kickoff(rt_encoder);
+
+	dpu_vbif_clear_errors(dpu_kms);
+
+	/*
+	 * Kickoff real time encoder last as it's the encoder that
+	 * will do the flush
+	 */
+	dpu_encoder_kickoff(wb_encoder);
+	dpu_encoder_kickoff(rt_encoder);
+
+	/* Don't start frame done timers until the kickoffs have finished */
+	dpu_encoder_start_frame_done_timer(wb_encoder);
+	dpu_encoder_start_frame_done_timer(rt_encoder);
+
+	return 0;
+}
+
 void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 {
 	struct drm_encoder *encoder;
@@ -952,13 +991,27 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 			goto end;
 		}
 	}
-	/*
-	 * Encoder will flush/start now, unless it has a tx pending. If so, it
-	 * may delay and flush at an irq event (e.g. ppdone)
-	 */
-	drm_for_each_encoder_mask(encoder, crtc->dev,
-				  crtc->state->encoder_mask)
-		dpu_encoder_prepare_for_kickoff(encoder);
+
+	if (drm_crtc_in_clone_mode(crtc->state)) {
+		if (dpu_crtc_kickoff_clone_mode(crtc))
+			goto end;
+	} else {
+		/*
+		 * Encoder will flush/start now, unless it has a tx pending.
+		 * If so, it may delay and flush at an irq event (e.g. ppdone)
+		 */
+		drm_for_each_encoder_mask(encoder, crtc->dev,
+				crtc->state->encoder_mask)
+			dpu_encoder_prepare_for_kickoff(encoder);
+
+		dpu_vbif_clear_errors(dpu_kms);
+
+		drm_for_each_encoder_mask(encoder, crtc->dev,
+				crtc->state->encoder_mask) {
+			dpu_encoder_kickoff(encoder);
+			dpu_encoder_start_frame_done_timer(encoder);
+		}
+	}
 
 	if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
 		/* acquire bandwidth and other resources */
@@ -968,13 +1021,6 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 
 	dpu_crtc->play_count++;
 
-	dpu_vbif_clear_errors(dpu_kms);
-
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
-		dpu_encoder_kickoff(encoder);
-		dpu_encoder_start_frame_done_timer(encoder);
-	}
-
 	reinit_completion(&dpu_crtc->frame_done_comp);
 
 end:

-- 
2.34.1


