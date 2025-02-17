Return-Path: <linux-kernel+bounces-515842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC11DA369C6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF438166F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8385931;
	Sat, 15 Feb 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QVkcleuE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098402943F;
	Sat, 15 Feb 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578542; cv=none; b=bxDJPNDM3evAXw3macBwJovqByE9nbzPvN+Gi8QM6gce/Bi5zRzzo+nZl1IeQ7O6MpercGES71DdVsBNmHpQiFeW01dSa1BFXCFKPqihVpTHLxfWRsgr/z0VQRUxdfn9OSvYBH4aFxAg3CQsdPXtTxb1r0XCv/oeclno2Ct/hbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578542; c=relaxed/simple;
	bh=LypIT3Vsvo+COpx9vViitKdfHH7SaO6HMvWRQmInK90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L0XBlQ6GL/fHV5rjNIfyIVdwgBGCUyNHjTBF4Tl7aSSKO9pD26ql46RcG5F3slIG4G//0lII5gqONAV4FzUnCvNBq8JI8/uZUpwbrEQFcvmViZqcAnvFzmxH0KD7cNnfUkEam++jsbqEy/dJX/xy2/V10vTkAoRasqP/cP7HDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QVkcleuE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51F082BM000738;
	Sat, 15 Feb 2025 00:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	myD/s69pQEXYf8tAFqqd+x3CdRklck+3AlJhWp6po88=; b=QVkcleuEZ+wV0DvI
	lF1QWYDQFId5P2Kc3XSsXnb7kU+cDZxXvpYdun3pRUXu5C7K9GtVzMnni7WGyJr5
	vkXpCdVKCOkqSrq1WOGuLOhzbxJLJXTAK5OyaDOvPh03kY2566H8Iou1K/8U/1Ai
	cvFe2VP2IOUl+9KSZLx4vzwPTqUyYmODDJz8oh/kAPEe1VUqnGkUCjbOrBInba+T
	+/gqyXe7mvHe/vf3SOQWJd+5QZ6H1u56un/mIhl5dG2kKk0CVjD1xEyFpMjlUAEj
	AQxDTIU9Jc9qnSryd0b51M6A7JFpghsKPeonkLX1dVgcZ53G5UP7xOii3Egeik7V
	MztVXA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44seq051kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2025 00:15:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51F0FQAe012705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2025 00:15:26 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Feb 2025 16:15:25 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Fri, 14 Feb 2025 16:14:28 -0800
Subject: [PATCH v6 05/14] drm/msm/dpu: Require modeset if clone mode status
 changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250214-concurrent-wb-v6-5-a44c293cf422@quicinc.com>
References: <20250214-concurrent-wb-v6-0-a44c293cf422@quicinc.com>
In-Reply-To: <20250214-concurrent-wb-v6-0-a44c293cf422@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <quic_abhinavk@quicinc.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simona Vetter <simona@ffwll.ch>,
        Simona Vetter <simona.vetter@ffwll.ch>
CC: <quic_ebharadw@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        "Jessica
 Zhang" <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-f0f05
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739578524; l=3521;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=LypIT3Vsvo+COpx9vViitKdfHH7SaO6HMvWRQmInK90=;
 b=1Un89lFl88+zWMKA9SRjPt7j+PyUD5pXcYNg5kU/kwKUP1L4PmEYdt7JZ4kpuQtpF/71ax4w4
 w020U36NAxxDGZGI3JwrhAU1/Iw6QJNdnYCt+oto9H7Vd6fw6ojCHyL
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VMiAb72SR3DvelqGqanbUMWZQA7l9JGZ
X-Proofpoint-ORIG-GUID: VMiAb72SR3DvelqGqanbUMWZQA7l9JGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_10,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502150000

If the clone mode enabled status is changing, a modeset needs to happen
so that the resources can be reassigned

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 17 ++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h |  3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  5 +++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 7c0ab1cee057..5c9c317c9347 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1351,19 +1351,26 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
  *
  * Check if the changes in the object properties demand full mode set.
  */
-int dpu_crtc_check_mode_changed(struct drm_crtc_state *crtc_state)
+int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
+				struct drm_crtc_state *new_crtc_state)
 {
 	struct drm_encoder *drm_enc;
-	struct drm_crtc *crtc = crtc_state->crtc;
+	struct drm_crtc *crtc = new_crtc_state->crtc;
+	bool clone_mode_enabled = drm_crtc_in_clone_mode(old_crtc_state);
+	bool clone_mode_requested = drm_crtc_in_clone_mode(new_crtc_state);
 
 	DRM_DEBUG_ATOMIC("%d\n", crtc->base.id);
 
 	/* there might be cases where encoder needs a modeset too */
-	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
-		if (dpu_encoder_needs_modeset(drm_enc, crtc_state->state))
-			crtc_state->mode_changed = true;
+	drm_for_each_encoder_mask(drm_enc, crtc->dev, new_crtc_state->encoder_mask) {
+		if (dpu_encoder_needs_modeset(drm_enc, new_crtc_state->state))
+			new_crtc_state->mode_changed = true;
 	}
 
+	if ((clone_mode_requested && !clone_mode_enabled) ||
+	    (!clone_mode_requested && clone_mode_enabled))
+		new_crtc_state->mode_changed = true;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index 51a3b5fc879a..94392b9b9245 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -239,7 +239,8 @@ static inline int dpu_crtc_frame_pending(struct drm_crtc *crtc)
 	return crtc ? atomic_read(&to_dpu_crtc(crtc)->frame_pending) : -EINVAL;
 }
 
-int dpu_crtc_check_mode_changed(struct drm_crtc_state *crtc_state);
+int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
+				struct drm_crtc_state *new_crtc_state);
 
 int dpu_crtc_vblank(struct drm_crtc *crtc, bool en);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index c6b3b2e147b4..423af6f8251c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -449,11 +449,12 @@ static void dpu_kms_disable_commit(struct msm_kms *kms)
 static int dpu_kms_check_mode_changed(struct msm_kms *kms, struct drm_atomic_state *state)
 {
 	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc_state *old_crtc_state;
 	struct drm_crtc *crtc;
 	int i;
 
-	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
-		dpu_crtc_check_mode_changed(new_crtc_state);
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i)
+		dpu_crtc_check_mode_changed(old_crtc_state, new_crtc_state);
 
 	return 0;
 }

-- 
2.48.1


