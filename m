Return-Path: <linux-kernel+bounces-280534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025594CBD0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6EF1F21B42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425216CD2E;
	Fri,  9 Aug 2024 08:01:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F14C8D1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190466; cv=none; b=Gz7z8bYeCk63KtOncvpEDg93RWBgGUBiCr9+JvXLdU7psriYwubUHvHLmjusH+eqr4rfNzyPlOEbWg9Pwmj5gWd9hJaLY9ggeWeWu7PNPvq5FNRJ/J/0ik+hjDvymE/LpqKaG7hl/dYilpy1ZJfNJMPlJUIHLvF3ycnmhvpaEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190466; c=relaxed/simple;
	bh=B/1qyI/bwZI8VyyT62pZlbsgCiUmMIEJVoPDBAE8ttM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lYUQesLMUYwhw1OsAynoR/uZgQqozMQImmqP68L32VQKuevk2LVAgcyLtlW97WCStgPvNSO2UtNXtJQ6LV4YFd+WnwB180cjO9yoHZAtXHtp82AQDs59R42tmaDORqLB2IZ7rIncmXCpM4T5lYBaX8eIC5ca4kejP4yldVFtEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8edd7370so201716339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723190464; x=1723795264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcA85CCFfsINsKGdo0oSz/srwwJd6gouV+ynJ7APhsE=;
        b=tRFzIUnm+RLck8ESZkInEBoRTNjVAT9CGEKSoNLntTrR/dkuh891NaNA5EiL2U0Q3/
         ZJjkJvyQYwBOkDdoshCUPnocZmYbsB6LIrNLRZkfHa48EjFhiYm7yn6PjH4kT3rOZKtm
         beEpX53lxI4hXLRl8+qgbnJbY1lwsWn8KuRx47/g3ftWc52F8MKZ4Je38ZwUMemMmF8d
         fbYxZIkTAnYKKjvS0QsTSDOx1ZVByiEr0Pq/NAbSjqR066rn7BkHqzlmZmn+0mMKmFBt
         gaS6qOCeFA5Kjehar1gMKZPK+GVSOw0GsqLwnz1dY6tq1O0yt7hgiTvfWHsYE3VxvK5H
         O3tQ==
X-Gm-Message-State: AOJu0Yx9C2a41bL2L5dpDkkntAZiu/K3bmEYEvEszms34CcEnw+IzK23
	IimecJSPul0BgcCh0bIwZYwus51q9hx0Zg2TnafPBBBBsX+7VLYFtWS3XsYipkEcX7Pl19kYyrJ
	Ysipk8bDjJaSEfIwyjmnNRC7KhHstVcN8hBXwGTHWNOfITZhmHSa0104=
X-Google-Smtp-Source: AGHT+IFVjBlyAJwE5QJSCwhDOvIOaOPiSnKyrlFwLTiNnFNKWTh2ZaeID6iAyy1Eq9HlkxqwNHEQbt/sNHa9RFFRLQlBDmULQMPP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc2:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39b870aa6f5mr797785ab.5.1723190464339; Fri, 09 Aug 2024
 01:01:04 -0700 (PDT)
Date: Fri, 09 Aug 2024 01:01:04 -0700
In-Reply-To: <20240809074103.2196689-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081f1a2061f3b8bd9@google.com>
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
WARNING: CPU: 2 PID: 77 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 2 PID: 77 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 2 UID: 0 PID: 77 Comm: kworker/u32:4 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-15)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 51 4a 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 32 2b a8 fe e9 51 ff ff ff e8 98 2a
RSP: 0018:ffffc9000160f480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803299e090 RCX: ffffffff814cc379
RDX: ffff88801ac3c880 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88801b5260c8
R13: dffffc0000000000 R14: ffffc9000160f840 R15: ffff88801b526318
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c001011000 CR3: 00000000225d4000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1327b2bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1493d66d980000


