Return-Path: <linux-kernel+bounces-364202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B499CCA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488E41C218DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2941547F3;
	Mon, 14 Oct 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FE5fTdDo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZVabL8q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FE5fTdDo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZVabL8q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F06E571
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915763; cv=none; b=knq++Sa2r9DlqiU2KJfta2yEINpbaFJnAIyA0RgyYRMOAm++NIC1n4ViA//yt/9KmiE+rIhZcqYUgHECxmo6GngJPD7TrmMxsztxhhiUv5quDFzqYE0mtHOHnqG1tq0Rr3vfby9lcOqW3cF3+QrkaM9ZwI2MIU5pvy2S7mQ2whQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915763; c=relaxed/simple;
	bh=gNfwZPiPRpzGUtP7oqJbTfdW6R2pPP8E8ZFROI5gtWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY0poOfQ4iUCdRokPMQqnGQrrzXzFk1NzNfiBnvWbxH2CsIkx0JGCqfkNSKlmoFyhXSUrtVobC1yIpRo4tOTd9OSSsYjaqCNnW0cmEi9vYzaTbTA/DUQAGQwSnQlecSmeshxEczztlJtKki89y5N+3xj5urJYCBh7zevFQ0WHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FE5fTdDo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZVabL8q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FE5fTdDo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZVabL8q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 652A91F793;
	Mon, 14 Oct 2024 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728915759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH2agdZ/HVjvaNuR068wqqnkeVeVY2POa398uHmb9rk=;
	b=FE5fTdDobz8PwL17qDaLalniQgtzcLr7tuZEHwlFJqWRQBUYHyU4UH0LFCPzeUZG71jfie
	c3DRbZAu/42c2pTcam2HgTQ+L3/NLjJGNowDcFweDtyxakozQxVdMnk9xEvWJ7xLzARx6G
	xKVL+hs9bh8LS0nuqsZSb11sQFUUTMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728915759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH2agdZ/HVjvaNuR068wqqnkeVeVY2POa398uHmb9rk=;
	b=VZVabL8qeReBh54D+xhTiNcQbFmOVYRG++IEs0BWQWamx7wIoZ4A7DuZLOn5pDSmTlCwOd
	yr7elb+WzHDxGDCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FE5fTdDo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VZVabL8q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728915759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH2agdZ/HVjvaNuR068wqqnkeVeVY2POa398uHmb9rk=;
	b=FE5fTdDobz8PwL17qDaLalniQgtzcLr7tuZEHwlFJqWRQBUYHyU4UH0LFCPzeUZG71jfie
	c3DRbZAu/42c2pTcam2HgTQ+L3/NLjJGNowDcFweDtyxakozQxVdMnk9xEvWJ7xLzARx6G
	xKVL+hs9bh8LS0nuqsZSb11sQFUUTMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728915759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH2agdZ/HVjvaNuR068wqqnkeVeVY2POa398uHmb9rk=;
	b=VZVabL8qeReBh54D+xhTiNcQbFmOVYRG++IEs0BWQWamx7wIoZ4A7DuZLOn5pDSmTlCwOd
	yr7elb+WzHDxGDCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53A0D13A51;
	Mon, 14 Oct 2024 14:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rMKBFC8pDWelZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 14:22:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10713A0896; Mon, 14 Oct 2024 16:22:39 +0200 (CEST)
Date: Mon, 14 Oct 2024 16:22:39 +0200
From: Jan Kara <jack@suse.cz>
To: Hui Guo <guohui.study@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 write_special_inodes
Message-ID: <20241014142239.7h53tahoczkmaww2@quack3>
References: <CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com>
X-Rspamd-Queue-Id: 652A91F793
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

On Sat 12-10-24 17:13:40, Hui Guo wrote:
> we found a crash "BUG: unable to handle kernel NULL pointer
> dereference in write_special_inodes" in upstream, and reproduced it
> successfully.

The reproducer is just mounting corrupted JFS image. Unless Shaggy is
willing to dive into this I don't think this will be acted upon because JFS
is mostly dead.

									Honza

> 
> 
> HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
> kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/6.12.config
> 
> repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.report
> console output:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.log
> syz reproducer:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.prog
> c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/e4653eb3a7397c5782f96343fe9dbc5dada06496/repro.cprog
> 
> 
> Please let me know if there is anything I can help.
> Best,
> Hui Guo
> 
> This is the crash log I got by reproducing the bug based on the above
> environment，
> I have piped this log through decode_stacktrace.sh for better
> understand the cause of the bug.
> ================================================================================
> executing program
> syzkaller login: [ 43.704796][ T8242] loop3: detected capacity change
> from 0 to 32768
> [ 43.707859][ T8215] loop0: detected capacity change from 0 to 32768
> [ 43.733656][ T8239] loop2: detected capacity change from 0 to 32768
> [ 43.759686][ T8234] loop1: detected capacity change from 0 to 32768
> [ 43.921958][ T8248] loop5: detected capacity change from 0 to 32768
> [ 43.947086][ T8243] loop4: detected capacity change from 0 to 32768
> [ 43.969139][ T8250] loop9: detected capacity change from 0 to 32768
> [ 43.986996][ T8254] loop14: detected capacity change from 0 to 32768
> [ 44.060631][ T8218] BUG: kernel NULL pointer dereference, address:
> 0000000000000030
> [ 44.061395][ T8218] #PF: supervisor read access in kernel mode
> [ 44.061959][ T8218] #PF: error_code(0x0000) - not-present page
> [ 44.062526][ T8218] PGD 0 P4D 0
> [ 44.062898][ T8218] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 44.063564][ T8218] CPU: 1 UID: 0 PID: 8218 Comm: syz-executor368 Not
> tainted 6.12.0-rc1 #5
> [ 44.064885][ T8218] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [ 44.065764][ T8218] RIP: 0010:write_special_inodes
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
> (discriminator 3))
> [ 44.066375][ T8218] Code: 53 e8 6c 30 68 ff 49 8b 45 00 49 39 c5 74
> 43 48 8d 58 c8 e8 5a 30 68 ff 48 8b 43 10 48 8b 78 30 2e e8 4c 0d 39
> 03 48 8b 43 28 <48> 8b 78 30 2e e8 3e 0d 39 03 48 8b 83 b0 00 00 00 48
> 8b 78 30 2e
> All code
> ========
> 0: 53 push %rbx
> 1: e8 6c 30 68 ff call 0xffffffffff683072
> 6: 49 8b 45 00 mov 0x0(%r13),%rax
> a: 49 39 c5 cmp %rax,%r13
> d: 74 43 je 0x52
> f: 48 8d 58 c8 lea -0x38(%rax),%rbx
> 13: e8 5a 30 68 ff call 0xffffffffff683072
> 18: 48 8b 43 10 mov 0x10(%rbx),%rax
> 1c: 48 8b 78 30 mov 0x30(%rax),%rdi
> 20: 2e e8 4c 0d 39 03 cs call 0x3390d72
> 26: 48 8b 43 28 mov 0x28(%rbx),%rax
> 2a:* 48 8b 78 30 mov 0x30(%rax),%rdi <-- trapping instruction
> 2e: 2e e8 3e 0d 39 03 cs call 0x3390d72
> 34: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
> 3b: 48 8b 78 30 mov 0x30(%rax),%rdi
> 3f: 2e cs
> 
> Code starting with the faulting instruction
> ===========================================
> 0: 48 8b 78 30 mov 0x30(%rax),%rdi
> 4: 2e e8 3e 0d 39 03 cs call 0x3390d48
> a: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
> 11: 48 8b 78 30 mov 0x30(%rax),%rdi
> 15: 2e cs
> [ 44.068207][ T8218] RSP: 0018:ffff88800f2c3ce8 EFLAGS: 00010286
> [ 44.068812][ T8218] RAX: 0000000000000000 RBX: ffff88800e279c00 RCX:
> ffffffff814acf4f
> [ 44.069570][ T8218] RDX: ffff88800dde3300 RSI: ffffffff814acf5b RDI:
> 0000000000000005
> [ 44.070349][ T8218] RBP: ffff88800f2c3d00 R08: ffff88800a50e3d0 R09:
> 0000000000000001
> [ 44.071123][ T8218] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffffffff814b2420
> [ 44.071889][ T8218] R13: ffff888040fd5200 R14: ffff888040fd5280 R15:
> 0000000000000000
> [ 44.072665][ T8218] FS: 00005555717b43c0(0000)
> GS:ffff88807ee00000(0000) knlGS:0000000000000000
> [ 44.073532][ T8218] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 44.074184][ T8218] CR2: 0000000000000030 CR3: 000000000d8fa000 CR4:
> 0000000000350ef0
> [ 44.074962][ T8218] Call Trace:
> [ 44.075300][ T8218] <TASK>
> [ 44.075599][ T8218] ? show_regs
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/dumpstack.c:479)
> [ 44.076065][ T8218] ? __die
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/dumpstack.c:421
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/dumpstack.c:434)
> [ 44.076490][ T8218] ? page_fault_oops
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:711)
> [ 44.077009][ T8218] ? srso_return_thunk
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retpoline.S:224)
> [ 44.077511][ T8218] ? __kvm_handle_async_pf
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/kernel/kvm.c:262)
> [ 44.078096][ T8218] ? exc_page_fault
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:1265
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:1481
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/mm/fault.c:1539)
> [ 44.078637][ T8218] ? asm_exc_page_fault
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./arch/x86/include/asm/idtentry.h:623)
> [ 44.079197][ T8218] ? __pfx_filemap_flush
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:463)
> [ 44.079730][ T8218] ? filemap_fdatawrite_wbc
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:393)
> [ 44.080314][ T8218] ? filemap_fdatawrite_wbc
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/mm/filemap.c:401)
> [ 44.080893][ T8218] ? write_special_inodes
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
> (discriminator 3))
> [ 44.081423][ T8218] ? write_special_inodes
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
> (discriminator 3))
> [ 44.081967][ T8218] lmLogSync
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:937)
> [ 44.082412][ T8218] ? srso_return_thunk
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retpoline.S:224)
> [ 44.082917][ T8218] ? __sanitizer_cov_trace_const_cmp4
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/kcov.c:316)
> [ 44.083568][ T8218] ? srso_return_thunk
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/lib/retpoline.S:224)
> [ 44.083893][ T8253] loop11: detected capacity change from 0 to 32768
> [ 44.084063][ T8218] ? jfs_flush_journal
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:1615)
> [ 44.085204][ T8218] jfs_syncpt
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:1041)
> [ 44.085640][ T8218] jfs_sync_fs
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/super.c:688)
> [ 44.086107][ T8218] ? __pfx_jfs_sync_fs
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/super.c:674)
> [ 44.086625][ T8218] sync_filesystem
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/sync.c:57
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/sync.c:30)
> [ 44.087120][ T8218] generic_shutdown_super
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:624)
> [ 44.087674][ T8218] kill_block_super
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:1697)
> [ 44.088178][ T8218] deactivate_locked_super
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:434
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:475)
> [ 44.088742][ T8218] deactivate_super
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/super.c:508)
> [ 44.089265][ T8218] cleanup_mnt
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:250
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:1374)
> [ 44.089734][ T8218] __cleanup_mnt
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/namespace.c:1381)
> [ 44.090212][ T8218] task_work_run
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/sched.h:2031
> (discriminator 1)
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/task_work.c:230
> (discriminator 1))
> [ 44.090688][ T8218] syscall_exit_to_user_mode
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/resume_user_mode.h:50
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:114
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/./include/linux/entry-common.h:328
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:207
> /data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/kernel/entry/common.c:218)
> [ 44.091087][ T8247] loop10: detected capacity change from 0 to 32768
> [ 44.091253][ T8218] do_syscall_64
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/common.c:102)
> [ 44.092312][ T8218] entry_SYSCALL_64_after_hwframe
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/arch/x86/entry/entry_64.S:130)
> [ 44.092931][ T8218] RIP: 0033:0x7f44ff534f8b
> [ 44.093385][ T8218] Code: 08 00 48 83 c4 08 5b 5d c3 66 0f 1f 44 00
> 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6
> 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b8 ff
> ff ff f7 d8
> All code
> ========
> 0: 08 00 or %al,(%rax)
> 2: 48 83 c4 08 add $0x8,%rsp
> 6: 5b pop %rbx
> 7: 5d pop %rbp
> 8: c3 ret
> 9: 66 0f 1f 44 00 00 nopw 0x0(%rax,%rax,1)
> f: c3 ret
> 10: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
> 17: 00 00 00
> 1a: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
> 1f: f3 0f 1e fa endbr64
> 23: b8 a6 00 00 00 mov $0xa6,%eax
> 28: 0f 05 syscall
> 2a:* 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax <-- trapping instruction
> 30: 77 05 ja 0x37
> 32: c3 ret
> 33: 0f 1f 40 00 nopl 0x0(%rax)
> 37: 48 c7 c2 b8 ff ff ff mov $0xffffffffffffffb8,%rdx
> 3e: f7 d8 neg %eax
> 
> Code starting with the faulting instruction
> ===========================================
> 0: 48 3d 00 f0 ff ff cmp $0xfffffffffffff000,%rax
> 6: 77 05 ja 0xd
> 8: c3 ret
> 9: 0f 1f 40 00 nopl 0x0(%rax)
> d: 48 c7 c2 b8 ff ff ff mov $0xffffffffffffffb8,%rdx
> 14: f7 d8 neg %eax
> [ 44.095191][ T8218] RSP: 002b:00007ffc50d9a3b8 EFLAGS: 00000202
> ORIG_RAX: 00000000000000a6
> [ 44.096010][ T8218] RAX: 0000000000000000 RBX: 000000000000a5ee RCX:
> 00007f44ff534f8b
> [ 44.096766][ T8218] RDX: 00007f44ff4e4e88 RSI: 0000000000000009 RDI:
> 00007ffc50d9a470
> [ 44.097530][ T8218] RBP: 00007ffc50d9a470 R08: 0000000000000000 R09:
> 00007ffc50d9a240
> [ 44.098292][ T8218] R10: 00005555717b57b3 R11: 0000000000000202 R12:
> 00007ffc50d9b500
> [ 44.099058][ T8218] R13: 00005555717b5770 R14: 00007ffc50d9a3d8 R15:
> 00007ffc50d9b560
> [ 44.099831][ T8218] </TASK>
> [ 44.100138][ T8218] Modules linked in:
> [ 44.100537][ T8218] CR2: 0000000000000030
> [ 44.100952][ T8218] ---[ end trace 0000000000000000 ]---
> [ 44.101472][ T8218] RIP: 0010:write_special_inodes
> (/data/ghui/docker_data/linux_kernel/upstream/linux_v6.11/fs/jfs/jfs_logmgr.c:208
> (discriminator 3))
> [ 44.102070][ T8218] Code: 53 e8 6c 30 68 ff 49 8b 45 00 49 39 c5 74
> 43 48 8d 58 c8 e8 5a 30 68 ff 48 8b 43 10 48 8b 78 30 2e e8 4c 0d 39
> 03 48 8b 43 28 <48> 8b 78 30 2e e8 3e 0d 39 03 48 8b 83 b0 00 00 00 48
> 8b 78 30 2e
> All code
> ========
> 0: 53 push %rbx
> 1: e8 6c 30 68 ff call 0xffffffffff683072
> 6: 49 8b 45 00 mov 0x0(%r13),%rax
> a: 49 39 c5 cmp %rax,%r13
> d: 74 43 je 0x52
> f: 48 8d 58 c8 lea -0x38(%rax),%rbx
> 13: e8 5a 30 68 ff call 0xffffffffff683072
> 18: 48 8b 43 10 mov 0x10(%rbx),%rax
> 1c: 48 8b 78 30 mov 0x30(%rax),%rdi
> 20: 2e e8 4c 0d 39 03 cs call 0x3390d72
> 26: 48 8b 43 28 mov 0x28(%rbx),%rax
> 2a:* 48 8b 78 30 mov 0x30(%rax),%rdi <-- trapping instruction
> 2e: 2e e8 3e 0d 39 03 cs call 0x3390d72
> 34: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
> 3b: 48 8b 78 30 mov 0x30(%rax),%rdi
> 3f: 2e cs
> 
> Code starting with the faulting instruction
> ===========================================
> 0: 48 8b 78 30 mov 0x30(%rax),%rdi
> 4: 2e e8 3e 0d 39 03 cs call 0x3390d48
> a: 48 8b 83 b0 00 00 00 mov 0xb0(%rbx),%rax
> 11: 48 8b 78 30 mov 0x30(%rax),%rdi
> 15: 2e cs
> [ 44.103876][ T8218] RSP: 0018:ffff88800f2c3ce8 EFLAGS: 00010286
> [ 44.104474][ T8218] RAX: 0000000000000000 RBX: ffff88800e279c00 RCX:
> ffffffff814acf4f
> [ 44.105248][ T8218] RDX: ffff88800dde3300 RSI: ffffffff814acf5b RDI:
> 0000000000000005
> [ 44.106014][ T8218] RBP: ffff88800f2c3d00 R08: ffff88800a50e3d0 R09:
> 0000000000000001
> [ 44.106771][ T8218] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffffffff814b2420
> [ 44.107538][ T8218] R13: ffff888040fd5200 R14: ffff888040fd5280 R15:
> 0000000000000000
> [ 44.108300][ T8218] FS: 00005555717b43c0(0000)
> GS:ffff88807ee00000(0000) knlGS:0000000000000000
> [ 44.109164][ T8218] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 44.109809][ T8218] CR2: 0000000000000030 CR3: 000000000d8fa000 CR4:
> 0000000000350ef0
> [ 44.110572][ T8218] Kernel panic - not syncing: Fatal exception
> [ 44.111289][ T8218] Kernel Offset: disabled
> [ 44.111722][ T8218] Rebooting in 86400 seconds..
> 
> VM DIAGNOSIS:
> 07:10:48 Registers:
> info registers vcpu 0
> RAX=0000000000000000 RBX=0000000000001000 RCX=ffffffff814aca55
> RDX=ffff88800aa46600
> RSI=0000000000000000 RDI=0000000000000001 RBP=ffff88800ee03cf8
> RSP=ffff88800ee03ce0
> R8 =0000000000001000 R9 =ffffea0000b68ac0 R10=0000000000000000
> R11=0000000000000001
> R12=ffffea0000b68ac0 R13=0000000000001000 R14=0000000000ed2000
> R15=0000000000001000
> RIP=ffffffff8134ec2f RFL=00000293 [--S-A-C] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 0000000000000000 00000000 00000000
> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS [-WA]
> DS =0000 0000000000000000 00000000 00000000
> FS =0000 00005555717b43c0 00000000 00000000
> GS =0000 ffff88803ea00000 00000000 00000000
> LDT=0000 fffffe0000000000 00000000 00000000
> TR =0040 fffffe0000003000 00004087 00008b00 DPL=0 TSS64-busy
> GDT= fffffe0000001000 0000007f
> IDT= fffffe0000000000 00000fff
> CR0=80050033 CR2=00007ffc50d99bd8 CR3=000000000e6c8000 CR4=00350ef0
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000001d01
> FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
> FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
> FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
> FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
> FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
> YMM00=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM01=0000000000000000 0000000000000000 00000000ff000000 00000000000000ff
> YMM02=0000000000000000 0000000000000000 00000000ff000000 00000000000000ff
> YMM03=0000000000000000 0000000000000000 00007ffc50d9b520 00007ffc50d9b520
> YMM04=0000000000000000 0000000000000000 0000000000000000 00007ffc50d9b55f
> YMM05=0000000000000000 0000000000000000 cfff5ffebffcefff d7ffa23fffafff49
> YMM06=0000000000000000 0000000000000000 1d3ff77236800000 07fec5b8a9ffbb91
> YMM07=0000000000000000 0000000000000000 ffb2196e227feee7 ffd6adce7ffafff5
> YMM08=0000000000000000 0000000000000000 7665642f00736672 65646e69622f2e00
> YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM10=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM15=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> info registers vcpu 1
> RAX=0000000000000063 RBX=0000000000000000 RCX=0000000000000000
> RDX=00000000000003f8
> RSI=ffffffff82a1d59a RDI=ffffffff880cbfc0 RBP=ffff88800f2c3828
> RSP=ffff88800f2c3810
> R8 =302e34342020205b R9 =205b5d3436353336 R10=0000000000000063
> R11=205d383132385420
> R12=ffffffff880cbfc0 R13=0000000000000063 R14=ffffffff87fb4b3a
> R15=0000000000000000
> RIP=ffffffff82a1d5b1 RFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 0000000000000000 00000000 00000000
> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS [-WA]
> DS =0000 0000000000000000 00000000 00000000
> FS =0000 00005555717b43c0 00000000 00000000
> GS =0000 ffff88807ee00000 00000000 00000000
> LDT=0000 fffffe0000000000 00000000 00000000
> TR =0040 fffffe000003e000 00004087 00008b00 DPL=0 TSS64-busy
> GDT= fffffe000003c000 0000007f
> IDT= fffffe0000000000 00000fff
> CR0=80050033 CR2=0000000000000030 CR3=000000000d8fa000 CR4=00350ef0
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000001d01
> FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
> FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
> FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
> FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
> FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
> YMM00=0000000000000000 0000000000000000 0000000000989680 0000000000000000
> YMM01=0000000000000000 0000000000000000 0000000000000000 0000000000989680
> YMM02=0000000000000000 0000000000000000 00007f44ff5c3bc0 00007f44ff5c3bc0
> YMM03=0000000000000000 0000000000000000 00007ffc50d9b560 00007ffc50d9b560
> YMM04=0000000000000000 0000000000000000 0000000000000000 00007ffc50d9b59f
> YMM05=0000000000000000 0000000000000000 0000000000000000 00007f44ff5b84b0
> YMM06=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM07=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM08=0000000000000000 0000000000000000 7665642f00736672 65646e69622f2e00
> YMM09=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM10=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM11=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM12=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM13=0000000000000000 0000000000000000 0000000000000000 0000000000000000
> YMM14=0000000000000000 0000000000000000 0000000000000000 0000000000000000
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

