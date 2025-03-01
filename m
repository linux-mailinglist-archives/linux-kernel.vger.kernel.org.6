Return-Path: <linux-kernel+bounces-539879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E7A4AA36
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6B3BA43A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926E1D7E30;
	Sat,  1 Mar 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OEdvjnQ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BEnOf56j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y/bfopBT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Wzq+j9b"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF21D63D0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740824582; cv=none; b=UMEQy98EJflCfD9GK3MbKLsFUyA3XaTR8VzUyCZPwFYILUQkjVMwGFz0E/N9NSX27LV6epDEvYENMNjaQWtea8jdQL+Pu312jw1tKRz5BGlDhBOnayQL7AJkFyT9sZYRM+iDr+GK6+9GPXIq+j12TIeMzW5FjoHbpjQqyY498eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740824582; c=relaxed/simple;
	bh=uzXZp0rSHZQZHHuZDprERYQXn1rCnjSVvcgO3E2J71A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfCmWI54HM7tKIfcmqfT8TKqAnPKZCJrNEeBiqhsj+JDR4QFjmdmWd5f2CNHlDzH2ce/nc3OxHECPSSvAUlUQWm/av7m5R91p6NjCH1956Ix2LsjaETPg62IqwSKZ4ljhlht+O5NXh91NGpHam3tYKs4i60kBZ2Lz04uNsPSoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OEdvjnQ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BEnOf56j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y/bfopBT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Wzq+j9b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6C531F390;
	Sat,  1 Mar 2025 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740824573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssj//stbpF1q53It+eHhwY9hgm3MDD+OXkEYWTCIOa8=;
	b=OEdvjnQ8EPoIxvVtfv9UIg7XouxtC/gPTJ3jtYYk//taKsno9F1psHYn4DY5p+pdyZD/7Y
	Gypu3r1f+rlG1ftxXnqzfuhvvs/Uj/e4rlrZr8iwa9o0S+D82pAa5YiMXa8O9fdFNJq262
	V81I8OZfCGm3/UC8DtQffZZgsMOdjj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740824573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssj//stbpF1q53It+eHhwY9hgm3MDD+OXkEYWTCIOa8=;
	b=BEnOf56jAHAg/0pPZqyHf1bkmoJLQ+88ZMjo6nQNgRpQFj1OnUbY/V7JW83wznQJI1DT7o
	HhqE3Kqrip7tydDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Y/bfopBT";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/Wzq+j9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740824572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssj//stbpF1q53It+eHhwY9hgm3MDD+OXkEYWTCIOa8=;
	b=Y/bfopBTCGaoVdTxq0fC2rHHhkL8q0TTTFNLP0/pFk3eYWVzlKb3KVE6t/9NFrsMel5Q21
	MZ3C1307i2YOZGuMwp9HWHX8iy1JIePZruBF3hshPLjdNayLmOzxi0kHJNHxAtPE1jj8O5
	XBnn6MVRqS2PBH4cjN0VDeWDmeE2ocU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740824572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssj//stbpF1q53It+eHhwY9hgm3MDD+OXkEYWTCIOa8=;
	b=/Wzq+j9bS24CdtnNCVPdwGvfHlFx9aZCqVqht+Dh4i35YNVPM69LPYKQGyd1+bahCoGAbi
	ntRBLWDiA3Mci7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71F1213419;
	Sat,  1 Mar 2025 10:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w43BGfzfwmcOJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 01 Mar 2025 10:22:52 +0000
Date: Sat, 01 Mar 2025 11:22:52 +0100
Message-ID: <87tt8d9hj7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	<syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<perex@perex.cz>,
	<syzkaller-bugs@googlegroups.com>,
	<tiwai@suse.com>
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid context in snd_card_locked
In-Reply-To: <c57573e5-8208-495f-ba53-4d9962c0e9b6@quicinc.com>
References: <6610cdb8-072e-47fe-b9bc-f4f5b9a79f8e@quicinc.com>
	<87y0xp9jr8.wl-tiwai@suse.de>
	<c57573e5-8208-495f-ba53-4d9962c0e9b6@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C6C531F390
X-Spam-Level: 
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[4cb9fad083898f54c517];
	DKIM_TRACE(0.00)[suse.de:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.01
X-Spam-Flag: NO

On Sat, 01 Mar 2025 10:50:43 +0100,
Zhongqiu Han wrote:
> 
> On 3/1/2025 5:34 PM, Takashi Iwai wrote:
> > On Sat, 01 Mar 2025 10:25:55 +0100,
> > Zhongqiu Han wrote:
> >> 
> >>> Hello,
> >>> 
> >>> syzbot found the following issue on:
> >>> 
> >>> HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=14e3d7a4580000
> >>> kernel config:
> >> https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
> >>> dashboard link:
> >> https://syzkaller.appspot.com/bug?extid=4cb9fad083898f54c517
> >>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> >> for Debian) 2.40
> >> 
> >> 
> >> BUG: sleeping function called from invalid context and
> >> raw_local_irq_restore() called with IRQs enabled seems can be
> >> fixed by below change. if it is valid, will arise the PATCH.
> > 
> > snd_timer_process_callbacks() gets called from two places, one from
> > snd_timer_work() and another from snd_timer_interrupt() where both
> > caller cover already with guard(spinlock_irqsave).  That is, it's a
> > nested lock, hence without _irqsave().
> > 
> > IMO, the question is rather why the check of "!in_interrupt()" in
> > snd_seq_client_use_ptr() passed in this call path.
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> 
> Thanks Takashi for the discussion.
> 
> I have an initial check:
> func snd_seq_check_queue is called from func snd_seq_timer_interrupt,
> and the scoped_guard can not cover it. maybe this the reason of
> !in_interrupt() check pass.
> 
> just like my patch shared, snd_timer_process_callbacks called
> spin_unlock but not spin_unlock_irqrestore, which caused
> irqs_disabled(): 1 , and then caused the BUG.
> 
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:562
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1167, name:
> kworker/0:1H
> 
> 
> please feel free and kindly correct me if any misunderstanding.

Ah, no, the code in timer.c worked as expected; the lock in the caller
side is temporarily released intentionally for avoiding deadlock.

It's rather the problem in seq_clientmgr.c side, as I mentioned.  The
check with !in_interrupt() is fragile in this case, and it's an
overkill to handle the module loading whenever it's referenced.

I'm going to submit the fix patch later.


thanks,

Takashi

