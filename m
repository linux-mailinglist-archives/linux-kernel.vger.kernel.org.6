Return-Path: <linux-kernel+bounces-517329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0EA37F76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89320189A020
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E77F217718;
	Mon, 17 Feb 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VL6NvyDt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jbPvxmCf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D0phiIw9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lhFa6Qn+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BC2165E4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786542; cv=none; b=sClV3sS6icQHSXb+fORDL7lVIz0yncHbwoy+XqKGC8NXvWkkDTHnB/s3bBQaW9OfSpqkb58GAIim4BW6yvDljnEd2mzzPSvnDirQ5V6u1srSCKNvz+of3SmplVDM5I70p7xt3I8+2dmrvs1FbzAsYLNGpRFzdrqdiJyDz87WxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786542; c=relaxed/simple;
	bh=nACg6DT5VGn5eRpJp6XUU9IwP23zS21ckD3gLftmPeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc+2lS1u/oFLJOV2rmPJKz+Gcrzk0/gJHF5WkJDHDLmCLkypM1WduoFTZXLiAyMcbjUP7lKUvUZo597ZjT8OxkPtjZZ8npNChrEGvJ5OqY2usR0Yt8rqm6TlkdeDgx0UKyd8rtJvNuJvFgG7QM6LmurUacLdtzHMgZwFkqqDJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VL6NvyDt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jbPvxmCf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D0phiIw9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lhFa6Qn+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78095211AB;
	Mon, 17 Feb 2025 10:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739786538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifCPHsw4hKKup1+tTs8oRsM/KAt89MFr4TFT5o+3jB8=;
	b=VL6NvyDtBD4IkqizvIRD7R/vRQUOwfrCBbV+FNuZbpVETHzLVvLj8SaSBjtpfkkqtw/xqu
	Zb6Elr2afgrsHz7UxSrx18rHOHK1pTvlqx/+Strzuab5+U9shFEMP5hJReKmbg263K6wjV
	hBDdYHW3XbCfA3uzpc4sRvEJ8TLaWS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739786538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifCPHsw4hKKup1+tTs8oRsM/KAt89MFr4TFT5o+3jB8=;
	b=jbPvxmCfkQ4WQJV4zuxwUr+CcnnVea6xjLbdOukArmIfjsPhVtOdcIwFb1b8Yntg9uMAoY
	JGIxrMJ45vvl/wAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739786537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifCPHsw4hKKup1+tTs8oRsM/KAt89MFr4TFT5o+3jB8=;
	b=D0phiIw9+5XFlGLx8NwTfOKGdoF3NMMOtW8IFfolIqA01PFh8hTylfBx5XgWvbe3k3oVIp
	a6gtbx3UEy6WnILDxZiqNMug/98V08vwSkxBaB4sIYCFbc4hLLhN8daeAKuqWDKZrGUBNL
	dT4swSQrfL5Kisp6MF6EhDBp1xfVmKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739786537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ifCPHsw4hKKup1+tTs8oRsM/KAt89MFr4TFT5o+3jB8=;
	b=lhFa6Qn+ZyerYMUxhp+UCMfLykJxzEgBjzr7niL9d5s9yF8ban/JvOnADbNyzw7LPnFl9f
	+i0l4bzicVe9tHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5AF0133F9;
	Mon, 17 Feb 2025 10:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pMgJMSgJs2c7SQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 17 Feb 2025 10:02:16 +0000
Date: Mon, 17 Feb 2025 11:02:16 +0100
Message-ID: <87jz9o99ef.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming Fan <shumingf@realtek.com>,
	Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
In-Reply-To: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 16 Feb 2025 22:31:03 +0100,
Maciej S. Szmigiero wrote:
> 
> PC speaker works well on this platform in BIOS and in Linux until sound
> card drivers are loaded. Then it stops working.
> 
> There seems to be a beep generator node at 0x1a in this CODEC
> (ALC269_TYPE_ALC215) but it seems to be only connected to capture mixers
> at nodes 0x22 and 0x23.
> If I unmute the mixer input for 0x1a at node 0x23 and start recording
> from its "ALC285 Analog" capture device I can clearly hear beeps in that
> recording.
> 
> So the beep generator is indeed working properly, however I wasn't able to
> figure out any way to connect it to speakers.
> 
> However, the bits in the "Passthrough Control" register (0x36) seems to
> work at least partially: by zeroing "B" and "h" and setting "S" I can at
> least make the PIT PC speaker output appear either in this laptop speakers
> or headphones (depending on whether they are connected or not).
> 
> 
> There are some caveats, however:
> * If the CODEC gets runtime-suspended the beeps stop so it needs HDA beep
> device for keeping it awake during beeping.
> 
> * If the beep generator node is generating any beep the PC beep passthrough
> seems to be temporarily inhibited, so the HDA beep device has to be
> prevented from using the actual beep generator node - but the beep device
> is still necessary due to the previous point.
> 
> * In contrast with other platforms here beep amplification has to be
> disabled otherwise the beeps output are WAY louder than they were on pure
> BIOS setup.
> 
> 
> Unless someone (from Realtek probably) knows how to make the beep generator
> node output appear in speakers / headphones using PC beep passthrough seems
> to be the only way to make PC speaker beeping actually work on this
> platform.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
> 
> Since more than 6 weeks has now passed since the previous version of this
> patch was posted, yet no better or other solution was provided I'm
> re-submitting an updated version of the original patch.
>     
> This solution has been working fine for me on this platform all that time,
> without any obvious issues.
>     
> Changes from v1:
> * Correct the typo in !IS_ENABLED(CONFIG_INPUT_PCSPKR) code that the
> kernel test robot found.
>     
> * Change codec_warn() into dev_warn_once(hda_codec_dev(codec))
> to avoid spamming the kernel log at runtime PM CODEC re-init.

This is really a thing to be checked by Realtek people at first, as
it's very vendor-specific thing.

Kailang, please check this.

And, except for that, I'm still concerned by the behavior change.
Also the caveat you mentioned about the runtime PM raises some doubt,
too.


thanks,

Takashi

> 
>  include/sound/hda_codec.h     |  1 +
>  sound/pci/hda/hda_beep.c      | 15 +++++++++------
>  sound/pci/hda/patch_realtek.c | 34 +++++++++++++++++++++++++++++++++-
>  3 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
> index 575e55aa08ca..c1fe6290d04d 100644
> --- a/include/sound/hda_codec.h
> +++ b/include/sound/hda_codec.h
> @@ -195,6 +195,7 @@ struct hda_codec {
>  	/* beep device */
>  	struct hda_beep *beep;
>  	unsigned int beep_mode;
> +	bool beep_just_power_on;
>  
>  	/* widget capabilities cache */
>  	u32 *wcaps;
> diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
> index e51d47572557..13a7d92e8d8d 100644
> --- a/sound/pci/hda/hda_beep.c
> +++ b/sound/pci/hda/hda_beep.c
> @@ -31,8 +31,9 @@ static void generate_tone(struct hda_beep *beep, int tone)
>  			beep->power_hook(beep, true);
>  		beep->playing = 1;
>  	}
> -	snd_hda_codec_write(codec, beep->nid, 0,
> -			    AC_VERB_SET_BEEP_CONTROL, tone);
> +	if (!codec->beep_just_power_on)
> +		snd_hda_codec_write(codec, beep->nid, 0,
> +				    AC_VERB_SET_BEEP_CONTROL, tone);
>  	if (!tone && beep->playing) {
>  		beep->playing = 0;
>  		if (beep->power_hook)
> @@ -212,10 +213,12 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
>  	struct hda_beep *beep;
>  	int err;
>  
> -	if (!snd_hda_get_bool_hint(codec, "beep"))
> -		return 0; /* disabled explicitly by hints */
> -	if (codec->beep_mode == HDA_BEEP_MODE_OFF)
> -		return 0; /* disabled by module option */
> +	if (!codec->beep_just_power_on) {
> +		if (!snd_hda_get_bool_hint(codec, "beep"))
> +			return 0; /* disabled explicitly by hints */
> +		if (codec->beep_mode == HDA_BEEP_MODE_OFF)
> +			return 0; /* disabled by module option */
> +	}
>  
>  	beep = kzalloc(sizeof(*beep), GFP_KERNEL);
>  	if (beep == NULL)
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 224616fbec4f..fff6e7c1c265 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -28,6 +28,7 @@
>  #include <sound/hda_codec.h>
>  #include "hda_local.h"
>  #include "hda_auto_parser.h"
> +#include "hda_beep.h"
>  #include "hda_jack.h"
>  #include "hda_generic.h"
>  #include "hda_component.h"
> @@ -6923,6 +6924,30 @@ static void alc285_fixup_hp_envy_x360(struct hda_codec *codec,
>  	}
>  }
>  
> +static void alc285_fixup_hp_beep(struct hda_codec *codec,
> +				 const struct hda_fixup *fix, int action)
> +{
> +	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
> +		codec->beep_just_power_on = true;
> +	} else  if (action == HDA_FIXUP_ACT_INIT) {
> +#ifdef CONFIG_SND_HDA_INPUT_BEEP
> +		/*
> +		 * Just enable loopback to internal speaker and headphone jack.
> +		 * Disable amplification to get about the same beep volume as
> +		 * was on pure BIOS setup before loading the driver.
> +		 */
> +		alc_update_coef_idx(codec, 0x36, 0x7070, BIT(13));
> +
> +		snd_hda_enable_beep_device(codec, 1);
> +
> +#if !IS_ENABLED(CONFIG_INPUT_PCSPKR)
> +		dev_warn_once(hda_codec_dev(codec),
> +			      "enable CONFIG_INPUT_PCSPKR to get PC beeps\n");
> +#endif
> +#endif
> +	}
> +}
> +
>  /* for hda_fixup_thinkpad_acpi() */
>  #include "thinkpad_helper.c"
>  
> @@ -7707,6 +7732,7 @@ enum {
>  	ALC285_FIXUP_HP_GPIO_LED,
>  	ALC285_FIXUP_HP_MUTE_LED,
>  	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
> +	ALC285_FIXUP_HP_BEEP_MICMUTE_LED,
>  	ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
>  	ALC236_FIXUP_HP_GPIO_LED,
>  	ALC236_FIXUP_HP_MUTE_LED,
> @@ -9303,6 +9329,12 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc285_fixup_hp_spectre_x360_mute_led,
>  	},
> +	[ALC285_FIXUP_HP_BEEP_MICMUTE_LED] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc285_fixup_hp_beep,
> +		.chained = true,
> +		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
> +	},
>  	[ALC236_FIXUP_HP_MUTE_LED_COEFBIT2] = {
>  	    .type = HDA_FIXUP_FUNC,
>  	    .v.func = alc236_fixup_hp_mute_led_coefbit2,
> @@ -10392,7 +10424,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8730, "HP ProBook 445 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8735, "HP ProBook 435 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
> -	SND_PCI_QUIRK(0x103c, 0x8760, "HP", ALC285_FIXUP_HP_MUTE_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8760, "HP EliteBook 8{4,5}5 G7", ALC285_FIXUP_HP_BEEP_MICMUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x876e, "HP ENVY x360 Convertible 13-ay0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
>  	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),

