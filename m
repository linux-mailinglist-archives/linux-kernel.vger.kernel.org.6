Return-Path: <linux-kernel+bounces-191421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0048D0EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A5C1F21BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47161155C88;
	Mon, 27 May 2024 21:06:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D08481C4
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843968; cv=none; b=lGOgU97sGo8y/d2D7aJbntYf3LIEsDddvtU3Gx6ODInw1QK/+SZj89sEqUxdKx/ydXmSyWlMQNciwdCxW3QO2a/+BfP+F4l3EDn+xHTfjAamzDtKskwUdUrXRlo8W0KbbMPD3ANJKXStLNnv3QH3Do2gPedTYN+yyHS0qyaVT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843968; c=relaxed/simple;
	bh=JCYZ+H5659segi9ymkKMDgixoU25H/nRABLpJ4qPBpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mHFI4my6kcV0LmoeDLlmmAvV8yCpOe67NUrf7YJzrP+c1Hu+yyro0GJZ+yRqBRKtuheZM+UQFeYnI6jy/eymgLG6hm/lX8/HLX8QZUDdURLuLCVugYnSiGcq3Vg7nplrzLotjJES8JMJbPwxXOFj1/piedXWWS7pl7Oigc4PhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e8e558d366so20029339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716843966; x=1717448766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+lQQ1kBupVDn11xPmCUir7mv4GeGjPpfk4kBNO3QCE=;
        b=qfQuagWeomVmHu4JOXn2VsvE6ic03kK+u2I4BWCY9lfitc6ZOPLzyr8SSbzwgVC2ia
         5lYoOrxEdYbjjoEMvbQJI1v/GzoKAv8LoYiKocNbbm25/71WJFM7fh/p1ngWiralMmlE
         9uboUbJ9xGeAa9Ub+rngylKI5Kw3BLgazfIv0cwFLoaI7m/bpAF5rnnoRDPgIucxZ4jt
         KDxaLbxi895wfnuUmtyJl2hsjjJpGcTgiKDMWGGAQJ5Bues8UHAoJNcHrVByNPGYOc5P
         HuXvL1fCFHIKazEJWqVXHmY5x5/SdzPzCQGDesZEM1vCwHoTz0tzABlW8gEEnVoZ1vpm
         JmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsnCf2pCKi/iUi4YzvsopzFJeK7AhH7Cuj1P/xx612IttQNkutl1vCz3cXkx12PZZyg9pdjUWnFKktoAGDLn/t1xDNu3D/xw4nM+Eb
X-Gm-Message-State: AOJu0YzFAK1lH+WnNFv8lB4XieY5ee6Y3iFpg9SJuz+ZMO+CUFOxOawU
	q6DiIKZWD9SLqhF4VcB0pa0QWLdcV5F88xAjYC3NPdNSTxUIJv18m99vhJVqlUXg4oPZn8jQ5SO
	jNcgyaO5rb2m0aHjnUlT7qoUqbCpaIDUUCUPx1dX6k2Vo0Ag/K9G7zKQ=
X-Google-Smtp-Source: AGHT+IElWZO3CqSVqPVqnFihnu1pvU4o7KdRp3sc7/s2rVP6BLa0RjF1gaBdXqNm4Z1NJ0Y+/RAmHBw+CAh6/UJah0ISO4xau7eZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a892:0:b0:488:e34a:5f72 with SMTP id
 8926c6da1cb9f-4b03f630e0fmr367137173.2.1716843966049; Mon, 27 May 2024
 14:06:06 -0700 (PDT)
Date: Mon, 27 May 2024 14:06:06 -0700
In-Reply-To: <20240527104512.2559-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb3fe9061975e254@google.com>
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
From: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... } 2676 jiffies s: 3265 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6099 Comm: syz-executor.1 Not tainted 6.9.0-rc4-syzkaller-00266-g977b1ef51866-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:write_comp_data+0x34/0x90 kernel/kcov.c:236
Code: 48 8b 15 ff 1b 76 7e 65 8b 05 00 1c 76 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 14 16 00 00 85 c0 74 4f 8b 82 f0 15 00 00 <83> f8 03 75 44 48 8b 82 f8 15 00 00 8b 92 f4 15 00 00 48 8b 38 48
RSP: 0018:ffffc90002e5fc88 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888068e7cb40 RCX: ffffffff894209a1
RDX: ffff88801bfa8000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff888068e7cb40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000020 R11: 0000000000000003 R12: dffffc0000000000
R13: 0000000000000020 R14: 0000000000000000 R15: ffffed100d1cf96a
FS:  00007fe3784b36c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b05dac000 CR3: 0000000011a78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __inet_bhash2_conflict net/ipv4/inet_connection_sock.c:206 [inline]
 inet_bhash2_conflict.isra.0+0xb1/0x210 net/ipv4/inet_connection_sock.c:229
 inet_csk_bind_conflict+0x40c/0x630 net/ipv4/inet_connection_sock.c:264
 inet_csk_get_port+0x1639/0x25b0 net/ipv4/inet_connection_sock.c:585
 inet_csk_listen_start+0x15e/0x390 net/ipv4/inet_connection_sock.c:1281
 inet_dccp_listen+0x1c5/0x220 net/dccp/proto.c:951
 __sys_listen+0x19b/0x280 net/socket.c:1881
 __do_sys_listen net/socket.c:1890 [inline]
 __se_sys_listen net/socket.c:1888 [inline]
 __x64_sys_listen+0x53/0x80 net/socket.c:1888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe37767dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe3784b30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 00007fe3777abf80 RCX: 00007fe37767dea9
RDX: 0000000000000000 RSI: 0000000020000005 RDI: 0000000000000003
RBP: 00007fe3776ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe3777abf80 R15: 00007fff4057e238
 </TASK>


Tested on:

commit:         977b1ef5 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1530f71a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=2459c1b9fcd39be822b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13e5e7f0980000


