Return-Path: <linux-kernel+bounces-442125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6C9ED84E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD7A163DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459B91E9B34;
	Wed, 11 Dec 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n/9VC+Hq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B91C07E4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951949; cv=none; b=mN5i/vjXuOFJLUn2E1BPpUjvzPiHpsX22pkRDyzY6UbCY44M0Xajd6HNjcCdQIDx/8hRAfgzsUr1qSyueBlwoSmwVeskZ7i889eyoeBNB43UX831zv9LjybHER354Rr20P6GnSAj044y4Ic8na5UrAKs/yy0CWv/z5Vr1H+2uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951949; c=relaxed/simple;
	bh=S7/HrgG+BmhmmegVnh/3esYwG2OEDHW4+ltlL604FiE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=WF5P5Me1tXOb1hEOKZZRzX5KtXiyTW0w0AC+qDMYkgNVHJhuVvJoiQl2oa7925epDOUh07FROt7sIvItISlLhJDnGipzAHMY0zR+PNYzYsY1uK6G+7wAeapf01X797nMmRhzI+mcTvgkrksnsJ8RIpJRd0Hk1X/bHLc1EL8vEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n/9VC+Hq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHDO0d002411;
	Wed, 11 Dec 2024 21:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Aj/zp2/T6DzcCENEe1lXgl
	tCmZ7QwaGn3NNpQozcrf0=; b=n/9VC+HqOdBjwJ92LLRwlfCjRTv2jYOY1JYMyC
	pK35J5j1pDl8ItKh9DitRmeX0XKWcnzhS7BUa04vvp1u6wOnTe6ZzonXBdU5ccu2
	dcy3vYCGqLQVyKrLRqPOkEgk3MrzaELSm2kKqcvMlljZf0AP46OiksxDG20DrN83
	DKy1f0jckKrIUtXph3CqK9ijRmxaP+7PslxWSucIRbSr+4A6Kw2DnTyQoJmMmAhb
	isDlovYuoB220DIl+BhGaBKUO87ChPNPIfuov2LwxuE2PYlV7JQoRwJ+NlSOvwcs
	RlZY8WpFeH0687mSSDSSPj0iMtZ67Ps0EYGAUm6tuBC/kQ8g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eyg63d7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 21:18:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BBLIvar007938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 21:18:57 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 13:18:57 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [PATCH v3 0/2] drm: Allow encoder modeset when connectors are
 changed
Date: Wed, 11 Dec 2024 13:18:41 -0800
Message-ID: <20241211-abhinavk-modeset-fix-v3-0-0de4bf3e7c32@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALEBWmcC/4WOwQrCMBBEf0VydmWzRhs9+R9SJDZbu0gbTWpRp
 P9uKih48vgG5s08VeIonNR29lSRB0kSugzL+UxVjetODOIzK0IymnAD7thI54YztMFz4h5quUN
 h7NrU2jNar3L1EjnHb+2+zFzH0ELfRHZfGW5wRaQ1mQWtbEGFBg3Xm1SHz8JuIumqRRXaSdpI6
 kN8vK8ONKn/vBoIEIxHtPWanfX4YyzHcXwBbs+XUf8AAAA=
X-Change-ID: 20241209-abhinavk-modeset-fix-74864f1de08d
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <quic_abhinavk@quicinc.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733951937; l=1325;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=S7/HrgG+BmhmmegVnh/3esYwG2OEDHW4+ltlL604FiE=;
 b=R3ZX9cCYnxdQMGwsvOeE+fMyC+3qwOtd9C3AiTKQLR5ARLb8/YUB3k8zP5TyrM8SfucsHlk6d
 pFT5XNf+OAeB5FxzpoMKS+55b2iJvfICnRmE3WNEVskn3urVnAvxtcm
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cu1h1pabrPe8aYOwhMpu1MeQnN1OV6TT
X-Proofpoint-ORIG-GUID: cu1h1pabrPe8aYOwhMpu1MeQnN1OV6TT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=627 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110149

Call encoder mode_set() when connectors are changed. This avoids issues
for cases where the connectors are changed but CRTC mode is not.

---
Changes in v3:
- BUILD_BUG_ON() for encoders and connectors array size check (Dmitry)
- Added more descriptive, file-specific names for helper functions
  (Dmitry)
- Added comment to test documenting what the test does (Dmitry)
- Return drm_connector_helper_get_modes_fixed() directly for encoder
  get_modes() instead of returning 1 (Dmitry)
- Move local variable declarations to top of function (Dmitry)
- Link to v2: https://lore.kernel.org/r/20241209-abhinavk-modeset-fix-v2-0-4d008f6ea8d0@quicinc.com

Changes in v2:

- Added kunit test

---
Abhinav Kumar (1):
      drm: allow encoder mode_set even when connectors change for crtc

Jessica Zhang (1):
      drm/tests: Add test for drm_atomic_helper_commit_modeset_disables()

 drivers/gpu/drm/drm_atomic_helper.c           |   2 +-
 drivers/gpu/drm/tests/Makefile                |   1 +
 drivers/gpu/drm/tests/drm_atomic_state_test.c | 244 ++++++++++++++++++++++++++
 3 files changed, 246 insertions(+), 1 deletion(-)
---
base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
change-id: 20241209-abhinavk-modeset-fix-74864f1de08d

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>


