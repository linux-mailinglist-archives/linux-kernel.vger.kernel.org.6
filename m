Return-Path: <linux-kernel+bounces-300601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3616895E5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6020E1C207BF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597D578C8B;
	Sun, 25 Aug 2024 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="o1TtzzTv";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="f2WWBpTU"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741A433A2
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724628064; cv=none; b=c+CJyH67RgFF7vzoPNwwHGHxMoZ5ZOJ5N0izHAP7Py1dYV9u66CQ5bMIKbnuR96k1O9LtmVP++GRNo1hRZXh/hX9PtIOgdpNBGhrcm2OSq2765qOfp8yU2kedPU5mb6Dpz6bkS3GTVRrmVguGV9Y288qDjtlng1cLD84yDqofac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724628064; c=relaxed/simple;
	bh=1VNAGTm6fbQNSCUOnwTE8QIc4ewRNI0DFeqM4Uk4wpU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B8SYGlmo28mEBI1jg5HSxssrg0poVNAs4KfOJa7tx/eB7e8Jr64AziC+EtB23+PahVRUbdKqZZjfx8XykIo8u0O2RDLz8ZhOADxVS/DQvX2GhfGoLUWfTxQrgqGv2sOFGo91THj9WkbINDYzFWBn6HPnTzZegACHLEffN0uLcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=o1TtzzTv; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=f2WWBpTU; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724628062; x=1756164062;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=1VNAGTm6fbQNSCUOnwTE8QIc4ewRNI0DFeqM4Uk4wpU=;
  b=o1TtzzTvlIWUTWDc/BNgEpeAq/WzKv3JbFuZeZV880kADcvu5L2BaLIn
   Ok9VB/5dtn2Jv3kJSliDMSzqv18ncIcp++pbxzK+jKrTvNaz8mDUG8fpq
   RhPnH/T8SlicjOd9mpxcmDqwubNDV+9tjp0UnFdIejy+8GqERHUfRH32q
   rVBNrHH8gSZK8XhgF13Dq14T+RwlhysLLJ2iMHfMYoXG746+JPgP0/Jmb
   Wk/hj47W0hS2ryqVFCwS//jYc+p0WkuHqzps7oJjFSzEeXscxI35gsoFt
   P9+ryfpzi5p6Zja5H4iYCVmf4hz//UYlBGnDXBz9wE8QQc1PyVmTpljJ6
   Q==;
X-CSE-ConnectionGUID: GKmNgyCrQk+YpCQ4K9cxrQ==
X-CSE-MsgGUID: ylIVwqNYTPq7TWVyPLGvhg==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Aug 2024 16:20:56 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f81da0972so422472839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724628055; x=1725232855; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPUvazXE2fywtWRlxIfFoyunQ8Q7NR8HXFyklc0KAbY=;
        b=f2WWBpTUg5GTnR6yULir5Co6u9WKfTPigKKOLyJD3FGx02uw/oMOq+eQdGfymX2bq2
         AUXeEhuw9NmYoo0t0M6G7RVWbu6LfqY6votu2fklLFPAI694dsTahpBc9Z5IdEd+MbLF
         k4R+ltTkhnphSWvqehbUVkFB8UvbLoEUii/Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724628055; x=1725232855;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPUvazXE2fywtWRlxIfFoyunQ8Q7NR8HXFyklc0KAbY=;
        b=xVcONuDndR4Woh/5zWYKxRQP8LJCPmOL57hfpI0ZBD0VAQMG315dlS+LL2ICMI/k/Q
         kvTbIQ5RMfyQJfA5ctEUl5fOygQyx0UlP57VDOlH42PO9Ze+/boqvGmyZt65ZPm20fiV
         WZRJF5jSpJWYe9szdfpPAhQr1tcSM5/c7QDuWfyB9MzLMMdQUfp14Y6jJzpJnWrZsfdH
         gelXvOYGjZ2e+465gV0MGNkHRcN8SOfDS0ThJpjLTJ135Mdia/qazzpEWA40WdObb/ch
         jjpBqiD7LQIjpLLt5zk+Cbo4TBYPyMk3wAF/eGTqvRdgaC9VvtZEd+WFEIGn+t5gLpy7
         bAVA==
X-Forwarded-Encrypted: i=1; AJvYcCVlrAYbzjlG08f+N7i6l0xl1n6JUtxkHfku0S0/pQD1CnJ+5zOso1ImATh2TWGqepwDMO0KNI7PuHZNBs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCq/U1Ba5ZGDv55i7MUhQtvpnRj1i25MYH2rqBu3kSu6UA/EQ
	wDvn4DV7rC54YW7uXxAi5fPFj4wvCIXyGxDsSN3HRHLC7wQ9MrzjXX1soHGeIelnMevSJgp1VZ/
	nDGDolb2FvXAwdWaZf1pczDekXPTgfsKmrSe8ghkv6o85N5e+nYn5IHXWR95JJ4aHq2UTs4YKI/
	BmbCuo/G39U5hFq4UuEQww/fR5mhxnCsxbOpLesg==
X-Received: by 2002:a05:6602:27ce:b0:7fa:a253:a1cc with SMTP id ca18e2360f4ac-827880fd100mr1195403039f.3.1724628055175;
        Sun, 25 Aug 2024 16:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7VPvLD8KeXlnIkq/E2sTFVUSlSL9FTZF3bm3dmH4+DOTxM8fY8LJvaLcTQabvFe2U49BHULnxJ/erq29g6Aw=
X-Received: by 2002:a05:6602:27ce:b0:7fa:a253:a1cc with SMTP id
 ca18e2360f4ac-827880fd100mr1195401339f.3.1724628054796; Sun, 25 Aug 2024
 16:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sun, 25 Aug 2024 16:20:43 -0700
Message-ID: <CANikGpcbOMa9mGroj2jK0s9Rk0zThyaixf3wQa0ZR-7oh-50Rg@mail.gmail.com>
Subject: BUG: WARNING: ODEBUG bug in sk_stop_timer
To: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `tipc_release`, an ODEBUG warning was triggered when executing
`sk_stop_timer(sk, &sk->sk_timer);`. It seems that the function was called
without checking whether `sk->sk_timer` is initialized.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object:
ffff8880254e10a0 object type: timer_list hint:
tipc_sk_timeout+0x0/0xab0
WARNING: CPU: 0 PID: 11 at lib/debugobjects.c:517
debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
Code: df e8 6e e9 95 fd 4c 8b 0b 48 c7 c7 a0 61 a9 8b 48 8b 74 24 08
48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 de 2c f7 fc 48 83 c4 08 <0f> 0b
ff 05 42 1e c6 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d
RSP: 0018:ffffc900000df6f8 EFLAGS: 00010282
RAX: 2f987b8e4002d300 RBX: ffffffff8b4ee740 RCX: ffff8880156dbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff9200001be7c
R10: dffffc0000000000 R11: fffff5200001be7d R12: 0000000000000000
R13: ffffffff8ba96248 R14: dffffc0000000000 R15: ffff8880254e10a0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc21fbbff8 CR3: 000000003a1e4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init+0x35f/0x420 lib/debugobjects.c:910
 debug_timer_assert_init kernel/time/timer.c:846 [inline]
 debug_assert_init kernel/time/timer.c:891 [inline]
 __timer_delete kernel/time/timer.c:1413 [inline]
 timer_delete+0x98/0x150 kernel/time/timer.c:1453
 del_timer include/linux/timer.h:202 [inline]
 sk_stop_timer+0x18/0x90 net/core/sock.c:3426
 tipc_release+0x75f/0x1610 net/tipc/socket.c:645
 __sock_release net/socket.c:659 [inline]
 sock_release+0x80/0x140 net/socket.c:687
 tipc_topsrv_stop net/tipc/topsrv.c:718 [inline]
 tipc_topsrv_exit_net+0x2b4/0x2f0 net/tipc/topsrv.c:730
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x810/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>

