Return-Path: <linux-kernel+bounces-261266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8648E93B4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC831C22032
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9715EFA3;
	Wed, 24 Jul 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mMTwvg4U"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8415E5DC;
	Wed, 24 Jul 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838250; cv=none; b=U26G6Yjtu1C3Z6kHMq+Ku0yvf6aQj5T101h+TX/3aXnRqkecSbj0kB8b5PWBdiXIJS19e3xM/aRaDTU1Evy1UMmIdWayvJ2P+h5KXixF8O9SnaTZNJbbecDa11BEBF3pODwZ3zAnKkOHjuRWMN6+klntTCCWYvt3nTAnFt5WXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838250; c=relaxed/simple;
	bh=+GDXdpaA3tN+UsnM4TWXSQKP47WK9e3fMb2BieYvfZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJF7opBtsUL4cyMchSweWiewPYRJGFnHwjii4cexsn9WWp+Rwe38PPVyK0KcnYll88Ud1/w8HD58denncpEyXhcuqSemFlp8BA1xVs7Z8VQLcdKNg1vW/2umwSLQdweVgs+7J3kGEcKC7i1HRZSOg43TQfqjbGywPf0nJux0yy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mMTwvg4U; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXW6h026916;
	Wed, 24 Jul 2024 16:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=xHlM8Vj5GY+Sun
	9vNdid3JtRVWESlFDCDBqVFaBIKcw=; b=mMTwvg4UdjBJNFgPqp2coCaniZn0zR
	UTBOXDaq42i9HGAcQ1NTCIJsxK7z8xtK/0rMcsvSZMSnLNZT8PC/c1uZp27Ynysm
	O4UtAhL6QJ4GWxhJRiSXE/22O+G8lLLESZZ8Dx9gxordjtwIwlKJsFwMW00ACd4k
	bL2kmmiq9wMYVElwLR/wxDWBS9gMBOpwQrPvtUN3mRD5QpDVCDH6qXwGnljsQCyX
	JAYB9e9YB1bKK9rQFtMkfGtv3tmy7V/mSzHHi9Oq1wiW5EOvYdWUPKCAQUrmE0hO
	Wv7FamIH5KHKw87cAC4Lbsw6hu1X+rIutP64NwPgKnkNfb87aOnfEKUQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0hd3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 16:24:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OFIZXL011001;
	Wed, 24 Jul 2024 16:24:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29sv9rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 16:24:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46OGK1m1038616;
	Wed, 24 Jul 2024 16:24:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40h29sv9r0-1;
	Wed, 24 Jul 2024 16:24:02 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Abdel Alkuor <abdelalkuor@geotab.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: [PATCH 1/2] usb: typec: tipd: Fix dereferencing freeing memory in tps6598x_apply_patch()
Date: Wed, 24 Jul 2024 09:23:50 -0700
Message-ID: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_17,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240119
X-Proofpoint-GUID: la_pRtilNQS6xSM5tq_XVoIpHbfMvMqT
X-Proofpoint-ORIG-GUID: la_pRtilNQS6xSM5tq_XVoIpHbfMvMqT

release_firmware() already frees fw, fix this my moving release_firmware
after the dereference.

Fixes: 916b8e5fa73d ("usb: typec: tipd: add error log to provide firmware name and size")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is found with smatch, only compile tested
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ea768b19a7f1..eb5596e3406a 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1191,11 +1191,11 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
 	dev_info(tps->dev, "Firmware update succeeded\n");
 
 release_fw:
-	release_firmware(fw);
 	if (ret) {
 		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
 			firmware_name, fw->size);
 	}
+	release_firmware(fw);
 
 	return ret;
 };
-- 
2.45.2


