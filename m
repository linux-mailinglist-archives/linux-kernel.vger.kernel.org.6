Return-Path: <linux-kernel+bounces-281096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A794D307
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9577D1C20CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EDA198833;
	Fri,  9 Aug 2024 15:13:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FC197A93
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216383; cv=none; b=ilvpZIFI/GctgH6sLn6D2C+FcqbIyv5FT9B3WLH5IS1XyZD9lSyDqzN7rEt228kmCs3atRLBu6OEb1rzleeVc4MJvzjwKuttAAvtnRzn7ggfZHFj0ZbRztbcRJzXBIQPvIgj5jvTdQKMkwYp+v+cBcyRjkwa0mJpA8LyaaHxJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216383; c=relaxed/simple;
	bh=F0Hqy5bLEUB9lQYvauCs8H3epsbtuVy2eCZPEtRe6CE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pFIP3Ok355SdOezOztsslHqYmnUnDZDtlr98fs/ubYn8Y9tQP0HTvrWwIlODGI18kgcWj3vkGavCtwC/pIa+k9Q9iyQNBKpOHDV4sGeLFqMiYJWpd2DAoZskxFIS06VOAfnUmANi/S5swQwvsxETPCO5OQ8qDP+Ll5o0/vKtGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3962d4671c7so25340095ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216381; x=1723821181;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i28ivjeUQy0ScsjG3wn8OTGUIecJVem+Lw+UrMEzwd0=;
        b=MN0KFGesFO3rYh0/eQuRebet2Ui0AH6T7k+4Y7Fb4zClaazCiedffDZ1DRYUHUvvLv
         jmQzH5+5RhJwHY6I9a2HBmxJhRyZZXo3SkiLK1LuXqswSaRiqAiWaeGvhaSDmVUqLD7M
         HWm+S6Dn7xFhS4ojRqO3Q6YZFdI3MCsvjXtL3CC9q6t5F9XtTJx9i+FKExlSM7dDgfDF
         EyGMy4n/UonPw7j8Sw+z8v4eQeCqGeY6tptimBjbvVxSkG905r2YUh7TokWndh3ROp3c
         eQB5TxAtsAsxtnIj9dmLShlvhtpLisipspjhUmTzRUnC6A15LEBGes4b5EQerkBHA5xP
         9uAA==
X-Forwarded-Encrypted: i=1; AJvYcCV087mBwvo1+uBAJh7bgmO/ffeLhcP93zSXpxeGBrp6FBFCVhu/6gl8siDsCm0tj9HXffQRYq7XdnvGNtY9nB6hFLjqQAFc2e+5lANY
X-Gm-Message-State: AOJu0YwDWGeSep72wrhdXXuT0itMfhxXNPv1vEDF3OcXriBac8DDYepU
	CwlKNCrHuXHkJX72MWmCtMgVHjG8aUkVKvHM9dfN6wYanKsRGZEOLZczi9+yq4b0DeC3seeG7mW
	R1aNejnbGmh1LSpASNMrhwJPMo/RrLDRJHUPBG6JsIbhoQUFelpU88oQ=
X-Google-Smtp-Source: AGHT+IENOyFGjai01pGiSwSevzV0oqtTNbdSUaaqMlNj2OGawfbbrSRYUfsmUbBgm164rFHUukJXu5rRo1O0ap68xXCpCshMNnXR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39b6c119870mr1453995ab.0.1723216381479; Fri, 09 Aug 2024
 08:13:01 -0700 (PDT)
Date: Fri, 09 Aug 2024 08:13:01 -0700
In-Reply-To: <tencent_156C4BC27437768B67523DE3362496023609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a1f66061f41947d@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: 1901337, folio: ffffea0000cd8b00, netfs_writepages
ino: 1901337, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 1 PID: 325 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 1 UID: 0 PID: 325 Comm: kworker/u32:5 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-74)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 20 9b 8e 8b e8 c5 49 0d fe 90 <0f> 0b 90 90 eb 80 e8 a9 2a a8 fe e9 6f ff ff ff e8 0f 2a a8 fe e9
RSP: 0018:ffffc90003397478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888044443380 RCX: ffffffff814cc379
RDX: ffff88801e4d8000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888044443380
R13: ffffc90003397840 R14: ffff888023584c58 R15: ffff8880235849c0
FS:  0000000000000000(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000001f6c6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x812/0x1020 fs/netfs/write_issue.c:539
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13b6115d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1095dccb980000


