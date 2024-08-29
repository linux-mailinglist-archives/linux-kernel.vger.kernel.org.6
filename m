Return-Path: <linux-kernel+bounces-307667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC9965137
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1A285FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A21BCA1C;
	Thu, 29 Aug 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5V1+kLK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A71BAEE1;
	Thu, 29 Aug 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964560; cv=none; b=hPjAmEtVMz/gwAt8kv++u5amGflk93/IWd22V1A7duplfOa1DHwcQZsTEeodhBIHVKQF0UwRBh9diTLw3AGuknyFF8fCiiy4AQJMxwyrL8WohQ1CzLMTv4cPP/FVv5Gu/Rici8z7Vunb9bM3UkL3bACH7CTFdL7jLKjT8sUJr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964560; c=relaxed/simple;
	bh=ntWNPM9zed0TrpAd8XQwx6V/he1U41+q9IIsFiS/rS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KsigNokWIv09D/yfuFPXUgkY33Cxb2eBNm9wYzghnncY2SAsUlvTV/dx3x/aGbJBP+9EsuJrdPGvjGDuOTiLWapCdzrZGk/iydoAuRv357pSsHcbgxK1dMN0SjQNh1zJeOXyoQc53fP1jeOIXCQa8865dcrQLzESBHODLsSRbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5V1+kLK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGJhVk011674;
	Thu, 29 Aug 2024 20:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7gtwkNLn7VJUCrVd+0zRRUvRDiACAhmYTbXL324Y6g=; b=g5V1+kLKalgeU1qF
	qe3RjfjlgaxjRsY7MRvMGSq4f7GsWF1MLsaBfAGwVpwAN5oNY7hpoeTi1V3Go9d2
	POFXM2uUphTaGsgJvfv+PkDHBhwhV9F59njiHJ11/IB1g7gswIR9RTO53xneXtkB
	/JtAWNZwPOdVFK3egrH/mgb2uvktKNVnKihe/Slapn95AnqZjnkuVo3d6S3klXMb
	58p7fGf39JYVmpeL31kgQVdym1czvWSCjRsjSIpp2U7inEqU+mno90xIYKbDz+LB
	1/10Rs+1fuMK/I15k4bfETk7NHffPE3e2J2ydY4ue5UuGiTL6awLiQ+SyLTxcuXK
	xZsOBg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0pq96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47TKn2N4025055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:02 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 13:49:02 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Thu, 29 Aug 2024 13:48:34 -0700
Subject: [PATCH 13/21] drm/msm/dpu: Require modeset if clone mode status
 changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240829-concurrent-wb-v1-13-502b16ae2ebb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724964539; l=1349;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=ntWNPM9zed0TrpAd8XQwx6V/he1U41+q9IIsFiS/rS8=;
 b=VtfwJZY0OA8Jg/mqwkYAu4txG55/DICgCjxqJC4HgisA1y03G+ACkD0eB5SzjzC8KXi0EgyTX
 dPubGECOff3C11eT9/G4xAMug+lr0cBqfA6yEa/afMhRwIKpI580Qe3
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VwdSpyyoZhWTb7cz3WCvKd39GesnoTWC
X-Proofpoint-ORIG-GUID: VwdSpyyoZhWTb7cz3WCvKd39GesnoTWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290147

If the clone mode enabled status is changing, a modeset needs to happen
so that the resources can be reassigned

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 1b0cc899e8c1..99eaaca405a4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1306,6 +1306,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 	int rc = 0;
 
 	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
+	bool clone_mode_requested = drm_crtc_in_clone_mode(crtc->state);
+	bool clone_mode_enabled = drm_crtc_in_clone_mode(crtc_state);
 
 	/* there might be cases where encoder needs a modeset too */
 	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
@@ -1313,6 +1315,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 			crtc_state->mode_changed = true;
 	}
 
+	if ((clone_mode_requested && !clone_mode_enabled) ||
+			(!clone_mode_requested && clone_mode_enabled))
+		crtc_state->mode_changed = true;
+
 	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)

-- 
2.34.1


