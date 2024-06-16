Return-Path: <linux-kernel+bounces-216408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F3909EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A941F233FC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDF3B7A8;
	Sun, 16 Jun 2024 18:00:26 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AA24B34
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718560825; cv=none; b=E6lp5/GEgXmPcfzZhvHdlmd0XRVX+iAMYaO0O0RgMMfAA7U7zolNwPkqHy8NEOs6rQBnZlxijupnT8XmVTgStyaenviOwOnCmUgCqMtkDoKJ5CsT2s8hZjhteRSJ0ZO9X9qq7wxDll+wVuhmS7A3TrFCAgRpThYh2mIZZQU3sO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718560825; c=relaxed/simple;
	bh=+fzPigpqqCtdyNBac5peDLXSMz+u8kTHjXJcO2VKKY0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I/JA106foa4nTUnhv3GEtyRLFVB1VPj91GoEiiSRdXZUiieO9LHxEkQshUwLgVUmJXqxm4Wt9e6BwrBTjN1MpdP9AMi2UfcTBtJC1K4cgAn3yQMNhIzwLxju34gUr50MggfGwdmtKRxaj5MnN1p1djB1mJ0fVaZ6D9GgfEOf/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb5f83ae57so395542839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 11:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718560823; x=1719165623;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6Vx5rRDiMnr7zNSuIUNeaQO0x6H1lSVNApyoo9r05E=;
        b=NVnB0WJBHC8X1wuYu8P1D6MUgsH0Y5tG1sqj7Ns67vFvTqxAcPUXhGzA9mR/8CxsxH
         57e4F/J8pUnQzU+H1elXJnXl+IqnV8mUQhD6Px12veuNBGQNG3loaSYrpncjDsSIRyyS
         wdD68lj14EQ8X1Y5j9WbntrB2DuVGuzTGYVRul2qby7u2sIznGtea83zhwfSMajwBoug
         W/FAGFRzhPK/cX6g0VoEyvB9NwyyzOXHAMN3UPvJ8URf/yleo/u390RZ9EbtCTNDnSgA
         42MYzol6WQ2M7fUxYUBmxyYki6xMAGbiyrIz2mZ5moIazR6H5DEFixjUKoYaEDkVwte+
         AfxA==
X-Forwarded-Encrypted: i=1; AJvYcCUiGUOdB9ZPurNCQA2ZH5Z1VtMbfeV9fsLMO9VCh2v+vx9H70tsIF2DyUrRqcSgm8BUMsXvYhwXxsRN9Bt3wVE6G6bK3UusXSP9pUU8
X-Gm-Message-State: AOJu0YwU4AtK+ntlAS5USWIeHUYoXtwgUq3XpkPOE0UgasVevnfNfU8s
	Qf9s4r/LsuWbE6kwMGHETils++DhSF6JKnBSm9crQ9KpUiwoCCdZSCA4dNM7j7aJPC98oM8KHP7
	kO+I+VOyzocxIVZKfcJtoDzLV9zD5JSqcACPSJf9+d6JSN6YRia9EIG0=
X-Google-Smtp-Source: AGHT+IEnNQFapInZa9RWHbA4geAl1SxX21EsCPrsi+Ev7n9EoF/IG+EbV4iVjwcTxa8EjJ9Rg8C0BMpalIeGjRtNysfgJX4vJRk5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40aa:b0:4b4:5040:f29f with SMTP id
 8926c6da1cb9f-4b962b4b3c4mr362827173.1.1718560823101; Sun, 16 Jun 2024
 11:00:23 -0700 (PDT)
Date: Sun, 16 Jun 2024 11:00:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062d903061b059fb4@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_send_disconn_req
From: syzbot <syzbot+e70cc8721ff61d6bebda@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ef5971ff345 Merge tag 'vfs-6.10-rc4.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122b5b6a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=e70cc8721ff61d6bebda
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68c14576ffea/disk-2ef5971f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e404ec95932/vmlinux-2ef5971f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b486b23228a7/bzImage-2ef5971f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e70cc8721ff61d6bebda@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at kernel/workqueue.c:2281 __queue_work+0xc5e/0xee0 kernel/workqueue.c:2280
Modules linked in:
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.10.0-rc3-syzkaller-00021-g2ef5971ff345 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events l2cap_chan_timeout
RIP: 0010:__queue_work+0xc5e/0xee0 kernel/workqueue.c:2280
Code: ff e8 46 83 36 00 90 0f 0b 90 e9 20 fd ff ff e8 38 83 36 00 eb 13 e8 31 83 36 00 eb 0c e8 2a 83 36 00 eb 05 e8 23 83 36 00 90 <0f> 0b 90 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d e9 17 9d 50 0a
RSP: 0018:ffffc900000e7870 EFLAGS: 00010093
RAX: ffffffff815fa3dd RBX: ffff888015090008 RCX: ffff888016eb8000
RDX: 0000000000000000 RSI: 0000000000200000 RDI: 0000000000000000
RBP: 0000000000000020 R08: ffffffff81628b19 R09: ffffc900000e7940
R10: dffffc0000000000 R11: fffff5200001cf29 R12: ffff8880245d49c0
R13: dffffc0000000000 R14: ffff8880245d4800 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020aa3000 CR3: 000000005e458000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2410
 l2cap_send_disconn_req+0x28e/0x440 net/bluetooth/l2cap_core.c:1487
 l2cap_chan_close+0x378/0x9f0 net/bluetooth/l2cap_core.c:826
 l2cap_chan_timeout+0x142/0x360 net/bluetooth/l2cap_core.c:435
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

