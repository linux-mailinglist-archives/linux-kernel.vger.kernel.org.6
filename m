Return-Path: <linux-kernel+bounces-327768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4217977AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9771F215FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887001D6C52;
	Fri, 13 Sep 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBFKZufq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FD1BC088
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215974; cv=none; b=M5JRJi28+S3w8AXDUIrJc5a2tdWOtWXAbZW0cO69FJ3cUt1khjZkkO57KRFRDOGdgn1CXyRm0gJC07Id1y6guU6D0xc9KwhvqbrGypAU/OzhHRIOMXRFgIxTAYp1e6CzM/I//ezN79kFXy46fpX2sWVltWr3U3td659ZFcIJFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215974; c=relaxed/simple;
	bh=2fmUbJ6U3YLyeOz6zA3YswHO1R2bk+kedIB2Kx8eg+w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XjWlK1ZkbI2ax7BOZacatQE5nbF0F/cn4gmqkbagmHc9FOqwCdUswp1J6oWzxpgPsi4olUNuhYr0KB8xKipscHhvhTWFvftrlWcXGuehNPbLyFlym/S6/c8F+5XpT57L3KmcVomUigWQFnE1IdAjyYP0nXqjeXve3Qympmv0IrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBFKZufq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726215973; x=1757751973;
  h=from:to:cc:subject:date:message-id;
  bh=2fmUbJ6U3YLyeOz6zA3YswHO1R2bk+kedIB2Kx8eg+w=;
  b=IBFKZufqAer/4ZUk7x3jmld/m+pAqjyR+QLuhfM2cVLfeCodSsNu14aZ
   TNTSNDc9nylJC7FVna4OGdl2S6IE3xLYc7wBorUjOVX0uTr4vQwl6H+xR
   ER8RquLx/5oe1h6qB73EPIMLtCF2eh8/22h36q1P/UA90J6BvL/3gKn++
   Uh/XNN0rigoBs3qK4cmy77RLwpimrksKr3z1go8NRY+t4JJ6UU/8l1mIw
   0NqRp7gGoek9+dH0u5888FMlIF1vWUrN/QQCh+RB4lzFZAabtiRfo1BaA
   dKicpIeJkd9IXO+b+yoqdGORjJT2TpDzl8b3r6lLb1LgmMZ85ZWO5vADq
   A==;
X-CSE-ConnectionGUID: q9FOIji7TECZ+POMrZxI9g==
X-CSE-MsgGUID: hTZDthIyQyO/lYvN23QPgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24977563"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24977563"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:26:12 -0700
X-CSE-ConnectionGUID: RhTE6q83Tam+H/CrJJCUCQ==
X-CSE-MsgGUID: vPvoDzp6SaOFHYC9+3QAtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68485422"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 13 Sep 2024 01:26:12 -0700
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
Subject: [PATCH v7 0/3] x86/cacheinfo: Set the number of leaves per CPU
Date: Fri, 13 Sep 2024 01:31:52 -0700
Message-Id: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

This is v7 of a patchset to fix the cache sysfs interface by setting the
number of cache leaves independently for each CPU. This version merges
patches 1 and 2 from v6 into one as Borislav suggested. It looked OK to
me to keep the Reviewed-by and Tested-by collected so far in the merged
patch as all feedback still applies and there were no code changes. I
hope reviewers are OK!

Previous versions can be found in [1], [2], [3], [4], [5], and [6].

Below is the (updated) cover letter from v6 for reference.

The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
if CPUs have different numbers of subleaves in CPUID 4. This is the case
of Intel Meteor Lake, which now is out in the world. Tools that rely on
sysfs (e.g., lstopo) fail.

Patches 2 and 3 fix the described issue on Meteor Lake. Patch 1 deals
with prework in the cacheinfo base driver to fix issues uncovered while
updating cacheinfo for x86.

All the tests described in detail in [7] and [8] passed. This is the
summary:

  * /sys/devices/system/cpu/cpuX/cache is populated in Meteor Lake.
  * No inconsistencies are found in /sys/devices/system/cpu/cpuX/cache
    and the tools x86info, lstopo, and lscpu.
  * No splat is observed with and without CONFIG_PREEMPT_RT.
  * No new warnings/errors are seen the kernel log.
  * Tests done on assorted Intel and AMD client and server parts.

Changes since v6:
  * Merged patches 1 and 2 into one. (Borislav)
  * Fixed an formatting issue in allocate_cache_info(). (Borislav)

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
    cacheinfo[9]. This dereference is observed when the system does not
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
[6]. https://lore.kernel.org/all/20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com/
[7]. https://lore.kernel.org/lkml/20230912032350.GA17008@ranerica-svr.sc.intel.com/
[8]. https://lore.kernel.org/all/20240902074140.GA4179@alberich/
[9]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/

Ricardo Neri (3):
  cacheinfo: Allocate memory during CPU hotplug if not done from the
    primary CPU
  x86/cacheinfo: Delete global num_cache_leaves
  x86/cacheinfo: Clean out init_cache_level()

 arch/x86/kernel/cpu/cacheinfo.c | 49 +++++++++++++++++----------------
 drivers/base/cacheinfo.c        | 11 +++++---
 2 files changed, 33 insertions(+), 27 deletions(-)

-- 
2.34.1


