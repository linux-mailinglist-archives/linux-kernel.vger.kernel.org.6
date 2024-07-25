Return-Path: <linux-kernel+bounces-262219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49093C2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA4EB21BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67F519AD6F;
	Thu, 25 Jul 2024 13:06:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537717557C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912765; cv=none; b=YL/R/RBR3XMU1D6Q3KfaZLNtjhL+JbjulR0QSUycDxHN1W4dhhlwZH5F7WKaS4IPa4572eFRWdcO7bF4GR0VTw+mzvbM88EnHag5Sr+viUROt+iJ29jnAgLlLvvcfQu0U/5wa9lyhX19vQPIeBtVvTr1Cjp1J7MuAsA5FiIRoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912765; c=relaxed/simple;
	bh=sZCJQYWdT3tk2wT/UBrnDMUWWTqedKsRg+ToGL1rMp4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WodcdJgcolkMGe4/ch1KdafC/xUMimQ5GijGGCmKKJkYKRJrr4IGcdhP7zJm2yvGVk6whIMuOR0mpP2KIgzOzlw4bY2//NsvTABeC2pUAq+mkvF0it277B+VCakCddiQuaMl37UosDiX5fhaZvtxt+adyzVDgZvlseulsVMP5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-803621a51c9so16328039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912763; x=1722517563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GjFceZdzfhgAWNzY2JgcT8MhqAuMMQVDkBiMwuANHQ=;
        b=fwAZZAc74M1Xv4qd5ZHIWXyFTVV3Kyu0QXylW4H8LD5MWQ3p/v3P02WVZ30RprP15h
         WYK3fBuzXRjFXyCqKiKVm2CZg42rYNCO7t9+FwO5ml+/88NhO03BwUvkHvM7pe8MnPqs
         MJImFeObt1NWhEGwlBiZe7vNKz+68b90hzr623Zwv4nCA8G18IQwa8a3hGuQbmBb/lTl
         6SnsPwXQLz4TtdJ1qaGpseuRaSvkBR8hcLxDVeIxBc2vNkYLznUx5WbXIxe6YNw8lMbh
         JIZWBDoQ88JhJbZPlQGtHDBFHsETXp92O5P8M8nwKs4dkDkXtT2BiT4CzvN6cBQhZwMS
         43kw==
X-Gm-Message-State: AOJu0YwT/28GbUAEGQLlu0p+oEKVIpc9mCsyN4DvREvdIn4Of4EeFRaW
	V9R19K6t87/UiyIk6/7IEmXj5MxHPIq+mnn4jSZdzhxJs1ZKAazMJw7MkApAtRJPYinj3b/PFT7
	qX5kwpKSfBqOINgt8kcAA3/VJGPDQ7PHzm0MVLk814lyXh8CEt8mMxns=
X-Google-Smtp-Source: AGHT+IGkNzLxl5F1IicHCOS4SDwJ0FKKZSCU+ZXlOxqva6OIKaC8ZI0gpsnz6/hZBuZgtls12JeEFuHV3WkNugNDuCk9S/WyURgC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860e:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4c2a0f69595mr53915173.2.1721912762886; Thu, 25 Jul 2024
 06:06:02 -0700 (PDT)
Date: Thu, 25 Jul 2024 06:06:02 -0700
In-Reply-To: <20240725124919.3618893-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000910288061e120ee3@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: null-ptr-deref Write in f2fs_stop_gc_thread

F2FS-fs (loop3): Stopped filesystem due to reason: 0
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:118 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0xca/0x630 kernel/kthread.c:704
Write of size 4 at addr 0000000000000028 by task syz.3.51/6605

CPU: 1 PID: 6605 Comm: syz.3.51 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
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
 f2fs_stop_gc_thread+0x8b/0xc0 fs/f2fs/gc.c:215
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d4b975b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d4c6ee048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2d4bb06038 RCX: 00007f2d4b975b59
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f2d4b9e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2d4bb06038 R15: 00007ffef99b1198
 </TASK>
==================================================================


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13d5cea1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fc629d980000


