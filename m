Return-Path: <linux-kernel+bounces-282287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EE94E1AB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C821C20E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6801494A8;
	Sun, 11 Aug 2024 14:33:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA31798C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723386784; cv=none; b=N7LJGaiSguFT55NDCdYNSIARGjMafRNzU6HEvDHayGHUFcaORwbJ/uCpigqpU5y/tgCq47/FhjIlkgJoPGMDy3xFmDq3tjmvkzB890cNejq5UzIxmV0AUwrCFEKaJN+Q69NHh3RxDOKKKyoqoNgpV9+4Ua5Ekz57KA6QSePKBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723386784; c=relaxed/simple;
	bh=1qxA6gdXrx3Bh4Vb32h+/uLtTqf9J6agBrFOcJnWxiI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nUciKQqIZsFK9hu2f9FjFzZAwp2TWEV+lOaQt5RFPTqNdtb8KJv91lxad99waLxgtAgTCGduaqnuBCKKnsAY9/OQgcl8XCs5Mvufh7IxaZGj+sNL+FjEzk9TeF+mesZ6U/v5qQEN0Pw/Vd3Ouh88u3fnVTYYABAT/51dKCNlFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81faf98703eso478554439f.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 07:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723386781; x=1723991581;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PgIS2zfsxKODMuDp8kp4cSzi3TYPfrmeL0DlFXiVt4=;
        b=MKJG8EQTdsPp9d84elhSo2eAzpRYXYDeRUENDxLubjR9LvcdQ20PDJfYQYBD8PtTWd
         821hnUK/c5kE17tezWF8ncDSoEd5RtVK/n+tfwAt2FnxZ6fFLmoSBzsy8wmcxHqfr+5e
         1fxaJNSfuCNYT8Kfh1PbuaaBKjyIQUJJh3bMqNLPnflZARAxib/1G/uC1d88jFaJnu+2
         dtSzhR+ZrgrFMZICosCRx+cJDwdk75a+YDtt00bHBnp2SxktFRUkoNuze9B5GVmcE8/i
         Sov3uv08SKUvzkHCZg2xnhjp1U/PFOpGo7quTFq92nIPZalU2AAS81vTNlwMazwcBmrz
         OWNw==
X-Forwarded-Encrypted: i=1; AJvYcCWDAvrJWkMl3rxBgvUGpIutqmqjhTHSMwyJVZK5XomPW1vwyiHS5MfiBRSPIVXREazVTwQOBlXBzIvAa0sBAD3KNweomeLkasFl3XFn
X-Gm-Message-State: AOJu0YyBlRna1KvQPd6ZL8G+Nj7aHrhCyFEA7qfwQwNwbwGmhckghNRW
	ermgra1rWzd6LfxV8Iw4c/f/P33bcYkKsWJAKbfYoDL1pggdMwMcJsBS1RR5ITLSe0ZIqas6XLo
	/42sLERh5opV2lSZ/mlDhnWAHP5O4Y8K1k6+mG6M98SJ/QklVp6uv1GY=
X-Google-Smtp-Source: AGHT+IEkDHPxMeuH1TpNq4t6DHDG7IGNI/8KeTQ3mdvYQF8I8eFYLTWv6k2QayPpAuTp5y20HlvA9Fu4t3kfOwtiok8ehfNMEnS0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15d4:b0:80c:826f:ae77 with SMTP id
 ca18e2360f4ac-8225ee44169mr16737439f.2.1723386781503; Sun, 11 Aug 2024
 07:33:01 -0700 (PDT)
Date: Sun, 11 Aug 2024 07:33:01 -0700
In-Reply-To: <tencent_9BD4192E4F948D96A5F58DC9925C5DAADD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec2483061f69409d@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino state: 393351, ino: 190133a, comm: kworker/u32:0, folio: ffffea0000de1400, netfs_writepages
ino: 190133a, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=190133a
WARNING: CPU: 2 PID: 11 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 2 UID: 0 PID: 11 Comm: kworker/u32:0 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-212)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 e0 9f 8e 8b e8 35 40 0d fe 90 <0f> 0b 90 90 eb 80 e8 19 29 a8 fe e9 6f ff ff ff e8 7f 28 a8 fe e9
RSP: 0018:ffffc900000e7478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888032acd3b0 RCX: ffffffff814cc379
RDX: ffff888017ea2440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888032acd3b0
R13: ffff888026ce12d8 R14: dffffc0000000000 R15: ffffc900000e7840
FS:  0000000000000000(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000740 CR3: 000000001efc6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x97c/0x10a0 fs/netfs/write_issue.c:546
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15b7d95d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d13d11980000


