Return-Path: <linux-kernel+bounces-405826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DC9C5854
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB93B398A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA611F778C;
	Tue, 12 Nov 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="krALiOZK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G2G0uQcJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="krALiOZK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G2G0uQcJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B81CD1F1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414232; cv=none; b=nPQN8IQGZMs4bb0VmcruXnK63ivfphksMVrRo0EbeTL5w5AxElWWn4HuSPQVvkJ8D0TBprQFba1Yjdf6g53chSma/uROwLmskK8ua0HoNmXT6zDMzKn9wEo+skYtK2aYapWcUp9w5KH9xV7dQM2Wuz2Gz1PiFk/m7OMrPr6RJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414232; c=relaxed/simple;
	bh=ANyHZFoRR6ygTE3UMc98GV2Nef9hCyc26lI987f02OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI1KXU7wMbYgh67y+kmIv5YAUHbjSg/NlP0KQ127noh1MZxHd4BDJgXXcHlmsZfL11CnyhPLEjfQNfgOASNGBkS7T2C4QFL/A3d9VAfZ+c9g2HF4r2cK6Ma2UkaVmbTvkWX9XNFHpozTD3xT1KAfXHbpKtjx9817mASR8dYF1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=krALiOZK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G2G0uQcJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=krALiOZK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G2G0uQcJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 641E62128D;
	Tue, 12 Nov 2024 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731414228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FW493CnHCYKbIxrwlwlyWTVH0TZUOQripa78K7Mk8ks=;
	b=krALiOZKqfSgsfCdjeWL225kigiKeD4bX9rTHHymhUO0c84+A9anJ/BRrQ5OocEv945g6B
	3bZBpvpCnkH2DFB1Ry3ZG/1cJ9MYV7uJtUnCgZ8B5ACeyiLtQrF6VBjsgj32uZF6++thW0
	c4nx/PuAFHnkJ6U7a/oa9XeLK7bmjX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731414228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FW493CnHCYKbIxrwlwlyWTVH0TZUOQripa78K7Mk8ks=;
	b=G2G0uQcJAxbfvzXFwHkHxF9mUZnPeLyhp3Yw1lCDfk4XVizmTgK2rPHkj+XZHR1FkRTm94
	r7gJwsYOj703X9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731414228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FW493CnHCYKbIxrwlwlyWTVH0TZUOQripa78K7Mk8ks=;
	b=krALiOZKqfSgsfCdjeWL225kigiKeD4bX9rTHHymhUO0c84+A9anJ/BRrQ5OocEv945g6B
	3bZBpvpCnkH2DFB1Ry3ZG/1cJ9MYV7uJtUnCgZ8B5ACeyiLtQrF6VBjsgj32uZF6++thW0
	c4nx/PuAFHnkJ6U7a/oa9XeLK7bmjX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731414228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FW493CnHCYKbIxrwlwlyWTVH0TZUOQripa78K7Mk8ks=;
	b=G2G0uQcJAxbfvzXFwHkHxF9mUZnPeLyhp3Yw1lCDfk4XVizmTgK2rPHkj+XZHR1FkRTm94
	r7gJwsYOj703X9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1A9B13301;
	Tue, 12 Nov 2024 12:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WmQHONNIM2f8VgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 Nov 2024 12:23:47 +0000
Date: Tue, 12 Nov 2024 13:23:46 +0100
From: Oscar Salvador <osalvador@suse.de>
To: syzbot <syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in resv_map_release (3)
Message-ID: <ZzNI0ikhneaXRCgY@localhost.localdomain>
References: <6732e4aa.050a0220.5088e.0007.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6732e4aa.050a0220.5088e.0007.GAE@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[f525fd79634858f478e7];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Mon, Nov 11, 2024 at 09:16:26PM -0800, syzbot wrote:
> Hello,
... 
> ------------[ cut here ]------------
> kernel BUG at mm/hugetlb.c:1131!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 16399 Comm: syz-executor416 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:resv_map_release mm/hugetlb.c:1131 [inline]
> RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1116
> Code: a4 ff 48 85 db 75 1d e8 ab 1b a4 ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 e3 ea fa ff e8 8e 1b a4 ff 90 <0f> 0b 4c 89 ef e8 83 a6 05 00 e9 3d ff ff ff 48 89 ef e8 86 a5 05
> RSP: 0018:ffffc9002634f900 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e95f9b
> RDX: ffff888020d6c880 RSI: ffffffff81e95fc2 RDI: 0000000000000007
> RBP: ffff88802b289860 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802b289860
> R13: ffff88802b289860 R14: ffff888033f4ed88 R15: dead000000000100
> FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc9bfa142b8 CR3: 000000000df7c000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kref_put include/linux/kref.h:65 [inline]
>  hugetlb_vm_op_close+0x4a7/0x5b0 mm/hugetlb.c:5075
>  remove_vma+0xa8/0x1a0 mm/vma.c:330
>  exit_mmap+0x4e0/0xb30 mm/mmap.c:1937
>  __mmput+0x12a/0x480 kernel/fork.c:1348
>  mmput+0x62/0x70 kernel/fork.c:1370
>  exit_mm kernel/exit.c:571 [inline]
>  do_exit+0x9bf/0x2d70 kernel/exit.c:926
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
>  get_signal+0x25fb/0x2770 kernel/signal.c:2917
>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc9bf9be159
> Code: Unable to access opcode bytes at 0x7fc9bf9be12f.
> RSP: 002b:00007fc9bf957178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007fc9bfa48338 RCX: 00007fc9bf9be159
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc9bfa48338
> RBP: 00007fc9bfa48330 R08: 00007fc9bf9576c0 R09: 00007fc9bf9576c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc9bfa4833c
> R13: 000000000000000b R14: 00007ffda7c51e30 R15: 00007ffda7c51f18
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:resv_map_release mm/hugetlb.c:1131 [inline]
> RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1116
> Code: a4 ff 48 85 db 75 1d e8 ab 1b a4 ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 e3 ea fa ff e8 8e 1b a4 ff 90 <0f> 0b 4c 89 ef e8 83 a6 05 00 e9 3d ff ff ff 48 89 ef e8 86 a5 05
> RSP: 0018:ffffc9002634f900 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e95f9b
> RDX: ffff888020d6c880 RSI: ffffffff81e95fc2 RDI: 0000000000000007
> RBP: ffff88802b289860 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802b289860
> R13: ffff88802b289860 R14: ffff888033f4ed88 R15: dead000000000100
> FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffda7c52014 CR3: 00000000325ae000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

I can reproduce it locally.

I am having a look right now.


-- 
Oscar Salvador
SUSE Labs

