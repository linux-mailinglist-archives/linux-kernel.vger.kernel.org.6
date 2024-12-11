Return-Path: <linux-kernel+bounces-441737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1939ED34B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C3E161A26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7021FECC0;
	Wed, 11 Dec 2024 17:23:23 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722141FECA1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937803; cv=none; b=dV526OBPx4OvF/Z71MQnmxnyV2XGtCbz7qPtdDLF2O8iY2lkXbb6yS6wZ7DyMYODWx7mzRgUZB1KgJoAxy0Q9VeTQOs4xlAS/Cr26nQ1a2vzHxpE9uOLltiChEkTZQ07YxwUoE0eU8m1Si5HGawKarIb/gUaMRid1NeoJmRuedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937803; c=relaxed/simple;
	bh=IdYyK45BBh7f/4V4ntwntZE9St/TyZ24rrMt5FYpbbg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a+nCPwo5peNUAcsVRbpovoLMmfA9F0ShxVQENfBAFvSTTVNagchVN4yYXU/Xsa09SR5VXv0cFt2ffHuMcn9DdOL11V9gSrY6esDtVGjFIK52Q+cQiqhK+MN8UJZAeWjedk+SuA35IuATiHMRqOCSWax6vdWXV3MwYPRgIRQS1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so69698955ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733937799; x=1734542599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zIba66nBBaj0pJFFxdj0qayV1im2oVhQgHCS7G4314=;
        b=RpFsYCeesogO7Mc9b0r3b1rbG2A34b/lAFkm8l1XQXjyO9TgCoopBv2NsZ/KL1xd5n
         NEYA8+qYmoHXJbHWlNjNzIfOWYWkvk5FgwuS/LG/nlApr8f3oFX8nH7NZG0n/P//UpFB
         FDCK87vBZAVR1yjkbEcPwXA5SRUtc+o6uW7QzIRpvLXF4LP1B59+Cax9Qt/gaxuvqCnL
         LFk/jTrWxqK/YP9NQy0+69xEFc5s1kFzGrL0cnWm7cT+61y+KZYNRHOiVINrFtD+Zny/
         g4RQJYWTPf7CwgUxb9skAn+FzoJvB2tk8j2r8tzDBBzck9zbP+uM7V2NJIHYdI/caOA8
         L+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCULfNJFTEGWWlOaDwnfubq0ZOAfWto0/WfXew1o65ztZ8VhQiu7p/sTIMWDc3ASH8Dq4483xt73UT62fZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRM2KuIUhPCp9l7TikEyPndn/TMitXMHCRu0cO+UwvAeMteCCJ
	2Dr3Ut8aJT2A5KTGqvhRKT20IubxVGkCW0ZbEFrdX1SV92f49Hj8fsQQm5Tf0xKzpDuvLhiDZA2
	pQ6SnKOVRK2IDyOQx2zImqlTaWDusQ30Jc55xDXvZoCN/0B06qxWGvUA=
X-Google-Smtp-Source: AGHT+IEIGIvHwDwx6+RQ0NnRjZl+8AoAo3/8F4AQhkNRaFV1BQ/6Fm0cR7O5PoDYsyerVYVDX6ORpUf1dWrctfkDoyD3+/W/Uxpr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160b:b0:3a7:e67f:3c5b with SMTP id
 e9e14a558f8ab-3ac47a61e9fmr4104265ab.2.1733937799620; Wed, 11 Dec 2024
 09:23:19 -0800 (PST)
Date: Wed, 11 Dec 2024 09:23:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759ca87.050a0220.1ac542.000e.GAE@google.com>
Subject: [syzbot] [kvm?] WARNING in __srcu_check_read_flavor
From: syzbot <syzbot+4a606091891fbc6811cf@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    af2ea8ab7a54 Add linux-next specific files for 20241205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1267ab30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=4a606091891fbc6811cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8af0861258fa/disk-af2ea8ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffb38cf7a344/vmlinux-af2ea8ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6fbd2e50358a/bzImage-af2ea8ab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a606091891fbc6811cf@syzkaller.appspotmail.com

------------[ cut here ]------------
CPU 0 old state 10 new state 1
WARNING: CPU: 0 PID: 7665 at kernel/rcu/srcutree.c:734 __srcu_check_read_flavor+0x107/0x150 kernel/rcu/srcutree.c:734
Modules linked in:
CPU: 0 UID: 0 PID: 7665 Comm: syz.1.296 Not tainted 6.13.0-rc1-next-20241205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__srcu_check_read_flavor+0x107/0x150 kernel/rcu/srcutree.c:734
Code: c6 c8 01 00 00 4c 89 f0 48 c1 e8 03 42 0f b6 04 20 84 c0 75 38 41 8b 36 48 c7 c7 60 cc 0b 8c 89 ea 44 89 f9 e8 7a 8e db ff 90 <0f> 0b 90 90 eb a2 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 64 ff ff ff
RSP: 0018:ffffc90003d8f638 EFLAGS: 00010246
RAX: 7f55abc023df8500 RBX: ffffe8ffffc66be0 RCX: ffff88801eb93c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000000000a R08: ffffffff81600dd2 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: dffffc0000000000
R13: 0000607f47666bc0 R14: ffffe8ffffc66d88 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faaec237000 CR3: 00000000250bc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 srcu_check_read_flavor include/linux/srcutree.h:269 [inline]
 srcu_read_lock include/linux/srcu.h:247 [inline]
 kvm_mmu_notifier_release+0x2f/0xd0 virt/kvm/kvm_main.c:863
 mn_hlist_release mm/mmu_notifier.c:321 [inline]
 __mmu_notifier_release+0x3e4/0x670 mm/mmu_notifier.c:359
 mmu_notifier_release include/linux/mmu_notifier.h:402 [inline]
 exit_mmap+0x142/0xd50 mm/mmap.c:1239
 __mmput+0x115/0x3c0 kernel/fork.c:1350
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9b2/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc5e197fed9
Code: Unable to access opcode bytes at 0x7fc5e197feaf.
RSP: 002b:00007fc5e27460e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fc5e1b46088 RCX: 00007fc5e197fed9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc5e1b46088
RBP: 00007fc5e1b46080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc5e1b4608c
R13: 0000000000000000 R14: 00007fff899d8670 R15: 00007fff899d8758
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

