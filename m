Return-Path: <linux-kernel+bounces-263541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82FC93D77A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254471C22F54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59F17C7C9;
	Fri, 26 Jul 2024 17:18:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D311C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014286; cv=none; b=tnRq+DX5sWD0e+rHZuhLdICLZcdDW2kieYWakIfvAH8pr2Z63oxPoENryHCDtyLqdWBsTtrAfSM39g5gxelmltPfg3/LchzLoVZGHkdfe9Pf8aOM1gnjkOStCN/aUFBGSi2lUXaw/AX0z8kivgqePSZgmYDcu4ttJLzPhVypWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014286; c=relaxed/simple;
	bh=hAk9tSS6KrB9Q7/s8z/2D19I7YuQ8hsyVXUzLpLN1e4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YcGokg8pLrpcd4j/dAmSOaIFivzB5rip3IDq9lbzrcly0zejomtp10IzesOc6FkFLwVgMJ6lotYtt4uBpTefwU0TqmBqUfOYUpCVvFG4kSkKL2P2FY3P+BXNRpa4WQQr1ev5qPIt7xFp96TmcOcp8Jxp1GGtlDvYNdF9M2eDOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3987dace329so28295025ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014285; x=1722619085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbFCHuKsOVQmhgIz2OuhtCVxOwJfzQDTLiBU2A45lSI=;
        b=Epl4/agfyvEDAmqbGzaBvSYMrWgXQWR0s/D5ROBxJHxwY7XPPGUd4RD0oD7z+hORXP
         2OmDdg2d4pko9bRvi5+pdMu4Ucr9V/OetPrSz7Ksb83AzzG2asNh52WjEHtFFnE8BxkA
         LPD6gG4w+Dkpd9D6GJ7+pOeNvCeSwcsB1fW6yBBkRcgSdlv5qUcGbTZV3TycAz7EZOe9
         10FF2nNwzw5R3Ys1hWx/E6GuE3KQPm/sWXGQJ0pRo2lkV9ACX+kd7f5/VpZrIZSOV0Vx
         zj1xHjsigy8qGXLwrR4Rvd3eNtnnOD6z6JUk7E1FfwKiTr1qIPSNnk9wKNyKaKJhY55M
         Wi+w==
X-Forwarded-Encrypted: i=1; AJvYcCW48/li4v8JlHx3+yvL75skBbMyNj/Plna3VnM6enZcnMY8P0KbIgm4Imi3li6Ax7l2ZvjJMsMwQ5/qw6/yXeXKKS7cH/uqkDiQ/BPU
X-Gm-Message-State: AOJu0YydcB9YGV/t02LdoC2ULJ3OqBKadUDkGqmFgVAuyLrpbvQnWk/M
	Eqw35r9WuORyZg04dC5F/R390czjW1tpBxEjiyVcS0T/HUFkguHKvzMJFyFFnA/DF1SyumasSqP
	cQJEJVjSMADt6IS2UWbVZB3bqbkagJlXfIT/59bbsovOMiPVudJoIn6g=
X-Google-Smtp-Source: AGHT+IHPpsPSUKrQFbp7OGIVC2gJ7sKZn6O3KEV5tdUC/Py3Om20+/XD4eYYW+fpvs9DkOV3pUREiRe/CgrC7pK4z9UemsUtKuZQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-39aec4177b3mr19665ab.3.1722014284667; Fri, 26 Jul 2024 10:18:04
 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:18:04 -0700
In-Reply-To: <tencent_ED660A3CBD379296C036AA4A1A75D7771D09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc6e43061e29b172@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbSplit
From: syzbot <syzbot+dca05492eff41f604890@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in dbSplit

loop0: detected capacity change from 0 to 32768
loop0: detected capacity change from 32768 to 32745
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2629:27
index 4294967295 is out of range for type 's8[1365]' (aka 'signed char[1365]')
CPU: 1 PID: 5951 Comm: syz.0.15 Not tainted 6.10.0-syzkaller-11323-g7846b618e0a4-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dbSplit+0x1fd/0x220 fs/jfs/jfs_dmap.c:2629
 dbAllocBits+0x4e5/0x9a0 fs/jfs/jfs_dmap.c:2192
 dbAllocDmap fs/jfs/jfs_dmap.c:2033 [inline]
 dbAllocDmapLev+0x250/0x4a0 fs/jfs/jfs_dmap.c:1987
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1823
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbAlloc+0x658/0xca0 fs/jfs/jfs_dmap.c:888
 dtSplitUp fs/jfs/jfs_dtree.c:979 [inline]
 dtInsert+0xda7/0x6b00 fs/jfs/jfs_dtree.c:868
 jfs_create+0x7ba/0xbb0 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0x1a9a/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b4dd75b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b4ebb0048 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f3b4df05f60 RCX: 00007f3b4dd75b59
RDX: 000000000000275a RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f3b4dde4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3b4df05f60 R15: 00007ffda143f618
 </TASK>
---[ end trace ]---


Tested on:

commit:         7846b618 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16d89903980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176745f1980000


