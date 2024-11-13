Return-Path: <linux-kernel+bounces-407153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D039C6974
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BC9285DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA1178CEC;
	Wed, 13 Nov 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X4AGHehm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ruBqvx97";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X4AGHehm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ruBqvx97"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C022C9A;
	Wed, 13 Nov 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480489; cv=none; b=Cq2DnTvI9HaC44OzfRwWCYyjRAEWHBT7axlMLAPcoxEbBNM1WPxOoZHkkgz0wPDwTNwnABVjY1TNbVNrA/JN3CpuUbLpMY/MthjXnqRPDNnaJ3c0TV/Bgv6ufRbCVMZQdr3Fcn8ramUemv4iQLtGo8cnCnR3tfKZMRuoJSUSFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480489; c=relaxed/simple;
	bh=h7pP0+KYyaCbZIEKUOy63/L66JPfgorKeNnHtzP2KDs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQuQ0ELZ2iv/GnkN7aJjYq9TQBOZoc21zJJWkoDgWEBAJUPTLIsENNMKG5YXmZ9z1WiIpvmRF/fvsHsXEc55woQKpNOJQje2z1gZNfBpw5QaNeVXHEXu31mdfMDSNSv0aksDu/ftaGKwM5FrDYjFQDqGg5AF68ZMXtHIhxnlNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X4AGHehm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ruBqvx97; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X4AGHehm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ruBqvx97; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A21711F365;
	Wed, 13 Nov 2024 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731480485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lnb64D4HI5/47E8RPSDtjpJ8QGGcDwPg6Q/5lYyury8=;
	b=X4AGHehmoi9JeSDvrg1UjXUKHWX23BYV7gnyqX8q5nObfY3y315Q+0yxyY9G6iWFrjz8fb
	OToztef1oj7jcSAuebQJMS0MQ6ZdnqHaMC+I6BrsjD6czwKmW+Fby3xs2HFwGy5ZU8s+RH
	EkaRpXbKLoLRjdu+H3nZ0ioMSCvZek4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731480485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lnb64D4HI5/47E8RPSDtjpJ8QGGcDwPg6Q/5lYyury8=;
	b=ruBqvx974OSlaij/pXeUr4flchMyer1prF9vjNjdlwtxmsV5Brlm8mxiAVJlE/Y+kiAFGG
	I2CZFWvQEsc771DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731480485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lnb64D4HI5/47E8RPSDtjpJ8QGGcDwPg6Q/5lYyury8=;
	b=X4AGHehmoi9JeSDvrg1UjXUKHWX23BYV7gnyqX8q5nObfY3y315Q+0yxyY9G6iWFrjz8fb
	OToztef1oj7jcSAuebQJMS0MQ6ZdnqHaMC+I6BrsjD6czwKmW+Fby3xs2HFwGy5ZU8s+RH
	EkaRpXbKLoLRjdu+H3nZ0ioMSCvZek4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731480485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lnb64D4HI5/47E8RPSDtjpJ8QGGcDwPg6Q/5lYyury8=;
	b=ruBqvx974OSlaij/pXeUr4flchMyer1prF9vjNjdlwtxmsV5Brlm8mxiAVJlE/Y+kiAFGG
	I2CZFWvQEsc771DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F49913301;
	Wed, 13 Nov 2024 06:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iktuFaVLNGd8DQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Nov 2024 06:48:05 +0000
Date: Wed, 13 Nov 2024 07:48:04 +0100
Message-ID: <87servsk7v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edward Adam Davis <eadavis@qq.com>
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] usb: fix a task hung in snd_card_free
In-Reply-To: <tencent_F41B22255CBA04BB3B33319E461BFF4B3708@qq.com>
References: <874j4ctp57.wl-tiwai@suse.de>
	<tencent_F41B22255CBA04BB3B33319E461BFF4B3708@qq.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[73582d08864d8268b6fd];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 13 Nov 2024 02:48:49 +0100,
Edward Adam Davis wrote:
> 
> On Tue, 12 Nov 2024 17:04:04 +0100, Takashi Iwai wrote:
> > On Wed, 06 Nov 2024 03:15:49 +0100,
> > Edward Adam Davis wrote:
> > >
> > > task 1: snd ctrl will add card_dev ref count and can't call close to dec it,
> > >         it is blocked waiting for task 2 to release the USB dev lock.
> > >
> > > task 2: usb dev lock has been locked by hung task (here is usb_disconnect),
> > >         it is hung waiting for task 1 to exit and release card_dev.
> > >
> > > Adjust the USB lock acquisition method to non-blocking in ioctl to avoid
> > > hang when the USB connection is closed.
> > 
> > I'm afraid that this change would break things too badly.
> > i.e. changing the blocking behavior to non-blocking is no-go.
> > 
> > > Reported-and-tested-by: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
> > 
> > This particular syzkaller entry can be fixed rather by replacing
> > snd_card_free() in snd_usx2y_disconnect() with
> > snd_card_free_when_closed() like other USB audio drivers, something
> > like below.
> > 
> > Judging from the git log, it had been with snd_card_free_in_thread(),
> > but was switch to snd_card_free() around year 2005.  Meanwhile the
> > handling of async card release got improved, and it's very likely OK
> > to use snd_card_free_when_closed() there with the recent kernel.
> The snd_card instance will be released in snd_card_do_free().
> So, if snd_card_free_when_closed() is used to replace snd_card_free(), who will release the snd_card instance?

Via the release callback of the card device object, which is triggered
at the last close by refcounting.


Takashi

> 
> BR,
> Edward
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > -- 8< --
> > --- a/sound/usb/usx2y/usbusx2y.c
> > +++ b/sound/usb/usx2y/usbusx2y.c
> > @@ -422,7 +422,7 @@ static void snd_usx2y_disconnect(struct usb_interface *intf)
> >  	}
> >  	if (usx2y->us428ctls_sharedmem)
> >  		wake_up(&usx2y->us428ctls_wait_queue_head);
> > -	snd_card_free(card);
> > +	snd_card_free_when_closed(card);
> >  }
> > 
> >  static int snd_usx2y_probe(struct usb_interface *intf,
> 
> 

