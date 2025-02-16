Return-Path: <linux-kernel+bounces-516617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956B8A374C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C323A711B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D121993A3;
	Sun, 16 Feb 2025 14:42:21 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E2199238
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739716940; cv=none; b=ZDysf4MEDDKZsAYzEGf9OXSXlDMuwgv1Y2JanloPHh7STL2x//AiMmwKscdrCJ1LCp951SpPApwQrT1tDeS5S4dXSweMqqWrsXPUziGAQKJGy2GWUmj4kQam5Rvz1sZhWih2b3tO7f2unCbmOymRwElt3f2loOxNrZZpHFcESws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739716940; c=relaxed/simple;
	bh=SNAnre4C1rkz/IQaNPOR108QvdoPVBTVJsLJn6js8tY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bEeaHIWphBbYDruTDolKn+hmjk8/Gd6SzkUtCGe3UNAToTKG3h64LIaH2rpc4EyNnk0FMRGhEPQnS+5h7yRxsemSuXgMRtdh/a8fABB6c7mzx6rN6klJnccSBYRzEZzh1zGCURyucA7NtniYU+4SULmMdP++N+EwD3pPUeoqHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d18700311dso24959255ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 06:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739716937; x=1740321737;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vm7iqTfgi6IX3RNdT0GJ5kaQ96uQfyi6vZLs2hXMR4I=;
        b=RRl/q+IbvsLxdSdWEJa4LguOLr2x1LHCb60RCJst/fjOaQ80n7KrggmmLwwKcEv28e
         i1mXIg1WJvcM1gE287KXrxV+g4ztlYA31R9T3wTejU6Q8NjAoRARwYChAtsswmU8L7Mm
         udaTkRH96NraHbnHr9uBKvYytDg7CRvMKVCLGKvgxcCzvHbcbtfp2srQUo1qXJjsSoBb
         O8QGtNC1qk/FMUf41zUKiRkCX3DBfNG255zEEVQaO6YkKlMA8idCScoFoBd+NcEswYfr
         MMCxlrre7g2IoTgrFU0NjzY1Uqmj5C7Uw118J/cl2f3H/qZUqGB7M4dTSv+5P94xHbOx
         WF/A==
X-Forwarded-Encrypted: i=1; AJvYcCUviogi3uY3X2nxm1uEXV9FUbwQqxM8tzFMF3bEgd5k/JL2+7DsZTsEAtqKKTDmIKRUm1qOqv9zeOfOOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwpQe61L0dsTDYh7ST006D96ER6REQdSCMBqTHAN6UvBsH+PC
	QZKVIw7q6YfDv0O2GoY9NumpRwoLST4G46/bWcsHx9vSNs16fkZUi3aslMBw7n2QjUuJ/wnRY7Y
	eO9QaD4up5eyERk8tA8AExs5WdeOnE+bqbA8CYfT4USttDO+QRUT1rzA=
X-Google-Smtp-Source: AGHT+IEJF+SqeValIVWmyI4LBphtTNJzYhNFdVGtRJmRd3PXt4YDhlVMl1of06N1G/TGWBo8HUeacgC88gwUwZY37pBzAIpuZTYw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3cf:bb11:a3a7 with SMTP id
 e9e14a558f8ab-3d280947db4mr47537025ab.17.1739716937560; Sun, 16 Feb 2025
 06:42:17 -0800 (PST)
Date: Sun, 16 Feb 2025 06:42:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b1f949.050a0220.173698.000c.GAE@google.com>
Subject: [syzbot] [kernel?] possible deadlock in get_partial_node (2)
From: syzbot <syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D11d849b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3c2347dd6174fbe=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3D725322cc4ff5c53ab=
fac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-09fbf3d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/835b3d29c46c/vmlinux-=
09fbf3d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff4bfd8a5d42/bzI=
mage-09fbf3d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=3Dmetadata_che=
cksum=3Dnone,data_checksum=3Dnone,compression=3Dlz4,erasure_code,fsck,norec=
overy,nojournal_transaction_names,reconstruct_alloc,nocow,no_data_io
bcachefs (loop0): recovering from clean shutdown, journal seq 10
bcachefs (loop0): Version upgrade required:
Version upgrade from 0.24: unwritten_extents to 1.7: mi_btree_bitmap incomp=
lete
Doing incompatible version upgrade from 0.24: unwritten_extents to 1.20: di=
rectory_size
  running recovery passes: check_allocations,check_alloc_info,check_lrus,ch=
eck_btree_backpointers,check_backpointers_to_extents,check_extents_to_backp=
ointers,check_alloc_to_lru_refs,bucket_gens_init,check_snapshot_trees,check=
_snapshots,check_subvols,check_subvol_children,delete_dead_snapshots,check_=
inodes,check_extents,check_indirect_extents,check_dirents,check_xattrs,chec=
k_root,check_unreachable_inodes,check_subvolume_structure,check_directory_s=
tructure,check_nlinks,set_fs_needs_rebalance
bcachefs (loop0): dropping and reconstructing all alloc info
bcachefs (loop0): error validating btree node on loop0 at btree xattrs leve=
l 0/0
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 2285c34bed0abe32 writ=
ten 16 min_key POS_MIN durability: 1 ptr: 0:31:0 gen 0 =20
  node offset 0/16 bset u64s 60928: bset past end of btree node (offset 0 l=
en 960 but written 16), exiting
bcachefs (loop0): Unable to continue, halting
bcachefs (loop0): flagging btree xattrs lost data
bcachefs (loop0): running explicit recovery pass check_topology (2), curren=
tly at recovery_pass_empty (0)
bcachefs (loop0): running explicit recovery pass scan_for_btree_nodes (1), =
currently at recovery_pass_empty (0)
error reading btree root btree=3Dxattrs level=3D0: btree_node_read_error, f=
ixing
invalid bkey in btree_node btree=3Dsubvolumes level=3D0: u64s 7 type subvol=
ume 0:1:0 len 0 ver 0: root 4096 snapshot id 0
  invalid snapshot: delete?, fixing
bcachefs (loop0): scan_for_btree_nodes...
bcachefs (loop0): btree node scan found 7 nodes after overwrites
 done
bcachefs (loop0): check_topology...
bcachefs (loop0): btree root xattrs unreadable, must recover from scan
bcachefs (loop0): bch2_get_scanned_nodes(): recovery btree=3Dxattrs level=
=3D0 POS_MIN - SPOS_MAX
bcachefs (loop0): bch2_get_scanned_nodes(): recovering u64s 11 type btree_p=
tr_v2 SPOS_MAX len 0 ver 0: seq 2285c34bed0abe32 written 960 min_key POS_MI=
N durability: 1 ptr: 0:31:0 gen 0
empty interior btree node at btree=3Dxattrs level=3D1
u64s 5 type btree_ptr SPOS_MAX len 0 ver 0, fixing
bcachefs (loop0): empty btree root xattrs
 done
bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): done starting filesystem
bcachefs (loop0): missing subvolume 1
bcachefs (loop0): inconsistency detected - emergency read only at journal s=
eq 10
bcachefs (loop0): bch2_fs_get_tree(): error mounting: error getting root in=
ode ENOENT_bkey_type_mismatch
bcachefs (loop0): shutting down
bcachefs (loop0): shutdown complete
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.14.0-rc2-syzkaller-00039-g09fbf3d50205 #0 Not tainted
------------------------------------------------------
syz.0.0/5321 is trying to acquire lock:
ffffffff8e814418 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x20/0x=
a0 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff888040e446d8 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/lin=
ux/spinlock.h:376 [inline]
ffff888040e446d8 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:56=
09 [inline]
ffff888040e446d8 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0x9=
c/0x430 mm/slub.c:5647

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&n->list_lock){-.-.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       get_partial_node+0x37/0x3f0 mm/slub.c:2834
       get_partial mm/slub.c:2948 [inline]
       ___slab_alloc+0xb75/0x14a0 mm/slub.c:3806
       __slab_alloc+0x58/0xa0 mm/slub.c:3916
       __slab_alloc_node mm/slub.c:3991 [inline]
       slab_alloc_node mm/slub.c:4152 [inline]
       kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4171
       kmem_alloc_batch lib/debugobjects.c:371 [inline]
       fill_pool+0x260/0x680 lib/debugobjects.c:403
       debug_objects_fill_pool lib/debugobjects.c:725 [inline]
       debug_object_activate+0x493/0x580 lib/debugobjects.c:814
       debug_hrtimer_activate kernel/time/hrtimer.c:455 [inline]
       debug_activate kernel/time/hrtimer.c:496 [inline]
       enqueue_hrtimer+0x30/0x3c0 kernel/time/hrtimer.c:1100
       __hrtimer_start_range_ns kernel/time/hrtimer.c:1282 [inline]
       hrtimer_start_range_ns+0xcc3/0xfa0 kernel/time/hrtimer.c:1343
       schedule_hrtimeout_range_clock+0x158/0x320 kernel/time/sleep_timeout=
.c:213
       ep_poll fs/eventpoll.c:2099 [inline]
       do_epoll_wait+0x1db4/0x21c0 fs/eventpoll.c:2484
       __do_sys_epoll_wait fs/eventpoll.c:2492 [inline]
       __se_sys_epoll_wait fs/eventpoll.c:2487 [inline]
       __x64_sys_epoll_wait+0x257/0x2a0 fs/eventpoll.c:2487
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:181 [inline]
       hrtimer_start_range_ns+0xf9/0xfa0 kernel/time/hrtimer.c:1341
       hrtimer_start include/linux/hrtimer.h:260 [inline]
       start_dl_timer+0x36a/0x4e0 kernel/sched/deadline.c:1190
       enqueue_dl_entity+0x1056/0x1db0 kernel/sched/deadline.c:2076
       dl_server_start+0xe2/0x2a0 kernel/sched/deadline.c:1671
       enqueue_task_fair+0x9d7/0xd40 kernel/sched/fair.c:7010
       enqueue_task+0x73/0x3d0 kernel/sched/core.c:2069
       activate_task kernel/sched/core.c:2116 [inline]
       wake_up_new_task+0x576/0xc70 kernel/sched/core.c:4878
       kernel_clone+0x4ee/0x8e0 kernel/fork.c:2846
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2893
       rest_init+0x23/0x300 init/main.c:708
       start_kernel+0x484/0x510 init/main.c:1099
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:515
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:496
       common_startup_64+0x13e/0x147

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
       raw_spin_rq_lock kernel/sched/sched.h:1521 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:700
       cgroup_move_task+0x9b/0x5a0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x256/0x880 kernel/cgroup/cgroup.c:6691
       copy_process+0x39e9/0x3d50 kernel/fork.c:2629
       kernel_clone+0x226/0x8e0 kernel/fork.c:2815
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2893
       rest_init+0x23/0x300 init/main.c:708
       start_kernel+0x484/0x510 init/main.c:1099
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:515
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:496
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 =
[inline]
       try_to_wake_up+0xc2/0x1470 kernel/sched/core.c:4213
       up+0x72/0x90 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:343 [inline]
       __console_unlock+0x123/0x1f0 kernel/printk/printk.c:2869
       __console_flush_and_unlock kernel/printk/printk.c:3271 [inline]
       console_unlock+0x18f/0x3b0 kernel/printk/printk.c:3309
       vga_remove_vgacon+0xbe/0xd0 drivers/pci/vgaarb.c:186
       virtio_gpu_pci_quirk drivers/gpu/drm/virtio/virtgpu_drv.c:62 [inline=
]
       virtio_gpu_probe+0x33f/0x3c0 drivers/gpu/drm/virtio/virtgpu_drv.c:93
       virtio_dev_probe+0x931/0xc80 drivers/virtio/virtio.c:341
       really_probe+0x2b9/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
       bus_add_driver+0x346/0x670 drivers/base/bus.c:678
       driver_register+0x23a/0x320 drivers/base/driver.c:249
       do_one_initcall+0x248/0x870 init/main.c:1257
       do_initcall_level+0x157/0x210 init/main.c:1319
       do_initcalls+0x3f/0x80 init/main.c:1335
       kernel_init_freeable+0x435/0x5d0 init/main.c:1568
       kernel_init+0x1d/0x2b0 init/main.c:1457
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((console_sem).lock){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
       console_trylock kernel/printk/printk.c:2852 [inline]
       console_trylock_spinning kernel/printk/printk.c:2009 [inline]
       vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2431
       _printk+0xd5/0x120 kernel/printk/printk.c:2457
       slab_bug+0x6d/0xc0 mm/slub.c:1028
       slab_err+0x130/0x190 mm/slub.c:1129
       list_slab_objects mm/slub.c:5580 [inline]
       free_partial mm/slub.c:5615 [inline]
       __kmem_cache_shutdown+0x134/0x430 mm/slub.c:5647
       kmem_cache_destroy+0x76/0x160 mm/slab_common.c:530
       bio_put_slab block/bio.c:155 [inline]
       bioset_exit+0x54e/0x650 block/bio.c:1662
       __bch2_fs_free fs/bcachefs/super.c:594 [inline]
       bch2_fs_release+0x53a/0x7b0 fs/bcachefs/super.c:624
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x22f/0x480 lib/kobject.c:737
       deactivate_locked_super+0xc4/0x130 fs/super.c:473
       bch2_fs_get_tree+0xd18/0x1740 fs/bcachefs/fs.c:2304
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3560
       do_mount fs/namespace.c:3900 [inline]
       __do_sys_mount fs/namespace.c:4111 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> hrtimer_bases.lock --> &n->list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&n->list_lock);
                               lock(hrtimer_bases.lock);
                               lock(&n->list_lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

4 locks held by syz.0.0/5321:
 #0: ffffffff8f063128 (bio_slab_lock){+.+.}-{4:4}, at: bio_put_slab block/b=
io.c:140 [inline]
 #0: ffffffff8f063128 (bio_slab_lock){+.+.}-{4:4}, at: bioset_exit+0x42f/0x=
650 block/bio.c:1662
 #1: ffffffff8e7d49f0 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destro=
y+0x3e/0x160 mm/slab_common.c:517
 #2: ffffffff8ea22490 (slab_mutex){+.+.}-{4:4}, at: kmem_cache_destroy+0x4c=
/0x160 mm/slab_common.c:518
 #3: ffff888040e446d8 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq includ=
e/linux/spinlock.h:376 [inline]
 #3: ffff888040e446d8 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub=
.c:5609 [inline]
 #3: ffff888040e446d8 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdow=
n+0x9c/0x430 mm/slub.c:5647

stack backtrace:
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.14.0-rc2-syzkaller-0003=
9-g09fbf3d50205 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
 console_trylock kernel/printk/printk.c:2852 [inline]
 console_trylock_spinning kernel/printk/printk.c:2009 [inline]
 vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2431
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 slab_bug+0x6d/0xc0 mm/slub.c:1028
 slab_err+0x130/0x190 mm/slub.c:1129
 list_slab_objects mm/slub.c:5580 [inline]
 free_partial mm/slub.c:5615 [inline]
 __kmem_cache_shutdown+0x134/0x430 mm/slub.c:5647
 kmem_cache_destroy+0x76/0x160 mm/slab_common.c:530
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x54e/0x650 block/bio.c:1662
 __bch2_fs_free fs/bcachefs/super.c:594 [inline]
 bch2_fs_release+0x53a/0x7b0 fs/bcachefs/super.c:624
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 bch2_fs_get_tree+0xd18/0x1740 fs/bcachefs/fs.c:2304
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffac198e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffac2885e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffac2885ef0 RCX: 00007ffac198e58a
RDX: 00004000000058c0 RSI: 0000400000005900 RDI: 00007ffac2885eb0
RBP: 00004000000058c0 R08: 00007ffac2885ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000400000005900
R13: 00007ffac2885eb0 R14: 0000000000005912 R15: 00004000000001c0
 </TASK>
BUG bio-464 (Not tainted): Objects remaining in bio-464 on __kmem_cache_shu=
tdown()
---------------------------------------------------------------------------=
--

Slab 0xffffea0001480680 objects=3D12 used=3D5 fp=3D0xffff88805201b680 flags=
=3D0x4fff00000000240(workingset|head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.14.0-rc2-syzkaller-0003=
9-g09fbf3d50205 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 slab_err+0x15a/0x190 mm/slub.c:1131
 list_slab_objects mm/slub.c:5580 [inline]
 free_partial mm/slub.c:5615 [inline]
 __kmem_cache_shutdown+0x134/0x430 mm/slub.c:5647
 kmem_cache_destroy+0x76/0x160 mm/slab_common.c:530
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x54e/0x650 block/bio.c:1662
 __bch2_fs_free fs/bcachefs/super.c:594 [inline]
 bch2_fs_release+0x53a/0x7b0 fs/bcachefs/super.c:624
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 bch2_fs_get_tree+0xd18/0x1740 fs/bcachefs/fs.c:2304
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffac198e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffac2885e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffac2885ef0 RCX: 00007ffac198e58a
RDX: 00004000000058c0 RSI: 0000400000005900 RDI: 00007ffac2885eb0
RBP: 00004000000058c0 R08: 00007ffac2885ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000400000005900
R13: 00007ffac2885eb0 R14: 0000000000005912 R15: 00004000000001c0
 </TASK>
Object 0xffff88805201aa00 @offset=3D2560
Object 0xffff88805201ac80 @offset=3D3200
Object 0xffff88805201af00 @offset=3D3840
Object 0xffff88805201b180 @offset=3D4480
Object 0xffff88805201b400 @offset=3D5120
------------[ cut here ]------------
kmem_cache_destroy bio-464: Slab cache still has objects when called from b=
io_put_slab block/bio.c:155 [inline]
kmem_cache_destroy bio-464: Slab cache still has objects when called from b=
ioset_exit+0x54e/0x650 block/bio.c:1662
WARNING: CPU: 0 PID: 5321 at mm/slab_common.c:533 kmem_cache_destroy+0x153/=
0x160 mm/slab_common.c:532
Modules linked in:
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Tainted: G    B              6.14.0-r=
c2-syzkaller-00039-g09fbf3d50205 #0
Tainted: [B]=3DBAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
RIP: 0010:kmem_cache_destroy+0x153/0x160 mm/slab_common.c:532
Code: 3f 18 48 89 de 5b 41 5e 5d e9 f9 2a 14 00 90 48 8b 53 60 48 c7 c7 0f =
6e 0a 8e 48 c7 c6 48 6e 0a 8e 48 89 e9 e8 7e 85 79 ff 90 <0f> 0b 90 90 e9 2=
5 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d3d7840 EFLAGS: 00010246
RAX: c8a9f49d8cfb7200 RBX: ffff888043f77000 RCX: 0000000000100000
RDX: ffffc9000e5da000 RSI: 00000000000fffff RDI: 0000000000100000
RBP: ffffffff84c6b2be R08: ffffffff817ffc22 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 00000000000001d0
R13: 1ffff1100a900176 R14: 0000000000000001 R15: ffff888000a0b3c8
FS:  00007ffac28866c0(0000) GS:ffff88801fc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563fb2622098 CR3: 00000000440f8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x54e/0x650 block/bio.c:1662
 __bch2_fs_free fs/bcachefs/super.c:594 [inline]
 bch2_fs_release+0x53a/0x7b0 fs/bcachefs/super.c:624
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 bch2_fs_get_tree+0xd18/0x1740 fs/bcachefs/fs.c:2304
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffac198e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffac2885e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffac2885ef0 RCX: 00007ffac198e58a
RDX: 00004000000058c0 RSI: 0000400000005900 RDI: 00007ffac2885eb0
RBP: 00004000000058c0 R08: 00007ffac2885ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000400000005900
R13: 00007ffac2885eb0 R14: 0000000000005912 R15: 00004000000001c0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

