Return-Path: <linux-kernel+bounces-207574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC37901908
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 02:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F524B217B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4003E3D8E;
	Mon, 10 Jun 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSz7qihF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11B15A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717979978; cv=none; b=BM7r6lazpA4STV95PhYlUtsDlOOsTHinzTTyp8fVJzLx/VCDSANbCYHZoh67aayXdvSxlMP8ufUKO9NcH/senvevThfJCBnxjgjnWJnxVkDefvXh0P0ZMqpS4tg+FwTjAz4KKF80ueoV7tmL6OZ9UEiqw6XoZJNUUdXPvWmiCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717979978; c=relaxed/simple;
	bh=waD4N4XEB7SeuiB+bDbo3csSeAsfiUzOoJfHZThocuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1iKGDzEEnIjsLSMw52hSMpoQDG6NSwFiuVPg8RqxcRPZcmjizpDcIY9fFePl1WbMqAH2uk7JIL7HZdDpgkm98YRAtEtnfKvpRlwrlM8Lt1GjYsDnDJZjKW9lx4TfwxBnIhojdF1T/eRyn6vqogPwYK0HdozUBno9Q+o1A4zwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSz7qihF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717979976; x=1749515976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=waD4N4XEB7SeuiB+bDbo3csSeAsfiUzOoJfHZThocuo=;
  b=XSz7qihFb9Ux2l+XTHbGmp1tEB5VTWrOVOVK9d7j5HsM9VqEGH/qKwwo
   LusDq8SIxFVSZpNusu6+CE3ynfOS/6kqly/AV9CxQJgDPuNga+gUWbslF
   PM3Ua4Ev7Y5vJXW31dsqnbwais3BedjrQCzZo66Iyz7EghfSoeQaehhxC
   G4Q9ImGsAdojwoyDdgMIOnkDIvIulubuNDz0HqR88z7UOo2Q75H/Dhf0A
   PnD+jg37y+0A7LZumS0SCQ6OThDHjAFqqWi2L17EUMU9T3DKF1zRD+hGe
   MA4PLsaZBnpZ8GdZ1i9ImuCXt+6SKJjksNLqtgPDjDxvwxnNc+pJz/fTu
   Q==;
X-CSE-ConnectionGUID: SbXBkiSJRn+8xUbFjJYwMw==
X-CSE-MsgGUID: NZ8kvDEwSlGhr+aO4w5gIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="37154956"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="37154956"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 17:39:35 -0700
X-CSE-ConnectionGUID: EaSIL/wER2a+RZJ90UDvAA==
X-CSE-MsgGUID: RII/kgt4QsyOrjGd56fy/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="38829874"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 17:39:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 0/4] Add and use get_cpu_cacheinfo_level()
Date: Sun,  9 Jun 2024 17:39:23 -0700
Message-ID: <20240610003927.341707-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper function came up in discussion of the resctrl patches
for Sub-NUMA Cluster (SNC) support. Reinette pointed out[1] that there
are already two places where it would clean things up by avoiding
open coding. The SNC patches will add two additional call sites.

So rather than have this jammed up as part of the SNC series, I'm
posting it as a simple standalone cleanup.

Signed-off-by: Tony Luck <tony.luck@intel.com>

[1] https://lore.kernel.org/all/050c64b3-20b3-4db6-b782-f5124ebaab31@intel.com/

---
Changes since v3:
Link: https://lore.kernel.org/all/20240606164047.318378-1-tony.luck@intel.com/

Addition of lockdep_assert_cpus_held() in v3 led to #include hell
because <linux/cacheinfo.h> needed <linux/cpu.h>

Patch 1 resolves this hell by cut-and-pasting all the CPU hotplug
defintions out of cpu.h and into a new file cpuhplock.h.

Patch 2 brings the pasted code up to current coding standards

Patch 3 is the previous patch 1, but adds <linux/cpuhplock.h> instead
of <linux/cpu.h> to <linux/cacheinfo.h>

Patch 4 is the previous patch 2, unchanged.

Tony Luck (4):
  cpu: Move CPU hotplug function declarations into their own header
  cpu: Drop "extern" from function declarations in cpuhplock.h
  cacheinfo: Add function to get cacheinfo for a given (cpu, cachelevel)
  x86/resctrl: Replace open code cacheinfo searches

 include/linux/cacheinfo.h                 | 25 +++++++++---
 include/linux/cpu.h                       | 33 +---------------
 include/linux/cpuhplock.h                 | 47 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 17 +++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++----
 5 files changed, 79 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/cpuhplock.h


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.45.0


