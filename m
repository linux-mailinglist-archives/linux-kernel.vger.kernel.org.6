Return-Path: <linux-kernel+bounces-280228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595EA94C76A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2B61F21A95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94524160796;
	Thu,  8 Aug 2024 23:43:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E255769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160585; cv=none; b=BwGz89VMmRZtFmG8nWQQYOSFdQrX0SKeUI45SKxAlesyByFXY8PyFj0Z9HiaBmihw8lLRVjSFR/PhvaS4p2yQC9jl3KbbyELf7naiK1F2b7NgXtvK/yP3QnA4kes3b1lpygD7nXAF7gGMBlOunrldHA1igJarT+yUwP5w2PdZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160585; c=relaxed/simple;
	bh=7xRm3aIMs2pTIPb7GXBHV+8NVqHYEL9XUm9HH8t2Bvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=plw3EH1NpYsbNYBPsRLo+xrrCkKsrk0etLetw2TVRXOYbLwyBShJgjVD9KGlmLQl+01dP3L8eTTniAR29fq32c9iMVFIndrEE1VAWMkrEHjtjpYY12guddvi70Q2B8Dca7WzKCNC/kWipGSKg/uJNAGLQl9JvuIWdtb1A9VOfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f9504974dso162996739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 16:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723160583; x=1723765383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+k5w6rLZqKiWxf7CsxaxPeSbSkyvmBWZDNvQfcY6hgc=;
        b=bsRhNnHTQ7cNd745QbVsq+7wpfdTgUXcUjTEa7OdNXBd005r4Ax58NM13u4lYJkwSJ
         ulCKHYg4CcmjD1kC2Bg97Akuj90QrRRggSCa6GnairswliXMVELCp+WXScGYvW1/7XNE
         TediR7ygqBuCpB3cGJJ5pY2X3tuJIeDgNL1SBgL/5+D1GJFXXypDWyNe2MJkjta7y5vP
         zZX8iDbWcVQ62ZAVpbrpMvDv5WrA+ZQCBNT/2XfURPaF+w4Hz8p/2z5DX+HypQMsZopJ
         DpjYpIMuaG9gB1SG6KWLb1SALwr5qxjLRUNG8zxd//Mps4YccvDAlJ9DK94BNT2R0ONh
         ucOA==
X-Forwarded-Encrypted: i=1; AJvYcCUPPz2fGArFU8m/Ew71ja4T4MfQGVC6cG86LrQBmD45oU7dC/sL8hv7NvOS1lc8vCaM4lhiPP12OKRQlJv0/OQQ7b6+9D6Pd+PseA0k
X-Gm-Message-State: AOJu0Yz7EkjBbXAolD8Jy7tLyC5g2i5afsuf8Q+b/i7yOtrKvX+qqWEy
	veuViMq6eHq5+8EyT7XcrjAj94ozBO420lvRqOPWWOan/Pd7JjUSEuG9YTEWmc1sscIjxxMnNiP
	2QHzal8c5o7wBl/ctzYbPys13TTB34kkbto/xbuNj3OcLLzh1ZSXJiHw=
X-Google-Smtp-Source: AGHT+IH2kw9uOmBpGPrr+owvRVXLEigB0gAlclKH58CEIjRAmA+WYicbGb1YNxgK3mK7KmAAZt+BeOBxAIcWhyy1nw3I/cKmUJcm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4107:b0:4c2:7f96:6f4 with SMTP id
 8926c6da1cb9f-4ca5e0fba64mr163300173.4.1723160582829; Thu, 08 Aug 2024
 16:43:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:43:02 -0700
In-Reply-To: <tencent_1252C8C67A098E6ECCAED4CC9927E8C6C406@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e4e51061f3496f4@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: 1901336, v9fs_begin_writeback
ino: 1901336, inode fid list is empty: 1, v9fs_fid_find_inode
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901336
WARNING: CPU: 2 PID: 46 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 2 UID: 0 PID: 46 Comm: kworker/u32:3 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-17)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 60 9a 8e 8b e8 05 4c 0d fe 90 <0f> 0b 90 90 eb 80 e8 e9 2c a8 fe e9 6f ff ff ff e8 4f 2c a8 fe e9
RSP: 0018:ffffc900009e7480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803249cd40 RCX: ffffffff814cc379
RDX: ffff888018ef0000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88803249cd40
R13: dffffc0000000000 R14: ffffc900009e7840 R15: ffff88802791d958
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffec1874f78 CR3: 000000002a43c000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11331ed3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1236fc5d980000


