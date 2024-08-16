Return-Path: <linux-kernel+bounces-289272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4C095440A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B4D1C21FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E7713A89A;
	Fri, 16 Aug 2024 08:23:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147451D69E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796586; cv=none; b=AO3SIAVjbBUIKjeJ43bTQTUtxseepK6rZ5m0Q1PFH+q6HNzlNeoyOlQ3bQ15D5qmyUHsN1LM6nhDchs2QlmLRKTukPuA9ujxi2gRYhnPGJHLNQX8zGD0nXschNgJb6PtJGk6Ibx+MNAGQqh1ar8OJdCx0ZSHSiSw5ZoIZZwrg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796586; c=relaxed/simple;
	bh=zX8o4fAmOi91htoqHJU0TGVa9WM8+3TbYd2O9StBJNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K1SSUrQ8/a4ae8O3eD7213nRV27bAfTe/v9atqzHsOIPEZ7aib4MXXlLaApJxGbkyNPnmkZ7/tVFfe1WvrMJbm8xg1XmQSnAq1J3hFsMoX0VzwM9tseUiS1CMeVOTvY2uyahNRZEgthbw+dPGEbaRnbdTr0gj8EIxE/E/dokluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b3b5858e6so16160555ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796584; x=1724401384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUvryhNoIJAWl86PsTdJgEXusgSnDkCrEJGDICSPLyc=;
        b=RFiTxlvWksxu7IUKxpy5ZiWz/kggIfTSx6arvydR14siFoTVhVABea2fPv+iow5Lu0
         GlxU50ZM2d4j/XJhbc4a8cyUcIpB6/N9HkVqxOo5UItsfaOdj/03yAAc7xk3ntrjmT8i
         r8vtbVnsOPub3FzyhC5KOumBcm7CRLC38Xt+NOmbFldWzUB8zd86X0ZplqijBDWn7lcU
         16YvG5KrLzgmwjFlMeQobJmSwB5mR/PRqZiYIvm9TSwa8ospIfC7gONVXljGpvC4vxcu
         NmOz/ZrWQ9oND1ebDFPN0wX/6/7qxfJ4HjHA63lAY2w6O+oElrX0RbL95SmWGeHBC497
         XEpQ==
X-Gm-Message-State: AOJu0YxhIgOxVAYf6PmV9PYjzFmXD18B6/+4+SodN3hn8gYLXvOIV881
	brDBMCjXJ8GIMJ9A4Qa7ExbeGv1ArulmqlX4OL461k0TEEFNbmOveg3Zt8lj097bLpk94+TSuIA
	MQSKz5k0PPj4buvPPaYdHb/QEjsV7o/SagP4mPIBvfc7iEqqCB4eHaCg=
X-Google-Smtp-Source: AGHT+IFz6KIIzZ06+qW9CKJYBRjvZy695mWnU7fETbHZoNspL6Q0ddgqTZT9QnnF0YeEbn9vBWKiL+gebrHydu2tNjNwNzbay2Ag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39d26d95de3mr2367405ab.6.1723796584167; Fri, 16 Aug 2024
 01:23:04 -0700 (PDT)
Date: Fri, 16 Aug 2024 01:23:04 -0700
In-Reply-To: <20240816080852.2626448-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000108fea061fc8ab6d@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_iget

(syz.0.15,5573,0):ocfs2_read_locked_inode:536 ERROR: bug expression: !!(fe->i_flags & cpu_to_le32(OCFS2_SYSTEM_FL)) != !!(args->fi_flags & OCFS2_FI_FLAG_SYSFILE)
(syz.0.15,5573,0):ocfs2_read_locked_inode:536 ERROR: Inode 17: system file state is ambiguous
------------[ cut here ]------------
kernel BUG at fs/ocfs2/inode.c:536!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5573 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_read_locked_inode fs/ocfs2/inode.c:533 [inline]
RIP: 0010:ocfs2_iget+0x202b/0x2120 fs/ocfs2/inode.c:159
Code: 00 e8 b9 84 75 fe 4c 8b 84 24 c0 01 00 00 4c 89 f7 48 c7 c6 78 bf 0b 8e ba 18 02 00 00 48 c7 c1 00 00 49 8c e8 16 c9 16 00 90 <0f> 0b e8 ee 3d 0e fe 90 0f 0b e8 e6 3d 0e fe 31 db 65 ff 0d 35 8a
RSP: 0018:ffffc9000280efe0 EFLAGS: 00010246
RAX: 0dfa14ca5ec41c00 RBX: ffffc9000280f140 RCX: 0dfa14ca5ec41c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000280f270 R08: ffffffff817402fc R09: 1ffff92000501d70
R10: dffffc0000000000 R11: fffff52000501d71 R12: ffff88804cc18200
R13: dffffc0000000000 R14: ffffc9000280f160 R15: 1000000000000000
FS:  00007ff56b8ba6c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f99dd1b4ba8 CR3: 000000003671e000 CR4: 0000000000350ef0
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
RIP: 0033:0x7ff56ab7b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff56b8b9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ff56b8b9ef0 RCX: 00007ff56ab7b0ba
RDX: 0000000020004480 RSI: 00000000200044c0 RDI: 00007ff56b8b9eb0
RBP: 0000000020004480 R08: 00007ff56b8b9ef0 R09: 0000000002800400
R10: 0000000002800400 R11: 0000000000000246 R12: 00000000200044c0
R13: 00007ff56b8b9eb0 R14: 0000000000004481 R15: 00000000200001c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_read_locked_inode fs/ocfs2/inode.c:533 [inline]
RIP: 0010:ocfs2_iget+0x202b/0x2120 fs/ocfs2/inode.c:159
Code: 00 e8 b9 84 75 fe 4c 8b 84 24 c0 01 00 00 4c 89 f7 48 c7 c6 78 bf 0b 8e ba 18 02 00 00 48 c7 c1 00 00 49 8c e8 16 c9 16 00 90 <0f> 0b e8 ee 3d 0e fe 90 0f 0b e8 e6 3d 0e fe 31 db 65 ff 0d 35 8a
RSP: 0018:ffffc9000280efe0 EFLAGS: 00010246
RAX: 0dfa14ca5ec41c00 RBX: ffffc9000280f140 RCX: 0dfa14ca5ec41c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000280f270 R08: ffffffff817402fc R09: 1ffff92000501d70
R10: dffffc0000000000 R11: fffff52000501d71 R12: ffff88804cc18200
R13: dffffc0000000000 R14: ffffc9000280f160 R15: 1000000000000000
FS:  00007ff56b8ba6c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005616292ca000 CR3: 000000003671e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         d7a5aa4b Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15510ad5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=5bdd4953bc58c8fbd6eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

