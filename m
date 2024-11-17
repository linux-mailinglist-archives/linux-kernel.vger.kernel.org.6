Return-Path: <linux-kernel+bounces-411960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9931A9D01C0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583FA2827DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A18F54;
	Sun, 17 Nov 2024 00:46:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9287137E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731804366; cv=none; b=NzJVisUSts/mBE2990/XHi7+TZzS/M/kpF9DMff8f0VZ/bVn31YwRu11gSPSRt0UrcaqfYt1UtCvVUK0l9acdTb2fr6zgNgyH6WZUGZHJATwqIAtj6JRkxLONeVYKT99FHftxm2Z3Q7HfwkLdz6VYz46tcmlMoXNceBCbR5MhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731804366; c=relaxed/simple;
	bh=i52R9zRkzXv0E6Wi0DdZ6ZVrDquwSgkHuYwLyoGsbt0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BJjnh6YThsagfeF8bFNvkPfeiWYNo9wl0M9DwBfLDR2j3DEbqPYCoxDPjtn5o0t6AGa7c1pNktD37QCh02aRlO44d4dlaqpL8YBPhM/41abDTyPPoN8k2Dkz66l6/bEIl6eSyIBAvklCH0C7royx4z1srMzmi8Yl3C+J7ptnqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a75dd4b1f3so3801955ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731804364; x=1732409164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GyWLO6yzkcvcUEaHtbbEfe7VqlTXd1/z8RdjQQxL+I=;
        b=ZigcAI+dObs3X5P7m1XsrA/1dqQd0xxXbqeqLq9jCjCPruJpC+D2/r7TTMNRwyESu3
         RRVbzgdOK3D77Ov7JW47DGkQTt09keEYXRvwohItz9C6ZrFPESGAjQ2x50b6Fp5mDqsT
         qMM2HYUsmkKNtCuZbsExjzdqYkH9Qd5Z6tIVlrf3+gUawQoI5kcjbdaNredo7m1GTKFE
         UFtSXOd7qtKt8HAVWljPcU5ghAmRSdSd0G3WjCRzoNk5MFGBw1nYBDyeO38GiB6DrA5i
         lJ0vVDPvvUQTqhedfXSKIcJBEMiX9QXSSPNt4YjBT4RJdzrfthbzrLHaiDXNFnQ+/MWH
         RNhg==
X-Forwarded-Encrypted: i=1; AJvYcCV9x3RTt/0oShrvHZU5yi7O09p7mN6blwHG9J2enzriZFTQylgk44XUsvpj7oEjqElXmqmC9BYbv2In2Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5KYjRRPGggsb2dlZ6JxQ+wj4z6TYqVn0kDjr+HG4uglRb3nu
	4+PW0aHeS8N8kfbjdjoxG4OzLivQqNVxuXFcv/IOWjCV9MQDhnShlSZflOpkpjyB4bofYnLBMwE
	NyLwl0w+PChIPv4rPXaxmjYzYD3nkywaOYVvNQL74MaKWst1prKhN1XE=
X-Google-Smtp-Source: AGHT+IHD+uf7RFVZINrWw8g4SASIHWeHGthD3xG97B6FsiKGx8ePIo4u2Au2ot1TlVVuXNhQUUMD4vvWkUQJLL1c8FHcJI7RdX/s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca3:b0:3a7:2194:fd3d with SMTP id
 e9e14a558f8ab-3a748041fc6mr59599135ab.14.1731804364020; Sat, 16 Nov 2024
 16:46:04 -0800 (PST)
Date: Sat, 16 Nov 2024 16:46:03 -0800
In-Reply-To: <20241117002605.1398-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67393ccb.050a0220.e1c64.000b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in rcu_sync_dtor (2)
From: syzbot <syzbot+823cd0d24881f21ab9f1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rcu_sync_dtor

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6897 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Modules linked in:
CPU: 0 UID: 0 PID: 6897 Comm: kworker/0:6 Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: events destroy_super_work
RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Code: 74 19 e8 96 dd 00 00 43 0f b6 44 25 00 84 c0 0f 85 82 00 00 00 41 83 3f 00 75 1d 5b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 <0f> 0b 90 e9 66 ff ff ff 90 0f 0b 90 eb 89 90 0f 0b 90 eb dd 44 89
RSP: 0018:ffffc9000368fb30 EFLAGS: 00010246
RAX: 0000000000000002 RBX: 1ffff1100c693c77 RCX: ffff88802b3dbc00
RDX: 0000000000000000 RSI: ffffffff8c6038c0 RDI: ffff88806349e350
RBP: 000000000000020f R08: ffffffff820f0544 R09: 1ffffffff1cfbc21
R10: dffffc0000000000 R11: fffffbfff1cfbc22 R12: dffffc0000000000
R13: 1ffff1100c693c6a R14: ffff88806349e350 R15: ffff88806349e350
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555a3b4608 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
 destroy_super_work+0xef/0x130 fs/super.c:282
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         4a5df379 Merge tag 'mm-hotfixes-stable-2024-11-16-15-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cf9b5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b216897c3460507
dashboard link: https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11207130580000


