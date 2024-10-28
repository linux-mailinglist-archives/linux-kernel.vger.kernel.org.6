Return-Path: <linux-kernel+bounces-385387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0923E9B368E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB57C284C68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63D1DF24B;
	Mon, 28 Oct 2024 16:33:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A821DED7F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133209; cv=none; b=d8g7LCWI30LHe/XCzsReXaORqHAQxbbQ38hu1bFw0Iucb4DiOQB6+/Sxk7s3gsJ+o7AM43MYtODXhmxbo+xfhK0ELpmfAxF7Q9o/Mc7E7R9eIejWv9RW5g9uDbQGpHZhXHgzuS1o53043s7j+AgteVW5wSoHT2BUC1oX/YZJp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133209; c=relaxed/simple;
	bh=J10zdIX9MuypX2OJwxeZRKL1UkpOMLU6m7Y4OimwbAg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lKyGzJ7T9gvvwmAy65zvJYMWyPYmOc7s9OoGlX6SQoY0nbzn7Sf3HeS1Ty7Q110Y+Vze8yv9C8MDJQqZtrRFzrcKOsI+40YDefAf/oyGlKsYFe9DxJrRVUmc7L2AEIvNmoBq4DozaK1lRDlMbo0lg7Tdv7IlZI2u7F+MbMTbSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4f3d7d13fso13256675ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133206; x=1730738006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUq3+aXa4IvDT+Jzi8XCAyiYff+dQVkvNTEpmJ/Hkh8=;
        b=OZ4wOgOSW9VpVbmT0dyfXabPQnC3jMmopPKafh8fh8yawz4JLFbhvCpyC49cPV/dJ6
         EdyHZ8jT2FGBi+OS2FitFS1dM4hhcTZiX4if0MlSlye4qfV5KxQp+cCv5rqu0uDV2JxK
         v7cYnzWP5A0VxgFXmCY29SZC3t+oEQH1zcF3AVkh/la0gTmMqKwbipQJqpcWr8OWLIT5
         r9AclWrJagwrtjVJcJm1hA25ZRG1aHdHKXwM35mXPb6jnOvQBewRt6Hb+g5124DyQhKP
         AAFT+8achhY8/4Jnmb5oaNAuwGV1GmuSiuy9c/Z8bAMjWCjo/ZFRHkS9hghyLnQ5hoGK
         Q58Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFK0XuFSQglLdTVDLj+2uS/Ll3dUHMibZkGKKV5tAo3T0htSMi6O2/Cf5DEoWKEA8O8fn5g1qJ6rkkCeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsugdAxdMvXP0klVg1aQ1S1RRK3dzKZbu+6xbFxGNuckwVUe78
	jbqkBUUHYrNciazWlaLe+TCM8y9jJtM2s28d6n2B2UOjHZi/OK3ixjxK1WZsQjEgAQeUUodYUOe
	yhqC+fGZRCdag62M3A0n4nIRtMAzseTZi0XmAhWd9WZoeZTv/Mk8ZvD8=
X-Google-Smtp-Source: AGHT+IHP0p5B0wl/aHPZDoZKkS0o7JGjRxqZ/YKI+q4nVRLTpuMPLYOll3o2SzhZ6LbFMM66cZ5YOVuZIeBk3m8/1aSESlxju6L5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a4ed32b38dmr71621305ab.26.1730133206675; Mon, 28 Oct 2024
 09:33:26 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671fbcd6.050a0220.21b2f.0009.GAE@google.com>
Subject: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release (2)
From: syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com>
To: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a6324b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a34ca8ca33c0e535
dashboard link: https://syzkaller.appspot.com/bug?extid=dee8aa54cb2f5a150f9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484165f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b2ebb980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05e1e9a9e3e9/disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9ad3be6c91b/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/737d48c357b7/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at drivers/android/binder_alloc.c:897!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events binder_deferred_func
RIP: 0010:binder_alloc_deferred_release+0x68c/0x820 drivers/android/binder_alloc.c:897
Code: 00 00 00 48 c7 c6 20 7f 8d 8c 48 c7 c7 e0 7c 8d 8c 44 8b 44 24 14 8b 4c 24 10 e8 ef fd bb f8 e9 56 ff ff ff e8 d5 4b dc f8 90 <0f> 0b e8 cd 4b dc f8 48 89 ef e8 05 46 9c f8 e9 21 ff ff ff e8 ab
RSP: 0018:ffffc900000e7b98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880415e3220 RCX: ffffffff816b1a6d
RDX: ffff88801d6c0000 RSI: ffffffff88b1332b RDI: ffff8880415e3260
RBP: 0000000000000003 R08: 0000000000000001 R09: fffff5200001cf65
R10: 0000000000000003 R11: 0000000000000000 R12: ffff8880335c1860
R13: ffff8880335c1910 R14: ffff8880415e32c8 R15: ffff8880415e3000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f005c851546 CR3: 0000000079838000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 binder_free_proc drivers/android/binder.c:5237 [inline]
 binder_proc_dec_tmpref drivers/android/binder.c:1559 [inline]
 binder_proc_dec_tmpref+0x291/0x590 drivers/android/binder.c:1552
 binder_deferred_release drivers/android/binder.c:6269 [inline]
 binder_deferred_func+0xeda/0x12e0 drivers/android/binder.c:6296
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:binder_alloc_deferred_release+0x68c/0x820 drivers/android/binder_alloc.c:897
Code: 00 00 00 48 c7 c6 20 7f 8d 8c 48 c7 c7 e0 7c 8d 8c 44 8b 44 24 14 8b 4c 24 10 e8 ef fd bb f8 e9 56 ff ff ff e8 d5 4b dc f8 90 <0f> 0b e8 cd 4b dc f8 48 89 ef e8 05 46 9c f8 e9 21 ff ff ff e8 ab
RSP: 0018:ffffc900000e7b98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880415e3220 RCX: ffffffff816b1a6d
RDX: ffff88801d6c0000 RSI: ffffffff88b1332b RDI: ffff8880415e3260
RBP: 0000000000000003 R08: 0000000000000001 R09: fffff5200001cf65
R10: 0000000000000003 R11: 0000000000000000 R12: ffff8880335c1860
R13: ffff8880335c1910 R14: ffff8880415e32c8 R15: ffff8880415e3000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f005c851546 CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

