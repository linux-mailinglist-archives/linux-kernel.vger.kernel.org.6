Return-Path: <linux-kernel+bounces-280408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8ED94CA1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACA9287DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0916CD17;
	Fri,  9 Aug 2024 06:09:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337B17C98
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183745; cv=none; b=HAYZnx9iWr8oI43uE2RJyaH2Y7AA+4MlPuAUxzRn/WYSoDYHLs3AMx1mf8PtsP2AES9oeN7XyIBiBiZEzknGXY+qabCbxgqeEQJa9T0atgoFNeGHAF704xgwBks0XUfKEfLKs0758d6RimnrHUtTkHF/aTb21Yy7BBnbs58eYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183745; c=relaxed/simple;
	bh=LPBqF1wcWx2ubMCdIBSIokl4RdBxT/tbHgzW3LbuRAs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k5H+pueXVCbUA0ISCZ8OT5vyZtI77cxIaygCW+eZzdlOTjaDqLNp4e6jWv7GHdZ5Hw/GcpCqxRyGHTfSYcc7kaOYlqBnJjMmmFNLGFH5VCtsi9VVnGianZfNzlFyNxgEoBQC4niFMwSBDbYl5mgWj9kSF4ST9yG+A/7B5Q0My6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8c78cc66so218134839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 23:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723183742; x=1723788542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auPRQqPB/SSOgoeSmIgFYUNjROoHTkFvrvBWVbEj5Wo=;
        b=um0uQXkhMNAEnsex1SP263fIln1+b697u7M1eME9KUnO58kuZWMC8bUx5nmT05eYmM
         FyyooRNRooYFJ3SWDWqz2wHORP+Gapbe9e/MHEA0cvSe/+HsP+oE/qJiphYND+ncggGM
         NTaAlgtFL/PQu/Hr8cwJoZZC3OsihTAnJKmUd5Sj//J9FIn8zCVIcZ3yFxnAnAlt7igS
         J9Ou/kjAEkbijdb18GCkj1OqpLFrblRr9g7/Wgrs8jvTIXhVMALJ9A0XBjvvFo7/i1Pv
         u09Ir9EVKc5Xj3CCa7blcVrcqv+obx9Zf/AiiZaotboNloUDz4mWKbv7CXcyjAw3zl0J
         k7cQ==
X-Gm-Message-State: AOJu0YySKi2acGHf5lCVaoaauFKD638yjuWJ6ztyIdqSTUAwBaZMGrlk
	1oasJ/sjGG61ranZ+zhB2CdA2Cbzf4ZIHz7RrAiWrud0KhvI+cAj0Nk/UcS9zBWv/4VZVJbmgnw
	SabAgJb/HVjijBXhERLokXH+QIQN3FiaCyDBAOokj1cork+7gAfNhJH4=
X-Google-Smtp-Source: AGHT+IHI6hfLPgdBNPaOg8PP+l7/sZifbBHZUwLpRcN6k38HM9PLstL56vxr4s5bDmKPXRytrQySR9xTh11BgQMLh36tgpeECCFa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12c7:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4ca6eda5917mr16402173.4.1723183742651; Thu, 08 Aug 2024
 23:09:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 23:09:02 -0700
In-Reply-To: <20240809054850.762409-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd284f061f39facb@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901335
WARNING: CPU: 1 PID: 1107 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 1 PID: 1107 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 1 UID: 0 PID: 1107 Comm: kworker/u32:7 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-39)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 51 4a 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 32 2b a8 fe e9 51 ff ff ff e8 98 2a
RSP: 0018:ffffc90005d6f480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888032a2ad10 RCX: ffffffff814cc379
RDX: ffff888022d94880 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888040c47448
R13: dffffc0000000000 R14: ffffc90005d6f840 R15: ffff888040c47698
FS:  0000000000000000(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f18749020c0 CR3: 000000000db7c000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17004ff9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17406ff1980000


