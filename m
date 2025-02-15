Return-Path: <linux-kernel+bounces-516231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA7A36E72
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702351645F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A891D5ADD;
	Sat, 15 Feb 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nceq8HOz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7761C701C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739625469; cv=none; b=iaqiK+gly7ZK+qd4y60G/Fo2QyzwgKWh0/3phOL6nDwGiWNjRe6QiPsjpxPlruV52GfP11j4EfQbPUZ4qcIkih5or/nxC6QBzAzj65jGBMYTQHnwuT3Q9LHzoxnfXj7KnpaZ8WsF1FgLuPVwH47CfbqXx23LEUBP8R6KdF9svn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739625469; c=relaxed/simple;
	bh=xGHDEJPv1aWZddo2RO3r15uBCgY0PFZWPR+5uSkTwuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RSwz8tw6piFDAXm6OQydKkC/P+JU5gS92RPLoXQtyZIjqk3Nc6yoSgL1gKIQeUuMwPOGChO6XM8N0wmQXfMz/Kx6NfPAUs1zCTw91ozNO5Nj+wy5lQK8SZdQah/irTC3BMjdIj4orcYaOW6KKSfaF1b2S3rBA68WvFi2Fcy2H3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nceq8HOz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739625467; x=1771161467;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xGHDEJPv1aWZddo2RO3r15uBCgY0PFZWPR+5uSkTwuI=;
  b=Nceq8HOz5KrUf9no3ZSF7WUTC9MVH1LRfobaWyKBKOXn7dNARdkqyDMp
   w+9AVcHxVXueQ1ygMWY5cQtepEiPU7Zz7GEXu+s8Qb1TPEibovw+TxRRc
   X32I5jXUbfjdNcM45VDHtdNjN3mfSRMoSHWAJUkrMQOgjKSVmZoXhwgw4
   z9kfD6ptc+pbMJwwmTzUf1dnho3Iknfr/aseFCFWHRLEvF7gIsutsEMhH
   yMsfXmmZQOU0PnnrjWNO2n15glAeSd7lgxvhysdvobfp/GYjJ0pT6bcMK
   DIuzYeJSWdRFqB4oAu658lQkKDtpf8FTo8tU/R/FqwBCjTabz09lge85R
   Q==;
X-CSE-ConnectionGUID: SdQzt/NfT1uIP3jkY/4W6w==
X-CSE-MsgGUID: eNKOMq7TReyyCDYduSqNMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40285672"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40285672"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 05:17:46 -0800
X-CSE-ConnectionGUID: CwpnAvEcSlCBjEkpbwya5w==
X-CSE-MsgGUID: Ln/LbF5tRoOnDMXLplZJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114601928"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Feb 2025 05:17:45 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjI3C-001ArC-2p;
	Sat, 15 Feb 2025 13:17:42 +0000
Date: Sat, 15 Feb 2025 21:17:03 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Boris Brezillon <bbrezillon@kernel.org>,
	Steven Price <steven.price@arm.com>
Subject: drivers/gpu/drm/panthor/panthor_sched.c:687: warning: Excess struct
 member 'data' description in 'panthor_group'
Message-ID: <202502152133.QgtAml6d-lkp@intel.com>
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
head:   7ff71e6d923969d933e1ba7e0db857782d36cd19
commit: e16635d88fa07ba5801aa9e57ad7fe3c053234e4 drm/panthor: add DRM fdinfo support
date:   5 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250215/202502152133.QgtAml6d-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502152133.QgtAml6d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502152133.QgtAml6d-lkp@intel.com/

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
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'slots' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'slot_count' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:492: warning: Excess struct member 'seqno' description in 'panthor_queue'
>> drivers/gpu/drm/panthor/panthor_sched.c:687: warning: Excess struct member 'data' description in 'panthor_group'
>> drivers/gpu/drm/panthor/panthor_sched.c:687: warning: Excess struct member 'lock' description in 'panthor_group'
   drivers/gpu/drm/panthor/panthor_sched.c:823: warning: Excess struct member 'start' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:823: warning: Excess struct member 'size' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:823: warning: Excess struct member 'latest_flush' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:823: warning: Excess struct member 'start' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:823: warning: Excess struct member 'end' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:823: warning: Excess struct member 'mask' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:823: warning: Excess struct member 'slot' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:1746: warning: Function parameter or struct member 'ptdev' not described in 'panthor_sched_report_fw_events'
   drivers/gpu/drm/panthor/panthor_sched.c:1746: warning: Function parameter or struct member 'events' not described in 'panthor_sched_report_fw_events'
   drivers/gpu/drm/panthor/panthor_sched.c:2638: warning: Function parameter or struct member 'ptdev' not described in 'panthor_sched_report_mmu_fault'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +687 drivers/gpu/drm/panthor/panthor_sched.c

de85488138247d Boris Brezillon 2024-02-29  529  
de85488138247d Boris Brezillon 2024-02-29  530  /**
de85488138247d Boris Brezillon 2024-02-29  531   * struct panthor_group - Scheduling group object
de85488138247d Boris Brezillon 2024-02-29  532   */
de85488138247d Boris Brezillon 2024-02-29  533  struct panthor_group {
de85488138247d Boris Brezillon 2024-02-29  534  	/** @refcount: Reference count */
de85488138247d Boris Brezillon 2024-02-29  535  	struct kref refcount;
de85488138247d Boris Brezillon 2024-02-29  536  
de85488138247d Boris Brezillon 2024-02-29  537  	/** @ptdev: Device. */
de85488138247d Boris Brezillon 2024-02-29  538  	struct panthor_device *ptdev;
de85488138247d Boris Brezillon 2024-02-29  539  
de85488138247d Boris Brezillon 2024-02-29  540  	/** @vm: VM bound to the group. */
de85488138247d Boris Brezillon 2024-02-29  541  	struct panthor_vm *vm;
de85488138247d Boris Brezillon 2024-02-29  542  
de85488138247d Boris Brezillon 2024-02-29  543  	/** @compute_core_mask: Mask of shader cores that can be used for compute jobs. */
de85488138247d Boris Brezillon 2024-02-29  544  	u64 compute_core_mask;
de85488138247d Boris Brezillon 2024-02-29  545  
de85488138247d Boris Brezillon 2024-02-29  546  	/** @fragment_core_mask: Mask of shader cores that can be used for fragment jobs. */
de85488138247d Boris Brezillon 2024-02-29  547  	u64 fragment_core_mask;
de85488138247d Boris Brezillon 2024-02-29  548  
de85488138247d Boris Brezillon 2024-02-29  549  	/** @tiler_core_mask: Mask of tiler cores that can be used for tiler jobs. */
de85488138247d Boris Brezillon 2024-02-29  550  	u64 tiler_core_mask;
de85488138247d Boris Brezillon 2024-02-29  551  
de85488138247d Boris Brezillon 2024-02-29  552  	/** @max_compute_cores: Maximum number of shader cores used for compute jobs. */
de85488138247d Boris Brezillon 2024-02-29  553  	u8 max_compute_cores;
de85488138247d Boris Brezillon 2024-02-29  554  
be7ffc821f5fc2 Liviu Dudau     2024-04-02  555  	/** @max_fragment_cores: Maximum number of shader cores used for fragment jobs. */
de85488138247d Boris Brezillon 2024-02-29  556  	u8 max_fragment_cores;
de85488138247d Boris Brezillon 2024-02-29  557  
de85488138247d Boris Brezillon 2024-02-29  558  	/** @max_tiler_cores: Maximum number of tiler cores used for tiler jobs. */
de85488138247d Boris Brezillon 2024-02-29  559  	u8 max_tiler_cores;
de85488138247d Boris Brezillon 2024-02-29  560  
de85488138247d Boris Brezillon 2024-02-29  561  	/** @priority: Group priority (check panthor_csg_priority). */
de85488138247d Boris Brezillon 2024-02-29  562  	u8 priority;
de85488138247d Boris Brezillon 2024-02-29  563  
de85488138247d Boris Brezillon 2024-02-29  564  	/** @blocked_queues: Bitmask reflecting the blocked queues. */
de85488138247d Boris Brezillon 2024-02-29  565  	u32 blocked_queues;
de85488138247d Boris Brezillon 2024-02-29  566  
de85488138247d Boris Brezillon 2024-02-29  567  	/** @idle_queues: Bitmask reflecting the idle queues. */
de85488138247d Boris Brezillon 2024-02-29  568  	u32 idle_queues;
de85488138247d Boris Brezillon 2024-02-29  569  
de85488138247d Boris Brezillon 2024-02-29  570  	/** @fatal_lock: Lock used to protect access to fatal fields. */
de85488138247d Boris Brezillon 2024-02-29  571  	spinlock_t fatal_lock;
de85488138247d Boris Brezillon 2024-02-29  572  
de85488138247d Boris Brezillon 2024-02-29  573  	/** @fatal_queues: Bitmask reflecting the queues that hit a fatal exception. */
de85488138247d Boris Brezillon 2024-02-29  574  	u32 fatal_queues;
de85488138247d Boris Brezillon 2024-02-29  575  
de85488138247d Boris Brezillon 2024-02-29  576  	/** @tiler_oom: Mask of queues that have a tiler OOM event to process. */
de85488138247d Boris Brezillon 2024-02-29  577  	atomic_t tiler_oom;
de85488138247d Boris Brezillon 2024-02-29  578  
de85488138247d Boris Brezillon 2024-02-29  579  	/** @queue_count: Number of queues in this group. */
de85488138247d Boris Brezillon 2024-02-29  580  	u32 queue_count;
de85488138247d Boris Brezillon 2024-02-29  581  
de85488138247d Boris Brezillon 2024-02-29  582  	/** @queues: Queues owned by this group. */
de85488138247d Boris Brezillon 2024-02-29  583  	struct panthor_queue *queues[MAX_CS_PER_CSG];
de85488138247d Boris Brezillon 2024-02-29  584  
de85488138247d Boris Brezillon 2024-02-29  585  	/**
de85488138247d Boris Brezillon 2024-02-29  586  	 * @csg_id: ID of the FW group slot.
de85488138247d Boris Brezillon 2024-02-29  587  	 *
de85488138247d Boris Brezillon 2024-02-29  588  	 * -1 when the group is not scheduled/active.
de85488138247d Boris Brezillon 2024-02-29  589  	 */
de85488138247d Boris Brezillon 2024-02-29  590  	int csg_id;
de85488138247d Boris Brezillon 2024-02-29  591  
de85488138247d Boris Brezillon 2024-02-29  592  	/**
de85488138247d Boris Brezillon 2024-02-29  593  	 * @destroyed: True when the group has been destroyed.
de85488138247d Boris Brezillon 2024-02-29  594  	 *
de85488138247d Boris Brezillon 2024-02-29  595  	 * If a group is destroyed it becomes useless: no further jobs can be submitted
de85488138247d Boris Brezillon 2024-02-29  596  	 * to its queues. We simply wait for all references to be dropped so we can
de85488138247d Boris Brezillon 2024-02-29  597  	 * release the group object.
de85488138247d Boris Brezillon 2024-02-29  598  	 */
de85488138247d Boris Brezillon 2024-02-29  599  	bool destroyed;
de85488138247d Boris Brezillon 2024-02-29  600  
de85488138247d Boris Brezillon 2024-02-29  601  	/**
de85488138247d Boris Brezillon 2024-02-29  602  	 * @timedout: True when a timeout occurred on any of the queues owned by
de85488138247d Boris Brezillon 2024-02-29  603  	 * this group.
de85488138247d Boris Brezillon 2024-02-29  604  	 *
de85488138247d Boris Brezillon 2024-02-29  605  	 * Timeouts can be reported by drm_sched or by the FW. In any case, any
de85488138247d Boris Brezillon 2024-02-29  606  	 * timeout situation is unrecoverable, and the group becomes useless.
de85488138247d Boris Brezillon 2024-02-29  607  	 * We simply wait for all references to be dropped so we can release the
de85488138247d Boris Brezillon 2024-02-29  608  	 * group object.
de85488138247d Boris Brezillon 2024-02-29  609  	 */
de85488138247d Boris Brezillon 2024-02-29  610  	bool timedout;
de85488138247d Boris Brezillon 2024-02-29  611  
de85488138247d Boris Brezillon 2024-02-29  612  	/**
de85488138247d Boris Brezillon 2024-02-29  613  	 * @syncobjs: Pool of per-queue synchronization objects.
de85488138247d Boris Brezillon 2024-02-29  614  	 *
de85488138247d Boris Brezillon 2024-02-29  615  	 * One sync object per queue. The position of the sync object is
de85488138247d Boris Brezillon 2024-02-29  616  	 * determined by the queue index.
de85488138247d Boris Brezillon 2024-02-29  617  	 */
de85488138247d Boris Brezillon 2024-02-29  618  	struct panthor_kernel_bo *syncobjs;
de85488138247d Boris Brezillon 2024-02-29  619  
e16635d88fa07b Adrián Larumbe  2024-09-24  620  	/** @fdinfo: Per-file total cycle and timestamp values reference. */
e16635d88fa07b Adrián Larumbe  2024-09-24  621  	struct {
e16635d88fa07b Adrián Larumbe  2024-09-24  622  		/** @data: Total sampled values for jobs in queues from this group. */
e16635d88fa07b Adrián Larumbe  2024-09-24  623  		struct panthor_gpu_usage data;
e16635d88fa07b Adrián Larumbe  2024-09-24  624  
e16635d88fa07b Adrián Larumbe  2024-09-24  625  		/**
e16635d88fa07b Adrián Larumbe  2024-09-24  626  		 * @lock: Mutex to govern concurrent access from drm file's fdinfo callback
e16635d88fa07b Adrián Larumbe  2024-09-24  627  		 * and job post-completion processing function
e16635d88fa07b Adrián Larumbe  2024-09-24  628  		 */
e16635d88fa07b Adrián Larumbe  2024-09-24  629  		struct mutex lock;
e16635d88fa07b Adrián Larumbe  2024-09-24  630  	} fdinfo;
e16635d88fa07b Adrián Larumbe  2024-09-24  631  
de85488138247d Boris Brezillon 2024-02-29  632  	/** @state: Group state. */
de85488138247d Boris Brezillon 2024-02-29  633  	enum panthor_group_state state;
de85488138247d Boris Brezillon 2024-02-29  634  
de85488138247d Boris Brezillon 2024-02-29  635  	/**
de85488138247d Boris Brezillon 2024-02-29  636  	 * @suspend_buf: Suspend buffer.
de85488138247d Boris Brezillon 2024-02-29  637  	 *
de85488138247d Boris Brezillon 2024-02-29  638  	 * Stores the state of the group and its queues when a group is suspended.
de85488138247d Boris Brezillon 2024-02-29  639  	 * Used at resume time to restore the group in its previous state.
de85488138247d Boris Brezillon 2024-02-29  640  	 *
de85488138247d Boris Brezillon 2024-02-29  641  	 * The size of the suspend buffer is exposed through the FW interface.
de85488138247d Boris Brezillon 2024-02-29  642  	 */
de85488138247d Boris Brezillon 2024-02-29  643  	struct panthor_kernel_bo *suspend_buf;
de85488138247d Boris Brezillon 2024-02-29  644  
de85488138247d Boris Brezillon 2024-02-29  645  	/**
de85488138247d Boris Brezillon 2024-02-29  646  	 * @protm_suspend_buf: Protection mode suspend buffer.
de85488138247d Boris Brezillon 2024-02-29  647  	 *
de85488138247d Boris Brezillon 2024-02-29  648  	 * Stores the state of the group and its queues when a group that's in
de85488138247d Boris Brezillon 2024-02-29  649  	 * protection mode is suspended.
de85488138247d Boris Brezillon 2024-02-29  650  	 *
de85488138247d Boris Brezillon 2024-02-29  651  	 * Used at resume time to restore the group in its previous state.
de85488138247d Boris Brezillon 2024-02-29  652  	 *
de85488138247d Boris Brezillon 2024-02-29  653  	 * The size of the protection mode suspend buffer is exposed through the
de85488138247d Boris Brezillon 2024-02-29  654  	 * FW interface.
de85488138247d Boris Brezillon 2024-02-29  655  	 */
de85488138247d Boris Brezillon 2024-02-29  656  	struct panthor_kernel_bo *protm_suspend_buf;
de85488138247d Boris Brezillon 2024-02-29  657  
de85488138247d Boris Brezillon 2024-02-29  658  	/** @sync_upd_work: Work used to check/signal job fences. */
de85488138247d Boris Brezillon 2024-02-29  659  	struct work_struct sync_upd_work;
de85488138247d Boris Brezillon 2024-02-29  660  
de85488138247d Boris Brezillon 2024-02-29  661  	/** @tiler_oom_work: Work used to process tiler OOM events happening on this group. */
de85488138247d Boris Brezillon 2024-02-29  662  	struct work_struct tiler_oom_work;
de85488138247d Boris Brezillon 2024-02-29  663  
de85488138247d Boris Brezillon 2024-02-29  664  	/** @term_work: Work used to finish the group termination procedure. */
de85488138247d Boris Brezillon 2024-02-29  665  	struct work_struct term_work;
de85488138247d Boris Brezillon 2024-02-29  666  
de85488138247d Boris Brezillon 2024-02-29  667  	/**
de85488138247d Boris Brezillon 2024-02-29  668  	 * @release_work: Work used to release group resources.
de85488138247d Boris Brezillon 2024-02-29  669  	 *
de85488138247d Boris Brezillon 2024-02-29  670  	 * We need to postpone the group release to avoid a deadlock when
de85488138247d Boris Brezillon 2024-02-29  671  	 * the last ref is released in the tick work.
de85488138247d Boris Brezillon 2024-02-29  672  	 */
de85488138247d Boris Brezillon 2024-02-29  673  	struct work_struct release_work;
de85488138247d Boris Brezillon 2024-02-29  674  
de85488138247d Boris Brezillon 2024-02-29  675  	/**
de85488138247d Boris Brezillon 2024-02-29  676  	 * @run_node: Node used to insert the group in the
de85488138247d Boris Brezillon 2024-02-29  677  	 * panthor_group::groups::{runnable,idle} and
de85488138247d Boris Brezillon 2024-02-29  678  	 * panthor_group::reset.stopped_groups lists.
de85488138247d Boris Brezillon 2024-02-29  679  	 */
de85488138247d Boris Brezillon 2024-02-29  680  	struct list_head run_node;
de85488138247d Boris Brezillon 2024-02-29  681  
de85488138247d Boris Brezillon 2024-02-29  682  	/**
de85488138247d Boris Brezillon 2024-02-29  683  	 * @wait_node: Node used to insert the group in the
de85488138247d Boris Brezillon 2024-02-29  684  	 * panthor_group::groups::waiting list.
de85488138247d Boris Brezillon 2024-02-29  685  	 */
de85488138247d Boris Brezillon 2024-02-29  686  	struct list_head wait_node;
de85488138247d Boris Brezillon 2024-02-29 @687  };
de85488138247d Boris Brezillon 2024-02-29  688  

:::::: The code at line 687 was first introduced by commit
:::::: de85488138247d034eb3241840424a54d660926b drm/panthor: Add the scheduler logical block

:::::: TO: Boris Brezillon <boris.brezillon@collabora.com>
:::::: CC: Boris Brezillon <boris.brezillon@collabora.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

