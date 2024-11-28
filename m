Return-Path: <linux-kernel+bounces-424324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605339DB309
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90EBB21E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C025146A72;
	Thu, 28 Nov 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xFf6XQMg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eahhhYGi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IaAjvoTO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jDlXpyK6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275717C7C;
	Thu, 28 Nov 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778021; cv=none; b=oEC43ZeYvmjBZZ0aZcTH5A5pKUIhIahDZq3wDdJuqTBApZTtJorfRkZkJPlwLrTuE4TT15/tNE397Ebmisjuas+VhcyryHmbLucTbhSKWhecpZwFdDd3PV6Oh0d/z3xOjCrC1htb5WUZEQJ5yHordN/VLifPEqxO7wi5KcmTibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778021; c=relaxed/simple;
	bh=ttnpx85QzuXWP+00PWyJB1e8iARdDAn2piZmIn7Ef8A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAkm5//s/+0WnHHe0qjCpZyZw/IV7rDc3ZU3HqT0nRkMmA6TjUy/o0neC8OVgeD7tG7GHUwgo0k5vh3237zk+/nzsQttTG3VavBwKXEB0OhoUn+1DebSiGIXBWroZSzjTA3Rl7bBOuOxmZMZB6ff4YX2luMlhUdsycC6S9mza4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xFf6XQMg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eahhhYGi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IaAjvoTO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jDlXpyK6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3CB021164;
	Thu, 28 Nov 2024 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732778012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BidM+2SuXZzTG5UkEFJl+dPiNS4VFtpN6A+CWIGP6dI=;
	b=xFf6XQMgkcbDjP/ivDJa4qG/fjOEELlKOEsqsYtj1xKS93uZy4WYrwkMhEVR/MXXCpJrhR
	wW91RgsEDO3S2bweuYlwtAW1Ds8YtI3eg9Xqooxc4WyEH4GN2iyRefv5jAmMlLNPX5SHtj
	O8W0Ok9dw31I7IVQDgsmSxtv7SUmHxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732778012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BidM+2SuXZzTG5UkEFJl+dPiNS4VFtpN6A+CWIGP6dI=;
	b=eahhhYGiLiGzK4sQO11adoyUa44folEEoJgF8ne/KH5/Yzj8W7kfKDRr2oJpPSq9cGxcht
	2pPoLlCFGjgvcoBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IaAjvoTO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jDlXpyK6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732778011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BidM+2SuXZzTG5UkEFJl+dPiNS4VFtpN6A+CWIGP6dI=;
	b=IaAjvoTOx7noDhBFL1yfS76A/sxmwcekiNrHVslzJx1ZYuknBlNDC3Dsbj+n7xsIVFKjFB
	GJ6cD0B8jf9emyIGvwpSgvOHuCGOdmOXi7MSYUlyKtvf2VRlvgHHe7+FjIQLmgWXD7kRY8
	q3/nHPPsTf1Qn3nfE6d7YyBwfcahodY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732778011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BidM+2SuXZzTG5UkEFJl+dPiNS4VFtpN6A+CWIGP6dI=;
	b=jDlXpyK6MSlHMhv3aqACtKuIPS+vq2uiJ5jiA7B7UxSNm6Ex9ywVoIaYZEcRhebj2Pgal9
	ysTK4vzBbGoqmpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A98BC13690;
	Thu, 28 Nov 2024 07:13:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJS5JxsYSGcjEQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 Nov 2024 07:13:31 +0000
Date: Thu, 28 Nov 2024 08:13:31 +0100
Message-ID: <874j3r6db8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	feng.liu@senarytech.com
Subject: Re: [PATCH V2] ALSA: hda/conexant: fix Z60MR100 startup pop issue
In-Reply-To: <20241128060812.433362-1-bo.liu@senarytech.com>
References: <20241128060812.433362-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E3CB021164
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[senarytech.com:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 28 Nov 2024 07:08:12 +0100,
bo liu wrote:
> 
> When Z60MR100 startup, speaker will output a pop. To fix this issue,
> we mute codec by init verbs in bios when system startup, and set GPIO
> to low to unmute codec in codec driver when it loaded .
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>
> ---
>  sound/pci/hda/patch_conexant.c | 35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index e851785ff058..62c53e64bcad 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -42,6 +42,7 @@ struct conexant_spec {
>  	unsigned int gpio_led;
>  	unsigned int gpio_mute_led_mask;
>  	unsigned int gpio_mic_led_mask;
> +	unsigned int gpio_unmute_bit_mask;
>  	bool is_cx8070_sn6140;
>  };
>  
> @@ -308,6 +309,7 @@ enum {
>  	CXT_FIXUP_HP_MIC_NO_PRESENCE,
>  	CXT_PINCFG_SWS_JS201D,
>  	CXT_PINCFG_TOP_SPEAKER,
> +	CXT_FIXUP_HP_A_U,
>  };
>  
>  /* for hda_fixup_thinkpad_acpi() */
> @@ -762,6 +764,24 @@ static void cxt_setup_mute_led(struct hda_codec *codec,
>  	}
>  }
>  
> +static void cxt_setup_mute_gpio_and_unmute(struct hda_codec *codec,
> +				unsigned int gpio_mute_mask)
> +{
> +	struct conexant_spec *spec = codec->spec;
> +
> +	if (gpio_mute_mask) {
> +		spec->gpio_unmute_bit_mask = gpio_mute_mask;

Any reason to store this in spec?  As far as I see the code below,
it's used only locally here, so it doesn't have to be stored there.


> +
> +		//set gpio data to 0.

Put a space after "//".

> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
> +					spec->gpio_unmute_bit_mask);
> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
> +					spec->gpio_unmute_bit_mask);
> +		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_STICKY_MASK, 0);
> +	}
> +}
> +
>  static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
>  				const struct hda_fixup *fix, int action)
>  {
> @@ -776,6 +796,15 @@ static void cxt_fixup_hp_zbook_mute_led(struct hda_codec *codec,
>  		cxt_setup_mute_led(codec, 0x10, 0x20);
>  }
>  
> +static void cxt_fixup_hp_a_u(struct hda_codec *codec,
> +			const struct hda_fixup *fix, int action)
> +{
> +	//Init vers in BIOS mute the spk/hp by set gpio high to avoid pop noise,
> +	//so need to unmute once by clearing the gpio data when runs into the system.

Ditto.


thanks,

Takashi

