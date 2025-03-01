Return-Path: <linux-kernel+bounces-539864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31522A4AA0B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CC1174692
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B2191F77;
	Sat,  1 Mar 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5yxeZuZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VO4lrwRj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5yxeZuZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VO4lrwRj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD51B423C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821697; cv=none; b=IlhsSJIPEWWSym4TZSryERTCMSevTYOZtvm5S6sBhm/ypPZor4v2cijW7P8VelYdW248vv3dHudJrPE5Jm7pS0D79iFLm4X2797Vl95safrHHJBEUCJ21S80sdqshu4ARs5+GY7+ty1IfpdzLEukiVyq0/TFVYx9DJaAzs9IWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821697; c=relaxed/simple;
	bh=wCba9nahI57MMTK0vbGc+KKYaVW7hTyrYhqdZzfBs+U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rl8c1KwHwLZXJLmhaOjAHM4oYMQwEsVLofR8iOKOBlMN9D/J9Tr3UwprzQRaPahPgK9wi/WlhqBKpFfuV5E1AyoH98apr2mR6CAuZRrfpu3sOeW1oRTevoY+DLED+neFm7PLbIaRT26Wk+WGyMaejcPA+1xUmTlz98FEXjoyDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5yxeZuZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VO4lrwRj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5yxeZuZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VO4lrwRj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76A831F390;
	Sat,  1 Mar 2025 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740821692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KnCrz2WA0v4asIfqGDapvyiv7URFfA90YDxbZ5jGd0=;
	b=T5yxeZuZK6jcq19fF3MwlFk/vROEn7WYFg8JXsfs3Tnvhfl0fWZH4SdRcHypNosWZKWi1v
	ZGnIKFFmbHBh+B5hCgmKeFXT7+W6smuxlt5kdAy5Xus0t4CKqpW6dZWBGW0ONF27WIGKeV
	stovdl0EK1Fr2tP0C3y5xQ30MgHuSas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740821692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KnCrz2WA0v4asIfqGDapvyiv7URFfA90YDxbZ5jGd0=;
	b=VO4lrwRjl6sc/GE2q4nSu2UzT5oP/wN2F+HLXKFXrVDeO2HTwQ1pB58v2yqpABgpC7TIj0
	EdEBSC/WnAdED+Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T5yxeZuZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VO4lrwRj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740821692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KnCrz2WA0v4asIfqGDapvyiv7URFfA90YDxbZ5jGd0=;
	b=T5yxeZuZK6jcq19fF3MwlFk/vROEn7WYFg8JXsfs3Tnvhfl0fWZH4SdRcHypNosWZKWi1v
	ZGnIKFFmbHBh+B5hCgmKeFXT7+W6smuxlt5kdAy5Xus0t4CKqpW6dZWBGW0ONF27WIGKeV
	stovdl0EK1Fr2tP0C3y5xQ30MgHuSas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740821692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KnCrz2WA0v4asIfqGDapvyiv7URFfA90YDxbZ5jGd0=;
	b=VO4lrwRjl6sc/GE2q4nSu2UzT5oP/wN2F+HLXKFXrVDeO2HTwQ1pB58v2yqpABgpC7TIj0
	EdEBSC/WnAdED+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 321A713A53;
	Sat,  1 Mar 2025 09:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SnBrCrzUwmcLGwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 01 Mar 2025 09:34:52 +0000
Date: Sat, 01 Mar 2025 10:34:51 +0100
Message-ID: <87y0xp9jr8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: <syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<perex@perex.cz>,
	<syzkaller-bugs@googlegroups.com>,
	<tiwai@suse.com>
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid context in snd_card_locked
In-Reply-To: <6610cdb8-072e-47fe-b9bc-f4f5b9a79f8e@quicinc.com>
References: <6610cdb8-072e-47fe-b9bc-f4f5b9a79f8e@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 76A831F390
X-Spam-Level: 
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TAGGED_RCPT(0.00)[4cb9fad083898f54c517];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.01
X-Spam-Flag: NO

On Sat, 01 Mar 2025 10:25:55 +0100,
Zhongqiu Han wrote:
> 
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14e3d7a4580000
> > kernel config:
> https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
> > dashboard link:
> https://syzkaller.appspot.com/bug?extid=4cb9fad083898f54c517
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> for Debian) 2.40
> 
> 
> BUG: sleeping function called from invalid context and
> raw_local_irq_restore() called with IRQs enabled seems can be
> fixed by below change. if it is valid, will arise the PATCH.

snd_timer_process_callbacks() gets called from two places, one from
snd_timer_work() and another from snd_timer_interrupt() where both
caller cover already with guard(spinlock_irqsave).  That is, it's a
nested lock, hence without _irqsave().

IMO, the question is rather why the check of "!in_interrupt()" in 
snd_seq_client_use_ptr() passed in this call path.


thanks,

Takashi

> 
> #syz test:
> 
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index fbada79380f9..5290c1b9f2b8 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -767,6 +767,7 @@ static void snd_timer_process_callbacks(struct
> snd_timer *timer,
>  {
>         struct snd_timer_instance *ti;
>         unsigned long resolution, ticks;
> +       unsigned long flags;
> 
>         while (!list_empty(head)) {
>                 ti = list_first_entry(head, struct snd_timer_instance,
> @@ -780,10 +781,10 @@ static void snd_timer_process_callbacks(struct
> snd_timer *timer,
>                         ti->pticks = 0;
>                         resolution = ti->resolution;
>                         ti->flags |= SNDRV_TIMER_IFLG_CALLBACK;
> -                       spin_unlock(&timer->lock);
> +                       spin_unlock_irqrestore(&timer->lock, flags);
>                         if (ti->callback)
>                                 ti->callback(ti, resolution, ticks);
> -                       spin_lock(&timer->lock);
> +                       spin_lock_irqsave(&timer->lock, flags);
>                         ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
>                 }
>         }
> @@ -805,14 +806,16 @@ static void snd_timer_clear_callbacks(struct
> snd_timer *timer,
>  static void snd_timer_work(struct work_struct *work)
>  {
>         struct snd_timer *timer = container_of(work, struct snd_timer,
> task_work);
> +       unsigned long flags;
> 
>         if (timer->card && timer->card->shutdown) {
>                 snd_timer_clear_callbacks(timer, &timer->sack_list_head);
>                 return;
>         }
> 
> -       guard(spinlock_irqsave)(&timer->lock);
> +       spin_lock_irqsave(&timer->lock, flags);
>         snd_timer_process_callbacks(timer, &timer->sack_list_head);
> +       spin_unlock_irqrestore(&timer->lock, flags);
>  }
> 
>  /*
> 
> 
> 
> 
> 
> Thanks
> Zhongqiu Han

