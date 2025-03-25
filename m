Return-Path: <linux-kernel+bounces-575134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6429A6EDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2E67A4101
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77A7254AE5;
	Tue, 25 Mar 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jMd1jw7N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6kc4EbTB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jMd1jw7N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6kc4EbTB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655F254863
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899340; cv=none; b=V7X49oTTJq9+N4+hSXJrLCuDTx8a9aaVfaXe0anwWfQHF3/pNTz8v2zdzYzjDEYElp6RauoFaNGU2wfe2fs8EYUz9iqnCU2gkrj5ziqrbXugAoVXPHkysHBHlOP5OJl6/1BElJu3UpPzRYEfXLcnk4gW4Bv8jKhMsY3E9VJNpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899340; c=relaxed/simple;
	bh=4M685YFYylBe1+NiGa82PVUKBg9Vt+l/BT1my7zTJ4k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFlq+TMMVAFIgLAwLOs06XAMYgMOHX4NufXkDdzyp5q54euxsgOIt7lHbtCwfRCUjf5aUdD5cMHlNNogqvGgFaj5Envy6HfxpBpkxR3mXU2W8H+C39dkL9oVtpf75NR3WwasnKJOBl4Q14+lLlcpMHtnxRDdA3TLs+AShCzhlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jMd1jw7N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6kc4EbTB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jMd1jw7N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6kc4EbTB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8ADFA21157;
	Tue, 25 Mar 2025 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742899336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arYeXTM3mdXUvVX2yoxaWjgO4joW01BAfqMKfnfpp+U=;
	b=jMd1jw7NfPHFe1EzKfGP17P/xabwDhLGlGU18Ej+orltFNN0do0og67rh7h6vLOp0CY94K
	7OA/OklYcnMCyX84bhSPOmc50byi6vhO0M8X7r60cDLh2r/BEmRjy5unxzKSCcrUuZjIN4
	Q5vUNH1SMOQvVDnxGF6ZzG1H58tbwGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742899336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arYeXTM3mdXUvVX2yoxaWjgO4joW01BAfqMKfnfpp+U=;
	b=6kc4EbTBC2zr0lESUskhbAezs0cS6ySbpDkPUC/4SAyg9RCDZbRm29EYtR/EKjuApbpMT4
	kti7XBRJcdcghlDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742899336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arYeXTM3mdXUvVX2yoxaWjgO4joW01BAfqMKfnfpp+U=;
	b=jMd1jw7NfPHFe1EzKfGP17P/xabwDhLGlGU18Ej+orltFNN0do0og67rh7h6vLOp0CY94K
	7OA/OklYcnMCyX84bhSPOmc50byi6vhO0M8X7r60cDLh2r/BEmRjy5unxzKSCcrUuZjIN4
	Q5vUNH1SMOQvVDnxGF6ZzG1H58tbwGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742899336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arYeXTM3mdXUvVX2yoxaWjgO4joW01BAfqMKfnfpp+U=;
	b=6kc4EbTBC2zr0lESUskhbAezs0cS6ySbpDkPUC/4SAyg9RCDZbRm29EYtR/EKjuApbpMT4
	kti7XBRJcdcghlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C54E137AC;
	Tue, 25 Mar 2025 10:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zu5SEYiI4mfGTQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Mar 2025 10:42:16 +0000
Date: Tue, 25 Mar 2025 11:42:15 +0100
Message-ID: <87r02lcry0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<robinchen@ti.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Support dsp firmware Alpha and Beta seaies
In-Reply-To: <20250325103612.2021-1-shenghao-ding@ti.com>
References: <20250325103612.2021-1-shenghao-ding@ti.com>
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
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 25 Mar 2025 11:36:12 +0100,
Shenghao Ding wrote:
> 
> For calibration data, basic version firmware does not contain any
> calibration addresses, it depends on calibration tool to convey the
> addresses to the driver. Since Alpha and Beta firmware, all the
> calibration addresses are saved into the firmware.

The description is same with the other changes in ASoC and that's
*very* confusing.

Please give the proper description that matches with the actual
change.  Also consider a better subject line, too.

The same problem happened already a few times from your submitted
series in the past.  Please try to improve the process.


thanks,

Takashi

> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> v1:
>  - Add updating calibration addresses code into tas2781_apply_calib in
>    case of Alpha and Beta firmware.
> ---
>  sound/pci/hda/tas2781_hda_i2c.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
> index 50c5e5f26589..cb3d683013d9 100644
> --- a/sound/pci/hda/tas2781_hda_i2c.c
> +++ b/sound/pci/hda/tas2781_hda_i2c.c
> @@ -558,28 +558,38 @@ static int tas2563_save_calibration(struct tasdevice_priv *tas_priv)
>  
>  static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
>  {
> -	static const unsigned char page_array[CALIB_MAX] = {
> -		0x17, 0x18, 0x18, 0x13, 0x18,
> +	struct calidata *cali_data = &tas_priv->cali_data;
> +	struct cali_reg *r = &cali_data->cali_reg_array;
> +	unsigned int cali_reg[CALIB_MAX] = {
> +		TASDEVICE_REG(0, 0x17, 0x74),
> +		TASDEVICE_REG(0, 0x18, 0x0c),
> +		TASDEVICE_REG(0, 0x18, 0x14),
> +		TASDEVICE_REG(0, 0x13, 0x70),
> +		TASDEVICE_REG(0, 0x18, 0x7c),
>  	};
> -	static const unsigned char rgno_array[CALIB_MAX] = {
> -		0x74, 0x0c, 0x14, 0x70, 0x7c,
> -	};
> -	int offset = 0;
>  	int i, j, rc;
> +	int oft = 0;
>  	__be32 data;
>  
> +	if (tas_priv->dspbin_typ != TASDEV_BASIC) {
> +		cali_reg[0] = r->r0_reg;
> +		cali_reg[1] = r->invr0_reg;
> +		cali_reg[2] = r->r0_low_reg;
> +		cali_reg[3] = r->pow_reg;
> +		cali_reg[4] = r->tlimit_reg;
> +	}
> +
>  	for (i = 0; i < tas_priv->ndev; i++) {
>  		for (j = 0; j < CALIB_MAX; j++) {
>  			data = cpu_to_be32(
> -				*(uint32_t *)&tas_priv->cali_data.data[offset]);
> +				*(uint32_t *)&tas_priv->cali_data.data[oft]);
>  			rc = tasdevice_dev_bulk_write(tas_priv, i,
> -				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
> -				(unsigned char *)&data, 4);
> +				cali_reg[j], (unsigned char *)&data, 4);
>  			if (rc < 0)
>  				dev_err(tas_priv->dev,
>  					"chn %d calib %d bulk_wr err = %d\n",
>  					i, j, rc);
> -			offset += 4;
> +			oft += 4;
>  		}
>  	}
>  }
> -- 
> 2.34.1
> 

