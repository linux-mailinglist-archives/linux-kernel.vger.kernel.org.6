Return-Path: <linux-kernel+bounces-547365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76240A5064C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFBD17138B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637D1EDA2D;
	Wed,  5 Mar 2025 17:25:26 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882291C7011
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195526; cv=none; b=bzytEZlbnaviPv8thTw+JirAdavTNYUcAaORZxc5HQK8SaIuj+dzALFoF/5f38TKEqBZq7Gc6ScrFiLk8DsS1CtDv0SGTRQ0q5HMNdQRf6HoDjCkVOCFoaMpj3n35kxY1CqictBpDPacndownia422NSAtoRyy37zk8qM8e/Pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195526; c=relaxed/simple;
	bh=isU2KcR+Fc5IeSMj/3VUz+YxBSVpY6egRjgQpVu+WIY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mh4vLvNM5W8lAIrHAS6HcUzmBAfKfjcPrfqaobESpGpwFVUBfF7uXeevZv2J3mLL++7uMspNqwWM/E50eEO09ydDbj2NFsEnFWpQyIosEa8klCzlwy6FsmnDzjejcHKPEYbTmC/4keqkGv4i67MfOvMzaYmZj3VKrd73JnQ2gQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d3dd7f01cbso131272895ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195523; x=1741800323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76cFd9GTQUM+SI1YOG4WZgV51ROqXYBfRO68m84vkvU=;
        b=kx7kMz4ml2Q3N8UhGEVJ6mLvoQO1Dt7lk7qYxQbQT9lEJhobeu/NbxR1NNC9pqU3x+
         /AoNUYPN+TTY72fYmGoNr5zBNoMByAkTuDwLEwvn0V/6MSZoYtbwoprPLc+lbu3mfdTZ
         NywuMYtQF5JmTQ1Q06lJc4V0M6iLiDtAiWoZWBVJ8kjgaqFKnOSA7k7YSilL9e0ajrMx
         HKzEFqBKk/7FrV7d2IvzkFyrJ1GCJzf9Uawg60LFaVE5c6qLMHU/R1akwsQ90KR9F3xp
         Kc40DS2F35Xws0w9dVkfTRCVe6pXAJ/PR3I/EuLEUV8Q3iTp0UgIMe8yjt5vOzwYVdBu
         8acg==
X-Gm-Message-State: AOJu0YxXqIq/6sB5gbXBFugNq9g3KsOFmf0/+fmx5ZUOdynm4zTk7HI/
	iAoeTWXY88355gVGGB/LqLGEoVLnX9IvpGfrsA82Z91PWiADIEeVqtogGxY3NffH51cCdq9eG+j
	/x5q7T7nKR4ajgnUhxL4RGeIu1EsxnFKOntv8pukm6juchYbSMEiaDQujdA==
X-Google-Smtp-Source: AGHT+IH9wgZ7e93TVUTcam44ff5H/1ADzcH+Wo9y+7mtzZ/yrv6WY/MHHIPCcignXb7olaFpK04DatK0+JDzTDrn6aq3ZtcRXzM6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a08:b0:3d0:4c9c:965f with SMTP id
 e9e14a558f8ab-3d42b995fbcmr41695335ab.20.1741195523627; Wed, 05 Mar 2025
 09:25:23 -0800 (PST)
Date: Wed, 05 Mar 2025 09:25:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c88903.050a0220.15b4b9.0028.GAE@google.com>
Subject: [syzbot] [sound?] KCSAN: data-race in snd_seq_poll / snd_seq_pool_init
From: syzbot <syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48a5eed9ad58 Merge tag 'devicetree-fixes-for-6.14-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1657d8b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523b0e2f15224775
dashboard link: https://syzkaller.appspot.com/bug?extid=2d373c9936c00d7e120c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/877a63ac53f2/disk-48a5eed9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b3a614d4df6/vmlinux-48a5eed9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ce987fd9e0c/bzImage-48a5eed9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in snd_seq_poll / snd_seq_pool_init

write to 0xffff888114535610 of 4 bytes by task 7006 on cpu 1:
 snd_seq_pool_init+0x1c1/0x200 sound/core/seq/seq_memory.c:469
 snd_seq_write+0x17f/0x500 sound/core/seq/seq_clientmgr.c:1022
 vfs_write+0x27d/0x920 fs/read_write.c:677
 ksys_write+0xe8/0x1b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:739
 x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888114535610 of 4 bytes by task 7005 on cpu 0:
 snd_seq_total_cells sound/core/seq/seq_memory.h:83 [inline]
 snd_seq_write_pool_allocated sound/core/seq/seq_clientmgr.c:95 [inline]
 snd_seq_poll+0x103/0x170 sound/core/seq/seq_clientmgr.c:1139
 vfs_poll include/linux/poll.h:82 [inline]
 __io_arm_poll_handler+0x1e5/0xd50 io_uring/poll.c:582
 io_arm_poll_handler+0x464/0x5b0 io_uring/poll.c:707
 io_queue_async+0x89/0x320 io_uring/io_uring.c:1925
 io_queue_sqe io_uring/io_uring.c:1954 [inline]
 io_req_task_submit+0xb9/0xc0 io_uring/io_uring.c:1373
 io_handle_tw_list+0x1b9/0x200 io_uring/io_uring.c:1059
 tctx_task_work_run+0x6e/0x1c0 io_uring/io_uring.c:1123
 tctx_task_work+0x40/0x80 io_uring/io_uring.c:1141
 task_work_run+0x13a/0x1a0 kernel/task_work.c:227
 get_signal+0xe78/0x1000 kernel/signal.c:2809
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x62/0x120 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x000001f4

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 7005 Comm: syz.2.1455 Tainted: G        W          6.14.0-rc5-syzkaller-00016-g48a5eed9ad58 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

