Return-Path: <linux-kernel+bounces-527010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F2A4062B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A4E421289
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27311EF09A;
	Sat, 22 Feb 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpNb06f4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1035955;
	Sat, 22 Feb 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211238; cv=none; b=WZ6X37VPRjeW5ZbQdTBZUQiM1KMO7P6oni1VfajVUDA3HIG2G2UJuzw3PP/qLYVm0VoFm7inif2qNjaQCZBwy/U+M9175WlFzMM3hHlh4fX+jee/rizW01eqMU5n1wJ3BF1PRq3PEaXipO0wXbP5PYI+Znmn1oX/0/dofQSekcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211238; c=relaxed/simple;
	bh=VDIgSMNF/GuTbpRvpV0HFWzpA8QC7+IdUuqcvSlzDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcdnvT5pwlOsrKVAZ0hBoRcaHb+tlmcBOUGFoLlyF8bcPB5tU4B0rpltli3S+X+yhL+HrTP5bjAMmvIRJ7ez2033hFyrvUe0Qk5LQct7pvadJnfyuW9CUIFp3xH2STl5MxtDj9ERc5qUwohzSoYWJbvdBOxc5vBOejOIi6O9VQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpNb06f4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740211236; x=1771747236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VDIgSMNF/GuTbpRvpV0HFWzpA8QC7+IdUuqcvSlzDGU=;
  b=hpNb06f4ljCti5fEsyr+05CiKziAwEgphigh/JjhXRvv9NQpOA0iEvHW
   KKUyXa1d8fpo/pMPIL5dMFCSThKbAF43GnykGa6L5vOV0Qjp38a/sGYBW
   EIRU5Bi/ziR4was2ty3SAAWwBzDgKPIxcX73DzA41GxOBpFGAQ6NDMt+8
   SwNxL4Qqm5Z2fEn+LvxRFKQV4hAdKkcjw8Np8c9ADFixf1TxxNSNJ2RpD
   s25qzjGripo8f3QNmcNHsZDAir/SOK0vYX+7Djh1ASO5VcQj6EQwKevs9
   9NOe65Ddm2n5CbBdBj0m9RegUj2vf48rsYIYVvsT6/ictLxzLebdjCIeX
   w==;
X-CSE-ConnectionGUID: HOpSy8cuTG2CWyGj6Gk77Q==
X-CSE-MsgGUID: WUKUzhRtTcyqQIiATrHYuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41234934"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41234934"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 00:00:35 -0800
X-CSE-ConnectionGUID: lwzyr+XTQNukRQe8y9bwMQ==
X-CSE-MsgGUID: l38OadvYQ0G0LES2hVGxTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="138803309"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 22 Feb 2025 00:00:32 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlkR3-0006ON-31;
	Sat, 22 Feb 2025 08:00:29 +0000
Date: Sat, 22 Feb 2025 15:59:41 +0800
From: kernel test robot <lkp@intel.com>
To: Stanley Chu <stanley.chuys@gmail.com>, frank.li@nxp.com,
	miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v3 2/4] i3c: master: svc: Add support for Nuvoton npcm845
 i3c
Message-ID: <202502221511.0BCyUyEU-lkp@intel.com>
References: <20250221063528.1810007-3-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221063528.1810007-3-yschu@nuvoton.com>

Hi Stanley,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.14-rc3 next-20250221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chu/dt-bindings-i3c-silvaco-Add-npcm845-compatible-string/20250221-143909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250221063528.1810007-3-yschu%40nuvoton.com
patch subject: [PATCH v3 2/4] i3c: master: svc: Add support for Nuvoton npcm845 i3c
config: arm-randconfig-003-20250222 (https://download.01.org/0day-ci/archive/20250222/202502221511.0BCyUyEU-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502221511.0BCyUyEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502221511.0BCyUyEU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i3c/master/svc-i3c-master.c:240: warning: Function parameter or struct member 'drvdata' not described in 'svc_i3c_master'


vim +240 drivers/i3c/master/svc-i3c-master.c

28c82e7b13d49b1 Stanley Chu   2025-02-21  180  
dd3c52846d5954a Miquel Raynal 2021-01-21  181  /**
dd3c52846d5954a Miquel Raynal 2021-01-21  182   * struct svc_i3c_master - Silvaco I3C Master structure
dd3c52846d5954a Miquel Raynal 2021-01-21  183   * @base: I3C master controller
dd3c52846d5954a Miquel Raynal 2021-01-21  184   * @dev: Corresponding device
dd3c52846d5954a Miquel Raynal 2021-01-21  185   * @regs: Memory mapping
5496eac6ad7428f Miquel Raynal 2023-08-17  186   * @saved_regs: Volatile values for PM operations
dd3c52846d5954a Miquel Raynal 2021-01-21  187   * @free_slots: Bit array of available slots
dd3c52846d5954a Miquel Raynal 2021-01-21  188   * @addrs: Array containing the dynamic addresses of each attached device
dd3c52846d5954a Miquel Raynal 2021-01-21  189   * @descs: Array of descriptors, one per attached device
dd3c52846d5954a Miquel Raynal 2021-01-21  190   * @hj_work: Hot-join work
dd3c52846d5954a Miquel Raynal 2021-01-21  191   * @ibi_work: IBI work
dd3c52846d5954a Miquel Raynal 2021-01-21  192   * @irq: Main interrupt
dd3c52846d5954a Miquel Raynal 2021-01-21  193   * @pclk: System clock
dd3c52846d5954a Miquel Raynal 2021-01-21  194   * @fclk: Fast clock (bus)
dd3c52846d5954a Miquel Raynal 2021-01-21  195   * @sclk: Slow clock (other events)
dd3c52846d5954a Miquel Raynal 2021-01-21  196   * @xferqueue: Transfer queue structure
dd3c52846d5954a Miquel Raynal 2021-01-21  197   * @xferqueue.list: List member
dd3c52846d5954a Miquel Raynal 2021-01-21  198   * @xferqueue.cur: Current ongoing transfer
dd3c52846d5954a Miquel Raynal 2021-01-21  199   * @xferqueue.lock: Queue lock
dd3c52846d5954a Miquel Raynal 2021-01-21  200   * @ibi: IBI structure
dd3c52846d5954a Miquel Raynal 2021-01-21  201   * @ibi.num_slots: Number of slots available in @ibi.slots
dd3c52846d5954a Miquel Raynal 2021-01-21  202   * @ibi.slots: Available IBI slots
dd3c52846d5954a Miquel Raynal 2021-01-21  203   * @ibi.tbq_slot: To be queued IBI slot
dd3c52846d5954a Miquel Raynal 2021-01-21  204   * @ibi.lock: IBI lock
6bf3fc268183816 Frank Li      2023-10-23  205   * @lock: Transfer lock, protect between IBI work thread and callbacks from master
05b26c31a4859af Frank Li      2023-12-01  206   * @enabled_events: Bit masks for enable events (IBI, HotJoin).
20ade67bb1645f5 Carlos Song   2024-09-10  207   * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
dd3c52846d5954a Miquel Raynal 2021-01-21  208   */
dd3c52846d5954a Miquel Raynal 2021-01-21  209  struct svc_i3c_master {
dd3c52846d5954a Miquel Raynal 2021-01-21  210  	struct i3c_master_controller base;
dd3c52846d5954a Miquel Raynal 2021-01-21  211  	struct device *dev;
dd3c52846d5954a Miquel Raynal 2021-01-21  212  	void __iomem *regs;
1c5ee2a77b1bacd Clark Wang    2023-05-17  213  	struct svc_i3c_regs_save saved_regs;
dd3c52846d5954a Miquel Raynal 2021-01-21  214  	u32 free_slots;
dd3c52846d5954a Miquel Raynal 2021-01-21  215  	u8 addrs[SVC_I3C_MAX_DEVS];
dd3c52846d5954a Miquel Raynal 2021-01-21  216  	struct i3c_dev_desc *descs[SVC_I3C_MAX_DEVS];
dd3c52846d5954a Miquel Raynal 2021-01-21  217  	struct work_struct hj_work;
dd3c52846d5954a Miquel Raynal 2021-01-21  218  	struct work_struct ibi_work;
dd3c52846d5954a Miquel Raynal 2021-01-21  219  	int irq;
dd3c52846d5954a Miquel Raynal 2021-01-21  220  	struct clk *pclk;
dd3c52846d5954a Miquel Raynal 2021-01-21  221  	struct clk *fclk;
dd3c52846d5954a Miquel Raynal 2021-01-21  222  	struct clk *sclk;
dd3c52846d5954a Miquel Raynal 2021-01-21  223  	struct {
dd3c52846d5954a Miquel Raynal 2021-01-21  224  		struct list_head list;
dd3c52846d5954a Miquel Raynal 2021-01-21  225  		struct svc_i3c_xfer *cur;
dd3c52846d5954a Miquel Raynal 2021-01-21  226  		/* Prevent races between transfers */
dd3c52846d5954a Miquel Raynal 2021-01-21  227  		spinlock_t lock;
dd3c52846d5954a Miquel Raynal 2021-01-21  228  	} xferqueue;
dd3c52846d5954a Miquel Raynal 2021-01-21  229  	struct {
dd3c52846d5954a Miquel Raynal 2021-01-21  230  		unsigned int num_slots;
dd3c52846d5954a Miquel Raynal 2021-01-21  231  		struct i3c_dev_desc **slots;
dd3c52846d5954a Miquel Raynal 2021-01-21  232  		struct i3c_ibi_slot *tbq_slot;
dd3c52846d5954a Miquel Raynal 2021-01-21  233  		/* Prevent races within IBI handlers */
dd3c52846d5954a Miquel Raynal 2021-01-21  234  		spinlock_t lock;
dd3c52846d5954a Miquel Raynal 2021-01-21  235  	} ibi;
6bf3fc268183816 Frank Li      2023-10-23  236  	struct mutex lock;
28c82e7b13d49b1 Stanley Chu   2025-02-21  237  	const struct svc_i3c_drvdata *drvdata;
25bc99be5fe5385 Frank Li      2024-11-01  238  	u32 enabled_events;
20ade67bb1645f5 Carlos Song   2024-09-10  239  	u32 mctrl_config;
dd3c52846d5954a Miquel Raynal 2021-01-21 @240  };
dd3c52846d5954a Miquel Raynal 2021-01-21  241  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

