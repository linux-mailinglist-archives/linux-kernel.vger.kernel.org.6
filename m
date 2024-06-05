Return-Path: <linux-kernel+bounces-201736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DD8FC282
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F131F253F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EA7344F;
	Wed,  5 Jun 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I42RaqAS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B15FB9A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560087; cv=none; b=TjYUUaxvQ2q7VE27pa3o68GZDRrgRt4fDKc/UOfFz8foiCp64r3Q3j5b24QmG44nMDlqq3YvJZEdNU8gZoa81bLQ5EPMEkDiw+ur9rysImQPMS5HgkzJVTPcnvddxSNAYJuVe2bY0yADXmdkjyg1oRVWxV3XP74orn44NYyLebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560087; c=relaxed/simple;
	bh=QJK/UCdvzWRtAMi2kwt2zBQ6SfcTObzxpyYduoQPxF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbMUV20lbBFHnj7hwrYPw5U76TRPQ7YK8Gk3uHEWKQgp4v7Y5l3nJFxe0UErdSqeRlEg//EsgXudw9jhd+1FbdWcce1ub6YfPYGIR9ccB/ZMI5sMOrT6EOrkgiZiLUSsmQdMFVQQdfN8fq3f0wNHH7hNyN4fZJlCqFCWipDPlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I42RaqAS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so893600a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717560084; x=1718164884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kU9fcdqlmIxoPptCOuxbnJuCesVSnQbp810ayKVN6w=;
        b=I42RaqASUxwYulNp5KWDdacGokvMn9CJ9tHVSlGPOI6WUwpygn/65eDmS4HKMTQgE5
         vdWefKmuwMBQUlzm6OhUjehpxS71q+WgO5VoQe1JAMBDs0QgcTp70P29XWJXKXDoHmR8
         nZcofwseZCA3Wh22nASbZ9RegJDbpyIHtYoE1D+Ca2+Lz6MJ1tDCxSJ8dx0Ufl1SBh9z
         fDJajTtkiEqvMl+cngnKQ8iIJxsuBhckYFqj6pDHw4LI3bvgS4W7xWv1l3azkjpB2AiB
         4wG/LCEu74jK1GysyCT8aSW53pLCafA/CCdLmWAYCNlMrkGCtTeI8he5PcDxDiUzOHW1
         JqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717560084; x=1718164884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kU9fcdqlmIxoPptCOuxbnJuCesVSnQbp810ayKVN6w=;
        b=FjO6911yiyGCAh8RVW88YsUM40bNAJwnaE1kbL5vxEz9Cm6+/r8GQTuFUJtW50uBVk
         zqFjNPOs5NO/BwUgRKi9h7sX5fzwmmW2N3SCqS198iBvRlx/oHyz5Zkr9QZYR28a8Dd0
         1Ts0jJuRyUTCIWgpjzgA4VIz/tBmnBhoA0IA2gd4umj4G0vicdjocXstZAWdsMYb/o74
         aeFgPnnc3a43uBAf7xCB7EbCuAY0d7mcbU3ntwFj5ozIiylPjInOfuXrcKyMBxmsctqG
         DAdVMBuA6VX7ZakH5ZZu2fl90k1ULlIKvOvhxyHHflAunLKZdydeybT6iUzPS61z9r0P
         JTHg==
X-Forwarded-Encrypted: i=1; AJvYcCWAaigrlOCOFsW+IKRPl/+Ja22qTj8qIbeqjzqDDRR+FlgshBA1DADwiMkAwSLf715Qsebq9RVW5V25qqD5wEJxjNbOL1al/nBTbgGW
X-Gm-Message-State: AOJu0YzBD0CnukoerPmL/6nkZ0wRKkjCsCnM4wdtTYFdQFqhu6AhFEhn
	wormGh/TYUIpHgXku56UkpytcSD9Z7ZI/j7UR2mONY5pWxboDdmqhu6iEqgdh/V98fWEwXwW9JW
	FW9B1iMBLpIwLySwNz7uziOgPFFUYUhajjYs=
X-Google-Smtp-Source: AGHT+IHX9/3uOu6cNX7oU0TIr3zL5FbfYEBcjxAhy8uD/DnPSoL4EIQGBz2bMRKzYxzzs0YfJsflU+hRthGbijr32ZI=
X-Received: by 2002:a50:8ad9:0:b0:57a:6e41:9d8d with SMTP id
 4fb4d7f45d1cf-57a7a717b8emr3497013a12.18.1717560083821; Tue, 04 Jun 2024
 21:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000109e6b0619fbfd44@google.com> <20240604202327.37b6ff1ec94fe6c0a212c9f7@linux-foundation.org>
In-Reply-To: <20240604202327.37b6ff1ec94fe6c0a212c9f7@linux-foundation.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 5 Jun 2024 12:01:06 +0800
Message-ID: <CAK1f24kj8kL_3vuw+tb1owakoLgPCNvMkRSTZKCVEkOLxM+hoA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel panic: corrupted stack end in userfaultfd_ioctl
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 11:23=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>
> For some reason this thread doesn't appear in my linux-mm archive.
> Lance, please take a look?

Hi Andrew, thanks for pointing this out!

Hi Hillf, thanks a lot for helping to test the patch[1] with syzbot!

I noticed that syzbot has confirmed the patch and that the reproducer
did not trigger any issues[2].

Hopefully, the patch[3] will land in -rc3 to make the testing bots happy.

[1] https://lore.kernel.org/all/20240604123656.1730-1-hdanton@sina.com/
[2] https://lore.kernel.org/all/000000000000a3bf64061a101538@google.com/
[3] https://lore.kernel.org/linux-mm/20240524005444.135417-1-21cnbao@gmail.=
com/

Thanks,
Lance


>
>
> On Mon, 03 Jun 2024 06:05:33 -0700 syzbot <syzbot+5a1cb2c00e895afca87e@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry =
whe..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D104284f2980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbd6024aedb1=
5e15c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5a1cb2c00e895=
afca87e
> > compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld=
 (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D124e16649=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15683162980=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmli=
nux-4a4be1ad.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377=
/Image-4a4be1ad.gz.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com
> >
> > Kernel panic - not syncing: corrupted stack end detected inside schedul=
er
> > CPU: 1 PID: 3188 Comm: syz-executor396 Not tainted 6.10.0-rc1-syzkaller=
-00027-g4a4be1ad3a6e #0
> > Hardware name: linux,dummy-virt (DT)
> > Call trace:
> >  dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
> >  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x38/0x90 lib/dump_stack.c:114
> >  dump_stack+0x18/0x24 lib/dump_stack.c:123
> >  panic+0x39c/0x3d0 kernel/panic.c:347
> >  schedule_debug kernel/sched/core.c:5962 [inline]
> >  schedule+0x0/0x104 kernel/sched/core.c:6628
> >  preempt_schedule_irq+0x3c/0x80 kernel/sched/core.c:7067
> >  arm64_preempt_schedule_irq arch/arm64/kernel/entry-common.c:301 [inlin=
e]
> >  __el1_irq arch/arm64/kernel/entry-common.c:539 [inline]
> >  el1_interrupt+0x4c/0x64 arch/arm64/kernel/entry-common.c:551
> >  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
> >  el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
> >  __rcu_read_lock+0x0/0x14 kernel/rcu/tree_stall.h:125
> >  pte_offset_map_nolock+0x38/0xb0 mm/pgtable-generic.c:314
> >  move_pages_pte mm/userfaultfd.c:1160 [inline]
> >  move_pages+0x330/0x13a4 mm/userfaultfd.c:1733
> >  userfaultfd_move fs/userfaultfd.c:2016 [inline]
> >  userfaultfd_ioctl+0x6f4/0x1ed8 fs/userfaultfd.c:2134
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:907 [inline]
> >  __se_sys_ioctl fs/ioctl.c:893 [inline]
> >  __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:893
> >  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
> >  invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
> >  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
> >  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
> >  el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
> >  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
> >  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> > SMP: stopping secondary CPUs
> > Kernel Offset: disabled
> > CPU features: 0x00,00000006,8f17bd7c,1767f6bf
> > Memory Limit: none
> > Rebooting in 86400 seconds..
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

