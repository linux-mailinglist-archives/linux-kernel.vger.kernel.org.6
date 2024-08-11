Return-Path: <linux-kernel+bounces-282077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629AB94DF72
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 03:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756771C20A9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 01:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9C8F70;
	Sun, 11 Aug 2024 01:29:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFB8825
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723339762; cv=none; b=qVp0a923BW+kdmqKVD7bNFJL1Fx6kUSRSNbeo6+axTmGUoHjXBMrUiZDQJZtKMjCptuHuj4ZWrb03vTkM1vywgZkB4FEtor6KH1TOhiQ45D3vkfBx8A3/vmquilymi6+O3nr76swmpTilD2DpCNDSV8+ZaP8XXSI42L3rSM9LZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723339762; c=relaxed/simple;
	bh=6sJE3X/dRhKTAm0/Avn4aqo2AmKV3gAyVLwHqrKo2m0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eqMWOJVv4LM7yzNaBz2HutPeUWDNsfc+UYCxoyi0PfrCel46yyGq7Rs7Yhz36U/0uT0YefmuEP4VFVo8uLkPiekkRdY0WJOcpayJhPTmeSm6YD/BMqeftJ5NJKCKQSfI/7qs0b7MNfp8JVxAdv+QrzlYNBAwbraR06aVH1Td/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f93601444so453385639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 18:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723339760; x=1723944560;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raqRTF4eqwyqlA887pjYM5q2dkGs8fVr9I0/HOMYhvA=;
        b=QScLW3nUUEVdOabxpzF0uKM1eMSWttWNIonXJzYSW4GDZ92ug0atu7iRqhwodwp9ZT
         CdmYHzZABL73Mg96SaM/LzqEYr3O1N8IXiuvAoNm/dezS2qn6r2d3B3ZiA6PQp5JdA2T
         n+kOsjIlGkT5YAFSqi35YMfO1C9YxX2GmDbVnesAOYrRZhybdLG5wVvtnlz8nNKfptmq
         R6/+8SXMOccnxH4AE19Kz7Ea85G7NIzm27WNyMH7OED9dx1QV7/X0GNOsSJloqJYtPbR
         lURXhCuw1sPo/hTLdurUkLynlF9gLpIQ1khrcjYfobAvuIWxxsW47IRbKQ/DL22DNJ0l
         fvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzN2yOG3XTkYE0uGmEc5xgSvLJkMzjnOELva2D8xN7fm60kyXE+BMGIbAxiSmduHWr2LPIotEy/A5fGSA74UfNEZGOaXO9pKwtmwq+
X-Gm-Message-State: AOJu0YzhT8jHbfqM15QmEbgsrI5eFpr7Azc1fbmrxb13hZCZ6Yo4JFpZ
	Tu2ij2sfHUrbQstFV/pM8Ktr6DTGeNiPUwe59Im5r+Ny+KPEfbn9OTNJeOWQF2JmkBzTPcCv72q
	IcTFU1C/zhDmdFCewGq3uH5K7p2zdF8PGM78ZdLcYl/v1tOaJckj7ZAY=
X-Google-Smtp-Source: AGHT+IGMUx90vGxWQEs61DG5807um1iZtHw962pACzdzeR6VMhnBxdufArTRdCImox0pZ6vzmFPzlMpjrZZsD7f9RUdW1QpzLKuA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:629e:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4ca6eda5e4emr220752173.4.1723339760092; Sat, 10 Aug 2024
 18:29:20 -0700 (PDT)
Date: Sat, 10 Aug 2024 18:29:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a5292061f5e4e19@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
From: syzbot <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33e02dc69afb Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117f3182980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=8ea26396ff85d23a8929
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-33e02dc6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/573c88ac3233/vmlinux-33e02dc6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/760a52b9a00a/bzImage-33e02dc6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Code: 8b e8 37 85 cf fc 90 0f 0b 90 90 e9 c3 fe ff ff e8 68 34 0d fd c6 05 0d 81 4c 0b 01 90 48 c7 c7 20 2b 8f 8b e8 14 85 cf fc 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 e2 e8 68 fd e9 44 fe ff ff
RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
 inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
 inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
 tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
 tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
 setup_net+0x714/0xb40 net/core/net_namespace.c:375
 copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x419/0x970 kernel/fork.c:3323
 __do_sys_unshare kernel/fork.c:3394 [inline]
 __se_sys_unshare kernel/fork.c:3392 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56d7c7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f56d897c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f56d7dac1f0 RCX: 00007f56d7c7cee9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000042000000
RBP: 00007f56d7cc949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f56d7dac1f0 R15: 00007ffe66454be8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

