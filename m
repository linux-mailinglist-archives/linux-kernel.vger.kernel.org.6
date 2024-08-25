Return-Path: <linux-kernel+bounces-300332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D195E282
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0E11C2158B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89935FB95;
	Sun, 25 Aug 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bslASVOi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N3jBryQT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WN2HVeSV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="da0+/3Y+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4E2AEFD;
	Sun, 25 Aug 2024 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571924; cv=none; b=c5aQZeBG1UPlWsFa7Y8by0odqBTV1scaeLDhUmpFY9trXNqLL3IDmUfsqwF5K01MEaXj3u76GAKsF9fuaYLc51fE2J+OCNHK17pni9c03z62ZLz75lchijpzGYFQcTZbSCrChj2XVfpIkMOK3yCgct1boWiUYAsnxU/hKrwhtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571924; c=relaxed/simple;
	bh=/DABWROC1adRtXnWduaVICJKfy7K1ffXdGB6MNny38Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRDcGcx/m9mqn9Z3YKRg5wnRvpXa2kDd8NpkV+JaJ/Yb4VQUYr56RekcwX3owOG9yfiTBB8t4mobgyY0RWA2ChBu2Hd3F44ov801SwbkbF7SGNYGx+goNKzoL+ry8yn7cPPrxVMltLPp6xJ8zDXmGGu5KeCMaruKEYG/Gm3mRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bslASVOi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N3jBryQT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WN2HVeSV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=da0+/3Y+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54BC121A28;
	Sun, 25 Aug 2024 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724571920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywAiuhHecTp3MGsrAA/iUK/3ImfbVXkO3ORRDzjFjgA=;
	b=bslASVOi+d+zvNlSb0PHOovLB1Bdsi1/q6GvVEoo/Zg+RYJD+vwU0Wogc/KoStUvw0O+vv
	2/28+vkXB7qS40foMJFMMP/HlAYy6pLxXj1ho6Vwjc/PJ0GAcCbmCxS1SJHhMRYgUi/v/g
	sR29pwDtS2NVuwjNZHXrrFpnUwgoo14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724571920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywAiuhHecTp3MGsrAA/iUK/3ImfbVXkO3ORRDzjFjgA=;
	b=N3jBryQTjpz0wgNHkfUKTUw8asFzM4kbJ2MUcJXdXZk30c3unPhlGQoaO6MjqGcBp5QbUW
	MN37gSVs4r4LWjDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724571919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywAiuhHecTp3MGsrAA/iUK/3ImfbVXkO3ORRDzjFjgA=;
	b=WN2HVeSV0mQAsCmhyDuVBInbdCHljvv7veKgockJ3f7X9k5QK7b9wuMPcnj1j1ovA4Mmyd
	scmrZoF8UiK1Gst4wSq9m7T5M4UKR0cV9D16A3TncS2URAkSn7sLtcsBUn7QOj5xB6hywk
	0dPT9HkSTg4t8RhAbtO6jNx2bWpMu94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724571919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywAiuhHecTp3MGsrAA/iUK/3ImfbVXkO3ORRDzjFjgA=;
	b=da0+/3Y+3Lw0E4UAt+rTiysmaBoG47+HfZ5yyKy9LnMkr4er6zDFQ/n8w4AmWDnVAqzOd8
	ToTuy5FQfNNBVlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04FA013704;
	Sun, 25 Aug 2024 07:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GZNiOw7hymbnYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 25 Aug 2024 07:45:18 +0000
Date: Sun, 25 Aug 2024 09:46:02 +0200
Message-ID: <87frqtjb9h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hendrik Borghorst <hendrikborghorst@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alsa: support HP Pavilion Aero 13-bg0xxx Mute LED
In-Reply-To: <20240824183445.6610-1-hendrikborghorst@gmail.com>
References: <20240824183445.6610-1-hendrikborghorst@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Sat, 24 Aug 2024 20:34:38 +0200,
Hendrik Borghorst wrote:
> 
> This patch adds the HP Pavilion Aero 13 (13-bg0xxx) (year 2024) to list of
> quirks for keyboard LED mute indication.
> 
> The laptop has two LEDs (one for speaker and one for mic mute). The
> pre-existing quirk ALC245_FIXUP_HP_X360_MUTE_LEDS chains both the quirk for
> mic and speaker mute.
> 
> Tested on 6.11.0-rc4 with the aforementioned laptop.
> 
> Signed-off-by: Hendrik Borghorst <hendrikborghorst@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index d022a25635f9..a45062c9ed6d 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10217,6 +10217,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
>  	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8cbd, "HP Pavilion Aero Laptop 13-bg0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
>  	SND_PCI_QUIRK(0x103c, 0x896d, "HP ZBook Firefly 16 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8971, "HP EliteBook 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),

The table is sorted in PCI SSID number.  Could you try to put the
entry at the right position?


thanks,

Takashi

