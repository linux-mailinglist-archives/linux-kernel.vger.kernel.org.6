Return-Path: <linux-kernel+bounces-276086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2D948E36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195DB1F22806
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7A1C3F3B;
	Tue,  6 Aug 2024 11:56:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306411C233C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945365; cv=none; b=HCd4/tYG+Lhw/sZ0blwE+Wwro2aDokneRTejT8SRECbor66x+Fh75fLGXZpXG809dEqe5A9Ap6IWH9qxWHzaN82WCV/+BmUT19EhmhS9Em9nsFZrzwXsq1iGTnnpWf1Nu1BCkP9eGnzaIg5fWG8aK/Grk718W0b0q9rzZvWHqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945365; c=relaxed/simple;
	bh=NNtBbZ1/zNAnc0GfMMKdAMZ2kgpJuN01sUWeCCVSBmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RyOo145rDcb+ZT2zMkwgJ7SaZQvfQsFekfSR/gI5HDx1Hd99pcnufOf3m/R7bEjjEOdhs6DTyIeBqSetlbVvHVtfCPq22IZ60/SwCsz/ZcqDqe32t+Vm335Fyf66uYzesOi/WNbxVvAJge6vCADYpBVooAr5sTFMDc2R4kz7BgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39915b8e08dso7295055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945363; x=1723550163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OVE/O9AGW84ON/7C1wS6kl9XbGNoZzh0MiwSWvC/IU=;
        b=pph0Tiq+9nkPqyAi1LpEv+6YEBi3EtQlxPGatD7z6k4pRLcz6yH3jELgvbFquGicEV
         TxuE1gqTUE7PjTsUBx7/SV6c97mg2p/PrvZz6Iehl3YaTLWoLz8cLHUcpUVZDAHlPDU3
         CM1UOSzb6yyJhJZ8yRWUik2th7flu+ftBZCi5LFxJzLCg5XGMizXohKeaj6q19SdbQIk
         R3O9u812TylLnr6hZCIKJVaHo1y22dvr0d63VCfraXexzM1XDdqi95I++vmelR0xkVZO
         z01gTFK1uqPGLkPJIsoe0OQcKkIRBZmWYH38GJu/fSkROKZ2N7j/7kK9TIX1b9FDAjAY
         qDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtEqoz5Jh5duI9sxQv6PcJSq+dTaWLDYgw1Ab3YgdoxHwduJOf+9/fmOUUreTao3Ig9FPzljBIXgk30WeJzHgNUtj9C7oxsh/gyI5/
X-Gm-Message-State: AOJu0YxSl5I5DL4/oG9Vihf+FjUp5JqQ/mDz6ZK8xzPTjoqhdpR3Drt7
	RyHL+WhIs/I2mMFIdH7l7AH6LR8OZy8z1VlI7owucD7iCmEGvweQUg2RlPh6K3rYBes0ULWK9h5
	jA7REvP77KdpjYf7xg77z04eJPuWS9lS133cog7rzXWbyBhlrkkMAviU=
X-Google-Smtp-Source: AGHT+IFfXFuYXVxoT7uxbb1sHutcbrFkZv8sMO86gV5wXMhcJq5/Xvtc/GBO4WCioWE58vchExcyHK5M/O3zwKY4Hlcan9JHcWuJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39b1fc8baecmr11825975ab.6.1722945363236; Tue, 06 Aug 2024
 04:56:03 -0700 (PDT)
Date: Tue, 06 Aug 2024 04:56:03 -0700
In-Reply-To: <tencent_1E67D386C552C806488981AEDBAEDF8CAD06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057eae1061f027aec@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

WARNING: CPU: 2 PID: 64 at fs/9p/vfs_addr.c:43 v9fs_begin_writeback+0x25f/0x2c0 fs/9p/vfs_addr.c:43
Modules linked in:
CPU: 2 UID: 0 PID: 64 Comm: kworker/u32:3 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-1)
RIP: 0010:v9fs_begin_writeback+0x25f/0x2c0 fs/9p/vfs_addr.c:43
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 6a 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 f2 4b 0d fe 90 <0f> 0b 90 90 eb 80 e8 e6 2b a8 fe e9 d1 fd ff ff e8 cc 2c a8 fe e9
RSP: 0018:ffffc90000d17480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888046068670 RCX: ffffffff814cc379
RDX: ffff888016f42440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000004
R13: dffffc0000000000 R14: ffffc90000d17840 R15: ffff8880269d0298
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555755375c8 CR3: 000000002c17a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x656/0xde0 fs/netfs/write_issue.c:534
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x611/0x1150 fs/fs-writeback.c:1947
 wb_writeback+0x199/0xb50 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x28d/0xf40 fs/fs-writeback.c:2314
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=173a319d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125cb8d3980000


