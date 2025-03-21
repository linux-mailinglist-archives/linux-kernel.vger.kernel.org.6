Return-Path: <linux-kernel+bounces-571568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF24A6BEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62BD3BA18A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867122424E;
	Fri, 21 Mar 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVxc3JCV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9E78F51
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572557; cv=none; b=XScsKDnzrEZvCm9X1kJHF9MaTo3DxfCmbodNP/N6fopznj457PtRtIXRkkLxVJMXWg0BTWt05UGFvxMpl8L7kH4o4TTGo3hYid7aPxemjy1IN2RrxSDXBflmbwCO9xmVHn/WunYvdwTJ9GFWRqPiClS39+PS7jQVH3H1YF5yhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572557; c=relaxed/simple;
	bh=vQnCikzxwnaqeqF+Y3cBEBMNGEZaPJLE+R+RGfgHmFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O6zg2eZFOY5dmuJLTaFygH/XHFpxf95Xa3K98CWdkGnxCgAXb5A4PxLLQwOmDtBxCvQup5ZPj5w5mT89CAdgSmr57sTfzCWtSTyYVpokHPKYTDzwcsCYen8T1TXw43R9TW5p3TQfIi7lsqSJlRjtvMPECYns8BDyq2euhm0Zpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVxc3JCV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742572556; x=1774108556;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vQnCikzxwnaqeqF+Y3cBEBMNGEZaPJLE+R+RGfgHmFU=;
  b=aVxc3JCVW3RcUomVQTjPabi26Yx0QXiJCThvdqO9XWTXjbkTrGN3NcUs
   jiMpbnwXD2cDE23qMOCTzOjHBlllSwjF6YAZ866Ncem6M3tthHHiAlaoZ
   X1DCuaivHo2KqkC05P86pKFS5mJ6b6VB+HjyDbA05Y16sq1wxqhCfack6
   4JP6UuFC7ey0MAUiIMcUAPsnNQyQcphBl89mIQ5sZ5w2UDiypkkYXk4w5
   w7UpwoLMnos8fa/Xu1AXZF2msHCxm9/LxbM/0FcbfU4Uw3Rgxbna0tB9z
   7lh8ax1xULujPlwBYam/pAEgOemh4t6JQOkbGBeYunxZq3qKWaf2HYMFq
   A==;
X-CSE-ConnectionGUID: 2s8Stx7cSYmztPMqMqQfgw==
X-CSE-MsgGUID: JLIgDmbJRRCYHa1ccRJ2rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="46590969"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="46590969"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:55:55 -0700
X-CSE-ConnectionGUID: HxeCHtJ+QI2hYrPtdxmtFw==
X-CSE-MsgGUID: TkiRYomaRtqj8Aa0uFQB4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="160667141"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 21 Mar 2025 08:55:53 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tveir-0001S0-0V;
	Fri, 21 Mar 2025 15:55:49 +0000
Date: Fri, 21 Mar 2025 23:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:master 10/26] vmlinux.o: error: objtool: handle_bug+0x160: call
 to ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202503212305.DYXE8Njq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
head:   0ad3bae1c2d2da72845bae5e8703c86425ef7e43
commit: 3e87b3b74e9c3ee3b978d1371fcdb67d42c54b60 [10/26] Merge branch into tip/master: 'objtool/core'
config: x86_64-randconfig-077-20250321 (https://download.01.org/0day-ci/archive/20250321/202503212305.DYXE8Njq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503212305.DYXE8Njq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503212305.DYXE8Njq-lkp@intel.com/

All errors (new ones prefixed by >>):

   vmlinux.o: error: objtool: do_syscall_64+0x4b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   do_syscall_64+0x25: (alt)
   vmlinux.o: error: objtool:   do_syscall_64+0x349: (branch)
   vmlinux.o: error: objtool:   do_syscall_64+0x1b: (alt)
   vmlinux.o: error: objtool:   do_syscall_64+0x0: <=== (sym)
   vmlinux.o: error: objtool: do_int80_emulation+0x30: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   do_int80_emulation+0x0: <=== (sym)
   vmlinux.o: error: objtool: fred_int80_emulation+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fred_int80_emulation+0x14: (alt)
   vmlinux.o: error: objtool:   fred_int80_emulation+0x0: <=== (sym)
   vmlinux.o: error: objtool: do_fast_syscall_32+0x59: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   do_fast_syscall_32+0x35: (branch)
   vmlinux.o: error: objtool:   do_fast_syscall_32+0x0: <=== (sym)
   vmlinux.o: error: objtool: fred_hwexc.constprop.0+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fred_hwexc.constprop.0+0x0: <=== (sym)
   vmlinux.o: error: objtool: fred_extint.constprop.0+0x35: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fred_extint.constprop.0+0x0: <=== (sym)
   vmlinux.o: error: objtool: fred_entry_from_user+0xd3: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fred_entry_from_user+0x4d: (branch)
   vmlinux.o: error: objtool:   fred_entry_from_user+0x29: (branch)
   vmlinux.o: error: objtool:   fred_entry_from_user+0x0: <=== (sym)
   vmlinux.o: error: objtool: fred_entry_from_kernel+0x63: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fred_entry_from_kernel+0x25: (branch)
   vmlinux.o: error: objtool:   fred_entry_from_kernel+0x0: <=== (sym)
   vmlinux.o: error: objtool: __wrgsbase_inactive+0x76: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   __wrgsbase_inactive+0xd: (branch)
   vmlinux.o: error: objtool:   __wrgsbase_inactive+0x0: <=== (sym)
   vmlinux.o: error: objtool: __rdgsbase_inactive+0x77: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   __rdgsbase_inactive+0xd: (branch)
   vmlinux.o: error: objtool:   __rdgsbase_inactive+0x0: <=== (sym)
>> vmlinux.o: error: objtool: handle_bug+0x160: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: error: objtool:   handle_bug+0x4d: (branch)
   vmlinux.o: error: objtool:   handle_bug+0x13d: (branch)
   vmlinux.o: error: objtool:   handle_bug+0x33: (branch)
>> vmlinux.o: error: objtool:   handle_bug+0x0: <=== (sym)
   vmlinux.o: error: objtool: exc_debug_user+0x2f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   exc_debug_user+0x0: <=== (sym)
   vmlinux.o: error: objtool: fixup_bad_iret+0x92: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fixup_bad_iret+0x0: <=== (sym)
   vmlinux.o: error: objtool: exc_nmi+0x27: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   exc_nmi+0x0: <=== (sym)
   vmlinux.o: error: objtool: fred_exc_nmi+0x23: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fred_exc_nmi+0x0: <=== (sym)
   vmlinux.o: error: objtool: poke_int3_handler+0x3b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   poke_int3_handler+0x0: <=== (sym)
   vmlinux.o: error: objtool: native_sched_clock+0x76: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   native_sched_clock+0x4: (alt)
   vmlinux.o: error: objtool:   native_sched_clock+0x0: <=== (sym)
   vmlinux.o: error: objtool: __static_call_update_early+0x27: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   __static_call_update_early+0x0: <=== (sym)
   vmlinux.o: error: objtool: mce_check_crashing_cpu+0x1b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   mce_check_crashing_cpu+0x0: <=== (sym)
   vmlinux.o: error: objtool: do_machine_check+0x68: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   do_machine_check+0x0: <=== (sym)
   vmlinux.o: error: objtool: exc_machine_check+0x5b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   exc_machine_check+0x2b: (branch)
   vmlinux.o: error: objtool:   exc_machine_check+0xd: (alt)
   vmlinux.o: error: objtool:   exc_machine_check+0x0: <=== (sym)
   vmlinux.o: error: objtool: fred_exc_machine_check+0x76: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   fred_exc_machine_check+0x42: (branch)
   vmlinux.o: error: objtool:   fred_exc_machine_check+0x29: (branch)
   vmlinux.o: error: objtool:   fred_exc_machine_check+0xb: (alt)
   vmlinux.o: error: objtool:   fred_exc_machine_check+0x0: <=== (sym)
   vmlinux.o: error: objtool: pvclock_clocksource_read_nowd+0x7f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   pvclock_clocksource_read_nowd+0x10c: (branch)
   vmlinux.o: error: objtool:   pvclock_clocksource_read_nowd+0x140: (branch)
   vmlinux.o: error: objtool:   pvclock_clocksource_read_nowd+0x107: (branch)
   vmlinux.o: error: objtool:   pvclock_clocksource_read_nowd+0x3c: (branch)
   vmlinux.o: error: objtool:   pvclock_clocksource_read_nowd+0x1d: (alt)
   vmlinux.o: error: objtool:   pvclock_clocksource_read_nowd+0x0: <=== (sym)
   vmlinux.o: error: objtool: local_clock_noinstr+0x43: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   local_clock_noinstr+0x1d: (alt)
   vmlinux.o: error: objtool:   local_clock_noinstr+0x6: (branch)
   vmlinux.o: error: objtool:   local_clock_noinstr+0x0: <=== (sym)
   vmlinux.o: error: objtool: irqentry_nmi_enter+0x48: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   irqentry_nmi_enter+0x0: <=== (sym)
   vmlinux.o: error: objtool: irqentry_nmi_exit+0x4e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   irqentry_nmi_exit+0x95: (branch)
   vmlinux.o: error: objtool:   irqentry_nmi_exit+0x2f: (branch)
   vmlinux.o: error: objtool:   irqentry_nmi_exit+0x7d: (branch)
   vmlinux.o: error: objtool:   irqentry_nmi_exit+0xf: (branch)
   vmlinux.o: error: objtool:   irqentry_nmi_exit+0x0: <=== (sym)
   vmlinux.o: error: objtool: syscall_enter_from_user_mode_prepare+0x33: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   syscall_enter_from_user_mode_prepare+0xd: (alt)
   vmlinux.o: error: objtool:   syscall_enter_from_user_mode_prepare+0x0: <=== (sym)
   vmlinux.o: error: objtool: irqentry_enter_from_user_mode+0x33: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   irqentry_enter_from_user_mode+0xd: (alt)
   vmlinux.o: error: objtool:   irqentry_enter_from_user_mode+0x0: <=== (sym)
   vmlinux.o: error: objtool: irqentry_exit+0x8d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   irqentry_exit+0x15: (branch)
   vmlinux.o: error: objtool:   irqentry_exit+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_kernel_exit_state+0x25: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_kernel_exit_state+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_kernel_enter_state+0x25: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_kernel_enter_state+0x0: <=== (sym)
   vmlinux.o: error: objtool: context_tracking_recursion_enter+0x9c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   context_tracking_recursion_enter+0x2d: (branch)
   vmlinux.o: error: objtool:   context_tracking_recursion_enter+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_kernel_enter.constprop.0+0x14: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_kernel_enter.constprop.0+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_idle_exit+0x30: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_idle_exit+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_kernel_exit.constprop.0+0x3b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_kernel_exit.constprop.0+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_idle_enter+0x14: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_idle_enter+0x0: <=== (sym)
   vmlinux.o: error: objtool: __ct_user_enter+0xf6: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   __ct_user_enter+0x14: (branch)
   vmlinux.o: error: objtool:   __ct_user_enter+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_nmi_enter+0x32: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_nmi_enter+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_irq_enter+0x60: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_irq_enter+0xd: (branch)
   vmlinux.o: error: objtool:   ct_irq_enter+0x0: <=== (sym)
   vmlinux.o: error: objtool: ct_irq_exit+0x60: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   ct_irq_exit+0xd: (branch)
   vmlinux.o: error: objtool:   ct_irq_exit+0x0: <=== (sym)
   vmlinux.o: error: objtool: check_preemption_disabled.constprop.0+0x21: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   check_preemption_disabled.constprop.0+0x0: <=== (sym)
   vmlinux.o: error: objtool: mwait_idle+0x28: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   mwait_idle+0x0: <=== (sym)
   vmlinux.o: error: objtool: acpi_processor_ffh_cstate_enter+0x78: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   acpi_processor_ffh_cstate_enter+0x4c: (alt)
   vmlinux.o: error: objtool:   acpi_processor_ffh_cstate_enter+0x40: (alt)
   vmlinux.o: error: objtool:   acpi_processor_ffh_cstate_enter+0x10f: (branch)
   vmlinux.o: error: objtool:   acpi_processor_ffh_cstate_enter+0x35: (branch)
   vmlinux.o: error: objtool:   acpi_processor_ffh_cstate_enter+0x123: (branch)
   vmlinux.o: error: objtool:   acpi_processor_ffh_cstate_enter+0x23: (branch)
   vmlinux.o: error: objtool:   acpi_processor_ffh_cstate_enter+0x0: <=== (sym)
   vmlinux.o: error: objtool: intel_idle+0x63: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: error: objtool:   intel_idle+0x37: (alt)
   vmlinux.o: error: objtool:   intel_idle+0x2b: (alt)
   vmlinux.o: error: objtool:   intel_idle+0xe1: (branch)
   vmlinux.o: error: objtool:   intel_idle+0x17: (branch)
   vmlinux.o: error: objtool:   intel_idle+0x0: <=== (sym)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

