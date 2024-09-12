Return-Path: <linux-kernel+bounces-326289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6A9765F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498E5284EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF6819C57E;
	Thu, 12 Sep 2024 09:46:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13537199EB8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134384; cv=none; b=PecCOnLvMbxRlWaBx1HqrGaZlIXAsdIqwAA02KlkTzuv/GdSmwB6MxrkL7m98BdBRB7XMdSIYlt4m0wfJOgVJZ8jKi8MlhpciQ0QH5+/UtwiYOfdm5wSHw1lTi8N6i7ObRwKtgZF0JVrZN6L93ILD2OJ5yXg7OY35uabSn09/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134384; c=relaxed/simple;
	bh=NjzYRBNG2lMBlzjbh1aj0f917nsYUrL5rqCLwGTzklU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KH2DnZPdnhGt/5Pmu4X7RJc7bKDurQRQ16XZ98L2AglfO9Vz4dinNNBze7zz1xSu3U9tnzblBImbmhmyxoDKuiUqntfrZjOPOdtzloSI5iI/3Zoxl3u+Jmztk3uQiL3y919Addjjpn0cCBgLJmXPwYzBMEimH9MYUFcNX55vrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a050af2717so13969845ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726134382; x=1726739182;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1R+h/OmDweOJUF721+4YYV7lgj8RjG9bGByowlRGDQ=;
        b=IGlPrpK9qacDb+T8aHinxVYOKH/j+0ZVhOyJfsQviYdr/VI6pqQQ2VNu63v4hPruuK
         tOHhdm8MuZY8lCadBH/pM+jhXmVTwRIs7OfbgA0l9mGe78LSxbG994URlglfKVYQ7JFP
         wwgWB01CpoYA1+BTbcvoSKrCyTRnEO1Nzkg3l/gNyDvAeyxXxn6PKqKB1SeVtLlqLoQV
         shyxTzGdUsOlnEZAvbhgnv+VCIBqIfHzF7h/G6t2PsSy6JdC8EXGsSxXmv5KZYyZiSl6
         3biOYc6eRMUu4Xwo0LptAOCfRLtboMHWcoDnDbRDd+JDVuIaRQY0Z1Cif5O+J4MX4L4T
         b/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVOM80nKU1u7/OzN6cbQeCz9FZobyXDyurWmCVqXIa3gThY20Y9accz44+SOTAbT17Khb8N7zFyMbaP8/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkM9hOrlPtYoftgeuymM0PSfysfMfFC62WFuvQ2QBR1w7AUCtb
	LT6bqIgtNfjjbel5EawVm0gVFNYLYmnjy/+YldT38hAD6IFpqE1QIDRcBa4LSvBaIfAOfHDZaNC
	Go3fuWsVeJJT7BhzSkM78kPHa6cnWMUzhAI/SlwNvV3tACM/oulYgPqI=
X-Google-Smtp-Source: AGHT+IEJPqcz94gV+wDKD10A32pSng2GnEUN5E2b2FVVu+m50EW7cQtRC5UXqqxLk6Mynzke/5AnmlbfozF/hFpk8BmLmdu0Ulz0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:39f:7020:6a13 with SMTP id
 e9e14a558f8ab-3a0848c9ea3mr23325795ab.6.1726134382141; Thu, 12 Sep 2024
 02:46:22 -0700 (PDT)
Date: Thu, 12 Sep 2024 02:46:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aeb73d0621e8fa14@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_assert_warn_i
From: syzbot <syzbot+ffe01cefd437cbde362b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89f5e14d05b4 Merge tag 'timers_urgent_for_v6.11_rc7' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b54807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-89f5e14d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfc310daee41/vmlinux-89f5e14d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a92f22c06568/bzImage-89f5e14d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffe01cefd437cbde362b@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: warning: assertion "!qd->qd_change" failed - function = gfs2_qd_dispose, file = fs/gfs2/quota.c, line = 129
------------[ cut here ]------------
kernel BUG at fs/gfs2/util.c:414!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 76 Comm: kswapd0 Not tainted 6.11.0-rc6-syzkaller-00363-g89f5e14d05b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_assert_warn_i+0x2df/0x2f0 fs/gfs2/util.c:414
Code: fe 48 c7 c7 40 a9 4f 8c 48 89 ee 48 8b 54 24 08 48 8b 4c 24 10 4c 8b 44 24 18 44 8b 4c 24 04 e8 87 88 ce 07 e8 e2 73 ab fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90000e57328 EFLAGS: 00010293
RAX: ffffffff83e818ce RBX: 0000000000000004 RCX: ffff88801f3f8000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff8880119ec000 R08: ffffffff83e81787 R09: 1ffff920001cae04
R10: dffffc0000000000 R11: fffff520001cae05 R12: ffff8880119ec2bc
R13: 00000000000003e8 R14: 1ffff1100233d857 R15: 0000000000000126
FS:  0000000000000000(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f391d5a6000 CR3: 000000001e06e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_qd_dispose+0x4af/0x5b0 fs/gfs2/quota.c:129
 gfs2_qd_list_dispose fs/gfs2/quota.c:146 [inline]
 gfs2_qd_shrink_scan+0x2ae/0x360 fs/gfs2/quota.c:185
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
 shrink_one+0x43b/0x850 mm/vmscan.c:4795
 shrink_many mm/vmscan.c:4856 [inline]
 lru_gen_shrink_node mm/vmscan.c:4934 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5914
 kswapd_shrink_node mm/vmscan.c:6742 [inline]
 balance_pgdat mm/vmscan.c:6934 [inline]
 kswapd+0x1cbc/0x3720 mm/vmscan.c:7203
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:


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

