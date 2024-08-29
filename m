Return-Path: <linux-kernel+bounces-307664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C6965132
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BECB22503
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15131BC9E7;
	Thu, 29 Aug 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="leWIs5qV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2718C329;
	Thu, 29 Aug 2024 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964558; cv=none; b=DciFZkYl5u6TjmrYQd0n6Lc1M80hBT/lfoNnKbUJYEI0JOCfaipvxEFycZh3r8yrl9ASFvSMETEbu94qZefmNSn/lbUSf9WK0ap/TxBCT17Dd+U04r/h14Wc8KigNtKI1U7XW7MnDPBodNHWrKek3gOMPrJmucWxn/qoaAnCSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964558; c=relaxed/simple;
	bh=cfL8Euw5CQ5ocfSsUbpcXQrDGMxfXGdNhk8hzSy7o00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Hv3lMyz48qekM1U4ko+4pXtxR+IUwY4RXPs3rjtkERXy4jZ/lceSoN+zA40F0CATIZ+r+CHO4RZS/i5Q7zWRd4x5MjJRCzDz1OU7BlvJ5fDVvAN/aLfnJYRW5tX1+jHsafax7y3UxYauZQHx0CPw09viWeRVyyK5iR4OVIG1w/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=leWIs5qV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIFXkH013558;
	Thu, 29 Aug 2024 20:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLRCZ6v/RUbsyfmenr87SnfueJvcAidRqgQTZ1+GbrU=; b=leWIs5qV358nyN76
	gOESLjHPzcDD8GaiZswKHwGFZsKuDDRceJhk3aAeB/qryBOavy47TZ3U58z5Gtm2
	dhzcDEYy2DbLNUcDrjmckqMyCrbuwxckmTB2kRyIJZyFHElbNX43ByaIXz0MBmHU
	s/LjYaQOdb6PWYDqWggpMTAKmNkRG4H+ELfQN+rDZQU3yHs/V0Y5S6BCzDd0VLk/
	gSJIw3UD6wCXUOEH4n6lodCf/dwOQMuPKde2QMAHXRX1Ahw6eAC5JswDJ8+WpCoB
	lxZivqLCdLyGTa0+vpgRi+ctqWPEhaMEDFsuHGZQPc6OImFQpFPOUds7XyXSw0iR
	ksU2Vw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419px5pgwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47TKn4ma015152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:04 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 13:49:03 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Thu, 29 Aug 2024 13:48:39 -0700
Subject: [PATCH 18/21] drm/msm/dpu: Start frame done timer after encoder
 kickoff
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240829-concurrent-wb-v1-18-502b16ae2ebb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724964539; l=3077;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=cfL8Euw5CQ5ocfSsUbpcXQrDGMxfXGdNhk8hzSy7o00=;
 b=4bdfesOXhC54fzDlSTWkE3HRCOC67wQvuP2cAVOx/OxDRBXsMsJnw94e0/Ymk7rCc3uAvDzLj
 ZHKNckfWzoDAR/taSGbb+KwfkKUTEOD4e2VK/Absn89z6GOnKYKKApr
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QIvjX0DQKzi105XaD20MBItXilBJOmOl
X-Proofpoint-GUID: QIvjX0DQKzi105XaD20MBItXilBJOmOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408290147

Create a separate API for starting the encoder frame done timer and call
it after the encoder kickoff is finished

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 21 ++++++++++++++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  1 +
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index c8ef59af444c..daf5f751f584 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -970,8 +970,10 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 
 	dpu_vbif_clear_errors(dpu_kms);
 
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
+	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
 		dpu_encoder_kickoff(encoder);
+		dpu_encoder_start_frame_done_timer(encoder);
+	}
 
 	reinit_completion(&dpu_crtc->frame_done_comp);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index bde385318018..9d495a186eb8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1945,18 +1945,12 @@ bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc)
 	return true;
 }
 
-void dpu_encoder_kickoff(struct drm_encoder *drm_enc)
+void dpu_encoder_start_frame_done_timer(struct drm_encoder *drm_enc)
 {
 	struct dpu_encoder_virt *dpu_enc;
-	struct dpu_encoder_phys *phys;
 	unsigned long timeout_ms;
-	unsigned int i;
 
-	DPU_ATRACE_BEGIN("encoder_kickoff");
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
-
-	trace_dpu_enc_kickoff(DRMID(drm_enc));
-
 	timeout_ms = DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES * 1000 /
 			drm_mode_vrefresh(&drm_enc->crtc->state->adjusted_mode);
 
@@ -1964,6 +1958,19 @@ void dpu_encoder_kickoff(struct drm_encoder *drm_enc)
 	mod_timer(&dpu_enc->frame_done_timer,
 			jiffies + msecs_to_jiffies(timeout_ms));
 
+}
+
+void dpu_encoder_kickoff(struct drm_encoder *drm_enc)
+{
+	struct dpu_encoder_virt *dpu_enc;
+	struct dpu_encoder_phys *phys;
+	unsigned int i;
+
+	DPU_ATRACE_BEGIN("encoder_kickoff");
+	dpu_enc = to_dpu_encoder_virt(drm_enc);
+
+	trace_dpu_enc_kickoff(DRMID(drm_enc));
+
 	/* All phys encs are ready to go, trigger the kickoff */
 	_dpu_encoder_kickoff_phys(dpu_enc);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 131bb8b2c0ee..7ab5f9380bf5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -216,5 +216,6 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
  * @drm_enc:    Pointer to drm encoder structure
  */
 bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc);
+void dpu_encoder_start_frame_done_timer(struct drm_encoder *drm_enc);
 
 #endif /* __DPU_ENCODER_H__ */

-- 
2.34.1


