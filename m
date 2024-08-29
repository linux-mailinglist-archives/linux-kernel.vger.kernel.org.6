Return-Path: <linux-kernel+bounces-306530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41968964025
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515551C217C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AAD18CBF8;
	Thu, 29 Aug 2024 09:30:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22218D622
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923805; cv=none; b=hbuaiCFN0b1vRtWyHP9wKk1lsAWO7xp6nCOPSzPAhrajPj+KVRIw23LW8DiKl8tVuAZooYhNPuL4tFERUMR47TpqZQMhT195u6mt8Hp664hnNyQ2uDMN/SZ4Z5w/Qbe+KaNPl6YLXnWWBClpfpjJAsG+ww+sre01mzdUVblsG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923805; c=relaxed/simple;
	bh=wFlPSLr84jRW/YA7xxq90OoblQzxEOcYLExbXVFb/oo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZmDbsVk31Mvj3CmYQEytimCZmcqgk1BVd20L267mbae9THLp7PbI9f63IQ9NIWF2bMem74vOmO7nf+hDjLjTI3KoMZjwQyh+xc9tFEws92HaJYEK7rtLVoQa47kaNGB7LPeFYXbJ87j9K3a8mIpRbbCK0iIs1Czuy/Sf4wHXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d415635e6so4806915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923802; x=1725528602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZUQlxWI7QHospSTm70vK8FDPxDckUctkcD9GVTJIZI=;
        b=lyRAFwJJ6nTsiyx+bHhGmPmWzhmoyWs5+pmltd7/ZriCNKvj2lraXuJ3h0INrtV6rG
         Sv2vwFdZQkIf+Vg85yShHNdworOAxKf2jxlQyn/I0RC7fb6NTgzk9sVeMXTVMyBmqLB0
         1GZwbBs1pp0Bonn3OdzHWEdlEwEHo7t1DIj85gPeXPPv8DunH8LXwXLxW/mUe9iYYcpf
         wfIWjvUa9xxKgIBBt7FMhaY6mgDMODWzm3N53/nfSFXM8qdv8CJsyQfhV9qKrvboiefR
         f/iqdS9+5jgHv3b1gkoHuTxTV+gMC4EVElAZpTzajIqyiil+qkb0aRFnf9Un1I95zdUV
         AkMQ==
X-Gm-Message-State: AOJu0YyG1B2pO1KGJmsu4EurTfWpN3/0qGYwEkwZLBf+VsvNulnHCbcx
	/DCoSWxjx0azIJoj9PbDl6e8MiogNNAz60MQOdLvBLyDdmnl+NaAKmBmED5nm8kWYjWmmIi27HL
	xaX4B742bysbSk0kFGE7VylNY8Y5rRNeE9y29fbGS88UqpU/NQkuGfUk=
X-Google-Smtp-Source: AGHT+IH9olkpLr1DsfL66IwWeLwn9M+81TAIJ6pf0xHHBt0zO/pQQhkxLpXvfmAwFTrxYZmLvBo4YGQt7usYS/Jbaa4j6ea23+YL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1a:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39f37870cfemr1775295ab.5.1724923802592; Thu, 29 Aug 2024
 02:30:02 -0700 (PDT)
Date: Thu, 29 Aug 2024 02:30:02 -0700
In-Reply-To: <20240829090643.2396576-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084bb2e0620cf1e89@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
From: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in try_merge_map

em: ffff88802539cdc8, blockstart: 18446744073709551613, start: 0, len: 503808, btrfs_get_extent
em: ffff88802539cdc8, blockstart: 18446744073709551613, em refs: 1, add_extent_mapping
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 UID: 0 PID: 6499 Comm: syz.4.24 Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:extent_map_block_start fs/btrfs/extent_map.h:154 [inline]
RIP: 0010:try_merge_map+0x684/0x8e0 fs/btrfs/extent_map.c:387
Code: 19 e8 a0 f9 e1 fd 48 8b 2c 24 eb 0e e8 95 f9 e1 fd 48 8b 2c 24 4c 8b 64 24 10 48 83 c5 28 48 89 e8 48 c1 e8 03 48 89 44 24 20 <42> 80 3c 38 00 74 08 48 89 ef e8 4d 16 46 fe 48 89 6c 24 18 48 8b
RSP: 0018:ffffc90008e8f2c0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffff88802539cdc8 RCX: ffff88802b4e0000
RDX: 0000000000000000 RSI: fffffffffffffffd RDI: fffffffffffffffc
RBP: 0000000000000028 R08: ffffffff83b19139 R09: 1ffff11004a739c3
R10: dffffc0000000000 R11: ffffed1004a739c4 R12: fffffffffffffffd
R13: ffff88802539ce18 R14: 1ffff11004a739c3 R15: dffffc0000000000
FS:  00007f6c742e86c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c742e7f98 CR3: 00000000221cc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 setup_extent_mapping fs/btrfs/extent_map.c:467 [inline]
 add_extent_mapping+0x604/0xa50 fs/btrfs/extent_map.c:500
 btrfs_add_extent_mapping+0x10e/0x7b0 fs/btrfs/extent_map.c:712
 btrfs_get_extent+0x124b/0x1d30 fs/btrfs/inode.c:6962
 btrfs_cont_expand+0x28f/0xcd0 fs/btrfs/inode.c:4923
 btrfs_write_check+0x440/0x590 fs/btrfs/file.c:1181
 btrfs_direct_write+0x2f1/0xb40 fs/btrfs/direct-io.c:818
 btrfs_do_write_iter+0x2a1/0x760 fs/btrfs/file.c:1505
 do_iter_readv_writev+0x60a/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c73579e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6c742e8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f6c73716058 RCX: 00007f6c73579e79
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f6c735e793e R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6c73716058 R15: 00007ffed77574b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:extent_map_block_start fs/btrfs/extent_map.h:154 [inline]
RIP: 0010:try_merge_map+0x684/0x8e0 fs/btrfs/extent_map.c:387
Code: 19 e8 a0 f9 e1 fd 48 8b 2c 24 eb 0e e8 95 f9 e1 fd 48 8b 2c 24 4c 8b 64 24 10 48 83 c5 28 48 89 e8 48 c1 e8 03 48 89 44 24 20 <42> 80 3c 38 00 74 08 48 89 ef e8 4d 16 46 fe 48 89 6c 24 18 48 8b
RSP: 0018:ffffc90008e8f2c0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: ffff88802539cdc8 RCX: ffff88802b4e0000
RDX: 0000000000000000 RSI: fffffffffffffffd RDI: fffffffffffffffc
RBP: 0000000000000028 R08: ffffffff83b19139 R09: 1ffff11004a739c3
R10: dffffc0000000000 R11: ffffed1004a739c4 R12: fffffffffffffffd
R13: ffff88802539ce18 R14: 1ffff11004a739c3 R15: dffffc0000000000
FS:  00007f6c742e86c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c742e7f98 CR3: 00000000221cc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 a0 f9 e1 fd       	call   0xfde1f9a5
   5:	48 8b 2c 24          	mov    (%rsp),%rbp
   9:	eb 0e                	jmp    0x19
   b:	e8 95 f9 e1 fd       	call   0xfde1f9a5
  10:	48 8b 2c 24          	mov    (%rsp),%rbp
  14:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
  19:	48 83 c5 28          	add    $0x28,%rbp
  1d:	48 89 e8             	mov    %rbp,%rax
  20:	48 c1 e8 03          	shr    $0x3,%rax
  24:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
* 29:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 4d 16 46 fe       	call   0xfe461685
  38:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b


Tested on:

commit:         d5d547aa Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1162fc35980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=ba3c0273042a898c230e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1166fa0b980000


