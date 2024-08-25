Return-Path: <linux-kernel+bounces-300305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD51595E223
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAA51C214E5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB93987D;
	Sun, 25 Aug 2024 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="I8+ioaGA";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Yna/wi60"
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506E2119
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724564000; cv=none; b=qMlDd1Fg8TV+dQo54OSzxJCB9XkOsvRcVhmSIedhPfyPvBwzhPb7x9g/Bce7M6XLUcO1I4dFakQful6CeQtjGxnrgrqNWKWBx8mPURl8q3XKbLUasP9+dTrtXkdD1z3rmN0hde8jKPolAUPxhOrKduFv7ZHes5MMO2M1uP0jQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724564000; c=relaxed/simple;
	bh=EOCSXyZT218qAO1UeMOmp12yLzkXAryhTOnz8Geycfo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CKn+B/Hbe46LQig2jxs0hGmrvU5YJRxcZsSGlwLXosQ1psWQGx4tvydEUts/b6buSWjZLxFgiTBXlexdTzVQ9nvGoS0vKXGXKMxVaS/wrYaOw3rtAn+oUycHuLXpO25SUlgGN45o/WfoQpIUidZGV/HIwWhkZQAjbcFcNLrtfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=I8+ioaGA; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Yna/wi60; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724563999; x=1756099999;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=EOCSXyZT218qAO1UeMOmp12yLzkXAryhTOnz8Geycfo=;
  b=I8+ioaGArEaBSsnqV2bY6IYuoWvoKbgddy09p7Yuj+ycQ2KJwNPBF7kC
   6/WlY/uxd7OUsmd3rOvvoowjP72BMN6x1isLs9BnXod7oJ2Smd4t9vgFK
   LLQr8OKtm0pgx/kppX6TYsxW8ofBHDHX0BkTROZUvYexGgqpPd+n225jH
   NQblX9dKJRPUFu4AmaZhNLUzCl+QUjpAXe/HcuuPODWFq8RweBPbfLCxW
   yb0jDtxgLX8JqV5dB6MbdkoI3YbZbgJnbTG9GA3chlEgTKu+sKEwAH3eS
   d0Vf7NnN1YRnX7WbpG4+cygyjtQ1nDizPizyU0c512gMaiSvEQ2O4Vxmu
   Q==;
X-CSE-ConnectionGUID: 8kz0/ruVQzurWbuDX1n2cQ==
X-CSE-MsgGUID: Nz/9l39uQGiC7xULRzq7vg==
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:33:18 -0700
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso2647953a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724563997; x=1725168797; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81qbK4w/0/NVzMoh9KxmefEpdC00iBBUA6bk15VL1Uk=;
        b=Yna/wi60sBZZk+rrUbliu/KhUUO9OABJ92uXPdkKTzlemlKhpCh/brGS1A32xQe3Ow
         1OdzUni8MmJg5kvUa4aKa6vMofHaI50yPeIiFQaEcxLy3QEcIeUeai9QJpmuSnhMOrK7
         nJYJJinKb56b3EcYaepTb5LMfr6CQQtt5BJ90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724563997; x=1725168797;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81qbK4w/0/NVzMoh9KxmefEpdC00iBBUA6bk15VL1Uk=;
        b=r1BE9pAhJyRX16G4sLzDcFOFHTtDhjIZBfWracuH/JAhWQ5RcUk2jUu5sUOCb1SugE
         COvsIUdN+F9Zi9vCyzWUDMA1uok6RkEF61sH4bcFYX71G4fiY3sttjrpofD7ML66cRFO
         57QbST6J6/DuYtXph8/QOHpb/EvXDuLXAOcMVnr1xMPXSd4nICeksvq0D6D1D3vdSEGf
         f2DZKcoWiNwMYxQ1m/DtoKRYwVUBeGPYYsGiCEt5ZoBh7d8uIKafjqhZp4x4BjjQpvQM
         9O7Xca9dV8GkcAv2JeSEjNsCXPgjCHESl1GN5XIcNeykEnUhSBvQzFXpbgrCFqb4pi4o
         DYhg==
X-Forwarded-Encrypted: i=1; AJvYcCVyqdbHn4KuYpgJNS/WzublMnH5WUbfS9iN+lQAPJRpjYoju25qYnt9+8YpzuqrGLF2t07H+ZlCvD42SoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKZSnWqN4FRJwvcbjLByuzofEW8dvqE/haDtV/0b22FSTNrMd
	+by3EkOk0xKqr/3OB/H7gibTamH41sQcad4+dMrmQI38xws/4DwSeMLAVhUfnQrQ9MsJ0vet2xo
	t8U4Ir7Mn/s/2W8uSa/wMEPodYRJThBxxL6Uo1oFouG66lIrp9uBUj8w6df4RL4BXjMBTeAM359
	Ywa6vq9Ot+r9/MD/PbgsHHehC5CrBtT+nrOABtPw==
X-Received: by 2002:a17:90b:4c8f:b0:2d3:c084:9d93 with SMTP id 98e67ed59e1d1-2d60a9c68b7mr17057812a91.14.1724563997607;
        Sat, 24 Aug 2024 22:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOz5BtxRhM1Wy6Kvlf2nQqXZu9uvOJejjKQo9nCtcWDm0nBcp0gDBM2k/xOd2AKVHP5EOw7deQCu9vr9OCIo4=
X-Received: by 2002:a17:90b:4c8f:b0:2d3:c084:9d93 with SMTP id
 98e67ed59e1d1-2d60a9c68b7mr17057799a91.14.1724563997274; Sat, 24 Aug 2024
 22:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:33:07 -0700
Message-ID: <CALAgD-75bQU3K2HPSJJo7ra9n2Y=S=WxYoUp8ikjB9TFo1Zh9A@mail.gmail.com>
Subject: WARNING: refcount bug in nsim_fib6_rt_nh_del
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10. It is probably a use-after-free bug.
When fib6_info_release(line 341 of include/net/ip6_fib.h) executes
"refcount_dec_and_test(&f6i->fib6_ref)", it is possible that f6i is
already free previously.

The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2
family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2
family 0 port 6081 - 0
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 8850 at lib/refcount.c:28
refcount_warn_saturate+0x13f/0x1a0 lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 8850 Comm: kworker/u4:11 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0x13f/0x1a0 lib/refcount.c:28
Code: 0a 01 48 c7 c7 40 fb a8 8b e8 5d b2 fe fc 0f 0b eb a9 e8 a4 63
3a fd c6 05 d5 3e b8 0a 01 48 c7 c7 a0 fb a8 8b e8 41 b2 fe fc <0f> 0b
eb 8d e8 88 63 3a fd c6 05 b6 3e b8 0a 01 48 c7 c7 e0 fa a8
RSP: 0018:ffffc90002bff668 EFLAGS: 00010246
RAX: de8053514f502200 RBX: ffff8880320bcc2c RCX: ffff8880231b0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: 0000000000000000
R13: dead000000000122 R14: ffff8880320bcc00 R15: ffff8880320bcc2c
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13fe745f40 CR3: 00000000413e6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 fib6_info_release include/net/ip6_fib.h:341 [inline]
 nsim_rt6_release drivers/net/netdevsim/fib.c:515 [inline]
 nsim_fib6_rt_nh_del+0x277/0x2a0 drivers/net/netdevsim/fib.c:534
 nsim_fib6_rt_destroy drivers/net/netdevsim/fib.c:583 [inline]
 nsim_fib6_rt_free drivers/net/netdevsim/fib.c:1069 [inline]
 nsim_fib_rt_free+0x4a4/0x7a0 drivers/net/netdevsim/fib.c:1082
 rhashtable_free_one lib/rhashtable.c:1113 [inline]
 rhashtable_free_and_destroy+0x5ab/0x910 lib/rhashtable.c:1164
 nsim_fib_destroy+0xb0/0x180 drivers/net/netdevsim/fib.c:1659
 nsim_dev_reload_destroy+0x2db/0x480 drivers/net/netdevsim/dev.c:1662
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

