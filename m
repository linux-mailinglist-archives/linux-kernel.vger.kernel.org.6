Return-Path: <linux-kernel+bounces-286393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20B951A63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA7E1C20C75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91001AC43C;
	Wed, 14 Aug 2024 11:51:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC85143879
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636288; cv=none; b=Ig4tyHVGiRsHp2EhKpyil/YwT8jL+65qdr1lBCmeGP5yxsyF4tn8XOUTTbzsuy4qxWvwCxxMtMq8WMgzFcS7HVadI85V8wtHFqMMWVNtW9Kc8oI6uqrUbxgFXKXMS3liYGcFhPlR4nJWbNrAGtTqqvdPsAxiFiIpUSEMq3r1crU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636288; c=relaxed/simple;
	bh=YaiBRNJtWXyugg1Rf+o8s3VdLGcWCkwZHSM/owKJpWI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RhO7vPq7UKd0CXTgHogljsbihxtF0yTBcgWcvIwNJZKEyGvFf5gKins0iKrV2Vxya760lv/H+4rGB/saAdD2BLcgoLz9co9wdlmRIi2sBe8I+zub1nrQVsI4fhYvPm1RHWTPFkrcHVnftDjAY1L1R9a1cdeiColmvpglakGiDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so800192639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723636285; x=1724241085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfhPFen+pJGtXri7WMYT8g/C8iSfG1cnFgoXyp9YAIA=;
        b=h+Npx5lrlGJuZYVFo9ggSk2nTR1sdTZaP7NpniEvdz7MYT2/C8vy2HM5IbIfjyhcEH
         517OTD1fDqHndNjq11maw8+bfpvIm/ObB59tPbtHOJ7yRBQWbwtgYfdhXO8cNci2xpPp
         fBjLSXZgnlJshhrL1gM72ZJXxGQEFI0ZsYxl4J/9Rj2bTD+dK4RcnzRwSkxMmCoD2SAK
         3NFSn6GF6UVefX18Xera7nk4BUKDbjH+/6uO5vLN/1WrEXJ2BjjfaEUuwkGguyriqaun
         ExDDIpBkHi8mNP+fV8Gnqp27lBaE6JFXeYTpBqpi4fOIFHxVOd5uAFYkEdIV2gY+3eOf
         IIdA==
X-Forwarded-Encrypted: i=1; AJvYcCW1AxxzTtoVq3OYAp72ItBKYkPKuEm8O0O5lWrcMUNjw/1tmUQGlmBrMJqlAQKQ96X+scIsiJm2zDwXHMtJbJjm3Or0t25hrzss45+e
X-Gm-Message-State: AOJu0YyGNatGGAvL6p+XKIo4mWYHde5sYB8Y0uRoZDLyjnGhCbgXt6y5
	brEmRp/AvYPoE2TqHWbflF6RXjW3FjbOf0i9zbrJXVffXbaYx38TbIn1guXJ5z6W1gbwadBBZyK
	2gTsGhf1L//Rq9igxSBahGAo6GQvKz75ovDIHYI5A8IYXnSUxcqx0nK0=
X-Google-Smtp-Source: AGHT+IHnms+5nTtcNuZshswUQpu1bJOfgn0qohq2NYn9uBNUrbcfJSU6xBHQ46OzBj/w8kmk+ylzaeIIX5haxI+6UaERRc1Wlw0T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2501:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4cab0a2d383mr138659173.5.1723636285040; Wed, 14 Aug 2024
 04:51:25 -0700 (PDT)
Date: Wed, 14 Aug 2024 04:51:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dfbdb061fa35855@google.com>
Subject: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_ioc_start_atomic_write
From: syzbot <syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1431e405980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120ed77d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130e0ef3980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/08b48c782593/mount_0.gz

The issue was bisected to:

commit 374a8881ce4ccf787f5381a39f825cb17a3f6b14
Author: Chao Yu <chao@kernel.org>
Date:   Tue Jun 25 03:13:51 2024 +0000

    f2fs: atomic: fix to forbid dio in atomic_file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10741429980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12741429980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14741429980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
Fixes: 374a8881ce4c ("f2fs: atomic: fix to forbid dio in atomic_file")

F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
syz-executor312: attempt to access beyond end of device
loop0: rw=10241, sector=45096, nr_sectors = 8 limit=40427
================================================
WARNING: lock held when returning to user space!
6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
------------------------------------------------
syz-executor312/5227 is leaving the kernel with locks still held!
1 lock held by syz-executor312/5227:
 #0: ffff8880695aa0e0 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
 #0: ffff8880695aa0e0 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x2ed/0xac0 fs/f2fs/file.c:2163


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

