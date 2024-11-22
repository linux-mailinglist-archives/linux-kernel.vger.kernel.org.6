Return-Path: <linux-kernel+bounces-418835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704629D65F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3059C286F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D81C8776;
	Fri, 22 Nov 2024 22:48:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DD1BD9E9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315706; cv=none; b=LNZQZkfjiDjyIE/Zc22WgESGO+dQ3x8vywIu+ZEWIQpGJdCO27AAFYRyv/NYmRWxtlB/Fux6AotdaK/Tv3CGW/+zjCjYpoNCObHXPhzpJ4sd/JyeWIPIltUEcsoWUOWWawhsC1m55nCAqAK/tKJe4ulP49Ki1N3IwHoodVo1p+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315706; c=relaxed/simple;
	bh=M+pXEzVAh+FfiomftgpSUO542zOsHza/XJ6X5aBG8MQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F/lN7VRa3pUgQGU4TjxOBtzFtVNy20pKo2qG7yOmGR7O/rHtXi2tNaTNqc7rDlFlftm7hbTGUIuYzN32mX/PQwBmt9JDEOgnKcaHXMSGQJeZaKWbn6Nyde8QMLeSfGXWJ0n46/M524i/PlHKBHdRF6ZZLQeTZg9IJxZybqaU7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a768b62268so28138195ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315704; x=1732920504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dk8I5Y58Qn9xNhXYLDh8oA7Dj1xfAoj/QD4TuCLbCc=;
        b=D52AMxjUwPenCsqpObBtZ1SdPfwJ20EWCruU33gIir/lr4Q8VTnXlAua3Jm7DJLM2L
         OVjM8HrNidNUAYkkXmbhdGNwIBpFEh1W/1T06tyDpqKXMol54LLBzpCS0xACw955u32T
         c1lxm2Uwktj3J4H4cJvM3/Sx/j+bwea5QytuvpGrOrE8J4u8o7CFObC2lmMJS5Xq1pxj
         zT7eppPPAHhSk56JfbhI+wviJWzttQ7LC5yeF/L8wP9gAJ81tfpQISGGADhgfQ0WXNqi
         A2tq3Eh8lWJpGYGHc97y8ycLT5QSjom5TMnp9j17o22FogOdmiiJG3aKWvVaeNekxxyL
         Mphg==
X-Forwarded-Encrypted: i=1; AJvYcCU03kSG5uXcDqTegQYLnwnoDyxto+e8uAvcAdks5YgCIcRU8iaJwBK2LnkfJDO0Lg+kj93bB/Zu3OSKjfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvow9DomgbhfUZc9zadzrdu23tli1b8LzIAUdzZyKG+KIsiLoG
	3gAkgWC7DSTFCaF6nSjPeabOquoqo4o+LTR+sNDruFG4IjBQWsUYmvURnClWBYWcHB/xaeANF+s
	tTZ7QfKOQBy+7QhQoFl4zJ6stJXxU/v14pa8iWAOROCc8vCn+e/he6+M=
X-Google-Smtp-Source: AGHT+IFuwti6VEDQFJdUqneodNTCTrTmi9w4b5SxEsUGc1hbpqe1/+jzXZXJ/l8tlOolxd3Qy63yjKdIadRO3yqP89WvewyA3YDw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188f:b0:3a7:820e:3388 with SMTP id
 e9e14a558f8ab-3a79afd6e87mr66934035ab.20.1732315703815; Fri, 22 Nov 2024
 14:48:23 -0800 (PST)
Date: Fri, 22 Nov 2024 14:48:23 -0800
In-Reply-To: <66f839ac.050a0220.aab67.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67410a37.050a0220.363a1b.0150.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in enqueue_dl_entity
From: syzbot <syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bsegall@google.com, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    28eb75e178d3 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1402175f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5606b6814de0f638
dashboard link: https://syzkaller.appspot.com/bug?extid=00a022dc9979d67df050
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1016fec0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-28eb75e1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4053ed867efd/vmlinux-28eb75e1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/903039310aac/Image-28eb75e1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 10 at kernel/sched/deadline.c:1995 enqueue_dl_entity+0x478/0x58c kernel/sched/deadline.c:2029
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.12.0-syzkaller-07749-g28eb75e178d3 #0
Hardware name: linux,dummy-virt (DT)
Workqueue:  0x0 (events)
pstate: a14000c9 (NzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : enqueue_dl_entity+0x478/0x58c kernel/sched/deadline.c:1995
lr : dl_server_start+0x44/0x12c kernel/sched/deadline.c:1650
sp : ffff800082b33a10
x29: ffff800082b33a10 x28: fdf0000004e5dc00 x27: 0000000000000000
x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000048
x23: fff000007f8d7600 x22: 0000000000000001 x21: 000000000016e360
x20: 0000000000000001 x19: fff000007f8d7f68 x18: 0000000000000000
x17: 0000000000000004 x16: 0000000000000002 x15: 0000000000000000
x14: 0000000000000142 x13: 00000000000003db x12: 0000000000000001
x11: fff000007f8d7680 x10: 0000000000000284 x9 : 0000000000000048
x8 : 0000000000100000 x7 : 0000000000000000 x6 : fdf0000004e5dbc0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 enqueue_dl_entity+0x478/0x58c kernel/sched/deadline.c:2029 (P)
 dl_server_start+0x44/0x12c kernel/sched/deadline.c:1650 (L)
 dl_server_start+0x44/0x12c kernel/sched/deadline.c:1650
 enqueue_task_fair+0x11c/0x3a4 kernel/sched/fair.c:7038
 enqueue_task+0x3c/0xe4 kernel/sched/core.c:2061
 activate_task+0x68/0x80 kernel/sched/core.c:2108
 attach_task+0x4c/0x74 kernel/sched/fair.c:9635
 attach_tasks kernel/sched/fair.c:9670 [inline]
 sched_balance_rq+0x580/0xc74 kernel/sched/fair.c:11747
 sched_balance_newidle.constprop.0+0x1b0/0x3e4 kernel/sched/fair.c:12789
 pick_next_task_fair+0x50/0x320 kernel/sched/fair.c:8937
 __pick_next_task kernel/sched/core.c:6023 [inline]
 pick_next_task kernel/sched/core.c:6542 [inline]
 __schedule+0x15c/0x900 kernel/sched/core.c:6709
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x34/0x104 kernel/sched/core.c:6848
 worker_thread+0x19c/0x354 kernel/workqueue.c:3406
 kthread+0x114/0x118 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

