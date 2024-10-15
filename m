Return-Path: <linux-kernel+bounces-366466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F099F5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8595280ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE620371A;
	Tue, 15 Oct 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFeZWr15"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18033203711
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017337; cv=none; b=E9c+/zEPyqQWExtcqPRtnt0LJ92FelaLuOJYX38nPqdcw9rSUiWMOl8zJaJWbjk/pN/mfpTQuoX+T+sLnilJo7b+jcGmM8jCcs7p13hra0FSLktwmV0+YbfxlBZbUP72C6N0BkryocyNVTpdhF1Dgpxl287l//YFEbM++f5yHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017337; c=relaxed/simple;
	bh=Trw6EI01R3CQTFvq1C0Y/ju9QSqLHZULVnd/Pe5libA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAThcLQCr3CP/U8TBfjDUh2GMkhb2DGGN0z32v8cV9QClPEJfxiuqcrOFxugVXh88fjHPCnq7vxzL7lNnybd4idbU1JlJvG7Aw8e2YTPavbuaye/4klaEs2et5AxtEF8nSEiSeOfjJNAplxdP0K+KJ6279E7GwOTSBD3DhB8Ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFeZWr15; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311173a667so8900905e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729017333; x=1729622133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEAdFklZ6+/g1WKDp56Df6I5L1xTdYOKDZ4MHxIVc7Q=;
        b=eFeZWr15R5QQalbiLQP86ou68lZPb/lVLvDS5ReBZHalo7jt3ogTVoJlq/jJA2HVtc
         hWJvbkVCY6VWIqhKgwgVTObivupjXoBehyrx+dcqGqzsPdiRqipgenNEGzLEAn12i2Ss
         lV/FghKt7+Z9JH92XKRTCwRb2Pv/UW4mQLvHgGJwNlXUZq5iJlSiPOjASgkSRdGS+U7u
         MAuorp7l6/nCtLAQWvZSXccqjvbtUdt8oW5SAGgg8QX6D7SejQdc0ACQ306VdBim9muK
         zRJfGUZg16LS8CmIJF8V75IefCH+JcP91+zP6IOnS+uu/C8fOX+6RQd3ixk6/eWezkll
         ezKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017333; x=1729622133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEAdFklZ6+/g1WKDp56Df6I5L1xTdYOKDZ4MHxIVc7Q=;
        b=YYgBD247gLpYLUxa/9u8tISQoy9wH4Bk5Fa92qgEzCgvoCu7yUQbT8zyzhXawcAmaD
         zJzBsJHVAJMoV2+xAeLQxbKDH4AGefPzvgD842LoT5sSlHgm6+crTrAclGZxr0yyjP/u
         FAvdGoKKoZna9Nc7dUjaB/bTjClfboVQNlEEriwDwFYOq97dRrGgnUOWOUt0fmMTkoxg
         NNfJhPtUL1RHkUL2IBr6BtDDctXh+vr2TJDwEE6aBgFaJ6hIa/Li6Wud61ZvqvUMJdkh
         NNzomWVvSNbzs8yYtUmXQmw42GBJOmcw6MP0mW+YftXb1gpA1z0FxqBokA/fn0jrKkfi
         0dBg==
X-Forwarded-Encrypted: i=1; AJvYcCVLGgxRYhhwoHAXy44hlRlu0rXJYJPN94h1TCkiNzZVxEE4fpk3bM9hoQBa/qzpMrHCjO38NVdXuPlIlQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bgqJ9fWAmnaTKvdTzjIuz6L8qb6kTfbgaR0CnjcUmVrdaHRt
	AGpxLNytsWrDXJr9CVIry60Z3k8udsBItL0JdoMmVMDyAB9ZMnpBsEdnvIVU99Ai3hxlLQpPz55
	5hLmQY6QOs5KW7FDEXzEvp5lJM0s=
X-Google-Smtp-Source: AGHT+IHr9znTMe98ZtApY5ItCUcjnaEDPXuD6MfvldmM2hWZY42ind//FgQEmwlpN28elSX16JUOolk4gBD8BYaONaA=
X-Received: by 2002:a5d:6daa:0:b0:374:bfd1:a786 with SMTP id
 ffacd0b85a97d-37d5527f05emr5952046f8f.4.1729017333124; Tue, 15 Oct 2024
 11:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz-aUw70NeJwk-zPeqpXD1+VsKBjNqjWBySoXsLz+zRXg@mail.gmail.com>
In-Reply-To: <CAJg=8jz-aUw70NeJwk-zPeqpXD1+VsKBjNqjWBySoXsLz+zRXg@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Tue, 15 Oct 2024 11:35:22 -0700
Message-ID: <CAJg=8jzQOgBa=P4Anc28yz-CLhci6_pvE+5EyN_YxJYfXoxhcw@mail.gmail.com>
Subject: Re: INFO: task hung in ocfs2_get_sector
To: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Hope you are doing well!

Quick update from our side: The reproducers from the previous email
still trigger this INFO on v5.15 (commit hash
3a5928702e7120f83f703fd566082bfb59f1a57e).
Happy to also test on other kernel versions if that helps.

Please let us know if there is any other helpful information I can provide.

Wishing you a nice day!

Best,
Marius

On Tue, 21 May 2024 at 14:38, Marius Fleischer
<fleischermarius@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
>
> ======================================================
> description: INFO: task hung in ocfs2_get_sector
> affected file: drivers/block/floppy.c
> kernel version: 5.15.159
> kernel commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> git tree: upstream
> kernel config: attached
> crash reproducer: attached
> ======================================================
> Crash log:
> INFO: task syz-executor.4:92137 blocked for more than 143 seconds.
>       Not tainted 5.15.159 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.4  state:D stack:27168 pid:92137 ppid:  6651 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5030 [inline]
>  __schedule+0xb54/0x5560 kernel/sched/core.c:6376
>  schedule+0x113/0x240 kernel/sched/core.c:6459
>  io_schedule+0xba/0x130 kernel/sched/core.c:8484
>  bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
>  __wait_on_bit+0x60/0x190 kernel/sched/wait_bit.c:49
>  out_of_line_wait_on_bit+0xd8/0x110 kernel/sched/wait_bit.c:64
>  wait_on_bit_io include/linux/wait_bit.h:101 [inline]
>  __wait_on_buffer+0x7c/0x90 fs/buffer.c:122
>  wait_on_buffer include/linux/buffer_head.h:390 [inline]
>  ocfs2_get_sector+0x34d/0x540 fs/ocfs2/super.c:1772
>  ocfs2_sb_probe fs/ocfs2/super.c:748 [inline]
>  ocfs2_fill_super+0x3d5/0x3cc0 fs/ocfs2/super.c:989
>  mount_bdev+0x34f/0x410 fs/super.c:1387
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:611
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1517
>  do_new_mount fs/namespace.c:3005 [inline]
>  path_mount+0x6a5/0x2010 fs/namespace.c:3335
>  do_mount fs/namespace.c:3348 [inline]
>  __do_sys_mount fs/namespace.c:3556 [inline]
>  __se_sys_mount fs/namespace.c:3533 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3533
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x66/0xd0
> RIP: 0033:0x7fb030b75dad
> RSP: 002b:00007fb02f0c4028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fb030cb3050 RCX: 00007fb030b75dad
> RDX: 0000000020000080 RSI: 0000000020000000 RDI: 00000000200000c0
> RBP: 00007fb030bd74a6 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007fb030cb3050 R15: 00007fb02f0a4000
>  </TASK>
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/30:
>  #0: ffffffff8b9876c0 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x53/0x272 kernel/locking/lockdep.c:6452
> 2 locks held by systemd-journal/3015:
> 1 lock held by in:imklog/6431:
>  #0: ffff888152c46870 (&f->f_pos_lock){+.+.}-{3:3}, at:
> __fdget_pos+0xed/0x190 fs/file.c:1088
> 1 lock held by syz-executor.4/92137:
>  #0: ffff8880792300e0 (&type->s_umount_key#105/1){+.+.}-{3:3}, at:
> alloc_super+0x233/0xb70 fs/super.c:229
> 2 locks held by syz-executor.4/92619:
>  #0: ffff88801774f008 (&bdev->bd_fsfreeze_mutex){+.+.}-{3:3}, at:
> mount_bdev+0x90/0x410 fs/super.c:1354
>  #1: ffff8880792300e0 (&type->s_umount_key#115){+.+.}-{3:3}, at:
> grab_super+0x59/0x260 fs/super.c:389
> 1 lock held by syz-executor.4/92621:
>  #0: ffff88801ab2e208 (&nbd->config_lock){+.+.}-{3:3}, at:
> nbd_ioctl+0x151/0xba0 drivers/block/nbd.c:1460
> 1 lock held by syz-executor.4/92622:
>  #0: ffff88801ab2e208 (&nbd->config_lock){+.+.}-{3:3}, at:
> nbd_ioctl+0x151/0xba0 drivers/block/nbd.c:1460
> 1 lock held by syz-executor.4/93058:
>  #0: ffff88801ab2e208 (&nbd->config_lock){+.+.}-{3:3}, at:
> nbd_ioctl+0x151/0xba0 drivers/block/nbd.c:1460
> 1 lock held by syz-executor.4/93059:
>  #0: ffff88801ab2e208 (&nbd->config_lock){+.+.}-{3:3}, at:
> nbd_ioctl+0x151/0xba0 drivers/block/nbd.c:1460
> 1 lock held by syz-executor.4/93060:
>  #0: ffff88801ab2e208 (&nbd->config_lock){+.+.}-{3:3}, at:
> nbd_ioctl+0x151/0xba0 drivers/block/nbd.c:1460
> 1 lock held by syz-executor.4/93061:
>  #0: ffff88801774f008 (&bdev->bd_fsfreeze_mutex){+.+.}-{3:3}, at:
> mount_bdev+0x90/0x410 fs/super.c:1354
>
> =============================================
>
> NMI backtrace for cpu 0
> CPU: 0 PID: 30 Comm: khungtaskd Not tainted 5.15.159 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
>  nmi_trigger_cpumask_backtrace+0x1ea/0x230 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
>  watchdog+0xc5f/0xf30 kernel/hung_task.c:295
>  kthread+0x3e5/0x4d0 kernel/kthread.c:334
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:300
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 34028 Comm: kworker/u4:6 Not tainted 5.15.159 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: bat_events batadv_nc_worker
> RIP: 0010:__lock_acquire+0x1ab/0x5340 kernel/locking/lockdep.c:4918
> Code: 0f 84 e1 10 00 00 48 ba ab aa aa aa aa aa aa aa 48 2d 40 7e d9
> 8f 48 8d bd f0 0a 00 00 48 c1 f8 06 48 0f af c2 48 89 7c 24 28 <48> 89
> 44 24 10 8b 44 24 08 48 89 c6 48 8d 04 80 85 f6 4c 8d 24 c5
> RSP: 0000:ffffc9000737fa38 EFLAGS: 00000803
> RAX: 0000000000000015 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: aaaaaaaaaaaaaaab RSI: 0000000000000000 RDI: ffff88801a762f30
> RBP: ffff88801a762440 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff90582768 R12: 0000000000000000
> R13: ffffffff8b9876c0 R14: 0000000000000000 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc544a1d4a8 CR3: 0000000147ec5000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  lock_acquire kernel/locking/lockdep.c:5623 [inline]
>  lock_acquire+0x1ab/0x4e0 kernel/locking/lockdep.c:5588
>  rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
>  rcu_read_lock include/linux/rcupdate.h:739 [inline]
>  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
>  batadv_nc_worker+0x12d/0xfe0 net/batman-adv/network-coding.c:723
>  process_one_work+0x9bc/0x1550 kernel/workqueue.c:2310
>  worker_thread+0x65d/0x1130 kernel/workqueue.c:2457
>  kthread+0x3e5/0x4d0 kernel/kthread.c:334
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:300
>  </TASK>
> ======================================================
>
> Wishing you a nice day!
>
> Best,
> Marius

