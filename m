Return-Path: <linux-kernel+bounces-263526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC64E93D741
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7661C21DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6217C7AD;
	Fri, 26 Jul 2024 17:02:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC05684
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013325; cv=none; b=adRO1dsRWOiyLW/MIpIoP5NtL+l1/HPDXc79dUtgM6utaMjuBn7mGkR+yoX+yPmf3F8zigobPVOff4rOhvWRIc/Yi0C9vS9pmNR3zmuRTasn4NNEVy41Ne53t3YlwNzRb0MWnqQVdlQ048bmttG0kzfNI2ME5cxxXF4WhvsSCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013325; c=relaxed/simple;
	bh=itAaLq+fxTFXBx8H+Q8COB9853ycuS+hTDeZVdotK/M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y1HueN1LHV51aaOr3ljE/e1D5/m5oMPTDvs1Xmdgm6QovcmkdZZBQztlvvsjQcvZQEDJZHh4ZrZZB3T8DrYooMPQD9QzXI4/wskhXi6LnBhBmwwRnKi7NG1c0su4hWI0CgUKd/yvCR9nQWorrNCmlEaO6G54HcY7KOPYej/ioWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39aebcdfc3eso1163355ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722013323; x=1722618123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=achvCUOjruFgA5WCY4la7gxxgbALRA57rcP8e18jQhI=;
        b=ByVjfQshOd/GzDCsF/5nODJ+Jhpo7GdBeVM04umOZZrqlWYvIMU2zwpXGVfoxNl2Rz
         ZPYfYth5b6uhdsfPoJ5K8aRLs8x1TPpWltrVeYEe4g/wdIAHHX5Rb63ZJhaH/CUO8+bD
         N1RunOqjfS9M2ES/Ox7tMzL/oX+kA/ZSwsX0wGWt56kbq0GAylLWMO0LoKNefpSoyKSg
         UniOOSCC19yf8jB035BJJC73uNo3F0k5SlEZJpSlcIemHoFMtVsxVkCBDaXJqA70Izo1
         eA3QOXu2r9cEt5kv0gByrhBnwSCjTfdFOBKVHbH+6RfaHYrFbzUZ92iCSU6XKYl8FGPd
         Fobw==
X-Forwarded-Encrypted: i=1; AJvYcCUC0G3Gx0L/44VmaQBhxGSTNluv5b4rR494+s97hmf8dukdUAwHXN1dnLYbbav7F24wlEadH7B2u4u4vFgOusQRJ0GGcOoWx1UzfDVa
X-Gm-Message-State: AOJu0YzzapmfpQqRr+whZDI+BwQn3PQGB2pEnr/ZcWH63iv20iYb1VvD
	aLa9pKn9barXtmzk7ercj79y1O5paLwAPgFJekuNvD2sBWVjugcID80EAEO0DHFvr0F4+CxYKq8
	N43/ioZwyEFv1jHbfsY2rWrAlcYuXY+jQ1tWQFAtrIS6ESdte/3dQ528=
X-Google-Smtp-Source: AGHT+IFdK5iqk73w8W5cnX5bAEaSjMpF06V1E8aPzxulqDmJq4a96ytnEgw3lh1mV9KYsiOH2WzcVx9woC9u6EaiW1yG9yf+YRFD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:385:ffe:4516 with SMTP id
 e9e14a558f8ab-39aec2db3cemr49915ab.2.1722013322968; Fri, 26 Jul 2024 10:02:02
 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:02:02 -0700
In-Reply-To: <tencent_6858E8F6EDBECDCC79226C942EA56E00950A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a0eec061e29780e@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
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
Write of size 4 at addr 0000000000000028 by task syz.3.116/7392

CPU: 0 PID: 7392 Comm: syz.3.116 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
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
RIP: 0033:0x7f28ae575b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f28af3cc048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f28ae706038 RCX: 00007f28ae575b59
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f28ae5e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f28ae706038 R15: 00007ffeb6d24ae8
 </TASK>
==================================================================


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=137bde11980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146ff0d9980000


