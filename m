Return-Path: <linux-kernel+bounces-522005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578ECA3C4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9263A9802
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976FF1FE443;
	Wed, 19 Feb 2025 16:20:22 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B61F4635
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982022; cv=none; b=TpieYNk890mieOmNABJLlXfKbg57DvSgVM89j5rV3VGC+WY6af4QTGHuBOuxMIP0Etx6OBR1g57FrdwnV4/V1+DEQpXRlzj7HG0WhgVbLOjCkGtjfoq6XNqYwAvEJwZErUkcajzKmrKG0PMexoDz9nLYfC7qJzhvJsLmf8tJa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982022; c=relaxed/simple;
	bh=MQeHFuduWVAMAAqMbp2rQRf3xmQGWIHeRLGMeswVe40=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=drtoJBb4CHYncYlq9mW76eQ+GgRgmwad2bFxGR0hlZi6Cj43CzS420315czVpO94mkQlKYQEII5tb3FTLGueWC8YwC9yQcMPxscs5kvltNle4rrbcsRAD9hbsK452SHTEsK4RVHIr6Ggn/qXj+BhVYV9Cf9Wvq7guhnGc0wK7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so53667975ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982020; x=1740586820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKwsz9i2UOEtd3adiy+fEs7UosVd9+NQm/SUByIEXqc=;
        b=MKBYZvkNCRFdiE89xXVYuwTzCfvdq512MOlZlhP4KcojvF15kKZ/QA1fZQbqJ1hN3h
         874T7aaOLKAHGSCm9HuxX8Mx/3TQqbujsrZbWp0H+w3dWqUMamcWdUJhrE/bbkjKzZFW
         AmUUmcQ7IjXLiwPxt15aJpguQjvMAyHK3y4N6icVTd5QAEpiPlAVkeD/a+d8nMpQZEL0
         rpJF6ClXs8DSaLO/p18RxQY+EM+wpuVasVoURDrxSwj89G3KXmTxESnOWauSlwT367hC
         bxEkKCqJafpf5WwXlMCsO129Ih3bmA+E3FFfTPuDv5e2VI1JFHDF+Q9vke8lp99q4WEO
         hX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV813sbHR7Sovd6i6HAoyTElSUSU3dO0LjOqfus8iwqnYvgRtFhykK/2EKqHAS2TPCBeDY1hv8YYDxvYhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJIkZCb2LIz5KrOHnyF1/dreeowB+uOX3exGes+NtDLKqT7PTP
	wLzjp2NqMxzUyMes0kGEK0Luo3maIGBj7dqT8xBugU4fYQCSj9ybwZnqCWqJU5lXWEGJxlJ+67j
	Ik+jVU0SkRDZcaBsTE93N1XxSYm2DBPDkZ/hl9CuecIcEOmYUFMK+OBw=
X-Google-Smtp-Source: AGHT+IGg6e3hiLKlUkkjUonUCyoM7svuV25/Uc+2ldNvUnggzzErZ2tc8c4Sv0zZRcu8j9aKiLR5R3uF6JpIIsVIoAXkcDIct4eR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0a:0:b0:3d0:d0d:db8e with SMTP id
 e9e14a558f8ab-3d280771c6bmr187283755ab.1.1739982019842; Wed, 19 Feb 2025
 08:20:19 -0800 (PST)
Date: Wed, 19 Feb 2025 08:20:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b604c3.050a0220.14d86d.0150.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in __filemap_add_folio /
 file_write_and_wait_range (7)
From: syzbot <syzbot+6c0e241874a0c6a56ec2@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10291498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce4e433ac2a58cc2
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0e241874a0c6a56ec2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a486bd4f9ce1/disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b6efb477de2/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a4c3dd86651/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c0e241874a0c6a56ec2@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __filemap_add_folio / file_write_and_wait_range

read-write to 0xffff888115692c60 of 8 bytes by task 14397 on cpu 0:
 __filemap_add_folio+0x430/0x6f0 mm/filemap.c:929
 filemap_add_folio+0x9c/0x1b0 mm/filemap.c:981
 __filemap_get_folio+0x32f/0x630 mm/filemap.c:1980
 block_write_begin fs/buffer.c:2221 [inline]
 cont_write_begin+0x512/0x860 fs/buffer.c:2577
 fat_write_begin+0x51/0xe0 fs/fat/inode.c:228
 generic_perform_write+0x1a8/0x4a0 mm/filemap.c:4189
 __generic_file_write_iter+0xa1/0x120 mm/filemap.c:4290
 generic_file_write_iter+0x8f/0x310 mm/filemap.c:4316
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x77b/0x920 fs/read_write.c:679
 ksys_write+0xe8/0x1b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:739
 x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888115692c60 of 8 bytes by task 14402 on cpu 1:
 mapping_needs_writeback mm/filemap.c:644 [inline]
 file_write_and_wait_range+0x68/0x2f0 mm/filemap.c:796
 __generic_file_fsync+0x46/0x140 fs/libfs.c:1525
 fat_file_fsync+0x46/0x100 fs/fat/file.c:191
 vfs_fsync_range fs/sync.c:187 [inline]
 vfs_fsync fs/sync.c:201 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:222 [inline]
 __se_sys_fdatasync fs/sync.c:220 [inline]
 __x64_sys_fdatasync+0x7e/0xd0 fs/sync.c:220
 x64_sys_call+0x15e1/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:76
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000321 -> 0x0000000000000324

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 14402 Comm: syz.7.4702 Tainted: G        W          6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
==================================================================


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

