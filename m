Return-Path: <linux-kernel+bounces-300484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7D95E43A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB2E1F214B6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9A155757;
	Sun, 25 Aug 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kpe7XCmz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="InwdEdho";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kpe7XCmz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="InwdEdho"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43A1DA3D;
	Sun, 25 Aug 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724601747; cv=none; b=fGQIu3vOIlKyUi82cM56QYnQrM+oZuEwmimsyPcksQGAhT2X7wbzmB/NwqOA41jMUAgy/T/8HdhKwuxkHsLP+snvwfPyJ89l87+A0CDyKGwadQLhjTlZrBZGLMR1Ti+m2BBfIGLKHIFDuDvCliJ2zM5OfEvbSktT9Gpm06SIk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724601747; c=relaxed/simple;
	bh=d69WvDF+2qA78JixRylQjZFCRS3rEYzGO3VxldJpak4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2V6UHSWs8lNOK8iAKh4wpwbKb7vw01c6HJgVVzO3aVHsUIb5yggqHin3wpCNv+scM3zUOJW9XzsY211AI9xmBXxqSbNL/BEuXALLIbfywlGvMx+8/jDwUHHYp2M4VxkcDjIONynIb7kXCLyVknFZ2fNKSdMOEvHTzcaDZEMvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kpe7XCmz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=InwdEdho; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kpe7XCmz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=InwdEdho; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC681F7EB;
	Sun, 25 Aug 2024 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724601229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBB8zsdLKrit08YFy8cC0Il/RGsKpwy1+6oMvE8IdA8=;
	b=Kpe7XCmzP54yHtUgaGvelH4Opr1xSgRZV5Y4TTOzqyBwsVCM4DdUbLRbZUi6lWP/5iBNQb
	TEUBGJG05MX6d2Uac6hQ+++w8kJg7xGDhZSCUiKwpGcjFw5iPj+FmFdBl8O0fbEidcRhlt
	JjjIeN6+I6j7EtNGPUlpEZx4ACsrFU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724601229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBB8zsdLKrit08YFy8cC0Il/RGsKpwy1+6oMvE8IdA8=;
	b=InwdEdhoyRBJQ7MFPRA07y/To78kR99gKiowK2CjDMz4p+yLkWqAtxT/T4unNbxDErbd7m
	egiC5dONcju2dLBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Kpe7XCmz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=InwdEdho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724601229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBB8zsdLKrit08YFy8cC0Il/RGsKpwy1+6oMvE8IdA8=;
	b=Kpe7XCmzP54yHtUgaGvelH4Opr1xSgRZV5Y4TTOzqyBwsVCM4DdUbLRbZUi6lWP/5iBNQb
	TEUBGJG05MX6d2Uac6hQ+++w8kJg7xGDhZSCUiKwpGcjFw5iPj+FmFdBl8O0fbEidcRhlt
	JjjIeN6+I6j7EtNGPUlpEZx4ACsrFU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724601229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBB8zsdLKrit08YFy8cC0Il/RGsKpwy1+6oMvE8IdA8=;
	b=InwdEdhoyRBJQ7MFPRA07y/To78kR99gKiowK2CjDMz4p+yLkWqAtxT/T4unNbxDErbd7m
	egiC5dONcju2dLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FF1613408;
	Sun, 25 Aug 2024 15:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yC8OCo1Ty2aUWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 25 Aug 2024 15:53:49 +0000
Date: Sun, 25 Aug 2024 17:54:32 +0200
Message-ID: <87v7zoionb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: BUG: INFO: task hung in seq_free_client
In-Reply-To: <CANikGpe4pbGxQV+CCvSF6U+4cGHLWBzY_WXGSV9m+prBE6tYEQ@mail.gmail.com>
References: <CANikGpe4pbGxQV+CCvSF6U+4cGHLWBzY_WXGSV9m+prBE6tYEQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 5EC681F7EB
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Sun, 25 Aug 2024 01:08:32 +0200,
Juefei Pu wrote:
> 
> Hello,
> We found the following issue using syzkaller on Linux v6.10.
> In `seq_free_client`,  the task hangs when trying to acquire lock
> `register_mutex`.
> 
> Unfortunately, the syzkaller failed to generate a reproducer.
> But at least we have the report:

Unfortunately the stack trace isn't really helpful.  It merely means
that something else already blocked the register_mutex, and it's
likely that something went wrong at releasing another client, hence
it's keeping the mutex.  But I can't say more than that the info for
now.

In anyway, if this is reproducible and have a reproducer, please
report again.


thanks,

Takashi

> 
> INFO: task syz.0.38:8767 blocked for more than 143 seconds.
>       Not tainted 6.10.0 #13
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.38        state:D stack:24680 pid:8767  tgid:8767
> ppid:8050   flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5407 [inline]
>  __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
>  __schedule_loop kernel/sched/core.c:6825 [inline]
>  schedule+0x143/0x310 kernel/sched/core.c:6840
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6897
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x69a/0xd50 kernel/locking/mutex.c:752
>  seq_free_client+0x27/0x180 sound/core/seq/seq_clientmgr.c:298
>  snd_seq_release+0x44/0xc0 sound/core/seq/seq_clientmgr.c:387
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  task_work_run+0x239/0x2f0 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x12d/0x280 kernel/entry/common.c:218
>  do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f9a0cf809b9
> RSP: 002b:00007ffc31b75f88 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00007f9a0d147a80 RCX: 00007f9a0cf809b9
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007f9a0d147a80 R08: 0000000000000006 R09: 00007ffc31b7626f
> R10: 00000000003ffcd0 R11: 0000000000000246 R12: 00000000000248af
> R13: 00007ffc31b76080 R14: 00007ffc31b760a0 R15: ffffffffffffffff
>  </TASK>
> 
> Showing all locks held in the system:
> 3 locks held by kworker/0:1/10:
>  #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3223 [inline]
>  #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_scheduled_works+0x8fb/0x1410 kernel/workqueue.c:3329
>  #1: ffffc900000cfd20
> ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3224 [inline]
>  #1: ffffc900000cfd20
> ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at:
> process_scheduled_works+0x922/0x1410 kernel/workqueue.c:3329
>  #2: ffff888100af7240 (&data->fib_lock){+.+.}-{3:3}, at:
> nsim_fib_event_work+0x2de/0x4050 drivers/net/netdevsim/fib.c:1489
> 1 lock held by khungtaskd/25:
>  #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
> rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
> include/linux/rcupdate.h:781 [inline]
>  #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x54/0x2d0 kernel/locking/lockdep.c:6614
> 2 locks held by kworker/u4:9/2825:
> 1 lock held by systemd-udevd/4506:
> 1 lock held by in:imklog/7643:
> 1 lock held by syz.1.37/8761:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> seq_free_client+0x27/0x180 sound/core/seq/seq_clientmgr.c:298
> 1 lock held by syz.0.38/8767:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> seq_free_client+0x27/0x180 sound/core/seq/seq_clientmgr.c:298
> 1 lock held by syz.0.44/9437:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.46/9506:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.46/9508:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.46/9509:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.0.53/10021:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.0.53/10022:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.57/10085:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.57/10091:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.0.64/10607:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.66/10653:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.0.70/11162:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.68/11179:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.0.71/11691:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.72/11705:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.1.74/12211:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.0.81/12259:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 2 locks held by syz-executor/12269:
> 1 lock held by systemd-udevd/12279:
> 2 locks held by syz-executor/12313:
> 1 lock held by syz.1.82/12748:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335
> 1 lock held by syz.0.83/12763:
>  #0: ffffffff8ecc0b08 (register_mutex#3){+.+.}-{3:3}, at:
> snd_seq_open+0x42/0x4a0 sound/core/seq/seq_clientmgr.c:335

