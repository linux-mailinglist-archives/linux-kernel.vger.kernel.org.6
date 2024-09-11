Return-Path: <linux-kernel+bounces-324841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F2975170
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42461F21D32
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067F187338;
	Wed, 11 Sep 2024 12:07:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9773477
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056426; cv=none; b=HrFxZwf/ImpXdsK8Ay8TplgVulpFe1L4mJHlv5MhhN6xixTUnE75coMwlP+tWdL18Go45SABKrrPhW+7YKmtoqq3edWiRxh27R1oyfKMQm9nN8C04mfQTof3HRA0J8mROj6DCZMuG3Bwssqu0O4U7x7Q9Rx/yU3O+nY3EIEKx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056426; c=relaxed/simple;
	bh=v8Q1OGIReAuJGzkId1S2Yrl3KlsyTGWyUXhEaYTtOII=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q/K/JZLe00QOlZ+5qEAlYF3tux6fiEqhamiu1K8kmu4h+wKqjphZp8GE05oCq9cf6DfOhr+9iTDqmfM93Ye7GZ327c8/I60vv3FT12gLt6NeziJPEqXvsicI2HcM1jKDaGXhtt9SpwJoYhX3tVRX62Of++JYSSVwE/tlIt3dCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a05009b331so99279175ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726056424; x=1726661224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Oxphr+gNt1K1c76eZ5YGXb601LMMomDshX7mZKvlvU=;
        b=UZJBhJkfd7I08ZaOAS3aHQbEdZBY3Sp3To55xfaj2zZyyas5YFrx+/4NhcJcASnyOM
         YdtJ5M2es+73fKCOpJnyzbNxWA5+kpzIpiCtbVafcb4WcP1uS3dw0yWslQ9CJDI2O2ec
         swvcZFclEcZQV/e8+H7qwvcY2sfPg/2ACx8QWk2Rnuj7MFhgs88JUhjWLhurcvq005wl
         I7j1Kh9TTLIPh/n1MBcUoFHyWpKDP/gek+wcpQrAxstLfOkD/bpkL0aEQxb8AK6E4533
         TMRHiljXp/oOWM1vbBUTtO4NorOoYzWcXRfllwSQsExzAE+/X7LdQkbnTZDrqgYIMbpw
         ig8w==
X-Forwarded-Encrypted: i=1; AJvYcCU3k7hgjAFzp6doqLc+mbQEqg6s/1vzjKipEPGVovh2g25L1endlm/LhmDh2qQxYGuJS/90PoxjVbv4TrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFsj/h01aNX+TGuilRb4+tXti9tsS0C3NYj9TXFFBbIuDOeFA
	QTNjvi2xvU17k93gv8MOLP/T0ZS7jbsWsVfjz2yij5sG6WKw5rZ325Y5dPHuy1BOhwH6UOJKfB3
	Ceu58QF8fHBG1p4WcAZVSWWkqHrJWetrXG/rIgoPB8wS3I0/B359A60s=
X-Google-Smtp-Source: AGHT+IGKQF11kIL+ayjL3Lk4NAxuzcHXjKqKfek+h+FnrJ5XVAJBNT3sA5k987Qe1EWN8/IV4seoq45bJj+NJU7jmBqUuEKCluhM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c267:0:b0:396:e8b8:88d with SMTP id
 e9e14a558f8ab-3a056868be5mr162674575ab.11.1726056423715; Wed, 11 Sep 2024
 05:07:03 -0700 (PDT)
Date: Wed, 11 Sep 2024 05:07:03 -0700
In-Reply-To: <6631d99a-2dda-454d-8b55-5c207754c8a8@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffb1f10621d6d3b0@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in rtnl_lock

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc7-syzkaller-g7e3e2c7f05cd-dirty #0 Not tainted
------------------------------------------------------
syz.0.15/7317 is trying to acquire lock:
ffff8000923b7ea8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79

but task is already holding lock:
ffff0000d4798a58 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064

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

1 lock held by syz.0.15/7317:
 #0: ffff0000d4798a58 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064

stack backtrace:
CPU: 1 UID: 0 PID: 7317 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-g7e3e2c7f05cd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
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


Tested on:

commit:         7e3e2c7f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13b56100580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921accd5d8340211
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16856100580000


