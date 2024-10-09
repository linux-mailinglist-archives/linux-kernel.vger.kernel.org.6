Return-Path: <linux-kernel+bounces-356629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A02996456
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C0F1F21A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1E188906;
	Wed,  9 Oct 2024 09:02:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525E17C22B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464525; cv=none; b=GDd5g6b07acviHCq822Obf92uNORMQuzJdGlLqLz8G4Z+L7tHCYht7xC5teNfphtidxi3IJhPzT7JPxadLNs/QeKZPvmR8ERUSEF5XbdM7Ovt9Tjzd7uOw24P9YPgLkFG5lJP5ykdTKv1YRoDNdwc3Vb8VDp3DS1L4EVglIJHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464525; c=relaxed/simple;
	bh=oo6VcK2rs3IY1w9JRgHXriWMgStsa4FSPSm1bMovECo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ETbQdvjH40QtvCh81fMdg/a7s17Q5Udjafvoel088OWOl8MidThC3aSeUjdNTeR0Ww1ijvTxfCX2vWo9JsergGpgvLL0KNXshMkBYeuKHIP0pl/Pz4KdZZCEbENp5bEr3PAX6ycgfQNTsR6j8hNmDIesRmvkPxHL+C3LZJIBtdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a348ebb940so69269895ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 02:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728464522; x=1729069322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1B1q5SrQHb6EVlMxxk3YyNU71Tt+c0BYVGTEt5xjEA=;
        b=GC1pgGX7hu7s6whIfiSu7yHQz9n9ihxND2IIQkHkPSifbgSQU6eUp5/a+RnkbWwhmL
         UEAfhkeMvW4Tz+OrYgM5RD8VnzOxeuxJP/980UQgegdLcDdDBjo8WmUGekqdVwZKLoBz
         A/L9zof8ZeRyUlOMpqDSF9q9Y7l6n0BMWDqYr3CVme2Q4XDIVFflxM2VlLxDOWl7yqns
         Vt5wXwF5cqQMFxRaq8LZj4T9y90pEF0MygNkLHXsNQJiVhrGCBAqQ/Ps5fbiAJ03YZcn
         qimR0bIHAFFCKjIjFEBtlWIUwcAcGuhjy/IWOtXQEYmM0g6FlDT/c77ut9/ICe05orsy
         JnPw==
X-Forwarded-Encrypted: i=1; AJvYcCVvY4vfIEdzDP9JWOzj8wgbVGY8m0L1SBpC2Bl56QZbaRZ2cEWownwOrPK3AaiJGCZySu8GqwQNQWAq4mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLoT0FRiuZ7Nbde1fquN5/B5Q4sK1fGqyA0fMNNuPfORsHWoq
	7iNgZNxTE0LdIzxmSJy/yNfjBladGJA2IPZTalbOhPWhUbycUJ9ih+0keL6GW+cFV8i5bX/6gOF
	NEEpj1bMrOnBHDpmXbqAo/S70phBwvPyTV8ZOzYgHUiwx1OhIg/L/Oq8=
X-Google-Smtp-Source: AGHT+IFgK3GaNEbcVvlW9Vo6Wb99Gd/Zp7pPI33DjYS3F9NH37d1CvzdroeqkCfW+TCKMS8yrvTXlI9Yris6gAl7LVlXkCHEly/P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:3a3:96c4:29bc with SMTP id
 e9e14a558f8ab-3a397cf14d0mr20026965ab.11.1728464522534; Wed, 09 Oct 2024
 02:02:02 -0700 (PDT)
Date: Wed, 09 Oct 2024 02:02:02 -0700
In-Reply-To: <tencent_BE79CA6D3C2FA56CF897FCEA4AED62CD6C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706468a.050a0220.22840d.0011.GAE@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in chaoskey_open
From: syzbot <syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in chaoskey_release

============================================
WARNING: possible recursive locking detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0 Not tainted
--------------------------------------------
syz.1.16/6532 is trying to acquire lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322

but task is already holding lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(chaoskey_list_lock);
  lock(chaoskey_list_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz.1.16/6532:
 #0: ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

stack backtrace:
CPU: 1 UID: 0 PID: 6532 Comm: syz.1.16 Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x2e3/0x410 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain kernel/locking/lockdep.c:3891 [inline]
 __lock_acquire+0x2185/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x24e/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35b167dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe690a74c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001c363 RCX: 00007f35b167dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f35b1837a80 R08: 0000000000000001 R09: 00007ffe690a77bf
R10: 00007f35b14fa000 R11: 0000000000000246 R12: 000000000001cf4f
R13: 00007ffe690a75d0 R14: 0000000000000bea R15: ffffffffffffffff
 </TASK>


Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15b89f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=5f1ce62e956b7b19610e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14adf707980000


