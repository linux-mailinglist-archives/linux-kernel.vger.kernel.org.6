Return-Path: <linux-kernel+bounces-319849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85C970308
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E871C21499
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694215FA8F;
	Sat,  7 Sep 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DA/f3B9r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hpvg2r5c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DA/f3B9r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hpvg2r5c"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340315B559;
	Sat,  7 Sep 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725724115; cv=none; b=OjU3p8FBpPSY0og9eGt3xzxMNOucvhJRg3nTwGU+VoIJ0tPTxQFep2FKh4CT/4oiCavLYe7UvAaymq4PNK2h/12NtL1LAiara41KtT2c7UKH1GQVw5FducZmgnxJ+Kym9+Y7Li26LiIEiMa9HRMV87fsABobDtqs75f1kFw7pxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725724115; c=relaxed/simple;
	bh=XAGEFl0itSEt5qLzMTmnCipUw+vhSLkkMfBd54GTxs4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDDzLYO8uv1crzGOeqpY/gRZI8idcX/enikS5ZRfJ701YGQBq2ZEXAjZda81Tp4fDLhweL/j2jGxeeWn/KH7zoRWkmmVz5Qwho4lEDpZLG+IGYgoBpww2vbELO87Kf2TxajzD09lrWcdlunQK9A+8BHidd7wIRgcqpSUC7TaTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DA/f3B9r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hpvg2r5c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DA/f3B9r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hpvg2r5c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A5C321B3D;
	Sat,  7 Sep 2024 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725724104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NhTeVKZenfNEMzWicjmmKPs35XODzC8N+CHfb8EkckY=;
	b=DA/f3B9rcwUCY+8Tadbqz3mT+IYMezZCMAd4kA/pVkRHRXJaQSB6mX0iyCx4tUgzV1yplj
	XmcrL4qo+x2CZTszUjjkR1NTO1dctI7kdTSMfSK6pRorcPaFtHZc13othC5KNcOyKTJVoW
	hN3+6K944Zdlt0CLOflDDUfPfTewjt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725724104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NhTeVKZenfNEMzWicjmmKPs35XODzC8N+CHfb8EkckY=;
	b=hpvg2r5cIaJF/w1Ette+j2F5avefgzKjFAvtbrgOiqVlxRtDoOJIrNKF/r4JtVoQJPsTku
	TvaZtX7EeKbWdMDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725724104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NhTeVKZenfNEMzWicjmmKPs35XODzC8N+CHfb8EkckY=;
	b=DA/f3B9rcwUCY+8Tadbqz3mT+IYMezZCMAd4kA/pVkRHRXJaQSB6mX0iyCx4tUgzV1yplj
	XmcrL4qo+x2CZTszUjjkR1NTO1dctI7kdTSMfSK6pRorcPaFtHZc13othC5KNcOyKTJVoW
	hN3+6K944Zdlt0CLOflDDUfPfTewjt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725724104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NhTeVKZenfNEMzWicjmmKPs35XODzC8N+CHfb8EkckY=;
	b=hpvg2r5cIaJF/w1Ette+j2F5avefgzKjFAvtbrgOiqVlxRtDoOJIrNKF/r4JtVoQJPsTku
	TvaZtX7EeKbWdMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DECD139DE;
	Sat,  7 Sep 2024 15:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HB+fAch13GY6JwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 07 Sep 2024 15:48:24 +0000
Date: Sat, 07 Sep 2024 17:49:11 +0200
Message-ID: <87jzfncvm0.wl-tiwai@suse.de>
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
In-Reply-To: <ZtxZBUjlF8TeIUKC@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
	<871q1ygov9.wl-tiwai@suse.de>
	<ZttEUjeYFzdznYKM@mail.gmail.com>
	<87wmjndbha.wl-tiwai@suse.de>
	<ZtxZBUjlF8TeIUKC@mail.gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,suse.com,linux.intel.com,intel.com,gmail.com,loongson.cn,google.com,lekensteyn.nl,wunner.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Sat, 07 Sep 2024 15:45:41 +0200,
Maxim Mikityanskiy wrote:
> 
> On Sat, 07 Sep 2024 at 12:06:25 +0200, Takashi Iwai wrote:
> > On Fri, 06 Sep 2024 20:05:06 +0200,
> > Maxim Mikityanskiy wrote:
> > > 
> > > On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > > > On Wed, 04 Sep 2024 22:39:55 +0200,
> > > > Maxim Mikityanskiy wrote:
> > > > > 
> > > > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> > > 
> > > Spotted a typo: s/520M/540M/
> > > 
> > > > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > > > up probed, but calls azx_free() and stops the chip. However, from the
> > > > > runtime PM point of view, the device remains active, because the PCI
> > > > > subsystem makes it active on probe, and it's still bound. It prevents
> > > > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > > > power management for the video and audio devices).
> > > > > 
> > > > > Fix it by forcing the device to the suspended state in azx_free().
> > > > > 
> > > > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > > 
> > > > What if this device probe is skipped (e.g. adding your device entry to
> > > > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > > > runtime-suspended state?
> > > 
> > > I added the following:
> > > 
> > > { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> > > 
> > > The probe was apparently skipped (the device is not attached to a
> > > driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> > > DynOff.
> > 
> > OK, that's good.
> > 
> > > However, I'm not sure whether it's a good idea to blacklist 540M
> > > entirely, as there might be other laptops with this GPU that have sound,
> > > and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.
> > 
> > You should specify the PCI SSID of your device instead of 0:0 in the
> > above, so that it's picked up only for yours.
> 
> Where can I get it?
> 
> # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_vendor
> 0x0000
> # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_device
> 0x0000

Ouch, Lenovo didn't set it right.
Alternatively we may introduce a deny list based on DMI.  Hmm...


Takashi


> 
> Is it not the right place?
> 
> > 
> > Takashi
> > 
> > > Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
> > > although I don't know whether it can be done without recompiling the
> > > kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.
> > > 
> > > (Note that I need to set nouveau.modeset=2 either way, otherwise it
> > > stays in DynPwr if the screen is on.)
> > > 
> > > > 
> > > > 
> > > > thanks,
> > > > 
> > > > Takashi
> > > > 
> > > > > ---
> > > > >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > > index b79020adce63..65fcb92e11c7 100644
> > > > > --- a/sound/pci/hda/hda_intel.c
> > > > > +++ b/sound/pci/hda/hda_intel.c
> > > > > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> > > > >  	if (use_vga_switcheroo(hda)) {
> > > > >  		if (chip->disabled && hda->probe_continued)
> > > > >  			snd_hda_unlock_devices(&chip->bus);
> > > > > -		if (hda->vga_switcheroo_registered)
> > > > > +		if (hda->vga_switcheroo_registered) {
> > > > >  			vga_switcheroo_unregister_client(chip->pci);
> > > > > +
> > > > > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > > > > +			 * leaving the device probed but non-functional. As long
> > > > > +			 * as it's probed, the PCI subsystem keeps its runtime
> > > > > +			 * PM status as active. Force it to suspended (as we
> > > > > +			 * actually stop the chip) to allow GPU to suspend via
> > > > > +			 * vga_switcheroo.
> > > > > +			 */
> > > > > +			pm_runtime_disable(&pci->dev);
> > > > > +			pm_runtime_set_suspended(&pci->dev);
> > > > > +			pm_runtime_enable(&pci->dev);
> > > > > +		}
> > > > >  	}
> > > > >  
> > > > >  	if (bus->chip_init) {
> > > > > -- 
> > > > > 2.46.0
> > > > > 

