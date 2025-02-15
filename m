Return-Path: <linux-kernel+bounces-515978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6CA36B82
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C115116EA42
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD5154BE2;
	Sat, 15 Feb 2025 02:57:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF93EACE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739588225; cv=none; b=FVLfctKuG/KJkUIFpbKfOygOK5QA2OCB+zO+n17UKK2wCh8upGOFt5NpB71KO2yIQ40pq75/idD55Sdb7807avKrKpS+PYyLW3iCr2eXLF+73i7Cs2FXu62hr6eUr+yrJKuBriS5NPWMzuyS8t9bwU4xsWvHwIohwpUNPmC49QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739588225; c=relaxed/simple;
	bh=25LXtwiQw6BsOH0XDN3AHo2fupe78MahrQ6JcmW4FSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mgd+a/oTUJA1PqMi9vTyqa+H/wTfz/htXcAFO4TPFoFRXfEDwcpeu1J8FuT6Yzl/i1sgH4XPETAfpCoPDpQYrPcvQh7ugFHFzIUldKG6KQmctxdwSFWkfUUAWbo2nFuwrSuhebMT/ZwxR321fi3q3VtZhRrFqRWW0ThWGLQta/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so46962065ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739588222; x=1740193022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewfXyiseps2ZVeaT/Lt3xVkEFfQYiqAXMTKnxIzxV2Q=;
        b=LeOfSop8zDyaJNlrwNTBW+13rtYLt+cRKtkWE4gtPO+hs28gV3TeZW0V381ZC41mcC
         a1L4I5iPxLo5RI9+Pp0NQE238eYN3BPdDCsmRzcNlwP+GknR9YGy1VRKW6mEuBk2ibwz
         BJpLiSNGIbEyO0puXt8pRGtdwsxPAmqN6f894EWOKtir24nsj0m1E8O6jwx0mi1gM7rz
         YUcYjmwfUrP/bZcwSmgBo9pGGY8gz4ngDNvoxRjYK97PAy8HD0mDEDS3g6AG9NpOlp9u
         DCC5HJclql+oCzH1qVNSyGkQ+NFZFXlQTzOMuc8LIh7bmjW/hcXf0/30wMwraizz4YHo
         lo6A==
X-Forwarded-Encrypted: i=1; AJvYcCWeXoXNHK4CVMClgDFz9nNeee6ECBHOhzUTq1+tWxaLLrtTr50SDeygbilfrhjhRQwjW2ck1sfAHdmisqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcik12uGIbzCAY+mI2oIuSEXzborfZ33vmMEN4b5TzomKr7m2P
	66j+05gyv3OT2NsuS4NhBzVS/rXhgx25cuslkz54+l6hphQxCtEOtvWUx31L0SSsTzH1PecDgFR
	2Pe34jwqhn8YE/A/N3gE41P1Mz+n/39Wy85OowlP58Y+baC7MaOV6XKc=
X-Google-Smtp-Source: AGHT+IGf2axYUBnFHzmQi3n7DOXMhhUkxUqG13bvyVc5jF0l3zmd8X/l8/gFHJ7M9l9cYIIxN/iYR7hy0luwhdyZgBtgV4k+oE9D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138e:b0:3d1:a1d7:ea5c with SMTP id
 e9e14a558f8ab-3d28078d499mr13666905ab.2.1739588222558; Fri, 14 Feb 2025
 18:57:02 -0800 (PST)
Date: Fri, 14 Feb 2025 18:57:02 -0800
In-Reply-To: <tencent_7E9E251B1E4B791BAD2507BA27BB48330008@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0027e.050a0220.21dd3.0063.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in netfs_put_subrequest

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 81 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 81 Comm: kworker/u32:4 Not tainted 6.14.0-rc2-syzkaller-g78a632a2086c-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_read_collection_worker
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 c8 5a f5 fc 84 db 0f 85 66 ff ff ff e8 1b 60 f5 fc c6 05 d7 5c 86 0b 01 90 48 c7 c7 c0 00 d3 8b e8 77 99 b5 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 f8 5f f5 fc 0f b6 1d b2 5c 86 0b 31
RSP: 0018:ffffc9000162fab8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a1229
RDX: ffff888020af2440 RSI: ffffffff817a1236 RDI: 0000000000000001
RBP: ffff8880305354a0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000005
R13: 00000000000006ed R14: 0000000000000001 R15: ffff8880305354a0
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7675a2f98 CR3: 000000000df80000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 netfs_put_subrequest+0x2c1/0x4d0 fs/netfs/objects.c:230
 netfs_collect_read_results fs/netfs/read_collect.c:300 [inline]
 netfs_read_collection+0x25af/0x3d00 fs/netfs/read_collect.c:422
 netfs_read_collection_worker+0x285/0x350 fs/netfs/read_collect.c:469
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         78a632a2 Merge tag 'pci-v6.14-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123719a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a667df980000


