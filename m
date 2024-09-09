Return-Path: <linux-kernel+bounces-321971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BA97223C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889D81C23A64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC5189906;
	Mon,  9 Sep 2024 19:00:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDED25779
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908430; cv=none; b=Q2mufmfwz+wQjFNVhEloPJMO9p62mcEg4ROElYSe9bD+qSQ5meQ7vzSBVfD32w1Cf1bsx1aw1Np6uzEmvYDeKIJhsj61aMoBBrVT9CtWDGJoDu33VwhJU847J/WJBiHxS0iDmJutX59HhJSWsPfVGTioAflNs5bJppAB5Hc85tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908430; c=relaxed/simple;
	bh=YBJ7N57PFghVozGSVnOMZ4czC9mduxg6tedfKugZ5us=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mVUmAGE7OC/tS2PYvYyWp0MVt/Dppy/sR8IY4PubhKISawAvbliQKp8i8kHZqnssz3EWbNYfaODTonfVZ4abP+3tHxxcT7q+ZGiYw9BQR4U5N3w/NbcQomSA6hd+al2DOHyKHUSrBFBnra6AgHfq9w5Q+HpoU3awHUethnGainM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa67b1101so509644239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 12:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908428; x=1726513228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y54PztHGwSAI8/Jf/tUurGKOciAkk0Ur88jNfvTGdGQ=;
        b=EwxTXfg5QkZrzAmSQMd3dWVlcsicwntOv/2qpiWAQOGdrlwaUGqxuupW9FIEs6pSBM
         muV4rSA2nqGgJGaPs79kfe4Al1DOHLohJCaivwKga9Jc+4XeTXTD6lxSoVSSveiDOC+Z
         dJej+7FcRpiGGToe2yMsx6FW+4EliFW4aa/Jz6vBRgfRZWUAFdfqXxL9ZRJtAKG/gwBQ
         M+PMTuJfKxDggh3UUxK+6PYfRoZbpoY0uN7bHFukR0BcbbA5yapHQVEoNNLHTEueDAYH
         44HI6z/45wcG2GsvSnJp+es0Gy63huyA5XzmS0HjRN9xU2Lw5HHDJ+TdeghByfCOG8Ed
         9yeg==
X-Forwarded-Encrypted: i=1; AJvYcCUYc2FOWw90B5r/tDLmHlJBMgJ56TEKBWhDiwu65WCnT81siS7HheKUGkKD3jjnW1FLr6MRVvYlbtuL3Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCK4IN+UoWQ2pqKLyCT12M3M66vAnHVxHkM2DycwquFD2xjBPT
	i1npY8sKO3bO3QF9/D5WahlKuYyEV+vGv+uQQk/JzAGmwibVAyvvCT6KJERDmOYL/Ip8rp98gNY
	MYNNZnfu2JPUqcUhTMJlGzXMcLIauNV7QHiwLnRtWth1HrHnfs8us8c4=
X-Google-Smtp-Source: AGHT+IE8kTe40tat07PZm3BRhKLiWjktlMUi8aNQn0szQWIy17wOGlwMjSrwjR1+vtZWbjs30p9EfQ3QokaVYYg+CNHBNKPhI13l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6209:b0:82b:c70f:5061 with SMTP id
 ca18e2360f4ac-82bc70f511emr565773739f.7.1725908428139; Mon, 09 Sep 2024
 12:00:28 -0700 (PDT)
Date: Mon, 09 Sep 2024 12:00:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c643440621b45e4e@google.com>
Subject: [syzbot] [ext4?] KCSAN: data-race in redirty_tail_locked /
 vfs_fsync_range (2)
From: syzbot <syzbot+a388a53633c9a4e9b22e@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    da3ea35007d0 Linux 6.11-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172d743b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a388a53633c9a4e9b22e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3cf4ae8a1204/disk-da3ea350.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8186bac98f7/vmlinux-da3ea350.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1ab98f32196/bzImage-da3ea350.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a388a53633c9a4e9b22e@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in redirty_tail_locked / vfs_fsync_range

read-write to 0xffff88811317dce8 of 8 bytes by task 4275 on cpu 0:
 redirty_tail_locked+0x56/0x270 fs/fs-writeback.c:1346
 writeback_single_inode+0x1ea/0x4a0 fs/fs-writeback.c:1792
 sync_inode_metadata+0x5c/0x90 fs/fs-writeback.c:2842
 generic_buffers_fsync_noflush+0xe4/0x130 fs/buffer.c:610
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x20b/0x6c0 fs/ext4/fsync.c:151
 vfs_fsync_range+0x122/0x140 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2822 [inline]
 ext4_buffered_write_iter+0x338/0x380 fs/ext4/file.c:305
 ext4_file_write_iter+0x29f/0xe30
 iter_file_splice_write+0x5e6/0x970 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x16c/0x2c0 fs/splice.c:1164
 splice_direct_to_actor+0x305/0x670 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0xd7/0x150 fs/splice.c:1233
 do_sendfile+0x3ab/0x950 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1348
 x64_sys_call+0xed5/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:41
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811317dce8 of 8 bytes by task 4277 on cpu 1:
 vfs_fsync_range+0xa6/0x140 fs/sync.c:186
 generic_write_sync include/linux/fs.h:2822 [inline]
 ext4_buffered_write_iter+0x338/0x380 fs/ext4/file.c:305
 ext4_file_write_iter+0x29f/0xe30
 iter_file_splice_write+0x5e6/0x970 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x16c/0x2c0 fs/splice.c:1164
 splice_direct_to_actor+0x305/0x670 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0xd7/0x150 fs/splice.c:1233
 do_sendfile+0x3ab/0x950 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1348
 x64_sys_call+0xed5/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:41
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000087 -> 0x0000000000000080

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 4277 Comm: syz.2.232 Not tainted 6.11.0-rc7-syzkaller #0
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

