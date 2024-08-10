Return-Path: <linux-kernel+bounces-281672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C895694D9BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C858F1C213DA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197543D55D;
	Sat, 10 Aug 2024 01:21:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAC1EB35
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252864; cv=none; b=YK39clhXfdHM7V5VmAtPtw+tDJh7PtPFQlNstsUMQ6kDsN/OxN8p4WTj+2qZV5iKusE3AK+6hTHgNk7wYIU3+g86FKt93VhsHKVlS/A9SMFfRk1M39thQ9JEDKM/yjsp6ln+eIW+6lJTlixtO1Iwd+gZBH+xFshzFaZ7dqHexXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252864; c=relaxed/simple;
	bh=/KZgtwTnGNrVi5uqrp3hj4UXfuVBILcRjfq+oFSm8KE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BtKfEH1EeNK/y7G/pae9hEDkj07BMA1fNLKT5j6y6LkwOnMstIQHHJG/1O6gsHE1QamPNT0GQoFD8OZnb5d5cfshH3BU1GXPMW/fDySPZT1VbgV4/UHOoeFH+Jsnvk2mSNbPhPLfJzb6nLa6QzjrQqI9uS4R1LUqEk3FgsfKtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b391cf336so40181405ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 18:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252862; x=1723857662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOjcroTxiXS01J/mgD48xC1SyD8vtDV4JFo7zMvjHOk=;
        b=bWQ9kE0K3sXSZa6IR13X/t6vp4IdsdnuOSmh7z1mfI8OM4PawwNid4aRDWrP7MFRFd
         Qjg4Ub5NMJSep5aYgwpGdXIfJkRVon8JISFvVarnHhvHKhXAWvJux7BsRvSWJj5wSoYU
         8/9SIAOyMdAxJpEFxjihbhd6sxk2yjCOOfrqZhQQf4sOFMK/J1E4UhbzmorcjcWRDXUA
         LwmEorwaZnC/k/kI+T3YHWcnKha2JlIgrCpVXf6LQJjkZrbw/7SH9XAqJQsOUCP6eknj
         ZQO023Iyectx1Oky5rXZDJjQx2Idbi9DEKf51FglsAmoxznEcDvJjvX/OsoIP61vNMfp
         2FSA==
X-Forwarded-Encrypted: i=1; AJvYcCVIDq/VRuQmCe7QwXWIDnx4bzFj9hFZOQ/+FpjdDrO8mlNBa5BAsiRZSJzNNsRY2RrSUrKS9bAOpvrxBx5qIYnX62Mf+P5xF/Cn56yZ
X-Gm-Message-State: AOJu0YwaoQv2aEpke8hZEJFgfGQvBCfKZfmWttI7rmkKURX29SnKqpeM
	DS0B+pMj4Kxc21nJcTkkc9949UgMR22ACha8bgXjKANydDDhm+LOcS4ntAoymrCidhkloX/W9U+
	VvtROZG3E3pk6nxImcmFENsg8KJM2eUrtDkoGhWHKJGbMMprYDmp2au8=
X-Google-Smtp-Source: AGHT+IHM+auSRG4EltT837WfTWDqFUxm4HL09/9k2Z0/hrEchkuMpHbjljAOtsfUo1bDg5xzxyy0EhXblrkumr0ECW/94OT57VML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39bc704b058mr2190625ab.0.1723252862296; Fri, 09 Aug 2024
 18:21:02 -0700 (PDT)
Date: Fri, 09 Aug 2024 18:21:02 -0700
In-Reply-To: <tencent_234974A3B3644C9769777466C1F365636505@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b732a5061f4a12b1@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: 1901336, folio: ffffea0000e18200, netfs_writepages
ino: 1901336, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901336
WARNING: CPU: 0 PID: 65 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 0 UID: 0 PID: 65 Comm: kworker/u32:3 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-7)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 a0 9b 8e 8b e8 a5 49 0d fe 90 <0f> 0b 90 90 eb 80 e8 89 2a a8 fe e9 6f ff ff ff e8 ef 29 a8 fe e9
RSP: 0018:ffffc90000d27478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888032adb9f0 RCX: ffffffff814cc379
RDX: ffff888019ac8000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888032adb9f0
R13: ffffc90000d27840 R14: ffff88802036a658 R15: ffff88802036a3c0
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc78e97db8 CR3: 0000000044b02000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x82c/0x1040 fs/netfs/write_issue.c:541
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1121115d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146ec67d980000


