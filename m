Return-Path: <linux-kernel+bounces-307169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27F964961
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CA1281D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634D1B252F;
	Thu, 29 Aug 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t7Q+lTir";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rwz+63Hb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t7Q+lTir";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rwz+63Hb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF81B1402;
	Thu, 29 Aug 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943761; cv=none; b=lI/WOgARajJ5fuhXJlddJ/bP2XqGzG+fA/oKv033jVW6I52uNLGq/t8QYpe49XtRtYZgybBCd3dr/RBFEoAO4w9HOL2Evx8tIRAhMPXnQQDZQoKjZvDOS2PTG793U/sAaJ1VZWqNDORLpWEhk22Z0mFm/+303Ko/GoZE6GFSz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943761; c=relaxed/simple;
	bh=UAusvvbdg2IQoqzAbue98/Thju9MJrWBSf3WwhkcI8w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DD5obwTdMfUd+jFz8mYLk84GouJ5ResNsyyj5Q9sMEASlN09SmJkr0GT04Fev18odXb+AoXxN2/J4xiiCqtYSjUsAhjTxE7vFcq2n3bdWPfMvUxt8cagQ4kQNNZ7+VqV6454U4vto8J5WXlGvQOm7lx/ES8vQdF3h/xa2rnli8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t7Q+lTir; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rwz+63Hb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t7Q+lTir; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rwz+63Hb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 896721F443;
	Thu, 29 Aug 2024 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724943757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1gVNaVflu1aaLfA3dtbtuJKp3oDtSRODV3UNOm1x0s=;
	b=t7Q+lTirUErNsRTdew3ChXTsUzuPnHqt3vF9/Q8fsKFjFxI1qwAqFhRLW/QGxtUIfBMaeQ
	9YtZW999N2rkqDpLDc9MCOci05FX6HuV1P2D8bsPrfMBM/AVSNu3flE9auf6MGo7rmJU1+
	7caQ/De6ijZ+ZnWR/7BwyeHffH5Rzo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724943757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1gVNaVflu1aaLfA3dtbtuJKp3oDtSRODV3UNOm1x0s=;
	b=rwz+63HbUzKoyNpwequD4NsnVhCLdQDlIrGK9i5M9RI6S9CluDln4SMXmozC6+qC4W0im2
	QL8Jq+VTqyfLG3DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t7Q+lTir;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rwz+63Hb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724943757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1gVNaVflu1aaLfA3dtbtuJKp3oDtSRODV3UNOm1x0s=;
	b=t7Q+lTirUErNsRTdew3ChXTsUzuPnHqt3vF9/Q8fsKFjFxI1qwAqFhRLW/QGxtUIfBMaeQ
	9YtZW999N2rkqDpLDc9MCOci05FX6HuV1P2D8bsPrfMBM/AVSNu3flE9auf6MGo7rmJU1+
	7caQ/De6ijZ+ZnWR/7BwyeHffH5Rzo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724943757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1gVNaVflu1aaLfA3dtbtuJKp3oDtSRODV3UNOm1x0s=;
	b=rwz+63HbUzKoyNpwequD4NsnVhCLdQDlIrGK9i5M9RI6S9CluDln4SMXmozC6+qC4W0im2
	QL8Jq+VTqyfLG3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60457139B0;
	Thu, 29 Aug 2024 15:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMQ0Fo2N0GboYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 29 Aug 2024 15:02:37 +0000
Date: Thu, 29 Aug 2024 17:03:21 +0200
Message-ID: <87y14fv0au.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Terry Cheong <htcheong@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: add patch for internal mic in Lenovo V145
In-Reply-To: <20240829-lenovo-v145-fixes-v2-1-713ac5cbb32d@chromium.org>
References: <20240829-lenovo-v145-fixes-v2-1-713ac5cbb32d@chromium.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 896721F443
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,chromium.org:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 28 Aug 2024 22:20:18 +0200,
Terry Cheong wrote:
> 
> Lenovo V145 is having phase inverted dmic but simply applying inverted
> dmic fixups does not work. Chaining up verb fixes for ALC283 enables
> inverting dmic fixup to work properly.
> 
> Signed-off-by: Terry Cheong <htcheong@chromium.org>
> ---
> Changes in v2:
> - Corrected description for the patch
> - Link to v1: https://lore.kernel.org/r/20240829-lenovo-v145-fixes-v1-1-133d1e6813b3@chromium.org
> ---
>  sound/pci/hda/patch_realtek.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 588738ce7380..bbda235ea96c 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -7538,6 +7538,7 @@ enum {
>  	ALC236_FIXUP_HP_GPIO_LED,
>  	ALC236_FIXUP_HP_MUTE_LED,
>  	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
> +	ALC236_FIXUP_LENOVO_INV_DMIC,
>  	ALC298_FIXUP_SAMSUNG_AMP,
>  	ALC298_FIXUP_SAMSUNG_AMP2,
>  	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
> @@ -9161,6 +9162,12 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc236_fixup_hp_mute_led_micmute_vref,
>  	},
> +	[ALC236_FIXUP_LENOVO_INV_DMIC] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc_fixup_inv_dmic,
> +		.chained = true,
> +		.chain_id = ALC283_FIXUP_INT_MIC,
> +	},
>  	[ALC298_FIXUP_SAMSUNG_AMP] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc298_fixup_samsung_amp,
> @@ -10707,6 +10714,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
>  	SND_PCI_QUIRK(0x17aa, 0x3865, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
> +	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
>  	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
>  	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7 / Yoga Pro 7 14ARP8",  ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7),
>  	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion Pro 7/7i", ALC287_FIXUP_LENOVO_LEGION_7),

The quirk table is sorted in PCI SSID order.
Could you try to put the entry at the right position?


thanks,

Takashi

