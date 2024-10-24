Return-Path: <linux-kernel+bounces-380562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8B9AF281
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2ABC1C261A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696F218585;
	Thu, 24 Oct 2024 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTSYez4o"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E752178EC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797196; cv=none; b=Tgrgj46ZaOOPPk6sZv2Wng9ruXNEvwo9hkgUGS44/NLLfP4PSnHgxj5FN4mYUGE2b04Hf3PmTwXy7cL7gnG0YDH7wrNPEIw48HzSyxJ2TFxFSsLgogbiNBVsMW9G+XvArjd0KqyM5i4su6nngdY9ogIjNqdBwV5I+mUe1NMI9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797196; c=relaxed/simple;
	bh=llsbJa8CAOQrZ/8zAHYxZT4aEzgBAtLvIcbfGGGGgB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DS3NKJz9itMMA32TBSrXu09E1T2d8jRSQernOjZ+pw8efkHK944C0jv8z6m22FZxm0NSfCjXMI0xdpCJXKiONbjNTJgIgx3l9vj07raLApky6v7POJhmEqv7MG/2J8MREZfrsUdGtX+AnbDf7PmWnc4iZlr8r6LyLmVFPyMrSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTSYez4o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFcbKU002139;
	Thu, 24 Oct 2024 19:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=L1mgv8Oo2aiSACGAkiajajPkSyZIlsaky/nqHxX6w
	Dk=; b=sTSYez4oB3UZf1PazTG4xjYP1QtJwyEJyOdl4dTAsf083VCekB/Rnq/4b
	d9VL81JkOssrwco0vApwDaGLsLtiacJ7/TwxYz3VMiYUHmk3fkcshT9StpYRMWl3
	NDiqFbMGNqhgwOU2jDPp612fUfhmHucrOJ4SPFr/rifXlK8s++d4ZPxpBzWoHU0y
	TVRQX68wpIWQ95PLNtFUi54RMMZbE+R0mshlDQq1aqThy8lDB+H3S4+SfP7ZieI9
	Baqz6nwbIP6GQsQmyaMLk7HGvT/lMPUnz6XWP722HkmFScv6cF3hrXKYYPf8uqk5
	vVN5SULtYPN4+pgR+vKZ1lyvFlnQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fgyuuqdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 19:12:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OJCxNW031392;
	Thu, 24 Oct 2024 19:12:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fgyuuqde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 19:12:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OI2HDH014287;
	Thu, 24 Oct 2024 19:12:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhft1c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 19:12:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OJCra052429196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 19:12:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C52D820043;
	Thu, 24 Oct 2024 19:12:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFAB020040;
	Thu, 24 Oct 2024 19:12:51 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com.com (unknown [9.43.37.181])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 19:12:51 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        maddy@linux.ibm.com, peterx@redhat.com, groug@kaod.org,
        sshegde@linux.ibm.com, mchauras@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/xmon: symbol lookup length fixed
Date: Fri, 25 Oct 2024 00:42:33 +0530
Message-ID: <20241024191232.1570894-2-mchauras@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p9m36YE5cZSWDNycHutVENENPzhQoSTW
X-Proofpoint-GUID: QFUPqyUUvpFtObGIeQ53XbNoAJBawy1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=992 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240155

Currently this cannot lookup symbol beyond 64 characters in some cases
like "ls", "lp" and "t"

Fix this by using KSYM_NAME_LEN instead of fixed 64 characters

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

ChangeLog v1 -> v2:
  - Commit message updated with commands

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e6cddbb2305f..22b8b5cc4df0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3662,7 +3662,7 @@ symbol_lookup(void)
 	int type = inchar();
 	unsigned long addr, cpu;
 	void __percpu *ptr = NULL;
-	static char tmp[64];
+	static char tmp[KSYM_NAME_LEN];
 
 	switch (type) {
 	case 'a':
@@ -3671,7 +3671,7 @@ symbol_lookup(void)
 		termch = 0;
 		break;
 	case 's':
-		getstring(tmp, 64);
+		getstring(tmp, KSYM_NAME_LEN);
 		if (setjmp(bus_error_jmp) == 0) {
 			catch_memory_errors = 1;
 			sync();
@@ -3686,7 +3686,7 @@ symbol_lookup(void)
 		termch = 0;
 		break;
 	case 'p':
-		getstring(tmp, 64);
+		getstring(tmp, KSYM_NAME_LEN);
 		if (setjmp(bus_error_jmp) == 0) {
 			catch_memory_errors = 1;
 			sync();
-- 
2.47.0


