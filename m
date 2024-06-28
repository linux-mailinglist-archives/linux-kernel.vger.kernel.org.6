Return-Path: <linux-kernel+bounces-234611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB991C8A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A84B20CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8380BF2;
	Fri, 28 Jun 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm1UqR2X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C196278C9D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611788; cv=none; b=p/T4iz2xpigOZzmJI0M6Tqu5hCECzzqP7mdIlUZZ5SFmyWVQmUdxa0E4Ju+WjeOFKZTkqHK1P0fII1o/OtqNtHDZxRs6NkCW0hc47KcJpwhwLCH6lLGOZiSpeBaMPTFwusnTmKmSYShYX9yQaP6fzwtCWf2LZiKv4nUS+xqzQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611788; c=relaxed/simple;
	bh=VALfNi/4TVa/iaQqSjXTociderrHdkMJNYdcIRqCWUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uW2C/83RtQa3m1pZMlrQZjaXLM4edFIbTrLaz5Z6iOTxca19LYmJstrfEfeuSBWtYj1N9LzThW+LpEvTlge3ruTHixRnebldQfPOPIsDoWVp2kzpo+1YmK60pcHJTO3dxO//JIQ74VPIrS/CsyqKu9QYF30AQVPRlVF2Od5lZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm1UqR2X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611787; x=1751147787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VALfNi/4TVa/iaQqSjXTociderrHdkMJNYdcIRqCWUM=;
  b=nm1UqR2X6fZy7CfL1T9Y2Qt/NmR4AO+7zjzJFdmqVcO0yQ67BBKWUBrF
   qrVJzwwsY3M9tVZdt1i7L9JWO77q0KM3VdQjf57ALWL3d94eJMqM4klOA
   vtqQeVf/CnRfEYcQ4aYQodFH8Uec5s+2gLL4+vQKex//TdBVMUfV6XgxL
   xCJDAvRv7ZP5+IwJE+8GtDmMKaYxlqgxA+CPE3blk/HiusPBj2p7L6YWp
   SfNmfn4JfG9jWeFG9KhwInvBmWzpjGniMG7zRyKwJeZFwW6bRC2+kpyeK
   RkP/pOGdi4z8h9ETyU/aMYTelhmr6WVSDcoEFY5RgPoxxJzJYrv/1wO3D
   A==;
X-CSE-ConnectionGUID: uXcamtavTy28tNNnrshucA==
X-CSE-MsgGUID: E/fDX1c1TIeSwyr95wZsxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762525"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762525"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:26 -0700
X-CSE-ConnectionGUID: Gin8q+5MRo2MUMhK1EK/+A==
X-CSE-MsgGUID: 8ZAuzHCfRPSgQl2M43QS8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065633"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:26 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v23 00/19] Add support for Sub-NUMA cluster (SNC) systems
Date: Fri, 28 Jun 2024 14:56:00 -0700
Message-ID: <20240628215619.76401-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series based on top of tip x86/cache commit f385f0246394
("x86/resctrl: Replace open coded cacheinfo searches")

The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
that share an L3 cache into two or more sets. This plays havoc with the
Resource Director Technology (RDT) monitoring features.  Prior to this
patch Intel has advised that SNC and RDT are incompatible.

Some of these CPUs support an MSR that can partition the RMID counters
in the same way. This allows monitoring features to be used. Legacy
monitoring files provide the sum of counters from each SNC node for
backwards compatibility. Additional  files per SNC node provide details
per node.

Memory bandwidth allocation features continue to operate at
the scope of the L3 cache.

L3 cache occupancy and allocation operate on the portion of
L3 cache available for each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Changes since v21: https://lore.kernel.org/all/20240627203856.66628-1-tony.luck@intel.com/

No net code changes (final version v23 == v22)

* Patch 9 split into two (9 & 10 in this series) Added Reinette's Reviewed-by tag to both.
* Added Reinette's Reviewed-by tag to parts 15 & 16 (were 14, 15 in v22)

Tony Luck (19):
  x86/resctrl: Prepare for new domain scope
  x86/resctrl: Prepare to split rdt_domain structure
  x86/resctrl: Prepare for different scope for control/monitor
    operations
  x86/resctrl: Split the rdt_domain and rdt_hw_domain structures
  x86/resctrl: Add node-scope to the options for feature scope
  x86/resctrl: Introduce snc_nodes_per_l3_cache
  x86/resctrl: Block use of mba_MBps mount option on Sub-NUMA Cluster
    (SNC) systems
  x86/resctrl: Prepare for new Sub-NUMA Cluster (SNC) monitor files
  x86/resctrl: Add a new field to struct rmid_read for summation of
    domains
  x86/resctrl: Initialize on-stack struct rmid_read instances
  x86/resctrl: Refactor mkdir_mondata_subdir() with a helper function
  x86/resctrl: Allocate a new field in union mon_data_bits
  x86/resctrl: Create Sub-NUMA Cluster (SNC) monitor files
  x86/resctrl: Handle removing directories in Sub-NUMA Cluster (SNC)
    mode
  x86/resctrl: Fill out rmid_read structure for smp_call*() to read a
    counter
  x86/resctrl: Make __mon_event_count() handle sum domains
  x86/resctrl: Enable shared RMID mode on Sub-NUMA Cluster (SNC) systems
  x86/resctrl: Sub-NUMA Cluster (SNC) detection
  x86/resctrl: Update documentation with Sub-NUMA cluster changes

 Documentation/arch/x86/resctrl.rst        |  27 ++
 include/linux/resctrl.h                   |  88 ++++--
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    | 108 +++++---
 arch/x86/kernel/cpu/resctrl/core.c        | 312 ++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  89 +++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 256 +++++++++++++++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  27 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 281 ++++++++++++-------
 9 files changed, 865 insertions(+), 324 deletions(-)


base-commit: f385f024639431bec3e70c33cdbc9563894b3ee5
-- 
2.45.2


