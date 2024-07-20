Return-Path: <linux-kernel+bounces-257773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD51937ECA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 05:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C93A1F21878
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF8BA33;
	Sat, 20 Jul 2024 03:00:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9B8F68
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721444406; cv=none; b=VG0SyV5NE2rgg187HIAD9HGcKqbzfQEtAwVk/0B89qjMbnxrybRI3cl/YLlngqqQhXYV/XBSAInS4ROsuGwxJfpUlfzbS4rwLg3BX49zXyp/uc63BAUlHlJ4CvlYNrW8fsqWsOQThdcOrZwS82Inv5dgySFfC16+eXXRdAbywCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721444406; c=relaxed/simple;
	bh=xcKIbvGuiuA/N9SD/WHV2+IWuEk2Y5lFCVYPx1OlJkI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WlpwH3nVXKv8j3FFy0OghHWzbeXEuhscx6UZLYnGuvAJCkXAA/LeRx5nHkUJIfHJtu1dlUenMJri17JiiKqzpeKErCAuNb0EtZ9iU4YmNXuCQjCYE9O5AhDBgn6EbqIMsQOv/u7rQ3RwK0QCIVJS+EDpKTpk6bWuK3E/mcDKZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-802d5953345so356543639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721444404; x=1722049204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEoGyHkKKTp4hZk8msAkRbaz7NRXUIhTQApJK1opyY8=;
        b=r2oUR788Mx58e0UrReH+w3r7m/Ghz8BlQCzNQ027eVbNMLRMOT1NRiyeEFzTsYC+Lt
         rw+0hmoswCmi8XKZe6bKbYrqws/LZprZ66cqCo9VItqBPDpJS8mnF0HjjikL+G5o2a5E
         8nMEw4aySK9BJoeHZy2e6wK6myUQZ0n4rvecCOrOFuZuowVL5yUkzHg60aafNEMpCEUs
         FPrGK2e/lpbKyDbdzXukixUjdc3FanKI2rwHt/cwNgO0jb5dOOilFg9ih/ZaJBuxmD9P
         F7ef2ofeZfSAzXjkYZD/pFUOFCtfEpaQlmu79tGP9A2wKuFtg55dfDIE6Ey6zf+R+Q9T
         rDzg==
X-Forwarded-Encrypted: i=1; AJvYcCXin0TumZGHoNy4IFi9PYs+/JqMF+/bCQfO1pFg07Mw7s24vFkVcio5od1MnDP1Ehd/YP7WcZxXROJLpEy07CJf0Kl9UQWrV2xNvZ+3
X-Gm-Message-State: AOJu0YyaQGBzTavpMqghr0G6spXQyWzspU2gEiBpiTGepasT+BHVrLlF
	GWfdMfvY9K2LE3JK3iAjg16eTigo8lZuKfpE5Xg8il5bGTJzJa3DdNi4CpCaKnsAPJ66is+3n4r
	PSbcXB/uFQM1tkkUq61yeJ3f8u850mtAWfTbxcHFXN6p1pvArWppllqo=
X-Google-Smtp-Source: AGHT+IHnCehqFhrU1rhB05RxKmxP7q95OQ1TyeJ7G3MTkmlkQIur7Z5Ft5CVJXVRO/kgGvZnG9B6C+FgD8LcXuheaoM3l4uAwLiH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:9812:0:b0:804:bfc0:382e with SMTP id
 ca18e2360f4ac-81aa7cf6b47mr1176439f.4.1721444403568; Fri, 19 Jul 2024
 20:00:03 -0700 (PDT)
Date: Fri, 19 Jul 2024 20:00:03 -0700
In-Reply-To: <tencent_DC67EC3CBB36D2971037E24A78740777C909@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cf2f7061da5029b@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in wb_writeback

sb: ffff88802058c000, wb_writeback
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1578
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2837, name: kworker/u8:7
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by kworker/u8:7/2837:
 #0: ffff8880186ea948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880186ea948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009a67d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009a67d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff888020b920d8 (&wb->list_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff888020b920d8 (&wb->list_lock){+.+.}-{2:2}, at: wb_writeback+0x29e/0xdb0 fs/fs-writeback.c:2106
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 2837 Comm: kworker/u8:7 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:10196
 down_write+0x19/0x50 kernel/locking/rwsem.c:1578
 wb_writeback+0x836/0xdb0 fs/fs-writeback.c:2128
 wb_do_writeback fs/fs-writeback.c:2278 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2318
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0 Tainted: G        W         
-----------------------------
kworker/u8:7/2837 is trying to lock:
ffff88802058c0e0 (&type->s_umount_key#52){+.+.}-{3:3}, at: wb_writeback+0x836/0xdb0 fs/fs-writeback.c:2128
other info that might help us debug this:
context-{4:4}
3 locks held by kworker/u8:7/2837:
 #0: ffff8880186ea948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880186ea948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009a67d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009a67d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff888020b920d8 (&wb->list_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff888020b920d8 (&wb->list_lock){+.+.}-{2:2}, at: wb_writeback+0x29e/0xdb0 fs/fs-writeback.c:2106
stack backtrace:
CPU: 1 PID: 2837 Comm: kworker/u8:7 Tainted: G        W          6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4751 [inline]
 check_wait_context kernel/locking/lockdep.c:4821 [inline]
 __lock_acquire+0x1507/0x1fd0 kernel/locking/lockdep.c:5087
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 wb_writeback+0x836/0xdb0 fs/fs-writeback.c:2128
 wb_do_writeback fs/fs-writeback.c:2278 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2318
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: scheduling while atomic: kworker/u8:7/2837/0x00000002
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


Tested on:

commit:         50736169 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1212f7a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=eda89a33c5856f66f823
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1442b72d980000


