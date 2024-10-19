Return-Path: <linux-kernel+bounces-372864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223089A4E86
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068601C2151A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A74138FB0;
	Sat, 19 Oct 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XacNuF7u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B351E519
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347159; cv=none; b=AY17P9NeNXDZ9shBE+qSNEASGbrVmXICUMjDDmj7sFhiRwqHgIqSw4xYb5qZnhs7lIE+wd4BJNTTQDVcvYS8hJMuI4WVr9S54QSBjUKrI8JYI9p+7LkGwnx3vbObgrYKKYHlZ+3oV4EwR1lE+egaltcpgbV4dvwbDG8Kap2OPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347159; c=relaxed/simple;
	bh=ikxsOS9//BIRhrEbwkUMCVoClNlS/zW9Wh6XXzfhBbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EBnATAW1jlMihskcCCdXyevC9EMF/Ch6Wxg20LHhs/kD08IPLcJ7YyskX3L+XbUJdN6//VVQZgN43Dtmdbufjih0vi5uw51fJKDvuyUEe6o/Q7oZewtDBPm6Y2yPfU6RZ6dpD0OY6uBoCSjcusMXk2hVAG9xg2r4BJlYHgADnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XacNuF7u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729347156; x=1760883156;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ikxsOS9//BIRhrEbwkUMCVoClNlS/zW9Wh6XXzfhBbU=;
  b=XacNuF7uWauLzOravbxaFQZlGrf5h7+viL+x3fF6q6ohIHvUvnvIRsJz
   6QGBuMrV6Mz0rKF6S+y93KqXNjtqVKp856R7Mf+TzjRLhUoGl5jTbmOQX
   RTV10zxJXMxqLnq5/aphp4WfRNi+n/sPkCD+M2MtvrKvNbkM2qihiIX/J
   qZ1J1tIRibIR0oWUBkZXoLpFVA2P7Qe0mC7hrWzyb26h+17ETEZe+oZZL
   csYy9NfZSElf1jn3qY9zo4D+6zeFV8P5c/bKWCrRni9wDCcdzKwv1aXwa
   PtJy7S7kLGcQOyOLBCj4OsJ77P+rmGdYeSm5Uf9liCVeDzXstfvhhw/N2
   g==;
X-CSE-ConnectionGUID: rraLd8n1QeC5SEYIvhOmWg==
X-CSE-MsgGUID: aputeWxdSuml6U7+YJ0F2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="40234591"
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="40234591"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 07:12:35 -0700
X-CSE-ConnectionGUID: IBkD6bFfTxCsO1QHrpE92Q==
X-CSE-MsgGUID: 1fM7OApbSJSVY8k393r61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="109875642"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Oct 2024 07:12:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2ABz-000P3N-32;
	Sat, 19 Oct 2024 14:12:31 +0000
Date: Sat, 19 Oct 2024 22:12:01 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/xen/enlighten_pv.c:1407:28: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202410192244.k4KFmVBy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
commit: 11e36b0f7c2150a6453872b79555767b43c846d0 x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]
date:   8 months ago
config: x86_64-randconfig-122-20241019 (https://download.01.org/0day-ci/archive/20241019/202410192244.k4KFmVBy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410192244.k4KFmVBy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410192244.k4KFmVBy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/xen/enlighten_pv.c:1407:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/xen/enlighten_pv.c:1407:28: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/xen/enlighten_pv.c:1407:28: sparse:     got struct gdt_page *
   arch/x86/xen/enlighten_pv.c: note: in included file (through arch/x86/include/asm/stackprotector.h, include/linux/stackprotector.h):
   arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *

vim +1407 arch/x86/xen/enlighten_pv.c

8b87d8cec1b31e Peter Zijlstra   2022-03-08  1311  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1312  /* First C function to be called on Xen boot */
96e8fc5818686d Juergen Gross    2022-06-30  1313  asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1314  {
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1315  	struct physdev_set_iopl set_iopl;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1316  	unsigned long initrd_start = 0;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1317  	int rc;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1318  
96e8fc5818686d Juergen Gross    2022-06-30  1319  	if (!si)
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1320  		return;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1321  
96e8fc5818686d Juergen Gross    2022-06-30  1322  	clear_bss();
96e8fc5818686d Juergen Gross    2022-06-30  1323  
96e8fc5818686d Juergen Gross    2022-06-30  1324  	xen_start_info = si;
96e8fc5818686d Juergen Gross    2022-06-30  1325  
8b87d8cec1b31e Peter Zijlstra   2022-03-08  1326  	__text_gen_insn(&early_xen_iret_patch,
8b87d8cec1b31e Peter Zijlstra   2022-03-08  1327  			JMP32_INSN_OPCODE, &early_xen_iret_patch, &xen_iret,
8b87d8cec1b31e Peter Zijlstra   2022-03-08  1328  			JMP32_INSN_SIZE);
8b87d8cec1b31e Peter Zijlstra   2022-03-08  1329  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1330  	xen_domain_type = XEN_PV_DOMAIN;
1fe83888a2b776 Roger Pau Monne  2018-06-08  1331  	xen_start_flags = xen_start_info->flags;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1332  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1333  	xen_setup_features();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1334  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1335  	/* Install Xen paravirt ops */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1336  	pv_info = xen_info;
1462eb381b4c27 Peter Zijlstra   2021-06-24  1337  	pv_ops.cpu = xen_cpu_ops.cpu;
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1338  	xen_init_irq_ops();
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1339  
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1340  	/*
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1341  	 * Setup xen_vcpu early because it is needed for
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1342  	 * local_irq_disable(), irqs_disabled(), e.g. in printk().
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1343  	 *
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1344  	 * Don't do the full vcpu_info placement stuff until we have
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1345  	 * the cpu_possible_mask and a non-dummy shared_info.
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1346  	 */
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1347  	xen_vcpu_info_reset(0);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1348  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1349  	x86_platform.get_nmi_reason = xen_get_nmi_reason;
f1e525009493cb Juergen Gross    2022-11-23  1350  	x86_platform.realmode_reserve = x86_init_noop;
f1e525009493cb Juergen Gross    2022-11-23  1351  	x86_platform.realmode_init = x86_init_noop;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1352  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1353  	x86_init.resources.memory_setup = xen_memory_setup;
979923871f69a4 Thomas Gleixner  2020-01-23  1354  	x86_init.irqs.intr_mode_select	= x86_init_noop;
3b5244bef15e0e Juergen Gross    2023-08-08  1355  	x86_init.irqs.intr_mode_init	= x86_64_probe_apic;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1356  	x86_init.oem.arch_setup = xen_arch_setup;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1357  	x86_init.oem.banner = xen_banner;
7b25b9cb0dad83 Pavel Tatashin   2018-07-19  1358  	x86_init.hyper.init_platform = xen_pv_init_platform;
7b25b9cb0dad83 Pavel Tatashin   2018-07-19  1359  	x86_init.hyper.guest_late_init = xen_pv_guest_late_init;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1360  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1361  	/*
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1362  	 * Set up some pagetable state before starting to set any ptes.
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1363  	 */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1364  
0ce0bba4e5e0eb Juergen Gross    2018-07-12  1365  	xen_setup_machphys_mapping();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1366  	xen_init_mmu_ops();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1367  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1368  	/* Prevent unwanted bits from being set in PTEs. */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1369  	__supported_pte_mask &= ~_PAGE_GLOBAL;
e69b5d308da72c Juergen Gross    2018-07-02  1370  	__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1371  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1372  	/* Get mfn list */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1373  	xen_build_dynamic_phys_to_machine();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1374  
ae897fda4f507e Jan Beulich      2021-05-20  1375  	/* Work out if we support NX */
ae897fda4f507e Jan Beulich      2021-05-20  1376  	get_cpu_cap(&boot_cpu_data);
ae897fda4f507e Jan Beulich      2021-05-20  1377  	x86_configure_nx();
ae897fda4f507e Jan Beulich      2021-05-20  1378  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1379  	/*
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1380  	 * Set up kernel GDT and segment registers, mainly so that
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1381  	 * -fstack-protector code can be executed.
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1382  	 */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1383  	xen_setup_gdt(0);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1384  
405c018a25fe46 M. Vefa Bicakci  2018-07-24  1385  	/* Determine virtual and physical address sizes */
405c018a25fe46 M. Vefa Bicakci  2018-07-24  1386  	get_cpu_address_sizes(&boot_cpu_data);
405c018a25fe46 M. Vefa Bicakci  2018-07-24  1387  
42b3a4cb5609de Juergen Gross    2017-11-24  1388  	/* Let's presume PV guests always boot on vCPU with id 0. */
42b3a4cb5609de Juergen Gross    2017-11-24  1389  	per_cpu(xen_vcpu_id, 0) = 0;
42b3a4cb5609de Juergen Gross    2017-11-24  1390  
42b3a4cb5609de Juergen Gross    2017-11-24  1391  	idt_setup_early_handler();
42b3a4cb5609de Juergen Gross    2017-11-24  1392  
0808e80cb760de Juergen Gross    2017-04-13  1393  	xen_init_capabilities();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1394  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1395  	/*
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1396  	 * set up the basic apic ops.
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1397  	 */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1398  	xen_init_apic();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1399  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1400  	machine_ops = xen_machine_ops;
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1401  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1402  	/*
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1403  	 * The only reliable way to retain the initial address of the
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1404  	 * percpu gdt_page is to remember it here, so we can go and
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1405  	 * mark it RW later, when the initial percpu area is freed.
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1406  	 */
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14 @1407  	xen_initial_gdt = &per_cpu(gdt_page, 0);
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1408  
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1409  	xen_smp_init();
e1dab14cf68d1e Vitaly Kuznetsov 2017-03-14  1410  

:::::: The code at line 1407 was first introduced by commit
:::::: e1dab14cf68d1e03950135969af3faf322f0db04 x86/xen: split off enlighten_pv.c

:::::: TO: Vitaly Kuznetsov <vkuznets@redhat.com>
:::::: CC: Juergen Gross <jgross@suse.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

