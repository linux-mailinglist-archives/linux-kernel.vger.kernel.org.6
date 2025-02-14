Return-Path: <linux-kernel+bounces-515772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B37A368BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DA6188E0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BB1FCF79;
	Fri, 14 Feb 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaJ0aqI6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3B1C84AC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573671; cv=none; b=ncjb1LjbcaZLqp+gxwIHYx4iRq18ofARdUsgkRZwGCmsFkMZ1NWNcl9ffsc22L+4lIRFnS7cvkSCadjhYNqPbjRfveHG1SGmlrL6ni9pH8178TCFJ2Wzj9tR3athJvwaDt9WB8ypckwPActwBU+mHfBYgsXZBeutQCZbcY44kJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573671; c=relaxed/simple;
	bh=XpD8kjdxn8zgb0bQboXyZiu7FPrXYInowNVupp5wr/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GhdRCMY2ZsXr7Incf17ZDD6ELKSZ0/+raDR7VmdD/g4XomN20CLRK4/OY1OfR1xNJyV19FgmcdpsQgnEZG7B0ftCNO5XBK4phFmJKxMf7z+PUHdWbcz0s0Ad+u2a+zN7Bo2M0mnZNzBCcQpmZ7rBJUS2oRIY20mOc7Blxn/k1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaJ0aqI6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739573669; x=1771109669;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XpD8kjdxn8zgb0bQboXyZiu7FPrXYInowNVupp5wr/8=;
  b=LaJ0aqI64yj36IHtlPLt/rKXBo8SceCKN3wfPMI9xKbFetJRJa7J7iK0
   5Iflizh2GtgCFmAYNK9nHy81lwY8903ujCdmCE77rSgp11KCIodKzPL++
   4k/7MfUkyXeiMztZAjX6ReuXedWQ+aXcJVlBK4faQTf0aDI8M64+1GCHw
   LZRBHqrWvJOInVrC6cDlrMP2stjjiaxuICdy1uyyhCBe2l3EaXUwd/ma9
   bvLsnNouMc3FasNWOMzgnf3xqQnx6reqnoGjPiRH7j7L9VgMOJwlxnGQI
   g8e56KYPnEZpogt2/nq0o+hcYFKL0rkJ81L4vEpCqC1uuRzzKOhCMLUHn
   g==;
X-CSE-ConnectionGUID: glBF2zmTTTqQ5qgDwFN0Og==
X-CSE-MsgGUID: HnvHfMvQQtOyh3CpqYDAPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="39521625"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="39521625"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 14:54:28 -0800
X-CSE-ConnectionGUID: tfVvwZWZToOdp9lOZfPVYg==
X-CSE-MsgGUID: FI+IZpVtSTW+kMQ8UbPyag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="118605625"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Feb 2025 14:54:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj4Zk-001AGF-04;
	Fri, 14 Feb 2025 22:54:24 +0000
Date: Sat, 15 Feb 2025 06:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Boris Brezillon <bbrezillon@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct
 member 'slots' description in 'panthor_queue'
Message-ID: <202502150602.v5B5FYkm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04f41cbf03ec7221ab0b179e336f4c805ee55520
commit: f8ff51a4708451763e6cfa36cc83dea8513d3318 drm/panthor: introduce job cycle and timestamp accounting
date:   5 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250215/202502150602.v5B5FYkm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502150602.v5B5FYkm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502150602.v5B5FYkm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/panthor/panthor_sched.c:320: warning: Excess struct member 'runnable' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:320: warning: Excess struct member 'idle' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:320: warning: Excess struct member 'waiting' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:320: warning: Excess struct member 'has_ref' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:320: warning: Excess struct member 'in_progress' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:320: warning: Excess struct member 'stopped_groups' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'mem' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'input' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'output' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'input_fw_va' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'output_fw_va' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'gpu_va' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'ref' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'gt' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'sync64' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'bo' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'offset' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'kmap' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'lock' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'id' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'seqno' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'last_fence' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'in_flight_jobs' description in 'panthor_queue'
>> drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'slots' description in 'panthor_queue'
>> drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'slot_count' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'seqno' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:811: warning: Excess struct member 'start' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:811: warning: Excess struct member 'size' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:811: warning: Excess struct member 'latest_flush' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:811: warning: Excess struct member 'start' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:811: warning: Excess struct member 'end' description in 'panthor_job'
>> drivers/gpu/drm/panthor/panthor_sched.c:811: warning: Excess struct member 'mask' description in 'panthor_job'
>> drivers/gpu/drm/panthor/panthor_sched.c:811: warning: Excess struct member 'slot' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:1732: warning: Function parameter or struct member 'ptdev' not described in 'panthor_sched_report_fw_events'
   drivers/gpu/drm/panthor/panthor_sched.c:1732: warning: Function parameter or struct member 'events' not described in 'panthor_sched_report_fw_events'
   drivers/gpu/drm/panthor/panthor_sched.c:2624: warning: Function parameter or struct member 'ptdev' not described in 'panthor_sched_report_mmu_fault'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +492 drivers/gpu/drm/panthor/panthor_sched.c

de85488138247d Boris Brezillon 2024-02-29  395  
de85488138247d Boris Brezillon 2024-02-29  396  	/** @ringbuf: Command stream ring-buffer. */
de85488138247d Boris Brezillon 2024-02-29  397  	struct panthor_kernel_bo *ringbuf;
de85488138247d Boris Brezillon 2024-02-29  398  
de85488138247d Boris Brezillon 2024-02-29  399  	/** @iface: Firmware interface. */
de85488138247d Boris Brezillon 2024-02-29  400  	struct {
de85488138247d Boris Brezillon 2024-02-29  401  		/** @mem: FW memory allocated for this interface. */
de85488138247d Boris Brezillon 2024-02-29  402  		struct panthor_kernel_bo *mem;
de85488138247d Boris Brezillon 2024-02-29  403  
de85488138247d Boris Brezillon 2024-02-29  404  		/** @input: Input interface. */
de85488138247d Boris Brezillon 2024-02-29  405  		struct panthor_fw_ringbuf_input_iface *input;
de85488138247d Boris Brezillon 2024-02-29  406  
de85488138247d Boris Brezillon 2024-02-29  407  		/** @output: Output interface. */
de85488138247d Boris Brezillon 2024-02-29  408  		const struct panthor_fw_ringbuf_output_iface *output;
de85488138247d Boris Brezillon 2024-02-29  409  
de85488138247d Boris Brezillon 2024-02-29  410  		/** @input_fw_va: FW virtual address of the input interface buffer. */
de85488138247d Boris Brezillon 2024-02-29  411  		u32 input_fw_va;
de85488138247d Boris Brezillon 2024-02-29  412  
de85488138247d Boris Brezillon 2024-02-29  413  		/** @output_fw_va: FW virtual address of the output interface buffer. */
de85488138247d Boris Brezillon 2024-02-29  414  		u32 output_fw_va;
de85488138247d Boris Brezillon 2024-02-29  415  	} iface;
de85488138247d Boris Brezillon 2024-02-29  416  
de85488138247d Boris Brezillon 2024-02-29  417  	/**
de85488138247d Boris Brezillon 2024-02-29  418  	 * @syncwait: Stores information about the synchronization object this
de85488138247d Boris Brezillon 2024-02-29  419  	 * queue is waiting on.
de85488138247d Boris Brezillon 2024-02-29  420  	 */
de85488138247d Boris Brezillon 2024-02-29  421  	struct {
de85488138247d Boris Brezillon 2024-02-29  422  		/** @gpu_va: GPU address of the synchronization object. */
de85488138247d Boris Brezillon 2024-02-29  423  		u64 gpu_va;
de85488138247d Boris Brezillon 2024-02-29  424  
de85488138247d Boris Brezillon 2024-02-29  425  		/** @ref: Reference value to compare against. */
de85488138247d Boris Brezillon 2024-02-29  426  		u64 ref;
de85488138247d Boris Brezillon 2024-02-29  427  
de85488138247d Boris Brezillon 2024-02-29  428  		/** @gt: True if this is a greater-than test. */
de85488138247d Boris Brezillon 2024-02-29  429  		bool gt;
de85488138247d Boris Brezillon 2024-02-29  430  
de85488138247d Boris Brezillon 2024-02-29  431  		/** @sync64: True if this is a 64-bit sync object. */
de85488138247d Boris Brezillon 2024-02-29  432  		bool sync64;
de85488138247d Boris Brezillon 2024-02-29  433  
de85488138247d Boris Brezillon 2024-02-29  434  		/** @bo: Buffer object holding the synchronization object. */
de85488138247d Boris Brezillon 2024-02-29  435  		struct drm_gem_object *obj;
de85488138247d Boris Brezillon 2024-02-29  436  
de85488138247d Boris Brezillon 2024-02-29  437  		/** @offset: Offset of the synchronization object inside @bo. */
de85488138247d Boris Brezillon 2024-02-29  438  		u64 offset;
de85488138247d Boris Brezillon 2024-02-29  439  
de85488138247d Boris Brezillon 2024-02-29  440  		/**
de85488138247d Boris Brezillon 2024-02-29  441  		 * @kmap: Kernel mapping of the buffer object holding the
de85488138247d Boris Brezillon 2024-02-29  442  		 * synchronization object.
de85488138247d Boris Brezillon 2024-02-29  443  		 */
de85488138247d Boris Brezillon 2024-02-29  444  		void *kmap;
de85488138247d Boris Brezillon 2024-02-29  445  	} syncwait;
de85488138247d Boris Brezillon 2024-02-29  446  
de85488138247d Boris Brezillon 2024-02-29  447  	/** @fence_ctx: Fence context fields. */
de85488138247d Boris Brezillon 2024-02-29  448  	struct {
de85488138247d Boris Brezillon 2024-02-29  449  		/** @lock: Used to protect access to all fences allocated by this context. */
de85488138247d Boris Brezillon 2024-02-29  450  		spinlock_t lock;
de85488138247d Boris Brezillon 2024-02-29  451  
de85488138247d Boris Brezillon 2024-02-29  452  		/**
de85488138247d Boris Brezillon 2024-02-29  453  		 * @id: Fence context ID.
de85488138247d Boris Brezillon 2024-02-29  454  		 *
de85488138247d Boris Brezillon 2024-02-29  455  		 * Allocated with dma_fence_context_alloc().
de85488138247d Boris Brezillon 2024-02-29  456  		 */
de85488138247d Boris Brezillon 2024-02-29  457  		u64 id;
de85488138247d Boris Brezillon 2024-02-29  458  
de85488138247d Boris Brezillon 2024-02-29  459  		/** @seqno: Sequence number of the last initialized fence. */
de85488138247d Boris Brezillon 2024-02-29  460  		atomic64_t seqno;
de85488138247d Boris Brezillon 2024-02-29  461  
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  462  		/**
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  463  		 * @last_fence: Fence of the last submitted job.
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  464  		 *
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  465  		 * We return this fence when we get an empty command stream.
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  466  		 * This way, we are guaranteed that all earlier jobs have completed
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  467  		 * when drm_sched_job::s_fence::finished without having to feed
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  468  		 * the CS ring buffer with a dummy job that only signals the fence.
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  469  		 */
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  470  		struct dma_fence *last_fence;
7b6f9ec6ad5112 Boris Brezillon 2024-07-03  471  
de85488138247d Boris Brezillon 2024-02-29  472  		/**
de85488138247d Boris Brezillon 2024-02-29  473  		 * @in_flight_jobs: List containing all in-flight jobs.
de85488138247d Boris Brezillon 2024-02-29  474  		 *
de85488138247d Boris Brezillon 2024-02-29  475  		 * Used to keep track and signal panthor_job::done_fence when the
de85488138247d Boris Brezillon 2024-02-29  476  		 * synchronization object attached to the queue is signaled.
de85488138247d Boris Brezillon 2024-02-29  477  		 */
de85488138247d Boris Brezillon 2024-02-29  478  		struct list_head in_flight_jobs;
de85488138247d Boris Brezillon 2024-02-29  479  	} fence_ctx;
f8ff51a4708451 Adrián Larumbe  2024-09-24  480  
f8ff51a4708451 Adrián Larumbe  2024-09-24  481  	/** @profiling: Job profiling data slots and access information. */
f8ff51a4708451 Adrián Larumbe  2024-09-24  482  	struct {
f8ff51a4708451 Adrián Larumbe  2024-09-24  483  		/** @slots: Kernel BO holding the slots. */
f8ff51a4708451 Adrián Larumbe  2024-09-24  484  		struct panthor_kernel_bo *slots;
f8ff51a4708451 Adrián Larumbe  2024-09-24  485  
f8ff51a4708451 Adrián Larumbe  2024-09-24  486  		/** @slot_count: Number of jobs ringbuffer can hold at once. */
f8ff51a4708451 Adrián Larumbe  2024-09-24  487  		u32 slot_count;
f8ff51a4708451 Adrián Larumbe  2024-09-24  488  
f8ff51a4708451 Adrián Larumbe  2024-09-24  489  		/** @seqno: Index of the next available profiling information slot. */
f8ff51a4708451 Adrián Larumbe  2024-09-24  490  		u32 seqno;
f8ff51a4708451 Adrián Larumbe  2024-09-24  491  	} profiling;
de85488138247d Boris Brezillon 2024-02-29 @492  };
de85488138247d Boris Brezillon 2024-02-29  493  

:::::: The code at line 492 was first introduced by commit
:::::: de85488138247d034eb3241840424a54d660926b drm/panthor: Add the scheduler logical block

:::::: TO: Boris Brezillon <boris.brezillon@collabora.com>
:::::: CC: Boris Brezillon <boris.brezillon@collabora.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

