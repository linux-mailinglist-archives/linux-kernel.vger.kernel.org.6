Return-Path: <linux-kernel+bounces-543106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C167FA4D195
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED5716AD02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284217C7CA;
	Tue,  4 Mar 2025 02:22:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B93C6BA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054924; cv=none; b=QmaYaJ5XsNmbEOi3xvW9CSEauqT2Vl/bBDlzA566ZwdPSqDfJOv5h8BXehD2rjS1OhQOgmYEfdISPe5yIB5hd0NuLM5UIUWc2U14I2pMD7ByjIRBr1HLolYI3GpommyjrazajLiUJ9sW2iodvd7L8P7XJw3CD1pQ5omMFgjV1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054924; c=relaxed/simple;
	bh=1ptdvDuqZVxnA8O+G5S1d6+zbfTqaG3HDLU4i9m86fs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CeickB5Qjc9cHSUnjVhAbekYUVgL+jBQagIEN8ySDnvaYDwr7xv38RhBEJaxKB6JX0mALzTNuumKD6YMzZ6bvUPdn3tP3FkAnydEovQdUuUOvCoE/6px3aHYWlKrC6xM+tCQ2vBcnZbSpuaT/SyS1Ow5A5Zuzt154go5Ake9sZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso117266165ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 18:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741054922; x=1741659722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIxRWFkR2d3r8alT3WiHAXt3dE1aM+y/MWXOoLEHBrM=;
        b=kIOjY1DMze8jUbeecyO283ovypyCpFNmtm48u1DkbFL4Ch3xNE5e/dN0HOS9yGSwy1
         NvQcTJL6KH5DkdmhUFE9MPqgN2Nez1r9owgDCiRMpcK2Q3mzrTkUzQs+7owjpv5K/t4T
         k5KQEu2/r2YCLI50Ar8iXJWDlzwtao4sNgio84i1r1w50K8/+u+qgvJEC8mnWbD8SzP4
         hjSPcuH6evH1PmO/02J6zgIzaBiD9/39THYkmjivy3km3MhtNNZuDZDhxICgEg+fRcGD
         lfewlu/inwWQX4Be6iCA4CnfCLHV0FwTRYN2r8zi4h56wsCjwdBoEGzRe2UnjGqa0WYZ
         YdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEA0SsalqI2iEMWFLLt7yBHoN0gMVs8lVPh5USYCzrHDUYFI8eyxbf0vpbceMSMTVYH0dTgm8/Qj7eT2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiSvARze9K/EQFPAlVcdAYoMWo1sttH+bLqOnW12iOExOfaTY
	rmYASc7QhUMWcu1FY7Cgow5Hmz1gRBuF+CVNgrqWwG3D15ZS/OPKLMq2ODboo1yyGKjBIKL74Bo
	reDRCsg4tQ0gEs+MKf4ryFU1Scwj0DkkMlvta1gGMdq5lvOTN17Po6/U=
X-Google-Smtp-Source: AGHT+IFyNlwhl32ETaUf97uU5bXB0H2AYf6FP0tXMvTS7trUqQmDHhOrG8uc6SGzN9VrltS3nWyRelNvhDnDblE0AB4H+hUpZbvg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e14:b0:3d3:df02:1882 with SMTP id
 e9e14a558f8ab-3d3e6fadcbdmr130403145ab.20.1741054922023; Mon, 03 Mar 2025
 18:22:02 -0800 (PST)
Date: Mon, 03 Mar 2025 18:22:02 -0800
In-Reply-To: <tencent_B976976066C3B3690374096D23B1845F3705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c663ca.050a0220.eb84a.0048.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in __mm_populate

XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
=====================================
WARNING: bad unlock balance detected!
6.14.0-rc4-syzkaller-ge056da87c780-dirty #0 Not tainted
-------------------------------------
syz.0.16/7412 is trying to release lock (&mm->mmap_lock) at:
[<ffff800080a63c80>] mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
[<ffff800080a63c80>] __mm_populate+0x354/0x408 mm/gup.c:2048
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz.0.16/7412.

stack backtrace:
CPU: 0 UID: 0 PID: 7412 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_unlock_imbalance_bug+0x254/0x2ac kernel/locking/lockdep.c:5289
 __lock_release kernel/locking/lockdep.c:5518 [inline]
 lock_release+0x410/0x9e4 kernel/locking/lockdep.c:5872
 up_read+0x24/0x3c kernel/locking/rwsem.c:1619
 mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
 __mm_populate+0x354/0x408 mm/gup.c:2048
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x304/0x3c4 mm/util.c:580
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff0000d520abe0, owner = 0x1, curr 0xffff0000c9001e80, list empty
WARNING: CPU: 0 PID: 7412 at kernel/locking/rwsem.c:1346 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
Modules linked in:
CPU: 0 UID: 0 PID: 7412 Comm: syz.0.16 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
lr : __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346
sp : ffff80009c0c79e0
x29: ffff80009c0c7a60 x28: 1ffff00011f780cb x27: ffff80008fbc0000
x26: dfff800000000000 x25: ffffffffffffff00 x24: ffff0000d520ac38
x23: ffff0000d520abe0 x22: ffffffffffffff00 x21: 0000000000000001
x20: ffff0000c9001e80 x19: ffff0000d520abe0 x18: 0000000000000008
x17: 0000000000000000 x16: ffff8000832b81a0 x15: 0000000000000001
x14: 1ffff00013818e94 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : bdbc827636499100
x8 : bdbc827636499100 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c0c7198 x4 : ffff80008fcaf780 x3 : ffff80008324a1b4
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 __up_read+0x3bc/0x5f8 kernel/locking/rwsem.c:1346 (P)
 up_read+0x2c/0x3c kernel/locking/rwsem.c:1620
 mmap_read_unlock include/linux/mmap_lock.h:217 [inline]
 __mm_populate+0x354/0x408 mm/gup.c:2048
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x304/0x3c4 mm/util.c:580
 ksys_mmap_pgoff+0x3a4/0x5c8 mm/mmap.c:607
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 74469
hardirqs last  enabled at (74469): [<ffff80008b7e85f8>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (74469): [<ffff80008b7e85f8>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (74468): [<ffff80008b7e8428>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (74468): [<ffff80008b7e8428>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (74288): [<ffff8000801283e0>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (74286): [<ffff8000801283ac>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         e056da87 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=125fafb8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9f411152c9539f4e59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a598b7980000


