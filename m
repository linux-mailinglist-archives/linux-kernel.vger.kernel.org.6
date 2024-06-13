Return-Path: <linux-kernel+bounces-213874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A54907BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8446D28251A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7312137905;
	Thu, 13 Jun 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRo0Qi6C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C972F34
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305229; cv=none; b=el137SENiKVv1sUOQjzG174AYhlsnQSH/mwutB5ebtXTYMaOgz1Fln25K+oJB5pppR+NHlVHHUCUtm34rEeFPJoqNwwZR94DAXoCp46C3C99OqzZzP/FbrOtsubUQISTMWRpyRHab2IvzXU1jqJs+DHyMIBtMg6rJx5nO9zX0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305229; c=relaxed/simple;
	bh=lw35mx/zdF0kMz4PHiIU27JCXZsPgkesYdNkrEr9eHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FOP0S3vMH3lmQ3VONRYasNIAkysC2Yo5FA/5dZtEb00WRnX8t/L74Li7wXQizZ+k00CDDF0cVroZwSF29dhXptiAE+LE4raLh+I5oDYRKjydkKa8c9vss3jGo+mdm4qV6sjWIMuxIdXG5eD90hRDo9UFBU7W3NUxaKeKCjes968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRo0Qi6C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718305228; x=1749841228;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=lw35mx/zdF0kMz4PHiIU27JCXZsPgkesYdNkrEr9eHM=;
  b=KRo0Qi6Cr0snE3Q92yP8ps5tgciQcNt+IZcA2gFhAXICLF+fUd3KtGqj
   j5JSUG/hcMztMzWFpvsWBU7Na/YDnlLB77n+qtQnu3dT6I17pVU7a+Wxh
   fS8Wzi00KIUn/CHO66kE2cQyGr0myeEz3jsOavv90xabpYkVyo4gYAJ+r
   M1qIwKWqcayE7nOc/IeyHqb6BOa5DzPFR1F2f/e349OjsiSmRBYLHTe2o
   ZqKWqSY15/WS/+fVLXS++olMxMYtpkfDfbI/aF7jAZzUlORUG1dg4OOr5
   Sde9Qe2q3q7aHsMN1JMKNaCYFdrulL0MPfI2xGbEAn7nudRtdoagsESfs
   g==;
X-CSE-ConnectionGUID: XmWXuvMESGSVp5F3lkgwrA==
X-CSE-MsgGUID: Wd/9151gTKWltjrmxeVn9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18943710"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="18943710"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 12:00:28 -0700
X-CSE-ConnectionGUID: k15kEKVHQlSeLGHrsR+aVw==
X-CSE-MsgGUID: iZyDQ+PNSDSPrOquVdz1Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="45193576"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 12:00:25 -0700
Date: Thu, 13 Jun 2024 22:00:33 +0300
From: Imre Deak <imre.deak@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Inconsistent lock state for sbq->ws[i].wait
Message-ID: <ZmtB0USK0+zdRe0R@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the Intel GFX CI regularly triggers the WARN below, which seems to have
started with 6.5-rc1 (6.9.0-rc6 being the first version with still
available logs where I could check the stacktrace matching exactly) and
always happens on - multiple different - Sandybridge machines, but not
on any other old or new Intel platforms in our CI farm. I'm not sure
about the root cause, so thought to send this to blk-mq-sched.c and
scsi_lib.c maintainers for any clues. For the history and full logs
please see:

https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/8852

Thanks,
Imre

<4> [211.780637] ================================
<4> [211.780643] WARNING: inconsistent lock state
<4> [211.780648] 6.10.0-rc3-Patchwork_133624v5-ga7d697ac042a+ #1 Not tainted
<4> [211.780656] --------------------------------
<4> [211.780661] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
<4> [211.780668] kworker/6:2/110 [HC0[0]:SC0[0]:HE0:SE1] takes:
<4> [211.780676] ffff8881030b9218 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x4f7/0x740
<4> [211.780695] {IN-SOFTIRQ-W} state was registered at:
<4> [211.780701]   lock_acquire+0xd1/0x2f0
<4> [211.780710]   _raw_spin_lock_irqsave+0x3d/0x60
<4> [211.780719]   __wake_up_common_lock+0x1d/0x60
<4> [211.780726]   sbitmap_queue_wake_up+0x74/0xb0
<4> [211.780735]   sbitmap_queue_clear+0x3b/0x60
<4> [211.780742]   __blk_mq_free_request+0x71/0xd0
<4> [211.780750]   scsi_end_request+0xf4/0x300
<4> [211.780758]   scsi_io_completion+0x40/0x590
<4> [211.780764]   blk_complete_reqs+0x3b/0x50
<4> [211.780771]   handle_softirqs+0xbf/0x3f0
<4> [211.780778]   irq_exit_rcu+0x87/0xc0
<4> [211.780784]   common_interrupt+0xbb/0xe0
<4> [211.780793]   asm_common_interrupt+0x26/0x40
<4> [211.780801]   lock_is_held_type+0x54/0x140
<4> [211.780808]   __might_resched+0x23a/0x2b0
<4> [211.780816]   dput.part.0+0x18/0x400
<4> [211.780824]   step_into+0x3b2/0x720
<4> [211.780832]   link_path_walk.part.0+0x279/0x390
<4> [211.780840]   path_lookupat.isra.0+0x39/0x150
<4> [211.780848]   filename_lookup+0xbb/0x140
<4> [211.780856]   vfs_statx+0x84/0x190
<4> [211.780863]   vfs_fstatat+0x55/0xc0
<4> [211.780869]   __do_sys_newlstat+0x33/0x70
<4> [211.780876]   do_syscall_64+0x66/0x140
<4> [211.780883]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
<4> [211.780891] irq event stamp: 88280
<4> [211.780897] hardirqs last  enabled at (88279): [<ffffffff81d78f28>] _raw_spin_unlock_irqrestore+0x58/0x70
<4> [211.780910] hardirqs last disabled at (88280): [<ffffffff81d78bb5>] _raw_spin_lock_irq+0x45/0x50
<4> [211.780922] softirqs last  enabled at (85746): [<ffffffffa013c94a>] tg3_mdio_read+0x5a/0x90 [tg3]
<4> [211.780940] softirqs last disabled at (85744): [<ffffffffa013c924>] tg3_mdio_read+0x34/0x90 [tg3]
<4> [211.780956] 
other info that might help us debug this:
<4> [211.780963]  Possible unsafe locking scenario:
<4> [211.780971]        CPU0
<4> [211.780975]        ----
<4> [211.780979]   lock(&sbq->ws[i].wait);
<4> [211.780986]   <Interrupt>
<4> [211.780990]     lock(&sbq->ws[i].wait);
<4> [211.780996] 
 *** DEADLOCK ***
<4> [211.781004] 5 locks held by kworker/6:2/110:
<4> [211.781010]  #0: ffff888100092d48 ((wq_completion)events_freezable_pwr_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x66/0x690
<4> [211.781031]  #1: ffffc900003ebe60 ((work_completion)(&(&ev->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x66/0x690
<4> [211.781049]  #2: ffffffff8273b8c0 (rcu_read_lock){....}-{1:2}, at: blk_mq_run_hw_queue+0x137/0x430
<4> [211.781066]  #3: ffff8881030b9218 (&sbq->ws[i].wait){+.?.}-{2:2}, at: blk_mq_dispatch_rq_list+0x4f7/0x740
<4> [211.781082]  #4: ffff888106089db0 (&hctx->dispatch_wait_lock){+...}-{2:2}, at: blk_mq_dispatch_rq_list+0x515/0x740
<4> [211.781099] 
stack backtrace:
<4> [211.781105] CPU: 6 PID: 110 Comm: kworker/6:2 Not tainted 6.10.0-rc3-Patchwork_133624v5-ga7d697ac042a+ #1
<4> [211.781117] Hardware name: Dell Inc. XPS 8300  /0Y2MRG, BIOS A06 10/17/2011
<4> [211.781126] Workqueue: events_freezable_pwr_efficient disk_events_workfn (events_freezable_pwr_ef)
<4> [211.781141] Call Trace:
<4> [211.781147]  <TASK>
<4> [211.781151]  dump_stack_lvl+0x82/0xd0
<4> [211.781160]  mark_lock.part.0+0x87b/0xcd0
<4> [211.781169]  ? lock_acquire+0xd1/0x2f0
<4> [211.781178]  mark_held_locks+0x49/0x80
<4> [211.781187]  lockdep_hardirqs_on_prepare+0xf6/0x1b0
<4> [211.781195]  trace_hardirqs_on+0x4b/0xd0
<4> [211.781204]  _raw_spin_unlock_irq+0x23/0x50
<4> [211.781212]  __blk_mq_alloc_driver_tag+0x109/0x180
<4> [211.781221]  blk_mq_dispatch_rq_list+0x70b/0x740
<4> [211.781231]  __blk_mq_sched_dispatch_requests+0xa7/0x620
<4> [211.781243]  blk_mq_sched_dispatch_requests+0x27/0x60
<4> [211.781252]  blk_mq_run_hw_queue+0x161/0x430
<4> [211.781261]  blk_execute_rq+0x134/0x2b0
<4> [211.781271]  scsi_execute_cmd+0x174/0x420
<4> [211.781280]  scsi_test_unit_ready+0x6b/0x100
<4> [211.781291]  sd_check_events+0xf1/0x140
<4> [211.781300]  disk_check_events+0x38/0x100
<4> [211.781309]  process_scheduled_works+0x363/0x690
<4> [211.781318]  ? process_scheduled_works+0x66/0x690
<4> [211.781327]  ? process_scheduled_works+0x66/0x690
<4> [211.781337]  worker_thread+0x13d/0x2d0
<4> [211.781345]  ? __pfx_worker_thread+0x10/0x10
<4> [211.781354]  kthread+0xed/0x120
<4> [211.781361]  ? __pfx_kthread+0x10/0x10
<4> [211.781369]  ret_from_fork+0x2f/0x50
<4> [211.781377]  ? __pfx_kthread+0x10/0x10
<4> [211.781384]  ret_from_fork_asm+0x1a/0x30
<4> [211.781396]  </TASK>

