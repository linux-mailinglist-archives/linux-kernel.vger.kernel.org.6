Return-Path: <linux-kernel+bounces-406906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF189C662F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D35B299FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E095CB8;
	Wed, 13 Nov 2024 00:26:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841523A6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457567; cv=none; b=kOIAudCVfMqJu9YAV/+kyiBMVqxydHB/6bAOMc59Q0r55I3h9U6cnieG04AGk844eJRPD02bUmURpenjkyEUt3JjAPmlo5m3Y2KlpR4NgoQ5uR4qm5Z4UhH/O0akQ4mDMt7Ngg3Vu58x4Gt5w4pRfdPde4P5m3hDJXk5h7AZ/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457567; c=relaxed/simple;
	bh=aS2Is9ZQ/xzhIZQkkp5NJZKCy09LJu/qMCCqpUVWOqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O0JQHNt1/YgaMZz6vBBrUz331q3jC7njd2u1Hasw/+MHx2bm4sn3/udohEMj0xjmjxo4zD6I1g07ANrLyyhlvVZTx0quPv+OqM8s53q4BPiKwNvq/qm81cIcUlO7aubQ9WB78HQsSKyt6w1woQVpoijQrFWnjV5V0RokkFjfDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so75541675ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457564; x=1732062364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx6UwOIjgebHPG/IW8Frem6w/1sk6fZbDWO2MWfeuQ8=;
        b=Y97ch7hLrDkNAMjArv155zWtISl13Lhv1LMFxTQ3fF8i6++mJAoqLh/EmpQNRoU7MD
         oFH8bcYYN0a3wxlWtcmpo2fozpJMluPAX/1EWJPVB7aCgmYvoHQQ5LA+627VunZxwGhU
         TBNqQWf4e0ui6KLRC999HFxgeAVevvyULhMs6r7J6tSe49jiOLj1Gpzh6AJToGFw6oLI
         TUvoOD7EVirUgcPabnkIrXan/Iub3EB3p92J10moocOEhMRgh1EvxHWvqRJBhDAdrP6i
         DN8IjwgFaIvmRR+Z33AcLKyiGR0HETvmKVHxHjdxsCEODeNYqM7TowctA5t9WmFwr3d0
         lg6g==
X-Forwarded-Encrypted: i=1; AJvYcCVbAQn207EyJQ+lAHoHxSfuTLvjTCacSnJa5NHP2DhvBY9qVkmMUcjfIiV2Yz9+L93u/1n2qJ73e4HacqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUmrk+UFxQj8rhllYWZ9MGzCDvCuxIzikqfp631RBsbOek5cT
	jSInteHvwajGZNs4EB7laLcELy9nTI5sB9PkyqyeSqulG+xCSZEngLBOS023jnFm8T6uFJ5bL+V
	FyheLEAxHKJpfFgmVQoKJvJIqLoyUmuBAUNmTrBa3Y39+xGxNiP/E7uY=
X-Google-Smtp-Source: AGHT+IGuXdpZUeMwiOCcCmnYgMyAs3RKYJguHeZGUNZi47/Jp1CAlclzq559kggDf5Ad4y/ngWDlEnWRkwu1gCfmLJHrIHEP96rI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3a7156db5b5mr11333955ab.1.1731457564650; Tue, 12 Nov 2024
 16:26:04 -0800 (PST)
Date: Tue, 12 Nov 2024 16:26:04 -0800
In-Reply-To: <d703694c-a0a7-480b-bafa-c8703306d2f5@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6733f21c.050a0220.2a2fcc.0001.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in hfs_write_inode

------------[ cut here ]------------
kernel BUG at fs/hfs/inode.c:444!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 1 UID: 0 PID: 34 Comm: kworker/u8:2 Not tainted 6.12.0-rc7-syzkaller-00040-g14b6320953a3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:hfs_write_inode+0xe81/0xe90 fs/hfs/inode.c:444
Code: e9 f4 fd ff ff 8b 3a e8 7d 43 31 ff e9 02 fe ff ff 49 89 d6 8b 7d c8 e8 2d 3f 31 ff 41 89 06 e9 26 fe ff ff e8 b0 2d 98 fe 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffff8881003d75c0 EFLAGS: 00010293
RAX: ffffffff831cc480 RBX: 0000000000000000 RCX: ffff8881003dc180
RDX: 0000000000000000 RSI: ffffffff91870dd0 RDI: 0000000000000000
RBP: ffff8881003d76a8 R08: 0000000000000007 R09: ffffffff831cb73c
R10: 0000000000000003 R11: ffff8881003dc180 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888040cb0a70 R15: ffff8881003dccb8
FS:  0000000000000000(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdea70dd18 CR3: 00000001151bc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1503 [inline]
 __writeback_single_inode+0x8da/0x1290 fs/fs-writeback.c:1723
 writeback_sb_inodes+0xa34/0x1c20 fs/fs-writeback.c:1954
 wb_writeback+0x4df/0xcb0 fs/fs-writeback.c:2134
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x40b/0x1940 fs/fs-writeback.c:2321
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_write_inode+0xe81/0xe90 fs/hfs/inode.c:444
Code: e9 f4 fd ff ff 8b 3a e8 7d 43 31 ff e9 02 fe ff ff 49 89 d6 8b 7d c8 e8 2d 3f 31 ff 41 89 06 e9 26 fe ff ff e8 b0 2d 98 fe 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffff8881003d75c0 EFLAGS: 00010293
RAX: ffffffff831cc480 RBX: 0000000000000000 RCX: ffff8881003dc180
RDX: 0000000000000000 RSI: ffffffff91870dd0 RDI: 0000000000000000
RBP: ffff8881003d76a8 R08: 0000000000000007 R09: ffffffff831cb73c
R10: 0000000000000003 R11: ffff8881003dc180 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888040cb0a70 R15: ffff8881003dccb8
FS:  0000000000000000(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdea70dd18 CR3: 00000001151bc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         14b63209 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ad81a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d2d076474187685
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127101a7980000


