Return-Path: <linux-kernel+bounces-413029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7D9D129F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB1B2949F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834F19D88D;
	Mon, 18 Nov 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UBGGVrlG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vzKTrzDf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UBGGVrlG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vzKTrzDf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA253A7;
	Mon, 18 Nov 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937962; cv=none; b=QJdswSQ1rrkXFRQiO9k3WPLEaZy0yFj54HWcwi+RqLu5H+87MQ+AW6Ijg6ATRFgPF63RA6qYXloqUvZ5D1J66SWpEeBAUw5oMMkIQ4J3319lj+MC0QixKcQA+1GuYRgxd2NMPkVYKgwzGVv38EbKd28e0NzscJFuSD2Iw5EY5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937962; c=relaxed/simple;
	bh=0E+6qLPfRKUmoBQt3Sft11wxa/H2O0IMukdApYlQCLY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiMEMkF847lkecOUjniSfVfDyf7xlGUSzRciQMNEyoCvrt9aZB73f7aTQqSEeStDajIZvCLoHVO89zMFERCUFqHEwDcYjPPamEiWjoNfnA8RWqE3y4uTz2GgpWakE6GB3bOOWKTLBoB4J3zSzdMSEpwKNFozOYA72zRRKpf30YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UBGGVrlG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vzKTrzDf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UBGGVrlG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vzKTrzDf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41B07216F1;
	Mon, 18 Nov 2024 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731937958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw9Dty/2ZuJfFF40RG81VtuhOH2jUbCY3Jfr3J5wMXE=;
	b=UBGGVrlG0LmZzpfKTp9/q+TfJsMQwq4gM0nL1XogIGmW3owTExkBvcT0cO69T8ecHN6ASj
	rwx8GCxHy9MIqoOwidTysic1Tadvib+uQsjKVuKVy+6Hw9QAjWQOmL7GEsNENfZ4r/ZDRb
	u3UcExeR9Iv9Hy5NNpZUWw9gx6n2sL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731937958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw9Dty/2ZuJfFF40RG81VtuhOH2jUbCY3Jfr3J5wMXE=;
	b=vzKTrzDf8UN2FiKoWTDH8HWYZHLY94G0O5GfqgmgHaDPXXtEbCeF77masv2goqncP3XMoe
	lZAxCUb4CcdVyjAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UBGGVrlG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vzKTrzDf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731937958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw9Dty/2ZuJfFF40RG81VtuhOH2jUbCY3Jfr3J5wMXE=;
	b=UBGGVrlG0LmZzpfKTp9/q+TfJsMQwq4gM0nL1XogIGmW3owTExkBvcT0cO69T8ecHN6ASj
	rwx8GCxHy9MIqoOwidTysic1Tadvib+uQsjKVuKVy+6Hw9QAjWQOmL7GEsNENfZ4r/ZDRb
	u3UcExeR9Iv9Hy5NNpZUWw9gx6n2sL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731937958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw9Dty/2ZuJfFF40RG81VtuhOH2jUbCY3Jfr3J5wMXE=;
	b=vzKTrzDf8UN2FiKoWTDH8HWYZHLY94G0O5GfqgmgHaDPXXtEbCeF77masv2goqncP3XMoe
	lZAxCUb4CcdVyjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B62134A0;
	Mon, 18 Nov 2024 13:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JCIuM6VGO2fIbAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Nov 2024 13:52:37 +0000
Date: Mon, 18 Nov 2024 14:52:37 +0100
Message-ID: <87ed387ioq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hridesh MG <hridesh699@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
In-Reply-To: <CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com>
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
	<20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com>
	<87iksmq8ho.wl-tiwai@suse.de>
	<CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41B07216F1
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 17 Nov 2024 21:24:45 +0100,
Hridesh MG wrote:
> 
> > > +     [ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS] = {
> > > +             .type = HDA_FIXUP_VERBS,
> > > +             .v.verbs = (const struct hda_verb[]) {
> > > +                     { 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
> > > +                     { 0x20, AC_VERB_SET_PROC_COEF, 0xD689 },
> >
> > This is a generic setup for the headset input in CTIA mode.
> > Do you really need this explicity?  Usually it's set up at
> > alc_headset_mode_ctia() when the iPhone type is connected.
> Yeah, the mic wont pick up input without it. I did have a feeling that
> it's supposed to be set up automatically rather than being set as a
> verb but I couldn't figure out which part of the code I'm supposed to
> modify to make that happen. I've tried running it with dynamic
> debugging turned on but I don't see the output of codec_dbg from
> alc_headset_mode_ctia() :(

Is alc_fixup_headset_mode() called by the quirk chain?
When this is set up via quirks, alc_update_headset_mode() gets called
at initialization and this should detect the headset type.  At that
point, alc_headset_mode_ctia() would be called if the proper type gets
detected.

> > >  static const struct snd2_pci_quirk alc269_fixup_tbl[] = {
> > > @@ -10201,6 +10220,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> > >       SND_PCI_QUIRK(0x1025, 0x1466, "Acer Aspire A515-56", ALC255_FIXUP_ACER_HEADPHONE_AND_MIC),
> > >       SND_PCI_QUIRK(0x1025, 0x1534, "Acer Predator PH315-54", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
> > >       SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
> > > +     SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN),
> >
> > The table is sorted in PCI SSID order.  Please put at the right
> > place.
> Will do, thanks.
> 
> > > +     {.id = ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN, .name = "alc287-fixup-acer-nitro-headset-mic"},
> >
> > Nowadays the less need for a new model name string.  You can specify
> > the model with an alias of SSID if any other device needs to apply the
> > same quirk, too.  So, unless it's mandatory, better to drop.
> I added the model name string to make debugging easier for users. When
> troubleshooting this issue, I followed many guides that recommended
> the 'Codec-Specific Models' document, but no entry existed for the
> ALC287. I thought that adding a model name would help users quickly
> identify and apply the correct quirk without needing kernel expertise.
> However, if this goes against the current standards, I¢m happy to
> adjust.

We used to add static model names in the past, but since some years ago
the driver can accept a style like model=1025:169a option, so there is
no longer need for the explicit new model name string.


thanks,

Takashi

