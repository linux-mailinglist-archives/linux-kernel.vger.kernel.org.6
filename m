Return-Path: <linux-kernel+bounces-332081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FA97B52C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8099B1F226A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792BB192580;
	Tue, 17 Sep 2024 21:28:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7127442
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608486; cv=none; b=h60Glu3JDRZOlc5e70XWV4kqy25O4npWYriIoz3ZXl5Axwb5Ra0iVxYn9jpqu6+gUc480OWhzYW5G2BNJEQoIzJoFPSU4iPLYWWc71D78zqQI6JV9fUO3xdrfwoQsD7GhxLKeBZhYyXCFoMUc0KCtAsweDknEIgbWx+FrAEfblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608486; c=relaxed/simple;
	bh=FFms0JSvc6Z0q5c1Qi9WXKX5XoFu2RsClrHkYr07ICY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DLY3UJVVlF9XxYumZr4+lKKJu9O0E6+gS0eIgzf546OiuNnttyxhoDukNDV/rvflbnXDCvOkl/6xvvNFZc2isbv7L10CLuUxGsWp5CxlbQCoBa5pFNuZi9k7ZGNA6CrrIk+qDt2PZaR+WVneo7DQLvOJl8liMcDHJPFw3bPh7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso125980785ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608483; x=1727213283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bDAHX/2HpeG8O0GYsUySOvXaZHBEvJDh7x2fWTnQJ0=;
        b=rrsBCGrda1kTPxntee6uoSArkFEqVygSXIZHCnRUyj1HhV+++oXbV6iMvDj2FHlce/
         T5US0kv0TphJ5pI7D52bMzCAqBuDTHqewCmqLSzXAmU9WjYa5OUPCPeccyz2R6EbK+Ab
         S6TLIDou71zdGoK/VQJ4EFPNEHD3/u0v6I6aj8bJIaYexrg5lAFX/h8dXkCqqKNYAJPh
         47sKhvclea/1/ksx2dPppFxJSq9zsh9eTVr647IayLtIcJw9R9h2R5h2JIaAAww+OWjs
         PpsvMXukepbAexpbI07NRvMFBrlOkuIbOmeqEfSuVB+JHy0JHUQoqrjMShQk+YKgMx5J
         hDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXr9DvGV3StHlSKizInPGffQdu7oc7NUxdvPNxuqoAUVNY7HcdoTyZ8YEfh4dUSqGNT+9CWAgLB0PC7dI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaua0n6/A87hRC/mTMYDtC0dVi0+vROJZeHPu23L0u3VgmY36s
	zZ7FMcmbbfjg96UM7kZcGOto0ipkzl2+zdj51n2/Ko67oJapdzCtiYyCbeoIahnLLbViSDNI0Co
	9wHYkQ4glvv1EFa5xFT54rEkURGrYFDhZyGdcM1FXpJ1FFvHG7vW72vk=
X-Google-Smtp-Source: AGHT+IFReLZrO4jwJzW8veawI7UH1yi9eJ8Twhb48vdnrlkmvEiNi2VB2VoI+z2BXtT5KR1MzxA5IUKoZqccQvSaeUy9x0PwHbo8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:4d6b:42f7 with SMTP id
 e9e14a558f8ab-3a08b79a1a2mr148103725ab.22.1726608483655; Tue, 17 Sep 2024
 14:28:03 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:28:03 -0700
In-Reply-To: <fc79c53e-a5a7-4ae2-a579-83fefea772c4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055b6570622575dba@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	schnelle@linux.ibm.com, srikarananta01@gmail.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in do_ip_setsockopt

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-04557-g2f27fce67173-dirty #0 Not tainted
------------------------------------------------------
syz.0.15/6023 is trying to acquire lock:
ffff888025c40918 (sk_lock-AF_INET){+.+.}-{0:0}, at: do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078

but task is already holding lock:
ffffffff8faa9708 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_vlan_by_tcpsk+0x399/0x4e0 net/smc/smc_core.c:1898
       __smc_connect+0x292/0x1850 net/smc/af_smc.c:1518
       smc_connect+0x868/0xde0 net/smc/af_smc.c:1694
       __sys_connect_file net/socket.c:2067 [inline]
       __sys_connect+0x2d1/0x300 net/socket.c:2084
       __do_sys_connect net/socket.c:2094 [inline]
       __se_sys_connect net/socket.c:2091 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2091
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       lock_sock_nested+0x48/0x100 net/core/sock.c:3611
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2330
       __sys_setsockopt+0x1a8/0x250 net/socket.c:2353
       __do_sys_setsockopt net/socket.c:2362 [inline]
       __se_sys_setsockopt net/socket.c:2359 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2359
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(sk_lock-AF_INET);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

1 lock held by syz.0.15/6023:
 #0: ffffffff8faa9708 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077

stack backtrace:
CPU: 0 UID: 0 PID: 6023 Comm: syz.0.15 Not tainted 6.11.0-syzkaller-04557-g2f27fce67173-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 lock_sock_nested+0x48/0x100 net/core/sock.c:3611
 do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
 ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2330
 __sys_setsockopt+0x1a8/0x250 net/socket.c:2353
 __do_sys_setsockopt net/socket.c:2362 [inline]
 __se_sys_setsockopt net/socket.c:2359 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2359
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f34b9b79e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f34b95ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f34b9d15f80 RCX: 00007f34b9b79e79
RDX: 0000000000000023 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f34b9be793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f34b9d15f80 R15: 00007ffd22175db8
 </TASK>


Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104cb500580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7e7e5a089fe8488
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

