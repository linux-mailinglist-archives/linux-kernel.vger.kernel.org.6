Return-Path: <linux-kernel+bounces-216631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A090A268
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADF31C224F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098804317B;
	Mon, 17 Jun 2024 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhrqJCXl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF223A9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590840; cv=none; b=PDDZz6Jawox3YMEJKnvJ3JXAOJcCub0UlsI0LKazf51prXeYwO/jzT8G57/1eKxVFfchnmSXNudUxc4QSDmYbHgw78wPXsbFCPgN11LeZQ3pDUHC7QnxQwrwQMxJcvTUZ1fks+T8iq2Vob8pAWXnVRx/zRo3chM/mx3tJa6J07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590840; c=relaxed/simple;
	bh=CvmlvXgIecncaxictHMvsmFyc4WoTFp3vf3O71YAmOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV1l8MOmg14fHhCHrHM5yhoosO2xvKNosLhhrDTyyoSKD9eapym15/J12uEWa4DF8VMcFSUPBb5NqKkQHNg7kTcjU6eZzYRebHWffMlznhoe1tz6wZv3VBtck1WWFj3BqcQFE5QRBzP1oSPPWefI6ZuiutwbK4o9f6CWHEK/0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhrqJCXl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-423b89f9042so39355e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718590837; x=1719195637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+liqLNozFDxUH+OypCJoM7VDxvJv3ED8jIOovDEO77k=;
        b=HhrqJCXlq+3mZQQt9hS4m6O0RbdRH29iNMXypdRQEmOHiX18iPto5ef2k8rL+GdYGJ
         Sy0fz6nnKPK2fnczGlgZI7kbGxkTPI1Z77mQr/MEMzwkLz6fNClQmeqm2arfnS+W053C
         MRf0oSGEwe0uBVTsjx239ym/QAStGRon+OwHne7U0fgWkd+TvFW+HCChq7fQeqn7ojUV
         OItHdR5wgPZDOSHjarWzZFP9fNgOh+BgVTAgiKEVgJsn28lJRJg2DEVnZhK/9/OEFsRt
         kgN1qxnk00OjiLYYC5flmh8IUgexDVew18RQrKrsXasBNswrgO5Egynk1vgSr7dXqCK7
         d8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590837; x=1719195637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+liqLNozFDxUH+OypCJoM7VDxvJv3ED8jIOovDEO77k=;
        b=knh6ZuOvJ6+F61cWzsDp1bPSN4iA64Mt/7adXRYe5GdPsL27vJbEfx9+mmqaZRmdsh
         0CnFzSZoiZ5a2IQH1J8S+OFzWw+MF7MVrARvpCmrofjJwhxoVqe/06jcOpEUA+HO7x2g
         I/u3tcr4Ri8Ebd0FBWovKKhd7Z60h3tebV/BHEQpcs9n3b5Y6R3CvvcTjSKGdo0mkTBF
         APqHAh1FB9whJnd5BD5TNujheGBfrnZigeT3i9bUMtik78MdZTJyhwFjFbWM7rX3mLfF
         RXy1PV4oKn737B44nxJ3Xp9XfV7+huc+OlL0muo+U9xft2zGbOreKS6VbTzCuTt7Qi6g
         KkRw==
X-Forwarded-Encrypted: i=1; AJvYcCUKBhkzjN15C2OUbofHFWemg9UMTq+kNpFzlX5gqmlvX/d6bQ5ftVLslyeHRx9QEp4QwmCMllU6Jw2la9RHtJc1pAxOg0SajYkr/14x
X-Gm-Message-State: AOJu0YxhkwoOHqKlG/kh/Klu3x2uSquTYQNSQlLgUlWS6rRdibtybS2d
	plz/xk3oTcO1e7+bOKIAOCic8bWOztumVJrbe0md1wKhADJ2uz0YnqLCYJUkP2oe36F3PxymESB
	DayVuORKtEMdllJtxYIwd/+Xjgp8og1KpUbR1
X-Google-Smtp-Source: AGHT+IH+i/n6l/qWLdjjiA93WeQVWsPHFU3OP2SCKrZy2kbxCg6Vk24oRYFBxtJPOTv4A7g3aZs8o6hDPxwPNWpDHD0=
X-Received: by 2002:a05:600c:3d0d:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-423b5fb8d5emr2734065e9.4.1718590836757; Sun, 16 Jun 2024
 19:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c89573061af04607@google.com>
In-Reply-To: <000000000000c89573061af04607@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 16 Jun 2024 20:19:59 -0600
Message-ID: <CAOUHufa=0MW2Esc3eW8BnDF84GPh5T3A75ngJKMbvacSiv_5tw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (2)
To: syzbot <syzbot+12f0383f30f497b7f266@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 11:42=E2=80=AFAM syzbot
<syzbot+12f0383f30f497b7f266@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2ef5971ff345 Merge tag 'vfs-6.10-rc4.fixes' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12873d9698000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D81c0d76ceef02=
b39
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D12f0383f30f497b=
7f266
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
bc7510fe41f/non_bootable_disk-2ef5971f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/85722ebc781d/vmlinu=
x-2ef5971f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/27fd8bd02a1e/b=
zImage-2ef5971f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+12f0383f30f497b7f266@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/i=
nstrumented.h:68 [inline]
> BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/i=
nstrumented-non-atomic.h:141 [inline]
> BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/page=
map.h:259 [inline]
> BUG: KASAN: slab-use-after-free in folio_evictable+0x7b/0x270 mm/internal=
.h:353
> Read of size 8 at addr ffff88804b68ab18 by task kswapd0/111
>
> CPU: 3 PID: 111 Comm: kswapd0 Not tainted 6.10.0-rc3-syzkaller-00021-g2ef=
5971ff345 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:488
>  kasan_report+0xd9/0x110 mm/kasan/report.c:601
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inli=
ne]
>  mapping_unevictable include/linux/pagemap.h:259 [inline]

The memory folio->mapping pointed to was RCU freed and
mapping_unevictable() was under the RCU read lock.

So probably the owner of that folio forgot to clear the mapping?

>  folio_evictable+0x7b/0x270 mm/internal.h:353
>  sort_folio mm/vmscan.c:4259 [inline]
>  scan_folios mm/vmscan.c:4385 [inline]
>  isolate_folios+0xdc0/0x3e90 mm/vmscan.c:4510
>  evict_folios+0x1a2/0x1bf0 mm/vmscan.c:4541
>  try_to_shrink_lruvec+0x618/0x9b0 mm/vmscan.c:4749
>  shrink_one+0x3f8/0x7c0 mm/vmscan.c:4788
>  shrink_many mm/vmscan.c:4851 [inline]
>  lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
>  shrink_node mm/vmscan.c:5910 [inline]
>  kswapd_shrink_node mm/vmscan.c:6720 [inline]
>  balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
>  kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 11159:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:312 [inline]
>  __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3941 [inline]
>  slab_alloc_node mm/slub.c:4001 [inline]
>  kmem_cache_alloc_lru_noprof+0x121/0x2f0 mm/slub.c:4020
>  nilfs_alloc_inode+0x26/0x150 fs/nilfs2/super.c:154
>  alloc_inode+0x5d/0x230 fs/inode.c:261
>  iget5_locked fs/inode.c:1235 [inline]
>  iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
>  nilfs_iget_locked+0xa1/0xe0 fs/nilfs2/inode.c:606
>  nilfs_ifile_read+0x2f/0x1e0 fs/nilfs2/ifile.c:192
>  nilfs_attach_checkpoint+0x12d/0x1d0 fs/nilfs2/super.c:557
>  nilfs_fill_super fs/nilfs2/super.c:1067 [inline]
>  nilfs_get_tree+0x951/0x1000 fs/nilfs2/super.c:1211
>  vfs_get_tree+0x8f/0x380 fs/super.c:1780
>  do_new_mount fs/namespace.c:3352 [inline]
>  path_mount+0x6e1/0x1f10 fs/namespace.c:3679
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount fs/namespace.c:3875 [inline]
>  __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>
> Freed by task 111:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
>  poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
>  __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2196 [inline]
>  slab_free mm/slub.c:4437 [inline]
>  kmem_cache_free+0x12f/0x3a0 mm/slub.c:4512
>  i_callback+0x43/0x70 fs/inode.c:250
>  rcu_do_batch kernel/rcu/tree.c:2535 [inline]
>  rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2809
>  handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inli=
ne]
>  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:702
>
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
>  __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:3072
>  destroy_inode+0x12c/0x1b0 fs/inode.c:316
>  iput_final fs/inode.c:1741 [inline]
>  iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
>  iput+0x5c/0x80 fs/inode.c:1757
>  nilfs_put_root+0xae/0xe0 fs/nilfs2/the_nilfs.c:925
>  nilfs_segctor_destroy fs/nilfs2/segment.c:2788 [inline]
>  nilfs_detach_log_writer+0x5ef/0xaa0 fs/nilfs2/segment.c:2850
>  nilfs_put_super+0x43/0x1b0 fs/nilfs2/super.c:498
>  generic_shutdown_super+0x159/0x3d0 fs/super.c:642
>  kill_block_super+0x3b/0x90 fs/super.c:1676
>  deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
>  deactivate_super+0xde/0x100 fs/super.c:506
>  cleanup_mnt+0x222/0x450 fs/namespace.c:1267
>  task_work_run+0x14e/0x250 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
>  __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>
> The buggy address belongs to the object at ffff88804b68a670
>  which belongs to the cache nilfs2_inode_cache of size 1512
> The buggy address is located 1192 bytes inside of
>  freed 1512-byte region [ffff88804b68a670, ffff88804b68ac58)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88804b68=
acd8 pfn:0x4b688
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff888058e37301
> flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xffffefff(slab)
> raw: 04fff00000000040 ffff88801b6f6280 dead000000000122 0000000000000000
> raw: ffff88804b68acd8 0000000080130007 00000001ffffefff ffff888058e37301
> head: 04fff00000000040 ffff88801b6f6280 dead000000000122 0000000000000000
> head: ffff88804b68acd8 0000000080130007 00000001ffffefff ffff888058e37301
> head: 04fff00000000003 ffffea00012da201 ffffffffffffffff 0000000000000000
> head: ffff888000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d20=
50(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HA=
RDWALL|__GFP_RECLAIMABLE), pid 6572, tgid 6570 (syz-executor.2), ts 1004186=
94148, free_ts 93623440891
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
>  prep_new_page mm/page_alloc.c:1476 [inline]
>  get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
>  __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x56/0x110 mm/slub.c:2265
>  allocate_slab mm/slub.c:2428 [inline]
>  new_slab+0x84/0x260 mm/slub.c:2481
>  ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
>  __slab_alloc_node mm/slub.c:3810 [inline]
>  slab_alloc_node mm/slub.c:3989 [inline]
>  kmem_cache_alloc_lru_noprof+0x2a7/0x2f0 mm/slub.c:4020
>  nilfs_alloc_inode+0x26/0x150 fs/nilfs2/super.c:154
>  alloc_inode+0x5d/0x230 fs/inode.c:261
>  iget5_locked fs/inode.c:1235 [inline]
>  iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
>  nilfs_iget_for_shadow+0xe4/0x2f0 fs/nilfs2/inode.c:742
>  nilfs_mdt_setup_shadow_map+0x8c/0x150 fs/nilfs2/mdt.c:523
>  nilfs_dat_read+0x26d/0x360 fs/nilfs2/dat.c:525
>  nilfs_load_super_root fs/nilfs2/the_nilfs.c:120 [inline]
>  load_nilfs+0x399/0x12e0 fs/nilfs2/the_nilfs.c:301
>  nilfs_fill_super fs/nilfs2/super.c:1062 [inline]
>  nilfs_get_tree+0x8c9/0x1000 fs/nilfs2/super.c:1211
> page last free pid 5216 tgid 5216 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1088 [inline]
>  free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
>  __put_partials+0x14c/0x170 mm/slub.c:2995
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3941 [inline]
>  slab_alloc_node mm/slub.c:4001 [inline]
>  kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4008
>  getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
>  getname_flags include/linux/audit.h:322 [inline]
>  getname+0x8f/0xe0 fs/namei.c:218
>  do_sys_openat2+0x104/0x1e0 fs/open.c:1399
>  do_sys_open fs/open.c:1420 [inline]
>  __do_sys_openat fs/open.c:1436 [inline]
>  __se_sys_openat fs/open.c:1431 [inline]
>  __x64_sys_openat+0x175/0x210 fs/open.c:1431
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff88804b68aa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88804b68aa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88804b68ab00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                             ^
>  ffff88804b68ab80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88804b68ac00: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

