Return-Path: <linux-kernel+bounces-300188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61995DFFE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1687F1C209C1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EF280C02;
	Sat, 24 Aug 2024 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="KGa9cyYE";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="VvfsJHZH"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0D48CCC
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724533578; cv=none; b=PLPlLGWq4U3uQsV5aZu8U96J4YejhYx7Y9/j/Ryf6UTwGX00Xo6wz0OkjF+zJblR/o5vToH/xBWC0Bi3Q9+JGJ/D2VgUv9wi03Ze/FEM4xp3FaNJNkGrnRjE24RNc8XgCakayrnnqE+I1cKgla23g6tLx2A+bCaWgpT4MUH6zzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724533578; c=relaxed/simple;
	bh=TA/Cz65zRxAjAfq7MjkUo5qbaN77MjBbibjMgDttlrE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oB24/pBYzOIQ36ChWOr3FIoahb9wt1AhB2q/01wbAZABBpogfWTlNZHRabEixG+ekMPcA4WA711tbYBQdIe9s9pgOAV6HscEgvIRu8+GiItvcXoXOx/MNKX1984lgav9BQ8TsKVNvmQ3mFdEQCIVHjtfaf55P3pXgNXDpcmkVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=KGa9cyYE; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=VvfsJHZH; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724533576; x=1756069576;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=TA/Cz65zRxAjAfq7MjkUo5qbaN77MjBbibjMgDttlrE=;
  b=KGa9cyYEjWncg0HPrsKilV8Zuu7q5PWXcbmLwDdLvTkzydeM+XWrccZ3
   amVOfHZ8YzD0XK1slg5KQwVlqC/ntyNnBK/aH6pmVxqMSogpt7zCwYgq8
   YUH9GwfHlKO/baT/BEXcOH869RNSiYsm2eWzeBR/O7jS/CJbrXoQ/AWYj
   5k2Gw3ZAyRInWupI8kC5J9fD2S++GIX+hWhvVQEtZ2XN0Dn/g47wrA7t7
   I9sRVfqJ3imYJYWy2teYx61ZuVHzgASM6wxvxCTpdxVAElHKIqExWfvro
   Wvdp26jHBG3My3Sbkl5W5fQ6hMuvLUzX7PPQsGpFjR9KQ6YipZyoWdFxJ
   g==;
X-CSE-ConnectionGUID: fnkT1nduTcmnLoTZGT38Ng==
X-CSE-MsgGUID: tiXjENrEQWivuZBh2sc4hw==
Received: from mail-io1-f70.google.com ([209.85.166.70])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 14:05:08 -0700
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so354236139f.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724533507; x=1725138307; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=It2SBHCkREFPrVbJXjBwm2w6igz9uIpTeTCDbfBbJro=;
        b=VvfsJHZH+FxQyjMD7HX2xkE09ykn1w0rPoKdIUVavFSFW66xG4zUk6D+Hq4/wJ34X+
         qOBPyGyLf/0oksFtTdmrdYZRPpiRahG9DSs0Q2xxNfLVdsO67AhzM9RyNFG2tJekdu0R
         TKOKIg+7cOyMJWlbCu4gFHlV/IMmv2vZevyGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724533507; x=1725138307;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It2SBHCkREFPrVbJXjBwm2w6igz9uIpTeTCDbfBbJro=;
        b=lzRCLjZPrFouzvD/pmmTrmzW6XxJy4I3ZZgjIBa3ZiQOTBoSwPKRZFYIWRrMSR8OGk
         uGsZwSYG44YKiiSzy8r6g+g6r1GuEW4WFcEbsdJVAzh1ZJctwgWBnnXsuRpaNG1hJiwf
         JxmSB2TNvXcJNRviUsFGJSUkm2BM4PYxphXwMRW4ys1X1QeOkAraeCVMYFmz92SzG84B
         Ey3EVgCv4ClWXtRCHRJcojXNcXBo1QlZiK3hbrkxORvhQvSteoRF0EMG+IxpgnvpP+5n
         1a6jpu6+eDYiYKVo9vEk7LABpr6sd+ROFR7/Pgfa5RQaTRwH6qdKgk1rMnIjKw65pynM
         Wkew==
X-Forwarded-Encrypted: i=1; AJvYcCW5TWC8xNJX5qUZwAXIckN2Ed+HXkKi4J5YkdCaGhhrSmfqDs8QqRkkGD00CzPYxXXsKKLR2RDI3SRAl3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KWVjWlGWvTCXLJTW1K9YmcyciFcP8MSLKotmpoIs1AKTxPTb
	2jkmeXhiJsuWTxZv7Fm2ouMu7VUJBdAtbA4sV8jsxcxCDEbQJ0rXPLlKxZi5/tBmBf64dc0/RZm
	091ozn3E1DP5NGN5heAoOuQdCbnwNSGX4U8dmEmtXJoCF+4beEVJQmb3zLgz9UI6Y6zpdbKNRc5
	GhX83OswSFiPG4A4xr/UQTACSizDpMZcNiV2epqg==
X-Received: by 2002:a05:6602:3429:b0:805:3d47:19d6 with SMTP id ca18e2360f4ac-8278731d742mr749430139f.6.1724533507534;
        Sat, 24 Aug 2024 14:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh1WytsX9vb6S0Fq6cbm62QwZOTitShDAke3V40ewupwNIw/kzd6cj6GxoWxvouZTrOyU8jo4Rvx1bJ/EnDTQ=
X-Received: by 2002:a05:6602:3429:b0:805:3d47:19d6 with SMTP id
 ca18e2360f4ac-8278731d742mr749428939f.6.1724533507230; Sat, 24 Aug 2024
 14:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 14:04:55 -0700
Message-ID: <CANikGpcUOLC06-Mfq296LeXxudpO6732vWM58-Zfv14GqoJE7w@mail.gmail.com>
Subject: BUG: INFO: task hung in gsm_cleanup_mux
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.

In function `gsm_cleanup_mux`,  the kernel hangs when waiting for
`dlci->state` to become `DLCI_CLOSED`. It seems that
`gsm_dlci_begin_close` failed to close the dlci.

The full report including the Syzkaller reproducer:
https://gist.github.com/TomAPU/38bb00292b33d52a6dd2d1b629247146

The brief report is below:

INFO: task syz.1.466:13387 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.466       state:D stack:27400 pid:13387 tgid:13304
ppid:8048   flags:0x00004004
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
RIP: 0033:0x7fafaef809b9
RSP: 002b:00007fafafe0a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fafaf146130 RCX: 00007fafaef809b9
RDX: 0000000020000100 RSI: 00000000404c4701 RDI: 0000000000000004
RBP: 00007fafaeff4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fafaf146130 R15: 00007ffd1b6e06a8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x54/0x2d0 kernel/locking/lockdep.c:6614
1 lock held by systemd-journal/4495:
1 lock held by systemd-udevd/4507:
1 lock held by in:imklog/7662:
2 locks held by agetty/7949:
 #0: ffff88802e7850a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900040dc2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by syz-executor/8032:
2 locks held by syz.1.466/13387:
 #0: ffff8880285170a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffff8880193520b0 (&gsm->mutex){+.+.}-{3:3}, at:
gsm_cleanup_mux+0xb7/0x930 drivers/tty/n_gsm.c:3130
1 lock held by syz.1.796/18097:
2 locks held by syz-executor/18310:
1 lock held by systemd-sysctl/18525:
1 lock held by syz.0.834/18561:
 #0: ffff888020337398 (&mm->mmap_lock){++++}-{3:3}, at:
mmap_read_lock_killable+0x18/0x60 include/linux/mmap_lock.h:153
2 locks held by syz.0.834/18562:
 #0: ffff888020337398 (&mm->mmap_lock){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff888020337398 (&mm->mmap_lock){++++}-{3:3}, at:
vm_mmap_pgoff+0x173/0x3a0 mm/util.c:571
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
synchronize_rcu_expedited+0x37c/0x810 kernel/rcu/tree_exp.h:939

