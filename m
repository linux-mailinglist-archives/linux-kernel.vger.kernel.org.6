Return-Path: <linux-kernel+bounces-511593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C4A32D18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B77116C1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6E256C8E;
	Wed, 12 Feb 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pFlxGPBO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB1253B63
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380136; cv=none; b=FYcaZGo6wVY9MeAfcnlFsA7GHXHrjdR89c7R5b6YMp3scNkFPEl5dE9A4jDe8rib93JnC0/A9musYbNWu/Z3ngB0qsVXf3V1QQrXP3r7OdLDkDcNWZSLNkIExndmCbEbVxnLrBWi8t0tZORLQKuvUnpkh1RkBKlnAChcFGARDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380136; c=relaxed/simple;
	bh=WYGCA/5PA8RVabOezI8jUKp+br/HPzbB2/YE7M0yBBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foBwANjqRrIg8PNHuDfg7YaFlAYMXbqWV7eTtucXEn195jwd/PAa9ob2q9q8n+wUg04VND/t5DT91VBQ9UBbsSFvc/xSBOJRY3BjDPGNU65MoRKQgd9Ep9iCvpX/mhGBs8ZrzGxxHlS5FGlD7MFgpnvn64sUYO6ilZx6RKQEbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pFlxGPBO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CAkptk012575;
	Wed, 12 Feb 2025 17:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=K2I1nWVkfCkRd0Xe12e1T3Yl0yxmtCAJNed23sGtc
	ag=; b=pFlxGPBOEEM+60LtTNzVrVtKRFTa+5uYBMzJVSk/DWmC0w/WxkejuFFYa
	uLx9l1oTnsbdnhFr7EBi9bGAKzWdKKpgi2LaQqrGENl5M/GqgBHZxqfch4xZzniN
	yJmw+qvtmoF2uEbmJQ2Eq1uCk/CA+e1dikufsEcYnhXn6VB6kxx2D79j8EWQbOiU
	ZcaiETh/LvfFYtzkbw3OWsCnZyx/Fq0Sj+drgNMeQz1UbRdsJ6kR5lYqwD/BcYyF
	6YJCE0O8CR7oVCf+gUWJ2b8u2/eTARYW88l8CWOe2Okwzj6jESoydT9IA9UeXo5z
	51JaJZ1WCDQVNAUUfXBRVHRoydJ1g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa4xs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:08:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFrJfd001051;
	Wed, 12 Feb 2025 17:08:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkn9y9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:08:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CH8VAW22217420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 17:08:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB56758065;
	Wed, 12 Feb 2025 17:08:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B2B158063;
	Wed, 12 Feb 2025 17:08:31 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.104.210])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 17:08:31 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eajames@linux.ibm.com, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, linux-fsi@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: change maintainer for FSI
Date: Wed, 12 Feb 2025 11:08:27 -0600
Message-ID: <20250212170827.1477102-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jPhs8sh0UBW5UswdmdsWyMFPoKBHS5Zr
X-Proofpoint-ORIG-GUID: jPhs8sh0UBW5UswdmdsWyMFPoKBHS5Zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=976 clxscore=1011 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120124

Due to job transitions, both Joel and Jeremy can no longer maintain
the FSI subsystem. I will take over.
I also removed the link to Joel's FSI tree as he won't be maintaining
it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---

Since there is no longer a tree associated with this subsystem, can we rely
on you, Greg, to merge changes to the FSI subsystem? Or will I need to create
a kernel.org account and an associated tree and send you merge requests?
Thanks.

 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f65a2a1cde5b..83024cd416143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9441,14 +9441,13 @@ F:	include/linux/fscrypt.h
 F:	include/uapi/linux/fscrypt.h
 
 FSI SUBSYSTEM
-M:	Jeremy Kerr <jk@ozlabs.org>
-M:	Joel Stanley <joel@jms.id.au>
+M:	Eddie James <eajames@linux.ibm.com>
+R:	Jeremy Kerr <jk@ozlabs.org>
+R:	Joel Stanley <joel@jms.id.au>
 R:	Alistar Popple <alistair@popple.id.au>
-R:	Eddie James <eajames@linux.ibm.com>
 L:	linux-fsi@lists.ozlabs.org
 S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git
 F:	drivers/fsi/
 F:	include/linux/fsi*.h
 F:	include/trace/events/fsi*.h
-- 
2.43.5


