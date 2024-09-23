Return-Path: <linux-kernel+bounces-335515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDEA97E6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1A11F2110D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E09B482E4;
	Mon, 23 Sep 2024 07:44:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04A41C77
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077465; cv=none; b=InpPixo7prgmNgaUsHEtOKyYMJTuYNSrJDLZzWe5Qc6Y10q8zDgYa9wpGHwuraIm9xnf/oxPDSUbfJuM/Vl1FrcBlhN6j75ZHePxR+r6IaFNcmgquZzpQ9i21sGg9fvRR7RGHqvuyb8NGaJjsR4Ooq1WOmHYGxVKpEq0PSOqATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077465; c=relaxed/simple;
	bh=LkC1t3TxTFZa8Hn+77XTWKGisM+k5AaosaNClAvoYlY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EyvIzUidpjf5WNvgGav0y+5EtoLRG0Pi/nmmc8WmzqTik/FXCXitcHeo/K1cisKTbyKMH7jNHlDm8oEASBJSActOsC0kWxd6PEcbL2oLmdaCbCwj45qpeO35cn1KhDsNoOwCk8SP2rYt5gRzyp8SPCzYxb4KLbQ1NE8TE2jWFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-832160abde4so150767439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 00:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727077463; x=1727682263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVTYoiAtNlDktBdtE7+MhVrGPrjoTxKIvCHBywjWffI=;
        b=HNyZ2CrCmbfresK0KlcbmI9fttaYg3E+I8dc64/4qgE1MvYEvGtXQn9sbka3ei6lAq
         dBA1mEy4l7aiKCY+/ZfS0cTtj9lrJL5RGflw0LqGWH+/fukiVuanCA8oCdwebcdQiupy
         rsvnRPN9TNePXFz6eXXKHFrGDvyYu59sQv+k2P2Nc0sG3wmK3rkkQmEpTyapzrxdCjpw
         ftLRZ8SbuhuwVcAeX6Fpt3HqBIjDAk0Wt2+gLwk4KpzGOCaJ7bLMu0+yK4gUx2eF5gvJ
         aXQShaCXzEN6G6c163PYF5CV7lHp/SwsKGNe+EyjSsxuEPdcEPhUs9og1jTchYWlC2f/
         qu5g==
X-Forwarded-Encrypted: i=1; AJvYcCW71CAQdytbDZ7tkHnXEKEHi+qj9pdQ1idqrXbMeFe+6xjQvAkB7PUouyUqxDtp25Vk1+LahwfNEdQA4fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyScYe6TMn608G3s3DLOEGikXdFoGUOm9yri1tNZ4tb6slSM+Td
	QPcE+iLOI7RpAkZbFz4qfVD3C/50DwGQWqrR03QLWD2+FQ1ScsVXhq89Q8UU2LIYVQvJ1NKwgN8
	EcqbgHU5OPlEkjYm6v0aMx+GxKkj9cNXFchrDhLVf8+aYjBJOSsJSF24=
X-Google-Smtp-Source: AGHT+IF+PZtw8vh0GIIVd//mP/NGikAR6iEVCRDuchYNnphLoOQ0gfs9VDP33HVjngJDoGqDCA7neIw78b8ttGK0H7CwbjowLmsm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a3:b0:3a0:9903:42c3 with SMTP id
 e9e14a558f8ab-3a0c89fd336mr72667575ab.10.1727077463707; Mon, 23 Sep 2024
 00:44:23 -0700 (PDT)
Date: Mon, 23 Sep 2024 00:44:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f11c57.050a0220.c23dd.000b.GAE@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfs_iget
From: syzbot <syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    af9c191ac2a0 Merge tag 'trace-ring-buffer-v6.12' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1705c107980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547de13ee0a4d284
dashboard link: https://syzkaller.appspot.com/bug?extid=18dd03a3fcf0ffe27da0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1085c107980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aa9c27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2fd24309dcaf/disk-af9c191a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37cd070c7ff6/vmlinux-af9c191a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/71a3466b8e96/bzImage-af9c191a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/28d1a4936640/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in hfs_iget+0x1be/0x240 fs/hfs/inode.c:403
 hfs_iget+0x1be/0x240 fs/hfs/inode.c:403
 hfs_lookup+0x2f3/0x3d0 fs/hfs/dir.c:37
 lookup_one_qstr_excl+0x238/0x530 fs/namei.c:1633
 do_unlinkat+0x2c5/0xe10 fs/namei.c:4521
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __x64_sys_unlinkat+0x17a/0x220 fs/namei.c:4569
 x64_sys_call+0x2c7a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:264
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable rec created at:
 hfs_lookup+0x43/0x3d0 fs/hfs/dir.c:23
 lookup_one_qstr_excl+0x238/0x530 fs/namei.c:1633

CPU: 1 UID: 0 PID: 5180 Comm: syz-executor419 Not tainted 6.11.0-syzkaller-08829-gaf9c191ac2a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

