Return-Path: <linux-kernel+bounces-342961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A398952E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B37F1C21BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D140C152790;
	Sun, 29 Sep 2024 11:39:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC617736
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609966; cv=none; b=le5rrRAsHfTAvC8eOqvuNi8hAy/7AF/+oqbULBT5WF+7JJW9yfcTAjmGBukrHxWngVKkz8tNwn8BqN5hN8n6HXvQR6TxN7l2xiotSvYOG497DEXmJdfu1YfSnSjTTZLLWSXpIdaMMzeiaZCJxnvo5HVBbGDg7efOl+Vm0sAiqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609966; c=relaxed/simple;
	bh=hBWm3brtTKEXQJld0PTq+zCDu+hKRdhaAMnMhoyRO2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vdoa6MjzNv0ckQP0dKw8g0WAsRF1c7qYoUA5WLd2bSAiu5BYxyt/uBGOTm/1x9G/Z2fZj9mq0LDjPbI7xy7vnIC3OUs1yBRlsFIY6gN5A08BnF6aicb0n1pfLG9zckXs8OfhSGQ2wJCrDb9ZfW41f8gnxjK2fDnD+KjbfogHTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cf30e0092so298109539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727609964; x=1728214764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGsKv+FpL3A9q6h0ZFnz52oFqre73IC6TMcMjqaFkzM=;
        b=apdGH1KseVywsLwKHPk86ntOhlH6Hep9NwL2ZvQ9275kiabpBpTxLzvr9N1BxVxUA+
         vtjLQ3qr2OEOhNabNeZDR2aA/ZClziz+enHwFp110PWRnV4gIH4p95fdq68bBG/lvabT
         T1krsJXewZ5+z/ni36zcxGYbNgZ2LoZAEonN29TwSuovhSS7GmUeuRFulGRlIUMEAmUq
         rGkusBGIZGArd3uhREI9k2A5axFs8Ov4FPIixeJ0vEISSJg5lVtjuJ38H7zVmfhSrLes
         R/hK/PBc2eZQ+K4V/0rK5BehI2mELJKNhy5vWUZLfZWjL5IiH9fAF1ZMGGk+Bu7Bead2
         D6jA==
X-Forwarded-Encrypted: i=1; AJvYcCWGG8btdxA+J0R50OUFMhiCe1ym+EXal3ryyeWnFcS0aG/wQ+zgzIpXKmtTh+JsEbqL8woEiNQSCig7v/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLIyYCmfCd4Csaw019yXQNonwjJYZPIcdH022Jz96Qv8pA4e+
	Zn17Z/B6UzUx/K9UvTCkQATo8TtUOAn9nSEPr3cE2FgM3Sp640wamMIFGwAJ9gRjhWZrs9meeaa
	UO1bVLjSnIIBbu/7N8Wx3b022YZ/D+eqHsYzKvodumOqoi1h6MuxAauU=
X-Google-Smtp-Source: AGHT+IH2mBuVwWzYsBH3fceyzpEm+aduilzjh4fkHICu+fmDmiGtzr8860lu0y4YTjSEIDmN09HN2ekSUmpUpiY59GST9vQ05JMw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:3a0:a0a1:650c with SMTP id
 e9e14a558f8ab-3a3451b6ca7mr75454365ab.22.1727609964149; Sun, 29 Sep 2024
 04:39:24 -0700 (PDT)
Date: Sun, 29 Sep 2024 04:39:24 -0700
In-Reply-To: <000000000000b7b11a061ab49122@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f93c6c.050a0220.6bad9.000c.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (2)
From: syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, peterx@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=177e0127980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=0b56d6ed0d0c0c9a79dc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a7de80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b67507980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b5a4faec7a99/disk-3efc5736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/971adf9a5295/vmlinux-3efc5736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49516da34e16/bzImage-3efc5736.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5229 at mm/page_table_check.c:209 page_table_check_pte_flags mm/page_table_check.c:209 [inline]
WARNING: CPU: 1 PID: 5229 at mm/page_table_check.c:209 __page_table_check_ptes_set+0x3bf/0x410 mm/page_table_check.c:220
Modules linked in:
CPU: 1 UID: 0 PID: 5229 Comm: syz-executor342 Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:page_table_check_pte_flags mm/page_table_check.c:209 [inline]
RIP: 0010:__page_table_check_ptes_set+0x3bf/0x410 mm/page_table_check.c:220
Code: 00 6c 49 39 c4 74 1d 48 b8 00 00 00 00 00 00 00 68 49 39 c4 75 1c e8 60 6b 89 ff eb 0c e8 59 6b 89 ff eb 05 e8 52 6b 89 ff 90 <0f> 0b 90 e9 98 fd ff ff e8 44 6b 89 ff e9 8e fd ff ff e8 da b9 b9
RSP: 0018:ffffc90002fe7000 EFLAGS: 00010293
RAX: ffffffff820b7ac0 RBX: d7ffe7fff1ed7c06 RCX: ffff88801cba3c00
RDX: 0000000000000000 RSI: ffffffff8ea73b20 RDI: 6800000000000000
RBP: ffffc90002fe70b0 R08: 0000000000000007 R09: ffffffff820b7a8e
R10: 0000000000000003 R11: ffff88801cba3c00 R12: 6800000000000000
R13: 0000000000000000 R14: 1ffff920005fce04 R15: 0000000000000001
FS:  00005555848eb380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000076e54000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
 set_ptes include/linux/pgtable.h:267 [inline]
 try_to_migrate_one+0x2683/0x4240 mm/rmap.c:2300
 rmap_walk_anon+0x4cd/0x8a0 mm/rmap.c:2638
 try_to_migrate+0x3de/0x4b0
 migrate_folio_unmap mm/migrate.c:1326 [inline]
 migrate_pages_batch+0x113d/0x36d0 mm/migrate.c:1797
 migrate_pages_sync mm/migrate.c:1963 [inline]
 migrate_pages+0x2062/0x3560 mm/migrate.c:2072
 migrate_to_node mm/mempolicy.c:1095 [inline]
 do_migrate_pages+0x7ef/0xa30 mm/mempolicy.c:1194
 kernel_migrate_pages mm/mempolicy.c:1709 [inline]
 __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
 __se_sys_migrate_pages+0x6c4/0x740 mm/mempolicy.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd4c1b123e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3a5f83d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
RAX: ffffffffffffffda RBX: 00007ffc3a5f85b8 RCX: 00007fd4c1b123e9
RDX: 0000000020000040 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 00007fd4c1b85610 R08: 00000000ffffc000 R09: 00000000ffffc000
R10: 0000000020000300 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc3a5f85a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

