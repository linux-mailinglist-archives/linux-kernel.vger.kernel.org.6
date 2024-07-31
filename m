Return-Path: <linux-kernel+bounces-269503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F693943395
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045EA282CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA31BBBD7;
	Wed, 31 Jul 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fu04ENa4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608D17BBF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440656; cv=none; b=ACV2dk9uK6bjKPXM52ZbTP2YbSkaV72w05KjqtrWkseVdCu0nkTsizAeiyGlWXhk74EStMkW90as0gwnVHVqrrHrSvf170lHOWud23Yn8xm7SF/rKyyPK/nsBnz3niwbQFNlGLqowEzCGdLZl+bwNz9fl6azzruiq4QkQysJYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440656; c=relaxed/simple;
	bh=Ww1HdiYabJvs0TVzDN5wYB7aV2nKtr5xgegYLtamEHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ut7hx3Bny9MSqBdzBQ/+fzyf6ehknkiQdRxipALsuyvPADeokWo/ACgG0CJv0+s0B3lC0D79PpoRandaeznwWmwzxrouQtgg3ka8LbrCA3dn7HouwGwKBnKBcptzLI47NIMLg3Pd+RQ93A1bghkijYmwIA9XfZnYrQapeSkxA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fu04ENa4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VEx8xZ010793;
	Wed, 31 Jul 2024 15:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=hhHWeaNkZfHMfRDUO64zSGqk09
	QgJEh1NWQLmw+aNQc=; b=fu04ENa4h8O9wnWe9M1ajRTMcXYS95QeBUBWH9myRQ
	pUIEimclg1mxFi5Xbc2G00YDFi9FAwQu3g50RIsGC6Jy/XVCtPlAI7e4onBY2TDX
	A0vsAhsiHwVBZjy7kvmTfNvq2rPN1/Vlm9p3LNyQiD+iXlJ2Zdp0q9vbto3sKn9a
	1Hl/yFnXmX4ELNkN1y8/N8gzjLJJeXMggGUmL/CEesdFliUdTRY6L/1wXDHs/ZQS
	hLgZgJIDBm8+z0VOsZyKsrIrAe654pf1pqe5juOvzEoYidI8nxrdkfh/oWW4g6C2
	A8V+rwnp5RPbzcOQ+LEert2g/fpM1PgtiLV0Y28lRqQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qqgfg50g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:43:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VFhvJX030535;
	Wed, 31 Jul 2024 15:43:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qqgfg50f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:43:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46VFPDbD018863;
	Wed, 31 Jul 2024 15:28:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pvcar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:28:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VFSEtp25297594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 15:28:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 768A520043;
	Wed, 31 Jul 2024 15:28:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86E520040;
	Wed, 31 Jul 2024 15:28:11 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.121.172])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 15:28:11 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: [PATCH] kexec/crash: no crash update when kexec in progress
Date: Wed, 31 Jul 2024 20:57:38 +0530
Message-ID: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NI5JIIGj-pUPCmKc0HLVKOq8Q-d3lv5Y
X-Proofpoint-ORIG-GUID: DSRbYjB_BDAWk9Bm9dww5IvoeeZeHPoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310108

The following errors are observed when kexec is done with SMT=off on
powerpc.

[  358.458385] Removing IBM Power 842 compression device
[  374.795734] kexec_core: Starting new kernel
[  374.795748] kexec: Waking offline cpu 1.
[  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[  374.935833] kexec: Waking offline cpu 2.
[  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
snip..
[  375.515823] kexec: Waking offline cpu 6.
[  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[  375.695836] kexec: Waking offline cpu 7.

During kexec, the offline CPUs are brought online, which triggers the
crash hotplug handler `crash_handle_hotplug_event()` to update the kdump
image. Given that the system is on the kexec path and the kexec lock is
taken, the `crash_handle_hotplug_event()` function fails to take the
same lock to update the kdump image, resulting in the above error
messages.

To fix this, let's return from `crash_handle_hotplug_event()` if kexec
is in progress.

The same applies to the `crash_check_hotplug_support()` function.
Return 0 if kexec is in progress.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kernel/crash_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..d37a16d5c3a1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -502,6 +502,9 @@ int crash_check_hotplug_support(void)
 {
 	int rc = 0;
 
+	if (kexec_in_progress)
+		return 0;
+
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
@@ -537,6 +540,9 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 {
 	struct kimage *image;
 
+	if (kexec_in_progress)
+		return;
+
 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
-- 
2.45.2


