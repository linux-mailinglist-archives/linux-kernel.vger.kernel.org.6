Return-Path: <linux-kernel+bounces-510764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18384A3219D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7053A700E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54A205AB7;
	Wed, 12 Feb 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dTDteLxw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C0271828;
	Wed, 12 Feb 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350795; cv=none; b=C2kEYI4yuWv9OBwOHJ6AKBp8/QRVkHnHT379VFpIWk3bpYIX7/0F/V1mPDWkRuQpWvMnq3pqEdrwlqOu0aACJIvzopkv8Nc/5JlWk2qeBxFWfxNVBpA1bnjdfRO3EkcZ9Q5qT/7c4y0uqRbuY4dvX/2SI4El2sbzTPtHME+M98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350795; c=relaxed/simple;
	bh=tkIbzF/VE87FfH08HryaQAxJKBpLdyOgoDpYoolYttY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVqY7Mxba+JxfNaKJXax9v8rpidZ82IeppA+me9S3Yu/B05T1ZRogpIz2APFPW8TvrFx+XCj4BA6QFehYwA8rwvmc2qzDl6e5FxkREp+i4f+w7jiSuIymCaE6x1ivgeJ0tX8DSj+n8ZQ57ETdCzOM8mx3+k/O2BSuJt05vNveaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dTDteLxw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C1BbX1002423;
	Wed, 12 Feb 2025 08:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=3jEbAOIXwseuskCe2/0uhyXK88iKw
	0GjqWtoWGzO/G0=; b=dTDteLxwcdxQRB1WSy79NwbwFn/pPTXd90xVwhkqKh1Sg
	32wpI8qPd8061dcjfDZyVceSsdKiSEzyVm6rqyET2JwxDhy43/Dfax+MUn0SvWxl
	FYFy02posUzAfTjpdjC6SkjLgbq8302Y5nXl0XjTdoLmxWrdS6JeD7M5b8bIdZ8L
	pPeugtc1OAxqLCOQk6LkRHRsKptwk7J/ESpEVhSp5TX4eLKjjhozls4BkZ2fICZv
	oiZAGFf9cM43Y3GtO35ZOCKKTZbJcmyH0VvysvQW5joYmrSgMVqeNkVwr41mkIap
	PBuyaiesOieKaxWHSMGvsq8yMtlY2182n3viTSYdg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn6vku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 08:59:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51C82Lrs002313;
	Wed, 12 Feb 2025 08:59:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqggfpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 08:59:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51C8xHoS035041;
	Wed, 12 Feb 2025 08:59:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44nwqggfc1-1;
	Wed, 12 Feb 2025 08:59:17 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>,
        Jens Axboe <axboe@kernel.dk>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()
Date: Wed, 12 Feb 2025 00:58:53 -0800
Message-ID: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120069
X-Proofpoint-GUID: oXk8rO_FymSKpMyuwOW0i7zrRQoM96WV
X-Proofpoint-ORIG-GUID: oXk8rO_FymSKpMyuwOW0i7zrRQoM96WV

This code calls kfree(bfr); and then passes "bfr" to rtk->ops->crashed()
which is a use after free.  The ->crashed function pointer is implemented
by apple_nvme_rtkit_crashed() and it doesn't use the "bfr" pointer so
this doesn't cause a problem.  But it still looks sketchy as can be.

Fix this by moving kfree() after the last usage of bfr.

Fixes: c559645f343a ("soc: apple: rtkit: Pass the crashlog to the crashed() callback")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 drivers/soc/apple/rtkit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 4b0783091a92..1ccec7ba640c 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -360,7 +360,6 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
 		apple_rtkit_memcpy(rtk, bfr, &rtk->crashlog_buffer, 0,
 				   rtk->crashlog_buffer.size);
 		apple_rtkit_crashlog_dump(rtk, bfr, rtk->crashlog_buffer.size);
-		kfree(bfr);
 	} else {
 		dev_err(rtk->dev,
 			"RTKit: Couldn't allocate crashlog shadow buffer\n");
@@ -369,6 +368,8 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit *rtk, u64 msg)
 	rtk->crashed = true;
 	if (rtk->ops->crashed)
 		rtk->ops->crashed(rtk->cookie, bfr, rtk->crashlog_buffer.size);
+
+	kfree(bfr);
 }
 
 static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
-- 
2.39.3


