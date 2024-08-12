Return-Path: <linux-kernel+bounces-282549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6043F94E5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FFA281F75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC313D8B6;
	Mon, 12 Aug 2024 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sanv3JSb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891AC3398A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723436251; cv=none; b=KEHvUDLpHbEPntmk2mONB/i0zxmYoEiAKKQw3coIubB2LNTYefeNlPI+iNBdd9IZmiWByL0hfHEjFdJz2jppSy1sKHVH5kp8f+co4vjfBKgVC8OwMNirBR2wFyD4kP6ME6Jm0A+pOf67//ixP63RTTZvp891FZCw9tR/EcwGEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723436251; c=relaxed/simple;
	bh=hfgJ1BqUGLo8edx66H30vVLs4wqTCSjkTE1Hno7L1oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRrzSO6fUrZA0xtHZWUagi87IsEqrvpKFh4FvP3Tl/RFfY+Z362nVk728p7qUdOH+LXW025FHqAgs/4t/IEKCy1L9bCxyyRHoaWu7pFK8Fl0DQ1o5xExY2Oed8So8S/x9pmVj02kUHpc6NfP60ahDd+57FtKpenkO1orYvQB6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sanv3JSb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C40MlQ025153;
	Mon, 12 Aug 2024 04:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=62oxwiY5u3UMmRSQAYsBL1tFjGfWXTjHWjaJdWv
	xGPo=; b=Sanv3JSbiJD22z7tLlmTtLv1OmBmnjDF1b8/xVW+M6IN3+O76qtA9p9
	dkEo9t+6fG/xNXq2+wLj1Qkh/PE8qtXZy9FcAl0+WaDXEPcWZ9/ydY23hOEXCXhG
	zpx1eetRvV0uI/iJhpWgPHuCFzzDtxpAKXDVsN4Hn97TIo6GEHM5lRYuSajAu7Zm
	iSm2YUpO6WHvZLCPBFbJTCu6AGCpkbiGkLe21aucgbJvX2Z190IrySTENcyt8nvr
	mfQgeOyBa4zz57yUkVyWh7KVgWDRbhdHFF14VEro4V36Lejm4qXyVcm6wmAoQq4r
	icicvISkH8vmVu/R/zLbZKyvjCCmaDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wxmjusgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 04:17:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47C4HArP020690;
	Mon, 12 Aug 2024 04:17:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wxmjusgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 04:17:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47C3WUbJ030998;
	Mon, 12 Aug 2024 04:17:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrm4gx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 04:17:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47C4H4C355116090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 04:17:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B1620043;
	Mon, 12 Aug 2024 04:17:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A732320040;
	Mon, 12 Aug 2024 04:17:00 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.69.208])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Aug 2024 04:17:00 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <petr@tesarici.cz>,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: [PATCH v2] Document/kexec: Generalize crash hotplug description
Date: Mon, 12 Aug 2024 09:46:51 +0530
Message-ID: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HyyGjBIDXDtUFsVmprReAEctkiO3T5if
X-Proofpoint-GUID: ZZhXB_5bhMwUz45dOSbQ_eu9wlrzIubP
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120029

Commit 79365026f869 ("crash: add a new kexec flag for hotplug support")
generalizes the crash hotplug support to allow architectures to update
multiple kexec segments on CPU/Memory hotplug and not just elfcorehdr.
Therefore, update the relevant kernel documentation to reflect the same.

No functional change.

Cc: Petr Tesarik <petr@tesarici.cz>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---

Changelog:

Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
  - Update crash_hotplug sysfs document as suggested by Petr T
  - Update an error message in crash_handle_hotplug_event and
    crash_check_hotplug_support function.

---
 .../ABI/testing/sysfs-devices-memory          |  6 ++--
 .../ABI/testing/sysfs-devices-system-cpu      |  6 ++--
 .../admin-guide/mm/memory-hotplug.rst         |  5 +--
 Documentation/core-api/cpu_hotplug.rst        | 10 +++---
 kernel/crash_core.c                           | 33 +++++++++++--------
 5 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index a95e0f17c35a..cec65827e602 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -115,6 +115,6 @@ What:		/sys/devices/system/memory/crash_hotplug
 Date:		Aug 2023
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
-		(RO) indicates whether or not the kernel directly supports
-		modifying the crash elfcorehdr for memory hot un/plug and/or
-		on/offline changes.
+		(RO) indicates whether or not the kernel updates relevant kexec
+		segments on memory hot un/plug and/or on/offline events, avoiding the
+		need to reload kdump kernel.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 325873385b71..1a31b7c71676 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -703,9 +703,9 @@ What:		/sys/devices/system/cpu/crash_hotplug
 Date:		Aug 2023
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
-		(RO) indicates whether or not the kernel directly supports
-		modifying the crash elfcorehdr for CPU hot un/plug and/or
-		on/offline changes.
+		(RO) indicates whether or not the kernel updates relevant kexec
+		segments on memory hot un/plug and/or on/offline events, avoiding the
+		need to reload kdump kernel.
 
 What:		/sys/devices/system/cpu/enabled
 Date:		Nov 2022
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 098f14d83e99..cb2c080f400c 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -294,8 +294,9 @@ The following files are currently defined:
 ``crash_hotplug``      read-only: when changes to the system memory map
 		       occur due to hot un/plug of memory, this file contains
 		       '1' if the kernel updates the kdump capture kernel memory
-		       map itself (via elfcorehdr), or '0' if userspace must update
-		       the kdump capture kernel memory map.
+		       map itself (via elfcorehdr and other relevant kexec
+		       segments), or '0' if userspace must update the kdump
+		       capture kernel memory map.
 
 		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
 		       configuration option.
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index dcb0e379e5e8..a21dbf261be7 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -737,8 +737,9 @@ can process the event further.
 
 When changes to the CPUs in the system occur, the sysfs file
 /sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
-updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
-or '0' if userspace must update the kdump capture kernel list of CPUs.
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr and
+other relevant kexec segment), or '0' if userspace must update the kdump
+capture kernel list of CPUs.
 
 The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
 option.
@@ -750,8 +751,9 @@ file can be used in a udev rule as follows:
  SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 
 For a CPU hot un/plug event, if the architecture supports kernel updates
-of the elfcorehdr (which contains the list of CPUs), then the rule skips
-the unload-then-reload of the kdump capture kernel.
+of the elfcorehdr (which contains the list of CPUs) and other relevant
+kexec segments, then the rule skips the unload-then-reload of the kdump
+capture kernel.
 
 Kernel Inline Documentations Reference
 ======================================
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..c1048893f4b6 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;
 	}
@@ -520,18 +520,25 @@ int crash_check_hotplug_support(void)
 }
 
 /*
- * To accurately reflect hot un/plug changes of cpu and memory resources
- * (including onling and offlining of those resources), the elfcorehdr
- * (which is passed to the crash kernel via the elfcorehdr= parameter)
- * must be updated with the new list of CPUs and memories.
+ * To accurately reflect hot un/plug changes of CPU and Memory resources
+ * (including onling and offlining of those resources), the relevant
+ * kexec segments must be updated with latest CPU and Memory resources.
  *
- * In order to make changes to elfcorehdr, two conditions are needed:
- * First, the segment containing the elfcorehdr must be large enough
- * to permit a growing number of resources; the elfcorehdr memory size
- * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
- * Second, purgatory must explicitly exclude the elfcorehdr from the
- * list of segments it checks (since the elfcorehdr changes and thus
- * would require an update to purgatory itself to update the digest).
+ * Architectures must ensure two things for all segments that need
+ * updating during hotplug events:
+ *
+ * 1. Segments must be large enough to accommodate a growing number of
+ *    resources.
+ * 2. Exclude the segments from SHA verification.
+ *
+ * For example, on most architectures, the elfcorehdr (which is passed
+ * to the crash kernel via the elfcorehdr= parameter) must include the
+ * new list of CPUs and memory. To make changes to the elfcorehdr, it
+ * should be large enough to permit a growing number of CPU and Memory
+ * resources. One can estimate the elfcorehdr memory size based on
+ * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
+ * excluded from SHA verification by default if the architecture
+ * supports crash hotplug.
  */
 static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
 {
@@ -540,7 +547,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
 		crash_hotplug_unlock();
 		return;
 	}
-- 
2.45.2


