Return-Path: <linux-kernel+bounces-332984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B697C1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964DCB21C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C21CB30A;
	Wed, 18 Sep 2024 22:23:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F8178CF6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726698207; cv=none; b=m7QWJ5fl5tDK6tI//3ZRlQZ03kbBLlFeIs/oBZmP/7UZOP8m9tEXufB9rQX3beAQHdbc9uduan4K/UzwYGUXmkX/tzxODaEyGpy9Uc9OfGUvdUEHnUQnTm6nM+B+/J40LetBHbB4GaBdU2iKEpRy7ycK4kSZ/xQHogmjE/briUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726698207; c=relaxed/simple;
	bh=bt5Y9Zq2Aubhd33F/e9LT0kLJ0XiYr166lnE61O2gVk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DLOW9eNee+6THYhgNgUpLOCYEaiNR7ij7vHAO/g429ppthYjMd42JWjr/lYbxbjdYm7nllsNdrQcNShmvcj7bbmYiCi1w/9tWx2U9IsAv0tOCj7i+Rj24xls4TaG4mGOZjZdeFrLmcyG8Xed/KAhDxOyjz8K6ZzFgdaERZgkIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04af50632so3398305ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726698205; x=1727303005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXSTMnfbUZ8RYfjmftrAsUTnKI7IlQ58ScrWqouQmKE=;
        b=o7uNKosLLSRPJum7/FIzuIhnapZpiBi1FKYdlCby8r6p/Cjcyk3mPA32fdk22Ah2Hm
         HMl7YH5XfPN5Kc+A2G6YHBWzqP1Fs/4+0XhPBGGgfQOjW10NUZVZMxvudodMNLNOBmqB
         DPJG86p36WwXX+VKMXGMiUIbv5sWsBrc2m1QVpLGdYBix0F4wzGZTRnZy8uSghAePYHT
         kKYpni/dKoTYwvkOxc5CGRtAXwDCtLSnqt+ufjpBoo3M4rLAQ2u74QinHa12nddh/O7m
         U5gCxAjF6Mq2Ahcjrrzrop5LsqCGXZNg0H1WRKV1/Nx+jv3gjP2jQ7IN54Q+vtcgWjYc
         uiFQ==
X-Gm-Message-State: AOJu0YxKytBC95uPqTi80lzY1ch5YKQJz4lR2DZ2ArVbdMzD+dBLKgWc
	bDteebTkkd0WzLpXEO1MmxLOJOr0bIDKyd5ISlsr9n7ZT51c0RN+/w6B2H6N1SvlohaSO632M7L
	e8iBmgrBFSH9DGtf2TDlnAdPbNu32GbE6NbJToD2XCsN0LP9VGXdzqIg=
X-Google-Smtp-Source: AGHT+IGlhzJbduMuROvITQHEhp8mQNjc/MtKUh4FAg5DOdLHl8W1Cj6jQbPR5I2nGO8TKlvUJQhuRU9T7QsNxOokvsfPRG8L9ews
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a49:b0:3a0:9f71:c6e with SMTP id
 e9e14a558f8ab-3a09f711033mr111117475ab.22.1726698204808; Wed, 18 Sep 2024
 15:23:24 -0700 (PDT)
Date: Wed, 18 Sep 2024 15:23:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eb52dc.050a0220.92ef1.0006.GAE@google.com>
Subject: [syzbot] upstream test error: BUG: stack guard page was hit in corrupted
From: syzbot <syzbot+d5db198a0f40411f24c3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153e7fc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c78e7c8f41d443e6
dashboard link: https://syzkaller.appspot.com/bug?extid=d5db198a0f40411f24c3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f4127f9a9466/disk-4a39ac5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23dcf778c269/vmlinux-4a39ac5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/386c61739e91/bzImage-4a39ac5b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5db198a0f40411f24c3@syzkaller.appspotmail.com

BUG: TASK stack guard page was hit at ffffc9000005fff8 (stack is ffffc90000060000..ffffc90000068000)
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:error_entry+0xd/0x140 arch/x86/entry/entry_64.S:1007
Code: fd ff ff 85 db 0f 85 8e fd ff ff 0f 01 f8 e9 86 fd ff ff 66 2e 0f 1f 84 00 00 00 00 00 56 48 8b 74 24 08 48 89 7c 24 08 52 51 <50> 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 41 57 56 31 f6
RSP: 0000:ffffc90000060000 EFLAGS: 00010046
RAX: 0000000000000002 RBX: ffffc90000060088 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b20128d RDI: ffffffff8bb130e0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000005fff8 CR3: 000000000dd7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 </#DF>
 <TASK>
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:error_entry+0xd/0x140 arch/x86/entry/entry_64.S:1007
Code: fd ff ff 85 db 0f 85 8e fd ff ff 0f 01 f8 e9 86 fd ff ff 66 2e 0f 1f 84 00 00 00 00 00 56 48 8b 74 24 08 48 89 7c 24 08 52 51 <50> 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 41 57 56 31 f6
RSP: 0000:ffffc90000060000 EFLAGS: 00010046
RAX: 0000000000000002 RBX: ffffc90000060088 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b20128d RDI: ffffffff8bb130e0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000005fff8 CR3: 000000000dd7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	85 db                	test   %ebx,%ebx
   2:	0f 85 8e fd ff ff    	jne    0xfffffd96
   8:	0f 01 f8             	swapgs
   b:	e9 86 fd ff ff       	jmp    0xfffffd96
  10:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  17:	00 00 00
  1a:	56                   	push   %rsi
  1b:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  20:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
  25:	52                   	push   %rdx
  26:	51                   	push   %rcx
* 27:	50                   	push   %rax <-- trapping instruction
  28:	41 50                	push   %r8
  2a:	41 51                	push   %r9
  2c:	41 52                	push   %r10
  2e:	41 53                	push   %r11
  30:	53                   	push   %rbx
  31:	55                   	push   %rbp
  32:	41 54                	push   %r12
  34:	41 55                	push   %r13
  36:	41 56                	push   %r14
  38:	41 57                	push   %r15
  3a:	56                   	push   %rsi
  3b:	31 f6                	xor    %esi,%esi


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

