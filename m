Return-Path: <linux-kernel+bounces-515348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC049A36395
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073993A6B74
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86626738A;
	Fri, 14 Feb 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cIVL5YoV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="We6OT8FI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cIVL5YoV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="We6OT8FI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF80245002
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551842; cv=none; b=I3nuAluqLYwLdrZI26R53BLuSxDJ4Sx6ec1x15GOTmRIddcCP3LRUPhpPTB4ZVZVd1U5h9EM3UzKD2jsXH+IRFkKtwcyJ1c7t+e0ouAmJdw14CPlj5hkjM8k598xTahE4c1t/gIHhYQbUmHAKlYBbSdOfgo01tDOaU2BgMdDs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551842; c=relaxed/simple;
	bh=qlMMIibr9KHm9ibM7FFd+UmdB3uLuPPaikSJNH1wDkA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSW2QBZv8h/0YeapJTYQJ65//SNcj3K1yT9x3DjJwX91FYsLTT0VoYFtdXDmmMyUjkcDbYDOm/cf6jPknoankNDqaCPvabuqkTEnZ/uwINKF8iPwYnxz8wR04Uj9MYPikzIntltviiOT+Ah1WBc/fiObrbX8SmkwABc0IIKY0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cIVL5YoV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=We6OT8FI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cIVL5YoV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=We6OT8FI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D93B210F8;
	Fri, 14 Feb 2025 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739551839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uikJNsa0IsBWSXLjFgb4Adl8m/7KsWzFWxdjjTDyTkI=;
	b=cIVL5YoVjkvzFr7Efl0axtuYsaDsbq8cx2bwfrepPrZ4jv4bL5eSduLsfzE6bxIRHKl5nR
	B3xxdVc3xNxH2rBj9noXYQyzRZX+9pQQj7H3TXym+N8k0X9Sj+TwP6kapcHURnU6eNnGbT
	PbaCVB0VA5XjQLHnamzUSNK1yoWOphk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739551839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uikJNsa0IsBWSXLjFgb4Adl8m/7KsWzFWxdjjTDyTkI=;
	b=We6OT8FIsda5aiJFsE/SDB68Tx1jSUFNFc/+i3L0AXI+shYLBTHvK8tbtb3zp5409xXIvo
	gRB/301CUZzxH2BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739551839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uikJNsa0IsBWSXLjFgb4Adl8m/7KsWzFWxdjjTDyTkI=;
	b=cIVL5YoVjkvzFr7Efl0axtuYsaDsbq8cx2bwfrepPrZ4jv4bL5eSduLsfzE6bxIRHKl5nR
	B3xxdVc3xNxH2rBj9noXYQyzRZX+9pQQj7H3TXym+N8k0X9Sj+TwP6kapcHURnU6eNnGbT
	PbaCVB0VA5XjQLHnamzUSNK1yoWOphk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739551839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uikJNsa0IsBWSXLjFgb4Adl8m/7KsWzFWxdjjTDyTkI=;
	b=We6OT8FIsda5aiJFsE/SDB68Tx1jSUFNFc/+i3L0AXI+shYLBTHvK8tbtb3zp5409xXIvo
	gRB/301CUZzxH2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE03E137DB;
	Fri, 14 Feb 2025 16:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c7UUJ150r2dRUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Feb 2025 16:50:38 +0000
Date: Fri, 14 Feb 2025 17:50:33 +0100
Message-ID: <87seog1ndy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ALSA: hda/cirrus: Correct the full scale volume set logic
In-Reply-To: <20250214162354.2675652-1-vitalyr@opensource.cirrus.com>
References: <20250214162354.2675652-1-vitalyr@opensource.cirrus.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,cirrus.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Feb 2025 17:23:25 +0100,
Vitaly Rodionov wrote:
> 
> This patch corrects the full-scale volume setting logic. On certain
> platforms, the full-scale volume bit is required. The current logic
> mistakenly sets this bit and incorrectly clears reserved bit 0, causing
> the headphone output to be muted.
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Can we have a Fixes tag?


thanks,

Takashi

> ---
>  sound/pci/hda/patch_cs8409-tables.c |  6 +++---
>  sound/pci/hda/patch_cs8409.c        | 20 +++++++++++---------
>  sound/pci/hda/patch_cs8409.h        |  5 +++--
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
> index 759f48038273..621f947e3817 100644
> --- a/sound/pci/hda/patch_cs8409-tables.c
> +++ b/sound/pci/hda/patch_cs8409-tables.c
> @@ -121,7 +121,7 @@ static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
>  	{ CS42L42_MIXER_CHA_VOL, 0x3F },
>  	{ CS42L42_MIXER_CHB_VOL, 0x3F },
>  	{ CS42L42_MIXER_ADC_VOL, 0x3f },
> -	{ CS42L42_HP_CTL, 0x03 },
> +	{ CS42L42_HP_CTL, 0x0D },
>  	{ CS42L42_MIC_DET_CTL1, 0xB6 },
>  	{ CS42L42_TIPSENSE_CTL, 0xC2 },
>  	{ CS42L42_HS_CLAMP_DISABLE, 0x01 },
> @@ -315,7 +315,7 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
>  	{ CS42L42_ASP_TX_SZ_EN, 0x01 },
>  	{ CS42L42_PWR_CTL1, 0x0A },
>  	{ CS42L42_PWR_CTL2, 0x84 },
> -	{ CS42L42_HP_CTL, 0x03 },
> +	{ CS42L42_HP_CTL, 0x0D },
>  	{ CS42L42_MIXER_CHA_VOL, 0x3F },
>  	{ CS42L42_MIXER_CHB_VOL, 0x3F },
>  	{ CS42L42_MIXER_ADC_VOL, 0x3f },
> @@ -371,7 +371,7 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
>  	{ CS42L42_ASP_TX_SZ_EN, 0x00 },
>  	{ CS42L42_PWR_CTL1, 0x0E },
>  	{ CS42L42_PWR_CTL2, 0x84 },
> -	{ CS42L42_HP_CTL, 0x01 },
> +	{ CS42L42_HP_CTL, 0x0D },
>  	{ CS42L42_MIXER_CHA_VOL, 0x3F },
>  	{ CS42L42_MIXER_CHB_VOL, 0x3F },
>  	{ CS42L42_MIXER_ADC_VOL, 0x3f },
> diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
> index 614327218634..b760332a4e35 100644
> --- a/sound/pci/hda/patch_cs8409.c
> +++ b/sound/pci/hda/patch_cs8409.c
> @@ -876,7 +876,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
>  		{ CS42L42_DET_INT_STATUS2, 0x00 },
>  		{ CS42L42_TSRS_PLUG_STATUS, 0x00 },
>  	};
> -	int fsv_old, fsv_new;
> +	unsigned int fsv;
>  
>  	/* Bring CS42L42 out of Reset */
>  	spec->gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
> @@ -893,13 +893,15 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
>  	/* Clear interrupts, by reading interrupt status registers */
>  	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
>  
> -	fsv_old = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
> -	if (cs42l42->full_scale_vol == CS42L42_FULL_SCALE_VOL_0DB)
> -		fsv_new = fsv_old & ~CS42L42_FULL_SCALE_VOL_MASK;
> -	else
> -		fsv_new = fsv_old & CS42L42_FULL_SCALE_VOL_MASK;
> -	if (fsv_new != fsv_old)
> -		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv_new);
> +	fsv = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
> +	if (cs42l42->full_scale_vol) {
> +		// Set the full scale volume bit
> +		fsv |= CS42L42_FULL_SCALE_VOL_MASK;
> +		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
> +	}
> +	// Unmute analog channels A and B
> +	fsv = (fsv & ~CS42L42_ANA_MUTE_AB);
> +	cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
>  
>  	/* we have to explicitly allow unsol event handling even during the
>  	 * resume phase so that the jack event is processed properly
> @@ -920,7 +922,7 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
>  		{ CS42L42_MIXER_CHA_VOL, 0x3F },
>  		{ CS42L42_MIXER_ADC_VOL, 0x3F },
>  		{ CS42L42_MIXER_CHB_VOL, 0x3F },
> -		{ CS42L42_HP_CTL, 0x0F },
> +		{ CS42L42_HP_CTL, 0x0D },
>  		{ CS42L42_ASP_RX_DAI0_EN, 0x00 },
>  		{ CS42L42_ASP_CLK_CFG, 0x00 },
>  		{ CS42L42_PWR_CTL1, 0xFE },
> diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
> index 5e48115caf09..14645d25e70f 100644
> --- a/sound/pci/hda/patch_cs8409.h
> +++ b/sound/pci/hda/patch_cs8409.h
> @@ -230,9 +230,10 @@ enum cs8409_coefficient_index_registers {
>  #define CS42L42_PDN_TIMEOUT_US			(250000)
>  #define CS42L42_PDN_SLEEP_US			(2000)
>  #define CS42L42_INIT_TIMEOUT_MS			(45)
> +#define CS42L42_ANA_MUTE_AB			(0x0C)
>  #define CS42L42_FULL_SCALE_VOL_MASK		(2)
> -#define CS42L42_FULL_SCALE_VOL_0DB		(1)
> -#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(0)
> +#define CS42L42_FULL_SCALE_VOL_0DB		(0)
> +#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(1)
>  
>  /* Dell BULLSEYE / WARLOCK / CYBORG Specific Definitions */
>  
> -- 
> 2.43.0
> 

