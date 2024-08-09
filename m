Return-Path: <linux-kernel+bounces-280457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335DF94CADF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8BD282303
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3C16C6B6;
	Fri,  9 Aug 2024 07:01:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812302905
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186863; cv=none; b=vD3hnMjROaB7aL+dqitQgbES+reaKiMnhpWcT9nETTkCjw8tnadNyQFwrsSfya0pST713xUVbf8dCoIjc+Rc/X+y4gYDvVDWdreQc9oaCcloWad/c+uCo8GRhV8Lj3CIN+4zoOfm64V+hzF5VRSW6krd7LaQkz4ha7kxlyajq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186863; c=relaxed/simple;
	bh=N59uvdCn2JoZywFkgtjZrw+/JfuqDjS53661f2CBZHM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lTa0veqqNzEr7eHLWE29ReostnfoRy7l4LUmxGggCAim1lngtMjlBukgYoEza1WOjO9X/rQFeibjm3cU/3+zIZMXecAG1TjOWWIz50JD9BK/M0oUS2nL7hCRG2sErWHZu7V8CTnJzOlbnNvOmgGpiktfJH58fcE1IF2ZljU50y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f87561de0so208240039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723186861; x=1723791661;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tES2e3HgSjzS2QlQnXYSvbvcws1yZH6b3rXbTyhOaY4=;
        b=EDCimEYWGdmx8ALGFs2hfXFtsdasmRuGCHchfpjHXI/2Ov78ka2z36G+bN9EcUL+W6
         /lPPoCVBNs5AShLFBj66gQ5frBOxs3EDqy/ZEza+ie/b1ZsCY3NRJ1IArJ3mIUnhpN+l
         hFGUffhNKnwbyeaReO5CnzS6obawzQLnGTmFwe+FE9yO9oWlhrmjwAnivIz5IVoHXQ55
         gNtpzfNWw4LEq3/5Pg7/9HZ7vlqx3x6Qdo9nkpbTjTS01Q4SMBRIKdDjXjY4MnxNjj96
         V6xVQoYInsimYPBzLEFHL1kZimmJIxWSIWB0O9ZesbxafRiQuXBQEepYJVMfEZkhRPGK
         WT6w==
X-Gm-Message-State: AOJu0Yx6SHOvpqQevg/Fb0JE3uDbrqUzZPwUwIr/9fIw4mnU65gyJx0X
	TA98nrhafRrcVRuATwUOlcTvKQRn3/CRgf4WDITC0ZeM2rgpXWJeECvYRu0kW1jKXnOtd0/frpt
	V9CVvLdhUc4xgz/BFUKjcgNJughyk9d+8Sq1XUENcmib7VFQAuEjCJWM=
X-Google-Smtp-Source: AGHT+IHzi8YztasgRPIBKYGhw+aX1JM8OH0L7YqVqma/wPvxyN/TOjz167AXTsZwadiCQuwctb0y71+xKRsH47vuJFVgiDh1LEUt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8325:b0:4c8:d4a7:898d with SMTP id
 8926c6da1cb9f-4ca6eb9f18emr15918173.0.1723186861554; Fri, 09 Aug 2024
 00:01:01 -0700 (PDT)
Date: Fri, 09 Aug 2024 00:01:01 -0700
In-Reply-To: <20240809064122.1490034-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3d094061f3ab42f@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901336
WARNING: CPU: 0 PID: 1204 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 0 PID: 1204 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 0 UID: 0 PID: 1204 Comm: kworker/u32:9 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-21)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 51 4a 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 32 2b a8 fe e9 51 ff ff ff e8 98 2a
RSP: 0018:ffffc90005dff480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803274e090 RCX: ffffffff814cc379
RDX: ffff8880232cc880 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888024d0cd48
R13: dffffc0000000000 R14: ffffc90005dff840 R15: ffff888024d0cf98
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000023c86000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10c34d11980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138833bd980000


