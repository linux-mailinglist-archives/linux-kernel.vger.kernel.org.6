Return-Path: <linux-kernel+bounces-436545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067639E875B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 19:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C32164324
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2F189BBF;
	Sun,  8 Dec 2024 18:47:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CABC14373F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733683624; cv=none; b=ugviFcEGAbX69Da/T/0l4yJlcfE4hJMnDZO63e+3NOwlazwRRiMRK9oUin2ZbYsptKAxYA5aGWwQXI8B7ktSHy8+wrluYqB47bB0OkAoqqLJ94qOqERzS4wwHludwoZhwME5s3wAYCrHMrusJ2/a+CXCYSKRUEfcctsfwwZ21Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733683624; c=relaxed/simple;
	bh=KNU8KmCT9yq1Y3oVWNmqhJN3lKBd9PheEgvzMWae51g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OdyNS06xVgb3XhMqAUfw6UvCLxjq8qQivqcP6ByAgHgPH9jz5/ZtOHjnd8JcJbHxPz6BHPWAPZDnr5jC6URlhXs5obyEM+UNvlA8yqgTdsRMAAQ5pl47NhudMruUukPO/O9eChd0SvUzcmhCi5n70AosK1h2LN6QhZTqtbF/iGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so24865655ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 10:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733683622; x=1734288422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOyvVHs7fPVVHMmk6cC3sxmiGi+PskbI93Nc45XBoCY=;
        b=E5Hotv7+3Q0sdsBbmUby8zuZ9yRE3ZpbIQvIitVENd4lpKWb4NpTng2A/j/Hq2X3Pd
         4dHWF5KvS8cjQmymGzJRNkzocGSrzFclb/IzKoIC8zSsi84y9nlHaqYhbKAoEMJObSyP
         kgucfFtE8WfW2F8jjLskL3zkdY97HvLEilgqGWOHe3AfbqOFOVRk3ppznL0go6F9d3Ep
         5Ql749IVDUR8kWSUYOvp4HZ/zgOLHxkuRyRN2QMa92ahqwXJUL+91c83VCsFWKILe5kp
         GlMYdo1479qR+OpBZvfPfIyamq1h0RX5qaP8ITcdeZ51TfbyQyECJ92KTVSM5GPNmMiS
         qTtg==
X-Gm-Message-State: AOJu0Yxicc7SsInSny6PhK4NG2Sdk/GpK5hWGpKEeTIZxfTWTcanxIKU
	45+Mn9uXg5/ucDewTV44ryw8nINlNYE/32XoWv31D+V16VKujD6tCLd+iqOFYraqVUKMzE9C5oH
	FXgCGmM4C0RacEcJFwUsoRZ3qBiHxCKPM7t7zWEf9zMq2Ksn8P7OHKV4=
X-Google-Smtp-Source: AGHT+IEPFFMoYZTJa2UCsKnWvjHHxqpM6vHj6zPaV/41qWNOvIMgu949aEsOI2KykawT+X6YaWYluZNviHUCbnB+6oqfyCzGmTVq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3a811e073afmr105321475ab.17.1733683622366; Sun, 08 Dec 2024
 10:47:02 -0800 (PST)
Date: Sun, 08 Dec 2024 10:47:02 -0800
In-Reply-To: <D66J2UCA2K95.14GOLVW7ECBK2@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6755e9a6.050a0220.a30f1.0180.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in mgmt_remove_adv_monitor_complete

============================================
WARNING: possible recursive locking detected
6.13.0-rc1-syzkaller-00337-g7503345ac5f5-dirty #0 Not tainted
--------------------------------------------
syz.2.3904/14857 is trying to acquire lock:
ffff88807518c078 (&hdev->lock){+.+.}-{4:4}, at: mgmt_remove_adv_monitor_complete+0xca/0x5d0 net/bluetooth/mgmt.c:5528

but task is already holding lock:
ffff88807518c078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x5d4/0x11c0 net/bluetooth/hci_sync.c:5203

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hdev->lock);
  lock(&hdev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz.2.3904/14857:
 #0: ffff88807518cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88807518cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508
 #1: ffff88807518c078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x5d4/0x11c0 net/bluetooth/hci_sync.c:5203
 #2: ffff88807518c690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_dequeue+0x44/0x3d0 net/bluetooth/hci_sync.c:887

stack backtrace:
CPU: 1 UID: 0 PID: 14857 Comm: syz.2.3904 Not tainted 6.13.0-rc1-syzkaller-00337-g7503345ac5f5-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 mgmt_remove_adv_monitor_complete+0xca/0x5d0 net/bluetooth/mgmt.c:5528
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:645 [inline]
 hci_cmd_sync_dequeue+0x22b/0x3d0 net/bluetooth/hci_sync.c:890
 cmd_complete_rsp+0x4c/0x180 net/bluetooth/mgmt.c:1469
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9561
 hci_dev_close_sync+0x6d0/0x11c0 net/bluetooth/hci_sync.c:5211
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2175180849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2175eeb058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2175345fa0 RCX: 00007f2175180849
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000004
RBP: 00007f21751f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2175345fa0 R15: 00007fff28348728
 </TASK>


Tested on:

commit:         7503345a Merge tag 'block-6.13-20241207' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118e4b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136743e8580000


