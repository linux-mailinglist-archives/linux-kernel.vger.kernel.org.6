Return-Path: <linux-kernel+bounces-276511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C89494CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FB0B28CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A0364BA;
	Tue,  6 Aug 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mn9RqRJT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71B1803A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959243; cv=none; b=CABGtW//M3a1db21pM4QLS9JLspYNov0i3jeYpPDlXXP6ssSw5u3XqI3HpN9LX5OXZCf6nHbwBq7uZLzTyLRlKaRMcbR9BD4DZjDlMSibzt21OA88sSwlJgn5QM41i0JMx8INb+6XNCd+LaCALQBoQPqvd7tpemYJVGHGBaoroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959243; c=relaxed/simple;
	bh=B5W64/YtAb0TWD/SCkxVwqRn9FRktUCb7dR2fufvfHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZHJ9uhOTN7naZjTsjBoJJJpOIYmDc10jIHKt1WoezZVQVq3oeQBMrl3IYZEwDnz7B2rm6UapC3xi7rYMF8tICgJBVq77fAMp8Y/G6zXyIYLGxYrjVOXplUnJnMXChGFTG/aymfBlSrgx7DVhD3hwGD1NP3w5jKZSTGVf8Yhr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mn9RqRJT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722959240; x=1754495240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B5W64/YtAb0TWD/SCkxVwqRn9FRktUCb7dR2fufvfHQ=;
  b=mn9RqRJT6qMrWuWWcsuEqtTt0hYj8wcMw4k/rVf5LJQs4RSS8YymhMCG
   E8mD7j6j5uSxnROz4PSas2DHGRBnLlPlhRt+D302ba2Ptg4e+BPPHaSAz
   zF+J20QYhMOzRDrzbvtafoenVMfoe5CRkTBeSh3hEuIleOPTIEGUD3lFJ
   ISs1y5UnbJMWV7lkB8XjZg5s8L5qMmtpS+t2wTzKw/CClZYebqgWHoXO7
   OOtZoLAwPIDO7AkEF/SzLsQGDSrEl8V0VrEPU7wIl2i9GJorRDvaLmE9K
   BsH2SNw5X17JXcyClYyYZ6xo7jFuoIspC1KJi6YlKQt6Wa2oG0VTXCPxm
   g==;
X-CSE-ConnectionGUID: sXnvHunQTyS7pPEpnB+BhQ==
X-CSE-MsgGUID: tNl9MYV0Sw6RD8ke0H+Sbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43512439"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="43512439"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:47:19 -0700
X-CSE-ConnectionGUID: qYKSYn55Qom1+YpqxB4m4w==
X-CSE-MsgGUID: Y76qsy3gR9OiH9MxETeWxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56629159"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 06 Aug 2024 08:47:17 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbMP4-0004cm-15;
	Tue, 06 Aug 2024 15:47:14 +0000
Date: Tue, 6 Aug 2024 23:46:29 +0800
From: kernel test robot <lkp@intel.com>
To: carlos.song@nxp.com, alexandre.belloni@bootlin.com, frank.li@nxp.com,
	miquel.raynal@bootlin.com, conor.culhane@silvaco.com
Cc: oe-kbuild-all@lists.linux.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-imx@nxp.com
Subject: Re: [PATCH 2/2] i3c: master: svc: use slow speed for first broadcast
 address
Message-ID: <202408062304.MtyfBIl7-lkp@intel.com>
References: <20240806064851.2425797-2-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806064851.2425797-2-carlos.song@nxp.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc2 next-20240806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/carlos-song-nxp-com/i3c-master-svc-use-slow-speed-for-first-broadcast-address/20240806-144941
base:   linus/master
patch link:    https://lore.kernel.org/r/20240806064851.2425797-2-carlos.song%40nxp.com
patch subject: [PATCH 2/2] i3c: master: svc: use slow speed for first broadcast address
config: i386-buildonly-randconfig-001-20240806 (https://download.01.org/0day-ci/archive/20240806/202408062304.MtyfBIl7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408062304.MtyfBIl7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408062304.MtyfBIl7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i3c/master/svc-i3c-master.c:216: warning: Function parameter or struct member 'mctrl_config' not described in 'svc_i3c_master'


vim +216 drivers/i3c/master/svc-i3c-master.c

1c5ee2a77b1bac Clark Wang    2023-05-17  158  
dd3c52846d5954 Miquel Raynal 2021-01-21  159  /**
dd3c52846d5954 Miquel Raynal 2021-01-21  160   * struct svc_i3c_master - Silvaco I3C Master structure
dd3c52846d5954 Miquel Raynal 2021-01-21  161   * @base: I3C master controller
dd3c52846d5954 Miquel Raynal 2021-01-21  162   * @dev: Corresponding device
dd3c52846d5954 Miquel Raynal 2021-01-21  163   * @regs: Memory mapping
5496eac6ad7428 Miquel Raynal 2023-08-17  164   * @saved_regs: Volatile values for PM operations
dd3c52846d5954 Miquel Raynal 2021-01-21  165   * @free_slots: Bit array of available slots
dd3c52846d5954 Miquel Raynal 2021-01-21  166   * @addrs: Array containing the dynamic addresses of each attached device
dd3c52846d5954 Miquel Raynal 2021-01-21  167   * @descs: Array of descriptors, one per attached device
dd3c52846d5954 Miquel Raynal 2021-01-21  168   * @hj_work: Hot-join work
dd3c52846d5954 Miquel Raynal 2021-01-21  169   * @ibi_work: IBI work
dd3c52846d5954 Miquel Raynal 2021-01-21  170   * @irq: Main interrupt
dd3c52846d5954 Miquel Raynal 2021-01-21  171   * @pclk: System clock
dd3c52846d5954 Miquel Raynal 2021-01-21  172   * @fclk: Fast clock (bus)
dd3c52846d5954 Miquel Raynal 2021-01-21  173   * @sclk: Slow clock (other events)
dd3c52846d5954 Miquel Raynal 2021-01-21  174   * @xferqueue: Transfer queue structure
dd3c52846d5954 Miquel Raynal 2021-01-21  175   * @xferqueue.list: List member
dd3c52846d5954 Miquel Raynal 2021-01-21  176   * @xferqueue.cur: Current ongoing transfer
dd3c52846d5954 Miquel Raynal 2021-01-21  177   * @xferqueue.lock: Queue lock
dd3c52846d5954 Miquel Raynal 2021-01-21  178   * @ibi: IBI structure
dd3c52846d5954 Miquel Raynal 2021-01-21  179   * @ibi.num_slots: Number of slots available in @ibi.slots
dd3c52846d5954 Miquel Raynal 2021-01-21  180   * @ibi.slots: Available IBI slots
dd3c52846d5954 Miquel Raynal 2021-01-21  181   * @ibi.tbq_slot: To be queued IBI slot
dd3c52846d5954 Miquel Raynal 2021-01-21  182   * @ibi.lock: IBI lock
6bf3fc26818381 Frank Li      2023-10-23  183   * @lock: Transfer lock, protect between IBI work thread and callbacks from master
05b26c31a4859a Frank Li      2023-12-01  184   * @enabled_events: Bit masks for enable events (IBI, HotJoin).
dd3c52846d5954 Miquel Raynal 2021-01-21  185   */
dd3c52846d5954 Miquel Raynal 2021-01-21  186  struct svc_i3c_master {
dd3c52846d5954 Miquel Raynal 2021-01-21  187  	struct i3c_master_controller base;
dd3c52846d5954 Miquel Raynal 2021-01-21  188  	struct device *dev;
dd3c52846d5954 Miquel Raynal 2021-01-21  189  	void __iomem *regs;
1c5ee2a77b1bac Clark Wang    2023-05-17  190  	struct svc_i3c_regs_save saved_regs;
dd3c52846d5954 Miquel Raynal 2021-01-21  191  	u32 free_slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  192  	u8 addrs[SVC_I3C_MAX_DEVS];
dd3c52846d5954 Miquel Raynal 2021-01-21  193  	struct i3c_dev_desc *descs[SVC_I3C_MAX_DEVS];
dd3c52846d5954 Miquel Raynal 2021-01-21  194  	struct work_struct hj_work;
dd3c52846d5954 Miquel Raynal 2021-01-21  195  	struct work_struct ibi_work;
dd3c52846d5954 Miquel Raynal 2021-01-21  196  	int irq;
dd3c52846d5954 Miquel Raynal 2021-01-21  197  	struct clk *pclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  198  	struct clk *fclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  199  	struct clk *sclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  200  	struct {
dd3c52846d5954 Miquel Raynal 2021-01-21  201  		struct list_head list;
dd3c52846d5954 Miquel Raynal 2021-01-21  202  		struct svc_i3c_xfer *cur;
dd3c52846d5954 Miquel Raynal 2021-01-21  203  		/* Prevent races between transfers */
dd3c52846d5954 Miquel Raynal 2021-01-21  204  		spinlock_t lock;
dd3c52846d5954 Miquel Raynal 2021-01-21  205  	} xferqueue;
dd3c52846d5954 Miquel Raynal 2021-01-21  206  	struct {
dd3c52846d5954 Miquel Raynal 2021-01-21  207  		unsigned int num_slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  208  		struct i3c_dev_desc **slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  209  		struct i3c_ibi_slot *tbq_slot;
dd3c52846d5954 Miquel Raynal 2021-01-21  210  		/* Prevent races within IBI handlers */
dd3c52846d5954 Miquel Raynal 2021-01-21  211  		spinlock_t lock;
dd3c52846d5954 Miquel Raynal 2021-01-21  212  	} ibi;
6bf3fc26818381 Frank Li      2023-10-23  213  	struct mutex lock;
05b26c31a4859a Frank Li      2023-12-01  214  	int enabled_events;
7f8771c6b3f96d Carlos Song   2024-08-06  215  	u32 mctrl_config;
dd3c52846d5954 Miquel Raynal 2021-01-21 @216  };
dd3c52846d5954 Miquel Raynal 2021-01-21  217  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

