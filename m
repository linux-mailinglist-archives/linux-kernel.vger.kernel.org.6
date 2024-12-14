Return-Path: <linux-kernel+bounces-445861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF069F1C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4661166236
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DB282F4;
	Sat, 14 Dec 2024 03:56:30 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFB17BA0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734148590; cv=none; b=refZUgNC8UgtIEseR4mWbDeU2jpGKAiagS1qcjGnmmXwlL7HrhRGnAXMFDfIHzWj9EH1TjKdnwGqVYsDImdn9BrQXH3W7NQiADK6VIUGzKJPu3LoXlGdLl22ZaG/oI8edNSTSvp0HB+xkaisngHeEN+G2sioFu3bpxJN/02uaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734148590; c=relaxed/simple;
	bh=9bXlRvDRCP4i2xCKds9ODP9/fRkfDHOs2UMer8LkqjI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WibZ/3YkT8gccxAeGrK//vqz0/K5H79xxJtQ1cdSXLoUo4Pgt4+WwS2+Eb1/BTCpNjVY9buw32lxX3FQkpM4SGPOnD6VK4ASRfD9veoAVazCLja9Aj7nDSXOiDuIxp0e73DRBBa99IsPPDLqzNMPsNsId0ks1XGX3opK24yGvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso22377675ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734148585; x=1734753385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AP2AJfwK5g5z8pqFOpkvkB3dn0tXpBdm+8FdXH8XQMY=;
        b=IhA/EKJijzN68j5adznPQ+LU58nxP/TMxt3Dog5RQ/T+AAFgFvU2mxIzLRA32sLzBG
         jsJkULusBiK6vccwcqwx9b7il8onNp8zqvAKZuO2MYjZwyXqvl6UJSK1jUSMLlGqB4ON
         Y7tRV7mNd6k9OF+yXDorzuynM958kW3F6d2otMr1wVjRW+aR7JglPmSTXOLSR8gfOQ4h
         XYlmmMkQ2E1yeSyRyfW2ua95DfGOATH8mVGL/HlTWvrA+yioJVz8zqhCtjQ83io3LQna
         /y1q8LnqTshyEuqBmfb+3vsf3cI0lNLoixipP2ArNR/DK4uJNWHMzPKW60n1bTcKHZuY
         5SkA==
X-Forwarded-Encrypted: i=1; AJvYcCV9DvNIzif8i/WDiKkmb5M4q/zVNnxzQduHloD4kczL79Uw5R06s/wiCGVfpadpZqslDl6keL4zXbv3V+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+FE2fnGCg5E4Pzu5yPh69fly/z0dqo6N3mG6/jaj87nxGCQai
	Uu9FHT1UrRv16MHonr/3KWDC315iouOxMofT9Sviu+InFjMmoKhEqDeQdjrt74Yk7SXEeOCujs4
	EhcZtGfl85zHIpwaEo/ychayenRdneGOUJPQ4YkvYThtrbjCQjcwYYk4=
X-Google-Smtp-Source: AGHT+IFxn5+Veh5mxNqdDVnalMSvoRmu0z2zrhWPndzEOWAtfaOJI5BRcdvMMKQ0rGXuW4mO/jPkSkP1lJPWMCrfeyElItFL2Lu1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c569:0:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3aff794e4a0mr66293965ab.12.1734148585282; Fri, 13 Dec 2024
 19:56:25 -0800 (PST)
Date: Fri, 13 Dec 2024 19:56:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675d01e9.050a0220.37aaf.00be.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg
From: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e96b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=38a0cbd267eff2d286ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329dab/vmlinux-7cb1b466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe3847d08513/bzImage-7cb1b466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 80 at mm/list_lru.c:97 lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
Modules linked in:
CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
Code: e9 22 fe ff ff e8 9b cc b6 ff 4c 8b 7c 24 10 45 84 f6 0f 84 40 ff ff ff e9 37 01 00 00 e8 83 cc b6 ff eb 05 e8 7c cc b6 ff 90 <0f> 0b 90 eb 97 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fd ff ff 48
RSP: 0018:ffffc9000105e798 EFLAGS: 00010093
RAX: ffffffff81e891c4 RBX: 0000000000000000 RCX: ffff88801f53a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888042e70054 R08: ffffffff81e89156 R09: 1ffffffff2032cae
R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffffffff81e88e5e
R13: ffffffff9a3feb20 R14: 0000000000000000 R15: ffff888042e70000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020161000 CR3: 0000000032d12000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 list_lru_add+0x59/0x270 mm/list_lru.c:164
 list_lru_add_obj+0x17b/0x250 mm/list_lru.c:187
 workingset_update_node+0x1af/0x230 mm/workingset.c:634
 xas_update lib/xarray.c:355 [inline]
 update_node lib/xarray.c:758 [inline]
 xas_store+0xb8f/0x1890 lib/xarray.c:845
 page_cache_delete mm/filemap.c:149 [inline]
 __filemap_remove_folio+0x4e9/0x670 mm/filemap.c:232
 __remove_mapping+0x86f/0xad0 mm/vmscan.c:791
 shrink_folio_list+0x30a6/0x5ca0 mm/vmscan.c:1467
 evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
 try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
 shrink_one+0x3b9/0x850 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat mm/vmscan.c:6977 [inline]
 kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

