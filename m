Return-Path: <linux-kernel+bounces-334685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB397DAA7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7561F2240C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846718D65B;
	Fri, 20 Sep 2024 22:46:22 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD9F9F8
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726872382; cv=none; b=JTZzS3Ptk7pjSDzwiDBDN15lc165vsnLoMaqi9O/O0/FohfxEEc7l8BXGimygB6QH8MREWE0ex+csiV2gGKFQQmSDf+REfBh+ZDTP9Xh+tnYnBT/WMbmTHhciEjHuVc9L9B1lhVTtOLlU0UDktYxqPrSvKlNrBzE1MJ1MBPvRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726872382; c=relaxed/simple;
	bh=GL47SFFcTle11eqGz4D70eZnps0ZNFsyHl8H3Sf95Q8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l6KIuybmaa/5XPGbv4G/u4SUqYxVuzmpG+fke0MQGoriZDlA1SwiY3JR5+7shsLr4NvUkR/xSKvctPgn4taiyTH7DCTotSlubZWKNXUSNwQ5bhwojcdDJsjDyAnJqBxK8q8PxAbhzAuv9NSDASe2fQAC8CubU31a2EXgiDWyQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f6f16ed00so31927435ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726872380; x=1727477180;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CWl/oXgHFGuHggsC2LsqL669quZl+i9JwDCfxfEDJM=;
        b=TNcUl8kfvTOrMO8pWO/Rc+Z1rIPHuVapUPWGw1jXRWi4gooVNn8DlTWUOE0qSJa0JZ
         0SPzYDxAXaBAkAQv/9Y/0e48rfYKI6GV0DoFaL/JC0mR5Jsa1X/tF4l3X9syyfczwAK8
         i0APww320bb/Aw1lXfdnfrEjRbt5uWrjaZw2N9PplwtvpdPrPP2uwl6qy+IIWX7MwlES
         we9JunKCOBrRRZWei44uxRE+zBD8wZpeoU4nchDwyQV8NwdXpxasT9ko/95U6QkW+Jdh
         3brq1rxmr97sM4SJwKzmBS6N0uNY9+PyKs0mZKsdNvz5jQEZ1aZsSt32AXGMmaIyw72u
         1u6w==
X-Forwarded-Encrypted: i=1; AJvYcCUR7tWhDRCj8ZWoSHGCtw2KWJ3mET2MlwCulown2GDRq2r+LijEhLg69U5VvnYkwwG+x3KtTCWTZgiF1oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIeklWdl+JGvMQYpxdj64o3kKp19mnGw4P+E2OUY5Gw8I9y9g
	49Ci6URsDcXU6Hxv4evk8pgBFlO1NUSsg2JUIecEpID0mMYHgjtkKcT5O9GaZb2NSW9ULn4q9CD
	kQ6q67+9/KsIoz9Rknna7RlC7hgGFdbz41QOgYYK7kR8FHVXdw4JWg2A=
X-Google-Smtp-Source: AGHT+IEnCMHwiQXwXo7xUh1hdOL7ScpBpmb0Kq1UHilzjw/OoE4eu0USUk0Mts3GnGbBjvMf/XscQfJE5xhEU8mgE5CFo9chVzYF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:3a0:9b27:7d52 with SMTP id
 e9e14a558f8ab-3a0c8d39690mr42649655ab.20.1726872380049; Fri, 20 Sep 2024
 15:46:20 -0700 (PDT)
Date: Fri, 20 Sep 2024 15:46:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edfb3c.050a0220.3195df.001a.GAE@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in __ep_remove / __fput (5)
From: syzbot <syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    baeb9a7d8b60 Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16080700580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b3c9c7ae5fde27e
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6b32dc50537a49bb4a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0581f8f76ee/disk-baeb9a7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/742809660d16/vmlinux-baeb9a7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/628c7d467d97/bzImage-baeb9a7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __ep_remove / __fput

write to 0xffff888117ce4690 of 8 bytes by task 3797 on cpu 1:
 __ep_remove+0x3c8/0x450 fs/eventpoll.c:826
 ep_remove_safe fs/eventpoll.c:864 [inline]
 ep_clear_and_put+0x158/0x260 fs/eventpoll.c:900
 ep_eventpoll_release+0x2c/0x40 fs/eventpoll.c:937
 __fput+0x17a/0x6d0 fs/file_table.c:431
 ____fput+0x1c/0x30 fs/file_table.c:459
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 get_signal+0xf87/0x1100 kernel/signal.c:2690
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888117ce4690 of 8 bytes by task 3795 on cpu 0:
 eventpoll_release include/linux/eventpoll.h:45 [inline]
 __fput+0xee/0x6d0 fs/file_table.c:422
 ____fput+0x1c/0x30 fs/file_table.c:459
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 get_signal+0xf87/0x1100 kernel/signal.c:2690
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x59/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888103209140 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3795 Comm: syz.3.142 Not tainted 6.11.0-syzkaller-07341-gbaeb9a7d8b60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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

