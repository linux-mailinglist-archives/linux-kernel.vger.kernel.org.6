Return-Path: <linux-kernel+bounces-390539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3C9B7B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DB71F235D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097119D06A;
	Thu, 31 Oct 2024 12:47:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF519CC07
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378828; cv=none; b=nRieRhIICTli3muwDAtZyERyj/gzH+qisvU20w+mlXXeXbyhSfh52MBbJ6PzSlRoI8qWK7gXbpgRyQMZGY1rpLpiLbgp5uEcAgXpUQ8ShrR9VapMVgKCRpHau8hW8CW4H6yVPJsUOP0YwZk2af1VrKtziyiubVi49R4FdkF1eVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378828; c=relaxed/simple;
	bh=Ry5VGJgFHxCPQdMAUJoLJta72VRHxfLPusHWRGaEHsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jv8cFOpV+3+UEvblvraIX2H0V83eDgfbt/PP9z3wrOtEvWHQ0+4QB6JfrMKPR25HZhnc/l0Hm2QDBjAEMajJiAvvnwxhl7XQcy9EjmbdY4V85hvfvbbA5XsOwSeSLdzDazkss/6MOOn9FbTvrPI8j4EQYqde9DWVc7VEw1sW3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e86fb603so9094605ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378825; x=1730983625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEVObIYhi8t3nlk037PM9Ug5uDA/Tp6yvEWCBaSJtFk=;
        b=RRFWraUCep36xZN18EnuPMly+a0zSIbm9Y28lReC8FLcfEVB6BjUDKkUmNf26EubKx
         mBFovvs+F3E8wMuouwbFS8y0B7OFdjYrNI2X4riALGAFIoJcKdpPJnsMeBx6Pkv8eK/N
         wYX53Ebx48U8drvVxgs30m4HvZhsKQJIkLMx3uDclEq/GAXXD8n/EqTbQSooNqlOYztF
         Jytv7j9TueyHj6WzSGpeS1rR3uRebdtCm1qkwpt96ASr5W98mF9BT414jAhvypiotacC
         w0AWhEsLU6Rtp6cXsSe6PPfhEBPIspMFO5CGVDWHkdWvp1RbbHEqR1PeCJo5+8aWg5ZB
         ZEkA==
X-Forwarded-Encrypted: i=1; AJvYcCXIHXeNFzYcwqf7wkRHWwcOBWB6vyWFXLO2HlN/8UGcaaR12TWyubvhMt3UoVZWLdx4Bl7o/gENX9mzAv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeG0pue+vSWpA/rkoJ7mV72G6JmJbacF2UQQ64Cr29n1KdX9MY
	xQ3JqleKcUyqNMDPTCaGf1V57EKckHXZ/UB3EvBiApehgv8O7Icmy3FlPjWoCiZfltYUD3v57sn
	4jP36FE/YduHp7w4d3Hie7tIAgfnn3sqnpUNOtpXf8AONEQVQm6jsp+Q=
X-Google-Smtp-Source: AGHT+IF3Oh4qbkJIVJUnHXkeN0aUd9MV/A52CKQ5lv4/nhJu+Kkm88V1bxr3cuOdUl9rl6eLfYBRuKxkugJUpDKrhCQgT/iwDA1F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:3a3:4391:24e9 with SMTP id
 e9e14a558f8ab-3a4ed2dfafdmr203048695ab.20.1730378825492; Thu, 31 Oct 2024
 05:47:05 -0700 (PDT)
Date: Thu, 31 Oct 2024 05:47:05 -0700
In-Reply-To: <tencent_A26C497463A2045397695767E6D4B36EC305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67237c49.050a0220.3c8d68.07bf.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in touch_buffer
From: syzbot <syzbot+9982fb8d18eba905abe2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in touch_buffer

bh: ffff88801fcf9910, folio size: 4096, folio nr pages: 1, __nilfs_get_folio_block
bh: ffff88801fcf9910, blk: 3, first blk: 0, blkbits: 10, idx: 0, __nilfs_get_folio_block
after get nth bh: ffff88801fd4c9f8, __nilfs_get_folio_block
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 UID: 0 PID: 6143 Comm: syz.0.57 Not tainted 6.12.0-rc5-syzkaller-g0fc810ae3ae1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:perf_trace_block_buffer+0x293/0x490 include/trace/events/block.h:24
Code: 24 18 48 8d 58 30 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 8b 7d 62 fd 4c 8b 3b 49 83 c7 34 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 6c 01 00 00 45 8b 3f 49 8d 5c 24 08 48
RSP: 0018:ffffc9000d2d7400 EFLAGS: 00010207
RAX: 0000000000000006 RBX: ffff88801fd4ca28 RCX: ffff8880363e2440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801fc37928
RBP: ffffc9000d2d74f0 R08: ffffffff819e732b R09: 1ffffffff203a0bd
R10: dffffc0000000000 R11: fffffbfff203a0be R12: ffffe8ffffc88e78
R13: dffffc0000000000 R14: ffff88801fc378a0 R15: 0000000000000034
FS:  00007f849423c6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f45ffff CR3: 000000005600e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_block_touch_buffer include/trace/events/block.h:54 [inline]
 touch_buffer+0x1d5/0x240 fs/buffer.c:64
 __nilfs_get_folio_block fs/nilfs2/page.c:51 [inline]
 nilfs_grab_buffer+0x56b/0x8d0 fs/nilfs2/page.c:70
 nilfs_mdt_submit_block+0xdc/0x890 fs/nilfs2/mdt.c:121
 nilfs_mdt_read_block+0x150/0x430 fs/nilfs2/mdt.c:186
 nilfs_mdt_get_block+0x127/0xb70 fs/nilfs2/mdt.c:251
 nilfs_palloc_get_block+0x181/0x2a0 fs/nilfs2/alloc.c:217
 nilfs_palloc_get_entry_block+0x8e/0xb0 fs/nilfs2/alloc.c:319
 nilfs_ifile_get_inode_block+0xed/0x180 fs/nilfs2/ifile.c:141
 __nilfs_read_inode fs/nilfs2/inode.c:476 [inline]
 nilfs_iget+0x240/0x810 fs/nilfs2/inode.c:581
 nilfs_get_root_dentry+0x28/0x230 fs/nilfs2/super.c:909
 nilfs_fill_super+0x50b/0x720 fs/nilfs2/super.c:1090
 nilfs_get_tree+0x4f9/0x920 fs/nilfs2/super.c:1220
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f849337feba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f849423be68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f849423bef0 RCX: 00007f849337feba
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007f849423beb0
RBP: 0000000020000000 R08: 00007f849423bef0 R09: 0000000003200c00
R10: 0000000003200c00 R11: 0000000000000246 R12: 0000000020000040
R13: 00007f849423beb0 R14: 0000000000000aa7 R15: 0000000020001bc0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:perf_trace_block_buffer+0x293/0x490 include/trace/events/block.h:24
Code: 24 18 48 8d 58 30 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 8b 7d 62 fd 4c 8b 3b 49 83 c7 34 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 6c 01 00 00 45 8b 3f 49 8d 5c 24 08 48
RSP: 0018:ffffc9000d2d7400 EFLAGS: 00010207
RAX: 0000000000000006 RBX: ffff88801fd4ca28 RCX: ffff8880363e2440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801fc37928
RBP: ffffc9000d2d74f0 R08: ffffffff819e732b R09: 1ffffffff203a0bd
R10: dffffc0000000000 R11: fffffbfff203a0be R12: ffffe8ffffc88e78
R13: dffffc0000000000 R14: ffff88801fc378a0 R15: 0000000000000034
FS:  00007f849423c6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f45ffff CR3: 000000005600e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	24 18                	and    $0x18,%al
   2:	48 8d 58 30          	lea    0x30(%rax),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 8b 7d 62 fd       	call   0xfd627da7
  1c:	4c 8b 3b             	mov    (%rbx),%r15
  1f:	49 83 c7 34          	add    $0x34,%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 6c 01 00 00    	jne    0x1a3
  37:	45 8b 3f             	mov    (%r15),%r15d
  3a:	49 8d 5c 24 08       	lea    0x8(%r12),%rbx
  3f:	48                   	rex.W


Tested on:

commit:         0fc810ae x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106b655f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=9982fb8d18eba905abe2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e92630580000


