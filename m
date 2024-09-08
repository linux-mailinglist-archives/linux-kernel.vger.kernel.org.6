Return-Path: <linux-kernel+bounces-319972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173497048F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA201F2206D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 00:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E07F6;
	Sun,  8 Sep 2024 00:06:22 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFD181
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725753982; cv=none; b=iY9cQ+swnkrR2GfnbDrfRwWUg+Pfs1nNYJGBMyfhxBB2KB6gDoJw9MppHDq7ZiB9FcHndZVT/pHTUsvXjMd0PIT6xKo87znhjhoetkyEebMzdNa0DHOtQqqzXUq4yKlJm9u8KguWz1Yn0nTEHlEj2mlwtceQGq4AFaqPQ8vNPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725753982; c=relaxed/simple;
	bh=GoaGMT8U41Lz/I9fuKIkEq1p8AqK4yiH0CZrkGfIkPU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lAR2/YGpLiXRQt8UwrYWwRZ6tOZ1/oW5hvOvrAiTRCKK/SdKzlAqXYqVyEVzxeiIl074k8YfkgHakDc3QjZMjK0Tf1eH4S/ZZZ4/OBJeyZkmu91fajH8Owe9f7L0g5IYzbIiDPpEfOxDtq37KIB+DczCRg1k4qNw02I5TXEskFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d28a70743so61035095ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 17:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725753979; x=1726358779;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuGPLBYHmZNmIrhx/QwJcLDDN7l/h+kf2hJL7HUrSDA=;
        b=I/hzQXwcjaywh2KuIZaDKvuGmcXuf3DE0VwPbbC8rw0Hldfh+A/mWdIDM3ywky7/QN
         rHFX9J/wTPOFseE21pfa6oR74nZDUUJyGNDDaCVm4GicnX6rDPxzxxFhVhkwQFohzoFq
         pKPgbb/f9dAvwJRkdSLPtxVX0jKZhRz95gPKexyhZQVMlStagYE9nFC4YGbMvhEzIXlR
         o29L+wSURmE595/QmMbksN9AogBPURissIg+Dv8PvVySaKEQNba8GElxoV4HA9GLhC8i
         fOcUtKMAL1gXA9bprekXU9CRxT27HStHtx3NFnIErJ2lksJak//494TN+8sJTPvLcZFj
         6Zvw==
X-Forwarded-Encrypted: i=1; AJvYcCX7nzou5TzwuwLYERbz/x9ZLTinxBSPrDDPSfDpR7JtVkhAO8C1bKaHkNbVf9/TZp9mzz8seo6vNlVzfv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkoqrjpsQgflnHIB9JXU0keFMZON+S+zi138mD+oK2ouWfMeR
	wbdnn5v1pX/u1h6pIsPRAwYH8KIddiUXb00GL/XrRyoT5a9wt0TJp5CLZe0hw6hUI4wP7xtoOFJ
	ZBbU77MPKwEJVVq7RVEl1voczltyhCUnJjQoLrr04suBlnEhwbQ8jLEE=
X-Google-Smtp-Source: AGHT+IELstcxdUngd7MkmNZBwnkYAdOx0Z0+sTM8BB0Nn1FV9s1mbtPZ1ivkBNkjkzcoGykTw3gSIwjpo7uKNojYUP4BSZjDmteK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:39f:520e:7279 with SMTP id
 e9e14a558f8ab-39f74fe9275mr100228375ab.3.1725753979547; Sat, 07 Sep 2024
 17:06:19 -0700 (PDT)
Date: Sat, 07 Sep 2024 17:06:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebc1a306219068a5@google.com>
Subject: [syzbot] [kernel?] WARNING in get_pat_info
From: syzbot <syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    67784a74e258 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ac82ab980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=931962fa28089080
dashboard link: https://syzkaller.appspot.com/bug?extid=16b1da89309a06cd0e3a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5d04638ac9ee/disk-67784a74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b56a931235c/vmlinux-67784a74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3b447615c560/bzImage-67784a74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7739 at include/linux/rwsem.h:195 rwsem_assert_held include/linux/rwsem.h:195 [inline]
WARNING: CPU: 1 PID: 7739 at include/linux/rwsem.h:195 mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
WARNING: CPU: 1 PID: 7739 at include/linux/rwsem.h:195 follow_pte+0x414/0x4c0 mm/memory.c:6133
Modules linked in:
CPU: 1 UID: 0 PID: 7739 Comm: syz.1.945 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
R13: ffffc90004cff530 R14: ffffc90004cff550 R15: ffff88801e6e2600
FS:  00007f7831aab6c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c379ecd CR3: 000000002ad46000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
 get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
 unmap_mapping_range_vma mm/memory.c:3734 [inline]
 unmap_mapping_range_tree mm/memory.c:3751 [inline]
 unmap_mapping_pages mm/memory.c:3817 [inline]
 unmap_mapping_range+0x1ee/0x280 mm/memory.c:3854
RIP: 0033:0x7f7830d79eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7831aab038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f7830f15f80 RCX: 00007f7830d79eb9
RDX: 0000000000000300 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f7830de793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7830f15f80 R15: 00007ffd316c3c28
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

