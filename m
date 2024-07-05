Return-Path: <linux-kernel+bounces-242134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1392840F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EDD1F22B02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972C145FE0;
	Fri,  5 Jul 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hlq1n32j"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF92144D0E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169308; cv=none; b=GKN94LjtJofwH3qvyRsW1IHfsDUzagAU7r+mXU3eF1+0BSvxqX7Xg9RvebwxV40QsJFxa7BPfW7T97L6bdV8DLum3tEebirbfwmFQ4h40arYF5OJ65mVvUL1J54cjt9BZyqMaD0BeWxbBXdpmV2XT6qUX9D9vAEPFUavyU0btqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169308; c=relaxed/simple;
	bh=PCmILhZnkmWNVnAzRrSpjrEtBVCWY+tUa92/0HxNRTY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s0FQ0yroOIrj2VUto8a7kRuFZXgV8dA5Lwhhqf66VLvXPTqb8WMmU+F8l7X+Xi28hRsKMLNv1vlLZpxuaXJB1QVBluSfM0b1hpMJlh6R+e3uMyomA6TXIeRhAe8T3JuE3zjx5ngafNufxqLtsEh5uoortYfAy5y5xHtnR9Bo3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hlq1n32j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5041D20B7001;
	Fri,  5 Jul 2024 01:48:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5041D20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720169306;
	bh=0thq+BQ0rfesnQgGZNqX21vsSZLDMUtxpzXR/g19MkA=;
	h=From:To:Cc:Subject:Date:From;
	b=Hlq1n32jWKC7p4bjqM7cmiqf/I6OSmhHULQEiJkMsf1mEvii7LEFZW79TtyfaeVyK
	 q4jMMfD46cunsQDKMcKm5PRlB+BZvg043PhxeTRMaYHtQHhKtjHPAU45GPiB0txZHs
	 CLR3i2kVQbYOTxwHJGmxzOFWKQ7EfYbdWoJmSmQE=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	wei.liu@kernel.org
Subject: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after all CPUs bringup
Date: Fri,  5 Jul 2024 01:48:21 -0700
Message-Id: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

refresh_zone_stat_thresholds function has two loops which is expensive for
higher number of CPUs and NUMA nodes.

Below is the rough estimation of total iterations done by these loops
based on number of NUMA and CPUs.

Total number of iterations: nCPU * 2 * Numa * mCPU
Where:
 nCPU = total number of CPUs
 Numa = total number of NUMA nodes
 mCPU = mean value of total CPUs (e.g., 512 for 1024 total CPUs)

For the system under test with 16 NUMA nodes and 1024 CPUs, this
results in a substantial increase in the number of loop iterations
during boot-up when NUMA is enabled:

No NUMA = 1024*2*1*512  =   1,048,576 : Here refresh_zone_stat_thresholds
takes around 224 ms total for all the CPUs in the system under test.
16 NUMA = 1024*2*16*512 =  16,777,216 : Here refresh_zone_stat_thresholds
takes around 4.5 seconds total for all the CPUs in the system under test.

Calling this for each CPU is expensive when there are large number
of CPUs along with multiple NUMAs. Fix this by deferring
refresh_zone_stat_thresholds to be called later at once when all the
secondary CPUs are up. Also, register the DYN hooks to keep the
existing hotplug functionality intact.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 mm/vmstat.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6e3347789eb2..5c0df62238d9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -31,6 +31,7 @@
 
 #include "internal.h"
 
+static int vmstat_late_init_done;
 #ifdef CONFIG_NUMA
 int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
 
@@ -2107,7 +2108,8 @@ static void __init init_cpu_node_state(void)
 
 static int vmstat_cpu_online(unsigned int cpu)
 {
-	refresh_zone_stat_thresholds();
+	if (vmstat_late_init_done)
+		refresh_zone_stat_thresholds();
 
 	if (!node_state(cpu_to_node(cpu), N_CPU)) {
 		node_set_state(cpu_to_node(cpu), N_CPU);
@@ -2139,6 +2141,14 @@ static int vmstat_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+static int __init vmstat_late_init(void)
+{
+	refresh_zone_stat_thresholds();
+	vmstat_late_init_done = 1;
+
+	return 0;
+}
+late_initcall(vmstat_late_init);
 #endif
 
 struct workqueue_struct *mm_percpu_wq;
-- 
2.34.1


