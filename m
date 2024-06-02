Return-Path: <linux-kernel+bounces-198112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3358D7381
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 05:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D841C213B2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F9C8FB;
	Sun,  2 Jun 2024 03:46:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632FA930
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299967; cv=none; b=hf+095yYBTfMk2f9sf7Navwm7on71jea+YrmrFH5UMqxcAYaIGmt15TlmWHPbe1vkB9qqgjzArWJr55rJ+9vVGwVdPKLdU1fEa//L1CZJLNdBfD/Km9HNePK5lZTOcSPPPq8/jj8z+Q3wMNmPGE0llW/r/UMv4i1EMW3Izy7XGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299967; c=relaxed/simple;
	bh=plRV+ubUUxqtsKUx1W3lqAkRwL2tSFYQNbjn2KD6NZ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pXZ1jHuF0ll/qTqZ1sBEegcebqkk1lnmfmtSTcd9lHZQTrZ020JC9cffaJL7o1oRNLgnsO8xMty8iVb8K1X3JlhVTlMFAbp8AasHUDiSyRIk7q60rEIwFBgwtcKfrFOr1XCYkQTfPZY4mZIhRoC+XbGMOsuo5dJ18vzcEnxJWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3748cab6364so21562845ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 20:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717299965; x=1717904765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdZaO1NNvfMfg/xJ1g6VKs8HYRcpBdNPd/3YBF7Tpo0=;
        b=qSNJud1RI9kx9qPO3QCpsDqXXdjVf9mdsVLax0Sp6SSHf6oXno48imamL1c5Nw0FvT
         cCci2ifQOr8ccI+f9LiC4ii16TDq1zcGgaOCrEbFXFV+dXyiOD1WyNeYveXF3bobCmZp
         U25959WtjIlbnzNpORu667btOQHvzZhEI2p5YDWRju8Og27g2MfJ8ScrynBQIEgrlLSc
         cBORQRnhCijmeB2jhduhwXR9cSyx8gjGVrGm2eAWj8IbacnykdXfzg7COkBNVF85gmcw
         GG4qFE/0v/IUsAjtdJo1erewIFbKMc+/kEpJlqyvv6xJ2V8cF+zqzs7I1h1Y2WZVddvi
         86Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUN54uThJtIEPXltqx8T1f5O04NZg5WblnT08NEcyb4SidCODg1fBv9DbXIJKs4sU7lZwszTp7JDj8RYYP0xOZZ63OpCGwSwt6vRHBI
X-Gm-Message-State: AOJu0Yyx61rzPbDZwJ9oj7EVxGBX3d+Fmc+5SzN3eUTm0kcdzh5ptmNG
	Yg1aVg5hcWJ0ccb71CtULnO5U3Hngk71vBfGOKxDSNNH/CNwrPIO5sr+/+uAhlMs+yRhjlFsq32
	q8K5k/NDs3OwWI1E3maSxlFW4SfOE3KhlBkcD1a9Yvpd3UKg81hFR6xo=
X-Google-Smtp-Source: AGHT+IFLEZ8vWRTHlOpAJT+955J8E1QvkBjpgAL78/rciAqlnjDb7I+dtmrtkT88HzP37E5s9e878wmClXICvmsrokVjjTtXjn3L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:374:5eee:dc2f with SMTP id
 e9e14a558f8ab-3748b8f23b6mr5680435ab.0.1717299964841; Sat, 01 Jun 2024
 20:46:04 -0700 (PDT)
Date: Sat, 01 Jun 2024 20:46:04 -0700
In-Reply-To: <d586a439-4f58-4409-8a60-6a00614ec346@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000609f770619e00ec5@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
From: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in f2fs_write_inline_data

loop0: detected capacity change from 0 to 40427
F2FS-fs (loop0): Invalid log_blocksize (268), supports only 12
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
------------[ cut here ]------------
kernel BUG at fs/f2fs/inline.c:276!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5967 Comm: syz-executor Not tainted 6.9.0-syzkaller-10227-g9ee8c306dc6b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:276
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 cf da 09 fe e9 d6 fc ff ff e8 75 68 96 07 e8 30 03 a4 fd 90 <0f> 0b e8 28 03 a4 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000352eb20 EFLAGS: 00010293
RAX: ffffffff83f22ec0 RBX: 0000000000000001 RCX: ffff888024a21e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000352ec50 R08: ffffffff83f22985 R09: 1ffff1100d23c095
R10: dffffc0000000000 R11: ffffed100d23c096 R12: ffffc9000352eba8
R13: 1ffff1100d23c095 R14: ffffc9000352eba0 R15: ffffc9000352ebb0
FS:  00007efdd7bfa6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000007ac94000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 f2fs_write_single_data_page+0xbb6/0x1e90 fs/f2fs/data.c:2888
 f2fs_write_cache_pages fs/f2fs/data.c:3187 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3342 [inline]
 f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3369
 do_writepages+0x359/0x870 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 file_write_and_wait_range+0x1aa/0x290 mm/filemap.c:788
 f2fs_do_sync_file+0x68a/0x1ae0 fs/f2fs/file.c:276
 generic_write_sync include/linux/fs.h:2806 [inline]
 f2fs_file_write_iter+0x7bd/0x24e0 fs/f2fs/file.c:4977
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efdd6e7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efdd7bfa0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efdd6fb3fa0 RCX: 00007efdd6e7cee9
RDX: 0000000000002000 RSI: 0000000020000040 RDI: 0000000000000006
RBP: 00007efdd6ec947f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efdd6fb3fa0 R15: 00007ffd0e21ca28
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:276
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 cf da 09 fe e9 d6 fc ff ff e8 75 68 96 07 e8 30 03 a4 fd 90 <0f> 0b e8 28 03 a4 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000352eb20 EFLAGS: 00010293
RAX: ffffffff83f22ec0 RBX: 0000000000000001 RCX: ffff888024a21e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000352ec50 R08: ffffffff83f22985 R09: 1ffff1100d23c095
R10: dffffc0000000000 R11: ffffed100d23c096 R12: ffffc9000352eba8
R13: 1ffff1100d23c095 R14: ffffc9000352eba0 R15: ffffc9000352ebb0
FS:  00007efdd7bfa6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000007ac94000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         9ee8c306 f2fs: fix to truncate preallocated blocks in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=12ab0a4a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48a63c58ee55467e
dashboard link: https://syzkaller.appspot.com/bug?extid=848062ba19c8782ca5c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

