Return-Path: <linux-kernel+bounces-320056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C89705AD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA3C1F21ED5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6BE7DA94;
	Sun,  8 Sep 2024 08:12:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E664B5C1
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725783148; cv=none; b=D+UQUhwX/AQVbT6X3ot0cwQ9FC6+p38c92UXkd4OglcCz+vEwm/xga2FhfCc9dR3R6OJGX6tigULIpGLBzoMIRXRBDITGJfBIq/ojHkVxy1K+Bk4h26i0g6PMLEVlbROUZPAkEWqEfdnF42gf0vG5hsD4Clac6oSi20dgh6MLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725783148; c=relaxed/simple;
	bh=kyePYKOFDQL+5mXF1w2Q/Uxe3QCbgrcrKYOqYih5jes=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iVRdiLUvs4gvgJENhRevmwnEV1G1RLRzJs2DtQB9DkQWhCVl/teKqXft9Eu1pJd9w1/52K0St6xbs8rhtSHBTEloGghAmtDcR+zyy/lk42jQHUTJv+Rp7mUAZiqGXTGKuZo454mukiYYh18vupGemSiKHcViofohpyPsLtB1CgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so57397815ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 01:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725783146; x=1726387946;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6zkXL6M85HDpU3e6kg1bEucVPuZexPj9yvmKku646o=;
        b=PP6aMUuUVYxDME17YLtAptLT9+A0UZh0uBLLCqcjMNBVci9BZcBYNQ8oWwYpliXr4L
         dQNmDmqfQIt0Fz00bVOdGa6K+WcmcMQhsspRZSv4znK2w/9aIHYALVDc8Cch7u5youpN
         1oFK5NejnsNItcWZQdCL/VkbbPxB3358BxNRrbJGJVl92I16UQKlKKQTi0kI1aGtsMaf
         c+on4nh57k6R3lhxhbrVZdnmyI1hAt3Yzmu4AAInJiFWOyMJpVf5llB946jXzNaWpXMm
         iRfjbxc8KL+71N7XFy/Wo34rx7JUjGcduEwk0FrV4jYSQiTEfRkUBIlO2FoZcfXOiQt0
         +32A==
X-Forwarded-Encrypted: i=1; AJvYcCXWWngjeq7fHSyC9GND1UZLfGhFyT9tSXQAXVcb0PwCW9krQ4aUUYppRX2fc666U/mlY+v5qizCjunuexk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymB8mbI9X+m7xVV2MlCoJhx7HPN5LmyikaRNJo1XjaMXn/2FpM
	igikywHWpceuQAPJFHXLVG82EOmYFdl1DN7rJsXmBnaSxToJ0i/eI90tVQ0h0EmP4iuOJ7DR04k
	8InPciN2wNeYHEYzOCPgBplfyfwuy5G4vCs2TI69gtxsiInypU4uigbY=
X-Google-Smtp-Source: AGHT+IHX5E7ARNZRNjQXWYsaEFPDYFA+o52IjvnN2dB/X4I6GJJk0W9cIok9iF3h7hLu9LoRvCdYKyZXiGmxhlTCEaTs05iLRDNa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1386:b0:381:40be:4ce6 with SMTP id
 e9e14a558f8ab-3a04f09be4cmr98368985ab.11.1725783145775; Sun, 08 Sep 2024
 01:12:25 -0700 (PDT)
Date: Sun, 08 Sep 2024 01:12:25 -0700
In-Reply-To: <0000000000000311430620013217@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d1b320621973380@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    df54f4a16f82 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12bdabc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1798589f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a30e00580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa2eb06e0aea/disk-df54f4a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14728733d385/vmlinux-df54f4a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99816271407d/Image-df54f4a1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc5-syzkaller-gdf54f4a16f82 #0 Not tainted
------------------------------------------------------
syz-executor272/6388 is trying to acquire lock:
ffff8000923b6ce8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79

but task is already holding lock:
ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       smc_switch_to_fallback+0x48/0xa80 net/smc/af_smc.c:902
       smc_sendmsg+0xfc/0x9f8 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       __sys_sendto+0x374/0x4f4 net/socket.c:2204
       __do_sys_sendto net/socket.c:2216 [inline]
       __se_sys_sendto net/socket.c:2212 [inline]
       __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2212
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested net/core/sock.c:3543 [inline]
       lock_sock include/net/sock.h:1607 [inline]
       sockopt_lock_sock+0x88/0x148 net/core/sock.c:1061
       do_ip_setsockopt+0x1438/0x346c net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
       raw_setsockopt+0x100/0x294 net/ipv4/raw.c:845
       sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
       do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
       __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
       lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
       do_ip_setsockopt+0xe8c/0x346c net/ipv4/ip_sockglue.c:1077
       ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
       tcp_setsockopt+0xcc/0xe8 net/ipv4/tcp.c:3768
       sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
       smc_setsockopt+0x204/0x10fc net/smc/af_smc.c:3072
       do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
       __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor272/6388:
 #0: ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064

stack backtrace:
CPU: 1 UID: 0 PID: 6388 Comm: syz-executor272 Not tainted 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2059
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
 __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
 do_ip_setsockopt+0xe8c/0x346c net/ipv4/ip_sockglue.c:1077
 ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
 tcp_setsockopt+0xcc/0xe8 net/ipv4/tcp.c:3768
 sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
 smc_setsockopt+0x204/0x10fc net/smc/af_smc.c:3072
 do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
 __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

