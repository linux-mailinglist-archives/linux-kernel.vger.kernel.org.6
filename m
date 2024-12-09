Return-Path: <linux-kernel+bounces-436919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B69E8C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A911C18867F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864721504E;
	Mon,  9 Dec 2024 07:51:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104A5588B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730666; cv=none; b=bidQJtLaKvpZNg21/ArZYqIhymPZPqt461XrlVSqVT/OJzasteUQVPmyemAlSq2EB2Ym/o1JTOI8fZCfl4WS7DNo34OgyTFPlHFh4V4q/50OzdQsL6ynPn/0iGKKs1NDXj8w+RjLtgU4eSsEOQR6vq6CPDZAMpPQRgMGj4m5NXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730666; c=relaxed/simple;
	bh=XUm4/8q+1W6G/vk+WLxdngoM98hXYmDcLRSCPaMUzxE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UZU7qkmsr+zx3B/f02AtuArT8NBPR/E1IcO5cdJLOgm9V/GHykPUsN+JRu2wbzUiW7BtlD2yJveUUPZcTG8YVuOb77lhTGr1Sq4y/J2wHXKiE0T2B0CfNgXUX8ZloiaKNhqLnJ6IJqYRNewcRGbazLRPvIxmLY3H1a9SNuvl7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso25607825ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733730664; x=1734335464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsYXpWjeU7ykaU6U6w4TuxqgvQ7KYCYd7p2jWWg3weA=;
        b=T5fkFPfNLM8M7J6U/KDKqPCz8G97GNHpiuHqwot5DFsVa2gztW+8xjtmZo/ZahFuZP
         7NS2TkMUQHungErmdY0HqogScLidpPqbaxOevyKl8basakgyKr4RuDmF+EiEo6ELNYmw
         nA6spKkPhI8/gqZrkiEm5s3vmHcOHZUliVM4Mk7+ZCLLgxYm3R0lOEbP+4W6itRcfW/M
         w5th+8KfbCSaDt/ZJlQh04pcGJjy8ljF+fstPjsX2TsUz1COD+KiIJH5FSI2mUrwKPc4
         VoggDBLG3+QctDynJx/7DbOSbqpS8rUZLcW30ru0A4s+ej+XRWZq98yiuChAIZuhuloX
         Qb8A==
X-Forwarded-Encrypted: i=1; AJvYcCVz8Qow/8XcAgt7xvd/R0duPyCmIVn50Y9P2KOQqsc+TiGrHpUGvYqLHIg3KjFqFrl40DaebsaUMACRdLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcAklmFTKtEY93BdE/QfjxPlJJdISzcVSOPeDKTlynaa2LI8R
	C11j1vnGAqWvvGOVPUrgf2kHo5qlpBUSSWDQFIUzUz3Qyf4XK1U0EuYEjUU3cHNBgDxfuEAx5yL
	YEgqmjfwTCrooB+b/At25NwnM6XgiXDLGEJfrlJPjYskGvSueTfzPa8E=
X-Google-Smtp-Source: AGHT+IHMvpQK1wmfjhQ5NpODaHsHcgT1YoDGVgOm2bjy2BWpWLN7xjIRA9kXBRbQWQCrqnhkDfCBRYEuEe5mRjuplx0WP+2XlD0l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca2:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3a811e0c0a2mr114042025ab.18.1733730662678; Sun, 08 Dec 2024
 23:51:02 -0800 (PST)
Date: Sun, 08 Dec 2024 23:51:02 -0800
In-Reply-To: <f97193a8-b41f-48e0-a75c-4f769124675c@bytedance.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756a166.050a0220.2477f.0039.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
From: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in move_pages_pte

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6741 at mm/userfaultfd.c:1188 move_pages_pte+0x26bb/0x3400 mm/userfaultfd.c:1188
Modules linked in:
CPU: 0 UID: 0 PID: 6741 Comm: syz.0.36 Not tainted 6.13.0-rc1-syzkaller-00172-g6e165f544379-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:move_pages_pte+0x26bb/0x3400 mm/userfaultfd.c:1188
Code: 8d ff b8 f5 ff ff ff e9 f9 f1 ff ff e8 de 41 8d ff 90 0f 0b 90 b8 ea ff ff ff 48 89 44 24 18 e9 9a fb ff ff e8 c6 41 8d ff 90 <0f> 0b 90 eb 14 e8 bb 41 8d ff 90 0f 0b 90 eb 09 e8 b0 41 8d ff 90
RSP: 0018:ffffc900034871c0 EFLAGS: 00010293
RAX: ffffffff8212016a RBX: 0000000000000000 RCX: ffff88801fbb9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003487600 R08: ffffffff8211df31 R09: 1ffffffff2853d10
R10: dffffc0000000000 R11: fffffbfff2853d11 R12: dffffc0000000000
R13: 0000000000000000 R14: 00000000321be067 R15: 0000000000000000
FS:  00007fd136ec86c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd136ea6fb8 CR3: 0000000031194000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 move_pages+0xdd7/0x1600 mm/userfaultfd.c:1742
 userfaultfd_move fs/userfaultfd.c:1899 [inline]
 userfaultfd_ioctl+0x518b/0x6770 fs/userfaultfd.c:2022
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd13617ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd136ec8058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd136345fa0 RCX: 00007fd13617ff19
RDX: 0000000020000080 RSI: 00000000c028aa05 RDI: 0000000000000003
RBP: 00007fd1361f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd136345fa0 R15: 00007ffd06723498
 </TASK>


Tested on:

commit:         6e165f54 mm/page_isolation: fixup isolate_single_pageb..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=14142b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3884fb5fa6f2533c
dashboard link: https://syzkaller.appspot.com/bug?extid=1c58afed1cfd2f57efee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11245944580000


