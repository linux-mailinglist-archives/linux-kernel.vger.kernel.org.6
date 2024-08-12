Return-Path: <linux-kernel+bounces-282608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978A94E669
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C625F1F22360
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883314E2C5;
	Mon, 12 Aug 2024 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KEKDBxKy"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAE3715E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443227; cv=none; b=mN9W0OeyhnLeFbWaF+M3SYdnXdQ06hkGN97rEb66JwdsAGvpyJvlks4N1etohkEI40mFcquyZPSFobxSbSQz7kQ2VV5XsMgqgiCxiN4C38ECLYEpJPI2dgR6sVIfgSCp/c/x6vCI7OrrW3KG/Fb2S99WESEzgZVTVWBzFNEVl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443227; c=relaxed/simple;
	bh=63aIivKusA3rq9+2Llqi5WIx1GratG6DrP7QyO0Xr3E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GBuBh1gVXzik58Wv748zMyHlWpEZcXgypJ1HbR7Rf/9iYiSy1KgM2eDBQErkSyy9GLqlcrxmKsZdDpZzSzv/Mlo4pikZgVwzSn6uIS8uTUEjYiyGlB+N8KdN9xyJrbtvDypyCIUHd2Y+EBrCzNK8r/RC4lgTdRxtolt41GhwXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KEKDBxKy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4EA920B7165;
	Sun, 11 Aug 2024 23:13:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4EA920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723443225;
	bh=UHju3hrLliyn4aLgBcrXKTfn/eved4RXuOjZBYYgczY=;
	h=From:To:Cc:Subject:Date:From;
	b=KEKDBxKyq/ZHcu+a6BDafEqICqQWIGyGXcYP/nHEBBuhGV9FyFMcA4R5X1CnDc0/J
	 d/obfZQhfftf8UUy5KCVKXaZAiT9k2lQ9Cp1pWIFB/ajTUnrSPSPvr3yUsuJr3K94b
	 2TFri3Pd61N2fp3a6vRyUoyw08bGYinYE4AfNB9I=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	wei.liu@kernel.org,
	srivatsa@csail.mit.edu
Subject: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds after all CPUs bringup
Date: Sun, 11 Aug 2024 23:13:40 -0700
Message-Id: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
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
[V2]
	- Move vmstat_late_init_done under CONFIG_SMP to fix
          variable 'defined but not used' warning.

 mm/vmstat.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4e2dc067a654..fa235c65c756 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1908,6 +1908,7 @@ static const struct seq_operations vmstat_op = {
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
 int sysctl_stat_interval __read_mostly = HZ;
+static int vmstat_late_init_done;
 
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
@@ -2110,7 +2111,8 @@ static void __init init_cpu_node_state(void)
 
 static int vmstat_cpu_online(unsigned int cpu)
 {
-	refresh_zone_stat_thresholds();
+	if (vmstat_late_init_done)
+		refresh_zone_stat_thresholds();
 
 	if (!node_state(cpu_to_node(cpu), N_CPU)) {
 		node_set_state(cpu_to_node(cpu), N_CPU);
@@ -2142,6 +2144,14 @@ static int vmstat_cpu_dead(unsigned int cpu)
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
2.43.0


