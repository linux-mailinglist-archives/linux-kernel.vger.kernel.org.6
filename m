Return-Path: <linux-kernel+bounces-262179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE693C1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C7C1C209E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD619939A;
	Thu, 25 Jul 2024 12:27:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369414277
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910425; cv=none; b=en35p/oBYeBoKEySLsClLnefgMDBnMfqyevTfnR3RMWE0KJyAclvgWpo0ZTbFurQHqwRnu5y+tpupsXzLtzt/BOw96NpZZTsQ3cc4w8sq294Of1dzu0IFkID2rC8uZWPxTLszc7rlJGfHg86YgElsWoghwWnjYG+s9kXeIrEmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910425; c=relaxed/simple;
	bh=CRCeYqTzO8sHw7w2yGGnUARTKRmHGh3RReQ3DknRykU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GRUmCrHVjn+hAcHaxcRdvhK3Nih9MY0lSYuuH/l7WkJgg5H4OhWFslx0fZH4AecpJ4dZ+Cn9p5A6zWEDAqlbQfZtg7jncbyuXTtE3YGf4f/a1KDBaUX0ZacRM4mgGGDWygZfpAv2Ot7hyUORgdyGwafKwy0ecqG9dpr+uXPIDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso10552839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910423; x=1722515223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e8sSMSPVqnvW0wjggf1UpvdBi7FGRc39+YqqLUcriY=;
        b=KivVCiVbLqhGrAN3AJbg7tl29kjD7h7d5aCZVZeR9EIQJyr2kAyzVVxpYWS4M44jmC
         GBBbhoKHpK/94QTWurmvWCfoe9iEO51MovIehbIvy5KWkKXJYbwjroEw3Ocgbd9Q5vVQ
         dPxNiQFllplUFKpUAbScy6mBgVh3It15fL2Tu/uGdxskdXG4hHXRIctZKg1JHB0rxRJB
         Z+C/35Wee9JA/yQo4y58/rf5KmY7wu1WLVdobZ7xjFIxwZ91/ShjTdVmD5oPTlu795JQ
         /snLis+136DK45QwqVyQFIRcPP3U0Jll62nXtY56LeEm6HNsPKdqUWTghTemCOJ0vQM5
         iupQ==
X-Gm-Message-State: AOJu0YwKwtcRneuiVmYYpz2/WDQOE5aZ/luCITl/+tG0xt2jYA5EQn4+
	EB5DefnGJoklnmeDoB0UjpLvWtyMWApj6tpfmcLZv4Nw/VwarLun7vqc9x3wMoGDuNjJe7mz3ya
	3vRyyzDK69Tz97J/WLDjd6yp1d0/XCoE/u2+CiBpWL9NLIW2/sZuERzE=
X-Google-Smtp-Source: AGHT+IGnQbtDwz3l3lAh4ecvz+CEuoPqeQuen8bPARm503zXDBDJsKqaCt0MQ3aq9y4qaliGaUSjwVn8q2k1/HzeUE861w3s6u3P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8504:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4c29b0ecaf4mr145065173.3.1721910423162; Thu, 25 Jul 2024
 05:27:03 -0700 (PDT)
Date: Thu, 25 Jul 2024 05:27:03 -0700
In-Reply-To: <20240725080829.841010-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ba2d7061e1183c0@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: null-ptr-deref Write in f2fs_stop_gc_thread

F2FS-fs (loop0): Stopped filesystem due to reason: 0
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:118 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0xca/0x630 kernel/kthread.c:704
Write of size 4 at addr 0000000000000028 by task syz.0.75/6555

CPU: 1 PID: 6555 Comm: syz.0.75 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
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
 f2fs_stop_gc_thread+0x73/0xc0 fs/f2fs/gc.c:214
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f59fb975b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f59fc7f8048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f59fbb06038 RCX: 00007f59fb975b59
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f59fb9e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f59fbb06038 R15: 00007fff3691d728
 </TASK>
==================================================================


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1578d455980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ae9bb5980000


