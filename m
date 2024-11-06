Return-Path: <linux-kernel+bounces-398654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC409BF439
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411DC2848A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419522064FF;
	Wed,  6 Nov 2024 17:21:51 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106E190667
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913710; cv=none; b=qbiKN7PmqNy/Z1imKAneePV/N3OOTM/XSWcGjrL/0M8sVYyuVuKCf24rFo0/Can5pdvjTHs5IoupO1xXwgKsJO4KD123lbqcsVzUq9Z4BbGZmAzHkykAT7oIKToJ95iK8DXscrTFluCdfbzsoL/EoxhqEyjN1ASeSjXfPTVNr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913710; c=relaxed/simple;
	bh=biHtMpgOM2mp0eq4vFc1eJ1pO9ucSrFLczTkH68Lv1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LcFkZc5WzMV3aScb6jn4CRV5DdC8XH3OJJQW+6YYXuuVweiMTnel+Rcd/7fHDQUQYXodq55aOkBezdjxKQqTP5i6ILkBHIf+/tLRTqwWsKYr9IZ0ANiomKrjk+rn8U7C78QOMmZHBVrK2j9KLyvSa2iQwgHVIq9jfMZVfpVyLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aecd993faso99063539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730913708; x=1731518508;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bk09z7FHiyX2Z7MKYXieal7kpPgKLXHK3UI85PDA+BY=;
        b=D5tp+RcdYDSgkV0MQhQ2gZDBlQISgvlgg46xHdrSBnMUdevnxPnmExv98YC5IhbN0M
         cIjFb/6qvjaDAHDZ/GDCAjgZB7KQ1Y5VzEFmUxLcXvxuV3uUPzOUE9dIXnL+BBh3HCI+
         QqXlObjIq0rq/jAugByinMw0Z5D3bSkkYuO4vs0x23l+OzPpUsOkK9+49Ina3moud5Hv
         uUodf6Mx58WAYRwwmLR1GHTmRfKX/I2LUH6v8Krxi8lTq32Yk1QIQJmtrdxeo36/aZ1E
         7Rx0wMpfdP7d0namAAQiQ2K7iC22hHmnRNM00/889Xt58/xTe4eRI+oZ72j5kH2P1HmS
         Sf4w==
X-Gm-Message-State: AOJu0YwZilhRHMG8Xy8cJ+pjgTh6hbaFI5VnlKAKDRGuurx1JPG3CrN4
	snkSu58e6dJBVaQnnI9679auKarRWFD9pYAO0VxII1phHOLFcjxcyMygY9QEbkhgCYH2vzvMumk
	lnKKuzJ4D8alY/4xfS0RotIyS19hNX9eSNFFv/+8HjHRDjR8Btm+6CtU=
X-Google-Smtp-Source: AGHT+IHonsbEwcMByV2AvceZ7hffLJb0eMaX/1iaRgy+sV+ReiDvvkiEj09FdJQ+QZRh5u3ZPh6NiojVVfrrHuAGu8DaPW8Ulor2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d251:0:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a6e2a96369mr23056025ab.12.1730913708233; Wed, 06 Nov 2024
 09:21:48 -0800 (PST)
Date: Wed, 06 Nov 2024 09:21:48 -0800
In-Reply-To: <0000000000005423e30621f745ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ba5ac.050a0220.49393.016b.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] WARNING in l2tp_exit_net
From: syzbot <syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] WARNING in l2tp_exit_net
Author: jchapman@katalix.com

On 06/11/2024 06:00, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ccb35037c48a Merge branch 'net-lan969x-add-vcap-functional..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16674f40580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
> dashboard link: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136a36a7980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4c339ec95c42/disk-ccb35037.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/328f6f24277e/vmlinux-ccb35037.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0473d4109fcb/bzImage-ccb35037.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
> 
> bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
> bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
> bond0 (unregistering): Released all slaves
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1153 at net/l2tp/l2tp_core.c:1881 l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
> Modules linked in:
> CPU: 1 UID: 0 PID: 1153 Comm: kworker/u8:5 Not tainted 6.12.0-rc5-syzkaller-01164-gccb35037c48a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: netns cleanup_net
> RIP: 0010:l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
> Code: 0f 0b 90 e9 3b ff ff ff e8 b8 31 a5 f6 eb 05 e8 b1 31 a5 f6 90 0f 0b 90 e9 7a ff ff ff e8 a3 31 a5 f6 eb 05 e8 9c 31 a5 f6 90 <0f> 0b 90 eb b5 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90004177a98 EFLAGS: 00010293
> RAX: ffffffff8aefa87d RBX: ffff888076669088 RCX: ffff8880277abc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
> RBP: ffffc90004177bb0 R08: ffffffff8bc11bb6 R09: 1ffffffff203a5d5
> R10: dffffc0000000000 R11: fffffbfff203a5d6 R12: dffffc0000000000
> R13: 1ffffffff1fdb678 R14: ffff888076669130 R15: ffff888076669040
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffca636d388 CR3: 0000000026e10000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ops_exit_list net/core/net_namespace.c:173 [inline]
>   cleanup_net+0x802/0xcc0 net/core/net_namespace.c:633
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>

Attaching patch for testing.

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 
ccb35037c48a


