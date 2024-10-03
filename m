Return-Path: <linux-kernel+bounces-349478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA34D98F6CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C0B1C21F1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776A1AB6D4;
	Thu,  3 Oct 2024 19:10:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80238DD1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982629; cv=none; b=B4vzMgvh9x5nHI7p+fTeQrbAt4dVSrELkZgMt09Qb9Lo4BHHE138WYDbxYVaNflgaMo/Z31AZ3rFgb9idJ2cP+goDuLmmBJO1IXz+Y9S0SvjW/cJesGZHrShc4QhxTWnp9sCnBwInUQUe4I5PBE3RCO7rsCS4tj6plPLZSsIIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982629; c=relaxed/simple;
	bh=tIlyHP8YQlJunsIhxVQ/fac2Z3f5p1/lUu5BiQfPkf0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pxFzJ7vjBsvgk+p630nUer9MPu+PSu6JGHGZVAd6zdrpu94KxxXh7LcomXtAmIPBSyd56/q6mepqDpSTrihGhLT2NnaK2nxvgdlYvrFXslbWI8SPUp7wfyjos8oxOVBWCM9yL/luo9gpV3UKKBqM46S6+bQ2wpZGJVQe3srQqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8325010330fso134959639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 12:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982627; x=1728587427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDlR7B+s3yTh+LBBOJNrKl0WkULGNN+JmGj33uBpDo4=;
        b=Fuy/VHUERLiJIOQSUnfuoz2DHWzg14nTdLuYU5x4yE+SyuMUd1mJVOBaRcdJCkx0kL
         mjtSS4FynGBZfDNIQiuCJpCGCgJBtYFWNQ9pSL3Xh6ndvmXMeV5FWNJvQJKTzjcCxELH
         Ec+k/bux7vjBLGEG8fYN/SgZp5vKNbyOn7Q0uwYPdgBU2V2kZMCeEU5OQE2+bjDpqbxN
         /fYNGO1QVgQm8q8UaCzpvgPVCadKAyBxsTlWKRgnbpA0B9zw9MJvJiSijCSwtnVy0QuF
         PzDjHpSjRC3k+HgoshBKr/BsPUEYX5uba8fKu38cioNy0492yylwlvZLRS/Ciyer7H6P
         uSFw==
X-Forwarded-Encrypted: i=1; AJvYcCXnKTgWusHg07LZ1N6FbhasSTqqONNG03bsFKJ0dGcfgxaRhwIYeACAX264gzfoVGkAs0JzqkiqwdtnDvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDdfy1bpVFgr/+Jp9vWffDIJveFfJKtz+44UbQfk8xcFOqFiD
	UixN+zwxdYoAyD4ve+6+HgUteGzjyEWicySfH5jTwaCCIUqMZLkzmtguYroBBnlgiDNNnjrvtOR
	yh674s71MFkviLgQSJszeet7TwYkOQ0GYowRcj18zxVUxtRo9vYgv+Sw=
X-Google-Smtp-Source: AGHT+IE0siJiLWIH8n/SO8mPn6X3uCZ9RtjNk7UsJqNla/63RlbC80qmifd0FxO7JjAMcbd2Xeh8zUsHaPetEELlkln9+4Flx1/L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:9fc6:5437 with SMTP id
 e9e14a558f8ab-3a375bb7c44mr2383345ab.18.1727982627496; Thu, 03 Oct 2024
 12:10:27 -0700 (PDT)
Date: Thu, 03 Oct 2024 12:10:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66feec23.050a0220.9ec68.0059.GAE@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtInsertEntry
From: syzbot <syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164e8127980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84a3f3ed29aaafa0
dashboard link: https://syzkaller.appspot.com/bug?extid=5f7f0caf9979e9d09ff8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb021424c7db/disk-e7ed3436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f5f0d22ea96/vmlinux-e7ed3436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47176809b11c/bzImage-e7ed3436.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:3632:9
index 27 is out of range for type 'struct lv[20]'
CPU: 1 UID: 0 PID: 5469 Comm: syz.1.37 Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dtInsertEntry+0x174e/0x1780 fs/jfs/jfs_dtree.c:3632
 dtSplitPage+0x2d99/0x3ed0 fs/jfs/jfs_dtree.c:1595
 dtSplitUp fs/jfs/jfs_dtree.c:1091 [inline]
 dtInsert+0x14bd/0x6c10 fs/jfs/jfs_dtree.c:870
 jfs_create+0x7ba/0xbb0 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3595 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_creat fs/open.c:1506 [inline]
 __se_sys_creat fs/open.c:1500 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1500
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c1f97dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c20746038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f2c1fb35f80 RCX: 00007f2c1f97dff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000e00
RBP: 00007f2c1f9f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2c1fb35f80 R15: 00007ffdc44cf8d8
 </TASK>
---[ end trace ]---


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

