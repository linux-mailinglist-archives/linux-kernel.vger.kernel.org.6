Return-Path: <linux-kernel+bounces-408468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508C9C7F30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3A61F2296D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A544C148;
	Thu, 14 Nov 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9UU1Bbj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F42F46;
	Thu, 14 Nov 2024 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543441; cv=none; b=b/daP/PZMd2uaTaUEOEUbx77jra8l5xrsNQJFRHTrlpo0Tw+nsqPqChnovXXu4RVtlPrstR7f3L0WroT8jeDtCohF63ot/TQfR8YzO4miHTuI3BXzmt96qA8G7rkM9vVdUv7PYWq8pde8SK20k/9IEq5bQDaUqkl2i0FyhyLk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543441; c=relaxed/simple;
	bh=wG+C2i7AjVhz6G1Ml7Nh9i0jXeC0kh+g8h7fbiBN2b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8+jD0oSBuqb9WD1ooJMTPhug1SgRBkLt2LwNDruRqNdFdpqaatdqw5ysmnQag/AKq/3OLpesCQOx89olOnlqWU2rTwjk41A20e9q+rEx9YUYBbpx9aMZRlayN+zxRDcGiIb/ZF+OKUnnG9Hjq702H740/DTEUx+J3rOfFm4y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9UU1Bbj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731543439; x=1763079439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wG+C2i7AjVhz6G1Ml7Nh9i0jXeC0kh+g8h7fbiBN2b4=;
  b=f9UU1Bbjvjo4sfDUIV0/Ycx6ccW9gE+wFl0pj982FGPLHb2kJnjuJBiG
   gK09VEka1gYsZel/aD8KJkfw9NoT5ruxqehS8E1erXC/SnqqbEcL6Fda9
   QOf4IpBhQJT2dJBq1UGoAae4/slPwhdy64U4SEUuk7n1+nU4+k9DnjhgE
   iLq0tRw0ywNQzvtH1nahBVEzdhA8IwhPGvIA7Eexlvn7KU++sHOCc5MFz
   vfBzP8L1uKPhCifiZ6YQyf88PrfoFRBbALSEXyO4WJg+WerOukSGL6D/5
   Wmr4/dV2YO4XhCq/92LCHhvkxF9qj6mXGFJ9o1lteeYYA7vmJbnR3JZlu
   g==;
X-CSE-ConnectionGUID: Isy5FPV4SsOKLFgQnVuq5A==
X-CSE-MsgGUID: GeCLgkVVQZmrZ3wnBxoUFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30869450"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="30869450"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:18 -0800
X-CSE-ConnectionGUID: DVud6nHeQ3yJseNgLLT7KQ==
X-CSE-MsgGUID: UcZ83RHdSgetHfbO973ARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92081148"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:18 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 0/9] x86/resctrl: mba_MBps enhancement
Date: Wed, 13 Nov 2024 16:17:02 -0800
Message-ID: <20241114001712.80315-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to choose the memory monitor bandwidth event independently
for each ctrl_mon group when resctrl is mounted with the mba_MBps
option. Users may want this for applications that are not localized to
NUMA boundaries.  Default behavior still uses local memory bandwidth
when that event is supported by the platform.

Side benefit[0]: Systems that do not support the local bandwidth monitor
event but do support the total bandwidth event can now use the mba_MBps
mount option.

Changes since v8:
Link: https://lore.kernel.org/all/20241029172832.93963-1-tony.luck@intel.com

Patch(es):	Change
1:		New to this series. Almost direct copy from Babu's patch6
		in the ABMC series. Only change is to drop the __init
		from resctrl_file_fflags_init() because I need to use it
		at runtime for mount/unmount.

2:		Was patch 1
		Fenghua: Use is_mbm_local_enabled() instead of open
			 coded bit check.
		Reinette: Fix comment for @mba_mbps_event
			  Move check for local event after check for any event
			  Move initialization of rdtgroup_default.mba_mbps_event
			  into rdtgroup_setup_default() and make it conditional
			  on is_mbm_local_enabled().
			  Move initialization of rdtgrp->mba_mbps_event inside
			  "if (resctrl_arch_mon_capable())" and make it
			  conditional on is_mba_sc(NULL).
		Tony: Moved the fallback to total bandwidth to later in
		      series until all code is changed to cope with total.

3-4:		Was 2-3
		Reinette: Shuffled the pieces of these two patches to
			  flow better.
		Fenghue: Don't drop the comment when refactoring, but do
			 update a little.

5:		Was 4. No change.

6:		Was 5.
		Reinette: Expand commit change log
			  Fix rdtgroup_mba_mbps_event_show() to return -ENOENT
			  if rdtgrp isn't found.
			  Add pr_warn_once() to cover default case in switch.
			  File mode of mba_MBps_event 0444 in this patch.
			  Initialize .fflags to "RFTYPE_CTRL_BASE | RFTYPE_MON_BASE"
			  using Babu's resctrl_file_fflags_init() helper
			  instead of adding mba_mbps_event_init() function.

7:		Was 6.
		Reinette: Expand commit change log
			  Just use "Unsupported event" event for all invalid
			  user input instead of separate messages for
			  different problems.
			  Use this patch to switch mode from 0444 to 0644

8:		New. Moved the fallback to total bandwidth to this patch.

9:		No change. I punted on trying to explain the perils of
		users rapidly switching between mba_sc events.

[0] My original objective!

Babu Moger (1):
  x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags

Tony Luck (8):
  x86/resctrl: Prepare for per-ctrl_mon group mba_MBps control
  x86/resctrl: Modify update_mba_bw() to use per ctrl_mon group event
  x86/resctrl: Compute memory bandwidth for all supported events
  x86/resctrl: Relax checks for mba_MBps mount option
  x86/resctrl: Add "mba_MBps_event" file to ctrl_mon directories
  x86/resctrl: Add write option to "mba_MBps_event" file
  x86/resctrl: Make mba_sc use total bandwidth if local is not supported
  x86/resctrl: Document the new "mba_MBps_event" file

 Documentation/arch/x86/resctrl.rst        |  10 +++
 include/linux/resctrl.h                   |   2 +
 arch/x86/kernel/cpu/resctrl/internal.h    |   9 +-
 arch/x86/kernel/cpu/resctrl/core.c        |   9 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  70 +++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c     | 101 ++++++++++++----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  36 ++++----
 7 files changed, 173 insertions(+), 64 deletions(-)


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.47.0


