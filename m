Return-Path: <linux-kernel+bounces-343534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53040989C30
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816D21C211E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373A170A0C;
	Mon, 30 Sep 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b8z/hce5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IrZCdNBi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b8z/hce5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IrZCdNBi"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460B15D5D9;
	Mon, 30 Sep 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683615; cv=none; b=r2QZ1FmP5Jk4YM9Buwz0HGZtKJlx9egdC5DNY5NazTv+CJvfO2Hyn2P9Q05IWD22pKeyMKXtoYZHOUCZoeveJCgZiRx/cglaCbIWNKiCar8kE0T5dMvN2FQU3IQPe65YRYQgBTg+JeOYdX9If4mmMZnUR9E4vlNPe9/KmzYn9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683615; c=relaxed/simple;
	bh=Ml/C1UEozI9Zq8G2VPoRO/w2gkGlFOuCHY0BvSjxaFg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/kIoYvyBp85VhodJC79vmCRO5AJhSbgUJr6OCyM+B9ymLSwhuaZF0DdKNN26/7O2yuKfSElu1lkX/8+ws0/mxAuGftxlHrx4yr5+d0UVBjJLk9J9N5I+HtHlA2xuCFn6FZ1jZu3XsD7QvSd7S3AAJOVElRScMskaD31dBYFwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b8z/hce5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IrZCdNBi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b8z/hce5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IrZCdNBi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2F7521A41;
	Mon, 30 Sep 2024 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgIzhpWSzAWDM2RoiQkqkuUGUoPapXR01pRgaP7CHLY=;
	b=b8z/hce5xtA+TfnuFxfHYDL4XDSk1Lfe1EXbfXnW1poDQe+MubukxRjT3eUm0IJqOCdK/1
	6li6XowDWCQNz3/i3LMxIp4JdmZYNNnWGStlcLf0H8JKRJA/jOqQXPUYIM+vph8LyolrEU
	2lZd1OXUn7Z0M9WuQw5ojV/9P1z300s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgIzhpWSzAWDM2RoiQkqkuUGUoPapXR01pRgaP7CHLY=;
	b=IrZCdNBi8nmXNEZww87HIswotiK2XDI2Xu6QilzZCHS3iK8w4H21YLvxt1Fy1B43I3aTsx
	O/1o0/hoRryca+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgIzhpWSzAWDM2RoiQkqkuUGUoPapXR01pRgaP7CHLY=;
	b=b8z/hce5xtA+TfnuFxfHYDL4XDSk1Lfe1EXbfXnW1poDQe+MubukxRjT3eUm0IJqOCdK/1
	6li6XowDWCQNz3/i3LMxIp4JdmZYNNnWGStlcLf0H8JKRJA/jOqQXPUYIM+vph8LyolrEU
	2lZd1OXUn7Z0M9WuQw5ojV/9P1z300s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgIzhpWSzAWDM2RoiQkqkuUGUoPapXR01pRgaP7CHLY=;
	b=IrZCdNBi8nmXNEZww87HIswotiK2XDI2Xu6QilzZCHS3iK8w4H21YLvxt1Fy1B43I3aTsx
	O/1o0/hoRryca+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85D9113A8B;
	Mon, 30 Sep 2024 08:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4LRQHxtc+mYoFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 08:06:51 +0000
Date: Mon, 30 Sep 2024 10:07:44 +0200
Message-ID: <87a5fpk1in.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cs@tuxedo.de,
	songxiebing@kylinos.cn,
	wse@tuxedocomputers.com
Subject: Re: [PATCH] ALSA: hda/conexant: fix Z60MR100 startup pop issue
In-Reply-To: <20240926100135.36499-1-bo.liu@senarytech.com>
References: <20240926100135.36499-1-bo.liu@senarytech.com>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 26 Sep 2024 12:01:35 +0200,
bo liu wrote:
> 
> When Z60MR100 startup, speaker will output a pop. To fix this issue,
> we mute codec in bios when startup, and use GPIO1 to unmute codec in
> codec driver.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>
> ---
>  sound/pci/hda/patch_conexant.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index e851785ff058..27758822377f 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -308,6 +308,7 @@ enum {
>  	CXT_FIXUP_HP_MIC_NO_PRESENCE,
>  	CXT_PINCFG_SWS_JS201D,
>  	CXT_PINCFG_TOP_SPEAKER,
> +	CXT_FIXUP_HP_A_U,
>  };
>  
>  /* for hda_fixup_thinkpad_acpi() */
> @@ -776,6 +777,18 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
>  		cxt_setup_mute_led(codec, 0x10, 0x20);
>  }
>  
> +static void cxt_fixup_hp_a_u(struct hda_codec *codec,
> +			const struct hda_fixup *fix, int action)
> +{
> +	if (action == HDA_FIXUP_ACT_INIT) {
> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK, 2);
> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION, 2);
> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_STICKY_MASK, 0);
> +	}

The GPIO bits can be manipulated for LEDs, and that would override
this setup.  It'd be better to define something like
spec->gpio_static_mask and set it in cxt_init_gpio_led().


thanks,

Takashi

