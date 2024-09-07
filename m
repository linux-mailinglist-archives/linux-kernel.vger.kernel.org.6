Return-Path: <linux-kernel+bounces-319734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F056C970183
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196B01C218C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB31547E8;
	Sat,  7 Sep 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YQOsxVe3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mSQeLPug";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ThszcR1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kHibkI2e"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC954656;
	Sat,  7 Sep 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725703545; cv=none; b=cSWywBuN7HhsmLwr16IHnBpWzmXlPNMVmz2mPax/IJaw+zigd1d1r5xc189uYABSGEOeohUCRGm5BBxrqoLMBauv8pTGo2OMTLfbmCW4AU5LTtm1MSGZUh2Y3jEZHlnVbliZPsMyD0gdhVgrJSASDmaNfrc4UVTcXhw9LQu1wnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725703545; c=relaxed/simple;
	bh=BOmcOHAF+2Qs3Xv8Rf/zZEHZ5V8eO4zCPwIAyzyalhU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flm76CCISFpGNvwRTYRfdVWJCmuTSDN/TDK/FONX9rBn64xoxZEA7YcC833o4ioKxT3NNs7dm/cT9BFqitkQLzaQwChWrOgnPVna5uGAsT+6alxlDilaMMwtSubpUWR9a6hPxWeqhQA2KwUAjPFCRvKKULO5NOAjVBZwHuG9kYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YQOsxVe3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mSQeLPug; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ThszcR1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kHibkI2e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD77C21229;
	Sat,  7 Sep 2024 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725703540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spN8FZT1364KvIzdbQJ12M/ejhSlRN8HftF1NP0frAY=;
	b=YQOsxVe3PZqeQ9kRKXNGfkEVa49XMXn+MmOMFHgtpzGfh9+QWwTvbYHVG8YH14gjq1Bwie
	BRL+VbpG1qWsrPWkWvTeJ+svOi9W/PwcSaZf7a+lMvVVJrlJM0lMJKkzzl5oOJ1ABvCjJj
	ZwFWX3mqNRg0LdNWXCsGgsnxRLu+whs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725703540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spN8FZT1364KvIzdbQJ12M/ejhSlRN8HftF1NP0frAY=;
	b=mSQeLPugjc/pYAcNTRbD9Yz1p52/sUO+GkmFbpa00j0Dd9EoRLyONgTSBk3SOFOniypczk
	DeATzqLsAoOMhiCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0ThszcR1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kHibkI2e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725703539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spN8FZT1364KvIzdbQJ12M/ejhSlRN8HftF1NP0frAY=;
	b=0ThszcR1BNlpTzWNCVfN1UNahcPLZMvbU4cwFKKkbVnz2OxtzorDE4ioXlXG1gHxyz+XEe
	6VmRcgVGvfFUpCiMY3tcE5XadOeAnxNcaoDyZEXUG06Bugz/cw+10PcQO2jbVt7ZxT/XYO
	3j45PuMJmaeqSWuWfubIE0i3V/PmFCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725703539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spN8FZT1364KvIzdbQJ12M/ejhSlRN8HftF1NP0frAY=;
	b=kHibkI2e0llJmZbVdAcMPWFSBct6MhHcknAqdBZJFN1+TYduSOvoJeHEt+0w++/P9XCU7z
	oROhWNkbGJ4U52Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F6BE139DE;
	Sat,  7 Sep 2024 10:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C2pJEXMl3GbwVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 07 Sep 2024 10:05:39 +0000
Date: Sat, 07 Sep 2024 12:06:25 +0200
Message-ID: <87wmjndbha.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
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
In-Reply-To: <ZttEUjeYFzdznYKM@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
	<871q1ygov9.wl-tiwai@suse.de>
	<ZttEUjeYFzdznYKM@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: CD77C21229
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,suse.com,linux.intel.com,intel.com,gmail.com,loongson.cn,google.com,lekensteyn.nl,wunner.de,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Fri, 06 Sep 2024 20:05:06 +0200,
Maxim Mikityanskiy wrote:
> 
> On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > On Wed, 04 Sep 2024 22:39:55 +0200,
> > Maxim Mikityanskiy wrote:
> > > 
> > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> 
> Spotted a typo: s/520M/540M/
> 
> > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > up probed, but calls azx_free() and stops the chip. However, from the
> > > runtime PM point of view, the device remains active, because the PCI
> > > subsystem makes it active on probe, and it's still bound. It prevents
> > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > power management for the video and audio devices).
> > > 
> > > Fix it by forcing the device to the suspended state in azx_free().
> > > 
> > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > 
> > What if this device probe is skipped (e.g. adding your device entry to
> > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > runtime-suspended state?
> 
> I added the following:
> 
> { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> 
> The probe was apparently skipped (the device is not attached to a
> driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> DynOff.

OK, that's good.

> However, I'm not sure whether it's a good idea to blacklist 540M
> entirely, as there might be other laptops with this GPU that have sound,
> and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.

You should specify the PCI SSID of your device instead of 0:0 in the
above, so that it's picked up only for yours.


Takashi

> Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
> although I don't know whether it can be done without recompiling the
> kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.
> 
> (Note that I need to set nouveau.modeset=2 either way, otherwise it
> stays in DynPwr if the screen is on.)
> 
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > > ---
> > >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > index b79020adce63..65fcb92e11c7 100644
> > > --- a/sound/pci/hda/hda_intel.c
> > > +++ b/sound/pci/hda/hda_intel.c
> > > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> > >  	if (use_vga_switcheroo(hda)) {
> > >  		if (chip->disabled && hda->probe_continued)
> > >  			snd_hda_unlock_devices(&chip->bus);
> > > -		if (hda->vga_switcheroo_registered)
> > > +		if (hda->vga_switcheroo_registered) {
> > >  			vga_switcheroo_unregister_client(chip->pci);
> > > +
> > > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > > +			 * leaving the device probed but non-functional. As long
> > > +			 * as it's probed, the PCI subsystem keeps its runtime
> > > +			 * PM status as active. Force it to suspended (as we
> > > +			 * actually stop the chip) to allow GPU to suspend via
> > > +			 * vga_switcheroo.
> > > +			 */
> > > +			pm_runtime_disable(&pci->dev);
> > > +			pm_runtime_set_suspended(&pci->dev);
> > > +			pm_runtime_enable(&pci->dev);
> > > +		}
> > >  	}
> > >  
> > >  	if (bus->chip_init) {
> > > -- 
> > > 2.46.0
> > > 

