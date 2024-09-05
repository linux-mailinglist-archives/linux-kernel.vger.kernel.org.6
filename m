Return-Path: <linux-kernel+bounces-317265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685696DBB2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F068283536
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DF31DDF5;
	Thu,  5 Sep 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QQ+Irz7o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kGYpoev3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QQ+Irz7o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kGYpoev3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EDDDBE;
	Thu,  5 Sep 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546223; cv=none; b=TEmYuGJd+FrjcBtReWptN2WfPSc4L+Df7MpjIS4tmUbsCaUo1mQDrNqEh//fBgTXjLlP5Y2yIKLvbxxEJCTenQ6qmxTonNla4mP1mjwwoH33XGWTXcv1HadievGcfsO9UoJqN0xCKizaEmaVa6BZuA4xnAwojaSOvaXezQIEiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546223; c=relaxed/simple;
	bh=AeRF6zhavOsIpBs5U7NNvBjB6VdfAx7BxVGTKCujwSg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMYlTSejEH9cZK5kRGVE74j1T/yc/j2MCDBpqgTB6VCCjUq8402jLzkXUGSkRv3GBMexPGhmBxMwlpRQlbu91FRtaoeU5cAv0LOqmta9nvccpXzj1CtLqdyS0+jBmMEm+je4unSEGnz6O2IXJVfjY2G54QQtMGMfONjxwbSLoJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QQ+Irz7o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kGYpoev3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QQ+Irz7o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kGYpoev3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E40021A78;
	Thu,  5 Sep 2024 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725546220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXjOgRJyaK980gQw8Y3NlSFe0GnlwU931hrCdeCHqQU=;
	b=QQ+Irz7oH/Cet56BscubaypucDL86cP8ZEPl7+jmtxDFLsu/xWLPXazbBfrUArOkfBi3p7
	lhXWgy9slAkO8uDxmB7AFEJiaHW48RGAMYszm/gw+i/AcqGBOy9nmjY4NuUh6dupeSkvjZ
	iX52r3FQjLg3suGcLTnYYzxEaofndxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725546220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXjOgRJyaK980gQw8Y3NlSFe0GnlwU931hrCdeCHqQU=;
	b=kGYpoev39ZS/X79rPSDk3YUEt+fOJOEvNF90L5U5yc20XVwZh5mQ6W6fELC9z/sa9SRpMi
	svNL2JlD1FKELDAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725546220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXjOgRJyaK980gQw8Y3NlSFe0GnlwU931hrCdeCHqQU=;
	b=QQ+Irz7oH/Cet56BscubaypucDL86cP8ZEPl7+jmtxDFLsu/xWLPXazbBfrUArOkfBi3p7
	lhXWgy9slAkO8uDxmB7AFEJiaHW48RGAMYszm/gw+i/AcqGBOy9nmjY4NuUh6dupeSkvjZ
	iX52r3FQjLg3suGcLTnYYzxEaofndxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725546220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXjOgRJyaK980gQw8Y3NlSFe0GnlwU931hrCdeCHqQU=;
	b=kGYpoev39ZS/X79rPSDk3YUEt+fOJOEvNF90L5U5yc20XVwZh5mQ6W6fELC9z/sa9SRpMi
	svNL2JlD1FKELDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C01021395F;
	Thu,  5 Sep 2024 14:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g3SgLeu+2WbKGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Sep 2024 14:23:39 +0000
Date: Thu, 05 Sep 2024 16:24:26 +0200
Message-ID: <871q1ygov9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Peter Wu <peter@lekensteyn.nl>,
	Lukas Wunner <lukas@wunner.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel: Fix Optimus when GPU has no sound
In-Reply-To: <20240904203955.245085-1-maxtram95@gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,linux.intel.com,intel.com,gmail.com,loongson.cn,google.com,lekensteyn.nl,wunner.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 04 Sep 2024 22:39:55 +0200,
Maxim Mikityanskiy wrote:
> 
> Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> the discrete GPU. snd_hda_intel probes the device and schedules
> azx_probe_continue(), which fails at azx_first_init(). The driver ends
> up probed, but calls azx_free() and stops the chip. However, from the
> runtime PM point of view, the device remains active, because the PCI
> subsystem makes it active on probe, and it's still bound. It prevents
> vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> power management for the video and audio devices).
> 
> Fix it by forcing the device to the suspended state in azx_free().
> 
> Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>

What if this device probe is skipped (e.g. adding your device entry to
driver_denylist[] in hda_intel.c)?  Is the device also in the
runtime-suspended state?


thanks,

Takashi

> ---
>  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index b79020adce63..65fcb92e11c7 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
>  	if (use_vga_switcheroo(hda)) {
>  		if (chip->disabled && hda->probe_continued)
>  			snd_hda_unlock_devices(&chip->bus);
> -		if (hda->vga_switcheroo_registered)
> +		if (hda->vga_switcheroo_registered) {
>  			vga_switcheroo_unregister_client(chip->pci);
> +
> +			/* Some GPUs don't have sound, and azx_first_init fails,
> +			 * leaving the device probed but non-functional. As long
> +			 * as it's probed, the PCI subsystem keeps its runtime
> +			 * PM status as active. Force it to suspended (as we
> +			 * actually stop the chip) to allow GPU to suspend via
> +			 * vga_switcheroo.
> +			 */
> +			pm_runtime_disable(&pci->dev);
> +			pm_runtime_set_suspended(&pci->dev);
> +			pm_runtime_enable(&pci->dev);
> +		}
>  	}
>  
>  	if (bus->chip_init) {
> -- 
> 2.46.0
> 

