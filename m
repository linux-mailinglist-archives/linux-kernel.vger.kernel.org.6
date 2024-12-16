Return-Path: <linux-kernel+bounces-446761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883B9F28D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C742F18853D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B73155C82;
	Mon, 16 Dec 2024 03:40:23 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB21E4AB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734320423; cv=none; b=quCnuy4Su8+JxvB5ax43h+sz2OGKIjOMHuNrgal/OeWDTcYQpdz9ik0MPs99EwBEVwVI9BSlh8vujmUqu6mwtCtG1vTzMQ5ubT+eogQMnYH5Cb+fqmodVIxNMHiBCT15iPYWLkkVDqj5jEMV985Eo1Kp2CFgaypwRUMnFjgZIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734320423; c=relaxed/simple;
	bh=kh7WXgQmMD0VNcpIz7BxS53P8ZnSyWco4ZVc6r6/17Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OOK4IKMd9p5JW6G4yLlZcAElO1CajREIQJqEhwwmIFauzeaX8/P5+oo9knGFjyP6KAruwl0UcNJi8vDnZO7TmYhrlqahhPLB3w9sBSI3+1ArlKCHQaqVIwu/M4FEhN9KKAPt1zwH/WwhMzUVO3iUjsHnXH+mtx1HrQHjMhO36S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ac005db65eso36596215ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734320420; x=1734925220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOB0HEugu8rtEkdqAGGbh6aZOu7rOkf9C7CquvPAPp8=;
        b=C4OPWst+FzyIcaaEi6qP5+1bIGD1MtZ6FH/eyZrWqQzpb2HvilNjBcCS+0yrn9fXxs
         VyhL63NQQvGliYAwe1p5XB32XP+hjb4JjLVLeiY0gqQUo6KHYsJXjSPyK6lkc/c8v9ty
         t5KsbJrDDmZzqD2iolmVI5HX1GuCTNnYu5fGj72EBKXt+sHLKvzbuPtV+wZGivvpFjmd
         HssAklZUgjnAgyB9ZzS9cndtZJWTZqmPX/B0jw68XFG+6Yoiw6dFXcSBC1I0R2B8FylT
         XV/Lvqs0Kl5QHV67oM8RlrkJ0JrQ73etXMv+1xleTyte0bGyUdEXRQKcmPLVAPMwliYS
         281w==
X-Forwarded-Encrypted: i=1; AJvYcCV+TU/RneUp0u7GTSTDdfAKrgvxYyusUU5u+2QboXeCDhyq7MjrkLL3EYanmh+kT6/a+ePRVx7EJ4z2NSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mOmYi6FN4D7CsVosOPDUGBS1fkjjrgK9RRWwmJw0SnufEJe+
	wi/EF4nZpRGz6Ut6LssOADUj0lSez/0h1cR55EYHDhU1eQnMuybBCt7AmFXG810in6rmqB7YdNe
	ovf7Oa6bHqM3fOzOB5ZUetM1ylQ4OeD4uCnI1IGryFcsIEiwZyuF3b+8=
X-Google-Smtp-Source: AGHT+IGYWsLJFAeuDpjMOzB8xk5mcZPCEY7uYbF6MFVbf75UTJiHPdChILTkgBkWwMQsTgXEUukgprSjqTBtGSmv8tMr/52rduET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3a7:e286:a56b with SMTP id
 e9e14a558f8ab-3aff6213bf9mr119399365ab.5.1734320420552; Sun, 15 Dec 2024
 19:40:20 -0800 (PST)
Date: Sun, 15 Dec 2024 19:40:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fa124.050a0220.37aaf.0113.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in vsscanf (2)
From: syzbot <syzbot+8a3da2f1bbf59227c289@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116904f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=8a3da2f1bbf59227c289
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15758d44580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156904f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a3da2f1bbf59227c289@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5823 Comm: syz-executor234 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:vsscanf+0x1a4/0x2a30 lib/vsprintf.c:3466
Code: db 74 5e e8 1e da 82 f6 49 8d 5d 01 48 89 e9 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 48 89 5c 24 70 49 89 dc 41 0f b6 45 00 <0f> b6 14 11 48 89 e9 83 e1 07 38 ca 7f 08 84 d2 0f 85 1e 19 00 00
RSP: 0018:ffffc90003cc7668 EFLAGS: 00010246
RAX: 0000000000000030 RBX: ffffffff8b5c7801 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff8b1663d2 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000030 R11: 00000000000a2001 R12: ffffffff8b5c7801
R13: ffffffff8b5c7800 R14: dffffc0000000000 R15: ffffc90003cc7eb0
FS:  0000555573fa8380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000073a06000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sscanf+0xc8/0x100 lib/vsprintf.c:3722
 split_huge_pages_write+0xa16/0x1f60 mm/huge_memory.c:4178
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9a505582e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdae2774c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffdae277698 RCX: 00007f9a505582e9
RDX: 0000000000000004 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f9a505cb610 R08: 0000000000000000 R09: 00007ffdae277698
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdae277688 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vsscanf+0x1a4/0x2a30 lib/vsprintf.c:3466
Code: db 74 5e e8 1e da 82 f6 49 8d 5d 01 48 89 e9 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 48 89 5c 24 70 49 89 dc 41 0f b6 45 00 <0f> b6 14 11 48 89 e9 83 e1 07 38 ca 7f 08 84 d2 0f 85 1e 19 00 00
RSP: 0018:ffffc90003cc7668 EFLAGS: 00010246
RAX: 0000000000000030 RBX: ffffffff8b5c7801 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff8b1663d2 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000030 R11: 00000000000a2001 R12: ffffffff8b5c7801
R13: ffffffff8b5c7800 R14: dffffc0000000000 R15: ffffc90003cc7eb0
FS:  0000555573fa8380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000073a06000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	74 5e                	je     0x60
   2:	e8 1e da 82 f6       	call   0xf682da25
   7:	49 8d 5d 01          	lea    0x1(%r13),%rbx
   b:	48 89 e9             	mov    %rbp,%rcx
   e:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  15:	fc ff df
  18:	48 c1 e9 03          	shr    $0x3,%rcx
  1c:	48 89 5c 24 70       	mov    %rbx,0x70(%rsp)
  21:	49 89 dc             	mov    %rbx,%r12
  24:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
* 29:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx <-- trapping instruction
  2d:	48 89 e9             	mov    %rbp,%rcx
  30:	83 e1 07             	and    $0x7,%ecx
  33:	38 ca                	cmp    %cl,%dl
  35:	7f 08                	jg     0x3f
  37:	84 d2                	test   %dl,%dl
  39:	0f 85 1e 19 00 00    	jne    0x195d


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

