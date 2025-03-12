Return-Path: <linux-kernel+bounces-558061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AEAA5E11C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701631882839
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6A2561BC;
	Wed, 12 Mar 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q6Oe0qL9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33869254865;
	Wed, 12 Mar 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794750; cv=none; b=Mm/SQmOof7Alo2Osv+zinwdrR2znLlHrZjy2+W43U9//PNAjKWPd9NcmE7kd4dg8M4Tk1T1fDfKDTuaP2OxWnS4ZKN73W2YNKxIYhe1W2LbLdG3eYQo82PrzbZ29Du08hatYvj2ehOYDOkwCTa8uTPOWDet+BJvONFKtDIfsnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794750; c=relaxed/simple;
	bh=fMTbSOL0ZU7nk2Xdj/nf7/vh8CFVz1lbE/ewljcg1ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YW84wyesqUpYNECedsGcxSPTyJxrUTXDiusUC5QyXOrK8j1sBtz1BnO1Ac6Bukwwbhv8yMloMlyCDPO34Ls9T4TDjWAY988bSlFxzpXsb/jgxyoJtEtcdBHTPlRawIWbmRlvK2BLNNrW6myOLZFsk5711jQ28oaJ4SJG2WrIauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q6Oe0qL9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCe1MP022097;
	Wed, 12 Mar 2025 15:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TPto3JH2HTAPZ0HDZktA1VaObqgyBXr78eU9i1r5d
	xk=; b=Q6Oe0qL9hEcm8qe4EgYzYRbTBrdpSNQFuoFDWCmlZxR35lmVW8bfo+a+G
	mw1wlMWNkvPtVpfSpR6QoiYDHk7DX1FfYB934QhGCPvBoEM5A03jE3CiERPtqxU0
	GU8HZ/j9AfxjXYxMPfAesEnA8PC+wcd/EGIDdkiR86B88ARj884nDzBqp1Rxjinj
	azdn8sDSNqDrkn0TLpWmuKr7khMX5Q+3FoodR/8+bnxlCZcnveeG7TWpy3BNkVqf
	ujW0XtX2XTIY8CwR30KkV8vxRS1wxBsycuhwYOlAqBAipMXDBv34co04zqECxJgx
	bCo+f7kEdP5llSdwMW0/mFXAbZXlQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avk4csvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:52:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CE4fYU007490;
	Wed, 12 Mar 2025 15:52:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr4vay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:52:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CFqKMQ56099252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:52:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12B762004D;
	Wed, 12 Mar 2025 15:52:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C48ED20049;
	Wed, 12 Mar 2025 15:52:19 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 15:52:19 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] scripts: get_feat.pl: substitute s390x with s390
Date: Wed, 12 Mar 2025 16:52:19 +0100
Message-ID: <20250312155219.3597768-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QLKk1lM8-btA4Xg49qhyYbsClowHhiH3
X-Proofpoint-GUID: QLKk1lM8-btA4Xg49qhyYbsClowHhiH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120105

Both get_feat.pl and list-arch.sh use uname -m to get the machine hardware
name to figure out the current architecture if no architecture is specified
with a command line option.

This doesn't work for s390, since for 64 bit kernels the hardware name is
s390x, while the architecture name within the kernel, as well as in all
feature files is s390.

Therefore substitute s390x with s390 similar to what is already done for
x86_64 and i386.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/features/list-arch.sh | 2 +-
 scripts/get_feat.pl                 | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index e73aa35848f0..ac8ff7f6f859 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -6,6 +6,6 @@
 # (If no arguments are given then it will print the host architecture's status.)
 #
 
-ARCH=${1:-$(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/')}
+ARCH=${1:-$(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/' | sed 's/s390x/s390/')}
 
 $(dirname $0)/../../scripts/get_feat.pl list --arch $ARCH
diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 5c5397eeb237..40fb28c8424e 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -512,13 +512,13 @@ print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
 # Handles the command
 #
 if ($cmd eq "current") {
-	$arch = qx(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/');
+	$arch = qx(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/' | sed 's/s390x/s390/');
 	$arch =~s/\s+$//;
 }
 
 if ($cmd eq "ls" or $cmd eq "list") {
 	if (!$arch) {
-		$arch = qx(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/');
+		$arch = qx(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/' | sed 's/s390x/s390/');
 		$arch =~s/\s+$//;
 	}
 
-- 
2.45.2


