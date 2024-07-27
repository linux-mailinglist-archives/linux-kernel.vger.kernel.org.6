Return-Path: <linux-kernel+bounces-263951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BB493DD10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FC8B23119
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B368E1C2D;
	Sat, 27 Jul 2024 02:48:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C015BB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722048485; cv=none; b=LsclFifX7Uj8WHacB9ybudbmlVM8tCHjbIGv4PlsBXf2hXA0MlRqHVk3O15NhRB109Pt8ScGuD4tl/FzIQ9NewiSgYoB6JlIOfWNfXz3KHH0+MKrUdOSk80eGbNZukGFJoGdMOJ6LcP8svNUTrjMne12NxjNmnOid0pf2WCN+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722048485; c=relaxed/simple;
	bh=wRC6k3KlraaCT76iuFHeEpOEJtNmaePzW5s5LmVPa7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mtcv9CVTaNBigjTYJ0f3lv94OALyt6FfczOJvmeEJmuqO69JziaaWN5VmEdU/qxTFYEdf7u8H3gYVBCvj0AxUyN+O4vf2DwfB8OmbpYFoSU+fU+1nzqjgkMkvdxQvorFmNb0aan9Xbx7xlfMIFbZfUeijkBP4aiMYeAuD0pXr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a1ba36524so37764525ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722048483; x=1722653283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpRJ6d1KqE33rupG4rhTGkKcJPfrRUXWAl1tYdPwVAY=;
        b=vhT3Sgs0B4P5cESHDOG72MCY9DLwMa22fK+1vqC3nBZx8Na6c5kERZbhLyeJJ23GLs
         LECtP/xVh3d3Fil7QPh6Lelp9nlO8UXfRuZf7fOMEUFysLa3fkzcQEitcNSFc6mx+kIt
         P/4RPIIJGOQ6Y7TqTYIqukiUQ/oTp6CI8SSQXToy9KSS2T/kFYspDtewyayuOEzr3czN
         0+Nv9R6Dre0MEZ+WMHVNrt5Mh4J5YRohoeYetUCb69oXZox/X/oC5+3a7c8G9zeJVRJp
         2pvOYP82UJmI4+q0pnASR4eohFvJgpxplOlyYMfQ3Z8+W5pqjuCYksmZ4xLNUfrsfdgV
         rh+g==
X-Forwarded-Encrypted: i=1; AJvYcCV5USM3wdrQIW95Fm2NivSsdToKlgG0xilM220/x+yxsS3Bd/HLYKDLTc6gBpQIFGOaklKbFWMxGPvvj1dFpEjHr1tGWNirYehj1/ok
X-Gm-Message-State: AOJu0YyjHYlfWP8KaI4iWirpbEg5b6lCh2FKOL4wEyV5G/MiPxZtLjjG
	FQ/e6uF+0RbsT45pYAvVaacTVQ7916P4LXsLDAnHYtijYsJRJxd4oOBTeuvo5sld5nS94Ikdlnp
	NyWlVDBE2vv0/Ss5miuuafza4PViciqoC9fSqb7kCXZ6DUFhwxgI6DVo=
X-Google-Smtp-Source: AGHT+IGktKGsb/3qYK46ZlJurtZ+6sY/lEB9PxVNnWFxvy2sbuFz/onPNIuiYEQP1uZl8GKzdv+qP4X+36mSO4xR8XaBOcbCKUtT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56e:0:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39aec41b90dmr1075695ab.4.1722048482931; Fri, 26 Jul 2024
 19:48:02 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:48:02 -0700
In-Reply-To: <tencent_250DFF9261DD82DDDA19784F898D9625D107@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c8692061e31a824@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: null-ptr-deref Write in f2fs_stop_gc_thread

F2FS-fs (loop1): Stopped filesystem due to reason: 0
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:118 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0xca/0x630 kernel/kthread.c:704
Write of size 4 at addr 0000000000000028 by task syz.1.265/8090

CPU: 1 PID: 8090 Comm: syz.1.265 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 get_task_struct include/linux/sched/task.h:118 [inline]
 kthread_stop+0xca/0x630 kernel/kthread.c:704
 f2fs_stop_gc_thread+0x83/0xd0 fs/f2fs/gc.c:214
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f604c575b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f604d3e9048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f604c706038 RCX: 00007f604c575b59
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f604c5e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f604c706038 R15: 00007fff3d7c10f8
 </TASK>
==================================================================


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17f2dd73980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113ee499980000


