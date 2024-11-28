Return-Path: <linux-kernel+bounces-424063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D49DB031
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75C0B21BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9F9460;
	Thu, 28 Nov 2024 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBrvkoKq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279517FE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752961; cv=none; b=Dqr8x1apjx7faHR0b7r4hbZ+4ues+UUyA5G3CiSiJiJ0w1BzjHQB6qN77maLk+rzNMiuPBqAroyRbvSjPCyD5Q8+6IS8FffCXtj89qZMgzwzby1+Qt/UzfcUO2vpThMgsFDyaHtbh+9SU9bw+CO9RNUof1BQG9tpYZsJ018SvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752961; c=relaxed/simple;
	bh=WTfpgCdZwvt2jTzEPwzhCjCKD93TH5wqSpPFoZZZg48=;
	h=From:To:Cc:Subject:Date:Message-Id; b=e8d15npZNzSk8vhUJJgom8NqLnXJ4acT5CQQJdzNuEv4ie0FIW+GN0sDprwBKmiU1OrWFF+Re6C5ViooDa1wrWUbGr6z16pvbSR2U1dCJoDmC+SNmEx3s/z4ogmZCSLF8SlSE7cGLlmFXpwzU1aeF1ua4LQx711AzIXxbEilAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBrvkoKq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732752960; x=1764288960;
  h=from:to:cc:subject:date:message-id;
  bh=WTfpgCdZwvt2jTzEPwzhCjCKD93TH5wqSpPFoZZZg48=;
  b=CBrvkoKqkbIKxiRRwV/fT5tIUTcHSrl83go4k0BeE8imyWBgUU52jqam
   RMJrq3qQj1QSxVaN+w9IhEwc6f8yN4ZkXCI/pUwjvD3YkAYioNq6gjQOm
   3WxXJJjfH28DU0Pg4cCzNoauaFIxX6S8wLK2sxodbrbHa9+mldHzV4N6Y
   qfIgV4niTkcUOvprcMIOOaprYSs5kaPfDM/LvB49Qifm4LaAq/uhUfNgN
   7+v5p6btSmiKs3Wrk9iGl6rs4EI3CnLrbsLxLDfOUya/MRsGtB2TZVK99
   GJt0EhWNykVjTTTZqmZHpeZgYmPJF3OeJpmf2VIhUAUH6DCoOavYlxLqD
   Q==;
X-CSE-ConnectionGUID: 8W/VfgWGRr+QIwHNPrRdww==
X-CSE-MsgGUID: nsucFAzeS6OG2UBAyVTdwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43464067"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="43464067"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 16:15:59 -0800
X-CSE-ConnectionGUID: 83l76MD3Q4yAtsg7mrZUuQ==
X-CSE-MsgGUID: aro3XhY6TemagMgrWNoXvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="96173983"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP; 27 Nov 2024 16:15:59 -0800
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
Subject: [PATCH v8 0/2] x86/cacheinfo: Set the number of leaves per CPU
Date: Wed, 27 Nov 2024 16:22:45 -0800
Message-Id: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

This is v8 of a patchset to fix the cache sysfs interface by setting the
number of cache leaves independently for each CPU. This version merges
patches 2 and 3 from v7 into one as Borislav suggested. I also dropped
the wrappers functions I had added to access per-CPU cache info
(ci_cpu_cacheinfo).

It looked OK to me to keep the Reviewed-by and Tested-by tags collected
so far as all feedback still applies and changes were minor. I hope
reviewers are OK!

Previous versions can be found in [1], [2], [3], [4], [5], [6], and [7].

Below is the (updated) cover letter from v6 for reference:

The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
if CPUs have different numbers of subleaves in CPUID 4. This is the case
of Intel Meteor Lake, which now is out in the world. Tools that rely on
sysfs (e.g., lstopo) fail.

Patch 2 fixes the described issue on Meteor Lake. Patch 1 deals with
prework in the cacheinfo base driver to fix issues uncovered while updating
cacheinfo for x86.

All the tests described in detail in [8] and [9] passed. This is the
summary:

  * /sys/devices/system/cpu/cpuX/cache is populated in Meteor Lake.
  * No inconsistencies are found in /sys/devices/system/cpu/cpuX/cache
    and the tools x86info, lstopo, and lscpu.
  * No splat is observed with and without CONFIG_PREEMPT_RT.
  * No new warnings/errors are seen the kernel log.
  * Tests done on assorted Intel and AMD client and server parts.

Changes since v7:
 * Merged patches 2/3 into one. (Borislav)
 * Dropped wrapper functions for ci_cpu_cacheinfo. (Borislav)
 * Check for zero cache leaves in init_cache_level() for x86.
   (Borislav)
 * Removed an ugly line break. (Borislav)

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
    cacheinfo[10]. This dereference is observed when the system does not
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
[7]. https://lore.kernel.org/all/20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com/
[8]. https://lore.kernel.org/lkml/20230912032350.GA17008@ranerica-svr.sc.intel.com/
[9]. https://lore.kernel.org/all/20240902074140.GA4179@alberich/
[10]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/

Ricardo Neri (2):
  cacheinfo: Allocate memory during CPU hotplug if not done from the
    primary CPU
  x86/cacheinfo: Delete global num_cache_leaves

 arch/x86/kernel/cpu/cacheinfo.c | 41 +++++++++++++++------------------
 drivers/base/cacheinfo.c        | 11 +++++----
 2 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.34.1


