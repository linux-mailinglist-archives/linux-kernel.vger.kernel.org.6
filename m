Return-Path: <linux-kernel+bounces-305763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3349633F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F115282F75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5AC1AC43B;
	Wed, 28 Aug 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fFNf+cUi";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="lrGMo/YE"
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF215A85A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880844; cv=none; b=UelNZhSwsSkPQtn74aVaa7OKiiL6haFcuknTyjOacxwepY/SCL0Y5YzbuFLjd+Prr94h4WM8lOU1X1CjomCvnSw5qgXMUYQqfnU5zXa2Vr7apmnfiPR1bdJD+yFQVfNFYAEGReXghZqeQP9GG9B6nR/uzcQTrifOuAwq/QY4y2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880844; c=relaxed/simple;
	bh=A24ez11eeQu5EEqiADgBz6c9H40a8QZR49Fn7MtCuD0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R5xgMB6Gth/c4G+QCQvVlIU9jdgwBi+wEbbuRvAOnbcU8SYMbpNmMp4T8t5jaC2BygzWyL/LtLHU1xWeq8/gaHPnu8OpYI+YZhHe8KKo4LoaRjBvwhUqgEmzJosbfCnjqsFQwvyOTz1stb9yaxffC0ObqzKXNXGDvGDIUtKRJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=fFNf+cUi; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=lrGMo/YE; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724880842; x=1756416842;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=A24ez11eeQu5EEqiADgBz6c9H40a8QZR49Fn7MtCuD0=;
  b=fFNf+cUiCLlOcsz9ulUzNqDP3qgaDoFVoUnO6w7g4jrOBiiUwvM6YCek
   0K7CCgdIajZ2Z4AW+qCroPuTWEY/9natkRKNychsY3Fn9+7N0MMR6Y2XY
   vrxwn/9H2KefNdOMjwZB3UfSgDOgIUbmijrwqFOVHK+3MvBU7U0SxI/Ao
   XyHCy/2jaYOoMQvdTg5T5k840gyHfL8M0D8nmiOcjWVDoOo5crBzUGPEE
   8gTDpOwVXA7ue/UyCJAC4xHRVQ1BVJRoVaw9ZWtcH5NmsLdkaKKYxedgB
   24DzadmXpC0QEXpfzCgNRsvx0WvheFRqLIq6LgyGGpZZH3qpAKwrpHdZK
   Q==;
X-CSE-ConnectionGUID: gB4h2EVOQo6UfHccHljc1Q==
X-CSE-MsgGUID: OOkxpaIuTZqTrEcKLwelyQ==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 14:34:01 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d404e24c18so7611246a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724880841; x=1725485641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rz9rLYVmxrB/bF5hzSn4HlP2I3MxSlKdiEtL7jcUCXA=;
        b=lrGMo/YESD5UFGsVUh5N5QcB/79Skq8ertVC0WqrGGOx6Lu3xZWWEH2UHbNHF3dRDX
         6t83QR481FBKFSCNy3tfGIk2SGB9AWZc+J5ytyrSlVX3nbCOmxpqPh92Rs5ACy5YnKq7
         s4XgIkRA5cB4LyjYGeiYePkMq4rPkGklTfM1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880841; x=1725485641;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rz9rLYVmxrB/bF5hzSn4HlP2I3MxSlKdiEtL7jcUCXA=;
        b=ucAgLHImuW41tAov53DldK83h1uLAx8IBa9HXAe2M+EdOKO1cDoEDccHjIsdxyryUl
         kQcyZgtaqFs32arp5Q7J0sHjJ/Tt6t7hGzSwMSbGKnvu2lIbnynfIEVADs4eTq1+MG5Z
         Y8Z13tWoAWVKpU1gceDzSYco3jB3W14h0SDXb1xssBptiEkDb5Qg//IaVhQxOCDTkpwU
         SqUyt/jvQdT4vq/kgSiMcHk6sSBETw6jhtufWNLtUVylINkf1vscF9MOX8iFAxlkTrdV
         GSX1wmcxklXy2DmQZdPh1WSfezPuQoIQedpYOsUeGGjBx/bMpS0/5abag5RdlGQtKmm5
         U+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD+B3r0rVxDZw6RnvwYmL5exmtaWLf2QxrpllNrdlwGmAmYc06ndC9sScnQW9guTkowx0wtd97PLswnlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysu1C8RZ1V0umZu8BkzrWFoClYlflYdqlVUkCY+eZbhgAZNngc
	NJDMWXbZAXx4L9lq6V+y+0M7LQ+bVtEgdyetJiWVI+3WFNypKARu/C5KdzTHxl0+VXFfRBFE0I/
	KGq3NoexZUiB/po7GaKOGxWZ5bErhVT4iAydJrxmzu8Mr5XuQo8ULroxeTL8LKSy6L296Yao8Nx
	N2J3FmZ3iwM3jVMKwctbt6zB+KFObld0zKFMS6Dw==
X-Received: by 2002:a17:90a:5d88:b0:2c9:90f5:cfca with SMTP id 98e67ed59e1d1-2d8564b14c9mr635060a91.42.1724880841372;
        Wed, 28 Aug 2024 14:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELIxc9OT0s5uv9pNhhcmr1CIb5UZWR8xaYYn35lOMGFdUCzGQEkmCoJ0eqobT+k4N5M6igbYwacv+s5y3j4jI=
X-Received: by 2002:a17:90a:5d88:b0:2c9:90f5:cfca with SMTP id
 98e67ed59e1d1-2d8564b14c9mr635048a91.42.1724880841083; Wed, 28 Aug 2024
 14:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 14:33:50 -0700
Message-ID: <CALAgD-53TVoamuAc4m4cG2ZD=8jYiygwkp8DX0qb9Xhk-Qgvfg@mail.gmail.com>
Subject: BUG: WARNING in kernfs_get
To: Greg KH <gregkh@linuxfoundation.org>, tj@kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a logic bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

WARNING: CPU: 0 PID: 101468 at fs/kernfs/dir.c:526 kernfs_get+0x67/0x90
Modules linked in:
CPU: 0 PID: 101468 Comm: kworker/u4:19 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:kernfs_get+0x67/0x90 fs/kernfs/dir.c:526
Code: 62 ff 85 ed 74 1f e8 98 6d 62 ff 48 89 df be 04 00 00 00 e8 4b
7a c5 ff 3e ff 03 eb 05 e8 81 6d 62 ff 5b 5d c3 e8 79 6d 62 ff <0f> 0b
eb dd 89 d9 80 e1 07 80 c1 03 38 c1 7c bd 48 89 df e8 71 78
RSP: 0018:ffffc9000472f620 EFLAGS: 00010293
RAX: ffffffff822ee3e7 RBX: ffff888045e8bd20 RCX: ffff8880288dbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff822ee3bf R09: 1ffff11008bd17a4
R10: dffffc0000000000 R11: ffffed1008bd17a5 R12: ffff88802c90c750
R13: 1ffffffff18d3dd8 R14: ffffffff8c69eec0 R15: ffff888045e8bd20
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3842d62e0 CR3: 000000002444a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sysfs_remove_group+0x86/0x2c0 fs/sysfs/group.c:316
 sysfs_remove_groups+0x50/0xa0 fs/sysfs/group.c:343
 __kobject_del+0x84/0x300 lib/kobject.c:595
 kobject_cleanup+0x237/0x430 lib/kobject.c:680
 net_rx_queue_update_kobjects+0x527/0x5a0 net/core/net-sysfs.c:1174
 remove_queue_kobjects net/core/net-sysfs.c:1950 [inline]
 netdev_unregister_kobject+0x105/0x240 net/core/net-sysfs.c:2104
 unregister_netdevice_many_notify+0x11a3/0x16d0 net/core/dev.c:11249
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 default_device_exit_batch+0xa79/0xaf0 net/core/dev.c:11760
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x8ae/0xcd0 net/core/net_namespace.c:640
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

