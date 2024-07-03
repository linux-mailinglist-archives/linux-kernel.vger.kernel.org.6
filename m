Return-Path: <linux-kernel+bounces-239783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284B926540
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1495B27BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88CC181B80;
	Wed,  3 Jul 2024 15:48:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C95173336
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021685; cv=none; b=L912nc/1GcMbQz+ZmlEwbCKxrUQTROO82mPFoN5IX7mG5ZI0v4BZH7lSnI5QP9sV43s5JWAVtuqu+6NaFdNuOw3HCSI82lcWzpANbwq7WHM28/wDEkSTVWhfRN9HLBdYJUufcUNhaT4welPZcuU4Z7es1qxRJvUk78C+MImjiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021685; c=relaxed/simple;
	bh=YT08CO2OUMcqWTKfee43uxS3qK1DNd/Xzu1HbLM9uiI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rs1cBhdL8+T489IUdy13nCBdkO26yH/bjaubxCaPL80uCoMlFcymjd+cBlDe8z8laiLxydGou5a0KfCTfkiBMdmcRiecrIY1OHzxqwROsOfDVxJ7vnyIQ/ylWnBh7ZxWNlXtVoeJP5N4fJLXfbxLD40iWKN+jRO7jXIbPQVDUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f4e270277cso54927439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021683; x=1720626483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns+9U2mCtCdWmzTSQm8KVg5tLPqm1UUxMjLGrIwV3VE=;
        b=i8PNaPLuFG3ssLoHxowexzD/uws8FPqtSB2J/MQlBl/QmnTb7wxNlTvPPuJl6p5kqK
         m18swzSOnO/FcZ7qPNqJs9xPOtv4mmlM3gIDpmyQNqc6M3Z5htsjoYt380cvhcdc54BM
         T7yNIF2UC67PPkAwkYMMDkkZe6f3pFC87zmqh5EZLjdIhX6Xklarsofz8mkBVOSuUwB1
         v2VGI0yJESAQhWbsxqPp/BWd7CHwNYzSoJ9hc/OS0W74ICXM+VBAur4qDoXi/tcjtXYk
         JebXGz9a/8l5/TaZY45ucXP/sc3b0WM+p6dFNCc95iPF7qC0ehKOCjjS94p0ECVED8SZ
         snZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCy2HPoHw7UXODm3qO9DXC7dxkgfnhsHgerKSu94Q0lMJtJqOI6Q8hadjr3L1fKKHo8pHzlleMZdo7uFNRs5uY5/LH6U4eWykkqXhW
X-Gm-Message-State: AOJu0YxaDm4Z4e5tVlPb1ZPDFEX/rBTgb7IOJ/+Wl3CzQvqd2NYLExZu
	q2CgEchw9og4mINkDZVXWCBD7tYhXL8LtHyINEzqqatQK1HgUZ8VAl0n78vD+41Tww82ymS9XDj
	ut6syMWqOcmuJYTw2dxzJ9a8SbBzKk7hqr+NIgqtracz932ymKkMb0wQ=
X-Google-Smtp-Source: AGHT+IFFfHask+hS0+ilU0s4BxQeoP5yJZGhKgWJHHYoYxCJv2/9Ga7RIzNp8S8EhvZx4FRXF6ceaOZGFzpB6P4sQjauXIlU1DHb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1387:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4bd5d1afc47mr124254173.1.1720021683120; Wed, 03 Jul 2024
 08:48:03 -0700 (PDT)
Date: Wed, 03 Jul 2024 08:48:03 -0700
In-Reply-To: <20240703151354.24132-1-en-wei.wu@canonical.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dbf27061c59c16a@google.com>
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
WARNING: CPU: 1 PID: 12 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Modules linked in:
CPU: 1 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc5-syzkaller-01200-gcda91d5b911a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 88 f2 ab 06 eb 1a e8 f1 b7 ad fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 70 f2 ab 06 90 <0f> 0b 90 48 83 c3 44 48 89 df be 04 00 00 00 e8 5b 7f 13 fd 48 89
RSP: 0018:ffffc900001179e0 EFLAGS: 00010246
RAX: ae4fba0a5aa06400 RBX: ffff888024fb1ed8 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcabb40 RDI: 0000000000000001
RBP: ffffc90000117ab0 R08: ffffffff92fbc65f R09: 1ffffffff25f78cb
R10: dffffc0000000000 R11: fffffbfff25f78cc R12: 1ffff110045b9468
R13: dead000000000100 R14: ffff888024fb1f28 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559ce218b950 CR3: 000000000e132000 CR4: 00000000003506f0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1287deb9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=d6eb9cee2885ec06f5e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128b109e980000


