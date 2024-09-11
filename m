Return-Path: <linux-kernel+bounces-324771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31F9750A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F24A1C224CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A8185B7B;
	Wed, 11 Sep 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oFtZMlkX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC314F100
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053692; cv=none; b=b+ex/e604bBKZTnPqytA85I/mNreR7jtv3TUf7ObJ2k4QS5JMOO+A/Jowvuv50ruM4IN7qyAQMxWZkpcepW/h4BRfn4WS+7OYPAi85SnzUjS50RRear4jMHb6w/T/V/CFFqoaENMD77CTCqLha88PzEWOTbEVfD+lniM9jNyAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053692; c=relaxed/simple;
	bh=3e/FjOg7diNV7H1GqG0B/9SBOjfzjtNJ2hpDMNUz3Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+9T1R8RRXf/6s2MhOYjhNH342Ez14JNSM5ePIUGhFpI253y58R9LGngyAy23acRbGc8RsTV6VZi05NsxXZ6pZS+/MnH/ctDdzPSZfh82OgM+oXtW9fNCGMZyv2ftB+O4RDzCgQo3PN/tSbw27S4v88W6GdV4hQrY795maZ74PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oFtZMlkX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B4tC8W017485;
	Wed, 11 Sep 2024 11:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=nBF5sI29Rox57tDf+dFBWrQ9inWyIhlzi9IfNsS
	nFRU=; b=oFtZMlkXigY4rAgSoR6KVg3y7WuNKQnQsHm6B2uLhUIsuKt9lYQahMS
	KcmnGMDojPmi/JAsestRyHwr6nXy23uTV/Z2ZgwKuXV8+0Ufyf8q8qUYJiQ7qpFs
	kvzUmyabBahTp6RDxj6zBSknSIfLwkEjrk8Hc4lIwKu6wgdG3nJrbcOL8C2/khKq
	wVbTx8Wx/WU/hmWUaIFeh//hJ7f6POxYx10qSWsG7ehX+cqfaHPUmvqXkzjYLSj4
	Q7YDiq6Y0W4aU220jL6orHXqgBphZbU8/1rxIEmFrytbMy4oF2V716+DAqm8udXD
	q6RsZcvS8VqtoQOi8lnlvuzQDLKA2BQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejanbch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:21:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48BBIUAY002556;
	Wed, 11 Sep 2024 11:21:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejanbc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:21:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B9qfRh032415;
	Wed, 11 Sep 2024 11:21:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0s8qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:21:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48BBLGWW50463098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 11:21:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29C8E20049;
	Wed, 11 Sep 2024 11:21:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B57620040;
	Wed, 11 Sep 2024 11:21:13 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.116.75])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 11:21:12 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: [PATCH RESEND v2] kexec/crash: no crash update when kexec in progress
Date: Wed, 11 Sep 2024 16:51:11 +0530
Message-ID: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5LbiWJagaFGoMF1stH_GnUIYrKVP5C8F
X-Proofpoint-GUID: oec8U_PFtdv40NkCfJS3AG_OrhMxS7PD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110082

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

To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
are offline are brought online during kexec. For more information, refer
to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
kexec"). Bringing the CPUs online triggers the crash hotplug handler,
crash_handle_hotplug_event(), to update the kdump image. Since the
system is on the kexec kernel boot path and the kexec lock is held, the
crash_handle_hotplug_event() function fails to acquire the same lock to
update the kdump image, resulting in the error messages mentioned above.

To fix this, return from crash_handle_hotplug_event() without printing
the error message if kexec is in progress.

The same applies to the crash_check_hotplug_support() function. Return
0 if kexec is in progress because kernel is not in a position to update
the kdump image.

Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
Changelog:

Since v1:
 - Keep the kexec_in_progress check within kexec_trylock() - Baoquan He
 - Include the reason why PowerPC brings offline CPUs online
   during the kexec kernel boot path - Baoquan He
 - Rebased on top of #next-20240910 to avoid conflict with the patch below
   https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u

V2 RESEND:
 - Update linuxppc-dev mailing list address
---
 kernel/crash_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index c1048893f4b6..078fe5bc5a74 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;
 	}
@@ -547,7 +548,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
+		if (!kexec_in_progress)
+			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return;
 	}
-- 
2.46.0


