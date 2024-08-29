Return-Path: <linux-kernel+bounces-307673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8976C965141
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E6B2861B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F671BE852;
	Thu, 29 Aug 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U0FGEC+B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D731BB6A4;
	Thu, 29 Aug 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964562; cv=none; b=YoTmc0pUl5sZJ2vLJmMU17Ui7TEwzFtSm4YuCRKz+U8yv8nF5L5hypC8ZLQSKZd4BIhJb9ePk7xdRDhkR932FmxaQchVLD1EcApqQgf8V7Wh8VvjSqDyHU6BaedDTOHq4B5oNmNmo/H3xt6ebNM0BCv//C9RPhVvgrh1kn8+93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964562; c=relaxed/simple;
	bh=kc9ilhLKig4c8W84vSwwdKMW7sbavFZ1geGDgPxzzLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tCsvoutSIvD27xjm/a9m4ZM23oduNcGvGrdAufSKDdSJGcW7qZmla6hRHsxFXgocS2HzfTPjFQdJ0MWv++FT4ikgJle/QH30ZdDdt3YAXsyMWCay8NBr9ANyvqc9rl699fCbCtgTk2WmSf9BRLXC21djoAcL2e/d3+u9XAws/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U0FGEC+B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGd0Eo030353;
	Thu, 29 Aug 2024 20:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fiRTKU3HBUesysXCPLeksdxnC+pkFe03YYBbXF/AbDE=; b=U0FGEC+BRpJ6Bbvh
	xOgZpKuDUQC8bKUeAljDW3MS/1dcTIeFdTliA9MWwGBgKhhP+j14901nu9qRWYfq
	rLp0PQHphvxTO+fRG/jJH+qIIQD700fshWoZh07uFdnTVjwX0ztI8Tz8UorUlZEd
	IafJ/fHXUHk/Y2090p/uiozIWX43MAzv5Q2/mwqQmTIGWdP4PRreEiD3VNVE7ixL
	qxVhXxSyKgvMJu3eKLIa9lgUeuipEw/At+5Yanp2r0FVG4A3YmY5PqO+bb6k/UMH
	7X0jlY5x+743XpONmlaenTNtpEn+LWJGrG87wIvjBFaiJMB+p8I6zhS2gOqWh8Wu
	OWPwrg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puuehx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47TKn42H003484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:04 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 13:49:04 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Thu, 29 Aug 2024 13:48:41 -0700
Subject: [PATCH 20/21] drm/msm/dpu: Reorder encoder kickoff for CWB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240829-concurrent-wb-v1-20-502b16ae2ebb@quicinc.com>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
In-Reply-To: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
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
        "Jessica
 Zhang" <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724964539; l=4105;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=kc9ilhLKig4c8W84vSwwdKMW7sbavFZ1geGDgPxzzLc=;
 b=zdk/fKu4UB+fzzNT6YmVkSQZIBSX+6Pv3hd9EM3NTJfsj2ovtzdzAX98vriC56kpJJRAt/aFw
 Z7BktN1SOt2D6YiI+7z9AAhpES1VDRrNXH/dtZOzkbv2Q1+Waz8VfN1
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2xbuLdlb6U_aD80XW9SR909H_eaI6-u0
X-Proofpoint-ORIG-GUID: 2xbuLdlb6U_aD80XW9SR909H_eaI6-u0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290147

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
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 67 ++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index daf5f751f584..d2f91e89eba7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -928,6 +928,42 @@ static int _dpu_crtc_wait_for_frame_done(struct drm_crtc *crtc)
 	return rc;
 }
 
+static int dpu_crtc_kickoff_clone_mode(struct drm_crtc *crtc)
+{
+	struct drm_encoder *encoder;
+	struct drm_encoder *rt_encoder = NULL, *wb_encoder;
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
@@ -952,13 +988,25 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
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
+		drm_for_each_encoder_mask(encoder, crtc->dev,
+				crtc->state->encoder_mask) {
+			dpu_encoder_kickoff(encoder);
+			dpu_encoder_start_frame_done_timer(encoder);
+		}
+	}
 
 	if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
 		/* acquire bandwidth and other resources */
@@ -970,11 +1018,6 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 
 	dpu_vbif_clear_errors(dpu_kms);
 
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
-		dpu_encoder_kickoff(encoder);
-		dpu_encoder_start_frame_done_timer(encoder);
-	}
-
 	reinit_completion(&dpu_crtc->frame_done_comp);
 
 end:

-- 
2.34.1


