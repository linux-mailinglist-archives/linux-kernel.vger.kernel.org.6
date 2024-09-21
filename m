Return-Path: <linux-kernel+bounces-334893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFA97DE07
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A21B213B5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6AB177992;
	Sat, 21 Sep 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci5KRYMe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF9178363
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937884; cv=none; b=SuZ7N1x5QOTVlmoVmSzJQPITPVK8D+jY1/MvMD8ct5N2dVAiDsIeR6DHRDl2+jFjTMepZUgQGYdbaJLHXythTIHoVtuQbtG3wSTDlQCkqqOt+oneEtlCsedI6XdplTWrQJR0CqylJepuE036rLSp0GPdUGSSEFGx9/G+B07Ieb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937884; c=relaxed/simple;
	bh=i/nnjI0ViTimAwem0aVad0+BDc21UD4S2ik361G0iQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvEgVT0fUBhKQmDa1Nh3yFyCXDgQiUnNKlrUlVJz1VHn5OFcvYphwQ6MRa9Igx83/WyrS/oG9GVxAixTqgEXtVzFgIM4+hBsSK7atDTK9u33jfohCU+bMbJCTdVyAAnIWOeuOF6xVLNlCr78Xs9oYjxQNpm0M8K6UJxe+MXU42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci5KRYMe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726937882; x=1758473882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/nnjI0ViTimAwem0aVad0+BDc21UD4S2ik361G0iQg=;
  b=Ci5KRYMeU6CsNksycP80YvQ/nmFR6ZovtAD+eU/zLhwyZtaQs5g9H4wT
   lUbjFSiorBDCHO+LxMKzxUQTKgnSNF0laLHTrls7EVUfiD+VO5ss3g0co
   QhZAJoLFcK462Jnz1BMWvGPs4hYFtTtAaE4wFHHAjSJ1u84lmCrRqOyqe
   SeGrOudN6LpKTMACzdX6qkgmiuv4Gpm4RO2x1NI8jyDZi2ykDmvjxfoyo
   8wnLTWGkdP3Wdq56wJ/lsGhzmAVurHE/bAs9RKN+GatTO5Vo29dCvQKM1
   CRyzKX396yVexnSb+yFiKULg8DeL3+z70Xj9dpSIAFg6TigtETN7rSS6l
   Q==;
X-CSE-ConnectionGUID: J1XKLL1bS6S1qAcrGEwjTg==
X-CSE-MsgGUID: LZBD7ocGTy264X3eUx4YCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36592240"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="36592240"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 09:58:01 -0700
X-CSE-ConnectionGUID: Q0Z8ZYNiSJSIQmHGIi5+eA==
X-CSE-MsgGUID: J+XTM455TaOuDL+8hEif8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="75398057"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Sep 2024 09:57:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss3Qg-000FcB-2w;
	Sat, 21 Sep 2024 16:57:54 +0000
Date: Sun, 22 Sep 2024 00:57:18 +0800
From: kernel test robot <lkp@intel.com>
To: Mary Guillemard <mary.guillemard@collabora.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Boris Brezillon <bbrezillon@kernel.org>,
	Christopher Healy <healych@amazon.com>, kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm/panthor: Add csg_priority to panthor_group
Message-ID: <202409220025.v4cCQjaI-lkp@intel.com>
References: <20240918085056.24422-3-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918085056.24422-3-mary.guillemard@collabora.com>

Hi Mary,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.11 next-20240920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mary-Guillemard/drm-panthor-Add-csg_priority-to-panthor_group/20240918-165602
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20240918085056.24422-3-mary.guillemard%40collabora.com
patch subject: [PATCH 1/2] drm/panthor: Add csg_priority to panthor_group
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240922/202409220025.v4cCQjaI-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220025.v4cCQjaI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220025.v4cCQjaI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/panthor/panthor_sched.c:319: warning: Excess struct member 'runnable' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:319: warning: Excess struct member 'idle' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:319: warning: Excess struct member 'waiting' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:319: warning: Excess struct member 'has_ref' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:319: warning: Excess struct member 'in_progress' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:319: warning: Excess struct member 'stopped_groups' description in 'panthor_scheduler'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'mem' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'input' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'output' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'input_fw_va' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'output_fw_va' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'gpu_va' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'ref' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'gt' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'sync64' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'bo' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'offset' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'kmap' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'lock' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'id' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'seqno' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'last_fence' description in 'panthor_queue'
   drivers/gpu/drm/panthor/panthor_sched.c:479: warning: Excess struct member 'in_flight_jobs' description in 'panthor_queue'
>> drivers/gpu/drm/panthor/panthor_sched.c:669: warning: Function parameter or struct member 'csg_priority' not described in 'panthor_group'
   drivers/gpu/drm/panthor/panthor_sched.c:784: warning: Excess struct member 'start' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:784: warning: Excess struct member 'size' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:784: warning: Excess struct member 'latest_flush' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:784: warning: Excess struct member 'start' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:784: warning: Excess struct member 'end' description in 'panthor_job'
   drivers/gpu/drm/panthor/panthor_sched.c:1707: warning: Function parameter or struct member 'ptdev' not described in 'panthor_sched_report_fw_events'
   drivers/gpu/drm/panthor/panthor_sched.c:1707: warning: Function parameter or struct member 'events' not described in 'panthor_sched_report_fw_events'
   drivers/gpu/drm/panthor/panthor_sched.c:2602: warning: Function parameter or struct member 'ptdev' not described in 'panthor_sched_report_mmu_fault'


vim +669 drivers/gpu/drm/panthor/panthor_sched.c

de85488138247d Boris Brezillon 2024-02-29  516  
de85488138247d Boris Brezillon 2024-02-29  517  /**
de85488138247d Boris Brezillon 2024-02-29  518   * struct panthor_group - Scheduling group object
de85488138247d Boris Brezillon 2024-02-29  519   */
de85488138247d Boris Brezillon 2024-02-29  520  struct panthor_group {
de85488138247d Boris Brezillon 2024-02-29  521  	/** @refcount: Reference count */
de85488138247d Boris Brezillon 2024-02-29  522  	struct kref refcount;
de85488138247d Boris Brezillon 2024-02-29  523  
de85488138247d Boris Brezillon 2024-02-29  524  	/** @ptdev: Device. */
de85488138247d Boris Brezillon 2024-02-29  525  	struct panthor_device *ptdev;
de85488138247d Boris Brezillon 2024-02-29  526  
de85488138247d Boris Brezillon 2024-02-29  527  	/** @vm: VM bound to the group. */
de85488138247d Boris Brezillon 2024-02-29  528  	struct panthor_vm *vm;
de85488138247d Boris Brezillon 2024-02-29  529  
de85488138247d Boris Brezillon 2024-02-29  530  	/** @compute_core_mask: Mask of shader cores that can be used for compute jobs. */
de85488138247d Boris Brezillon 2024-02-29  531  	u64 compute_core_mask;
de85488138247d Boris Brezillon 2024-02-29  532  
de85488138247d Boris Brezillon 2024-02-29  533  	/** @fragment_core_mask: Mask of shader cores that can be used for fragment jobs. */
de85488138247d Boris Brezillon 2024-02-29  534  	u64 fragment_core_mask;
de85488138247d Boris Brezillon 2024-02-29  535  
de85488138247d Boris Brezillon 2024-02-29  536  	/** @tiler_core_mask: Mask of tiler cores that can be used for tiler jobs. */
de85488138247d Boris Brezillon 2024-02-29  537  	u64 tiler_core_mask;
de85488138247d Boris Brezillon 2024-02-29  538  
de85488138247d Boris Brezillon 2024-02-29  539  	/** @max_compute_cores: Maximum number of shader cores used for compute jobs. */
de85488138247d Boris Brezillon 2024-02-29  540  	u8 max_compute_cores;
de85488138247d Boris Brezillon 2024-02-29  541  
be7ffc821f5fc2 Liviu Dudau     2024-04-02  542  	/** @max_fragment_cores: Maximum number of shader cores used for fragment jobs. */
de85488138247d Boris Brezillon 2024-02-29  543  	u8 max_fragment_cores;
de85488138247d Boris Brezillon 2024-02-29  544  
de85488138247d Boris Brezillon 2024-02-29  545  	/** @max_tiler_cores: Maximum number of tiler cores used for tiler jobs. */
de85488138247d Boris Brezillon 2024-02-29  546  	u8 max_tiler_cores;
de85488138247d Boris Brezillon 2024-02-29  547  
de85488138247d Boris Brezillon 2024-02-29  548  	/** @priority: Group priority (check panthor_csg_priority). */
de85488138247d Boris Brezillon 2024-02-29  549  	u8 priority;
de85488138247d Boris Brezillon 2024-02-29  550  
de85488138247d Boris Brezillon 2024-02-29  551  	/** @blocked_queues: Bitmask reflecting the blocked queues. */
de85488138247d Boris Brezillon 2024-02-29  552  	u32 blocked_queues;
de85488138247d Boris Brezillon 2024-02-29  553  
de85488138247d Boris Brezillon 2024-02-29  554  	/** @idle_queues: Bitmask reflecting the idle queues. */
de85488138247d Boris Brezillon 2024-02-29  555  	u32 idle_queues;
de85488138247d Boris Brezillon 2024-02-29  556  
de85488138247d Boris Brezillon 2024-02-29  557  	/** @fatal_lock: Lock used to protect access to fatal fields. */
de85488138247d Boris Brezillon 2024-02-29  558  	spinlock_t fatal_lock;
de85488138247d Boris Brezillon 2024-02-29  559  
de85488138247d Boris Brezillon 2024-02-29  560  	/** @fatal_queues: Bitmask reflecting the queues that hit a fatal exception. */
de85488138247d Boris Brezillon 2024-02-29  561  	u32 fatal_queues;
de85488138247d Boris Brezillon 2024-02-29  562  
de85488138247d Boris Brezillon 2024-02-29  563  	/** @tiler_oom: Mask of queues that have a tiler OOM event to process. */
de85488138247d Boris Brezillon 2024-02-29  564  	atomic_t tiler_oom;
de85488138247d Boris Brezillon 2024-02-29  565  
de85488138247d Boris Brezillon 2024-02-29  566  	/** @queue_count: Number of queues in this group. */
de85488138247d Boris Brezillon 2024-02-29  567  	u32 queue_count;
de85488138247d Boris Brezillon 2024-02-29  568  
de85488138247d Boris Brezillon 2024-02-29  569  	/** @queues: Queues owned by this group. */
de85488138247d Boris Brezillon 2024-02-29  570  	struct panthor_queue *queues[MAX_CS_PER_CSG];
de85488138247d Boris Brezillon 2024-02-29  571  
de85488138247d Boris Brezillon 2024-02-29  572  	/**
de85488138247d Boris Brezillon 2024-02-29  573  	 * @csg_id: ID of the FW group slot.
de85488138247d Boris Brezillon 2024-02-29  574  	 *
de85488138247d Boris Brezillon 2024-02-29  575  	 * -1 when the group is not scheduled/active.
de85488138247d Boris Brezillon 2024-02-29  576  	 */
de85488138247d Boris Brezillon 2024-02-29  577  	int csg_id;
de85488138247d Boris Brezillon 2024-02-29  578  
474e5b301372a6 Mary Guillemard 2024-09-18  579  	/**
474e5b301372a6 Mary Guillemard 2024-09-18  580  	 * @csg_id: Priority of the FW group slot.
474e5b301372a6 Mary Guillemard 2024-09-18  581  	 *
474e5b301372a6 Mary Guillemard 2024-09-18  582  	 * -1 when the group is not scheduled/active.
474e5b301372a6 Mary Guillemard 2024-09-18  583  	 */
474e5b301372a6 Mary Guillemard 2024-09-18  584  	int csg_priority;
474e5b301372a6 Mary Guillemard 2024-09-18  585  
de85488138247d Boris Brezillon 2024-02-29  586  	/**
de85488138247d Boris Brezillon 2024-02-29  587  	 * @destroyed: True when the group has been destroyed.
de85488138247d Boris Brezillon 2024-02-29  588  	 *
de85488138247d Boris Brezillon 2024-02-29  589  	 * If a group is destroyed it becomes useless: no further jobs can be submitted
de85488138247d Boris Brezillon 2024-02-29  590  	 * to its queues. We simply wait for all references to be dropped so we can
de85488138247d Boris Brezillon 2024-02-29  591  	 * release the group object.
de85488138247d Boris Brezillon 2024-02-29  592  	 */
de85488138247d Boris Brezillon 2024-02-29  593  	bool destroyed;
de85488138247d Boris Brezillon 2024-02-29  594  
de85488138247d Boris Brezillon 2024-02-29  595  	/**
de85488138247d Boris Brezillon 2024-02-29  596  	 * @timedout: True when a timeout occurred on any of the queues owned by
de85488138247d Boris Brezillon 2024-02-29  597  	 * this group.
de85488138247d Boris Brezillon 2024-02-29  598  	 *
de85488138247d Boris Brezillon 2024-02-29  599  	 * Timeouts can be reported by drm_sched or by the FW. In any case, any
de85488138247d Boris Brezillon 2024-02-29  600  	 * timeout situation is unrecoverable, and the group becomes useless.
de85488138247d Boris Brezillon 2024-02-29  601  	 * We simply wait for all references to be dropped so we can release the
de85488138247d Boris Brezillon 2024-02-29  602  	 * group object.
de85488138247d Boris Brezillon 2024-02-29  603  	 */
de85488138247d Boris Brezillon 2024-02-29  604  	bool timedout;
de85488138247d Boris Brezillon 2024-02-29  605  
de85488138247d Boris Brezillon 2024-02-29  606  	/**
de85488138247d Boris Brezillon 2024-02-29  607  	 * @syncobjs: Pool of per-queue synchronization objects.
de85488138247d Boris Brezillon 2024-02-29  608  	 *
de85488138247d Boris Brezillon 2024-02-29  609  	 * One sync object per queue. The position of the sync object is
de85488138247d Boris Brezillon 2024-02-29  610  	 * determined by the queue index.
de85488138247d Boris Brezillon 2024-02-29  611  	 */
de85488138247d Boris Brezillon 2024-02-29  612  	struct panthor_kernel_bo *syncobjs;
de85488138247d Boris Brezillon 2024-02-29  613  
de85488138247d Boris Brezillon 2024-02-29  614  	/** @state: Group state. */
de85488138247d Boris Brezillon 2024-02-29  615  	enum panthor_group_state state;
de85488138247d Boris Brezillon 2024-02-29  616  
de85488138247d Boris Brezillon 2024-02-29  617  	/**
de85488138247d Boris Brezillon 2024-02-29  618  	 * @suspend_buf: Suspend buffer.
de85488138247d Boris Brezillon 2024-02-29  619  	 *
de85488138247d Boris Brezillon 2024-02-29  620  	 * Stores the state of the group and its queues when a group is suspended.
de85488138247d Boris Brezillon 2024-02-29  621  	 * Used at resume time to restore the group in its previous state.
de85488138247d Boris Brezillon 2024-02-29  622  	 *
de85488138247d Boris Brezillon 2024-02-29  623  	 * The size of the suspend buffer is exposed through the FW interface.
de85488138247d Boris Brezillon 2024-02-29  624  	 */
de85488138247d Boris Brezillon 2024-02-29  625  	struct panthor_kernel_bo *suspend_buf;
de85488138247d Boris Brezillon 2024-02-29  626  
de85488138247d Boris Brezillon 2024-02-29  627  	/**
de85488138247d Boris Brezillon 2024-02-29  628  	 * @protm_suspend_buf: Protection mode suspend buffer.
de85488138247d Boris Brezillon 2024-02-29  629  	 *
de85488138247d Boris Brezillon 2024-02-29  630  	 * Stores the state of the group and its queues when a group that's in
de85488138247d Boris Brezillon 2024-02-29  631  	 * protection mode is suspended.
de85488138247d Boris Brezillon 2024-02-29  632  	 *
de85488138247d Boris Brezillon 2024-02-29  633  	 * Used at resume time to restore the group in its previous state.
de85488138247d Boris Brezillon 2024-02-29  634  	 *
de85488138247d Boris Brezillon 2024-02-29  635  	 * The size of the protection mode suspend buffer is exposed through the
de85488138247d Boris Brezillon 2024-02-29  636  	 * FW interface.
de85488138247d Boris Brezillon 2024-02-29  637  	 */
de85488138247d Boris Brezillon 2024-02-29  638  	struct panthor_kernel_bo *protm_suspend_buf;
de85488138247d Boris Brezillon 2024-02-29  639  
de85488138247d Boris Brezillon 2024-02-29  640  	/** @sync_upd_work: Work used to check/signal job fences. */
de85488138247d Boris Brezillon 2024-02-29  641  	struct work_struct sync_upd_work;
de85488138247d Boris Brezillon 2024-02-29  642  
de85488138247d Boris Brezillon 2024-02-29  643  	/** @tiler_oom_work: Work used to process tiler OOM events happening on this group. */
de85488138247d Boris Brezillon 2024-02-29  644  	struct work_struct tiler_oom_work;
de85488138247d Boris Brezillon 2024-02-29  645  
de85488138247d Boris Brezillon 2024-02-29  646  	/** @term_work: Work used to finish the group termination procedure. */
de85488138247d Boris Brezillon 2024-02-29  647  	struct work_struct term_work;
de85488138247d Boris Brezillon 2024-02-29  648  
de85488138247d Boris Brezillon 2024-02-29  649  	/**
de85488138247d Boris Brezillon 2024-02-29  650  	 * @release_work: Work used to release group resources.
de85488138247d Boris Brezillon 2024-02-29  651  	 *
de85488138247d Boris Brezillon 2024-02-29  652  	 * We need to postpone the group release to avoid a deadlock when
de85488138247d Boris Brezillon 2024-02-29  653  	 * the last ref is released in the tick work.
de85488138247d Boris Brezillon 2024-02-29  654  	 */
de85488138247d Boris Brezillon 2024-02-29  655  	struct work_struct release_work;
de85488138247d Boris Brezillon 2024-02-29  656  
de85488138247d Boris Brezillon 2024-02-29  657  	/**
de85488138247d Boris Brezillon 2024-02-29  658  	 * @run_node: Node used to insert the group in the
de85488138247d Boris Brezillon 2024-02-29  659  	 * panthor_group::groups::{runnable,idle} and
de85488138247d Boris Brezillon 2024-02-29  660  	 * panthor_group::reset.stopped_groups lists.
de85488138247d Boris Brezillon 2024-02-29  661  	 */
de85488138247d Boris Brezillon 2024-02-29  662  	struct list_head run_node;
de85488138247d Boris Brezillon 2024-02-29  663  
de85488138247d Boris Brezillon 2024-02-29  664  	/**
de85488138247d Boris Brezillon 2024-02-29  665  	 * @wait_node: Node used to insert the group in the
de85488138247d Boris Brezillon 2024-02-29  666  	 * panthor_group::groups::waiting list.
de85488138247d Boris Brezillon 2024-02-29  667  	 */
de85488138247d Boris Brezillon 2024-02-29  668  	struct list_head wait_node;
de85488138247d Boris Brezillon 2024-02-29 @669  };
de85488138247d Boris Brezillon 2024-02-29  670  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

