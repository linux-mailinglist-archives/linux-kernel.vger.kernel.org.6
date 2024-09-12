Return-Path: <linux-kernel+bounces-326101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B238976292
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3EE1C22074
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A547618C34C;
	Thu, 12 Sep 2024 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+sOuKpJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t5ZibXal";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uozEnx54";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f920ZvR9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B11383;
	Thu, 12 Sep 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125757; cv=none; b=J+6fHjUMDsI6m/WQ5Pm2tEpdSm69lKQYWuytQMlu9e7Wn83JhtIwSMeTD5whzAyiVhnhuhkmpnSxv+Ul4It9Wurl4uxJyosIyA+jg5n5BqJP8R2r1iDqy+mGbzWiou1ngLpDVIn8LYHpQVzQD9v0Abx3a/N2chUqyFA2vhDB7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125757; c=relaxed/simple;
	bh=uDDvEuJkTQRs54zt2eOXjNQ8BYgQW7Pcg93jzFiE/QI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDbENehIElrOyRO9Xpc4x7DL1N4grp1Xt5fVZIISxv90ecP1Eo2rp/VtWnJiDQmFrQrMlY/Xmn5qNHVpoLaJhh/53aZ6WHvGkSQDKL8FnOQf84ITbG0+JWugR8jIt5H0ng4maIn8IHoV+kXaf8ohBJ/L9cs7dk577X1UYO7XnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+sOuKpJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t5ZibXal; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uozEnx54; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f920ZvR9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0898219E5;
	Thu, 12 Sep 2024 07:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726125754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL6g0fqV3HQuTCGH8GHnr5jIa2aqkDO1bANMf4TU9a4=;
	b=d+sOuKpJXyxk9IL2YbwDpIq+eaFmWx9hp95Z8kb2Dpvl8kiX5dPE2+en3cmGmEEEOsGXdE
	ZCm4M9mwnUSccDPJGA1cOtzFjI9+tVUWNUBNv/pmqTtMc/zrOj6l81Q8oUxgw82L2xQWyP
	kBw5FHGWpT+RvuopGDDSsGgqOXfFPQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726125754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL6g0fqV3HQuTCGH8GHnr5jIa2aqkDO1bANMf4TU9a4=;
	b=t5ZibXalNcCSUoxOzXPIfXSif3WCAz1ZLBFY7ionHtNiZtvV7eI6L/DOl/4DAhY8FxdHRs
	b5yDqk0obstOiRCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uozEnx54;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f920ZvR9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726125753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL6g0fqV3HQuTCGH8GHnr5jIa2aqkDO1bANMf4TU9a4=;
	b=uozEnx54OP8rZgAh6/Ba6m5VqpL2Ehh5TT1Or4eruK6hShA1Fi9j9Rer4UlqYq2dYb8wzF
	61MyjItagsd+favOENWMA1FeeP06sMGU5vFGqDnpInSAEKZnNQ7ZICPrR3nbpjdyY4ulko
	3jOl7ys5Eml3mxX8eAp75vp41jwj0SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726125753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL6g0fqV3HQuTCGH8GHnr5jIa2aqkDO1bANMf4TU9a4=;
	b=f920ZvR940sk8rt2QrnIojcnWCQHymarHum69GpAkXP7yyPTOzG1e5v7MVik0/pBgRGDX9
	BhMBbA/cBoy13fDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2C8513A73;
	Thu, 12 Sep 2024 07:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GgiHJrmW4mYMdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Sep 2024 07:22:33 +0000
Date: Thu, 12 Sep 2024 09:23:21 +0200
Message-ID: <87bk0t1gk6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joshua Pius <joshuapius@chromium.org>
Cc: Joshua Pius <joshuapius@google.com>,
	alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Steven 'Steve' Kendall" <skend@chromium.org>,
	Karol Kosik <k.kosik@outlook.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add logitech Audio profile quirk
In-Reply-To: <CAPUqXZAabm2xCK_H9bf=JBZk25BXKzsCUtcGEv0dHsMCyUTcZQ@mail.gmail.com>
References: <20240906211445.3924724-1-joshuapius@google.com>
	<878qw2d1ry.wl-tiwai@suse.de>
	<CAFs7P=g8Pqk2-WH8kX6spNSjJ8x80GnDur0ny2CvpzTKb7oa+Q@mail.gmail.com>
	<87o74v7w43.wl-tiwai@suse.de>
	<CAPUqXZAabm2xCK_H9bf=JBZk25BXKzsCUtcGEv0dHsMCyUTcZQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0898219E5
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,alsa-project.org,perex.cz,suse.com,chromium.org,outlook.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 11 Sep 2024 21:27:34 +0200,
Joshua Pius wrote:
> 
> Done.

Err, I meant to resubmit a new patch with the consistent From and
Signed-off-by tag.  I haven't seen any new patch yet.


Takashi

> 
> 
> On Tue, Sep 10, 2024 at 4:25 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Mon, 09 Sep 2024 04:03:36 +0200,
> > Joshua Pius wrote:
> > >
> > > Yes, this change is for UCM profiles.
> > >
> > > Yes this should be a one time occurrence as afterwards effort is being
> > > made to migrate over to UCM v2.
> >
> > OK, then I'll take it.  But, I noticed that your Signed-off-by tag was
> > with google.com address while you submitted from chromium.org.
> > Could you align those?
> >
> >
> > thanks,
> >
> > Takashi
> >
> > >
> > > Thanks,
> > >
> > > Joshua P
> > >
> > >
> > >
> > >
> > >
> > > On Sun, Sep 8, 2024 at 3:47 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Fri, 06 Sep 2024 23:14:38 +0200,
> > > > Joshua Pius wrote:
> > > > >
> > > > > Specify shortnames for the following Logitech Devices: Rally bar, Rally
> > > > > bar mini, Tap, MeetUp and Huddle.
> > > > >
> > > > > Signed-off-by: Joshua Pius <joshuapius@chromium.org>
> > > >
> > > > Is this change needed only for UCM profiles?  UCM v2 should be able to
> > > > handle better to identify models, and such short name updates aren't
> > > > needed for them.
> > > >
> > > > OTOH, I don't mind much to take this kind of small harmless changes
> > > > (unless it happens too frequently).  So I'll likely take this, but
> > > > just for verifying the situation.
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Takashi
> > > >
> > > >
> > > > > ---
> > > > >  sound/usb/card.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > > > > index 778de9244f1e..9c411b82a218 100644
> > > > > --- a/sound/usb/card.c
> > > > > +++ b/sound/usb/card.c
> > > > > @@ -384,6 +384,12 @@ static const struct usb_audio_device_name usb_audio_names[] = {
> > > > >       /* Creative/Toshiba Multimedia Center SB-0500 */
> > > > >       DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
> > > > >
> > > > > +     /* Logitech Audio Devices */
> > > > > +     DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
> > > > > +     DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio"),
> > > > > +     DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
> > > > > +     DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
> > > > > +     DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
> > > > >       DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
> > > > >
> > > > >       DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
> > > > > --
> > > > > 2.46.0.598.g6f2099f65c-goog
> > > > >
> 

