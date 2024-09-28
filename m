Return-Path: <linux-kernel+bounces-342594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF59890B4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856A5280ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BFC5381A;
	Sat, 28 Sep 2024 17:15:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931681EA85
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543727; cv=none; b=XYfVg1Xge4biDRtFcZGKchLE8dX3V9QVm7j/XMGf1vMOSU0hheQlaHgo8/O2wKCwQ6rc0yJ/zhLFW/MAsEJT400JrOEIvLb9InKaYlyLsGbxzFIJUIf8ddfajiyZ/q7+N1A97dvhQjsDLD3IGWXgwks8j7JPLQUR9oA7w8prNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543727; c=relaxed/simple;
	bh=L75wV3goodnEVnOpoVyb8KtycNqTR0T41MA0GwpACTY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AdtFgl/ty4xg62yqiRk6qqkpwNMSlUlbbRJX1y/zTKqePxRsh6c+038ieoje4XFlsAIvILO5ZAvnmEJeP6OMTI02Q6wad16wcDHbSPMLLr6WoQkQ5yW01Uo8GKvsNl7TkUFpXlkmjdjVetfeOiOXojrM8oaxphUMACNsJr6x9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3479460f4so17841125ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543724; x=1728148524;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+eM6+uGjRhV6pjAlMDlNiw0Ug6spSXD9CNoxfKY6Ds=;
        b=vmTXMO1b0hrUV5foofOQfJe4J4pcheNu41ZB6PthIatYTx0hJ/undSM7KjoTxAjKJk
         XJkG19PRxaQasetp1+SDDLW5TJZfbVslIDsOoQBC9ZqIuuR9e7IvQkjkYROG+XQyTLr9
         EGAglzwkyF1T17xtCL51WeqJdJbFhsv42O4EU7AWcX25u5/9V32IZZGGvzarVJnz0Rrw
         nasawTbM6FHJsews/wKTxG6COkI6qRy7qYYSFniLKBbKbLe7MvC2QO2vzsx28xjCVC58
         4vX0r7Z2mXbPP4rAH/VkA+V03QrcqplSSdZ6ndLOcQwxxoFG43WutcuxAlAj3UDJVJ/V
         oUDg==
X-Forwarded-Encrypted: i=1; AJvYcCXdVUbKUY3SXmwdU4txnqf/OkDP/BIZ/362OBKQPcKsM1wBgPOmywhPiDSOl7nMd67uTF5W4tYR8SYSLqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Q2HdxbF3+WdxBaOpYpu+KCMvNEEV4aAqsaB/w9PSECqyAYLq
	VDD0uUo32RR8lBugEae+BSEHTdZaKhfVur3AocECmIGfvei84CGRuWmusk3aNlAjFdy44hmG6vt
	VVWcstsfj4wAeba2NTsygaKTVOfOEudS4v7hUJnhloqz+mv2w0VDJhZM=
X-Google-Smtp-Source: AGHT+IEer9NcnjoNSnrxIFC6zYS++mj0XSXF3vOSC2bfzwfbfPfDW1dhX46R/2dWw23CC9GzHz46fkhGazztUq1lvdfwy59tzgRZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:3a0:9954:a6fa with SMTP id
 e9e14a558f8ab-3a345171ebfmr49175825ab.9.1727543724762; Sat, 28 Sep 2024
 10:15:24 -0700 (PDT)
Date: Sat, 28 Sep 2024 10:15:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f839ac.050a0220.aab67.0006.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in enqueue_dl_entity
From: syzbot <syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    13882369ceb9 Merge tag 'hid-for-linus-2024092601' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17334507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1af1dc2e43cf22f
dashboard link: https://syzkaller.appspot.com/bug?extid=00a022dc9979d67df050
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-13882369.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1a2db588faf/vmlinux-13882369.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3f594a63d31/Image-13882369.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 34 at kernel/sched/deadline.c:1995 enqueue_dl_entity+0x47c/0x590 kernel/sched/deadline.c:2029
Modules linked in:
CPU: 1 UID: 0 PID: 34 Comm: kcompactd0 Tainted: G    B              6.11.0-syzkaller-10729-g13882369ceb9 #0
Tainted: [B]=BAD_PAGE
Hardware name: linux,dummy-virt (DT)
pstate: a14000c9 (NzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : enqueue_dl_entity+0x47c/0x590 kernel/sched/deadline.c:1995
lr : dl_server_start+0x44/0x12c kernel/sched/deadline.c:1650
sp : ffff800082eab970
x29: ffff800082eab970 x28: f3f0000004f45c00 x27: 0000000000000000
x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000048
x23: fff000007f8ee800 x22: 0000000000000001 x21: 000000000016e360
x20: 0000000000000001 x19: fff000007f8ef168 x18: 0000000000000000
x17: fff07ffffd1e0000 x16: ffff800080008000 x15: 0000000000000000
x14: 00000000000002e1 x13: 0000000000000377 x12: 0000000000000001
x11: fff000007f8ee880 x10: 0000000000000001 x9 : 0000000000000048
x8 : 0000000000100000 x7 : 0000000000000001 x6 : f3f0000004f45bc0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 enqueue_dl_entity+0x47c/0x590 kernel/sched/deadline.c:2029
 dl_server_start+0x44/0x12c kernel/sched/deadline.c:1650
 enqueue_task_fair+0x11c/0x3a4 kernel/sched/fair.c:7040
 enqueue_task+0x58/0xbc kernel/sched/core.c:2020
 activate_task+0x68/0x80 kernel/sched/core.c:2062
 attach_task+0x4c/0x74 kernel/sched/fair.c:9631
 attach_tasks kernel/sched/fair.c:9666 [inline]
 sched_balance_rq+0x488/0xc74 kernel/sched/fair.c:11743
 sched_balance_newidle.constprop.0+0x1b0/0x3e4 kernel/sched/fair.c:12785
 pick_next_task_fair+0x50/0x320 kernel/sched/fair.c:8933
 __pick_next_task kernel/sched/core.c:5955 [inline]
 pick_next_task kernel/sched/core.c:6477 [inline]
 __schedule+0x158/0x8e8 kernel/sched/core.c:6629
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x34/0x104 kernel/sched/core.c:6767
 schedule_timeout+0x80/0xf4 kernel/time/timer.c:2615
 kcompactd+0x204/0x374 mm/compaction.c:3181
 kthread+0x114/0x118 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
---[ end trace 0000000000000000 ]---


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

