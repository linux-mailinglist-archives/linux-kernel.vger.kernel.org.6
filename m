Return-Path: <linux-kernel+bounces-324511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FE974D88
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825D1B2692C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4316DC33;
	Wed, 11 Sep 2024 08:52:03 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6214A606
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044723; cv=none; b=jnAfeWOgQw2GZV8yaD5Uv4iBXo6iM0+9sFLrNOZkli/fsQeQX5kjdujUbLDRYDYWnDpOt5mxmF5Xghbjl3iEOyMqRMC31OUI4GSYrHHW1A/rQjjVIJ+U42pOq+Qhj0y69ekB5o1SgY7vnm0++uu1geWpAnrSXbpM2A2Ou0b1AuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044723; c=relaxed/simple;
	bh=a2EDQYK1jSazRqYGC2e+e2eOzdT6VybByATT4QIAlWY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c46vI9R2Lz9v+lfh7nBNZodA4v9bKRDt2S/dFcjQWfY1s6qN75skORawnSvZaMUUJaO4htp/C1TvJ6+cqGKcQnxCQF7sx2MyP83HHjKF2zq/otbhH1Yk6mXjmSiPFkJF5R2K0EEqOTBi/zq3IsJMtEJuqjD3NJrWZfgt+u5C7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82be60b9809so125139339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044720; x=1726649520;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUQSq6WranqYb1DAnWkCL8GW6z2xk01BvFyRuTzmA+w=;
        b=R40w3y5G8knj2czBHrxQZXZ9Xl4L8NYdlJlR9R9rh2K5duurgbeicjlu//ShnmcVS0
         pevmEV8Mpa+8Ozt2tK4zrQWJHZSy8Xl/W94seyLezNeRZ3OZ+U5acZlWQRQSjw38oAlP
         ocAI/Rh/tXevg4xBSa0CRYIbqdkSl/vKbuFgoNoSFxcfwS1/HOsxkTJzOh6flKM+Nzw1
         NxOBRYya+7WjHzygfCf1oeFiSXRxbtj97Jem0k9auLBc9PQsWm4B8VbB5DOzeUmCSdta
         rD3u7SW+1KSMgqALCBS6vOsF328O6Caw0W7hxHO/6Ar3ucr4zlZqDOFZHhDY9vHPvehB
         6/DQ==
X-Gm-Message-State: AOJu0YwmaPvquqe89fGXnbwEUB1H+zx5FI+6Uszfiy4o81pTVLzqdQ5T
	jTvXB+JeKFqWGD5TFF4nF7B9yag1tg0OoMJMqfJcbF96/MWVTd9vyT+fuPTByrB3Jxyh96SkT8U
	Vt5SXBzgxwbS/DA4PdiBQ2FaEPMDaPnl4iOc5vs1pjzye1qHeZVzcYoI=
X-Google-Smtp-Source: AGHT+IF9A4QJiR7q9ROxBV3FmdXO1hr0zYJtqFJZ7LwqVNnf12C9kc0aLlvBFyreMES1Crfzu50QvAohQAVdK8SqK301e8GiIaul
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1847:b0:39f:74f9:f698 with SMTP id
 e9e14a558f8ab-3a04f0761d8mr75853395ab.2.1726044720142; Wed, 11 Sep 2024
 01:52:00 -0700 (PDT)
Date: Wed, 11 Sep 2024 01:52:00 -0700
In-Reply-To: <0000000000000311430620013217@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006930620621d41a0f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
Author: alibuda@linux.alibaba.com



On 8/19/24 11:49 AM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1fb918967b56 Merge tag 'for-6.11-rc3-tag' of git://git.ke=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D129dd7d998000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D804764788c030=
71f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D51cf7cc5f9ffc10=
06ef2
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/3=
84ffdcca292/non_bootable_disk-1fb91896.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7b8fac7b5b8b/vmlinu=
x-1fb91896.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/676950a147e6/I=
mage-1fb91896.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0 Not tainted
> ------------------------------------------------------
> syz.0.5481/17612 is trying to acquire lock:
> ffff8000880033a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28 net/co=
re/rtnetlink.c:79
>
> but task is already holding lock:
> ffff000010332b50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsoc=
kopt+0xd8/0xcec net/smc/af_smc.c:3064
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
>         __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>         __mutex_lock+0x134/0x840 kernel/locking/mutex.c:752
>         mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:804
>         smc_switch_to_fallback+0x34/0x80c net/smc/af_smc.c:902
>         smc_sendmsg+0xe4/0x8f8 net/smc/af_smc.c:2779
>         sock_sendmsg_nosec net/socket.c:730 [inline]
>         __sock_sendmsg+0xc8/0x168 net/socket.c:745
>         __sys_sendto+0x1a8/0x254 net/socket.c:2204
>         __do_sys_sendto net/socket.c:2216 [inline]
>         __se_sys_sendto net/socket.c:2212 [inline]
>         __arm64_sys_sendto+0xc0/0x134 net/socket.c:2212
>         __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>         invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
>         el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c=
:132
>         do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
>         el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
>         el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c=
:730
>         el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
> -> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
>         lock_sock_nested+0x38/0xe8 net/core/sock.c:3543
>         lock_sock include/net/sock.h:1607 [inline]
>         sockopt_lock_sock net/core/sock.c:1061 [inline]
>         sockopt_lock_sock+0x58/0x74 net/core/sock.c:1052
>         do_ip_setsockopt+0xe0/0x2358 net/ipv4/ip_sockglue.c:1078
>         ip_setsockopt+0x34/0x9c net/ipv4/ip_sockglue.c:1417
>         raw_setsockopt+0x7c/0x2e0 net/ipv4/raw.c:845
>         sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
>         do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
>         __sys_setsockopt+0xdc/0x178 net/socket.c:2347
>         __do_sys_setsockopt net/socket.c:2356 [inline]
>         __se_sys_setsockopt net/socket.c:2353 [inline]
>         __arm64_sys_setsockopt+0xa4/0x100 net/socket.c:2353
>         __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>         invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
>         el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c=
:132
>         do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
>         el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
>         el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c=
:730
>         el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
> -> #0 (rtnl_mutex){+.+.}-{3:3}:
>         check_prev_add kernel/locking/lockdep.c:3133 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>         validate_chain kernel/locking/lockdep.c:3868 [inline]
>         __lock_acquire+0x2aa4/0x6340 kernel/locking/lockdep.c:5142
>         lock_acquire kernel/locking/lockdep.c:5759 [inline]
>         lock_acquire+0x48c/0x7a4 kernel/locking/lockdep.c:5724
>         __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>         __mutex_lock+0x134/0x840 kernel/locking/mutex.c:752
>         mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:804
>         rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:79
>         do_ipv6_setsockopt+0x1a04/0x3814 net/ipv6/ipv6_sockglue.c:566
>         ipv6_setsockopt+0xc8/0x140 net/ipv6/ipv6_sockglue.c:993
>         tcp_setsockopt+0x90/0xcc net/ipv4/tcp.c:3768
>         sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
>         smc_setsockopt+0x150/0xcec net/smc/af_smc.c:3072
>         do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
>         __sys_setsockopt+0xdc/0x178 net/socket.c:2347
>         __do_sys_setsockopt net/socket.c:2356 [inline]
>         __se_sys_setsockopt net/socket.c:2353 [inline]
>         __arm64_sys_setsockopt+0xa4/0x100 net/socket.c:2353
>         __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>         invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
>         el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c=
:132
>         do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
>         el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
>         el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c=
:730
>         el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
> other info that might help us debug this:
>
> Chain exists of:
>    rtnl_mutex --> sk_lock-AF_INET --> &smc->clcsock_release_lock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&smc->clcsock_release_lock);
>                                 lock(sk_lock-AF_INET);
>                                 lock(&smc->clcsock_release_lock);
>    lock(rtnl_mutex);
>
>   *** DEADLOCK ***
>
> 1 lock held by syz.0.5481/17612:
>   #0: ffff000010332b50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_=
setsockopt+0xd8/0xcec net/smc/af_smc.c:3064
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 17612 Comm: syz.0.5481 Not tainted 6.11.0-rc3-syzkalle=
r-00066-g1fb918967b56 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>   dump_backtrace+0x9c/0x11c arch/arm64/kernel/stacktrace.c:317
>   show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
>   __dump_stack lib/dump_stack.c:93 [inline]
>   dump_stack_lvl+0xa4/0xf4 lib/dump_stack.c:119
>   dump_stack+0x1c/0x28 lib/dump_stack.c:128
>   print_circular_bug+0x420/0x6f8 kernel/locking/lockdep.c:2059
>   check_noncircular+0x2dc/0x364 kernel/locking/lockdep.c:2186
>   check_prev_add kernel/locking/lockdep.c:3133 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>   validate_chain kernel/locking/lockdep.c:3868 [inline]
>   __lock_acquire+0x2aa4/0x6340 kernel/locking/lockdep.c:5142
>   lock_acquire kernel/locking/lockdep.c:5759 [inline]
>   lock_acquire+0x48c/0x7a4 kernel/locking/lockdep.c:5724
>   __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>   __mutex_lock+0x134/0x840 kernel/locking/mutex.c:752
>   mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:804
>   rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:79
>   do_ipv6_setsockopt+0x1a04/0x3814 net/ipv6/ipv6_sockglue.c:566
>   ipv6_setsockopt+0xc8/0x140 net/ipv6/ipv6_sockglue.c:993
>   tcp_setsockopt+0x90/0xcc net/ipv4/tcp.c:3768
>   sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
>   smc_setsockopt+0x150/0xcec net/smc/af_smc.c:3072
>   do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
>   __sys_setsockopt+0xdc/0x178 net/socket.c:2347
>   __do_sys_setsockopt net/socket.c:2356 [inline]
>   __se_sys_setsockopt net/socket.c:2353 [inline]
>   __arm64_sys_setsockopt+0xa4/0x100 net/socket.c:2353
>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>   invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
>   el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
>   do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
>   el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
>   el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
>   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

#syz test

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346..281f0450 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -102,14 +102,29 @@
 =C2=A0};
 =C2=A0#endif /* CONFIG_IPV6 */

+static struct lock_class_key smc_clcsk_slock_keys[2];
+static struct lock_class_key smc_clcsk_keys[2];
+
 =C2=A0static int smc_inet_init_sock(struct sock *sk)
 =C2=A0{
+=C2=A0=C2=A0 bool is_ipv6 =3D sk->sk_family =3D=3D AF_INET6;
 =C2=A0=C2=A0=C2=A0 struct net *net =3D sock_net(sk);
+=C2=A0=C2=A0 int rc;

 =C2=A0=C2=A0=C2=A0 /* init common smc sock */
 =C2=A0=C2=A0=C2=A0 smc_sk_init(net, sk, IPPROTO_SMC);
 =C2=A0=C2=A0=C2=A0 /* create clcsock */
-=C2=A0=C2=A0 return smc_create_clcsk(net, sk, sk->sk_family);
+=C2=A0=C2=A0 rc =3D smc_create_clcsk(net, sk, sk->sk_family);
+=C2=A0=C2=A0 if (rc)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
+
+=C2=A0=C2=A0 sock_lock_init_class_and_name(smc_sk(sk)->clcsk,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_ipv6 ? "slock-AF_INET6-=
SMC-CLCSK" :=20
"slock-AF_INET-SMC-CLCSK",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &smc_clcsk_slock_keys[is_i=
pv6],
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_ipv6 ? "sk_lock-AF_INET=
6-SMC-CLCSK" :=20
"sk_lock-AF_INET-SMC-CLCSK",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &smc_clcsk_keys[is_ipv6]);
+
+=C2=A0=C2=A0 return 0;
 =C2=A0}

 =C2=A0int __init smc_inet_init(void)
--
1.8.3.1



