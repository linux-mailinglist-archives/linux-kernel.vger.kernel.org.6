Return-Path: <linux-kernel+bounces-282248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E281D94E14E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E80028103D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6057513D2B5;
	Sun, 11 Aug 2024 13:04:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9C13C9D5
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723381444; cv=none; b=Sg6uFZCfatFuQVW1+LWetSWXeQNWL6BOXBKljrFzNVv3wJPcUDx6dNrrJJerVhvaoXkJFk5RvG15ctFUi+tDT0gh73s1+7ZijzgjmWFdPdcwGBu1/BkJF33u0wvNxzCxNAd4xzEs7uFnyc9kUA+NWO8al/txrY1e/+vanSAzkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723381444; c=relaxed/simple;
	bh=rPJsyiioZMdEq2BEETQo7GejFCBPp07slnBt6JsvxGk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NbuPMvn9XfgybPZBzckydc3tOyNj9fWhHUBG9eQF1vqg1cz27/adT90/Iur/yrtdDWZ3/dnStKkNJv7yrisw/7XbmaKJAWcaDZS9kkRAqeksCL/9KM7Sl8+UpcSRQRXxpguYa8axMwpzSrckJ5+Wqc00yISb585+1MiqgGu99Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3b5858e6so42989685ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723381441; x=1723986241;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QIMVd1s8QiVIYd3WECwj+x2sjUMygw+0mX3A5XRfsY=;
        b=bTHFS6dT6Uz30ca4x5Mb7KrJg9M124SFfUu5IOizOvSMSuo8LiwluB1hYk4sFLBcHV
         I+aRCjJfyOz6jH0SQ/7ariGUYb7Zwuky1D7TiI9o+t0zzMLfe6zdeg5mUuuWZg80svGZ
         iBHOAUGvAEnicmbUsRZUgY47x9tKQx6hfBCf4tAu7Vrabsey26QRBpmCYtIeKSrxIO+1
         J5fbk+UIcgWhBGQTvcXFJWe0FwGQlMf9Enf4skNkSoITVmPYWIp7z58QP3ojlRY9wolz
         CSu303nK5zqNI2/p9KXWLj59+oYS+DW7sCTs8fGT+sTaCZRs4oujdZ/5FOkzTKytVIBP
         TzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5j98SBjdjCueXVx/EXh2sXPI1DLOq/t5Xi7n8bD71s4IHjc/vMduh2TxoADh475kV1gDyEmoG91FpX0jOBKapQk2zvKKVexsTRvOy
X-Gm-Message-State: AOJu0YwNr1y92onoEY0c0/1xBVBKNie/LZgbA3sVw/OVAr4M0aaQkM2Y
	sZw91mqzmffFZLRMAir5D+eH9qn60/8yzhCCYQD1JYMuWAlGO1zeehy7SVr53hTeAL2AocxYMJm
	AyYa5FlieJq4k/K74iW5jPIvoVUxjl7/rpzMaP9+cPStheakGJIxiCLE=
X-Google-Smtp-Source: AGHT+IESQXjBFTO3hUqZvl0pnjjkpcQNWS9+WqPKNm5vIErncW+D266x/JMdP83GBfgbcw/wTCG3yx1J54Ae4KjWOZSPQbpk7tB7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:39b:17a9:e374 with SMTP id
 e9e14a558f8ab-39b81325b85mr5989205ab.5.1723381441660; Sun, 11 Aug 2024
 06:04:01 -0700 (PDT)
Date: Sun, 11 Aug 2024 06:04:01 -0700
In-Reply-To: <tencent_0E503C2F3660964436144B5A74DD779D6709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a49973061f680250@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino state: 393351, ino: 1901337, comm: kworker/u32:7, folio: ffffea0000efe1c0, netfs_writepages
ino: 1901337, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 3 PID: 1106 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 3 UID: 0 PID: 1106 Comm: kworker/u32:7 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-1832)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 a0 9e 8e 8b e8 25 44 0d fe 90 <0f> 0b 90 90 eb 80 e8 19 29 a8 fe e9 6f ff ff ff e8 7f 28 a8 fe e9
RSP: 0018:ffffc90005c07478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888032ee26a0 RCX: ffffffff814cc379
RDX: ffff8880227c0000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888032ee26a0
R13: ffff88802599dfd8 R14: dffffc0000000000 R15: ffffc90005c07840
FS:  0000000000000000(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000740 CR3: 000000002c012000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=147299d9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c6caf3980000


