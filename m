Return-Path: <linux-kernel+bounces-340817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5389F987831
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135CD286DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7758C158205;
	Thu, 26 Sep 2024 17:14:35 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BE715DBB6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370875; cv=none; b=F9gVk1w77TGx1GlYqCV9fNnkXA1Fj8jNRO5lCkCKlpHSPwXwd941hOQ4mCCI4BFRnv98nX86yFfnkEzwvWRUr3fkbAzPHCYGpNLpu/3p7nXT7U2gWpgLo+GxVK6cXw0ST4Q1oPQyITqZuSIejfOMF8/d5XGFBGoNc0kde2ltZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370875; c=relaxed/simple;
	bh=mSAZQAfzb5f99wL7DAF3fixliJJmvYEDnISlGfHXxEY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PUsHF/cEdhxS/g7+DsGUWxNe8M7HZuXF4zLYrhi90cK/h2FQApRWUZVliHnBpnzLObfh9ZdgHHuvoj1XbdSWl5TS4QZkDqJpSbO3jK4EX+uHKwpT0/fj6ZdhfNxOiSNP6UpwHFS/kggvr8Q+wQ42zCkcY5EUHR65xV+V1hcajM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a344da7987so1339945ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727370873; x=1727975673;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcVFNg0CORml1RvTFpDvQ6uyvL/nbMGVmyvBgYWAPi8=;
        b=riR4qB/TkCTkH/J1XOy0ernhAvYkmce9NtiGqRMXhX1bw3mBzlP6DsVflR4V2a2dtb
         fC7QyvxsGROTy7LO0isnGVhdUO4DIozwhOdNMdOVCD1extTH1wjaI0iz6OHcMD5KvuXa
         uLf1ZJfuSNamNjSFiH5I2L61G/g0ArahxhUiN9tmb5D55zfP0irD3InNiTVIWbIhOWi4
         LKS0PYphEYr66CjyR501UPcCqEyMEP+/GPYrJHbBxNzXBGaEqyEQH+xOEqM5TuHQ4+Ze
         WI8uhXIHofKwfC3OwMhMbZ2PumX+LtSCqWN4YN4S27n92vbYw6f/ehR5XFtPgvP4vUfC
         u27g==
X-Forwarded-Encrypted: i=1; AJvYcCXOWiOr5qF8xgmsspKFNChjoxc6AVB4qjOcyPkujV5qB/+n7emjOH+Ib8FfMKukWtTqc90X00PcqcunZTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuvK9inSCh8yGC+j0zVjTWBsBT95NOxdGsmykq9fIJhWs0AJb
	BK3+Xkq99fn3wnfNTG0gI2gesCMSbRLL4v6uNsvaweqN8AUYTClpdeSutrsWnodXEZReLjMsn+l
	wC3nLDbZDdtmqXuGpZJRZq3yAMNuKBLQ8Udfyea2wNfoFDY74i/xzDzs=
X-Google-Smtp-Source: AGHT+IEIU0vE8fPtWYwzuRjNCPNXJZMyaL3qlUbRAx/JOlZQ2iN6bzetYwMXi1SLRvDMQIvb/D29Ah9DBzGMkZwmbdNRVBOpQCYZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1705:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a34514af38mr1675085ab.5.1727370872780; Thu, 26 Sep 2024
 10:14:32 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:14:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f59678.050a0220.46d20.0001.GAE@google.com>
Subject: [syzbot] [serial?] INFO: task hung in vcs_open (8)
From: syzbot <syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1187c19f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74ffdb3b3fad1a43
dashboard link: https://syzkaller.appspot.com/bug?extid=8a192e8d090fa9a31135
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16aa3ca9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1587c19f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87eaf0ad6d60/disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30c01cf8bc82/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1407424ea54/bzImage-88264981.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a8a56914d1d8/mount_6.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16154c80580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15154c80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11154c80580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com

INFO: task syz-executor199:5270 blocked for more than 147 seconds.
      Not tainted 6.11.0-syzkaller-08481-g88264981f208 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor199 state:D stack:27360 pid:5270  tgid:5255  ppid:5233   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6674
 __schedule_loop kernel/sched/core.c:6751 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6766
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2591
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x346/0x7f0 kernel/locking/semaphore.c:246
 down+0x84/0xc0 kernel/locking/semaphore.c:63
 console_lock+0x145/0x1b0 kernel/printk/printk.c:2808
 vcs_open+0x5d/0xd0 drivers/tty/vt/vc_screen.c:763
 chrdev_open+0x521/0x600 fs/char_dev.c:414
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

