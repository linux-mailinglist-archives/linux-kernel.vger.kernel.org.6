Return-Path: <linux-kernel+bounces-264994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE293EAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1ADB21138
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2241C6D;
	Mon, 29 Jul 2024 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAwZW+oW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CD14293
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219130; cv=none; b=mAYiB7LKFe1WHbR2lPO96hCDcVWbyVw5J4aRwrrAQsgSfkQY/iNMCtrjeoA3sIXw3dv7tSnaaDZJlWV9LCAhHAyBq7bdr3mjEoWjw6zNcBG6EFfA59hllIe8lKVC1WjhnQCmU2HAT27J6uygmiMXr97pvb+Grshkj5qCE4IRlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219130; c=relaxed/simple;
	bh=ttjHmVt8CeTYkWIImx6boEDXFBBsSZre9q/1NM3lXbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gx2n1VZ6fbxYaR69R2zFeSBY1/HEjICKMmfNJRcoK2uhJKr3l7ODBF2dN2WwKzveiHWueucw5x8K+5o3HlDONm2wW17qYCSxYN618b4YrSKKZNna/WJFo2gMl3+QPl0F/TirgYFplFxjqSzKRRzqDesNYv7xO89w/2lCvwvxwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAwZW+oW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722219128; x=1753755128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ttjHmVt8CeTYkWIImx6boEDXFBBsSZre9q/1NM3lXbg=;
  b=BAwZW+oWtug9jrl+DxjyobrjMTaNK4bdi/UK2febC0nrpTtZapl8S4Vr
   LrX8ja+3Uk6XV00lwnNgxaOXCIZuMTWDCHm54DzTLyTea/Crs3D4ZxmhS
   /uGVr0WyfS7j7o+Y3hzjzurXUojOh15S4fZa7J1+dX1Rkbx+FWI3ua6Eo
   HOZkhe1Cogwmte1WZ70EhTVO6xO5wq6DGzo4aCspyd0vrredZjQJOGiJ/
   nIbEa3XVTPtR+blnsaQ23vEEjleaAFlGfqmPv+PXS1ZeqyqQeo4imvFkK
   6TI42aF+Ctc+ZrPeYIK4rTWomMUZsfi9Kdu9H4Egduw15lvj7qmzz2pSm
   w==;
X-CSE-ConnectionGUID: 88ZolH9dRW2WlePYyEuvZg==
X-CSE-MsgGUID: nII9Uds2QGyfJwnqNIAMoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="22854429"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="22854429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 19:12:07 -0700
X-CSE-ConnectionGUID: PO77ahDVRD29COPFuNEIWQ==
X-CSE-MsgGUID: cR6kOZWgS3mHsV5VG5YbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58643934"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa003.jf.intel.com with ESMTP; 28 Jul 2024 19:12:04 -0700
From: Feng Tang <feng.tang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	x86@kernel.org,
	paulmck@kernel.org,
	rui.zhang@intel.com,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v4] x86/tsc: Use topology_max_packages() to get package number
Date: Mon, 29 Jul 2024 10:12:02 +0800
Message-Id: <20240729021202.180955-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduced to solve problem that
sometimes TSC clocksource is wrongly judged as unstable by watchdog
like 'jiffies', HPET, etc.

In it, the hardware package number is a key factor for judging whether
to disable the watchdog for TSC, and 'nr_online_nodes' was chosen due
to, at that time (kernel v5.1x), it is available in early boot phase
before registering 'tsc-early' clocksource, where all non-boot CPUs are
not brought up yet.

Dave and Rui pointed out there are many cases in which 'nr_online_nodes'
is cheated and not accurate, like:

* SNC (sub-numa cluster) mode enabled
* numa emulation (numa=fake=8 etc.)
* numa=off
* platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
* 'maxcpus=' cmdline setup, where chopped CPUs could be onlined later
* 'nr_cpus=', 'possible_cpus=' cmdline setup, where chopped CPUs can
  not be onlined after boot

The SNC case is the most user-visible case, as many CSP (Cloud Service
Provider) enable this feature in their server fleets. When SNC3 enabled,
a 2 socket machine will appear to have 6 NUMA nodes, and get impacted
by the issue in reality.

Thomas' recent patchset of refactoring x86 topology code improves
topology_max_packages() greatly, by making it more accurate and
available in early boot phase, which works well in most of the above
cases.

The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup, which
may under-estimate the package number. As during topology setup, the
boot CPU iterates through all enumerated APIC IDs and either accepts
or rejects the APIC ID. For accepted IDs, it figures out which bits of
the ID map to the package number.  It tracks which package numbers have
been seen in a bitmap.  topology_max_packages() just returns the number
of bits set in that bitmap.

'nr_cpus=' and 'possible_cpus=' can cause more APIC IDs to be rejected
and can artificially lower the number of bits in the package bitmap
and thus topology_max_packages().  This means that, for example, a
system with 8 physical packages might reject all the CPUs on 6 of those
packages and be left with only 2 packages and 2 bits set in the package
bitmap. It needs the TSC watchdog, but would disable it anyway.  This
isn't ideal, but it only happens for debug-oriented options. This is
fixable by tracking the package numbers for rejected CPUs.  But it's
not worth the trouble for debugging.

So use topology_max_packages() to replace nr_online_nodes().

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Closes: https://lore.kernel.org/lkml/a4860054-0f16-6513-f121-501048431086@intel.com/
Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
Hi all,

For warning about possible compromise due to 'nr_cpus=' and 'possible_cpus=',
one alternative is to check whether these has been setup in cmdline inside
tsc.c and warn there. 

Changelog:
 
  Since v3:
  * Rebase against v6.11-rc1
  * Add reviewed tag from Waiman
  * Refine the commmit log with user reported SNC3 bug info

  Since v2:
  * Use 'pr_info' to replace 'pr_warn' which could panic system
    if 'panic_on_warn=1' kcmdline parameter is on (Waiman)

  Since v1:
  * Use Dave's detailed elaboration about 'nr_cpus=', 'possible_cpus='
    possibly compromising '__max_logical_packages' in commit log
  * Fix typos and inaccuracy (Rui and Longman)


 arch/x86/kernel/cpu/topology.c | 5 ++++-
 arch/x86/kernel/tsc.c          | 7 ++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..5603aef16bf9 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -521,8 +521,11 @@ void __init topology_init_possible_cpus(void)
 	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
 
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
-	if (topo_info.nr_rejected_cpus)
+	if (topo_info.nr_rejected_cpus) {
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
+		if (__max_logical_packages <= 4)
+			pr_info("TSC might be buggered due to the rejected CPUs\n");
+	}
 
 	init_cpu_present(cpumask_of(0));
 	init_cpu_possible(cpumask_of(0));
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d4462fb26299..e6efe3a8dd5e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1253,15 +1253,12 @@ static void __init check_system_tsc_reliable(void)
 	 *  - TSC which does not stop in C-States
 	 *  - the TSC_ADJUST register which allows to detect even minimal
 	 *    modifications
-	 *  - not more than two sockets. As the number of sockets cannot be
-	 *    evaluated at the early boot stage where this has to be
-	 *    invoked, check the number of online memory nodes as a
-	 *    fallback solution which is an reasonable estimate.
+	 *  - not more than four packages
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 4)
+	    topology_max_packages() <= 4)
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.34.1


