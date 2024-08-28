Return-Path: <linux-kernel+bounces-305785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B0963453
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E121C23D36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52AB187862;
	Wed, 28 Aug 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jlENTj7g";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pkeOjn8F"
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A314A4D4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882627; cv=none; b=G6jUvEKSr1sf54Q+T9zpJvK1q6VeB+wBWZo5HwwefkVWaGW5sFsekqQaGk0Pg/R8rEhnM/b+eJjuO8HtwMkBa/9fK3OMShvE811wFHHrqBzCzWLqWFKiMiu88SjHz6GRyzWS6EJFzgOkOuTHwLBg5bNN1G5jYfNTKeEO5ZDK69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882627; c=relaxed/simple;
	bh=yc4opa4jlMvZORaTBxSefG6ckg7Y5G76WIcy9CRAjxQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TM+iA7krr0j2ljlZntEwBZ6i9ZUiFnQ5qeFfIOxz+gUFGh9JJe20ZZaX/OSeeqd7E4riqLOo9lAEL//ayW6+t8aVGvEPqrcTSK/hMuvg13w2xAlDhPvT6HN5c2qHV6TuBfHQQQAW5GOnsnqfDhtP1ttKosMXPzfF/riz+Szya9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jlENTj7g; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=pkeOjn8F; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724882625; x=1756418625;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=yc4opa4jlMvZORaTBxSefG6ckg7Y5G76WIcy9CRAjxQ=;
  b=jlENTj7gaEb1fDVi6435PSfnKTXSn1X1oeJZCjW70AtOOmVAtg3U50JA
   XlpTa3NV+jnsYoK6AUDUwGC+gxfWOWk9RSwryjuSUUBdzMfhrYmh9ne7I
   D489C92Xru018VhElTo954nUus2nTQNG+qQFEWXkxuEp4C9pKXos6JB0W
   PsFVVWzcfrtLDsH+CFJUO8uY7+TWENLqc0tNhDXYYqTXdnAvGZSOpHouO
   ZLTd2559aXShSQr37krzw/TxLArpXoLzKHWnBRbCl1uPQx7mq07Kcn4ki
   GMDs8txM6HdcbkIKNWJZM13Qvv+D6vxvXrCUkJNPfpqzGGxlk4F/GHOGs
   w==;
X-CSE-ConnectionGUID: c4Iy2Ep3SyW2PpPdUogMmQ==
X-CSE-MsgGUID: h2ThQAxuRcafPV0Utrtuig==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 15:03:45 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3b438c8c9so7650220a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724882624; x=1725487424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVSZz2hoPiR7sjXazJkCHkQi+Nbcimm2fYpFaxHOTiU=;
        b=pkeOjn8FF0Mn8QuocbStaAl5FprgxaUM8+mXPICYHWLoxbq8SQxtLzOtC0xlwHgwlv
         taaImbCGYEl68/z/yQjVecp/hnld3HTUqwXLqM6D6UmDw/Z+6kXwjcFgn1Swgyk3mX0R
         PzAKUH7LnFVWfMw9I4xyx5+kuAY3qynYRJTVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724882624; x=1725487424;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVSZz2hoPiR7sjXazJkCHkQi+Nbcimm2fYpFaxHOTiU=;
        b=hC+HiFM48DlgJ/vdKS2KTq7D9OJcjMXE9teHPbPfEC1pKb3hFAQAdxhWqI8ZwE08/n
         KmlV2UoE+VhrodMWcSzpTE4LdR1Eym/Gm1rxpNasz4j0tTDDiVxxrZGZYx7tksGSg7Pj
         K0xQs8gp18RZ1Tzqajon+ohmUAmkScRUXYOxSWTSBlpiaYAEjHtAnwuiPTEO7uoQEYlR
         NBPUPb8dkW071K5GaZmT2CXaY4FGT1y/1AIEO7Bg+VB6EMvSTDHhBpH5NcYsut5fXygu
         PEuTKmQ1M2cSbs6BfBCExV5a6uCFXmf2OHKeA+8zQpgrO85vsk0sY8rpl8eSKNWGDym4
         jeJg==
X-Forwarded-Encrypted: i=1; AJvYcCWgNz4mp87MbabvZ7Vnvou46s30OwV3IJFawkz4X3H24o4L3mRiMUC0o7kvxgQGIIkh+BEC1vgS1ASS+H0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cCH9g2rC7fVeRBAhHFsNXRPj/F5iwq/atm1apz0gFgPQG5hR
	e5og9eDHCF2DwaC3w6QxemlMm/nBJ+NG2eAv///7oCxZIxnb+VihCLB5DQMA5UcVssH5c6o+Kx4
	qmyMbe07KHvFn3EHn8proUHlf3gMK1kuuTpAvOV5pjUEbbptHfF28vY/eU86yZeZB6d+vODKp3n
	1WZNODamJ9FGdOTn1ZVs+rGBt5bp47CPFhzNKCq6bqb25sRwlmylA=
X-Received: by 2002:a17:90b:2701:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2d856392159mr777579a91.34.1724882623823;
        Wed, 28 Aug 2024 15:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjFUbN3dGO47ItBXQkAe4cFvBoqmTYjWMuvWSQuKxS3A6HaZaZ0lgQKl4pFflG/sWBQ6LaBf1ctu0C1ftyAq8=
X-Received: by 2002:a17:90b:2701:b0:2c8:53be:fa21 with SMTP id
 98e67ed59e1d1-2d856392159mr777558a91.34.1724882623536; Wed, 28 Aug 2024
 15:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 15:03:33 -0700
Message-ID: <CALAgD-5uYCK+Y5N431CwLXeN0ahJtUde+CovAYexVZyNqDBSqw@mail.gmail.com>
Subject: BUG: WARNING in __kernfs_remove
To: Greg KH <gregkh@linuxfoundation.org>, tj@kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a logic bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

team0 (unregistering): Port device team_slave_0 removed
netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2
family 0 port 6081 - 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1090 at fs/kernfs/dir.c:41
__kernfs_remove+0x2a6/0x830 fs/kernfs/dir.c:1470
Modules linked in:
CPU: 0 PID: 1090 Comm: kworker/u4:8 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:kernfs_active fs/kernfs/dir.c:41 [inline]
RIP: 0010:__kernfs_remove+0x2a6/0x830 fs/kernfs/dir.c:1470
Code: 80 eb 05 e8 4c 09 62 ff 4c 89 ff 4c 89 ee e8 b1 ec ff ff 48 85
c0 74 78 49 89 c7 e8 34 09 62 ff e9 be fe ff ff e8 2a 09 62 ff <0f> 0b
e9 75 ff ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c c4 fe ff ff
RSP: 0000:ffffc9000481f2b0 EFLAGS: 00010293
RAX: ffffffff822f4836 RBX: dffffc0000000000 RCX: ffff88801d2d9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff822f479e R09: 1ffff11003d63dc2
R10: dffffc0000000000 R11: ffffed1003d63dc3 R12: 0000000000000148
R13: ffff888028e864b0 R14: 1ffffffff1e4922d R15: ffff888026446c30
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7b38efb90 CR3: 000000001eb3e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_remove+0x76/0x90 fs/kernfs/dir.c:1528
 sysfs_remove_group+0x233/0x2c0 fs/sysfs/group.c:321
 sysfs_remove_groups+0x50/0xa0 fs/sysfs/group.c:343
 device_remove_groups drivers/base/core.c:2833 [inline]
 device_remove_attrs+0x1d8/0x290 drivers/base/core.c:2963
 device_del+0x512/0x940 drivers/base/core.c:3867
 unregister_netdevice_many_notify+0x11a3/0x16d0 net/core/dev.c:11249
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x2ff/0x370 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 nsim_destroy+0x17c/0x5b0 drivers/net/netdevsim/netdev.c:778
 __nsim_dev_port_del+0x14a/0x1b0 drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x282/0x480 drivers/net/netdevsim/dev.c:1658
 nsim_dev_reload_down+0x93/0xc0 drivers/net/netdevsim/dev.c:965
 devlink_reload+0x188/0x840 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1ee/0x440 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:163 [inline]
 cleanup_net+0x61e/0xcd0 net/core/net_namespace.c:620
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>


-- 
Yours sincerely,
Xingyu

