Return-Path: <linux-kernel+bounces-288891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12DC954016
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FCCB2148D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F196A8C1;
	Fri, 16 Aug 2024 03:41:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B743EA64
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723779666; cv=none; b=ILFR2zGqt2FDfiLJn99JTVMzw6walw67dZEU/YQFsDfzv7Yzk8hHWOWoAKUnHzoKtrjfhaX3EgC7Z4tiGt22sxRkC4PhvtnsukitZwCedT5LHRxmHA5jlm//GmvHOUNM8BpI+iBPVQWxYa70DC94XdGTS69EnrcjEahxDDKCXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723779666; c=relaxed/simple;
	bh=FXkfsP4e9umFHclIbDF4anr3WcWK2SXh6cRcqKLLLc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pk3JcUi8TeWKtWLFMApXIx78iC1VhYMEpclIaFlJBQrweMKrq/k8j+/Y3ENinJJZTFUhihpe6IiIvYMAyw/kNhRf34dqBZiwcYsNRbDr4EHVFw/uN50+j+5oOoqCtFXUD11qVevN/gAe0ETzXRP2khwU+6oyy6PHO+6pGwyPdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so159421339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723779664; x=1724384464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnJTL45ZCnjfHwhWWstoh+ghFombl+ayGJyswk1bOGU=;
        b=YWC+42QVsyNZp8SNz3BsdaMbHP/WdreFmlh6jXUjyuuWDkvzTICRcfukrFG5OQBkAj
         gaQbA4TnYIecqm/h5hnixkMM7tB2EOFVoaurleqTuiUjbuC48ItvJ1xLoCm6Nn/2EL7T
         f4SKlLgYsWZCu4ap3dhQbmFsMJ6cvxeawoOvLnQVySJXy3DK/pKq6OUxEiGWWXGFs2oH
         1jq4bkaJgDkRb/3wqL5mSmJEpxdd3efnoKuvWaQb+43lx8NuTNl3GUkLNxXNtFf37HEK
         gZNy/X9cwUPajydHLkzLUsyBb8VLtGdMl/ZG5zKSWfQYC1S0VLFUx6gzkRvgSh9XVL9H
         mNCQ==
X-Gm-Message-State: AOJu0Yzu8F7mbAMKXGNRBCBZo0AlcN8htXgTkoCOyPur3Z6PTxWw4z0A
	69QXzPk+uQ6wXj+v4Swu/oZsMXwoI9WiLCPWHY3Uz8niDwWnB/v9EZST11NR4haLRUxLoU5u7MD
	IpVmlEzr1dehh5Ck+s1t9RaKegyaC8rWUpHoFtxBCAmydaXJCGsrwLxQ=
X-Google-Smtp-Source: AGHT+IEAMONRduuigyCuMa60QICQt5OavWqzX4mdty3tDqf5UxDJpzWd+yge7Azr9+/U5OHnQvN/Gdzfz3hz7OBR1uzLSpGpnxe/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831e:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4cce15d71d1mr88701173.2.1723779664050; Thu, 15 Aug 2024
 20:41:04 -0700 (PDT)
Date: Thu, 15 Aug 2024 20:41:04 -0700
In-Reply-To: <20240816032623.3023693-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c104c061fc4ba05@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_iget

(syz.0.15,5600,0):ocfs2_read_locked_inode:538 ERROR: bug expression: !!(fe->i_flags & cpu_to_le32(OCFS2_SYSTEM_FL)) != !!(args->fi_flags & OCFS2_FI_FLAG_SYSFILE)
(syz.0.15,5600,0):ocfs2_read_locked_inode:538 ERROR: Inode 17: system file state is ambiguous
------------[ cut here ]------------
kernel BUG at fs/ocfs2/inode.c:538!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5600 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_read_locked_inode fs/ocfs2/inode.c:535 [inline]
RIP: 0010:ocfs2_iget+0x1c71/0x1cf0 fs/ocfs2/inode.c:159
Code: 00 e8 03 8e 75 fe 4c 8b 84 24 40 01 00 00 4c 89 f7 48 c7 c6 0f be 0b 8e ba 1a 02 00 00 48 c7 c1 20 01 49 8c e8 a0 ca 16 00 90 <0f> 0b e8 88 48 0e fe 90 0f 0b e8 80 48 0e fe 90 0f 0b 90 e9 3d fa
RSP: 0018:ffffc900027bf060 EFLAGS: 00010246
RAX: d9ed16ebbba7d700 RBX: ffffc900027bf140 RCX: d9ed16ebbba7d700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900027bf270 R08: ffffffff8174024c R09: 1ffff1100410519a
R10: dffffc0000000000 R11: ffffed100410519b R12: dffffc0000000000
R13: ffff88803a6c8878 R14: ffffc900027bf160 R15: 1000000000000000
FS:  00007f0c989f86c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ed5d95ed8 CR3: 000000001d86c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_init_global_system_inodes+0xc6/0x730 fs/ocfs2/super.c:437
 ocfs2_initialize_super fs/ocfs2/super.c:2250 [inline]
 ocfs2_fill_super+0x3068/0x5880 fs/ocfs2/super.c:994
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c97b7b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0c989f7e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0c989f7ef0 RCX: 00007f0c97b7b0ba
RDX: 0000000020004480 RSI: 00000000200044c0 RDI: 00007f0c989f7eb0
RBP: 0000000020004480 R08: 00007f0c989f7ef0 R09: 0000000002800400
R10: 0000000002800400 R11: 0000000000000246 R12: 00000000200044c0
R13: 00007f0c989f7eb0 R14: 0000000000004481 R15: 00000000200001c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_read_locked_inode fs/ocfs2/inode.c:535 [inline]
RIP: 0010:ocfs2_iget+0x1c71/0x1cf0 fs/ocfs2/inode.c:159
Code: 00 e8 03 8e 75 fe 4c 8b 84 24 40 01 00 00 4c 89 f7 48 c7 c6 0f be 0b 8e ba 1a 02 00 00 48 c7 c1 20 01 49 8c e8 a0 ca 16 00 90 <0f> 0b e8 88 48 0e fe 90 0f 0b e8 80 48 0e fe 90 0f 0b 90 e9 3d fa
RSP: 0018:ffffc900027bf060 EFLAGS: 00010246
RAX: d9ed16ebbba7d700 RBX: ffffc900027bf140 RCX: d9ed16ebbba7d700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900027bf270 R08: ffffffff8174024c R09: 1ffff1100410519a
R10: dffffc0000000000 R11: ffffed100410519b R12: dffffc0000000000
R13: ffff88803a6c8878 R14: ffffc900027bf160 R15: 1000000000000000
FS:  00007f0c989f86c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ed5d95ed8 CR3: 000000001d86c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         d07b4328 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1340acfd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=5bdd4953bc58c8fbd6eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b3abc5980000


