Return-Path: <linux-kernel+bounces-251687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970993083A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 03:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BEC1F219BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5503D6A;
	Sun, 14 Jul 2024 01:46:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE97F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720921580; cv=none; b=RMbA+AGtDuiakAnsV4hviiSsRdMmhXdhCeo84p3ARxi/jISsvCh42lQiOR//y+J8P/g9+OeFWgto40MJRHtRbrmJVkh9Cg0hJOZ6Tmn6fxMqq3rs4kk87O9vOElQKExkNG7ZqbhQNEDfpyorhG8xpw6biA+9XVJwyI7G3Kn2/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720921580; c=relaxed/simple;
	bh=N+2QVYMvkVamHVVVCTa+TrG7H9lzDDKjIe0szJMZfgs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DQGXnZLWuW9dn2lz2VP4PYP/Wr0N/XdwvYuqzY/smxhr67Md6xCjtnvW7DUOm2ezUqh2qhipdhUgQQL0qaQ8YCl19beTwopiuC4N63Bmiprc/KyLUUF9F9yXFV6G9zBkSJzgtgDo7xAR0SurCX9uNnIBeZqm3bS3yH0BeJcZVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso351828939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 18:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720921578; x=1721526378;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGcGkmHeYHi8rLYFZNi8Px3XBkGcuRBEtB7NvVt2g2U=;
        b=mvJH6S9w0c2/gw3EUo6dyFOjHaBMxhTlkW/3CG3membTgFJg+5Wxu9XM21xC4KteBS
         PBl8e/2jExDrlsaZqeCYEtc9tS+VEj/rp3iq4rM3SWo/QmQyZ+nU5O1l2FAoTh17nac+
         eZxZ6Er/N47oK5PW1VmMdPXIiSXaE18poI156p+qeijLuHROnVlKyZhLydKDBegih/LW
         ZPCGmQa+KgIPceDZD22WK1VeOLgovhd+uif4BFD15PNEXdW+y7qT1a+VokH/koUpdffQ
         cpuaqPuGxQuboGG8WA+kdotL3evB2iUr4x2Ah3062mvxGSqbMg2ESwBIm4+imdvoMg8T
         0vTg==
X-Forwarded-Encrypted: i=1; AJvYcCUj0ABg0xvtXlJ+lIuZPE44PNEYAZS35uAOdl/LV4WqpUMnXm/bJYJuehoiWNtFbbl7FAg+JTWvIiR7akRsFhXiqkfua3wxUcJGeFvk
X-Gm-Message-State: AOJu0YyCus2Y1Xj7j7ALmNJ0fDPU2wftxEzLMq0BpTGiCaap1F4oCMjF
	5YqpDNaskK56garbSbHxKAI7KwxmE0z22YZlNpVAJvfXVQOwfIBm3+l2rCQo8NcawjyXrR1L2G1
	akOJnBGdhdBJvEr0GvDQdyRTLJRCRyJ/78KrCLHgvG9QgM6qahiQMbts=
X-Google-Smtp-Source: AGHT+IGo7nDXP3cKgYDClfNyKCefvHbReZ7CgqRMPgLIAEhDX+5Zo04bbgs6uKN0+r0fHBLxUjgJlrMAtKYk3l6abc92m26Kyouo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164b:b0:80c:826f:ae79 with SMTP id
 ca18e2360f4ac-80c826fb13amr16573839f.2.1720921578189; Sat, 13 Jul 2024
 18:46:18 -0700 (PDT)
Date: Sat, 13 Jul 2024 18:46:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ac71f061d2b4757@google.com>
Subject: [syzbot] [mm?] kernel BUG in resv_map_release (2)
From: syzbot <syzbot+29f7252ab8a82a688b5d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    34afb82a3c67 Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ff8441980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=29f7252ab8a82a688b5d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2c5f697ee8f/disk-34afb82a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2aaaa729806e/vmlinux-34afb82a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3571e3d3b366/bzImage-34afb82a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29f7252ab8a82a688b5d@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/hugetlb.c:1130!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 21140 Comm: syz.3.4250 Not tainted 6.10.0-rc7-syzkaller-00012-g34afb82a3c67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:resv_map_release mm/hugetlb.c:1130 [inline]
RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1115
Code: a9 ff 48 85 db 75 1d e8 4b af a9 ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 23 19 fb ff e8 2e af a9 ff 90 <0f> 0b 4c 89 ef e8 d3 72 05 00 e9 3d ff ff ff 48 89 ef e8 d6 71 05
RSP: 0018:ffffc90002d5f928 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e4353b
RDX: ffff888029391e00 RSI: ffffffff81e43562 RDI: 0000000000000007
RBP: ffff88802e217860 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802e217860
R13: ffff88802e217860 R14: ffff8880223b5e08 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587202808 CR3: 0000000069194000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kref_put include/linux/kref.h:65 [inline]
 hugetlb_vm_op_close+0x4ef/0x5d0 mm/hugetlb.c:5233
 remove_vma+0x8b/0x180 mm/mmap.c:141
 exit_mmap+0x4d4/0xb20 mm/mmap.c:3365
 __mmput+0x12a/0x4d0 kernel/fork.c:1346
 mmput+0x62/0x70 kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b7/0x2ba0 kernel/exit.c:863
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1025
 get_signal+0x2616/0x2710 kernel/signal.c:2909
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a21f75bd9
Code: Unable to access opcode bytes at 0x7f1a21f75baf.
RSP: 002b:00007f1a22c850f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f1a22104040 RCX: 00007f1a21f75bd9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f1a22104040
RBP: 00007f1a22104038 R08: 00007f1a22c856c0 R09: 00007f1a22c856c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1a22104044
R13: 000000000000006e R14: 00007ffd0fcf9b50 R15: 00007ffd0fcf9c38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:resv_map_release mm/hugetlb.c:1130 [inline]
RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1115
Code: a9 ff 48 85 db 75 1d e8 4b af a9 ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 23 19 fb ff e8 2e af a9 ff 90 <0f> 0b 4c 89 ef e8 d3 72 05 00 e9 3d ff ff ff 48 89 ef e8 d6 71 05
RSP: 0018:ffffc90002d5f928 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e4353b
RDX: ffff888029391e00 RSI: ffffffff81e43562 RDI: 0000000000000007
RBP: ffff88802e217860 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802e217860
R13: ffff88802e217860 R14: ffff8880223b5e08 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020067000 CR3: 00000000669cc000 CR4: 00000000003506f0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

