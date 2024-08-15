Return-Path: <linux-kernel+bounces-287456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D96F9527FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D42284E89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E37D2A1C5;
	Thu, 15 Aug 2024 02:50:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24923776
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690206; cv=none; b=h8+8ULwhUJm+079pREeRH/a4RbVEQCqI/qFbT3yBvWO1dOExPs7wPA72oGqakc+yXSQCk4PUftlGYK0fM4poyQTlGyE/td8x+GlF6gAOud2FeHKFjmx2YTaMcuWHUgwAmricJqmHv0STI5yvq3UczQXHEtN0jnlfAtpMMUApzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690206; c=relaxed/simple;
	bh=5ojiZNxp0SLM4jCbbDjSeQk9FqD8P9qiojQ96MzOvyk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DO1KG81c36qNmdm/1TwX8nToXKWdw9GWseGdI2qQPO6SGnbI+JEpeNrolIYP+2o/ythlH4CbII7eFXUvH7AMjM11DmLfz8gAjIV7bLC/Eq7cd0p0VTS+ywAU9hRBPufnzsFC+a+SxSi5ZyWzYqxazY/xO8pcFNDqY8n8NEM1F/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fc0896188so61268639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723690203; x=1724295003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsldy06EpaXxkZDFhTtnezLRlK3jGbsh82cqbXZWLkA=;
        b=Hk2nOSfLvj7b1R/l3lfZvaru18BXS7iDuQRtTpX6da3ssQdrRYYd9JgNKx4lfgqrKG
         PAAT1Afy7hTlLE0Cc4fJgtxjxG4cz6DZ0AsLzpOyVIYefTXPrjdIInnrd2tg2tBaS/NR
         Lnkks7ukjZd0i3Dh3zwq3a/fh22DwwC6g9jdSucz60HAEjMFKDkRu6AGPbXwtCV2x2nd
         ACzQWyeTQhYjpoZ74z13RGa8H/hyBtp83B8JFGozxQXUgfKJ7SNoO1bALZZ5kBAALQVy
         Br142XCHsOLLHmFfLBq+NCBdYoT/8loy3/sVpIBHl4hC/wxDwylEBBb8IRjwtergS7oH
         JgUw==
X-Gm-Message-State: AOJu0YyR3TBnxJXcTPmsjzcrxh3rN4RFPwFpKEpPyUOvdw20LxP1oIV4
	fOPUDedDsBCB+lEgE7nk1T/s0b3pR0BB7ZL9ZvHMVfUFnuilgQys0c00o8DKc8AOQqp8P98mhBN
	MRkFUVNvMYR4+JuZP5MzwyPzDirCakRHLVkArnbA5DP2G8i8f6A6ShkA=
X-Google-Smtp-Source: AGHT+IE5Y0wAQYLGOu9ca9ewwoLoc5ceEtd45u3invqOlOxzzva5m0+b7FiWkSAGHUtcGg052wE6pCKozZ8E4CxhPyapn71met3r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12c9:b0:4c0:896c:515d with SMTP id
 8926c6da1cb9f-4cab0a3165emr212569173.5.1723690203424; Wed, 14 Aug 2024
 19:50:03 -0700 (PDT)
Date: Wed, 14 Aug 2024 19:50:03 -0700
In-Reply-To: <20240815023135.340669-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004735cd061fafe691@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901338
WARNING: CPU: 0 PID: 1105 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 0 PID: 1105 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 0 UID: 0 PID: 1105 Comm: kworker/u32:6 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-29)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 51 4a 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 32 2b a8 fe e9 51 ff ff ff e8 98 2a
RSP: 0018:ffffc90005aef480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88804547d3b0 RCX: ffffffff814cc379
RDX: ffff888022d92440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b172dc8
R13: dffffc0000000000 R14: ffffc90005aef840 R15: ffff88802b173018
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff8ce29b68 CR3: 000000001bb1c000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10fc0ad5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11af3bd9980000


