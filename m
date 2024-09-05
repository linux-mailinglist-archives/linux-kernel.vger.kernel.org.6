Return-Path: <linux-kernel+bounces-316378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6996CEC3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3681C226D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BD188A31;
	Thu,  5 Sep 2024 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaI3T58S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692F79E1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515691; cv=none; b=Rhi4aIVeQMPnibsaLzx/2CZE6uVa3DSzwXgMTXifiYHXbo9Pn4ju8neRBw7JpL6yHF0L5PRpvq+6DCbXbdD5wX7x4Y4FvBJKpRMLbhCWgF2OqB0LUN/gYYdQw0BbAgX0Ila9UMUf8hxojsvMLT/M9A8N7W5z/MH4T2JprEwJsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515691; c=relaxed/simple;
	bh=5dohECQD0J7OkGVwLm8AQ0fKLeE+G6Y/tG1Rqe7YFyM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sb5W+DEDHg1MD/lli00nObhZkyhRtd/ctcy3aObzSFdncOH6r3MgLbyRX+vf0SQs9eesa9HRx/oiaSu6IsSEBc0DNmBu9IUrrghthHOJbimvftqseJ7AM0zodYIHAQUTYSfUZYqfuuLeto07HPo6POTc2Oqkey3v5YuO8BuSAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaI3T58S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725515690; x=1757051690;
  h=from:to:cc:subject:date:message-id;
  bh=5dohECQD0J7OkGVwLm8AQ0fKLeE+G6Y/tG1Rqe7YFyM=;
  b=LaI3T58S/2VFmSWFXozZH08jbIwliM7BCzBfBmBnA2+3/6cYqS8LWOmS
   X/jbY5NfqHEch8CTDEkMpGSHzGdHNvpFsnfrHeLaBExnPh5fqGVZCYaB6
   1v4xwudXsEkLdjmVKG0BX87LP7XMZ2JKI5jgQd11HK8/9DZM5qMUIkXa2
   e3ghF3SdbWWG8Pg/GqS5n7PGc31FLRTKHtss9UIpjkBPmXFgY1QcPfV97
   2c+a2+wOdopCIvC2BxMfZ/lXz6yEVT/abiMdd286N16y/RFo6S+/oZJj2
   DsZXB6fONua7lR1gg9v/mOiMyZLQ3LxTMMxMir+vhmXJhFIEi0ZA7ymhC
   g==;
X-CSE-ConnectionGUID: t0OYxaFLSQW66HKF9Tp5kA==
X-CSE-MsgGUID: NARDeI9LRcawtQfYz5UWNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35567184"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="35567184"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 22:54:49 -0700
X-CSE-ConnectionGUID: z1gOza+zS4WpZiZMuCVEhA==
X-CSE-MsgGUID: 9GYOyIR2SbmffxQPmDgm7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="70421549"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2024 22:54:49 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] x86/cacheinfo: Set the number of leaves per CPU
Date: Wed,  4 Sep 2024 23:00:32 -0700
Message-Id: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
if CPUs have different numbers of subleaves in CPUID 4. This is the case
of Intel Meteor Lake, which now is out in the world. Tools that rely on
sysfs (e.g., lstopo) fail.

Patches 3 and 4 fix the described issue on Meteor Lake. Patches 1 and 2
are prework in the cacheinfo base driver and fix issues uncovered while
updating cacheinfo for x86.

This is v5 of a patchset to fix the cache sysfs interface by setting the
number of cache leaves independently for each CPU. It includes a cosmetic
change and Reviewed-by tags from Andreas and Nikolay as well as Tested-by
tags from Andreas.

Previous versions can be found in [1], [2], [3], [4], and [5].

All the tests described in detail in [6] and [7] passed. This is the
summary:

  * /sys/devices/system/cpu/cpuX/cache is populated in Meteor Lake.
  * No inconsistencies are found in /sys/devices/system/cpu/cpuX/cache
    and the tools x86info, lstopo, and lscpu.
  * No splat is observed with and without CONFIG_PREEMPT_RT.
  * No new warnings/errors are seen the kernel log.
  * Tests done on assorted Intel and AMD client and server parts.

Changes since v5:
  * Reordered the arguments of set_num_cache_leaves().
  * Fixed wording on the subject of patch 2.
  * Added Reviewed-by tags from Andreas and Nikolay. Thanks!
  * Added Tested-by tags from Andreas. Thanks!

Changes since v4:
  * Combined two condition checks into one line. (Sudeep)
  * Added one more Reviewed-by tag from Sudeep. Thanks!

Changes since v3:
  * Fixed another NULL-pointer dereference when checking the validity of
    the last-level cache info.
  * Added the Reviewed-by tags from Radu and Sudeep. Thanks!
  * Rebased on v6.7-rc5.

Changes since v2:
  * This version uncovered a NULL-pointer dereference in recent changes to
    cacheinfo[8]. This dereference is observed when the system does not
    configure cacheinfo early during boot nor makes corrections later
    during CPU hotplug; as is the case in x86. Patch 1 fixes this issue.

Changes since v1:
  * Dave Hansen suggested to use the existing per-CPU ci_cpu_cacheinfo
    variable. Now the global variable num_cache_leaves became useless.
  * While here, I noticed that init_cache_level() also became useless:
    x86 does not need ci_cpu_cacheinfo::num_levels.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20230314231658.30169-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/all/20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/lkml/20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com/
[4]. https://lore.kernel.org/all/20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com/
[5]. https://lore.kernel.org/all/20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com/
[6]. https://lore.kernel.org/lkml/20230912032350.GA17008@ranerica-svr.sc.intel.com/
[7]. https://lore.kernel.org/all/20240902074140.GA4179@alberich/
[8]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/

Ricardo Neri (4):
  cacheinfo: Check for null last-level cache info
  cacheinfo: Allocate memory during CPU hotplug if not done from the
    primary CPU
  x86/cacheinfo: Delete global num_cache_leaves
  x86/cacheinfo: Clean out init_cache_level()

 arch/x86/kernel/cpu/cacheinfo.c | 49 +++++++++++++++++----------------
 drivers/base/cacheinfo.c        |  8 ++++--
 2 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.34.1


