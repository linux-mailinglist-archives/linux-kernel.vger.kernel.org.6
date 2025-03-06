Return-Path: <linux-kernel+bounces-548366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA2A543EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE86F16B9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9761DC9AC;
	Thu,  6 Mar 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yyjkv1hQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2YTDgmY9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IpenPWf1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FEMmyrsI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B731A0BFA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247505; cv=none; b=R2BtTXIKbUu8S25n4s6gxCFMyPtQ0sgyiheGvnFchV5xGDVLywpA7CZLjQRNwZmr98Y3Hs2CWLTt6KXI8HaAmwqHARgyCT0x5mpaxRcUTplMSQGObQ68SVJrCTBzDS9JEoizLBwTERlcWk/j7ZrNnAnJleGN0EfYm48mH92KC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247505; c=relaxed/simple;
	bh=gjUcrqFcFI1ybL3DB1TbJViwYlIo9rMDGUyEZ0/f13g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XurCNrVfT7Z/lGjVyS+Js7SMPBBXMSFtoPPyUxV2A5IcOm4r92sg7xXB8feJHzIuc8ehdiwfRw8BnQ4NHwxQHU9yaQ0p64ALBEmGo5zMKujFJn5k3wXa2WO1s/v46r9OPbism5kEXkMHCf7dvF4XWZ83jYmHNWGK/mbV4dJMyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yyjkv1hQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2YTDgmY9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IpenPWf1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FEMmyrsI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B87401F385;
	Thu,  6 Mar 2025 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741247501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5iXPMp1dfiNbGtgtS9kQ0M8cK0gbrvN137GP+WnYpOk=;
	b=yyjkv1hQcdqQ1bFhmMLhFONh4JNMQURDDMqARtnKqePfsHfSTgNo3dMgqrf4yPGD+OTsEo
	+uL3Qj5P64LNSyAgSrNg5dqg9635f88tXimfxq2AVe5os5vDxXp7pvJdAO1m0k1XlXHFF8
	xOqbcbwEgdgWunZTxsXnL/Wn6QD0sW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741247501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5iXPMp1dfiNbGtgtS9kQ0M8cK0gbrvN137GP+WnYpOk=;
	b=2YTDgmY9z+jWBZa0RnOxvBdMWiPtOwfx2SUKaqDN1POxJ7+rWAwnR2QQKYehScDYqhGizv
	zz3uSGPwPtCIVFAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741247500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5iXPMp1dfiNbGtgtS9kQ0M8cK0gbrvN137GP+WnYpOk=;
	b=IpenPWf1Pg2cGBV0xueTnpFyzXp2rIahRwLLE0/0r0FztFxGsPbi9+h9D22l9qEocoJ1oz
	7X+0bZoV5nxEKBRJA2CR+x4mY6ppw5SHtpdUmG+IIRs3gtMhnJu3QFqHbWpx1z5W+F0zFY
	DB/+mErUCKf7djZK3grEDu6bOMlHMlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741247500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5iXPMp1dfiNbGtgtS9kQ0M8cK0gbrvN137GP+WnYpOk=;
	b=FEMmyrsIxcgCe8VJa4y953YyaRHpZ16A7C+kpxLxPw/Cu9APgwfTN6uWu+TGOjjjOfW7cT
	hmI116P1+prGz5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F2DE13A61;
	Thu,  6 Mar 2025 07:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rXwyHQxUyWcldgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Mar 2025 07:51:40 +0000
Date: Thu, 06 Mar 2025 08:51:40 +0100
Message-ID: <87h646r3zn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<perex@perex.cz>,
	<syzkaller-bugs@googlegroups.com>,
	<tiwai@suse.com>
Subject: Re: [PATCH] ALSA: seq: Use atomic to prevent data races in total_elements
In-Reply-To: <20250306011745.100014-1-lizhi.xu@windriver.com>
References: <67c88903.050a0220.15b4b9.0028.GAE@google.com>
	<20250306011745.100014-1-lizhi.xu@windriver.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[2d373c9936c00d7e120c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 06 Mar 2025 02:17:45 +0100,
Lizhi Xu wrote:
> 
> syzbot reported a data-race in snd_seq_poll / snd_seq_pool_init. [1]
> 
> Just use atomic_set/atomic_read for handling this case.
> 
> [1]
> BUG: KCSAN: data-race in snd_seq_poll / snd_seq_pool_init
> 
> write to 0xffff888114535610 of 4 bytes by task 7006 on cpu 1:
>  snd_seq_pool_init+0x1c1/0x200 sound/core/seq/seq_memory.c:469
>  snd_seq_write+0x17f/0x500 sound/core/seq/seq_clientmgr.c:1022
>  vfs_write+0x27d/0x920 fs/read_write.c:677
>  ksys_write+0xe8/0x1b0 fs/read_write.c:731
>  __do_sys_write fs/read_write.c:742 [inline]
>  __se_sys_write fs/read_write.c:739 [inline]
>  __x64_sys_write+0x42/0x50 fs/read_write.c:739
>  x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff888114535610 of 4 bytes by task 7005 on cpu 0:
>  snd_seq_total_cells sound/core/seq/seq_memory.h:83 [inline]
>  snd_seq_write_pool_allocated sound/core/seq/seq_clientmgr.c:95 [inline]
>  snd_seq_poll+0x103/0x170 sound/core/seq/seq_clientmgr.c:1139
>  vfs_poll include/linux/poll.h:82 [inline]
>  __io_arm_poll_handler+0x1e5/0xd50 io_uring/poll.c:582
>  io_arm_poll_handler+0x464/0x5b0 io_uring/poll.c:707
>  io_queue_async+0x89/0x320 io_uring/io_uring.c:1925
>  io_queue_sqe io_uring/io_uring.c:1954 [inline]
>  io_req_task_submit+0xb9/0xc0 io_uring/io_uring.c:1373
>  io_handle_tw_list+0x1b9/0x200 io_uring/io_uring.c:1059
>  tctx_task_work_run+0x6e/0x1c0 io_uring/io_uring.c:1123
>  tctx_task_work+0x40/0x80 io_uring/io_uring.c:1141
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:227
>  get_signal+0xe78/0x1000 kernel/signal.c:2809
>  arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x62/0x120 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x00000000 -> 0x000001f4

This is harmless as it's only a reference in poll() and that's rather
volatile.  So changing the whole with atomic_t is an overkill only for
that.

OTOH, the check of pool size in the caller side is fragile, and it can
purely rely on snd_seq_pool_poll_wait().  And, there, it should take
the pool->lock for the data consistency.

So, if any, an alternative fix would be something like below.


thanks,

Takashi

-- 8< --
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1150,8 +1150,7 @@ static __poll_t snd_seq_poll(struct file *file, poll_table * wait)
 	if (snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT) {
 
 		/* check if data is available in the pool */
-		if (!snd_seq_write_pool_allocated(client) ||
-		    snd_seq_pool_poll_wait(client->pool, file, wait))
+		if (snd_seq_pool_poll_wait(client->pool, file, wait))
 			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -427,6 +427,7 @@ int snd_seq_pool_poll_wait(struct snd_seq_pool *pool, struct file *file,
 			   poll_table *wait)
 {
 	poll_wait(file, &pool->output_sleep, wait);
+	guard(spinlock_irq)(&pool->lock);
 	return snd_seq_output_ok(pool);
 }
 


