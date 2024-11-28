Return-Path: <linux-kernel+bounces-425140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473D49DBE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00F5B2220E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0F1C7608;
	Thu, 28 Nov 2024 23:22:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB61DA23
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836150; cv=none; b=iPQObKJMqRLGCRWcyfdiwpV1xNEMaDjrquYxlWuk4W1876Fvt6+P07ncPokG1ozJyt1bQwbq+hiyjMAajUSC5LW0/rW0E6s8T1Axb5/xC1AaZgyvL8AxvHX7REsSJsOY7J9KLLv8jzOIJNIwXoLmXwHU/zP4jSFuJocyqsfR32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836150; c=relaxed/simple;
	bh=Yl6jYkLbWltgLDUBo+ho99krs2N/q2VNhZz2Cc63558=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=scKu21ymgEU7t/xPKB0nLj7HVyfli3bPEqoLnlFkihZn8zhGIaT2iPBv+Hw/ytRuIbCHWKW9EzNVsRaV3OejWCudMDQZI0mAiEpFoOfBYGFbmEZit+qkC9eB5wo8ksqC4XkpWN1hhBt0ouXVZaj2GqJpUI0vfX0vedDUY+9Yho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso167011439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836146; x=1733440946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iHQH29qnDNor/d3TsJ7a0m8YPCrMihPxJ1z2DF4/m0=;
        b=cw2psB2S3g92dgMknspa85xHNjw8OC5oA0I/6J2blgt9fMeSvleFzMkwrKchA8suBF
         iKhxi61Jnqb3rcFAlQHucUaEDjFFH8vPXvuIzZxUUfjJzmmWKftkWr1APQKZ3CfFWtXu
         7ClZd3fYV7CvaSWf9p4pk/zO7H2rtgjTHN3ynzxOIOo3YwkYEc+UZ7NX1BsHKtv6rKbw
         MHFK/9jQM6tgLIc+3sEaAq6P+CSO8OlF1n7/7ordPHRYwcja8a3Tz6hofPBdsU6/J6u6
         QIFpaAf6xC3MS6P/nTG/YOmYMTsMDtGRlneQA+9Xrb9X/46AWJrESVVbj5zuv5F+3YqD
         QJMw==
X-Forwarded-Encrypted: i=1; AJvYcCWf34uxqNfSVblpYO4dm/awU/wV+BAXVfA2tvsm3K31Zoq0q/Y0CUY9ycTDG1SkkWeyFgPvwRlrBrh3c8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZvyBKqkwpXWa8GcOFhRvhSmzeAwjONb4IQ9E1dfGJR3bANIX
	PeO5eJzfdW8w5Rvz2+gR0o+nlL248uY3NnqrsOPxGL2XiJrExJ0kCEI59un7+HYw+dxGtPaz1be
	jnBaTDSlREiJ2P3DCmA2rtc+g2RGlXg3IX0XXyCpKqPyk7O2obrqmpE0=
X-Google-Smtp-Source: AGHT+IFA18niwwKr3q3fR199YkYJekpfqZSsBiBHpSLvQHodwdY6CjbShbhM++ML1UTbUGGQPR1KPLWnPs3s/1dYLaYVScRACvDk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c46:b0:3a7:cf61:ded7 with SMTP id
 e9e14a558f8ab-3a7cf61e05cmr33336795ab.10.1732836146663; Thu, 28 Nov 2024
 15:22:26 -0800 (PST)
Date: Thu, 28 Nov 2024 15:22:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748fb32.050a0220.253251.0098.GAE@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtSplitRoot (2)
From: syzbot <syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=139a59c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=99491d74a9931659cf48
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fcc778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179a59c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9f905470542/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b4c9cc530ec/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0f262e4c35e/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e27e1a7c25e2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99491d74a9931659cf48@syzkaller.appspotmail.com

 ... Log Wrap ... Log Wrap ... Log Wrap ...
find_entry called with index >= next_index
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:1997:37
index -128 is out of range for type 'struct dtslot[128]'
CPU: 1 UID: 0 PID: 5842 Comm: syz-executor268 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dtSplitRoot+0xc9c/0x1930 fs/jfs/jfs_dtree.c:1997
 dtSplitUp fs/jfs/jfs_dtree.c:992 [inline]
 dtInsert+0x12cd/0x6c10 fs/jfs/jfs_dtree.c:870
 jfs_symlink+0x827/0x10f0 fs/jfs/namei.c:1020
 vfs_symlink+0x137/0x2e0 fs/namei.c:4669
 do_symlinkat+0x222/0x3a0 fs/namei.c:4695
 __do_sys_symlink fs/namei.c:4716 [inline]
 __se_sys_symlink fs/namei.c:4714 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4714
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb144f8c6f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1536c068 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 00007ffc1536c248 RCX: 00007fb144f8c6f9
RDX: 00007fb144f8b791 RSI: 0000000020000180 RDI: 0000000020000700
RBP: 00007fb145005610 R08: 000000000000620d R09: 0000000000000000
R10: 00007ffc1536bf30 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc1536c238 R14: 0000000000000001 R15: 0000000000000001
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

