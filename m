Return-Path: <linux-kernel+bounces-201718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B908FC226
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545B61C224EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A679C6CDB1;
	Wed,  5 Jun 2024 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2JFmtiDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4579DE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717557808; cv=none; b=k04yi2WSshVlmiNoKDeD2ItDUFK8jYIQxTxKeEf6VL0WUeFWtWln1Bko0l31gbu5GwiaBI1OGeTmZKcsAHoOwJk4EzW2mG+0FzoFwU1YqWf+fyPUOsixgzC2GQEAzg6fNl6S+wCv0c6SkkyTGYakFKSGl+9bLBAj+azORC6Y470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717557808; c=relaxed/simple;
	bh=7H29Oal966I5Bv2EA8I2x/Oc47qcILF4gRXbga2Kdpc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FwwbNDF/TpkGVUeF4nhmW24V5ZOpnBJbouwX4l/f65Jsd2WVhf+ULq2EG5W+CNN4R1ye8f65rMj5WGhiXBCBv1WfwdjnTLpCAk79B2jfnRLRRAyTRSwsN9Uh/4q47vUwqLDM3wNJInhl7AeqBq1w6GS0Bf//bzcj7ReSXLdddwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2JFmtiDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1289CC32781;
	Wed,  5 Jun 2024 03:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717557808;
	bh=7H29Oal966I5Bv2EA8I2x/Oc47qcILF4gRXbga2Kdpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2JFmtiDM9CqyfXTG8mjJAXb19GitD/mRvzoOT17vELhUw8cE51CIau50K9vffSjk/
	 L0gJBg7Cuh6bMx+0YAACcnhGMY4h8fzRsfop+HQSXf47qDds9yQWXv5JTVfiwTlcgs
	 LuYN5B+feAR2fL4Y31XcuaGLY3UaFilN8mf0qifI=
Date: Tue, 4 Jun 2024 20:23:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Lance Yang <ioworker0@gmail.com>, Hillf
 Danton <hdanton@sina.com>
Subject: Re: [syzbot] [mm?] kernel panic: corrupted stack end in
 userfaultfd_ioctl
Message-Id: <20240604202327.37b6ff1ec94fe6c0a212c9f7@linux-foundation.org>
In-Reply-To: <000000000000109e6b0619fbfd44@google.com>
References: <000000000000109e6b0619fbfd44@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


For some reason this thread doesn't appear in my linux-mm archive. 
Lance, please take a look?


On Mon, 03 Jun 2024 06:05:33 -0700 syzbot <syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=104284f2980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
> dashboard link: https://syzkaller.appspot.com/bug?extid=5a1cb2c00e895afca87e
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124e1664980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15683162980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com
> 
> Kernel panic - not syncing: corrupted stack end detected inside scheduler
> CPU: 1 PID: 3188 Comm: syz-executor396 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
>  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x38/0x90 lib/dump_stack.c:114
>  dump_stack+0x18/0x24 lib/dump_stack.c:123
>  panic+0x39c/0x3d0 kernel/panic.c:347
>  schedule_debug kernel/sched/core.c:5962 [inline]
>  schedule+0x0/0x104 kernel/sched/core.c:6628
>  preempt_schedule_irq+0x3c/0x80 kernel/sched/core.c:7067
>  arm64_preempt_schedule_irq arch/arm64/kernel/entry-common.c:301 [inline]
>  __el1_irq arch/arm64/kernel/entry-common.c:539 [inline]
>  el1_interrupt+0x4c/0x64 arch/arm64/kernel/entry-common.c:551
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
>  el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
>  __rcu_read_lock+0x0/0x14 kernel/rcu/tree_stall.h:125
>  pte_offset_map_nolock+0x38/0xb0 mm/pgtable-generic.c:314
>  move_pages_pte mm/userfaultfd.c:1160 [inline]
>  move_pages+0x330/0x13a4 mm/userfaultfd.c:1733
>  userfaultfd_move fs/userfaultfd.c:2016 [inline]
>  userfaultfd_ioctl+0x6f4/0x1ed8 fs/userfaultfd.c:2134
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:893
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
>  el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x00,00000006,8f17bd7c,1767f6bf
> Memory Limit: none
> Rebooting in 86400 seconds..
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

