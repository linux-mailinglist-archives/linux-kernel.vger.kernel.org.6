Return-Path: <linux-kernel+bounces-277652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DB94A44A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964481F2331B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0497D1CCB30;
	Wed,  7 Aug 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KEH94C0V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="stZfgEGd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KEH94C0V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="stZfgEGd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518413F435
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023018; cv=none; b=ECU0QQOwrauxPGemAyEGECa/iGqBCd/WU4sPYLBVV13sh8j5Ta6/SXkBfyOI1xGm+JXTt96UUzhlgurfSYq+hI/tHJteds+F9vgDIoLdPqCIHD0JM1EsskLrdqG/392sRwgNZFaC1l995nYT2WrHUrvi7GUpu5iDl23O6xSn+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023018; c=relaxed/simple;
	bh=iBwSElW7/bGjjlIgMt5MwMhqoVEnZ1qEhtTJ2Xsjuw4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtclvOuAdtIp7SHohZlXLI0UShofieJ703MvZ4aMvi98M5gb1KhkmX+jKbHszckxgYIfxvE87A/iUJwhb1j/zCzLimDd999Uv8RqEd0EaSoU8K04lST2lnscAqGj0A0Tx8ocFxNAMp9BfofTsE8tpADeBqpEo5atlMTDVzt+hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KEH94C0V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=stZfgEGd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KEH94C0V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=stZfgEGd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B52BF21B79;
	Wed,  7 Aug 2024 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723023014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhM+tJw0ZvhBM0ppB6xSr68FJ9X0AGS0EoEn7WLfbTQ=;
	b=KEH94C0VSSClbVs+IHMgmtLdflfj40u4QaOwdTKjxwIX8b9Y+H1C41ERZqcmLGEE8D+Tm+
	5IZGyIHnHS0ZbPvQ5ZPsQX2RG44B85VE43Z3a39ZLnHbsx1DQONpCMOJ15JOcup6rzx9WM
	zcGqgVq9khWDLi2iAaUpTmefYtqpI4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723023014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhM+tJw0ZvhBM0ppB6xSr68FJ9X0AGS0EoEn7WLfbTQ=;
	b=stZfgEGdVYSAY/V+mgzPtBobLhQgY2M1f34/sEE17IhnUJfI+iESJeI2EW0XsrOYjLaeJh
	c1S3STgA052vfzAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KEH94C0V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=stZfgEGd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723023014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhM+tJw0ZvhBM0ppB6xSr68FJ9X0AGS0EoEn7WLfbTQ=;
	b=KEH94C0VSSClbVs+IHMgmtLdflfj40u4QaOwdTKjxwIX8b9Y+H1C41ERZqcmLGEE8D+Tm+
	5IZGyIHnHS0ZbPvQ5ZPsQX2RG44B85VE43Z3a39ZLnHbsx1DQONpCMOJ15JOcup6rzx9WM
	zcGqgVq9khWDLi2iAaUpTmefYtqpI4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723023014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhM+tJw0ZvhBM0ppB6xSr68FJ9X0AGS0EoEn7WLfbTQ=;
	b=stZfgEGdVYSAY/V+mgzPtBobLhQgY2M1f34/sEE17IhnUJfI+iESJeI2EW0XsrOYjLaeJh
	c1S3STgA052vfzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5714913A7D;
	Wed,  7 Aug 2024 09:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0QfmE6Y+s2bGDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Aug 2024 09:30:14 +0000
Date: Wed, 07 Aug 2024 11:30:53 +0200
Message-ID: <87r0b07k8i.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13564923607@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<cameron.berkenpas@gmail.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>,
	<robinchen@ti.com>
Subject: Re: [PATCH v1] ALSA: ASoC/tas2781: fix wrong calibrated data order
In-Reply-To: <20240807075541.1458-1-shenghao-ding@ti.com>
References: <20240807075541.1458-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,ti.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: B52BF21B79

On Wed, 07 Aug 2024 09:55:40 +0200,
Shenghao Ding wrote:
> 
> From: Baojun Xu <baojun.xu@ti.com>
> 
> Wrong calibration data order cause sound too low in some device.
> Fix wrong calibrated data order, add calibration data converssion
> by get_unaligned_be32() after reading from UEFI.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---
> v1:
>  - Change copyright date, and add new maintainer.
>  - Add unaligned.h included for get_unaligned_be32().
>  - In tas2781_apply_calib(), change data address transfer directly to
>    get data by get_unaligned_be32(), and send address to device.
> ---
>  sound/pci/hda/tas2781_hda_i2c.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
> index 49bd7097d..4dc3350d5 100644
> --- a/sound/pci/hda/tas2781_hda_i2c.c
> +++ b/sound/pci/hda/tas2781_hda_i2c.c
> @@ -2,10 +2,12 @@
>  //
>  // TAS2781 HDA I2C driver
>  //
> -// Copyright 2023 Texas Instruments, Inc.
> +// Copyright 2023 - 2024 Texas Instruments, Inc.
>  //
>  // Author: Shenghao Ding <shenghao-ding@ti.com>
> +// Current maintainer: Baojun Xu <baojun.xu@ti.com>
>  
> +#include <asm/unaligned.h>
>  #include <linux/acpi.h>
>  #include <linux/crc8.h>
>  #include <linux/crc32.h>
> @@ -519,20 +521,21 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
>  	static const unsigned char rgno_array[CALIB_MAX] = {
>  		0x74, 0x0c, 0x14, 0x70, 0x7c,
>  	};
> -	unsigned char *data;
> -	int i, j, rc;
> +	int i, j, rc, data;
> +	int offset = 0;

data should be __be32 type, to be more explicit.


Takashi

>  
>  	for (i = 0; i < tas_priv->ndev; i++) {
> -		data = tas_priv->cali_data.data +
> -			i * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
>  		for (j = 0; j < CALIB_MAX; j++) {
> +			data = get_unaligned_be32(
> +				&tas_priv->cali_data.data[offset]);
>  			rc = tasdevice_dev_bulk_write(tas_priv, i,
>  				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
> -				&(data[4 * j]), 4);
> +				(unsigned char *)&data, 4);
>  			if (rc < 0)
>  				dev_err(tas_priv->dev,
>  					"chn %d calib %d bulk_wr err = %d\n",
>  					i, j, rc);
> +			offset += 4;
>  		}
>  	}
>  }
> -- 
> 2.40.1
> 

