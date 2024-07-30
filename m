Return-Path: <linux-kernel+bounces-267344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2A2941082
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8E3B23D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A119E7E0;
	Tue, 30 Jul 2024 11:31:00 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879D187340
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339059; cv=none; b=leO3bejvNcijc0uUqB2rCb8W1NilaanjXun6MJTAcrgcADnQx8OntK+UdMSb59fOg6W7qjRAq/sAP8RRqPb163HfPz4qByhmSTJ/BhzIUBzHwqjNFew0MESjj6mfEI8Me06S3VD8bStMIF2x2r0Bc+6IVYCwfzDdLDt2KPjF4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339059; c=relaxed/simple;
	bh=7by8ITos4+QAaUPN5cD7CLTjQgm2N0ZFHxPolUlmbz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ix9YyiJviugR2xiLGQTh0XLqRLLPQRSpcyyU6K4Z3LXLXYf6zwZGnb3AGbIUm67vbA/zVssHbTVSCCZRzWpRMImvnfMYQJBB8zBxxeIZuQ2tGRFYgqiJ0QiMsP5owcfIkdk8M9ohmHa7Kj74jewAmxgzp0bYOxDCQEvd7F/bm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.37])
	by sina.com (10.185.250.21) with ESMTP
	id 66A8CEDB00000E91; Tue, 30 Jul 2024 19:30:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1080953408335
X-SMAIL-UIID: 94CEDC4AAA844D50B4A4EC9F1046FD97-20240730-193038-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
Cc: Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
Date: Tue, 30 Jul 2024 19:30:26 +0800
Message-Id: <20240730113026.2365-1-hdanton@sina.com>
In-Reply-To: <000000000000e9a538061e64cae7@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 08:48:30 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=100341c9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
> dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1022b573980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6699621c3baa/disk-dc1c8034.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/22380dec726f/vmlinux-dc1c8034.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/04c3f45e6e2d/bzImage-dc1c8034.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525 [inline]
> WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 __kthread_bind kernel/kthread.c:538 [inline]
> WARNING: CPU: 0 PID: 53 at kernel/kthread.c:525 kthread_unpark+0x16b/0x210 kernel/kthread.c:631

This warning looks bogus to me since a running workqueue rescuer could not
have a state with TASK_PARKED set.

> Modules linked in:
> CPU: 0 UID: 0 PID: 53 Comm: kworker/u8:3 Not tainted 6.11.0-rc1-syzkaller-00004-gdc1c8034e31b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> Workqueue: netns cleanup_net
> 
> RIP: 0010:__kthread_bind_mask kernel/kthread.c:525 [inline]
> RIP: 0010:__kthread_bind kernel/kthread.c:538 [inline]
> RIP: 0010:kthread_unpark+0x16b/0x210 kernel/kthread.c:631
> Code: 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 93 00 00 00 41 80 4d 03 04 4c 89 e7 48 8b 34 24 e8 ad f7 56 0a eb 09 e8 06 a0 33 00 90 <0f> 0b 90 48 89 ef be 08 00 00 00 e8 c5 b5 97 00 f0 80 65 00 fb 4c
> RSP: 0018:ffffc90000bd7760 EFLAGS: 00010293
> 
> RAX: ffffffff815fe27a RBX: 0000000000000000 RCX: ffff888015f90000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88801fcd8200 R08: ffffffff815fe207 R09: 1ffffffff269d71e
> R10: dffffc0000000000 R11: fffffbfff269d71f R12: 0000000000000001
> R13: ffff888029c75a2c R14: 1ffff1100538eb45 R15: ffff888029c75a00
> FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc23f437d60 CR3: 000000007e72a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kthread_stop+0x17a/0x630 kernel/kthread.c:707
>  destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5793
>  wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
>  netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10753
>  default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11889
>  ops_exit_list net/core/net_namespace.c:178 [inline]
>  cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>

