Return-Path: <linux-kernel+bounces-300223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD895E0C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C96B1F2199A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6501B667;
	Sun, 25 Aug 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="WiXv+iUG";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pU2vT4km"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F10846D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724555637; cv=none; b=COyQ7sj1/7eDOkN8KlaOjxHepXLDfHXc2mRRXBlGyCtsFN5v162yRGk4du/DrNynJtWAmg1hRYALe/+ZMd/X/94URc+CtgR0Qa1EP/5phwk+sK43K8l14/jXYyDGkviHHX027LbKmUJeqm7Pca6Kg9+0J1fj7MVX9wdiJV6SqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724555637; c=relaxed/simple;
	bh=2HcrxrTPpRYy1wiPzdskR2z5hUqngZElV4KLHFlJHbE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eFhBYtwAxisqM88b9jPK7AZcx3StNKFc28JAaK3nkYuWpH0DjOSRIFo4hsKS3zq8QEJhDJy4MIebrGUyrjFOpyMtj5bZwjx9FMzfJPhAv0pIMyEVFV6VtgZc1WmMz8791mYRnDiOLEq5+YcVbpGmoRAQf1qYkb06yrfaWRL3f9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=WiXv+iUG; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=pU2vT4km; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724555634; x=1756091634;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=2HcrxrTPpRYy1wiPzdskR2z5hUqngZElV4KLHFlJHbE=;
  b=WiXv+iUGT0Dop+G5WArTLq4PNm6VISp2ndlte5uMnQAKn01/PTH3r5aS
   ZWKZKiwWgcqCNHKLs8ffM12K1NFq8u7+U0IS63Hy8UalDz6CaVeQ95X4M
   uMztC+9I+/wU/FsVaGdjqWtsaIrfnLvNBXHDkKp/jVDBWRIv+rEB4xAUX
   kx7xizFjFa3d9Nfwlz/EnVrNDAphtiwGLPWJgd7sPY82e5TnTjNIDfbtp
   dB3gXke+GaZyLcFpfnl1rSaBTOt7xqgObY2p3eoT1zm4aGdP1/pjnGHZi
   m5zrUAf+dXI/ib8p8eWR4PSDFJ13dhH8EwFxt+yKTWe9+0CYivLZqxJST
   Q==;
X-CSE-ConnectionGUID: QhTvVQTIRKGPpq5HPzVR5w==
X-CSE-MsgGUID: pwCH3+GoTYCpmS9LJBQm0A==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 20:13:53 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d27200924so39236885ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724555634; x=1725160434; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmd79+zPur4h5adj/lU6dhclauG0toHNxgaNJjl4T6Y=;
        b=pU2vT4kmN9/B+TjfPU+orcvmoFrt8ut8XfP719bQ9EMDnp8mk478LmAo0Wlb+2pb+e
         GKH6RF7XlhUli/FOR1FuWp39wnXtioJqezWESIIvyi5DNiAwVAawPMS03pv08cCnv5MA
         PQiWNVQiQbT5o3FwHTdstgw+sP7s0msuKaXfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724555634; x=1725160434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmd79+zPur4h5adj/lU6dhclauG0toHNxgaNJjl4T6Y=;
        b=b3NunCtd8OGKLtN2EqSrWQZHNktB9LiH0YG8ploMcdRw8u/apTnXnCo+jOWZJN4vhk
         ZNIaf623dQ4+1wJksKfP99RHx1x4DumIATeAmaghJrvWvQDHvrGY9ukSA31ffq/mN9e5
         KXtRnCgfneSwq1El6TfjQhZAb2v27bANnVV/pgDdcBBqQaMrm0pAcWurNv15N8zY/aQm
         nsyONuNXsltBYRg0LV/AtGYlZWud1Ad7SVFMEoOz029rpv3eYjQ4cegjMnH7ABdbjnxO
         Lah28v7gLtLYjBui1YnHHp9nAU8T9YEuqCv+FY/E9+aO87tlhzq75EybY0/oSLHDeqs1
         /5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn/tc1PZhji2bnFIk1oetaTvAsoR25+b0ZFJENAkbnkKgurqfXHrVcXVXSkPKkZ8ce8t16cmVGID9Do8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6c47YEPhO9LlN0rM7iFRybnsuNyhCV1ppWIYnAEoUOrWCR4hk
	CaMwBLnzt2WZZdbYBWOpcy5UjFzunat3jYGVjIGOSKAUeHUBOVUZkr8UIuZu8pt7rt/ChVagK24
	kkDFj3+0HkCOQXE3ds7MvtKPwI0HFczFxg5VXS2wySwiQqE1n6NCAAOYUvOdVgJQZGjBBphRzJE
	4iztgVluqrusXkdY2I3z7Lbif1+7zuqSIC84swZqFB0Pprgwfy7qH3fQ==
X-Received: by 2002:a05:6e02:1a45:b0:39d:4b1e:cd82 with SMTP id e9e14a558f8ab-39d728cfdd7mr96016545ab.14.1724555633647;
        Sat, 24 Aug 2024 20:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGgZHq/Se8tOA9DZdl1/0yf87umuwYdDN6FWtcguHA7aB/bSFDofbbs3PnOUQFbjcjVr9CCg8R2rXfKn36lyU=
X-Received: by 2002:a05:6e02:1a45:b0:39d:4b1e:cd82 with SMTP id
 e9e14a558f8ab-39d728cfdd7mr96016445ab.14.1724555633225; Sat, 24 Aug 2024
 20:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 20:13:41 -0700
Message-ID: <CANikGpciuP_rh0KrwcZG=yH1e3FG=31D=XT-F8E3z32docZu8w@mail.gmail.com>
Subject: BUG: INFO: task hung in tty_ldisc_hangup
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `ttty_ldisc_hangup` the task hung when trying to execute the
`tty_ldisc_lock` function.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

INFO: task syz.1.1480:25893 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1480      state:D stack:25768 pid:25893 tgid:25892
ppid:22615  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_timeout+0xac/0x300 kernel/time/timer.c:2557
 down_write_failed drivers/tty/tty_ldsem.c:262 [inline]
 __ldsem_down_write_nested+0x3cb/0x910 drivers/tty/tty_ldsem.c:324
 __tty_ldisc_lock drivers/tty/tty_ldisc.c:289 [inline]
 tty_ldisc_lock+0x6a/0xb0 drivers/tty/tty_ldisc.c:313
 tty_ldisc_hangup+0x23c/0x4c0 drivers/tty/tty_ldisc.c:718
 __tty_hangup+0x407/0x6c0 drivers/tty/tty_io.c:630
 tty_vhangup drivers/tty/tty_io.c:700 [inline]
 tty_ioctl+0x726/0xdb0 drivers/tty/tty_io.c:2743
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fbbaa1809b9
RSP: 002b:00007fbbaaedc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbbaa345f80 RCX: 00007fbbaa1809b9
RDX: 0000000000000000 RSI: 0000000000005437 RDI: 0000000000000004
RBP: 00007fbbaa1f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbbaa345f80 R15: 00007ffd9f1583d8
 </TASK>
INFO: task syz.1.1480:25961 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1480      state:D stack:27224 pid:25961 tgid:25892
ppid:22615  flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 gsm_cleanup_mux+0x344/0x930 drivers/tty/n_gsm.c:3136
 gsm_config drivers/tty/n_gsm.c:3408 [inline]
 gsmld_ioctl+0x13c4/0x2540 drivers/tty/n_gsm.c:3839
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fbbaa1809b9
RSP: 002b:00007fbba9bff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbbaa346130 RCX: 00007fbbaa1809b9
RDX: 0000000020000100 RSI: 00000000404c4701 RDI: 0000000000000004
RBP: 00007fbbaa1f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fbbaa346130 R15: 00007ffd9f1583d8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x54/0x2d0 kernel/locking/lockdep.c:6614
1 lock held by in:imklog/7649:
2 locks held by syz-executor/8034:
2 locks held by agetty/13559:
 #0: ffff88803d8e50a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900041d32f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by systemd-udevd/18316:
2 locks held by systemd-udevd/18325:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
2 locks held by systemd-udevd/18326:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
2 locks held by systemd-udevd/18382:
2 locks held by systemd-udevd/18500:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
1 lock held by systemd-udevd/18504:
2 locks held by systemd-udevd/18505:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
1 lock held by systemd-udevd/18822:
1 lock held by systemd-udevd/18860:
1 lock held by systemd-udevd/18902:
1 lock held by systemd-udevd/18908:
1 lock held by systemd-udevd/18925:
1 lock held by systemd-udevd/19029:
 #0: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock_shared include/linux/fs.h:801 [inline]
 #0: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3573 [inline]
 #0: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7c9/0x3580 fs/namei.c:3810
2 locks held by systemd-udevd/19104:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
2 locks held by agetty/20613:
 #0: ffff888042a120a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002de82f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by agetty/22206:
 #0: ffff8880451e10a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900018482f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by syz.1.1480/25893:
 #0: ffff88803ff751c0 (&tty->legacy_mutex){+.+.}-{3:3}, at:
__tty_hangup+0xcc/0x6c0 drivers/tty/tty_io.c:590
 #1: ffff88803ff750a0 (&tty->ldisc_sem){++++}-{0:0}, at:
__tty_ldisc_lock drivers/tty/tty_ldisc.c:289 [inline]
 #1: ffff88803ff750a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_lock+0x6a/0xb0 drivers/tty/tty_ldisc.c:313
2 locks held by syz.1.1480/25961:
 #0: ffff88803ff750a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffff88804484f0b0 (&gsm->mutex){+.+.}-{3:3}, at:
gsm_cleanup_mux+0xb7/0x930 drivers/tty/n_gsm.c:3130
1 lock held by syz.1.1868/30326:
1 lock held by systemd-sysctl/30475:
2 locks held by systemd-sysctl/30480:
2 locks held by syz.0.1895/30484:
 #0: ffffffff8e8387a8 (input_mutex){+.+.}-{3:3}, at:
__input_unregister_device+0x2ff/0x630 drivers/input/input.c:2293
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
synchronize_rcu_expedited+0x37c/0x810 kernel/rcu/tree_exp.h:939
3 locks held by syz.0.1895/30488:
2 locks held by apt-config/30483:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 25 Comm: khungtaskd Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x451/0x480 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x181/0x2d0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xdbd/0xe00 kernel/hung_task.c:379
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>

