Return-Path: <linux-kernel+bounces-356969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D081D996991
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF8C284B18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4996192B8F;
	Wed,  9 Oct 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1b/s8cw8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hqP+K751";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1b/s8cw8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hqP+K751"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD118EFE0;
	Wed,  9 Oct 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475737; cv=none; b=pmTKQfklLRhzzvZytdabqnXezDosKnio0sASSgji18ZTMvkbNcvwW4baRVP6Bbd4DE5Uf2knKKkvkooCY++txZJ0R/UL635SJic/4rDGjQZ3sYR8eM3yw1kRy0gjy85qmn/fGH5EcUSm4HzxC2L7igUAvL3WA5jB9iU14xy+9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475737; c=relaxed/simple;
	bh=gq/vRJvMBYuidETBL2mqLiaNg7+JIrVhHVRXtvFLNAk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrgKumSLxRn7mCvIwHeWdzvtOjjZAzvBo4trEhYzAC75O0aDKrV/9gxf+R+3a/eGOk7alNGe3H6uInMW7tkcWqjYdJWlLRaXP/+tFZtD54SyNzG6q9EYkvbxx4ppeALe9Wvhv19coSS86VqMkUFJg3Hgu8vjIyjWllRSXQm/pPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1b/s8cw8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hqP+K751; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1b/s8cw8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hqP+K751; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB6A51FB84;
	Wed,  9 Oct 2024 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728475733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUvW5GGjSA27vm1oD9o1b29SFueOzVknhSZqW1ZYKRM=;
	b=1b/s8cw8t9sy0t1XGg+sAGmmY1NNGxybgP+C1WkovWdRG89zXVyxqZDj2+AiKZrBArOd1z
	qbe55M7R6KIyzxixOvXMrnKQrNR/Cew3QRinGvEOi9fZOeGduu5lHyeCV0+FW08lImkcSo
	3dNLIJ/cxhAUibWHHbjYcZ2YIEFhhGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728475733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUvW5GGjSA27vm1oD9o1b29SFueOzVknhSZqW1ZYKRM=;
	b=hqP+K751EzKMq5YAmiHmxefDnjVtpTV1cxHYg/XppG4NBQqSADvnWTIcVMGjQDaikVy+e3
	9zwaWkDu9kclhQDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1b/s8cw8";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hqP+K751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728475733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUvW5GGjSA27vm1oD9o1b29SFueOzVknhSZqW1ZYKRM=;
	b=1b/s8cw8t9sy0t1XGg+sAGmmY1NNGxybgP+C1WkovWdRG89zXVyxqZDj2+AiKZrBArOd1z
	qbe55M7R6KIyzxixOvXMrnKQrNR/Cew3QRinGvEOi9fZOeGduu5lHyeCV0+FW08lImkcSo
	3dNLIJ/cxhAUibWHHbjYcZ2YIEFhhGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728475733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUvW5GGjSA27vm1oD9o1b29SFueOzVknhSZqW1ZYKRM=;
	b=hqP+K751EzKMq5YAmiHmxefDnjVtpTV1cxHYg/XppG4NBQqSADvnWTIcVMGjQDaikVy+e3
	9zwaWkDu9kclhQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B6DF13A58;
	Wed,  9 Oct 2024 12:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id llqCHFVyBmcdFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 09 Oct 2024 12:08:53 +0000
Date: Wed, 09 Oct 2024 14:09:48 +0200
Message-ID: <87v7y1tr3n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH] ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
In-Reply-To: <20241009111207.655842-1-kovalev@altlinux.org>
References: <20241009111207.655842-1-kovalev@altlinux.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: AB6A51FB84
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Wed, 09 Oct 2024 13:12:07 +0200,
Vasiliy Kovalev wrote:
> 
> There is a problem with simultaneous audio output to headphones and
> speakers, and when headphones are turned off, the speakers also turn
> off and do not turn them on.
> 
> However, it was found that if you boot linux immediately after windows,
> there are no such problems. When comparing alsa-info, the only difference
> is the different configuration of Node 0x1d:
> 
> working conf. (windows): Pin-ctls: 0x80: HP
> not working     (linux): Pin-ctls: 0xc0: OUT HP
> 
> This patch disable the AC_PINCTL_OUT_EN bit of Node 0x1d and fixes the
> described problem.
> 
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>

Interesting, is this pin not used by any routes, but it has to be set
up?  A bit more comments would be helpful for the quirk function.

In anyway, please give alsa-info.sh output.  Run the script with
--no-upload option and attach the output.


thanks,

Takashi


> ---
>  sound/pci/hda/patch_conexant.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index b61ce5e6f5ec5..47d1929184b2a 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -303,6 +303,7 @@ enum {
>  	CXT_FIXUP_HP_SPECTRE,
>  	CXT_FIXUP_HP_GATE_MIC,
>  	CXT_FIXUP_MUTE_LED_GPIO,
> +	CXT_FIXUP_HP_ELITEONE_OUT_DIS,
>  	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
>  	CXT_FIXUP_HEADSET_MIC,
>  	CXT_FIXUP_HP_MIC_NO_PRESENCE,
> @@ -320,6 +321,17 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
>  	spec->gen.inv_dmic_split = 1;
>  }
>  
> +static void cxt_fixup_out_disable(struct hda_codec *codec,
> +				   const struct hda_fixup *fix, int action)
> +{
> +	if (action == HDA_FIXUP_ACT_PROBE) {
> +		unsigned int val;
> +
> +		val = snd_hda_codec_get_pin_target(codec, 0x1d);
> +		snd_hda_set_pin_ctl(codec, 0x1d, val & (~AC_PINCTL_OUT_EN));
> +	}
> +}
> +
>  static void cxt5066_increase_mic_boost(struct hda_codec *codec,
>  				   const struct hda_fixup *fix, int action)
>  {
> @@ -971,6 +983,10 @@ static const struct hda_fixup cxt_fixups[] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = cxt_fixup_mute_led_gpio,
>  	},
> +	[CXT_FIXUP_HP_ELITEONE_OUT_DIS] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = cxt_fixup_out_disable,
> +	},
>  	[CXT_FIXUP_HP_ZBOOK_MUTE_LED] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = cxt_fixup_hp_zbook_mute_led,
> @@ -1061,6 +1077,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
>  	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
>  	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
> +	SND_PCI_QUIRK(0x103c, 0x83e5, "HP EliteOne 1000 G2", CXT_FIXUP_HP_ELITEONE_OUT_DIS),
>  	SND_PCI_QUIRK(0x103c, 0x8402, "HP ProBook 645 G4", CXT_FIXUP_MUTE_LED_GPIO),
>  	SND_PCI_QUIRK(0x103c, 0x8427, "HP ZBook Studio G5", CXT_FIXUP_HP_ZBOOK_MUTE_LED),
>  	SND_PCI_QUIRK(0x103c, 0x844f, "HP ZBook Studio G5", CXT_FIXUP_HP_ZBOOK_MUTE_LED),
> -- 
> 2.33.8
> 

