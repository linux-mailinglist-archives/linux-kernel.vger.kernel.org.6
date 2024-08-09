Return-Path: <linux-kernel+bounces-280663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7E94CD74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C071F22227
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAE19148D;
	Fri,  9 Aug 2024 09:40:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE3BA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196405; cv=none; b=CGUB/6zQ4Af8FbhXRyVtpIKO0+2eNRq857tvaI0JJd6RZHwYAehkxepql5+fmLVJtBJMWqoXYF8dhAqyR+m2n5evkdZGdv7MoFkOUCGx1H1RgPrIotJcOCn0pE7QdazN7srTCk3ttdPyAHVHCcAlDtDCWkwpVW7dSSAFXeQLXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196405; c=relaxed/simple;
	bh=ZWOlYfalz/WcF1v+v8fTfPizsK/yCWLZKWvn9WQk3KU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PfeEQTEMHTKsl8WTJYhxWZyTdevgfSjEoMhpV1pc7Al/vpBTj8i6Ydy/su5BO8/+DrJ1ypMIyNTiZHYrJbuCDJcv4NEj8hUSjOCS4YfkQIU6T7bIXKyUXACeSGxSe3mb0YykLl1b8tXqYdpSafIMF2Lk9RrbHlaGVFtFRJ0MWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso308276039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723196403; x=1723801203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ci62slgaX4lYcfNgF16KYrNbjZ1NcLGUDDP+N7LYB4=;
        b=U5CewdFANfOoN61RQpPbdMNnuoQXDmw8VNx7qH5gImBE/+n3POzsZ0yHtmGsJOEzKl
         TDiCl7xWiMv1Hx/OtNXZBVWQ4QTQQOMfet7jI0l7Kf9l/UajYvsBwQrhOqBGkJjbO5Dt
         DFGKw6jTd8pzF5ArI8CpEGyWn8mZFfcDLPrq3/hdavjlS1lnUynEnGLSXwITlivXCd39
         +VqKB7hIrhwflLRAds5HOcw1YjwBlnyc5o17PxqRROXf02/i27cgpJCCiiVcocm94d/v
         T94bpyOIk/QSHLfz25gFhOKKORMxsWbV6ZXwk0OALs/y0q3YMEWu7whJmlfWLcABBN6T
         VAsw==
X-Gm-Message-State: AOJu0Yzo8rM/BpEW9pi/IGnEvyxYIlP/YtjjVsjHiydLJO33JFho8ZCF
	IqpAniOmU1JiM5yqpzoG6UNXCgg5jWhR8K+LmpZNk3BSgX13HUZT8rn/MwghFtVk38m7r+n6s0R
	oBbt+cWNFraJBsGqoqx2RpiyaJ8EllD8LGEGiqIW/GJhbJAQM3MDDvAc=
X-Google-Smtp-Source: AGHT+IH6TkbKn7+ofN86Zgi44mYG8PgjNG34htEwMeoYOsOCc9WUG8xU0opAxOSCB2786GlgzA78ac9FzIoZPAhKIfVImZZzNClV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164b:b0:4ba:f3bd:3523 with SMTP id
 8926c6da1cb9f-4ca6ebda88fmr47378173.2.1723196403599; Fri, 09 Aug 2024
 02:40:03 -0700 (PDT)
Date: Fri, 09 Aug 2024 02:40:03 -0700
In-Reply-To: <20240809092004.3109492-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083dcd4061f3ced0c@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 0 PID: 13 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
WARNING: CPU: 0 PID: 13 at fs/9p/vfs_addr.c:39 v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Modules linked in:
CPU: 0 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-18)
RIP: 0010:v9fs_begin_writeback fs/9p/vfs_addr.c:39 [inline]
RIP: 0010:v9fs_begin_writeback+0x210/0x280 fs/9p/vfs_addr.c:33
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 66 48 8b 73 40 48 c7 c7 20 9a 8e 8b e8 51 4a 0d fe 90 <0f> 0b 90 90 e9 62 ff ff ff e8 32 2b a8 fe e9 51 ff ff ff e8 98 2a
RSP: 0018:ffffc90000107480 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880333a53b0 RCX: ffffffff814cc379
RDX: ffff888017ea8000 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802bfe5708
R13: dffffc0000000000 R14: ffffc90000107840 R15: ffff88802bfe5958
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556843b5c8 CR3: 0000000026014000 CR4: 0000000000350ef0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac45d9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1014bae5980000


