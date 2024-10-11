Return-Path: <linux-kernel+bounces-360805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EDF999FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066491C22239
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B562420C46B;
	Fri, 11 Oct 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sJIjbXAk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VCLJYrxe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sJIjbXAk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VCLJYrxe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1E20A5F0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638327; cv=none; b=LKjCYVR3Is0/VyNTgJhuinqFkSUBxrd6JYi5QnEygcEOi11UOFK8p2Cku8CBaHGILXaI28/XW4OmnmAjs2bg86QaELhJHFAbHjfwsAgQY9IwtkDf3OhOFOL/FC7sLlWYhT6DDuNt/DJRrNhwr8LXuxsBL0KP+jHxZeg2UasPkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638327; c=relaxed/simple;
	bh=4NTSIwXIbmOxmLhPnN+AhvGzzmlq9GG3PcJTduzs9M8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex9tXSOlb5/XaljMcrfg9/PoRWMWc4wCrLRWuVeZgWrOsYmi2ggm7hmUJS+oQHPRLW4mnsCY7Zp35PhR9a/uuyy/g5IyJOSDjxfvEy0DMBEQjNbU1BFSU3DUcMxmqkdn1BuWuJMycbs2zM8GBGC6Um+wfw1Ug3rZDySj+TqZ+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sJIjbXAk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VCLJYrxe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sJIjbXAk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VCLJYrxe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B3D31FC26;
	Fri, 11 Oct 2024 09:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728638323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWHTgPaGCE5lwyYr2ve/c/4MokteWT6gdE430QbnNeQ=;
	b=sJIjbXAkB67Ko9NMFiPrXh4+0A3fz5d2WsIcGVOU83SVnGOz5sHf9NOgOzhomMw4uMva8H
	dAb6l8AmANZqtxyQeTFnnISeOoOP/mwQyeCRFNzPKMpld+Cc5vAeKhP8/BdEj65kN19l0M
	IQwRc4IEB3kX6b4N0ok2hKxpCi2ZlYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728638323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWHTgPaGCE5lwyYr2ve/c/4MokteWT6gdE430QbnNeQ=;
	b=VCLJYrxeacbzU2aXP68vacg/mO5mTCFrVzxP/R5R0awDQ7yUQrsYCRFGGTgg2lnRMIEQYW
	D6sI3Epfwtx1h+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728638323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWHTgPaGCE5lwyYr2ve/c/4MokteWT6gdE430QbnNeQ=;
	b=sJIjbXAkB67Ko9NMFiPrXh4+0A3fz5d2WsIcGVOU83SVnGOz5sHf9NOgOzhomMw4uMva8H
	dAb6l8AmANZqtxyQeTFnnISeOoOP/mwQyeCRFNzPKMpld+Cc5vAeKhP8/BdEj65kN19l0M
	IQwRc4IEB3kX6b4N0ok2hKxpCi2ZlYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728638323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWHTgPaGCE5lwyYr2ve/c/4MokteWT6gdE430QbnNeQ=;
	b=VCLJYrxeacbzU2aXP68vacg/mO5mTCFrVzxP/R5R0awDQ7yUQrsYCRFGGTgg2lnRMIEQYW
	D6sI3Epfwtx1h+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FC3A1370C;
	Fri, 11 Oct 2024 09:18:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m7ycBnPtCGeQKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 11 Oct 2024 09:18:43 +0000
Date: Fri, 11 Oct 2024 11:19:40 +0200
Message-ID: <87iktzm1xv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <robh+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<kevin-lu@ti.com>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-hampiholi@ti.com>,
	<v-po@ti.com>,
	<niranjan.hy@ti.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<broonie@kernel.org>,
	<soyer@irl.hu>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add speaker id check for ASUS projects
In-Reply-To: <87plo7m2ff.wl-tiwai@suse.de>
References: <20241011085303.738-1-baojun.xu@ti.com>
	<87plo7m2ff.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Fri, 11 Oct 2024 11:09:08 +0200,
Takashi Iwai wrote:
> 
> On Fri, 11 Oct 2024 10:53:03 +0200,
> Baojun Xu wrote:
> > 
> > Add speaker id check by gpio in ACPI for ASUS projects.
> 
> Please give more background info.  e.g. why is the speaker id check
> needed, what does this patch actually fix, and why it's specific to
> ASUS?

Also, for the future submissions, please send to
linux-sound@vger.kernel.org instead of alsa-devel ML.


thanks,

Takashi

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> > ---
> >  include/sound/tas2781.h         |  3 +++
> >  sound/pci/hda/tas2781_hda_i2c.c | 39 ++++++++++++++++++++++++++++++---
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
> > index 8cd6da0480b7..f8a3dc13cbbc 100644
> > --- a/include/sound/tas2781.h
> > +++ b/include/sound/tas2781.h
> > @@ -107,6 +107,8 @@
> >  #define TASDEVICE_CMD_DELAY		0x3
> >  #define TASDEVICE_CMD_FIELD_W		0x4
> >  
> > +#define TAS2781_ASUS_ID			0x10430000
> > +
> >  enum audio_device {
> >  	TAS2563,
> >  	TAS2781,
> > @@ -156,6 +158,7 @@ struct tasdevice_priv {
> >  	struct tasdevice_rca rcabin;
> >  	struct calidata cali_data;
> >  	struct tasdevice_fw *fmw;
> > +	struct gpio_desc *speaker_id;
> >  	struct gpio_desc *reset;
> >  	struct mutex codec_lock;
> >  	struct regmap *regmap;
> > diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
> > index 370d847517f9..1f71927825b2 100644
> > --- a/sound/pci/hda/tas2781_hda_i2c.c
> > +++ b/sound/pci/hda/tas2781_hda_i2c.c
> > @@ -615,7 +615,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
> >  	struct tasdevice_priv *tas_priv = context;
> >  	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
> >  	struct hda_codec *codec = tas_priv->codec;
> > -	int i, ret;
> > +	int i, ret, spk_id;
> >  
> >  	pm_runtime_get_sync(tas_priv->dev);
> >  	mutex_lock(&tas_priv->codec_lock);
> > @@ -648,8 +648,23 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
> >  	tasdevice_dsp_remove(tas_priv);
> >  
> >  	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
> > -	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",
> > -		codec->core.subsystem_id & 0xffff);
> > +	if ((codec->core.subsystem_id & 0xffff0000) == TAS2781_ASUS_ID) {
> > +		// Speaker id need to be checked.
> > +		if (tas_priv->speaker_id)
> > +			spk_id = gpiod_get_value(tas_priv->speaker_id);
> > +		else
> > +			spk_id = 0;
> > +		if (spk_id < 0 || spk_id > 1) {
> > +			// Speaker id is not valid, use default.
> > +			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
> > +			spk_id = 0;
> > +		}
> > +		scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X%01d.bin",
> > +			codec->core.subsystem_id & 0xffff, spk_id);
> > +	} else {
> > +		scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",
> > +			codec->core.subsystem_id & 0xffff);
> > +	}
> >  	ret = tasdevice_dsp_parser(tas_priv);
> >  	if (ret) {
> >  		dev_err(tas_priv->dev, "dspfw load %s error\n",
> > @@ -787,6 +802,15 @@ static void tas2781_hda_remove(struct device *dev)
> >  	tasdevice_remove(tas_hda->priv);
> >  }
> >  
> > +static const struct acpi_gpio_params speakerid_gpios = { 0, 0, false };
> > +static const struct acpi_gpio_params interrupt_gpios = { 1, 0, false };
> > +
> > +static const struct acpi_gpio_mapping tas2781_speaker_id_gpios[] = {
> > +	{ "speakerid-gpios", &speakerid_gpios, 1 },
> > +	{ "interrupt-gpios", &interrupt_gpios, 1 },
> > +	{ }
> > +};
> > +
> >  static int tas2781_hda_i2c_probe(struct i2c_client *clt)
> >  {
> >  	struct tas2781_hda *tas_hda;
> > @@ -823,6 +847,15 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
> >  	if (ret)
> >  		return dev_err_probe(tas_hda->dev, ret,
> >  			"Platform not supported\n");
> > +	ret = devm_acpi_dev_add_driver_gpios(tas_hda->dev,
> > +					     tas2781_speaker_id_gpios);
> > +	if (ret)
> > +		dev_info(tas_hda->dev, "Unable to add GPIO mapping table\n");
> > +
> > +	tas_hda->priv->speaker_id = devm_gpiod_get(tas_hda->dev, "speakerid",
> > +						   GPIOD_IN);
> > +	if (IS_ERR(tas_hda->priv->speaker_id))
> > +		dev_info(tas_hda->dev, "Failed to get Speaker id gpio.\n");
> >  
> >  	ret = tasdevice_init(tas_hda->priv);
> >  	if (ret)
> > -- 
> > 2.43.0
> > 

