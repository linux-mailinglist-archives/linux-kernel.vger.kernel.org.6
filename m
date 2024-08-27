Return-Path: <linux-kernel+bounces-302605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4889600D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C9EB21B39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC95A4D5;
	Tue, 27 Aug 2024 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zgod9w/C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94F184E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735380; cv=none; b=XVMQDye/LfoDjRdxx/tvnZPYLRyvUNKeNn3X6CdC0Ov1gbG6LRIDeXb1HS/jZXBvQNwC1NBknnKdgDo8jEq4s2CymCNC7c8MqL7ZPkLwb0arA9CBKoZGhd/t46gdCqpkeFem0JabV8/PY2hkE35wNf9NzJgcyNSPoFq9xkxlVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735380; c=relaxed/simple;
	bh=lAnk49qArUXtVefQC8VXrILNgq93Waq9W75Cc70D3VU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=c5vfvjXFmCkI7aTkCOulfFqCrKw83Q4eP9Lir7VrmQ6gt0OHaoF3BdQOMF2i2tzyuH1zVB2YJF2/Vm/uoVTJRu5hZ4KhqizsQQExUFSouoo7Mw3VJz71DD+j7G9j942OztPZS//vOqrptPtWs/s+wvbkMjwC5rjA9YSz0ibnaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zgod9w/C; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724735378; x=1756271378;
  h=from:to:cc:subject:date:message-id;
  bh=lAnk49qArUXtVefQC8VXrILNgq93Waq9W75Cc70D3VU=;
  b=Zgod9w/CwRnGDMbQzIglZ2IcV1PMzCStR8eqdmcTg+lW+ib3zDYfNaNZ
   U16aQKmgDOQCeocLwPRWa3GhEyHQULDQcO8NpHBM3mOpWFDtEhYZDwYz7
   gwQeeFg9Rk+Ua5nrfLjlm+3RNFiBjNQ7Pf4n8wEF+5Gau+F9uBgzCsiUv
   yyKTad5/u8YGoQGlgjEMF7hXuYz7Hv9kXh6oIT/wpvpYZvUDg8OYMCQ9C
   4aQSASHGsTag+QhL5wyhIwo4M+LaoZuc0sqwrHpIIkcYn9sBXADLMtdO0
   sI0f+TZwHQxrlH5zJ1g2f4qTlB6Koh31kXmFPdQS2TkGOYdIyIs7ox5lT
   A==;
X-CSE-ConnectionGUID: rlFnk8UxSG6KvD0j3w8pkQ==
X-CSE-MsgGUID: PpcZGR7NTD6mw//g4KhbKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13230464"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="13230464"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:09:38 -0700
X-CSE-ConnectionGUID: D00ybYGgTeu5uzJnm/bYxg==
X-CSE-MsgGUID: nyye2PnhSxevTDe2Q/g4+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62703851"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 22:09:37 -0700
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
Subject: [PATCH v5 0/4] x86/cacheinfo: Set the number of leaves per CPU
Date: Mon, 26 Aug 2024 22:16:31 -0700
Message-Id: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
if CPUs have different numbers of subleaves in CPUID 4. This is the case
of Intel Meteor Lake, which now is out in the world.

This is v5 of a patchset to fix the cache sysfs interface by setting the
number of cache leaves independently for each CPU.

v1, v2, v3, and v4 can be found here[1], here[2], here[3], and here[4].

All the tests described in [5] passed.

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
    cacheinfo[6]. This dereference is observed when the system does not
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
[5]. https://lore.kernel.org/lkml/20230912032350.GA17008@ranerica-svr.sc.intel.com/
[6]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/

Ricardo Neri (4):
  cacheinfo: Check for null last-level cache info
  cacheinfo: Allocate memory for memory if not done from the primary CPU
  x86/cacheinfo: Delete global num_cache_leaves
  x86/cacheinfo: Clean out init_cache_level()

 arch/x86/kernel/cpu/cacheinfo.c | 49 +++++++++++++++++----------------
 drivers/base/cacheinfo.c        |  8 ++++--
 2 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.34.1


