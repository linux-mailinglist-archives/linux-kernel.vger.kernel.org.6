Return-Path: <linux-kernel+bounces-428318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80F9E0CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CB31656C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B041DED53;
	Mon,  2 Dec 2024 20:08:39 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1F1DE4C3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170118; cv=none; b=TF30Hqj6ivYVZYJ6DFbxRehjnW6zREecJvHSZNrQ7I98o756rF7VvcPV8Awm07zDUzT6Xo427wG2lUdE4vYB/wwWZQKrbM1YG05TX3N98RM8Ige07Ob5TEheyHLM0lBMs+N8bR0gKWKjGd77nkTeZFKSo+gQ90U0/FwsAKmw9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170118; c=relaxed/simple;
	bh=qSiP/DGVB9480yaDs2l5qreFVEdTl016XfrHtwqi0RI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NjJ+A+XKlaiKe04/tV48ogxAahVn+ZS1ykQY+OOvlMrEfdeA6Bwx43EmHaNusRFReCnVYlCK4aQcoVQB3jVwstzEfOF+qlw56KL64gqWrJMQxFuE3jVdOHe/MyfAmikSs/cIbmLgQn6w/Jz1GV+R8BcgI5J/VIHlYSNAC07C7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso426183239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170112; x=1733774912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2DuQQt4YAp0ub8FM1kAcoO6DJSYOWK+rmFmkB4i84Q=;
        b=ueqb/dXGYES+kk+llhBXXFF8PghkRnqaTZzMhKBJANgi0etvg2WuYZHccmLIH2fBru
         i815fb4mmpEwYtW3kxuIdX/myvhFwpFjsnhblG/1PhzPWHHmLOiNiwblbX0l42VIPmDu
         qwIKYsB9LlXp+2xtCcdobiY7sRunNqggdWVmlNweyCN9emexG40ioVZxxP1jaYbIsegB
         BrSscqtuB3ifvjdsCGTR+w917ucEwtj7xh2hnbhWAZ8xData5bqO8zEojOtxv6hM/9m3
         deLiLIGnUHrKvUOzmE0wx13ooWOWpgoQndoSpaRdZkQGpsfgbAy0WopzJ0RC/pRex8JN
         YE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX18f4rUL/BMZ6dD3zRrxjtS19u5yt5/u21pQAmJNXBubGkd3Xu+j57Uogcuw4PHpPoE6w24ImuA9amGK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rCzZUhcxE1/l0/y19Q2QXvEx1auvM7njp/LBgLjnlUhg2go3
	NQfuf0mdLl9AY+5CFee5PTHZTvPs5oBnYdEdGOPjiCL/dk0mvizHY1UNrxuxpdhchYCrgmUQsdV
	IaMDqKauyRZXcm8AkI7e2MCx2mVnx0HX1FXa1XsXVGSQPiUsIM1NCU/s=
X-Google-Smtp-Source: AGHT+IFtyxEKBueGdGuMZU4vkQXU0qGEE/smJwJ2rK2FlcJ1e00B+Re17MWU94EgOYeMl7MJ2XuSH9YWJa64AvGK9MUVptgMiJHp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:3a7:d02b:f653 with SMTP id
 e9e14a558f8ab-3a7d02bf7ccmr184513945ab.0.1733170112491; Mon, 02 Dec 2024
 12:08:32 -0800 (PST)
Date: Mon, 02 Dec 2024 12:08:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674e13c0.050a0220.48a03.0029.GAE@google.com>
Subject: [syzbot] [net?] WARNING in ip6mr_free_table
From: syzbot <syzbot+6e8cb445d4b43d006e0c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7af08b57bcb9 Merge tag 'trace-v6.13-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105733c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae452ddde099ccb1
dashboard link: https://syzkaller.appspot.com/bug?extid=6e8cb445d4b43d006e0c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d04d30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142fcf78580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc5dc75196ac/disk-7af08b57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63b4670d0126/vmlinux-7af08b57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9d6e3a842d9/bzImage-7af08b57.xz

The issue was bisected to:

commit 11b6e701bce96f98474084f26821157cb0dccf69
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Sun Nov 24 15:40:56 2024 +0000

    ipmr: add debug check for mr table cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1443e9e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1643e9e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1243e9e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e8cb445d4b43d006e0c@syzkaller.appspotmail.com
Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7478 at net/ipv6/ip6mr.c:419 ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
Modules linked in:
CPU: 0 UID: 0 PID: 7478 Comm: syz-executor212 Not tainted 6.12.0-syzkaller-10689-g7af08b57bcb9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 94 fe a9 f7 90 <0f> 0b 90 e8 8b fe a9 f7 48 8d 7b 38 e8 f2 be 96 f7 48 89 df be 0f
RSP: 0018:ffffc9000ca37820 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888071720000 RCX: ffffffff89e4c674
RDX: ffff888030d1a440 RSI: ffffffff89e4c6ac RDI: ffff88802b0ccb40
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802b0cbc80
R13: ffff888071720000 R14: ffff888071720008 R15: dead000000000100
FS:  00007f8e0d5626c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc0ae64c68 CR3: 000000007c576000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
 ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
 setup_net+0x4fe/0x860 net/core/net_namespace.c:394
 copy_net_ns+0x2b4/0x6b0 net/core/net_namespace.c:500
 create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
 copy_namespaces+0x468/0x560 kernel/nsproxy.c:179
 copy_process+0x2a11/0x8df0 kernel/fork.c:2398
 kernel_clone+0xfd/0x960 kernel/fork.c:2807
 __do_sys_clone+0xba/0x100 kernel/fork.c:2950
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8e0d5a7419
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8e0d562238 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f8e0d631328 RCX: 00007f8e0d5a7419
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040020000
RBP: 00007f8e0d631320 R08: 0000000000000000 R09: 00007f8e0d5626c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8e0d5fe074
R13: 0000000000000000 R14: 00007ffc0ae64ba0 R15: 00007ffc0ae64c88
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

