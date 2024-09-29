Return-Path: <linux-kernel+bounces-343037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9E0989618
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805A3284C22
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48917B41F;
	Sun, 29 Sep 2024 15:22:33 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C618C31
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727623352; cv=none; b=GXSbj+7N1Zlz0/ae38CEGzCpk0mwQNOHt6cgg/i8btmk83PK8w89y4diaago0sq5JScaOnrEdl43C12MWsb1enBP6NOTPIT6TjJHvZxGluuCWrS0RqtYYJqwy8C5L0oZHGf46Y1voKxJIia6J78qfzmGSlODipe1J7Fw3hm4lNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727623352; c=relaxed/simple;
	bh=2ex9y0UsAPBlrPOfl1FUXYE5dT3frzyx3jDpwpdno7I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OhWHaW18uG9dAcK/hknbBufz6IG8/wLcfcj+c8+wIn09Nthpjm+ldiXzDz6ehhgPFieIxcYs9uV/sNGma5vuxG3NBwAyL3H5bSbUtZIahKEjbzaN0gxAJJLNGq2jOhIYLg4vhMBSNiinDISYT/+IbeRXrohi3+tHSRXVRWFfZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aa4678394so465404339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727623350; x=1728228150;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKwGfbNeJAtsIYhH979/UVUtLhmIoByeYMt6WVw6JG0=;
        b=V9Bf/Syr6dPlG55y0kiHe6ImoTa9aYKpVZ+noraNyP+2HqhB5vAP19rHpQwQRydr0n
         djtWLe/4czmw2ru3ufoGSDLqcJZnWVQBgqmd1L6YZJ9Mkd644UR+o69Ugtk8Yolecinc
         tDj1pEKkroM1RagwoWD53KpvS/oRohplJrv5twFXzCQ+y5+pSqIECbUVgvbENGv3H1bO
         DDS+E9N1jMvyz5eBX/OHl7n5qeY5uYBWvbORlZM8IWMNMcNwuh1ClkfEQDFojIefg6LS
         bCxBQZHXk97FlUy4GG+eeMhuWsSyztySG/B8pqC2swu1h/9Y5IrVBdmpap1I1LbezdQ1
         K/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWN+ClhqtrdCtQ1OTTRix7GOKjAJAimK3YDnLSedVqo+64N0lJuOFUCg49pWs/Aa0si5xI3fpkbecZll8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxt7oYFOZPeel5iyhpSKjyeetRoEA9lhUVKO1cGNOddzpqJwVs
	NAwetOkUQJX/5ZItxZ54MO/aBW4vt7IIE5tc9iV4AjOeGOrVsPzaaVH+YSbBP9kTO+htHnExrig
	As5QZwU+ETDq206t7GlevBWZGOCd74iS4+HFD8OjA64lFZhqdcqA5QD4=
X-Google-Smtp-Source: AGHT+IH8jlOx3Vo5HWli/Hxb2cni/8759hXOSCk1x2fiNXKQSlODEvqhOq0Gu9RaiQG/5abR4DQZ2PPYp+RcUZ83ZNuv7Q/+6hcn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b23:b0:3a0:ab86:928f with SMTP id
 e9e14a558f8ab-3a3452cfda8mr60038855ab.26.1727623350448; Sun, 29 Sep 2024
 08:22:30 -0700 (PDT)
Date: Sun, 29 Sep 2024 08:22:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f970b6.050a0220.6bad9.001a.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_page_mkwrite
From: syzbot <syzbot+c3ef47c4433fe4281f50@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    684a64bf32b6 Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1518ca80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd75e1a00004094f
dashboard link: https://syzkaller.appspot.com/bug?extid=c3ef47c4433fe4281f50
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-684a64bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f05b4b08a420/vmlinux-684a64bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d59f9edaf3bc/bzImage-684a64bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3ef47c4433fe4281f50@syzkaller.appspotmail.com

Buffer I/O error on dev loop0, logical block 11096, async page read
Buffer I/O error on dev loop0, logical block 11097, async page read
(syz.0.0,5102,0):ocfs2_extend_trans:438 ERROR: status = -30
(syz.0.0,5102,0):ocfs2_try_to_merge_extent:3809 ERROR: status = -30
(syz.0.0,5102,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
(syz.0.0,5102,0):ocfs2_write_end_nolock:1967 ERROR: status = -30
------------[ cut here ]------------
kernel BUG at fs/ocfs2/mmap.c:107!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5102 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-10547-g684a64bf32b6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__ocfs2_page_mkwrite fs/ocfs2/mmap.c:107 [inline]
RIP: 0010:ocfs2_page_mkwrite+0xec0/0xed0 fs/ocfs2/mmap.c:144
Code: 06 50 05 fe 4c 89 f0 48 83 e0 01 75 0a e8 18 4b 05 fe e9 44 f7 ff ff 49 ff ce e8 0b 4b 05 fe e9 3c f7 ff ff e8 01 4b 05 fe 90 <0f> 0b e8 f9 4a 05 fe e9 3a fe ff ff 0f 1f 40 00 90 90 90 90 90 90
RSP: 0018:ffffc9000b0a7540 EFLAGS: 00010293
RAX: ffffffff838f6a3f RBX: 00000000ffffffe2 RCX: ffff8880006d2440
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 00000000ffffffe2
RBP: ffffc9000b0a76e8 R08: ffffffff838f678a R09: 1ffffffff284d117
R10: dffffc0000000000 R11: fffffbfff284d118 R12: 000000000000e000
R13: 1ffffd4000270684 R14: 0000000000001000 R15: 0000000000000000
FS:  000055558f8ee500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000e000 CR3: 000000004b98e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_page_mkwrite+0x198/0x480 mm/memory.c:3162
 wp_page_shared mm/memory.c:3563 [inline]
 do_wp_page+0x23d3/0x52d0 mm/memory.c:3713
 handle_pte_fault+0x10e3/0x6800 mm/memory.c:5767
 __handle_mm_fault mm/memory.c:5894 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6062
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f815a94740c
Code: 00 00 00 74 a0 83 f9 c0 0f 87 56 fe ff ff 62 e1 fe 28 6f 4e 01 48 29 fe 48 83 c7 3f 49 8d 0c 10 48 83 e7 c0 48 01 fe 48 29 f9 <f3> a4 62 c1 fe 28 7f 00 62 c1 fe 28 7f 48 01 c3 0f 1f 40 00 4c 8b
RSP: 002b:00007fffee1acf88 EFLAGS: 00010202
RAX: 0000000020009680 RBX: 0000000000000004 RCX: 0000000000000b8b
RDX: 000000000000550b RSI: 00007f815a21333e RDI: 000000002000e000
RBP: 00007f815ab37a80 R08: 0000000020009680 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000002 R12: 00000000000120b8
R13: 00007fffee1ad090 R14: 0000000000000032 R15: fffffffffffffffe
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__ocfs2_page_mkwrite fs/ocfs2/mmap.c:107 [inline]
RIP: 0010:ocfs2_page_mkwrite+0xec0/0xed0 fs/ocfs2/mmap.c:144
Code: 06 50 05 fe 4c 89 f0 48 83 e0 01 75 0a e8 18 4b 05 fe e9 44 f7 ff ff 49 ff ce e8 0b 4b 05 fe e9 3c f7 ff ff e8 01 4b 05 fe 90 <0f> 0b e8 f9 4a 05 fe e9 3a fe ff ff 0f 1f 40 00 90 90 90 90 90 90
RSP: 0018:ffffc9000b0a7540 EFLAGS: 00010293
RAX: ffffffff838f6a3f RBX: 00000000ffffffe2 RCX: ffff8880006d2440
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 00000000ffffffe2
RBP: ffffc9000b0a76e8 R08: ffffffff838f678a R09: 1ffffffff284d117
R10: dffffc0000000000 R11: fffffbfff284d118 R12: 000000000000e000
R13: 1ffffd4000270684 R14: 0000000000001000 R15: 0000000000000000
FS:  000055558f8ee500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055af02d95058 CR3: 000000004b98e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

