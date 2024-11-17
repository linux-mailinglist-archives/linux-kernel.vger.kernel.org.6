Return-Path: <linux-kernel+bounces-412124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA7C9D0421
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FE7B21F67
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B71CF5E9;
	Sun, 17 Nov 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gWOjL3oj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C40yiof1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gWOjL3oj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C40yiof1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AEC1CF2A4;
	Sun, 17 Nov 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731851143; cv=none; b=R7C1uoRaV3NLF+uaMvzo924gDDpBFq6qqXEwzLEXN+6EatsCWqxMRbm9+MNqCCQa/pwUvRNTPipkxlzxB5gheFtJmOxieOdZG0JWcz526pVLwUN3KLXrd8lHvukXKY4LjlNnPhwVXUUeR2KjJAAby/NxIMVwEPPWM5lt76ymUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731851143; c=relaxed/simple;
	bh=wlpL9K/BSFvJu/8n0B/UjT/JVS4r5lRUhoUFjHt1F3w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slKmjZiyJGiqDBmXe5Xm7+csiBVNdTe1vQ3w9t3XzHJI/LM2cnbB9F+/bfCWZ/r1+7ugGMBJcGHCdwLcrzk7JfJD0m2M3aGBFlrn6a02C+VNlKnVWMrYiMqpwpcr/S+hw7+KHXOx+K+L47wAwMMnyhisLtQ7Y/LeZ8+UCVC9HPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gWOjL3oj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C40yiof1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gWOjL3oj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C40yiof1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17D0D1F392;
	Sun, 17 Nov 2024 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731851140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClVxzXfHCSPMV48ylQZaEyqqtVKOcchnFeid0TS1gMY=;
	b=gWOjL3ojg1hD+BuYuezAa1bdQMQbZLZsPO6/jC3mIm991QSr2mBmC/pKXuUKOLooo8YapR
	dNOrom8FbWD7kwNYfTOrlOzSmT6vFKXH/WOBlqmTYn7vDHCotJd3Xik8h3Sr97bNQbTP/f
	MI2Bqu8FHYJdocc2cp27lrm9y+dwF8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731851140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClVxzXfHCSPMV48ylQZaEyqqtVKOcchnFeid0TS1gMY=;
	b=C40yiof1Pin9we/KFSMazE1NupuK4M3blYtzp6mbdlSchG/XW2PABjT2tkPabhF1ZjMra3
	mZmqzQgtUhHLfnCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gWOjL3oj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C40yiof1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731851140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClVxzXfHCSPMV48ylQZaEyqqtVKOcchnFeid0TS1gMY=;
	b=gWOjL3ojg1hD+BuYuezAa1bdQMQbZLZsPO6/jC3mIm991QSr2mBmC/pKXuUKOLooo8YapR
	dNOrom8FbWD7kwNYfTOrlOzSmT6vFKXH/WOBlqmTYn7vDHCotJd3Xik8h3Sr97bNQbTP/f
	MI2Bqu8FHYJdocc2cp27lrm9y+dwF8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731851140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClVxzXfHCSPMV48ylQZaEyqqtVKOcchnFeid0TS1gMY=;
	b=C40yiof1Pin9we/KFSMazE1NupuK4M3blYtzp6mbdlSchG/XW2PABjT2tkPabhF1ZjMra3
	mZmqzQgtUhHLfnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2920136D9;
	Sun, 17 Nov 2024 13:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4vkXKoPzOWc4cwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 17 Nov 2024 13:45:39 +0000
Date: Sun, 17 Nov 2024 14:45:39 +0100
Message-ID: <87iksmq8ho.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hridesh MG <hridesh699@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
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
In-Reply-To: <20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com>
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
	<20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 17D0D1F392
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 14 Nov 2024 17:41:19 +0100,
Hridesh MG wrote:
> 
> The headset jack on the realtek ALC287 codec for the Acer Nitro 5
> AN515-58 laptop requires a fixup to detect microphone input.
> 
> The required pin config and verbs were obtained by reverse engineering
> the windows driver using RtHD dump.
> 
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 571fa8a6c9e1204892a93ffb24acce65400ce4b2..0204ed80791db87153dad80d6a25466985ce5784 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -7780,6 +7780,8 @@ enum {
>  	ALC287_FIXUP_LENOVO_SSID_17AA3820,
>  	ALC245_FIXUP_CLEVO_NOISY_MIC,
>  	ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE,
> +	ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN,
> +	ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS,
>  };
>  
>  /* A special fixup for Lenovo C940 and Yoga Duet 7;
> @@ -10154,6 +10156,23 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.chained = true,
>  		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
>  	},
> +	[ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN] = {
> +		.type = HDA_FIXUP_PINS,
> +		.chained = true,
> +		.chain_id = ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +			{ 0x19, 0x03a19020 }, /* missing pin for headphone jack mic */

This looks fine, but...

> +			{ }
> +		}
> +	},
> +	[ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS] = {
> +		.type = HDA_FIXUP_VERBS,
> +		.v.verbs = (const struct hda_verb[]) {
> +			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
> +			{ 0x20, AC_VERB_SET_PROC_COEF, 0xD689 },

This is a generic setup for the headset input in CTIA mode.
Do you really need this explicity?  Usually it's set up at
alc_headset_mode_ctia() when the iPhone type is connected.

>  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> @@ -10201,6 +10220,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1025, 0x1466, "Acer Aspire A515-56", ALC255_FIXUP_ACER_HEADPHONE_AND_MIC),
>  	SND_PCI_QUIRK(0x1025, 0x1534, "Acer Predator PH315-54", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_ACER_SFG16_MICMUTE_LED),
> +	SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN),

The table is sorted in PCI SSID order.  Please put at the right
place.

> +	{.id = ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN, .name = "alc287-fixup-acer-nitro-headset-mic"},

Nowadays the less need for a new model name string.  You can specify
the model with an alias of SSID if any other device needs to apply the
same quirk, too.  So, unless it's mandatory, better to drop.


thanks,

Takashi

