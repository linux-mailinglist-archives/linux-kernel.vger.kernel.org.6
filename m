Return-Path: <linux-kernel+bounces-261267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734593B4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B821C2386F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121215F311;
	Wed, 24 Jul 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nE5ZqAw+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F515EFC0;
	Wed, 24 Jul 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838254; cv=none; b=A1HYIPQ71mbQxHX/Wu9cAHvAdizREu+KFNgrA7hloHtP6qNFRhxDDs0xtlFBheJq7nLTfhe5JK6Qw2lMZFtxr3lFvae71aOe0m236zlnvrJ0NEGNLGZKqY4rjhI6S0XblBIhfghEvZBbEEPeK35rdCMFZe4KPBAMRRXtdmbyiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838254; c=relaxed/simple;
	bh=Navrk+PFyaTDJIijMu687SZP4snjGd5YksT3s3Vgao4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X366tdbwP9r+YAYsDY9nhUKdgS+76Wmiuum6Wfl9pEPTQ0D/Sq1VNlxcLvVd6SmAi+iHXRnvy9P5yB9fYPhqjdjzksboJgEkN1eTV0xFMDgVO97/0iQV7a5RiM3yF1hYx0/QTwwBaMwGngmgZ2Q2OMmqFuhtzDlrxDO8vO7+4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nE5ZqAw+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXWmU028769;
	Wed, 24 Jul 2024 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=6
	KKce3+2I+tVZGXIFIMVYPZzso6eBjCP1BtU7O1YprA=; b=nE5ZqAw+tRm/OMCzw
	HY84XE8Gw/cOsKl56fshqs2S89iO/yAACyfC7uuWgQm7RrGcT1AW8Qqnw/aC8A8A
	f7Bs+WRwYJGoMJDGExh6StZR4jwgYTib0BJwZ7jHY+Rs4qpwPkf/fP2oA8nA5/2k
	BmNhRhsrZ4HRpFMeHn9/6asMO1sIMGeh7bBmwE2kcLHWxZnUplRCWvjN9VV8PyJQ
	x1J/iTPPGGqj5WQeBXTREVtYIokFRQ/3Dqtm1ZeA7NSwfHr4t5qKPJI8uMcFI5kg
	WsKZdYqAjTMYsz4rGmZMQFeUGsqziGFFa4Q6qbiexLX+ey1kLI0khfElrmTHwnM/
	98FQg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt9dj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 16:24:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OF2Mgh011060;
	Wed, 24 Jul 2024 16:24:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29sv9uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 16:24:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46OGK1m3038616;
	Wed, 24 Jul 2024 16:24:07 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40h29sv9r0-2;
	Wed, 24 Jul 2024 16:24:07 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Abdel Alkuor <abdelalkuor@geotab.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: [PATCH 2/2] usb: typec: tipd: Delete extra semi-colon
Date: Wed, 24 Jul 2024 09:23:51 -0700
Message-ID: <20240724162356.992763-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
References: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: Ph9qnNgDOM-RKjy7AVLffGCkoBxPX9wu
X-Proofpoint-ORIG-GUID: Ph9qnNgDOM-RKjy7AVLffGCkoBxPX9wu

There shouldn't be a ; at the end of the function, delete it.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index eb5596e3406a..dd51a25480bf 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1198,7 +1198,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
 	release_firmware(fw);
 
 	return ret;
-};
+}
 
 static int cd321x_init(struct tps6598x *tps)
 {
-- 
2.45.2


