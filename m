Return-Path: <linux-kernel+bounces-282996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC994EBAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0011C2142E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A4172BD8;
	Mon, 12 Aug 2024 11:18:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33843AA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461485; cv=none; b=JfDBjYinfonT5eXy6xst8l5AfQKCXl/hm5aFmQbqndThUN1vJ/xKLV4wAxd00JJARPBayq+4RLqRCsiVcSPT6+fMcGU1Cht3Ph36H51FBHdA7UlXc1NWptgtFTnzR+JWgFA1aWLq9w5FMkRJNoRpbLw9W1J9w1IYPM3A3wGPVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461485; c=relaxed/simple;
	bh=FbcMWVVkUAzutjf53EARFLzFPBMm4jedgksGwABChEE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D04VqGT4DX7y+9ZoVwpQzTr2yjdNQj22rMm5rrUGW/amXh7WnjB6hdQSc5a3YCZ2oR2J8DxX9L4GGGzlbOa/CG+5V6bTJ29jKfBh65uc5kWPmVRPYBbMyRi4oWM1DoC1oTqpkZUmgSEpgVUkqMj9s4bIwf/bQaA58W6i/xFr1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-822372161efso401550739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723461483; x=1724066283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn5mkl0camzZZtDfse7nmp35g+yc05KFCbjwYY+Eh8c=;
        b=Pqxk6wO5qnbc2QLZHUa8SIWY5Im4S2qkmNti+t/cQHS9TRv9uh9mTp4W7ULjT504pd
         ad6/L48kb/XsGBgjbsXV8HQXH9GG05Y2Ok5Te/ZdbuSKGSgdWVrEsD0zyVa9//XCi7D9
         3WTNhmEvfYO9JioBx+avxJqzFg7tciiEKQOCQUnVIEcXWnWeiF3BGDJ3VSOsl7u1k1dW
         80FqGch14erG3Nrw7OLRcLxGiRrD6uZb/IwCalrr+BYVWdIGo9quc0YrG3l1VmVHohBe
         BdiA6PCZriHFskPcnlIp/ynY2P0VmeOO1KDIBjb7jvRpOV9qEDr735NLPh5xQ2A24lmv
         f7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8PyYTFdF9S/s+Ob1x46uA5sitqHnf+HJt8ZL9cKXg2VA4M8tomb0ATPb8saki5kNfA4JYNpo2N+47V87XzQS2Q+tGHoUivrLiV0Cc
X-Gm-Message-State: AOJu0YzxggGp0DNlL2wHhS4KItgV1g3W9p+rH9JWOUk2vdkxqN1ND2bF
	dXaycbeE2t0wUNmculmYHaqSo2h4oejhq2gO8wbJpKvdX+n9utCWEeebWGMfd8FgfCrpZN/L3mU
	sOxWLoUHDZvC51OI6nrFl8gcdl89KoWa8q+TDuOp1deJYXfuYOcBrkZ4=
X-Google-Smtp-Source: AGHT+IGplz3OqIizwhyUvZoLsCs31tgP1lOTgEJbuBVD8c4VsDNiJs+bUmUCECOeiADBQiX7+JngFebPQI8qecS67002Juk1T+UN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:377:1625:5fca with SMTP id
 e9e14a558f8ab-39b8135325dmr6877635ab.1.1723461482821; Mon, 12 Aug 2024
 04:18:02 -0700 (PDT)
Date: Mon, 12 Aug 2024 04:18:02 -0700
In-Reply-To: <tencent_E325B68DA09221DDA0DD81191A4F878DAC07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077c9b2061f7aa54e@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: 1901338, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901338
WARNING: CPU: 0 PID: 1201 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 0 UID: 0 PID: 1201 Comm: kworker/u32:11 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-8)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 20 a4 8e 8b e8 95 3b 0d fe 90 <0f> 0b 90 90 eb 80 e8 f9 24 a8 fe e9 6f ff ff ff e8 5f 24 a8 fe e9
RSP: 0018:ffffc90005d8f478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888033572030 RCX: ffffffff814cc379
RDX: ffff888023322440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888033572030
R13: ffff88801bafd958 R14: dffffc0000000000 R15: ffffc90005d8f840
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2173307a8c CR3: 0000000042048000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x97c/0x1230 fs/netfs/write_issue.c:550
 do_writepages+0x1ae/0x940 mm/page-writeback.c:2683
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11e497c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c6e95d980000


