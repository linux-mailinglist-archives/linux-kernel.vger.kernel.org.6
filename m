Return-Path: <linux-kernel+bounces-411619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBE9CFCE8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04C2B27301
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61D192B85;
	Sat, 16 Nov 2024 06:37:40 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEEF18FDAF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731739059; cv=none; b=KJKaJupx25wgLjZtSvNOBSxccc4KcJfBZWnF3qfZGHO8HpwIdwjqorj2AxYW2IfpsC+KdSb9FvUkna6TUsTmJ9YF4Xd59GFR49BtGgetoW7pmWsvmYclAMpCj8O2GVpu0Lki6xVgQkfNio0cm1fuBPEIVWzvtUdi0noHhLGNl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731739059; c=relaxed/simple;
	bh=dpPXiqYL44/ZesfBlXXSsLrdC1yn9QX2ULNO1qyTeUU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QBlImwMa9wKNiImipLfAnJz+nEJA+W6ILhlwSqKqDZzUR5S7UpbNSPb2MOf29CeFjEOYV7XCprwYMB7h0+aA4KOUdpm9S6slX6lPkdCJgSV8WsACEa4oaDbVgSDi8q/SkuZQoJ4kEPHFLzvuCZeHHVPSGZ7Ve0YU43LSLvFn6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso4536175ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731739057; x=1732343857;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fk3LLYvVIMDlXis1K7JTYtu6V6565fK4YrzMnuiO6I=;
        b=wJsPwcAsm8aJjWIUYcciVSqs3l++CliAMWUJ9GEUnylR9iZxuSBFYX/uU/V6AMwe86
         uLaCgs2E5ylJtiJTDYMOfY5gBgcmdEF2k1hij8iBYZCXgSOfXEdmaikmB+JR1Gpz6pXd
         MZCr78640CIHqFoFU+5X4OJrNt/1szehu2ek3mzCEBKWz/qfgmW8ZvnAG34Daj8tlAPJ
         Mv0yQN9nJibxh7d5uRfbkYwrJEaYqrhUdPsOaBfc77YCOU55rHCozXQ4l+1TyKzw9QLB
         C3NoG2f65DsiouD7CmRdXtFg7vp/1diA3GxCH9T/Fs7rOZuICvMb1KvDK20Bi2Ncwoi/
         YBQw==
X-Forwarded-Encrypted: i=1; AJvYcCUprczqMXKMI3i/v3wHwF7BWYoRv4QZRMSOPNQuY7oDaQnvqCVaIXqPO6SGRST8TvhmKXM5W4QWabKkF+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2qhYr7Gny954eBKxDF2YdkxqKbgWIYH/WKo1MUZXay6EfjwM
	Tb+jwt9dZVCkhEqcpjq5tJQrorPlBKd6FR0h5IxTQOpzKkLT8xDMgkHlgHyxjGlxSz78opUd5rK
	ZHWeJJtoRxMpnjdeGIL4HLkbrh46AQJ6hJwzIgWcu8JkyC00Ed7nVgFk=
X-Google-Smtp-Source: AGHT+IGxyPG9EdGhSS2ON4E0MF9BtTUhNPnAdiK8c9vDMWwiBTSCILG7QHKfOiQbSRrUU+fUUW99EfK8QJM4CEwmCseXR2tiC7Uu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a74800f3efmr66025265ab.3.1731739057568; Fri, 15 Nov 2024
 22:37:37 -0800 (PST)
Date: Fri, 15 Nov 2024 22:37:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67383db1.050a0220.85a0.000f.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_write_begin_nolock
From: syzbot <syzbot+7c88f40b30ec95353951@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133a335f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=7c88f40b30ec95353951
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2d329b82126/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37a04ca225dd/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f837ce9d9dc/bzImage-2d5404ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c88f40b30ec95353951@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ocfs2/aops.c:1410!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6836 Comm: syz.6.125 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:ocfs2_populate_write_desc fs/ocfs2/aops.c:1410 [inline]
RIP: 0010:ocfs2_write_begin_nolock+0x4da3/0x4ec0 fs/ocfs2/aops.c:1707
Code: e8 92 d7 11 fe 48 89 df e8 da 60 0f 00 e9 b5 fc ff ff e8 80 d7 11 fe e9 ab fc ff ff e8 76 d7 11 fe 90 0f 0b e8 6e d7 11 fe 90 <0f> 0b e8 66 d7 11 fe 90 0f 0b e8 5e d7 11 fe 90 0f 0b e8 56 d7 11
RSP: 0000:ffffc90004466f60 EFLAGS: 00010293
RAX: ffffffff83830242 RBX: 0000000000000002 RCX: ffff88801e743c00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc90004467540 R08: ffffffff8382c05f R09: ffffffff8382c025
R10: 0000000000000006 R11: ffff88801e743c00 R12: 0000000000000000
R13: 1ffff1100ffea802 R14: 0000000000000000 R15: 0000000000000000
FS:  000055559101b500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000034ff8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ocfs2_page_mkwrite fs/ocfs2/mmap.c:93 [inline]
 ocfs2_page_mkwrite+0x752/0xed0 fs/ocfs2/mmap.c:144
 do_page_mkwrite+0x198/0x480 mm/memory.c:3162
 wp_page_shared mm/memory.c:3563 [inline]
 do_wp_page+0x23d3/0x52d0 mm/memory.c:3713
 handle_pte_fault+0x10e3/0x6820 mm/memory.c:5782
 __handle_mm_fault mm/memory.c:5909 [inline]
 handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6077
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fb6b79461d8
Code: fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 c5
RSP: 002b:00007ffc5c043b08 EFLAGS: 00010206
RAX: 0000000020000000 RBX: 0000000000000004 RCX: 006c7274635f6962
RDX: 000000000000000e RSI: 6962752f7665642f RDI: 0000000020000000
RBP: 00007fb6b7b37a80 R08: 00007fb6b7800000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 000000000001ceeb
R13: 00007ffc5c043c10 R14: 0000000000000032 R15: fffffffffffffffe
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_populate_write_desc fs/ocfs2/aops.c:1410 [inline]
RIP: 0010:ocfs2_write_begin_nolock+0x4da3/0x4ec0 fs/ocfs2/aops.c:1707
Code: e8 92 d7 11 fe 48 89 df e8 da 60 0f 00 e9 b5 fc ff ff e8 80 d7 11 fe e9 ab fc ff ff e8 76 d7 11 fe 90 0f 0b e8 6e d7 11 fe 90 <0f> 0b e8 66 d7 11 fe 90 0f 0b e8 5e d7 11 fe 90 0f 0b e8 56 d7 11
RSP: 0000:ffffc90004466f60 EFLAGS: 00010293
RAX: ffffffff83830242 RBX: 0000000000000002 RCX: ffff88801e743c00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc90004467540 R08: ffffffff8382c05f R09: ffffffff8382c025
R10: 0000000000000006 R11: ffff88801e743c00 R12: 0000000000000000
R13: 1ffff1100ffea802 R14: 0000000000000000 R15: 0000000000000000
FS:  000055559101b500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa88b6763b0 CR3: 0000000034ff8000 CR4: 00000000003526f0
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

