Return-Path: <linux-kernel+bounces-277511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E950F94A25D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F53B28ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B41C3F31;
	Wed,  7 Aug 2024 08:06:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57982863
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017987; cv=none; b=QsgSTayyRXT5xNjmgz4e8I4JSr7I7mOW3gLsVfjvltczTztbD6eqjdf2ZcTkQTcSWRbR9FCBUSoK4wKkP0UOJF/iYRdYzMIfIZ8rW9pX5B6uTzd7FvHPQ/ki2561Z3mL7t/rcIqyes063p+CfRGBAQ7lNOzTdXAjdrSLncdIkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017987; c=relaxed/simple;
	bh=OLJC7WIi/YVvouXXbG+qgsD5JqDKLtG4xt3AZpMVPRk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KB61ZeKQwn4jsJlSnpTe3aIGcADoxQiXUOCcTSedqW81GpvV1FV26pw3b3H8jeumpXuo4GO91jV9zkfTu9tyRMWqi/B5py8BcOFulBjFQns+/HRMQZHjDCjHxFPyEg/Cw9fnZXE3wNTZI8FALgM+XV1jjNxhntYTr06Bexdfcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso69183839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017985; x=1723622785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPyDpF/qZao+PcJQw2T5V5PZGFz/IsS/WZWVVXORGyg=;
        b=RI0iNgMp1WMly2fSUMkQo7rc9+W4e3sDfq4dwb3GjzwFxfP1109X5vyAJ6JYezsaqo
         /BLmukF1uOu751IT0OEYDd3XCUPjIljqjZ1k0nkfJqT25PxI46+H5+LYaO4J9+E7IOUm
         6dlgGSZPPEORZ6LQ+VGh+O2w6+GiWElW6w928b7Xs5fRnnuhsXL0ETsvo11ls5A4dCCe
         uO2vAIxghwqAvgAV+zWSQiO8qDs0XNDATloE9fxQeqwJumgPwm2g0CMpbzzmy6PenMoF
         mqxBTbiTz0CfnGtsV+OyBtq7vxnV4M1UKwqYHlYTYxkDIkannwTg99Vqv8XTjOqMePqq
         Db9w==
X-Forwarded-Encrypted: i=1; AJvYcCV6crBOkIRVyDdqZpeI/yuNysyv2PL5nv7ABtmn06oqzsrpcDMguorFI8mmiH7uZxciZqfgxPgyFsPrbgrISrIMDppnMown1heRsXA+
X-Gm-Message-State: AOJu0YxCHnJyFJwHMVOPTiJxQkoMy/7+i8Taq/rnF1NMXeDP72Bm9pMu
	sRLrjhxC7+DVt5LzeKQ+8OpBXOAs1oACWyIfKY6nP+K+jxVgddN0WigLn1UgPNmroN5YRr7FgQ7
	wsKib3f0URXsd/JqrwXLQs8BIEvP7FuA0dOW62CuryUjHJ2kFdxsM1wM=
X-Google-Smtp-Source: AGHT+IFw+lvtHH6wNrzOeeyoYZiaO+QYbVDCZhZAUINvkHpl5igpuymwK5YKiXATXg7FIVANLp0knbBD12+6VLYWJdDgLPwp3r0L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:395:fa9a:3187 with SMTP id
 e9e14a558f8ab-39b54502233mr1235635ab.3.1723017985247; Wed, 07 Aug 2024
 01:06:25 -0700 (PDT)
Date: Wed, 07 Aug 2024 01:06:25 -0700
In-Reply-To: <0000000000002e944b061bcfd65f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3e751061f136220@google.com>
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_vlan_by_tcpsk
From: syzbot <syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d4560686726f Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119f30f5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505ed4a1dd93463a
dashboard link: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e2fc5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16307a7d980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d4560686.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3304e311b45d/vmlinux-d4560686.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5fa8d141fd4/bzImage-d4560686.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc2-syzkaller-00013-gd4560686726f #0 Not tainted
------------------------------------------------------
syz-executor492/5336 is trying to acquire lock:
ffffffff8fa20ee8 (rtnl_mutex){+.+.}-{3:3}, at: smc_vlan_by_tcpsk+0x251/0x620 net/smc/smc_core.c:1853

but task is already holding lock:
ffff888033d60258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
ffff888033d60258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: smc_connect+0xd5/0x760 net/smc/af_smc.c:1650

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
       lock_sock include/net/sock.h:1607 [inline]
       sockopt_lock_sock net/core/sock.c:1061 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052
       do_ipv6_setsockopt+0x216a/0x47b0 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0xe3/0x1a0 net/ipv6/ipv6_sockglue.c:993
       udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1702
       do_sock_setsockopt+0x222/0x480 net/socket.c:2324
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       smc_vlan_by_tcpsk+0x251/0x620 net/smc/smc_core.c:1853
       __smc_connect+0x44d/0x4830 net/smc/af_smc.c:1522
       smc_connect+0x2fc/0x760 net/smc/af_smc.c:1702
       __sys_connect_file+0x15f/0x1a0 net/socket.c:2061
       __sys_connect+0x149/0x170 net/socket.c:2078
       __do_sys_connect net/socket.c:2088 [inline]
       __se_sys_connect net/socket.c:2085 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2085
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET6);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_INET6);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor492/5336:
 #0: ffff888033d60258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
 #0: ffff888033d60258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: smc_connect+0xd5/0x760 net/smc/af_smc.c:1650

stack backtrace:
CPU: 1 UID: 0 PID: 5336 Comm: syz-executor492 Not tainted 6.11.0-rc2-syzkaller-00013-gd4560686726f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 smc_vlan_by_tcpsk+0x251/0x620 net/smc/smc_core.c:1853
 __smc_connect+0x44d/0x4830 net/smc/af_smc.c:1522
 smc_connect+0x2fc/0x760 net/smc/af_smc.c:1702
 __sys_connect_file+0x15f/0x1a0 net/socket.c:2061
 __sys_connect+0x149/0x170 net/socket.c:2078
 __do_sys_connect net/socket.c:2088 [inline]
 __se_sys_connect net/socket.c:2085 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2085
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6fc285ad49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeaafd57c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f6fc285ad49
RDX: 000000000000001c RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffeaafd5820
R13: 00007f6fc28a8406 R14: 0000000000000003 R15: 00007ffeaafd5800
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

