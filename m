Return-Path: <linux-kernel+bounces-213676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 117089078A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3E41F21050
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AEC1448E6;
	Thu, 13 Jun 2024 16:48:23 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D112F386
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297303; cv=none; b=hmcgk11eQhEmXWD3InVIqBO8jzB/WqHAq/o4bPpR7qqlmXxhwOKzSIMP7d5tK6XqRuwWvsmyDXgHKb1EU4jdGEf5JGJuOKLctVTVYfmasdV9MMd0Qm+iW8tw1z39o3vpR/Rkw1+FNfRkvkE7NQZnBXvLWnD2BTGPUH78CCsO37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297303; c=relaxed/simple;
	bh=HVnJkaOLKV95o+aZ0neC5Y6FCoZ1JEXoSzA6RsVDQXE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dkxJw/1hKgzplgr3ZogbqJ1DKbyBOwRLY4EnuNduLZvKQcDfkLHbGF4a6LkwnZ2EdZ7K2vnQfrAEdTUgkNYF8OFjcEGNdj349lvkzO8JjnsfYLORrq6mof+/4vsc7yOYiRci5Rb+9vFq7yFnNmi/aJtQSvdoTuKGUAHhQmxgEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb84511dbfso108953839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297300; x=1718902100;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z94rtfoXjiFTl8HfxY5WVWY1FmY/1Za+eSdLTP2Qwqc=;
        b=R2cp2EYWCwCnBRWJHNRTiOVLTJkFx7k/Ha6GLfv37QHGW4nTg9MSB6FVchSvGtLb5/
         BtdaJD/rKI2jAzbj2LwXkoaLwtnZTrhOF/hE+hkLHki5+fj9hWb5TzxjdD8FTHhPmYcC
         Rvq+B0gZV2pUWh+/mlAmqXksssHbYijxPsPQ7YG54ECZ85Z3S8mEUf7ftPZv/2prBkB9
         6MBkk+MSuVtL2OMKQG2DX8TiT1/yCZgARFrN2AhlwUfhcB9kJrq5QLNOzC9FYtGEnyui
         J4/PBTomBpcyIu7LbQiQnHmGqDf3+WO11vPxSENqxDdRGlbZr9afJdqZY0ISo+HBqeK6
         IBJA==
X-Forwarded-Encrypted: i=1; AJvYcCV3v7EJV8bvxs1XwXtzk5iHC9Sv5KOKvr5oIDENILtcoV3IE+BVzq4uCYKD3yst4my9ChO+V4JwcABH6SrFhWy2zrFpBv0dfNMuW3BK
X-Gm-Message-State: AOJu0YwxffrjndzIyaXC1Gp6Gd0SgJKRQSUe3t85ksFQXEuw25uSklf1
	teCEC1fMABvv8REHQwoE3l1rNdmzHJyLU56O4diCIiZzhCc7l8T072lfM7sScfhQR6zKhYsOCI2
	8iCWoryWh3xbP0pjqultTcEQl1Vfv9/WBcsLvrO1/WmskBQNlmdUoIHA=
X-Google-Smtp-Source: AGHT+IGCrbnpcardLaTCxQNjhf6TB6Dalc2IqcZJxH2fvXN9lEQDeSDkeADy9F3ShExbSl1szdZ9NvlMqbemUHU95n2mLT7d+OHo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7115:b0:4b9:32f8:574f with SMTP id
 8926c6da1cb9f-4b93ee9dbe7mr193957173.5.1718297300704; Thu, 13 Jun 2024
 09:48:20 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a318c061ac844e2@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in truncate_setsize
From: syzbot <syzbot+c6773f706de1990de039@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137e8e9c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=c6773f706de1990de039
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dd89d349f79/disk-cea2a265.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/155ef1ec00f0/vmlinux-cea2a265.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0caa129cf368/bzImage-cea2a265.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6773f706de1990de039@syzkaller.appspotmail.com

INFO: task syz-executor.1:10394 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:16192 pid:10394 tgid:10393 ppid:9778   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 io_schedule+0x8d/0x110 kernel/sched/core.c:9043
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1307
 truncate_inode_pages_range+0xaaf/0xfc0 mm/truncate.c:412
 truncate_inode_pages mm/truncate.c:439 [inline]
 truncate_pagecache mm/truncate.c:732 [inline]
 truncate_setsize+0xcf/0xf0 mm/truncate.c:757
 bchfs_truncate+0x683/0xc80 fs/bcachefs/fs-io.c:453
 notify_change+0xb9d/0xe70 fs/attr.c:497
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3308 [inline]
 do_open fs/namei.c:3654 [inline]
 path_openat+0x2a3d/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_creat fs/open.c:1496 [inline]
 __se_sys_creat fs/open.c:1490 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1490
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff79e87cea9
RSP: 002b:00007ff79f6840c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007ff79e9b3f80 RCX: 00007ff79e87cea9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000


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

