Return-Path: <linux-kernel+bounces-266048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9EC93F9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6D41F22774
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3781598EE;
	Mon, 29 Jul 2024 15:48:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBCD81AB4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268112; cv=none; b=EATDNa8D9hnD/lbUAK7i07f7F7OaUx1uRwk4cokxd5a1YvHaSRYWF54YL9kI50CGfVVA5ev3MYW28RTUMJ/Jspd2t1M+biODMw1Z/s0P2REKgLOnBUAZONUg4LVE3nk8JGr11fpTOJ87FzexJo4PLDemM3LyMJYXO4KtmT0CjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268112; c=relaxed/simple;
	bh=rArEl4yIOqZ59InPwfhlc6msPLZe89qV0Yi2KY08dg8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EoBJ/2IHO0ty4fLfkSabhQyAypuQHeBqQg3BtoR4YSwjelv7c7Fv98JfqsZ7skDixLbrZNsEjn5uVTLdvw7J86VYc+3/5dT4L02Sm++z9QegTNX9L9ew2d1txy3pCQb0Erk+LVoNr8bGtdNXRqlWFgujPCf3p/ni8OuUuvF53ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso51945105ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268110; x=1722872910;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA8+++3yvb+eDXrAD85K2rueOWSInRZ1QvJmqWjrziA=;
        b=s3yPYtvSG7hsYGKhCiKqzOYt1ouh7VHSP5AVyLECzFYJGqpN53I/N5oT3QO5mv3nZl
         fNj+khrwxj3i++3DU8iFN1xjZx7i0Qn2Bg0xt8Blmv2J2sIJTCdzaJ1COGVdybq1Se2g
         z/crlE3fIrvYTaEJpiXEtMYqAtnm7TCiF8hBihYCSVbjOorcoQCRbINEj8eRh5oJuZ13
         1q7z/5cNQ/jeZ1Q690QB4KMyRg8Mm0juh/t9Vhj3vfDxMsIQItNNchcTZJEy23Cr46aJ
         24SEBjd1GP4SeFr+II1OMhogx3qSfSa97AA3iY+Y05Xx+8339OUFjMvFaSbE5ini6bQv
         AIGw==
X-Forwarded-Encrypted: i=1; AJvYcCUeR0TeBapLezuSC2f4/uvKj2B7N/uhoMPmFTxqnl+p4jWHRJH8bTbjFHlhowbETi1PJiha8+KjYhHz+bm5e89FIjHTTu20wqpJzYp6
X-Gm-Message-State: AOJu0YzWBrUznGNnFsq+gQe2uN13mWKLe56y9+/93Tq5d6WIselNxuN2
	3cTXZICDK+p/M67CptiN0Jj4fLuTWg0qxkOtAZ8LhNjJtbkD+AoBGbNTsHub9Be+kkL7PwC7z4F
	Lnovlr3xTwYm9FCf6bTOPZn+CPPoT+lrPVGJjmES3GoQuU/iRdh1H/0o=
X-Google-Smtp-Source: AGHT+IHSo09wEPx7at03BStfZ2VRmELGpqUvIeiTtyJ7I8yfxlluwu4vCJYFIp1cTivGqT3HGF2d7nhNOr3QXQdZ/XDZ2L3SbkNl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39aec2d773fmr5162965ab.2.1722268110131; Mon, 29 Jul 2024
 08:48:30 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:48:30 -0700
In-Reply-To: <00000000000061c0a106183499ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9a538061e64cae7@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, jason@zx2c4.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100341c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1022b573980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6699621c3baa/disk-dc1c8034.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22380dec726f/vmlinux-dc1c8034.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04c3f45e6e2d/bzImage-dc1c8034.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525 [inline]
WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 __kthread_bind kernel/kthread.c:538 [inline]
WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 kthread_unpark+0x16b/0x210 kernel/kthread.c:631
Modules linked in:
CPU: 0 UID: 0 PID: 53 Comm: kworker/u8:3 Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: netns cleanup_net

RIP: 0010:__kthread_bind_mask kernel/kthread.c:525 [inline]
RIP: 0010:__kthread_bind kernel/kthread.c:538 [inline]
RIP: 0010:kthread_unpark+0x16b/0x210 kernel/kthread.c:631
Code: 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 93 00 00 00 41 80 4d 03 04 4c 89 e7 48 8b 34 24 e8 ad f7 56 0a eb 09 e8 06 a0 33 00 90 <0f> 0b 90 48 89 ef be 08 00 00 00 e8 c5 b5 97 00 f0 80 65 00 fb 4c
RSP: 0018:ffffc90000bd7760 EFLAGS: 00010293

RAX: ffffffff815fe27a RBX: 0000000000000000 RCX: ffff888015f90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801fcd8200 R08: ffffffff815fe207 R09: 1ffffffff269d71e
R10: dffffc0000000000 R11: fffffbfff269d71f R12: 0000000000000001
R13: ffff888029c75a2c R14: 1ffff1100538eb45 R15: ffff888029c75a00
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc23f437d60 CR3: 000000007e72a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kthread_stop+0x17a/0x630 kernel/kthread.c:707
 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5793
 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10753
 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11889
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

