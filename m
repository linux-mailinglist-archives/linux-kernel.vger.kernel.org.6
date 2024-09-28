Return-Path: <linux-kernel+bounces-342310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D23F988D80
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA914282F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BD1865C;
	Sat, 28 Sep 2024 02:13:31 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3836FB9
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489611; cv=none; b=pfzyBwPktXNN/7cS6A9bUSouEa7XBWXGL9RQmUQVQBpv2SjagkZMi3AR+HU4sR7ixej/bkIdvjaJLHRs2eXuKHRSiBiANHQwzz1V6pqgKB2zpWN4SdFY05rSz5ohYXtJ9hPZHV4V3MVSAoNFxvdtIoq7YZTzRJ1w4ZTVOPv4uvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489611; c=relaxed/simple;
	bh=8RCQVeQ/XK9Z1B/wmO3ESfDVi+pbkKDn4zwyhJE3VZ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MZtOn9ZK1jvFJkGY5OsqMFk7rFMpZv3dRknCkX6DrACCfJgOpW4Q6f3nxjVKOl7iH+pf6HH30r0xWnuwAhoq6MlEt2L4J4EH/SPdrOyOYGA2L7q9vmR42aU7w6DM3q/r5wxjPqnmrszwu+c3e5X7lrL/owdVCjuXZz9bbO5YA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82d094a0010so307499739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727489609; x=1728094409;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M27INvGaSPwNPQg+W1lIH9OA4BsNDC8o2mri1nC+Z2I=;
        b=dM7QIQJbK5LWO9cN+Rsa6wwFFMmf+Uopd9V3/0u+6WU+7sXW4wnBHz+vCxR9ztAevG
         YA3FfKrheQgX+LYm/GA1ErDK6tVyK3K+i3bAorRMjPwT4KATHD6Sy49ncelYSJF5hGHs
         p/JXghzZm0DKFmnokh2S2/anjPHF/abbA54U30U7JS6Bf44yzGQIgCI+ojtDvBrITPiI
         EeA7GXdgBjPweYue26hnGIbjeW6Slw9VKkBdZsfzx7Vr5VOktBXio/X3VKorLTL7UsWC
         tnyUREm1fH6LaNbfy9i07ARAMTfMFo8wXWmss7Ck2/zu70z0inf3aw1ul658KeM8IwDG
         1UAw==
X-Forwarded-Encrypted: i=1; AJvYcCWBwHTwO39VdSPqrJl9XBvToI3GHt9lhZBzNbNYdX+pzGzuhQsL2H/8iX8L3rDBTwwGJLcOVlaiN8h3ax4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxRGdbTz4sya2+GKXny2BIfwG97VYUWeHD2Od+eAaaUYFJ/IK
	eTJm9M+zjsG5HwnLKs4oDD/S8dMksiK8sVmc2b6wBNj7kur5G9Fthpc5gfEKwslvS4KXnjH5YTF
	NWBpki+A/WPBsYH+gIhIZZqUMg3IVW1SpjEwvsScS+XjDsazU2+oN5rY=
X-Google-Smtp-Source: AGHT+IEg8HEFCGGB6ofQHbf1Qqy83n/cVSR+6UKhQR3NvXjj5JLo7yamoo/+SXfD9XvNAyzaHT5sLiLiR35QXEayNMM2xOsQfF3D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a0:ac0d:22b9 with SMTP id
 e9e14a558f8ab-3a345166d4dmr47655665ab.6.1727489608835; Fri, 27 Sep 2024
 19:13:28 -0700 (PDT)
Date: Fri, 27 Sep 2024 19:13:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f76648.050a0220.46d20.002c.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_fs_btree_write_buffer_exit
From: syzbot <syzbot+e4b5080f1e963225063e@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11ef8507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=e4b5080f1e963225063e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4b5080f1e963225063e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_write_buffer.c:801!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6419 Comm: syz-executor Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bch2_fs_btree_write_buffer_exit+0x1dc/0x1e0 fs/bcachefs/btree_write_buffer.c:800
lr : bch2_fs_btree_write_buffer_exit+0x1dc/0x1e0 fs/bcachefs/btree_write_buffer.c:800
sp : ffff8000a3217a80
x29: ffff8000a3217a80 x28: 1fffe0001e5b0010 x27: 1fffe0001e5b000d
x26: dfff800000000000 x25: ffff0000f2d80000 x24: dfff800000000000
x23: ffff0000f2dcb174 x22: 00000000000fffff x21: 00000000000ffffe
x20: ffff0000f2d80000 x19: ffff0000f2d845a0 x18: 1fffe000366d79ee
x17: ffff80008f56d000 x16: ffff80008b274880 x15: 0000000000000001
x14: 1fffe0001e5b962e x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001e5b962f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000ea698000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff800082a3a0cc
x2 : 0000000000000000 x1 : 00000000000ffffe x0 : 00000000000fffff
Call trace:
 bch2_fs_btree_write_buffer_exit+0x1dc/0x1e0 fs/bcachefs/btree_write_buffer.c:800
 __bch2_fs_free fs/bcachefs/super.c:564 [inline]
 bch2_fs_release+0x2d4/0x720 fs/bcachefs/super.c:608
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2a8/0x41c lib/kobject.c:737
 bch2_fs_free+0x2c4/0x334 fs/bcachefs/super.c:672
 bch2_kill_sb+0x48/0x58 fs/bcachefs/fs.c:2055
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1373
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1380
 task_work_run+0x230/0x2e0 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: d65f03c0 9774c432 17ffffc0 9774c430 (d4210000) 
---[ end trace 0000000000000000 ]---


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

