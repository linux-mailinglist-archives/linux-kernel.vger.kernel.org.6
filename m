Return-Path: <linux-kernel+bounces-376528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFA9AB2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC48E282094
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3941BC9E3;
	Tue, 22 Oct 2024 15:52:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C611BC9FC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612327; cv=none; b=rLOl+mA+zhjU7LndFLLx0FcNy8VHLraPRsvvyhjXs6+uoL3YNXO554tlAWOL44Ij0JAja8D0MAC8ThTBtcCEjqb0zxIiChGJIAxz9qfC7pm95Mo+RjCWWJVVJ634uAxY8OeUyu6x9ipvYSWlorBAYIVNKnoxmy/FLERnfGWH1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612327; c=relaxed/simple;
	bh=H0/tKRWeAU994gVsRPfmkHQFMbgtyI6+o5ZSOL8khug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jq5BFTUoj7vQAnYFQuCq6oPSURcGPetvyNGjLDWNlN4v8KcXMB9krMDpK5CZJ+lliO1tgOwR+svR1jIQ2xM5z0lThlwYqYrBGntF9OV5xKLNr6s7aTOxwIi1w7AnVMYbaGmKo/Iot3pXrjC4C5/7DYDA8sB1LSSEOPeyvKpzueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so46372495ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612324; x=1730217124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq1pAU7oprruu95sKFmcha2t872wgPryLWnGrzIGSbg=;
        b=uLTgpYuTRw3ZiqylKGh+fgB9tCK+dK6dEZs5DOA4vzBoJz+6xeGWb8VQpjv8dQ69kR
         /sXkN0aMV1+Qav1DhSjo+S8pBY69JIyVxg9CZHq73ckCFfsxLmFmRSIMraUiyd8GDVMV
         /4W4mxlr9rlobbomrhNddGQ/BvxwvC8V/SOe7g34pKb5RzFrNFx5ZYhzQ4wTV7ocO/K1
         XbMH5Ee5RQ2XScrOIq7p0k20AHXwNNlimn3g58L6f38c/obrHr2BmLGmYAPTjZ6vfuZe
         N4AlJCNyqtptdpVfTHQT5x+qw01gBN8S1yy8rLlYu9LljMcECq/HyLw3ITRHWTKXKBY8
         1qcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV67AILkDZyjr+CBApP/rPGE7aPOJIIpu1Sy3W1kt+fndTmlW07NO5lGO2kQQNflz57SNt1bXfeKDE3N+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybw5CSdDafJJx77n4r8b6V44LLxbwMrchJ8mwFhFxCyErWJUXb
	7JDvy7QZSFCC65JMu5zEar/u9MWNecffNuIqz2C//U0iD98cHv0gT07tzhmmzDQaR40pm3DMMXi
	DuprFtRSlFhLYEV+RVLs5eiZVC5IVfMjSE9B54fD/cOXoXD8oHsrI9NA=
X-Google-Smtp-Source: AGHT+IGxD1nP66OE3u5+gOcrHOOQMHjtDkI6riaHGc6u5z4DeWBPXAM5JT/IbO5kmLQlAjWUJKjnPdOf932MolhYJeCYtc+Kz29o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:3a0:bc39:2d72 with SMTP id
 e9e14a558f8ab-3a3f406fdcdmr140338295ab.12.1729612324524; Tue, 22 Oct 2024
 08:52:04 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:52:04 -0700
In-Reply-To: <3b0be684-0b50-4151-a275-0751715d1be8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6717ca24.050a0220.10f4f4.0150.GAE@google.com>
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
CPU: 0 UID: 0 PID: 4551 Comm: kworker/u8:26 Not tainted 6.12.0-rc4-syzkaller-gc2ee9f594da8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:hfs_write_inode+0xe81/0xe90 fs/hfs/inode.c:444
Code: e9 f4 fd ff ff 8b 3a e8 dd 6c 31 ff e9 02 fe ff ff 49 89 d6 8b 7d c8 e8 8d 68 31 ff 41 89 06 e9 26 fe ff ff e8 30 73 98 fe 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffff888115ccb5c0 EFLAGS: 00010293
RAX: ffffffff831c8500 RBX: 0000000000000000 RCX: ffff8881151c8000
RDX: 0000000000000000 RSI: ffffffff91870ec0 RDI: 0000000000000000
RBP: ffff888115ccb6a8 R08: 0000000000000007 R09: ffffffff831c77bc
R10: 0000000000000003 R11: ffff8881151c8000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888012a7ca70 R15: ffff8881151c8b38
FS:  0000000000000000(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcdb4e446a8 CR3: 000000004484a000 CR4: 00000000003526f0
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
Code: e9 f4 fd ff ff 8b 3a e8 dd 6c 31 ff e9 02 fe ff ff 49 89 d6 8b 7d c8 e8 8d 68 31 ff 41 89 06 e9 26 fe ff ff e8 30 73 98 fe 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffff888115ccb5c0 EFLAGS: 00010293
RAX: ffffffff831c8500 RBX: 0000000000000000 RCX: ffff8881151c8000
RDX: 0000000000000000 RSI: ffffffff91870ec0 RDI: 0000000000000000
RBP: ffff888115ccb6a8 R08: 0000000000000007 R09: ffffffff831c77bc
R10: 0000000000000003 R11: ffff8881151c8000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888012a7ca70 R15: ffff8881151c8b38
FS:  0000000000000000(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcdb4e446a8 CR3: 000000004484a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14922640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0a45c444eedcbdb
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164c4a5f980000


