Return-Path: <linux-kernel+bounces-355555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8CD995402
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852011C24BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D51E0B91;
	Tue,  8 Oct 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PQbvDA3A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TD7EfFCD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nW1hY0pT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WuUBlFIg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBB1E498;
	Tue,  8 Oct 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403542; cv=none; b=OHLmQkVdS/ZG4jwM3G62DQOJPOVF+WiTQjGP/bDhyhgLipnweHagaSa6Ghj+EPW5uvma7/gd4TevXtgfC89NhfK1lzhFS26b1nTGUKtblSV9v+R8/KLW9MrV1aAbrZtPMD1zTnow/OJgvfCh1pZ3eONksUujk45iCV17mGkZ+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403542; c=relaxed/simple;
	bh=ZbRbJWwNF/AeE+LMzcHvqOo/xGfNRwPvyy6wdQeCbdw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFXHP6yfqVLm8lqPCxmPxhMq42FhVuRwtpGg/3U6m9HJovzM3+9+P0BpL6NY56pKJjPZY4qWhpUGJBkO4nXUSm9zQqdhuqof+mYzsNRpJOJhTKUc78kLhhv1+i/FTJ1G7UIf9ilTXCRlWY28AAbj7NuGRG/l77yXpJSqa8PL21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PQbvDA3A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TD7EfFCD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nW1hY0pT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WuUBlFIg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D728E1FB62;
	Tue,  8 Oct 2024 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728403539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCIaegWAbU/B2iHGEWQDJjBxW35IPdzC29ItdoN3sd0=;
	b=PQbvDA3A29L5c7TybvH5QZhfHoWgXcMT0f8L+HeIg1k0Gah4tbF6I//g4pJJ+kWvwoQ5pY
	nlAdc5XycZ0bMEysQWGINQjk4KVBWjma4Kmj3A9M66at5aHtpXZTxsKyPOnS73DcPBvsiI
	pdBDzYWLwo7neeTCuuvDrK6jzVVwPpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728403539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCIaegWAbU/B2iHGEWQDJjBxW35IPdzC29ItdoN3sd0=;
	b=TD7EfFCDPM9puXHqYvfsBGD2JAS0sp9CWTdfoUMUxZXJ1wGy3BDHFBH+ObTjE0GokbB+JM
	NiQxtcZRiNpU+uDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nW1hY0pT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WuUBlFIg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728403538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCIaegWAbU/B2iHGEWQDJjBxW35IPdzC29ItdoN3sd0=;
	b=nW1hY0pTajWkJO4JzR5jgscOX9qwXucwrOKmGlSs3t42phsVJBneMX9kl6ARW8H+fKt7Gb
	H9WpY/BzKO8n7WgyDpC5bB6PgA+tv1NK38M7N5aum+q5UJMBMSvHFnqfK61o9i4cIZnSNT
	Klg/8MvS9Apw8AiN9S8elztxAxpkAHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728403538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCIaegWAbU/B2iHGEWQDJjBxW35IPdzC29ItdoN3sd0=;
	b=WuUBlFIgBdrp5Szv8iLXSl6Pa4w1E6B8RnpbHt6ynQVNJ6GArenLfhQOaoy98QxWObhw+H
	DMQHiTVHQynKFNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 992111340C;
	Tue,  8 Oct 2024 16:05:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bAoQJFJYBWddQQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 08 Oct 2024 16:05:38 +0000
Date: Tue, 08 Oct 2024 18:06:34 +0200
Message-ID: <87a5fevat1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christoffer Sandberg <cs@tuxedo.de>
Cc: Jerry Luo <jerryluo225@gmail.com>,
	christian@heusel.eu,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	regressions@lists.linux.dev,
	wse@tuxedocomputers.com
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <8734lcmd01.wl-tiwai@suse.de>
References: <87jzfbh5tu.wl-tiwai@suse.de>
	<ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
	<87jzetk2l0.wl-tiwai@suse.de>
	<b38b5947482a5ca4b55e0ddb908c2f34@tuxedo.de>
	<87seteli51.wl-tiwai@suse.de>
	<d348ca06-38ca-474f-8673-dff2248331e5@gmail.com>
	<dbc783cc2608ac63ffd420b1dc3eeaa9@tuxedo.de>
	<87iku8mfzh.wl-tiwai@suse.de>
	<8292a0dccbdcfcaebfb04bd84aa240e6@tuxedo.de>
	<8734lcmd01.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D728E1FB62
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,heusel.eu,vger.kernel.org,perex.cz,lists.linux.dev,tuxedocomputers.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 04 Oct 2024 11:30:22 +0200,
Takashi Iwai wrote:
> 
> On Fri, 04 Oct 2024 11:25:32 +0200,
> Christoffer Sandberg wrote:
> > 
> > 
> > 
> > On 4.10.2024 10:25, Takashi Iwai wrote:
> > > On Fri, 04 Oct 2024 10:18:10 +0200,
> > > Christoffer Sandberg wrote:
> > >> 
> > >> 
> > >> 
> > >> On 2.10.2024 23:28, Jerry Luo wrote:
> > >> > On 10/2/24 10:00 AM, Takashi Iwai wrote:
> > >> >> On Wed, 02 Oct 2024 10:21:22 +0200,
> > >> >> Christoffer Sandberg wrote:
> > >> >>>
> > >> >>>
> > >> >>> On 30.9.2024 09:44, Takashi Iwai wrote:
> > >> >>>> On Mon, 23 Sep 2024 21:37:42 +0200,
> > >> >>>> Jerry Luo wrote:
> > >> >>>>>
> > >> >>>>> Hi Takashi,
> > >> >>>>>
> > >> >>>>> On Mon, 16 Sep 2024 19:22:05 +0200,
> > >> >>>>>
> > >> >>>>> Takashi Iwai wrote:
> > >> >>>>>
> > >> >>>>>      Could you give alsa-info.sh output from both working and
> > >> >>>>> non-working
> > >> >>>>>      cases?  Run the script with --no-upload option and attach the
> > >> >>>>> outputs.
> > >> >>>>>
> > >> >>>>>      thanks,
> > >> >>>>>
> > >> >>>>>      Takashi
> > >> >>>>>
> > >> >>>>> Issue now reappear, output from alsa-info.sh are attached. If they
> > >> >>>>> are still
> > >> >>>>> needed.
> > >> >>>> Thanks.  The obvious difference seems to be the assignment of two
> > >> >>>> DACs
> > >> >>>> 0x10 and 0x11 for headphone and speaker outputs.
> > >> >>>>
> > >> >>>> Christoffer, how are those on your machines?
> > >> >>> I attached alsa-info from the Sirius Gen2 device.
> > >> >>>
> > >> >>> Comparing the working/nonworking of Jerry, yeah, the assignment of
> > >> >>> 0x10 and 0x11 looks switched around. I don't see what difference this
> > >> >>> would make. Also, node 0x22 has "bass speaker" controls in the
> > >> >>> non-working version.
> > >> >>>
> > >> >>> Comparing the Sirius Gen2 alsa-info with Jerrys, to me it looks like
> > >> >>> the non-working version corresponds to our working version.
> > >> >>>
> > >> >>> I would expect the non-working version to happen all the time though
> > >> >>> with regards to the "bass speaker" controls. Why would this only
> > >> >>> happen sometimes?
> > >> >> Thanks!  The assignment of DACs depend on the pins and topology, so it
> > >> >> can be a bit sensitive.
> > >> >>
> > >> >> Now looking more closely at both outputs, I wonder how the commit
> > >> >> breaks pang14.  Maybe it has a PCI SSID 2782:12c5 (or 12c3) while the
> > >> >> codec SSID is 2782:12b3?  If so, the patch below should fix.
> > >> 
> > >> Interesting, you're right, PCI SSID c3/c5 and codec SSID c3/c5 for the
> > >> Siriuses.
> > >> 
> > >> I had a look around. In patch_realtek there are some cases where codec
> > >> SSID match is needed as well. Would it be better/safer to directly do
> > >> this immediately or keep it as an exception where it breaks or for
> > >> known sensitive models/brands?
> > > 
> > > It needs a better handling, yes.  OTOH, the driver became gigantic and
> > > it's very tough to change the basic matching stuff.  That is, we can't
> > > flip from PCI SSID to codec SSID out of sudden, as it'll break
> > > certainly many other systems.
> > > 
> > > What I have in mind is to add an extra flag to the matching table to
> > > indicate the codec SSID matching, something like:
> > > 
> > > --- a/sound/pci/hda/hda_local.h
> > > +++ b/sound/pci/hda/hda_local.h
> > > @@ -282,6 +282,7 @@ struct hda_fixup {
> > >  	int type;
> > >  	bool chained:1;		/* call the chained fixup(s) after this */
> > >  	bool chained_before:1;	/* call the chained fixup(s) before this */
> > > +	bool match_codec_ssid:1; /* match with codec SSID instead of
> > > PCI SSID */
> > >  	int chain_id;
> > >  	union {
> > >  		const struct hda_pintbl *pins;
> > > 
> > 
> > Sounds reasonable to me. It would mean either-or then though.
> 
> Ah yes, it matches primarily with codec SSID instead of fallback.
> I guess if this flag is set, we shouldn't check PCI SSID, though.
> 
> > > Although this will help in this case, many of existing code do check
> > > codec ID in addition to PCI SSID, and this flag won't help for them as
> > > is.
> > 
> > For the fixups where codec SSID is already known for all cases it
> > would be possible to represent current logic with matching both SSIDs.
> > 
> > Otherwise I can not judge whether matching both PCI SSID and codec
> > SSID at the same time would be needed.
> > 
> > In any case, your approach would reduce code size if this is a
> > recurring thing.
> 
> OK, I'll try to prepare a cleanup patch later.

It turned out that my original idea above wasn't applicable, as we
want to filter out rather in the quirk table, not the target.
So I ended up with another patch and submitted shortly ago:
  https://lore.kernel.org/20241008120233.7154-1-tiwai@suse.de


Takashi

