Return-Path: <linux-kernel+bounces-302634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2744960141
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540301F22F36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58313A25B;
	Tue, 27 Aug 2024 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LlXk/ngX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C5CDf+PC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LlXk/ngX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C5CDf+PC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1E80054;
	Tue, 27 Aug 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738234; cv=none; b=Mw3lKxUDxgesVWJT+IW1/QbKTiPnFW8ihykuyx8jhZU7lDNBwoleEn0IMJcLPB02QlvajV15BRDN6Ramy4vbEvo/NLMfXPN2TH5KkgR6+V1V+cjdwgu8fO3+7nMQtwxQ4GifTucobR3k+Uw4ozWPL1mheP/9XemGdLtOAGeTwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738234; c=relaxed/simple;
	bh=KS/COEOvP2nLzg4qYCA+CqSs0Rziu1NcnY+iCZkywKs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocfSur1lIFGhc7hYObyaE5lSREw3ozD4qPjtedPmPoaGOEI4c513riNK+K1bVxRZjS2aS1DhmCrrCx/Kp2lRL2jvB58ENrwhZwJoLFUB9Ntc2j4NjPSWN4uLWfRDKynkNH9jlTRw3oM46bV59Ub6QZ3pTaH9AiXldMTJ7D+JEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LlXk/ngX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C5CDf+PC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LlXk/ngX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C5CDf+PC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 956EA1FB44;
	Tue, 27 Aug 2024 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724738230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dz2Y34rvZhR/epTiMuFmscCbHZN+elq57QIn8WxMD7c=;
	b=LlXk/ngXP3J5zfNAC7dxPSFah+LdGFZF2DVpOEn8oJNAOy7L4SKHLMDI1D8jzKLrTJM4vv
	weVUTYI69mTjYMVtcZBT7OI04LJNN44WABQ7i4uZ+0pR1Fn3QEaEWJAhnMeSIUh42ijN6/
	sZ4l5vwz3oBUVJJebfF1KAKJF+Nx6Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724738230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dz2Y34rvZhR/epTiMuFmscCbHZN+elq57QIn8WxMD7c=;
	b=C5CDf+PCGOPKIa5tBei5jYHeoSnpSR6qbctnpj2gGk0m7lRDM2TMqhvMR+kPzple42OgK2
	vIx+KPtrGZSUhNDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="LlXk/ngX";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C5CDf+PC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724738230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dz2Y34rvZhR/epTiMuFmscCbHZN+elq57QIn8WxMD7c=;
	b=LlXk/ngXP3J5zfNAC7dxPSFah+LdGFZF2DVpOEn8oJNAOy7L4SKHLMDI1D8jzKLrTJM4vv
	weVUTYI69mTjYMVtcZBT7OI04LJNN44WABQ7i4uZ+0pR1Fn3QEaEWJAhnMeSIUh42ijN6/
	sZ4l5vwz3oBUVJJebfF1KAKJF+Nx6Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724738230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dz2Y34rvZhR/epTiMuFmscCbHZN+elq57QIn8WxMD7c=;
	b=C5CDf+PCGOPKIa5tBei5jYHeoSnpSR6qbctnpj2gGk0m7lRDM2TMqhvMR+kPzple42OgK2
	vIx+KPtrGZSUhNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6465713A44;
	Tue, 27 Aug 2024 05:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Vn9FrZqzWYEXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Aug 2024 05:57:10 +0000
Date: Tue, 27 Aug 2024 07:57:54 +0200
Message-ID: <87msky33tp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+d2b696e5cb7a92fee831@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] WARNING in snd_pcm_open
In-Reply-To: <0000000000002680930620a0c6b9@google.com>
References: <0000000000002680930620a0c6b9@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 956EA1FB44
X-Spam-Level: 
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=897bd7c53a10fcfc];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[d2b696e5cb7a92fee831];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DKIM_TRACE(0.00)[suse.de:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.01
X-Spam-Flag: NO

On Tue, 27 Aug 2024 04:12:31 +0200,
syzbot wrote:
> 
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6a7917c89f21 Add linux-next specific files for 20240822
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a72e09980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=897bd7c53a10fcfc
> dashboard link: https://syzkaller.appspot.com/bug?extid=d2b696e5cb7a92fee831
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/47820545bc51/disk-6a7917c8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e300f3a38860/vmlinux-6a7917c8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9146afef58aa/bzImage-6a7917c8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d2b696e5cb7a92fee831@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff89468b6f>] snd_pcm_open+0x2ff/0x7a0 sound/core/pcm_native.c:2860
> WARNING: CPU: 1 PID: 5346 at kernel/sched/core.c:8556 __might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
> Modules linked in:
> CPU: 1 UID: 0 PID: 5346 Comm: syz.4.9 Not tainted 6.11.0-rc4-next-20240822-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
> Code: a1 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 ce e6 97 00 48 8b 4d 00 48 c7 c7 c0 60 0a 8c 44 89 ee 48 89 ca e8 f8 02 f1 ff 90 <0f> 0b 90 90 eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
> RSP: 0018:ffffc90004457408 EFLAGS: 00010246
> RAX: 0dea8fe797fdb300 RBX: 1ffff11002cf16ac RCX: 0000000000040000
> RDX: ffffc90009dd9000 RSI: 00000000000085c7 RDI: 00000000000085c8
> RBP: ffff88801678b560 R08: ffffffff8155a632 R09: fffffbfff1cfa364
> R10: dffffc0000000000 R11: fffffbfff1cfa364 R12: dffffc0000000000
> R13: 0000000000000001 R14: 0000000000000249 R15: ffffffff8c0ab880
> FS:  00007fa51e6226c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b32715ff8 CR3: 00000000771dc000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
>  snd_pcm_open+0x34b/0x7a0 sound/core/pcm_native.c:2863
>  snd_pcm_playback_open+0x6e/0xe0 sound/core/pcm_native.c:2810
>  chrdev_open+0x523/0x600 fs/char_dev.c:414
>  do_dentry_open+0x928/0x13f0 fs/open.c:959
>  vfs_open+0x3e/0x330 fs/open.c:1089
>  do_open fs/namei.c:3774 [inline]
>  path_openat+0x2c87/0x3590 fs/namei.c:3933
>  do_filp_open+0x235/0x490 fs/namei.c:3960
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
>  do_sys_open fs/open.c:1431 [inline]
>  __do_sys_openat fs/open.c:1447 [inline]
>  __se_sys_openat fs/open.c:1442 [inline]
>  __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

So the call path is really early and nothing changed there recently.
It looks either false-positive or like a breakage in other lower level
code.


thanks,

Takashi

> RIP: 0033:0x7fa51d778810
> Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 19 8f 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 6c 8f 02 00 8b 44
> RSP: 002b:00007fa51e621b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa51d778810
> RDX: 0000000000000000 RSI: 00007fa51e621c10 RDI: 00000000ffffff9c
> RBP: 00007fa51e621c10 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fa51d915f80 R15: 00007ffc16ca31f8
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

