Return-Path: <linux-kernel+bounces-302191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DA95FAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA8EB22FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29741199396;
	Mon, 26 Aug 2024 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jRHZkByp";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XxiJn1AV"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBB1991B5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705577; cv=none; b=IC4g2SYkMZz52nbCo2zDgjs9FSR21w4eIox0B8X0K9bdU1thf1MXndGGOcpT0nh72lkzWyd8ZtcLsJ4W5s7cFEvc9hnqjktWemvenybwOCxV7hvVBv6CrEiMJ1fzpbZor5SOj8cYqSBi1JLcYut4YJHZLPMJpwKoIYnPAf6csSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705577; c=relaxed/simple;
	bh=rOhOtgmsWxMhv8Vx68oTlpqJEDev/vlplnqmXQQsTEE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ahEOIUxGzf+aVXAMQjB7tptnajhEDjqJp4Ml70HM36TJH5SgBHaYjDVRGP4AREwniF3x5m9f4d8qL+FRT+FJ3zIvv+z8oJe0SuQ7r2j566g0xVdzk/Evd6ynDynslhsod1x7gE6/budDYBplx4iuo9Uz14aplOFWfQqcwX0L8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jRHZkByp; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=XxiJn1AV; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724705575; x=1756241575;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=rOhOtgmsWxMhv8Vx68oTlpqJEDev/vlplnqmXQQsTEE=;
  b=jRHZkBypzaP5ehmRRJ64Ju4ATNQQfZlwakHOprqDGLb4X2Kw/l9nK8Ro
   UaWupsJR2Z3EGQ0kPhnwa3L4EPGH6xAP5EaAXaLmN6A9eJU8d3nSHPhFN
   MB23AQ2gKe45x+XC6wxyVdr9FJHBPyLJD2l8a9oi6cSGCEjNftW55lWxP
   lNUEXjKbq2BjazEcb1ILjP1ghRYyOpFGChQEK58gULJoxdiIscr7k5Gix
   BCszksoUpHYnpgZPn3YmhNo/Ks9wxhL63mFLT9/ctTX9+mZCYs3rD0Y9m
   xi2A/G6o43ts/ciHQ+8uMTf4b/ww8w9qQZnC85nucnOqqoxaMQwavrG2G
   A==;
X-CSE-ConnectionGUID: aLsGnAz3S3q2gds1M8whvw==
X-CSE-MsgGUID: CgRLBf45TXaDC+kpNmLg6A==
Received: from mail-il1-f199.google.com ([209.85.166.199])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Aug 2024 13:52:54 -0700
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d32a4f301so49616765ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724705573; x=1725310373; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jovNTpEt2xlDSePsSQJipwFWwKK8ZqmzHDjm/x4SwU=;
        b=XxiJn1AV0DLk3w4KCDX0iRgTCcoYf0mXqRC+2P1gMxBlfiah8WmBa7a8ULTiW9UcnK
         JbfmYB5lUbg88Q5pKxGu+4ZffNTRrXI3Iy2szXM2cA0/RgfzDBisegWeu56soguTV7mV
         tLR/hoaZNTz1msho5ONb9rwHROhSJ1DbVvmyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705573; x=1725310373;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jovNTpEt2xlDSePsSQJipwFWwKK8ZqmzHDjm/x4SwU=;
        b=IA3ZIvJhErLw+u0fvfF+3Y8zVvfHlqiLBC/ll3/vQga1IGoftQRMyEvljK+pObgfuX
         O3Xshj5AnFldHfGaH3ObqI3IvLAMHEhhIDiZqEBQASA5VGa7U3VR2hO4G4bP7TzcCoD5
         7UeKM4AIYVoFC8MJPyRmpidOMABVGrqo6zBq2348THD+DYbpJwPSIVZtwcu06fIFH/Mk
         /I5neWZv4ReVMotG+wry5HZfW1jTxZeK3fkT/D5FsM0TI6ppMczQEC+8iV0PHjOKfFKT
         fFXiTiwOyMSqjRuvsMv81KGZgMtGHCsPnoIxYtZcSvRzJRvm0H5e2bWraiz1/1dAJBYu
         rUGA==
X-Forwarded-Encrypted: i=1; AJvYcCUr9uOoOF5O0CbfU2hz9ti26jsVxbxCmci+8TCZW2PLtC5Sco2KG77wMRXYXjTKcdpZj5yIWrk2PFAVuoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNThVdINr1hSq/me368wUSv9LeyhnPEbMnk/fP/xUom3PhzhJp
	RTEPM367+D2hfQGYSEVJd2SC3G58Uii5kvM+fQyD4C5ZrhpZ7Q5ElRxlLHid6M9qZvniCU/rJy0
	mS300IWQaKX2ngxNDqKqQKazX4OwwPBZ2Xh55ms1+fCXvh+Bj39U8XIl3qNxdBhTwkN6zacaj7x
	TE4yYuG/076eTV/B9+MDDToGW1GYzcxV1yTzRR1biedSJUE+bQM00=
X-Received: by 2002:a05:6e02:1b0e:b0:39d:47c6:38b1 with SMTP id e9e14a558f8ab-39e640214dbmr6768475ab.9.1724705573106;
        Mon, 26 Aug 2024 13:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrbjfDqA5RDh5l409+sU7yUdTureViDHqY3ihnv9F11d7Arb1WkvSkJYDtb9TlZOvULy1X3rFVKFATqHMi53Q=
X-Received: by 2002:a05:6e02:1b0e:b0:39d:47c6:38b1 with SMTP id
 e9e14a558f8ab-39e640214dbmr6768315ab.9.1724705572642; Mon, 26 Aug 2024
 13:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Mon, 26 Aug 2024 13:52:41 -0700
Message-ID: <CANikGpeautjFq49hKPhZQ7TQ3zwjToQrGUw+A6Oux90AcQqvcA@mail.gmail.com>
Subject: BUG: WARNING: possible circular locking dependency detected
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
A possible deadlock issue was discovered in function
`tty_buffer_flush` when it attempted to acquire lock `buf->lock`.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

======================================================
WARNING: possible circular locking dependency detected
6.10.0 #13 Not tainted
------------------------------------------------------
kworker/0:0/8 is trying to acquire lock:
ffff8880130990b8 (&buf->lock){+.+.}-{3:3}, at:
tty_buffer_flush+0x75/0x3f0 drivers/tty/tty_buffer.c:229

but task is already holding lock:
ffffffff8da0eb20 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x25/0x210
drivers/tty/vt/vt_ioctl.c:983

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (console_lock){+.+.}-{0:0}:
       console_lock+0x15f/0x1a0 kernel/printk/printk.c:2665
       con_flush_chars+0x67/0x260 drivers/tty/vt/vt.c:3503
       n_tty_write+0xfb6/0x12d0 drivers/tty/n_tty.c:2405
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x589/0xa00 drivers/tty/tty_io.c:1096
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x8a1/0xc70 fs/read_write.c:590
       ksys_write+0x19b/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x67/0x6f

-> #1 (&tty->termios_rwsem){++++}-{3:3}:
       down_write+0x36/0x50 kernel/locking/rwsem.c:1579
       n_tty_flush_buffer+0x2d/0x240 drivers/tty/n_tty.c:358
       tty_buffer_flush+0x324/0x3f0 drivers/tty/tty_buffer.c:241
       tty_ldisc_flush+0x66/0xc0 drivers/tty/tty_ldisc.c:388
       tty_port_close_start+0x2e7/0x540 drivers/tty/tty_port.c:663
       tty_port_close+0x24/0x140 drivers/tty/tty_port.c:718
       tty_release+0x284/0xd70 drivers/tty/tty_io.c:1760
       __fput+0x24a/0x8a0 fs/file_table.c:422
       task_work_run+0x239/0x2f0 kernel/task_work.c:180
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x12d/0x280 kernel/entry/common.c:218
       do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x67/0x6f

-> #0 (&buf->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x37ac/0x8050 kernel/locking/lockdep.c:5137
       lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x131/0xd50 kernel/locking/mutex.c:752
       tty_buffer_flush+0x75/0x3f0 drivers/tty/tty_buffer.c:229
       tty_ldisc_flush+0x66/0xc0 drivers/tty/tty_ldisc.c:388
       __do_SAK+0xc4/0x710 drivers/tty/tty_io.c:3038
       vc_SAK+0x73/0x210 drivers/tty/vt/vt_ioctl.c:993
       process_one_work kernel/workqueue.c:3248 [inline]
       process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
       worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
       kthread+0x2eb/0x380 kernel/kthread.c:389
       ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &buf->lock --> &tty->termios_rwsem --> console_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(console_lock);
                               lock(&tty->termios_rwsem);
                               lock(console_lock);
  lock(&buf->lock);

 *** DEADLOCK ***

4 locks held by kworker/0:0/8:
 #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
process_scheduled_works+0x8fb/0x1410 kernel/workqueue.c:3329
 #1: ffffc900000afd20
((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900000afd20
((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at:
process_scheduled_works+0x922/0x1410 kernel/workqueue.c:3329
 #2: ffffffff8da0eb20 (console_lock){+.+.}-{0:0}, at:
vc_SAK+0x25/0x210 drivers/tty/vt/vt_ioctl.c:983
 #3: ffff88802f1670a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref
drivers/tty/tty_ldisc.c:263 [inline]
 #3: ffff88802f1670a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_flush+0x1b/0xc0 drivers/tty/tty_ldisc.c:386

stack backtrace:
CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events vc_SAK
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 check_noncircular+0x36c/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x37ac/0x8050 kernel/locking/lockdep.c:5137
 lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x131/0xd50 kernel/locking/mutex.c:752
 tty_buffer_flush+0x75/0x3f0 drivers/tty/tty_buffer.c:229
 tty_ldisc_flush+0x66/0xc0 drivers/tty/tty_ldisc.c:388
 __do_SAK+0xc4/0x710 drivers/tty/tty_io.c:3038
 vc_SAK+0x73/0x210 drivers/tty/vt/vt_ioctl.c:993
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
tty tty1: SAK: killed process 7942 (agetty): by session
tty tty1: SAK: killed process 7942 (agetty): by controlling tty

