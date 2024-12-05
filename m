Return-Path: <linux-kernel+bounces-433017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2959E52F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9E61660B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4863B1DB92A;
	Thu,  5 Dec 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqTXtOY3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA021D8E01
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395863; cv=none; b=RZyCKT4wSoJUxXORlZToKItVC2T6TUuJgIZgvs8o3LwjEC6n2UPZ3SRl/0V/5BBZwWmqzu1CpIyMr0VAO8WFCzjxu+VkeY42Kg8VdswHFOXftIDTB5Hhnt3l6BnCwIp167J6OGlP4KzaD6pdBTIy7/+luqb1eTzmNTRhHjgqet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395863; c=relaxed/simple;
	bh=DbO052KE/Uk1t0rWP5RDwZigDbWazHUaobXRIHNrGxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EPabaxwMKhVFhHQiAu3uoU02UiE2rv8YA2blNqtJWq97PGkf3/Bs6O/MFYVXVzBDoSbnCS3ktSlgfQzj+ZbKmKxRQPLfe3zCyUWGtlZWGC+xo1kDbXjSY09ha8cfDTUvjjaqpYWdZTF19hJ63mjVf7EKeBm4KmrmPBNZ2zi2zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqTXtOY3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733395861; x=1764931861;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DbO052KE/Uk1t0rWP5RDwZigDbWazHUaobXRIHNrGxM=;
  b=PqTXtOY3JtSDXjKISqfhIqfgM2NEfb5cUE7iVMfrZbN+thdu++RCRbP6
   dK9ErPhOdwGNhKfWPkRL6HQtBUyVX/UsLWAtI1OqwEZyzx16+PRPqWpNy
   qbx2byps6k5syJHVhzsQtGaO5wQZDXQjm6uQCDxlroaEgOA2nBxC+AuD2
   c4VJAlHIbyfllWR0mg5C/J+lGYdgb6ATl5/qeqf+kDT5SkMx+uHRnpAPm
   coWWnyaTGqu9tmNwiWcQs/zaPiI7YkuYWkEKHlPRIGVWAf5o20Wh6mJTb
   BE1Y2APK1bAmO14PzDAYO7ydTGP970ip1UKJWtHdlQOLxemCPEGkHDPaK
   Q==;
X-CSE-ConnectionGUID: znQ95UUURQO1FzkSoLmwmg==
X-CSE-MsgGUID: wLJeZ5RqTtaeWl/FaqXEAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51237736"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="51237736"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:50:59 -0800
X-CSE-ConnectionGUID: GEu/vHquSGKzyTU2H8uanA==
X-CSE-MsgGUID: XrliNH0sRkaIjIxiixQA0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="124878501"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Dec 2024 02:50:58 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJ9Rf-00045p-33;
	Thu, 05 Dec 2024 10:50:55 +0000
Date: Thu, 5 Dec 2024 18:49:58 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: arch/x86/kernel/apic/apic.c:2168: warning: Function parameter or
 member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
Message-ID: <202412051816.oA5fqwk9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: f8542a55499a69a859c84866b66f0df43933e563 x86/apic: Turn on static calls
date:   1 year, 4 months ago
config: x86_64-randconfig-076-20240105 (https://download.01.org/0day-ci/archive/20241205/202412051816.oA5fqwk9-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412051816.oA5fqwk9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412051816.oA5fqwk9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/apic/apic.c:2168: warning: Function parameter or member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
>> arch/x86/kernel/apic/apic.c:2168: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead


vim +2168 arch/x86/kernel/apic/apic.c

c4d58cbd158dc9 arch/x86/kernel/apic_64.c   Thomas Gleixner 2007-10-12  2157  
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2158  /**
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2159   * spurious_interrupt - Catch all for interrupts raised on unused vectors
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2160   * @regs:	Pointer to pt_regs on stack
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2161   * @vector:	The vector number
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2162   *
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2163   * This is invoked from ASM entry code to catch all interrupts which
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2164   * trigger on an entry which is routed to the common_spurious idtentry
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2165   * point.
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2166   */
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2167  DEFINE_IDTENTRY_IRQ(spurious_interrupt)
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10 @2168  {
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2169  	handle_spurious_interrupt(vector);
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2170  }
3c5e0267ec3e6e arch/x86/kernel/apic/apic.c Thomas Gleixner 2021-02-10  2171  

:::::: The code at line 2168 was first introduced by commit
:::::: 3c5e0267ec3e6ed7d3f1793273cbf0beb4f86a74 x86/apic: Split out spurious handling code

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

