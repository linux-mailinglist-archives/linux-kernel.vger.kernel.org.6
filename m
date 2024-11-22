Return-Path: <linux-kernel+bounces-418397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D449B9D612F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509741602C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17B1DED45;
	Fri, 22 Nov 2024 15:15:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7413B7AE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288527; cv=none; b=vEAHUYcaJgsKtrlVKWw4J9eAuS5HPfWgvwwCeUvy2FitjZMeKnj/dufZAFj/UolbUpX4UBUSrZwd3MWS7ZgsmyiKxjflqgFWFT/+OTOJgr4S/n/jbBU/YQEPfQlwnDX8Kin8WzqbNHj7shCrk/KJSTP4P+hsx1DMQJB2FMuOk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288527; c=relaxed/simple;
	bh=Tl8e7v9TjYvFBHVAXy9aU10C0/yYOIAV2I5vXzz/iFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mb1V/uGmIJpmadm5WaIOd/SeTXOeyD8jLh7loxsHYlodAFPHbrzsZHTcL0y/lRcT1JBmfkdGxaWNkT46XjOGeXMLc6UWlS+cfchKgJnFQOVHEEUCpZNAtoAytibRJFDj6LaYmAG94bB2M4kngTNYf59QRNpej7jfIDTIrLq7pSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abf68e7ffso234263839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288524; x=1732893324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SrO8vy57FZ8eN/3j1OlDffZ87aJxX3WYR1dSwXbPFk=;
        b=XYOeoo8RQqUM/GPcxsSrsC9KqAxQqtp/ZER7+A9ANjuiBgGYM9FE+Ti48sfn2V3nti
         S8TIUM2BJ7WSRHqBRNIGkUbile6suT4UrhFiy2fEHBvd2rJooMDZc3kxCcwDDp3uWo+o
         nZRVYrcTvtEvPy+bg/uw5a/RLfKR3UOC7pdXh/Xe9y99xABuGYhMUTZgTZ2ZLHKI2ja2
         vS+zY9C2jGzQ9aNkCaKb38mfHRvJaxmbr+jDfYQsV0Z+dnyYYMN68GzNcCh3nMW8NAYp
         AUMEbeBD3fi0NMdvlsgW+calXkEl3jwUl3HjlcV2uOQvW9gLv+0jnsXWaRfoQ+7CG53C
         uQKA==
X-Forwarded-Encrypted: i=1; AJvYcCWg8IiUiWvqK2sTrwBeQQvGOselnP3EOjVD2BKNpNdnl0+QgdQXnvCdR51W3sT8ANsvs9F56Ks+KhFiW+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6bl0GE8lrNky6QH7W8b0JmwYfT2NnhjIMtERbmPP25UxYsmY
	NeKLcURlsDy9ye/e7pPsmLhT5Cedh8ffaoRvZ3BEWUZQvaocNbzbHdqrV1h1F2H16EV/RWXlDNm
	UWxaVu/MFsoLFALaWHCAxrmGFduod/3sUwfkD6cOoylcJwDa14vhtjtA=
X-Google-Smtp-Source: AGHT+IF/IPWNFHI+m+yrYAgnH7oKaN11IM8fWaX2iidc0uzKKN0bHARdF0cKAyRSvT3ft2pyrRnffyFfULXzFqlLICFYQU1v5/54
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a79ad27697mr37799865ab.6.1732288524479; Fri, 22 Nov 2024
 07:15:24 -0800 (PST)
Date: Fri, 22 Nov 2024 07:15:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740a00c.050a0220.363a1b.0143.GAE@google.com>
Subject: [syzbot] [f2fs?] WARNING in f2fs_unlink
From: syzbot <syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43fb83c17ba2 Merge tag 'soc-arm-6.13' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170f5930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e796b1bf154f93a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1213fae8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b3a75f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c93bb9014475/disk-43fb83c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8116200f91e3/vmlinux-43fb83c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3a982ec74b0/bzImage-43fb83c1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/43c22dda0085/mount_0.gz

The issue was bisected to:

commit 4c8ff7095bef64fc47e996a938f7d57f9e077da3
Author: Chao Yu <yuchao0@huawei.com>
Date:   Fri Nov 1 10:07:14 2019 +0000

    f2fs: support data compression

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101e5b78580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121e5b78580000
console output: https://syzkaller.appspot.com/x/log.txt?x=141e5b78580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Fixes: 4c8ff7095bef ("f2fs: support data compression")

F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5835 at fs/inode.c:407 drop_nlink+0xc4/0x110 fs/inode.c:407
Modules linked in:
CPU: 0 UID: 0 PID: 5835 Comm: syz-executor152 Not tainted 6.12.0-syzkaller-03657-g43fb83c17ba2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:drop_nlink+0xc4/0x110 fs/inode.c:407
Code: bb 70 07 00 00 be 08 00 00 00 e8 07 df e5 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc e8 ed e9 7e ff 90 <0f> 0b 90 eb 83 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 5c ff ff ff
RSP: 0018:ffffc90003cafb98 EFLAGS: 00010293
RAX: ffffffff82160e93 RBX: 1ffff1100e63e009 RCX: ffff888035573c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82160e13 R09: 1ffffffff203969e
R10: dffffc0000000000 R11: fffffbfff203969f R12: ffff8880731f0048
R13: dffffc0000000000 R14: ffff8880731f0000 R15: dffffc0000000000
FS:  0000555576140380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 00000000758b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 f2fs_i_links_write fs/f2fs/f2fs.h:3127 [inline]
 f2fs_drop_nlink+0xd6/0x380 fs/f2fs/dir.c:822
 f2fs_unlink+0x47f/0x960 fs/f2fs/namei.c:572
 vfs_unlink+0x365/0x650 fs/namei.c:4523
 do_unlinkat+0x4ae/0x830 fs/namei.c:4587
 __do_sys_unlinkat fs/namei.c:4630 [inline]
 __se_sys_unlinkat fs/namei.c:4623 [inline]
 __x64_sys_unlinkat+0xcc/0xf0 fs/namei.c:4623
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f71e4b355f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed28a90b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007ffed28a9298 RCX: 00007f71e4b355f9
RDX: 0000000000000000 RSI: 0000000020000380 RDI: 00000000ffffff9c
RBP: 00007f71e4bb8610 R08: 00000000000105b7 R09: 0000000000000000
R10: 00007ffed28a8f80 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffed28a9288 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

