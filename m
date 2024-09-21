Return-Path: <linux-kernel+bounces-334962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B597DEF1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2E11C20C38
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9014BF9B;
	Sat, 21 Sep 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB+zeS3B"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178E2F46;
	Sat, 21 Sep 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952510; cv=none; b=fI9BNqyrEnO290aJZStZtu+5GOzvDFW6CGw08Zlm7ivUIiGX3XmIY6enblrnLrapJvqJyQIqs9h+ba/+pru2HPXTPcsquYmZIRJAXn9bX3ZKwKFEwcrprxmeaAqSj6sg1zeefs3uSL+DlWyaYzxpOxFFx3jPO9iOfS4Cj8/zjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952510; c=relaxed/simple;
	bh=gsQCawjiWMjve4DR75mpCFBJgZyeiYTXYMbp/urF0qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSMZd29Z6ZJ2PrFJQSet/Htz5OBqy3BGqyyd3pKHi3tnZdyleGeTyRr8yL5yVteXkg2GWUHpz5A0KjdIIX4fxy+7OvYG1NIOJSW8CDq5ZRLRcjhYtRPYu3ESw45a4e2yB1iG5twg3qSr0ieMhht7LUn3irdCIgYJkToTvceEPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB+zeS3B; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374ca65cafdso1681350f8f.2;
        Sat, 21 Sep 2024 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726952507; x=1727557307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioNx30bUb02yV0oa64dkn9N/lsA9YB0fALzjduer2QE=;
        b=MB+zeS3BoyHaPEpCwhtwqnEfJXt7J0lxQENwfU6yo7C5OiNyw5b65IWrHN2FZ/ocfE
         rSg3i7LH33JfQoS6DaIZ/VxYG23MBzsvI+aFsOD4vfmOTNZpnvPcdPNbD5Kh9qZkn5Ip
         i3QLQ4VFmcqDY1rPS8WIeBalOWE0lbO4mQNjfTvlr4+p6qtey31ttgHDrZCkNOm+XPpE
         /iL3pS8lDyZbTAZMHskXJy2Bket25v4kzIAkgBkCOgLqSNRRnlCbmqCvaX6usHZahfo1
         UacBAHmfLwpW/FF7WUDkyAOY16ApFuhHpaMwE5vBla8Cd9VdsJ+U9e94wtwQ6dp4A4E9
         A+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952507; x=1727557307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioNx30bUb02yV0oa64dkn9N/lsA9YB0fALzjduer2QE=;
        b=fkqGXVw6r2x0nMtNQMBw5WkGwPuUecP0zEcrOKpDqP8sr1xo+LRJ+ltbj02YJKOsyL
         hulpy86n8LxvcBCL0ot/sU4gyLFymhD6gdb8gKQ3vvAbLtZRC2N2LF06iXfP1WFTdl6l
         X8JmEsGcN8WZ2TUrwrmb2w+y5JkBjaYFkdx6kXu8u9+YIa8X2quZAZojzVTyPhK3VMfP
         i+4q5D0S3RZaYouLF/LwMsnS5OX8SPkj+W4qMplx0Z/aehBitVMB0gtVJYv7yMPNehls
         2zdM44A7aXsL6y+LsCWnVbzfZHMVPsdAhPDVukZl79Kfg628M560vYOuaNOC0jadljiE
         Tl+g==
X-Forwarded-Encrypted: i=1; AJvYcCU/rWEz7cTuMyFVt0KivV7UbeRZZWNQBRP8usivy2iw33g34fXZAEHpxz/6IuEU6SIjvNFvTkNjMTmqXL0=@vger.kernel.org, AJvYcCUlHEuedCGV6hfBsT0Qokb2glJfc4RmwdV7wavGYrMSW8461rvXQSiTIHPBFrX45fGPt7UMSwvWwP3v@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQ2WtvcIHxsf9I+qsg80k46cRv46FG+Pgsyh7LaXjGmtyzjdk
	/nY/W7FB2VccSCVVonAVliv4mXlEq2KoXFRrOQPkKWwq0EcHEKu60PihAD1+JCJVYHfeNz1/Aq1
	qkRJ01F4Hb5hbAFyhT95QgyHC6AbFTO2WfXw=
X-Google-Smtp-Source: AGHT+IEURJO8igVmUsFBAyqQT1IVLrmZ4Uhdrf97FaOdOhoE8Jxxn5gVaCpY4nKJRyoPcSSSzdALzBSNsXzCrk/Qh4Y=
X-Received: by 2002:adf:fa4d:0:b0:374:ca16:e09b with SMTP id
 ffacd0b85a97d-37a4223e020mr3767504f8f.9.1726952507019; Sat, 21 Sep 2024
 14:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000091994406205b01fe@google.com>
In-Reply-To: <00000000000091994406205b01fe@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 21 Sep 2024 23:01:35 +0200
Message-ID: <CA+fCnZdAcD_sY7rPBa8mYHta3dFRg1TquAm0NkYhAN6rXuaL+g@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in raw_queue_event
To: syzbot <syzbot+62ff4e5cf4fec6052ff2@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:58=E2=80=AFPM syzbot
<syzbot+62ff4e5cf4fec6052ff2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c6653f49e4fd Merge tag 'powerpc-6.10-4' of git://git.kern=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D108a17c198000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1ace69f521989=
b1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D62ff4e5cf4fec60=
52ff2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a56f9eb616fa/dis=
k-c6653f49.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2f09515c2f1b/vmlinu=
x-c6653f49.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fdc471b5cbac/b=
zImage-c6653f49.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+62ff4e5cf4fec6052ff2@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in raw_event_queue_add drivers/usb/gadget=
/legacy/raw_gadget.c:81 [inline]
> BUG: KASAN: slab-use-after-free in raw_queue_event+0x299/0x2e0 drivers/us=
b/gadget/legacy/raw_gadget.c:239
> Read of size 4 at addr ffff888066f5c978 by task kworker/1:6/5145
>
> CPU: 1 PID: 5145 Comm: kworker/1:6 Not tainted 6.10.0-rc6-syzkaller-00223=
-gc6653f49e4fd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:81 [inline]
>  raw_queue_event+0x299/0x2e0 drivers/usb/gadget/legacy/raw_gadget.c:239
>  gadget_disconnect+0x50/0xb0 drivers/usb/gadget/legacy/raw_gadget.c:387
>  set_link_state+0xc81/0x1200
>  dummy_hub_control+0xb86/0x1b10
>  rh_call_control drivers/usb/core/hcd.c:656 [inline]
>  rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
>  usb_hcd_submit_urb+0xffc/0x1e80 drivers/usb/core/hcd.c:1529
>  usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
>  usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
>  usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:154
>  usb_clear_port_feature drivers/usb/core/hub.c:453 [inline]
>  usb_hub_set_port_power drivers/usb/core/hub.c:891 [inline]
>  hub_port_connect drivers/usb/core/hub.c:5561 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
>  port_event drivers/usb/core/hub.c:5821 [inline]
>  hub_event+0x30f2/0x5150 drivers/usb/core/hub.c:5903
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
>  worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 10173:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  kmalloc_trace_noprof+0x19c/0x2c0 mm/slub.c:4154
>  kmalloc_noprof include/linux/slab.h:660 [inline]
>  kzalloc_noprof include/linux/slab.h:778 [inline]
>  dev_new drivers/usb/gadget/legacy/raw_gadget.c:192 [inline]
>  raw_open+0x8c/0x4d0 drivers/usb/gadget/legacy/raw_gadget.c:434
>  misc_open+0x313/0x390 drivers/char/misc.c:165
>  chrdev_open+0x5b0/0x630 fs/char_dev.c:414
>  do_dentry_open+0x970/0x1450 fs/open.c:955
>  vfs_open+0x3e/0x330 fs/open.c:1086
>  do_open fs/namei.c:3654 [inline]
>  path_openat+0x2c01/0x35f0 fs/namei.c:3813
>  do_filp_open+0x235/0x490 fs/namei.c:3840
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1413
>  do_sys_open fs/open.c:1428 [inline]
>  __do_sys_openat fs/open.c:1444 [inline]
>  __se_sys_openat fs/open.c:1439 [inline]
>  __x64_sys_openat+0x247/0x2a0 fs/open.c:1439
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 10139:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2196 [inline]
>  slab_free mm/slub.c:4438 [inline]
>  kfree+0x149/0x360 mm/slub.c:4559
>  raw_release+0x138/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:473
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  task_work_run+0x24f/0x310 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa27/0x27e0 kernel/exit.c:876
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1025
>  get_signal+0x16a1/0x1740 kernel/signal.c:2909
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888066f5c000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 2424 bytes inside of
>  freed 4096-byte region [ffff888066f5c000, ffff888066f5d000)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x66f5=
8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xffffefff(slab)
> raw: 00fff00000000040 ffff888015042140 ffffea0000bf8000 dead000000000002
> raw: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
> head: 00fff00000000040 ffff888015042140 ffffea0000bf8000 dead000000000002
> head: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
> head: 00fff00000000003 ffffea00019bd601 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040=
(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARD=
WALL), pid 5177, tgid 5174 (syz.0.1), ts 69708451232, free_ts 15196910197
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
>  prep_new_page mm/page_alloc.c:1481 [inline]
>  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2265
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2428
>  new_slab mm/slub.c:2481 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
>  __slab_alloc+0x58/0xa0 mm/slub.c:3757
>  __slab_alloc_node mm/slub.c:3810 [inline]
>  slab_alloc_node mm/slub.c:3990 [inline]
>  __do_kmalloc_node mm/slub.c:4122 [inline]
>  __kmalloc_noprof+0x257/0x400 mm/slub.c:4136
>  kmalloc_noprof include/linux/slab.h:664 [inline]
>  tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
>  security_file_ioctl+0x75/0xb0 security/security.c:2765
>  __do_sys_ioctl fs/ioctl.c:901 [inline]
>  __se_sys_ioctl+0x47/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 1 tgid 1 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1093 [inline]
>  free_unref_page+0xd19/0xea0 mm/page_alloc.c:2588
>  free_contig_range+0x9e/0x160 mm/page_alloc.c:6642
>  destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1017
>  debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
>  do_one_initcall+0x248/0x880 init/main.c:1267
>  do_initcall_level+0x157/0x210 init/main.c:1329
>  do_initcalls+0x3f/0x80 init/main.c:1345
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1578
>  kernel_init+0x1d/0x2b0 init/main.c:1467
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Memory state around the buggy address:
>  ffff888066f5c800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888066f5c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888066f5c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                                 ^
>  ffff888066f5c980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888066f5ca00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

#syz dup: KASAN: invalid-free in dev_free

