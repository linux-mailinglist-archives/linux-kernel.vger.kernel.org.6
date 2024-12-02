Return-Path: <linux-kernel+bounces-428416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1779E0EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6794DB2817B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2F1DF27E;
	Mon,  2 Dec 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RORq6Y59"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17B2EAF7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175764; cv=none; b=WwF501Ut9cQvPwCXwddnBA8uW9ZVxGFP19CFBcMWxAEyg/Wq7gikUbz8ZZ2JopH2aXPA/pTqBWECa2jnoFdKlScb7G1nO0hCQjaPLww+BHR1fG2fudF02w8j6ZvSeB6QAzqhpVhcDMLtp72I4XGxFaWRZXH3MR98imwRp5SkKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175764; c=relaxed/simple;
	bh=2jwePacPVZRmts5lBpLjhrOz60W9a8tz3V3O1M697dc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hpfi5Inx0rhFgu9YDuGYdq5+xvXbrBwmW9/momBJqz2RW086C1MkTlhLNfZ6zggNQrMp7aFPtgJcTZFaMtpu/bymc+hqq0ltCz7SSCHOBs1eU1TmtboSTeU14bC70ULuOlRSDIRA89K+ms6WFQoIuFWMUicJ3ZoU9YO3bFYt2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RORq6Y59; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733175763; x=1764711763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2jwePacPVZRmts5lBpLjhrOz60W9a8tz3V3O1M697dc=;
  b=RORq6Y59cl3oaWmjE5q7Kp4rv5pE712X1bacc4tUuDm1TBzn+2DsmlmL
   zL1TyiZB0vYofoyMme9FftYTCsgIUjHHGf5oW5wvw3eysfb85emMM6tY8
   hpJGwEnVk4oQTqk5byQPPLaciz1ukGjZfONtsQd0QaFtqCmeTLH6SnWmw
   5T99U1ZP6lok8d7nAKJwPBfy4YSPhMlSyVvApZyJnv0iEqGP1ArzTnDFO
   QGjuct9cLMwlMAWJBkkG0hUcDU55vx/R1D07rM3Rldy+mG68Um6KlRzle
   ezRHqnA7k9zlCuxEtUx6h+4u3ECqpD+Om34mIxK2aRkVAIBLCwMRupnyO
   Q==;
X-CSE-ConnectionGUID: CDSj1ShpQaONPb1keVngYg==
X-CSE-MsgGUID: bPI/zLpaRqGZ5U5K30UEPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44752287"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44752287"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 13:42:42 -0800
X-CSE-ConnectionGUID: jsY3CIdRTqO1kSmM8+Ga7Q==
X-CSE-MsgGUID: XdSrXGfMQ/y+sahBD3pnQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="94055715"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 13:42:41 -0800
Date: Mon, 2 Dec 2024 13:42:39 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: resctrl mount fail on v6.13-rc1
Message-ID: <Z04pz3AlvI4o0Mr8@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Anyone better a decoding lockdep dumps then me make sense of this?

All I did was build v6.13-rc1 with (among others)

CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_PROVE_RCU=y

and then mount the resctrl filesystem:

$ sudo mount -t resctrl resctrl /sys/fs/resctrl

There are only trivial changes to the resctrl code between
v6.12 (which works) and v6.13-rc1:

$ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()

So something in kernfs? Or the way resctrl uses kernfs?

-Tony


[  124.435545]
[  124.437062] ======================================================
[  124.443245] WARNING: possible circular locking dependency detected
[  124.449425] 6.13.0-rc1 #208 Not tainted
[  124.453264] ------------------------------------------------------
[  124.459443] mount/4268 is trying to acquire lock:
[  124.464149] ff20974596218178 (&sbsec->lock){+.+.}-{4:4}, at: selinux_set_mnt_opts+0x6d/0x7e0
[  124.472598]
[  124.472598] but task is already holding lock:
[  124.478427] ff2097460518f0e0 (&type->s_umount_key#75/1){+.+.}-{4:4}, at: alloc_super+0xd9/0x3d0
[  124.487128]
[  124.487128] which lock already depends on the new lock.
[  124.487128]
[  124.495300]
[  124.495300] the existing dependency chain (in reverse order) is:
[  124.502771]
[  124.502771] -> #5 (&type->s_umount_key#75/1){+.+.}-{4:4}:
[  124.509651]        lock_release+0x135/0x2c0
[  124.513846]        __mutex_unlock_slowpath+0x3a/0x2c0
[  124.518908]        rdt_get_tree+0x1b5/0x590
[  124.523103]        vfs_get_tree+0x25/0x100
[  124.527208]        path_mount+0x4c6/0xbd0
[  124.531231]        __x64_sys_mount+0x113/0x150
[  124.535675]        do_syscall_64+0x93/0x180
[  124.539871]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  124.545449]
[  124.545449] -> #4 (cpu_hotplug_lock){++++}-{0:0}:
[  124.551631]        __cpuhp_state_add_instance+0x37/0x1e0
[  124.556952]        blk_mq_alloc_and_init_hctx+0x450/0x4d0
[  124.562358]        blk_mq_realloc_hw_ctxs+0x1df/0x230
[  124.567411]        blk_mq_init_allocated_queue+0x138/0x480
[  124.572906]        blk_mq_alloc_queue+0x7a/0xd0
[  124.577437]        scsi_alloc_sdev+0x283/0x3c0
[  124.581892]        scsi_probe_and_add_lun+0x1c0/0x450
[  124.586952]        __scsi_add_device+0x10b/0x130
[  124.591569]        ata_scsi_scan_host+0x98/0x1c0
[  124.596190]        async_run_entry_fn+0x2d/0x130
[  124.600818]        process_one_work+0x212/0x700
[  124.605350]        worker_thread+0x1ca/0x380
[  124.609622]        kthread+0xdd/0x110
[  124.613298]        ret_from_fork+0x2d/0x50
[  124.617405]        ret_from_fork_asm+0x1a/0x30
[  124.621859]
[  124.621859] -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
[  124.627864]        __mutex_lock+0xd1/0xcc0
[  124.631962]        queue_attr_store+0x5d/0xa0
[  124.636330]        kernfs_fop_write_iter+0x158/0x210
[  124.641306]        vfs_write+0x2bb/0x550
[  124.645240]        ksys_write+0x70/0xf0
[  124.649078]        do_syscall_64+0x93/0x180
[  124.653265]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  124.658834]
[  124.658834] -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[  124.665622]        blk_mq_submit_bio+0x929/0xb20
[  124.670240]        __submit_bio+0x10d/0x1f0
[  124.674427]        submit_bio_noacct_nocheck+0x300/0x400
[  124.679739]        btrfs_submit_chunk+0x1a9/0x660
[  124.684453]        btrfs_submit_bbio+0x16/0x30
[  124.688899]        read_extent_buffer_pages+0x17e/0x1f0
[  124.694132]        btrfs_read_extent_buffer+0x8f/0x180
[  124.699278]        read_block_for_search+0x224/0x390
[  124.704246]        btrfs_search_slot+0x2f0/0xd10
[  124.708865]        btrfs_init_root_free_objectid+0x8e/0x130
[  124.714446]        btrfs_get_root_ref+0x20d/0x3a0
[  124.719149]        btrfs_lookup_dentry+0x58d/0x610
[  124.723942]        btrfs_lookup+0xe/0x30
[  124.727870]        __lookup_slow+0xfc/0x1b0
[  124.732063]        walk_component+0xdb/0x150
[  124.736336]        path_lookupat+0x6a/0x1a0
[  124.740519]        filename_lookup+0xee/0x1f0
[  124.744880]        vfs_path_lookup+0x4e/0x80
[  124.749150]        mount_subtree+0x87/0x130
[  124.753337]        btrfs_get_tree+0x32b/0x790
[  124.757696]        vfs_get_tree+0x25/0x100
[  124.761795]        path_mount+0x4c6/0xbd0
[  124.765807]        __x64_sys_mount+0x113/0x150
[  124.770252]        do_syscall_64+0x93/0x180
[  124.774438]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  124.780009]
[  124.780009] -> #1 (btrfs-tree-00){++++}-{4:4}:
[  124.785931]        down_read_nested+0x30/0x170
[  124.790383]        btrfs_tree_read_lock_nested+0x21/0xd0
[  124.795696]        btrfs_read_lock_root_node+0x40/0xd0
[  124.800833]        btrfs_search_slot+0x144/0xd10
[  124.805454]        btrfs_lookup_xattr+0x8b/0xf0
[  124.809985]        btrfs_getxattr+0x55/0x110
[  124.814257]        __vfs_getxattr+0x7b/0xb0
[  124.818446]        sb_finish_set_opts+0x1ad/0x340
[  124.823151]        selinux_set_mnt_opts+0x408/0x7e0
[  124.828030]        iterate_supers+0x77/0xe0
[  124.832214]        selinux_policy_commit+0x2d1/0x2f0
[  124.837179]        sel_write_load+0x506/0xb90
[  124.841539]        vfs_write+0xf5/0x550
[  124.845379]        ksys_write+0x70/0xf0
[  124.849218]        do_syscall_64+0x93/0x180
[  124.853403]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  124.858975]
[  124.858975] -> #0 (&sbsec->lock){+.+.}-{4:4}:
[  124.864806]        __lock_acquire+0x1425/0x21d0
[  124.869339]        lock_acquire+0xd5/0x300
[  124.873439]        __mutex_lock+0xd1/0xcc0
[  124.877538]        selinux_set_mnt_opts+0x6d/0x7e0
[  124.882330]        security_sb_set_mnt_opts+0x50/0x80
[  124.887389]        vfs_get_tree+0x7d/0x100
[  124.891489]        path_mount+0x4c6/0xbd0
[  124.895502]        __x64_sys_mount+0x113/0x150
[  124.899947]        do_syscall_64+0x93/0x180
[  124.904134]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  124.909703]
[  124.909703] other info that might help us debug this:
[  124.909703]
[  124.917695] Chain exists of:
[  124.917695]   &sbsec->lock --> cpu_hotplug_lock --> &type->s_umount_key#75/1
[  124.917695]
[  124.929081]  Possible unsafe locking scenario:
[  124.929081]
[  124.934994]        CPU0                    CPU1
[  124.939523]        ----                    ----
[  124.944049]   lock(&type->s_umount_key#75/1);
[  124.948406]                                lock(cpu_hotplug_lock);
[  124.954587]                                lock(&type->s_umount_key#75/1);
[  124.961458]   lock(&sbsec->lock);
[  124.964778]
[  124.964778]  *** DEADLOCK ***
[  124.964778]
[  124.970695] 1 lock held by mount/4268:
[  124.974446]  #0: ff2097460518f0e0 (&type->s_umount_key#75/1){+.+.}-{4:4}, at: alloc_super+0xd9/0x3d0
[  124.983583]
[  124.983583] stack backtrace:
[  124.987943] CPU: 85 UID: 0 PID: 4268 Comm: mount Not tainted 6.13.0-rc1 #208
[  124.994995] Hardware name: Intel Corporation WilsonCity/WilsonCity, BIOS WLYDCRB1.SYS.0021.P06.2104260458 04/26/2021
[  125.005508] Call Trace:
[  125.007962]  <TASK>
[  125.010067]  dump_stack_lvl+0x73/0xb0
[  125.013742]  print_circular_bug+0x26e/0x340
[  125.017927]  check_noncircular+0x148/0x160
[  125.022025]  __lock_acquire+0x1425/0x21d0
[  125.026036]  lock_acquire+0xd5/0x300
[  125.029616]  ? selinux_set_mnt_opts+0x6d/0x7e0
[  125.034064]  __mutex_lock+0xd1/0xcc0
[  125.037639]  ? selinux_set_mnt_opts+0x6d/0x7e0
[  125.042085]  ? reacquire_held_locks+0xd1/0x1f0
[  125.046531]  ? selinux_set_mnt_opts+0x6d/0x7e0
[  125.050975]  ? reacquire_held_locks+0xd1/0x1f0
[  125.055425]  ? selinux_set_mnt_opts+0x6d/0x7e0
[  125.059877]  selinux_set_mnt_opts+0x6d/0x7e0
[  125.064152]  security_sb_set_mnt_opts+0x50/0x80
[  125.068691]  vfs_get_tree+0x7d/0x100
[  125.072270]  ? capable+0x32/0x60
[  125.075511]  path_mount+0x4c6/0xbd0
[  125.079005]  __x64_sys_mount+0x113/0x150
[  125.082937]  do_syscall_64+0x93/0x180
[  125.086603]  ? do_syscall_64+0x9f/0x180
[  125.090440]  ? lockdep_hardirqs_on+0x7b/0x100
[  125.094799]  ? do_syscall_64+0x9f/0x180
[  125.098638]  ? do_syscall_64+0x9f/0x180
[  125.102478]  ? lockdep_hardirqs_on+0x7b/0x100
[  125.106838]  ? do_syscall_64+0x9f/0x180
[  125.110676]  ? do_user_addr_fault+0x359/0x790
[  125.115043]  ? exc_page_fault+0x126/0x280
[  125.119057]  ? clear_bhb_loop+0x45/0xa0
[  125.122893]  ? clear_bhb_loop+0x45/0xa0
[  125.126736]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  125.131788] RIP: 0033:0x7fead6d8cc9e
[  125.135374] Code: 48 8b 0d 6d 11 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3a 11 0c 00 f7 d8 64 89 01 48
[  125.154119] RSP: 002b:00007ffcd6f80798 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  125.161684] RAX: ffffffffffffffda RBX: 000056371f46f550 RCX: 00007fead6d8cc9e
[  125.168815] RDX: 000056371f46f780 RSI: 000056371f46f7c0 RDI: 000056371f46f7a0
[  125.175949] RBP: 00007ffcd6f808c0 R08: 0000000000000000 R09: 0000000000000001
[  125.183080] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  125.190210] R13: 000056371f46f7a0 R14: 000056371f46f780 R15: 00007fead6ebd076
[  125.197339]  </TASK>


