Return-Path: <linux-kernel+bounces-438666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D59EA41D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA88428591A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B44206E;
	Tue, 10 Dec 2024 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y71w2M3q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40AE182D2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792991; cv=none; b=i56s3rxCqjGwOsUsudtHi5WZeB+2uwsyGQza0Xlnm9Hbdb/WEZWI9peHSTHk55h2rXaPg9M+KdQOPWYWHeTrTn0LPlp8yRrd2Q17ra2lvqarJJ+Gc4fnbpox0ZwVYp0D/HwD4ruHvgQTFAoRN3tiMSwu3qJkSzvNVOhCDZikvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792991; c=relaxed/simple;
	bh=Rl6nZALK8gL3omcCA9vPA6xqpms+IlATC5HTCrF0mTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IHujJn6NZaNyexNhYVQZbaRrro1UhZUm5XSYmpPufeVXkIxOB1E3Nf1XJpj+5Bqajdvo1bqPEbk/0apKJ7ii5wuPUsTPXvQ4tDQE5iPhElKUv0bMMVKg3gtkGneBuvGwAjBD0aPYmtw4Rdwoj3RdwTzuHKyznOh3nXqZ1lduIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y71w2M3q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FL89a019669;
	Tue, 10 Dec 2024 01:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/7zM4rSt6bAaKjC0n7Ru3DTNZnvxw0jAvOpQGmRKvp0=; b=Y71w2M3qNM0U/Fv1
	WmDc8UBaMkdpCUX6eGpHT83huPOpBlludXwpS+sORw2mNYY4AbPk78wwVcr5ggK7
	5Muh4tD+nRieX3eHjhdDO626j4jdao01Y1FpShtN7ojZL1UAA727c42ounzJ3rvA
	VBhtInI3YNO2aI+QJqel08uFGyrYMWeMEjqY18RTQK5IFM0qWdDuLHYKM7NOXgZi
	mAE8Fy19p+9/jLzY+8FoPmsdqvFivgacdHkt2ODwYytg+HK3/A9M5VBtQ3V8ddIn
	i3eq2pXnxdV9UCv6CoawEPSWY8AQOk07kiCdnNpIHNG8Hs+LQWyXtPmjmuq9bfoK
	msgAuw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e3419c5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 01:09:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA19eLm021946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 01:09:40 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 17:09:40 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Mon, 9 Dec 2024 17:09:24 -0800
Subject: [PATCH v2 1/2] drm: allow encoder mode_set even when connectors
 change for crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241209-abhinavk-modeset-fix-v2-1-4d008f6ea8d0@quicinc.com>
References: <20241209-abhinavk-modeset-fix-v2-0-4d008f6ea8d0@quicinc.com>
In-Reply-To: <20241209-abhinavk-modeset-fix-v2-0-4d008f6ea8d0@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733792980; l=1508;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=FRonWyPJVDhXxcF8DDyfc1TmR1l2G7jWVtfh1WOIoiQ=;
 b=YsE0Qj6rjxMVgYPPtuy2ct1JVdDITdmUV9gd5jFW/y7Mv4KpFGA4hpie+FTcWhSDQkqeYN89p
 EplUOBD1mwYCvaKhi/y+4Mi620GK67LLonwilIpqt6x+SFhpFE8ovfs
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DT5mGsOHXV_A7DWDpZa8Zzkn9u0ZdPAF
X-Proofpoint-ORIG-GUID: DT5mGsOHXV_A7DWDpZa8Zzkn9u0ZdPAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100004

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

In certain use-cases, a CRTC could switch between two encoders
and because the mode being programmed on the CRTC remains
the same during this switch, the CRTC's mode_changed remains false.
In such cases, the encoder's mode_set also gets skipped.

Skipping mode_set on the encoder for such cases could cause an issue
because even though the same CRTC mode was being used, the encoder
type could have changed like the CRTC could have switched from a
real time encoder to a writeback encoder OR vice-versa.

Allow encoder's mode_set to happen even when connectors changed on a
CRTC and not just when the mode changed.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 5186d2114a503701e228e382cc45180b0c578d0c..32902f77f00dd8b85f03811e6d6da99b6d538afe 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1376,7 +1376,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 		mode = &new_crtc_state->mode;
 		adjusted_mode = &new_crtc_state->adjusted_mode;
 
-		if (!new_crtc_state->mode_changed)
+		if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
 			continue;
 
 		drm_dbg_atomic(dev, "modeset on [ENCODER:%d:%s]\n",

-- 
2.34.1


