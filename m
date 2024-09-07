Return-Path: <linux-kernel+bounces-319896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC28970385
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2981F21E98
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E61165EE9;
	Sat,  7 Sep 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QWG94f6H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="db4cGYjr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A7lOq9iN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g3x4V3RX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1CE1494B2;
	Sat,  7 Sep 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732609; cv=none; b=OQ1s/gQsHKXuImb2ReNatTvqRmtAX7RqXkVW+TQtNjIqfxu4dE03vFfw9MTnxeNASFi1ysD4U68ht5Tn48og8uhmrmlMKEbEU3VWwVsUA2ikeFNikVwvjWXGb7XbgqlKtocdXgf+nv/sOOmay44AcrFM0zn+Bg8Pqe4fviTUDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732609; c=relaxed/simple;
	bh=YvuWeks6SbMh6KWqO5oHn5Qm3SNDP+yxlytp8u2fOFk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9PeMQE3cgiEvqiDSOGzwBSsKseJkvhVdU/S7n5eCNQxatRXSm+EznZ3OwguJkd82dm/OgHBgTZqwXjXl2zj0f9qq+xyOplo/kUK6IVWEQoR8nWl8D6a+k4SgYo4PzWhFEYhoUVSY8jWkn6tQwfIsKF9edLM4oOWiGN3exIe5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QWG94f6H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=db4cGYjr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A7lOq9iN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g3x4V3RX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21F461FB98;
	Sat,  7 Sep 2024 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725732599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJGoZdoJAZHLPTxeaeBNYfv6lD5gCmfLt6TZ5A8NRSY=;
	b=QWG94f6H2LN/4eq4Av5W118EZ7Oe+G/yrsKp0YY4xnyDvoktQVMa6Ww2HDmgLM7n8abrXu
	mu7RuJDawxhkm0gNWq72WbCW6P+H3gGW9DygiUqydj4XnmCmigucW0K0QX6zJc66gpQvhV
	f3lpM5xdzcQrZgXnaow6/AbLIxmWAzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725732599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJGoZdoJAZHLPTxeaeBNYfv6lD5gCmfLt6TZ5A8NRSY=;
	b=db4cGYjrFFJjAq090Up5xWDZhN4LkDzPBd1KEBm2zTGqAd+3j631/UpzEwBun7kEPuKMZy
	leP0VNl8VnTzHNCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A7lOq9iN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g3x4V3RX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725732598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJGoZdoJAZHLPTxeaeBNYfv6lD5gCmfLt6TZ5A8NRSY=;
	b=A7lOq9iNDxKjoYoSit+KK5OkRxm1SCs4U7dCYTxJ9BmftJ7qNZj9/tc0mUb6qZ7ca5wTE5
	qOU7d14y+/Pkxbk8Keaj3ra5Gjm28O1nOSTrlFJg5gCRxs+hG42tDqXbOoXVXe0k30+Atm
	OrITufWvFwMQMkyOmo72KBbxtclzMsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725732598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJGoZdoJAZHLPTxeaeBNYfv6lD5gCmfLt6TZ5A8NRSY=;
	b=g3x4V3RXZvHytwVA7ZseZd0wce3Rja7LhDVHORR854DM5YieowO3lR3AG1BeW0rn8xeKOJ
	OGl8IigUFWI6AwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB5A0139DE;
	Sat,  7 Sep 2024 18:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kw48KPWW3Gb3RwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 07 Sep 2024 18:09:57 +0000
Date: Sat, 07 Sep 2024 20:10:44 +0200
Message-ID: <87ed5vcp23.wl-tiwai@suse.de>
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
In-Reply-To: <ZtyMWSA0bg1SjFSU@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
	<871q1ygov9.wl-tiwai@suse.de>
	<ZttEUjeYFzdznYKM@mail.gmail.com>
	<87wmjndbha.wl-tiwai@suse.de>
	<ZtxZBUjlF8TeIUKC@mail.gmail.com>
	<87jzfncvm0.wl-tiwai@suse.de>
	<ZtyMWSA0bg1SjFSU@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 21F461FB98
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,suse.com,linux.intel.com,intel.com,gmail.com,loongson.cn,google.com,lekensteyn.nl,wunner.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 07 Sep 2024 19:24:41 +0200,
Maxim Mikityanskiy wrote:
> 
> On Sat, 07 Sep 2024 at 17:49:11 +0200, Takashi Iwai wrote:
> > On Sat, 07 Sep 2024 15:45:41 +0200,
> > Maxim Mikityanskiy wrote:
> > > 
> > > On Sat, 07 Sep 2024 at 12:06:25 +0200, Takashi Iwai wrote:
> > > > On Fri, 06 Sep 2024 20:05:06 +0200,
> > > > Maxim Mikityanskiy wrote:
> > > > > 
> > > > > On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > > > > > On Wed, 04 Sep 2024 22:39:55 +0200,
> > > > > > Maxim Mikityanskiy wrote:
> > > > > > > 
> > > > > > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> > > > > 
> > > > > Spotted a typo: s/520M/540M/
> > > > > 
> > > > > > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > > > > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > > > > > up probed, but calls azx_free() and stops the chip. However, from the
> > > > > > > runtime PM point of view, the device remains active, because the PCI
> > > > > > > subsystem makes it active on probe, and it's still bound. It prevents
> > > > > > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > > > > > power management for the video and audio devices).
> > > > > > > 
> > > > > > > Fix it by forcing the device to the suspended state in azx_free().
> > > > > > > 
> > > > > > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > > > > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > > > > 
> > > > > > What if this device probe is skipped (e.g. adding your device entry to
> > > > > > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > > > > > runtime-suspended state?
> > > > > 
> > > > > I added the following:
> > > > > 
> > > > > { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> > > > > 
> > > > > The probe was apparently skipped (the device is not attached to a
> > > > > driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> > > > > DynOff.
> > > > 
> > > > OK, that's good.
> > > > 
> > > > > However, I'm not sure whether it's a good idea to blacklist 540M
> > > > > entirely, as there might be other laptops with this GPU that have sound,
> > > > > and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.
> > > > 
> > > > You should specify the PCI SSID of your device instead of 0:0 in the
> > > > above, so that it's picked up only for yours.
> > > 
> > > Where can I get it?
> > > 
> > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_vendor
> > > 0x0000
> > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_device
> > > 0x0000
> > 
> > Ouch, Lenovo didn't set it right.
> > Alternatively we may introduce a deny list based on DMI.  Hmm...
> 
> A DMI-based quirk sounds better than blocking any NVIDIA 540M, it would
> also allow handling alternative GPUs on this laptop model.
> 
> But could you explain what's wrong with a generic approach that I
> suggest (probe_continue failed => mark as suspended)? It doesn't require
> any lists. Any drawbacks?

As you noticed, it will leave the device bound with driver, i.e. this
looks as if it were operative.  It means that the sound driver is
still responsible for suspend/resume or whatever action even though
it's totally useless.  In that sense, it makes more sense to give it
away at the early stage before actually binding it, and the deny list
is exactly for that.

Apart from that, the suggested change itself can be applied
independently from the deny list update, too.  It'd be good for other
similar devices, too.

Though, a slight concern is the sequence of runtime PM you applied in
the patch.  Is it a standard idiom to perform pm_runtime_disable(),
set_suspended() and enable()?  Also, azx_free() is the common
destructor, hence it's called also at the regular driver unbinding.
I'm not entirely sure whether it's OK to call there also at
unbinding.


thanks,

Takashi

> 
> > 
> > 
> > Takashi
> > 
> > 
> > > 
> > > Is it not the right place?
> > > 
> > > > 
> > > > Takashi
> > > > 
> > > > > Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
> > > > > although I don't know whether it can be done without recompiling the
> > > > > kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.
> > > > > 
> > > > > (Note that I need to set nouveau.modeset=2 either way, otherwise it
> > > > > stays in DynPwr if the screen is on.)
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > Takashi
> > > > > > 
> > > > > > > ---
> > > > > > >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> > > > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > > > > index b79020adce63..65fcb92e11c7 100644
> > > > > > > --- a/sound/pci/hda/hda_intel.c
> > > > > > > +++ b/sound/pci/hda/hda_intel.c
> > > > > > > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> > > > > > >  	if (use_vga_switcheroo(hda)) {
> > > > > > >  		if (chip->disabled && hda->probe_continued)
> > > > > > >  			snd_hda_unlock_devices(&chip->bus);
> > > > > > > -		if (hda->vga_switcheroo_registered)
> > > > > > > +		if (hda->vga_switcheroo_registered) {
> > > > > > >  			vga_switcheroo_unregister_client(chip->pci);
> > > > > > > +
> > > > > > > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > > > > > > +			 * leaving the device probed but non-functional. As long
> > > > > > > +			 * as it's probed, the PCI subsystem keeps its runtime
> > > > > > > +			 * PM status as active. Force it to suspended (as we
> > > > > > > +			 * actually stop the chip) to allow GPU to suspend via
> > > > > > > +			 * vga_switcheroo.
> > > > > > > +			 */
> > > > > > > +			pm_runtime_disable(&pci->dev);
> > > > > > > +			pm_runtime_set_suspended(&pci->dev);
> > > > > > > +			pm_runtime_enable(&pci->dev);
> > > > > > > +		}
> > > > > > >  	}
> > > > > > >  
> > > > > > >  	if (bus->chip_init) {
> > > > > > > -- 
> > > > > > > 2.46.0
> > > > > > > 

