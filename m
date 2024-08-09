Return-Path: <linux-kernel+bounces-280985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8394D19F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C1EB21C81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080AF195962;
	Fri,  9 Aug 2024 13:53:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5C1E49B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211584; cv=none; b=FBaM1aMA1s/MQY6MBlMZQPLL4s5H8HxnWZSxyDx/IrEFfn5lSzKW6W5MocFRR/fM+tvBGyy1KYTip7+2wzlI290WtpbQSlOtarPUpKnuu3hmHi+qMTUu9TeLMkXIjURS06PePiWqWGzrQucPSPCke6gnadWKxUlgWRKMu9O4IHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211584; c=relaxed/simple;
	bh=+vAHKNvMw0k0weLuKdpL+kCfloLp24OhOfHgl1BDMZQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lP0TqSbEjA48lkwWApsQiiI1w48vQSmP7nZhLqyyOFrweQz2nng8vm9ycSeUo9ZMFBdglUY0jC4TlhSB+8avp6Yr0OGka/PD/rXait9BEiSouvN0r3mysd0WKLNR+dU1fPGcdUmmpSwfsAF195iwYxGq64A6Jqh16GFavV2RdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-821dabd4625so241198339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211582; x=1723816382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb7MecKiKqf/wczWQVM6I2t2srk3ALp83WriJ0eDVv4=;
        b=Z8KXC0iQpBcAhFvwZHB7X+FxP7hJZToAjPDNTO4uVFBsU8dVvjMxZDQEexyXcOSXm/
         fGv6DLAAjcf2Ex3nb5unYfoC4/UflPKlj1fCpYsgS56vaSwceGfpRlJtUkhUIX1AaKuD
         LeLifxPPR3Vpg7FnRdfMccMKgBDtrLG9Btv5NVX9bs35m8VltLFhvRPG7bs8tw7L1ZOo
         BrzPkUpBSMOB9Sf6vfpzLJlkABxUj9T9yoCzRyfJZMFPpoxDfxfOSfzxBetR+F5RbDE3
         YpukOuL8cHKh/pbqucxT+HxT08ACkN5r6W7t2XBRRlRsNABOoruBahtOCcKA++jVVSjp
         UZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnuLGroq8AmP8pQbu00npGdf5mGSvNpDy19XNJWJWeYMBMhu6opKmhnESxXOIULsCzxGzWw/7MFvY/3yz6GLt2J7LWQV7w0KS6Td/a
X-Gm-Message-State: AOJu0YzQH46NgGi/MA9sVEr4OQ+MxOq67EcU5cKK/vDHb8U9vds1EXEN
	R6jjX+ZX210r1DocOgQ/9kG85WK5w90SqIRBgeIIczrUaOAZsWbH2ltRhAb7m//zH40JKlq4nla
	qia7Nj8Z8UMNOhPMFWw6WyPDvcBS/dl3odSN49VJU+cs10aHuwP9sv0w=
X-Google-Smtp-Source: AGHT+IHsO2kTopRTDJe7rgNcoffZ70krS+HeksM8JG+kAhrOfXjCAwyDJSw1C6boRo1nwxQSKoO5pnB6rDbm4TAmywnVEvGOvTGJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:c46:b0:4ca:7128:6c70 with SMTP id
 8926c6da1cb9f-4ca71286fdcmr38062173.6.1723211582086; Fri, 09 Aug 2024
 06:53:02 -0700 (PDT)
Date: Fri, 09 Aug 2024 06:53:02 -0700
In-Reply-To: <tencent_9A6ECA0CBEA7CC46CD92DA86534992EEDF06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000393064061f407652@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in v9fs_begin_writeback

ino: 1901337, folio: ffffea0000b9e280, netfs_writepages
ino: 1901337, v9fs_begin_writeback
------------[ cut here ]------------
folio expected an open fid inode->i_ino=1901337
WARNING: CPU: 3 PID: 1111 at fs/9p/vfs_addr.c:40 v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Modules linked in:
CPU: 3 UID: 0 PID: 1111 Comm: kworker/u32:8 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-37)
RIP: 0010:v9fs_begin_writeback+0x24c/0x2c0 fs/9p/vfs_addr.c:40
Code: 00 fc ff df 48 8b 5b 48 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 48 8b 73 40 48 c7 c7 e0 9a 8e 8b e8 a5 4b 0d fe 90 <0f> 0b 90 90 eb 80 e8 89 2c a8 fe e9 6f ff ff ff e8 ef 2b a8 fe e9
RSP: 0018:ffffc90005cff478 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888032064d40 RCX: ffffffff814cc379
RDX: ffff888022ada440 RSI: ffffffff814cc386 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888032064d40
R13: ffffc90005cff840 R14: ffffffff8b8e9c80 R15: ffff8880429e6998
FS:  0000000000000000(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557e5f55c8 CR3: 000000002be92000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_writepages+0x6a2/0xe40 fs/netfs/write_issue.c:535
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
console output: https://syzkaller.appspot.com/x/log.txt?x=121f7bc9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107a78ed980000


