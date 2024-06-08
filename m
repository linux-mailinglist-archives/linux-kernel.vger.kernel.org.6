Return-Path: <linux-kernel+bounces-207103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E6890126B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E17B21A40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E9179949;
	Sat,  8 Jun 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPFopaxC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFD179663
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717861746; cv=none; b=h9odC6WChx13PIHTpO94M7uNUJs2fSAE6+Jz1kzpJqvsbOh5DCwnVRJQRjnF5MOlm/MNjPtpx3U7scuG3L3YtrpEObTVpUX0A7w2KX0+NKrlqo0KPvwQl7pBNE3aOq3ViK716CosyYvfSCOP29kBInNM5S6g01d8xl3afU8nznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717861746; c=relaxed/simple;
	bh=Vu3mBoCiq0N9b7QydQzPOnM6ZLugKz3OoDl2wdqCxNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iN/Z2Cp5hMMfM7xHLAvPNByllz9si1+QC1hCXXEx9zN9tkwB8GiEIQBEnR9BUXdXWozr1OEtuD0CdYpO43FWc8gaWe5+tX03yMW12LfBQno2+u18LlSSMMOz93T9kpsvohZ0eD2msmTM9Nm/P8FhFHG7gPU4rIiTC51KKdvDdik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPFopaxC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717861745; x=1749397745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vu3mBoCiq0N9b7QydQzPOnM6ZLugKz3OoDl2wdqCxNY=;
  b=gPFopaxCDo2u643vfZi92QK54UAG/DKBiy57eTdkDOgxI+IiXxUIecNQ
   uyV3Ggc1tP57oG7xTklcDDUp5kuO3N7Ya6tmeJfBQeb8SWSz1VYWxslx8
   M4ehThKNt87CYN/twLmQ9KxIs+JL2ksGvS9pf8kuDbf1I3+PP5mRgFGs5
   YtAgKNfaUDJIgMbISLKd1CjV6YUbYvWs0I4BbTxCOnquOBCd5GwtwcSFz
   u7W3xMxoF/5RS/PnnB+SFAzZj1oMgTGP48FebNM3sa7QEV9UjHurcd5tQ
   aYS0KokcgbxshatR58647PIwsjOlCh8AMH23UOkHB1ODq/Pg49r3kZPol
   Q==;
X-CSE-ConnectionGUID: HyX1tQNVRJ+7aNNNd2kdQQ==
X-CSE-MsgGUID: TayVRuMWSZq3Xxw8se7OZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="25681616"
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="25681616"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 08:49:04 -0700
X-CSE-ConnectionGUID: 1h+eeu0rQ7OP1d7Rztx+ag==
X-CSE-MsgGUID: TrjGLIAcSieXP0Ml/ud06A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="38552071"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Jun 2024 08:49:02 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFyJP-00008Q-1y;
	Sat, 08 Jun 2024 15:48:59 +0000
Date: Sat, 8 Jun 2024 23:48:07 +0800
From: kernel test robot <lkp@intel.com>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>
Subject: arch/microblaze/kernel/entry.S:945: Error: unknown opcode "suspend"
Message-ID: <202406082323.HAzjhTNu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Appana,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc772f8237f9b0c9ea3f34d0dc4a57d1f6a5070d
commit: 88707ebe77e23e856981e597f322cabbf6415662 microblaze: Add custom break vector handler for mb manager
date:   1 year, 8 months ago
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240608/202406082323.HAzjhTNu-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406082323.HAzjhTNu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406082323.HAzjhTNu-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/microblaze/kernel/entry.S: Assembler messages:
>> arch/microblaze/kernel/entry.S:945: Error: unknown opcode "suspend"


vim +/suspend +945 arch/microblaze/kernel/entry.S

   825	
   826		/* restore all the tlb's */
   827		addik	r3, r0, TOPHYS(tlb_skip)
   828		addik	r6, r0, PT_TLBL0
   829		addik	r7, r0, PT_TLBH0
   830	restore_tlb:
   831		add	r6, r6, r1
   832		add	r7, r7, r1
   833		lwi	r2, r6, 0
   834		mts 	rtlblo, r2
   835		lwi	r2, r7, 0
   836		mts	rtlbhi, r2
   837		addik	r6, r6, 4
   838		addik	r7, r7, 4
   839		bgtid	r3, restore_tlb
   840		addik	r3, r3, -1
   841	
   842		lwi  	r5, r0, TOPHYS(xmb_manager_dev)
   843		lwi	r8, r0, TOPHYS(xmb_manager_reset_callback)
   844		set_vms
   845		/* return from reset need -8 to adjust for rtsd r15, 8 */
   846		addik   r15, r0, ret_from_reset - 8
   847		rtbd	r8, 0
   848		nop
   849	
   850	ret_from_reset:
   851		set_bip /* Ints masked for state restore */
   852		VM_OFF
   853		/* MS: Restore all regs */
   854		RESTORE_REGS
   855		lwi	r14, r1, PT_R14
   856		lwi	r16, r1, PT_PC
   857		addik	r1, r1, PT_SIZE + 36
   858		rtbd	r16, 0
   859		nop
   860	
   861	/*
   862	 * Break handler for MB Manager. Enter to _xmb_manager_break by
   863	 * injecting fault in one of the TMR Microblaze core.
   864	 * FIXME: This break handler supports getting
   865	 * called from kernel space only.
   866	 */
   867	C_ENTRY(_xmb_manager_break):
   868		/*
   869		 * Reserve memory in the stack for context store/restore
   870		 * (which includes memory for storing tlbs (max two tlbs))
   871		 */
   872		addik	r1, r1, -PT_SIZE - 36
   873		swi	r1, r0, xmb_manager_stackpointer
   874		SAVE_REGS
   875		swi	r14, r1, PT_R14	/* rewrite saved R14 value */
   876		swi	r16, r1, PT_PC; /* PC and r16 are the same */
   877	
   878		lwi	r6, r0, TOPHYS(xmb_manager_baseaddr)
   879		lwi	r7, r0, TOPHYS(xmb_manager_crval)
   880		/*
   881		 * When the break vector gets asserted because of error injection,
   882		 * the break signal must be blocked before exiting from the
   883		 * break handler, below code configures the tmr manager
   884		 * control register to block break signal.
   885		 */
   886		swi	r7, r6, 0
   887	
   888		/* Save the special purpose registers  */
   889		mfs	r2, rpid
   890		swi	r2, r1, PT_PID
   891	
   892		mfs	r2, rtlbx
   893		swi	r2, r1, PT_TLBI
   894	
   895		mfs	r2, rzpr
   896		swi	r2, r1, PT_ZPR
   897	
   898	#if CONFIG_XILINX_MICROBLAZE0_USE_FPU
   899		mfs	r2, rfsr
   900		swi	r2, r1, PT_FSR
   901	#endif
   902		mfs	r2, rmsr
   903		swi	r2, r1, PT_MSR
   904	
   905		/* Save all the tlb's */
   906		addik	r3, r0, TOPHYS(tlb_skip)
   907		addik	r6, r0, PT_TLBL0
   908		addik	r7, r0, PT_TLBH0
   909	save_tlb:
   910		add	r6, r6, r1
   911		add	r7, r7, r1
   912		mfs	r2, rtlblo
   913		swi	r2, r6, 0
   914		mfs	r2, rtlbhi
   915		swi	r2, r7, 0
   916		addik	r6, r6, 4
   917		addik	r7, r7, 4
   918		bgtid	r3, save_tlb
   919		addik	r3, r3, -1
   920	
   921		lwi  	r5, r0, TOPHYS(xmb_manager_dev)
   922		lwi	r8, r0, TOPHYS(xmb_manager_callback)
   923		/* return from break need -8 to adjust for rtsd r15, 8 */
   924		addik   r15, r0, ret_from_break - 8
   925		rtbd	r8, 0
   926		nop
   927	
   928	ret_from_break:
   929		/* flush the d-cache */
   930		bralid	r15, mb_flush_dcache
   931		nop
   932	
   933		/*
   934		 * To make sure microblaze i-cache is in a proper state
   935		 * invalidate the i-cache.
   936		 */
   937		bralid	r15, mb_invalidate_icache
   938		nop
   939	
   940		set_bip; /* Ints masked for state restore */
   941		VM_OFF;
   942		mbar	1
   943		mbar	2
   944		bri	4
 > 945		suspend
   946		nop
   947	#endif
   948	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

