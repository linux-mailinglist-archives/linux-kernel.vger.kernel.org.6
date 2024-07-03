Return-Path: <linux-kernel+bounces-239744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E029264C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E08C1C21943
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39317DA02;
	Wed,  3 Jul 2024 15:26:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0E1DA318
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020366; cv=none; b=soIrZUplp+0ditKJhi5NnBr8N5z5OcQ92My4G2Izc4lo6Msnd8zfnGurKaYjPj9EXIFZyaG4aycESnYOhxA/7OIUcu8Yz1lEPjvm4hRyyafxRHM0jgSU2b/5faJ54xzARLbx+C3zl8xQn+gf1rCUxlzXCXIPhFQrjtZ+C65HjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020366; c=relaxed/simple;
	bh=sED7aUBRBxgYqL3qDFVIy6Js3Xd6X0Y6cbfCth8OU8U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H2WiUqmEIJqQ9c7ElG5d5av1A0sS8ZJk84bEHKZm+VzQUu/Bx/udPNvmuMITdu0VcolprNZqPcVu3s5gJI+KrCYD5lhOFejmpznpD8tWrT4UP9iEygxA5aPDIscaBQeOqjz5pS+1J68oiWRoC3HNOFHTDGk+aMFrFFw7Q6Y5aZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f4e270277cso53158739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720020364; x=1720625164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RK4FhQE3m5VnS0m5avVglANXXmzqwiThRi8Sf5bmUg0=;
        b=IdhbIVpyAms2CJFfhedYrZGw3JjaNlnEN24W0zWwytygPwIxlmxXkyEgMZpGxKyM3j
         QxdTcIRvp7C5yT5QgYiRxwoOj1URKdNsY86+ICTo27HkwUaZ43h/VRN6/ghwYxXfxXyQ
         ZIVBx0toFjvwwCbrwXlXvNOigYjCLziRGBA8jmcAysZsCcc0Vb9db/BYrnBgF1AEOqFC
         4Hmrt0qUAKJIQRMKnbPK25iKrFfidG5S1P9BBlZm5Cs0o52X+P6sX6C4aIR87fgDET2z
         6IXCgbOsgmzWp0iIgfEsEhcmnK+VWKquTP3obN7qZFGzCuqzSqNdaGsQa8aeEN3HpxIF
         RJgg==
X-Forwarded-Encrypted: i=1; AJvYcCXGVwLmvvI25Mb+hz/mHwGxoVQwkqN5zekKJFzUnoKLYMw6PfOyRQECh+rxNbo56LgAqva5mR4eGMxckWOXHqjhKpN8NDX5+rVuUfU4
X-Gm-Message-State: AOJu0Yz3bzBLh0RkTePk2xKFg+g7nOD36plpoOAqYh6iZbzo3PbLsCY+
	0YUn/bTgig85BFPGGPoxVu2Guh/FGx7P37KpXurjLW1m3/i53wCebmldnoMAgmjntlFPl3Yq3TG
	aX/g5S3OxNuy/Y8MyZPV6OAHPDDw4pQ+LGeEDbilxjd06ALGxK0F2TiI=
X-Google-Smtp-Source: AGHT+IGWYIA5uJuwmaLRfQR0iccGXfLfk/NvqgmO68+rDoMj4sVLozNnpL4REGW2bgDrgSzdsSBP35wNqqTiw9jEY2dm6QGN8FCL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ef4:b0:381:f3bf:c5d2 with SMTP id
 e9e14a558f8ab-38235cc9514mr363515ab.3.1720020364239; Wed, 03 Jul 2024
 08:26:04 -0700 (PDT)
Date: Wed, 03 Jul 2024 08:26:04 -0700
In-Reply-To: <20240703150144.22450-1-en-wei.wu@canonical.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d13968061c59720f@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __cfg80211_connect_result (2)
From: syzbot <syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com>
To: en-wei.wu@canonical.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in cleanup_net

     create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
     unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
     ksys_unshare+0x619/0xc10 kernel/fork.c:3323
     __do_sys_unshare kernel/fork.c:3394 [inline]
     __se_sys_unshare kernel/fork.c:3392 [inline]
     __x64_sys_unshare+0x38/0x40 kernel/fork.c:3392
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
WARNING: CPU: 1 PID: 11 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u8:0 Not tainted 6.10.0-rc5-syzkaller-01200-gcda91d5b911a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 88 f2 ab 06 eb 1a e8 f1 b7 ad fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 70 f2 ab 06 90 <0f> 0b 90 48 83 c3 44 48 89 df be 04 00 00 00 e8 5b 7f 13 fd 48 89
RSP: 0018:ffffc900001079e0 EFLAGS: 00010246
RAX: 2ba763440467a200 RBX: ffff8880296b9ed8 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcabb40 RDI: 0000000000000001
RBP: ffffc90000107ab0 R08: ffffffff92fbc66f R09: 1ffffffff25f78cd
R10: dffffc0000000000 R11: fffffbfff25f78ce R12: 1ffff1100da640d8
R13: dead000000000100 R14: ffff8880296b9f28 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b2700a0950 CR3: 000000002c8b0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:465 [inline]
 cleanup_net+0xbf3/0xcc0 net/core/net_namespace.c:661
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         cda91d5b sctp: cancel a blocking accept when shutdown ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10042266980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=d6eb9cee2885ec06f5e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1424c7ae980000


