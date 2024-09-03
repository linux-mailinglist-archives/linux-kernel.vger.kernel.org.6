Return-Path: <linux-kernel+bounces-313375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAF96A4AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3715284DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D018BC39;
	Tue,  3 Sep 2024 16:42:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E518BC12
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381749; cv=none; b=IK+cy8NBXdjMfx5wD7RxK+ExfJecXBRt9y1jg5ajie3+ReUuQaO3JDXlaRnF0MQFn7WG2qsDZv8MoE7a8NGoYu4mFoEEnamBUkruMt54WtjyBuNpqyMposlG8pmEpqjlLMOQxfU0ZNFg6mnhFD4+oP5stHs9Wle9jntUNjzweyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381749; c=relaxed/simple;
	bh=succtZnmFgEiG27MfMyppGZ0dUL7MSPBoc6Jz59uogU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pdH7ZmWMgTqDUxIZ3CoOeoYrk8C7/SlUN8dH+PwpTYeFHdxAlPOQDV+U6g0RCFzoRCQR7/vEWnDqdgKbeO/Pdvjv0Ecz57E0VezRFQWCL7CX09tCQStQRO0a4vf2z1OgMuVWDEAaKz1Z4zgM2vbdKXe6HHw8TZK4wQrMzx/plx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4cef7aa7so55968675ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381747; x=1725986547;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+b/Aq/Hn2smUxUjq9y3DTYsF2A0ukafPUUwQ55d1uk=;
        b=LdqAdrfTG79YSlWvUbFn1uznC7pOKjAFR1b2cwTsX28A7S7i2dOB8bLeuDoWWyYPEb
         FDdJcOm21wN+86pgtuk981KxVB2IAnXMe3+UVXGQ1fP0io63VU7GjISVTdB5PydAHQ1B
         W55gZEfmHXX1KOW+VBSUFuo27fhb4KBUcrhn4YiudJCvX0SfjZDWXgfmPsITM5e0ZthF
         ay0B16l0zqlNaq9wae1K0twMDFeKc+3LqSg/dOQ8/eb6KvRpF2YCMlpRSFP+B4V82MT/
         TZCAqHFr/fW7W3MorWKAFE97VHGBmULsxDNLNyOpfmzTfZ65TXs4UdVEv6j4rqSbUvoJ
         72EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2cBo1YTZWpuDriHmFfOxZ/2gXyf0SDOf2USQpaRVQcc/2DbGRwLuGBzth3ulFX97f/5Clil5ZVlDdUnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2KKcWXPVDvrlwDxzbPh+JvtQLBOg7i4WYmcZxYNm/M8E/9NS
	3Jptbc7kWA+WGzWW/83vsBxp8I/xeDZWyItGhvPjTmjuUtsaTr+eTA43J6Tb0qdBLW5zC6lzE7L
	48BBsBhk0f5VCifK885m628HXVHiXLBiK7Lasoh3gqRVuVRsgCKIEl58=
X-Google-Smtp-Source: AGHT+IGk7hopY3usx07mrJ95n3oFmoEkwAzp8ur2+76gqxWJOTvyEziZWEkBK7PiInl7zHZjwPQyrcxr+7PFYO2YCOcwK6i3HEm4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8904:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4d017dc2862mr600899173.2.1725381746866; Tue, 03 Sep 2024
 09:42:26 -0700 (PDT)
Date: Tue, 03 Sep 2024 09:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fcd17062139be6d@google.com>
Subject: [syzbot] [kernel?] upstream-arm64 test error: kernel panic: VFS:
 Unable to mount root fs on unknown-block(NUM,NUM)
From: syzbot <syzbot+3d91bb43ea9bd71b490e@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8efd4bbd16de Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17016cfb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8ce0989a72ac4ae
dashboard link: https://syzkaller.appspot.com/bug?extid=3d91bb43ea9bd71b490e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/915e34fff8d7/disk-8efd4bbd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/630f1f097016/vmlinux-8efd4bbd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f1385be55d6/Image-8efd4bbd.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d91bb43ea9bd71b490e@syzkaller.appspotmail.com

 (driver?)
  103:00001     262144 nvme0n1p1 fb1dbdda-6850-4ddd-ad86-b1774de646a7

  103:00002    1048576 nvme0n1p2 d730f21b-d9a9-4cec-9f43-3402be542af1

1f00             128 mtdblock0 
 (driver?)
List of all bdev filesystems:
 reiserfs
 ext3
 ext2
 ext4
 cramfs
 squashfs
 minix
 vfat
 msdos
 exfat
 bfs
 iso9660
 hfsplus
 hfs
 vxfs
 sysv
 v7
 hpfs
 ntfs3
 ufs
 efs
 affs
 romfs
 qnx4
 qnx6
 adfs
 fuseblk
 udf
 omfs
 jfs
 xfs
 nilfs2
 befs
 ocfs2
 gfs2
 gfs2meta
 f2fs
 bcachefs
 erofs
 zonefs
 btrfs

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5-syzkaller-g8efd4bbd16de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 panic+0x300/0x884 kernel/panic.c:354
 mount_root_generic+0x4c4/0x5b8 init/do_mounts.c:236
 mount_block_root+0x6c/0x7c init/do_mounts.c:380
 mount_root+0xb4/0xe4 init/do_mounts.c:407
 prepare_namespace+0xdc/0x11c init/do_mounts.c:491
 kernel_init_freeable+0x360/0x478 init/main.c:1591
 kernel_init+0x24/0x2a0 init/main.c:1467
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x08,00000103,80100128,42017203
Memory Limit: none
Rebooting in 86400 seconds..


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

