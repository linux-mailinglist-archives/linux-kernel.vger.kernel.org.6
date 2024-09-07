Return-Path: <linux-kernel+bounces-319879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036F970356
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A791C212B5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE9161B43;
	Sat,  7 Sep 2024 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpC3sDcx"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877428F0;
	Sat,  7 Sep 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725729886; cv=none; b=dgLlj+LuatbCWbveIIiihTEWjTXHD6beabDjZxU6zo+MEawetaCV4DRV2n66p0z/SpLEFDUr76DRkG9fcSXOb6PPE8mKsTkGFN9vc7k5xMzhCzDbQeNdS8LagbxTzXoTc+27Waq778jbKF4jO+ZrJICJOZizOM6U8M5UkxDhneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725729886; c=relaxed/simple;
	bh=G4pKdn7pxpl11J4O3I0o/sD1l9XKau1XRHAgUT/KsRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhv7fHw5ynj2CwAXgyELqQi5/CWi1DL3UOh25Fk0fYLfbdRUVlC8gT4lNagbiTLQFbTXhIGfaNEAa+lRcRGAp5qmb6+5hNO9FElZYhbSTV5BU8FZXMDRGvB25dylDkm84gYFFsHm730bxTEt+/zTInm6D2KHYevOcht8qh2s0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpC3sDcx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75f116d11so3575101fa.1;
        Sat, 07 Sep 2024 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725729883; x=1726334683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtGfaeuE/RsXC8RrQ1vh1Bg0GmABCmpOCZr1tbgwhME=;
        b=MpC3sDcxcu0QZaIx/EpXfkdSPreSdQ2Vhro9E133T+2V165HmRtP/Mj9ZgsguFV+Pw
         crCbNOG84uOVBFqx/wYncBQ8OpjprwaL/S7jhx+6CKa5yTwIIFZV/q52yGEo4LCiPBv5
         hhPA7wRmCahVsSDbEd7QpcqEaxnIxnBedXHlAfyTA028f5JgHNNyt94dUedreGz11iRX
         j/01K+zOUw7CuXWqi3W9vgV3FX8D+98ayPSEPSMidf1TyBDSkqsMuMq/RZSHjyhk6L3J
         SYMAzdQ0Z2s1zb4JN63t68iJEM9FGSFiKjC527nXZjh/3N2YLiiLAIBrTph0db9pStb4
         4gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725729883; x=1726334683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtGfaeuE/RsXC8RrQ1vh1Bg0GmABCmpOCZr1tbgwhME=;
        b=ONbj/MuE7onTulhPpU2ebmcaFZJtdPJguZXTklrDZ6Bek2vNXZdUJNJnjAegD9h77r
         P5ifBoJz+EgXRVdGu4iZKBmog8ekHsS1cMu2NO7nx2ra0kYD7NKVl6lUIa/IPnXED9cU
         HRWhoD98kmCLe/4OIvuZMn1HDJFLWu1Jyw+qD9URF+u3K2KC9E1czXjiJpXyJX2OF8g4
         PiWYx4kX5zCF74wXjzkygPlFuX/mhEmhs7uufygYwp4c4CsCmDWdu2fUoIuBRQsi6jXa
         nIietzaR7w9zpiwNcDe6k7K7NQC2GNLnBquM2xUK9bzyEl5Oq53fbb5IrjK1OVFjjhqH
         2S8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUf4dlLiB+AKPxNA2KohaGcs2wazYKx3oGthO//V4NcUoQpBp7fbGIuCFEMDAhLRGg4QW1qkN+8AmW27c=@vger.kernel.org, AJvYcCXqjesp9ujxQguTLuidVfSiUe5oNYLk+84aRnoX+3CZqFck0li9XwP/UWS0AQXOaoZ+0GlKdxsHXt20b34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyizC9o7+Ygf4Blkdm90rrOI9QkKrywpRzd1wV69qSnpm/bvob8
	2uQQON4kd/pT/8BFXOjWWLHqOp9lHGECicceeLcPDZZOzjbPAOX3
X-Google-Smtp-Source: AGHT+IGD6zho3Y0mz1rIY+zVLPlarPzClcOT1QaLUENyfUBHiZ3/Q8EEoWKTJvHBRfowhyeHFFrGig==
X-Received: by 2002:a05:651c:1546:b0:2f7:5b47:ac1f with SMTP id 38308e7fff4ca-2f75b47aee9mr14115411fa.29.1725729882591;
        Sat, 07 Sep 2024 10:24:42 -0700 (PDT)
Received: from localhost ([45.139.122.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cddesm881046a12.88.2024.09.07.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 10:24:42 -0700 (PDT)
Date: Sat, 7 Sep 2024 20:24:41 +0300
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>, Peter Wu <peter@lekensteyn.nl>,
	Lukas Wunner <lukas@wunner.de>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel: Fix Optimus when GPU has no sound
Message-ID: <ZtyMWSA0bg1SjFSU@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
 <871q1ygov9.wl-tiwai@suse.de>
 <ZttEUjeYFzdznYKM@mail.gmail.com>
 <87wmjndbha.wl-tiwai@suse.de>
 <ZtxZBUjlF8TeIUKC@mail.gmail.com>
 <87jzfncvm0.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzfncvm0.wl-tiwai@suse.de>

On Sat, 07 Sep 2024 at 17:49:11 +0200, Takashi Iwai wrote:
> On Sat, 07 Sep 2024 15:45:41 +0200,
> Maxim Mikityanskiy wrote:
> > 
> > On Sat, 07 Sep 2024 at 12:06:25 +0200, Takashi Iwai wrote:
> > > On Fri, 06 Sep 2024 20:05:06 +0200,
> > > Maxim Mikityanskiy wrote:
> > > > 
> > > > On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > > > > On Wed, 04 Sep 2024 22:39:55 +0200,
> > > > > Maxim Mikityanskiy wrote:
> > > > > > 
> > > > > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> > > > 
> > > > Spotted a typo: s/520M/540M/
> > > > 
> > > > > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > > > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > > > > up probed, but calls azx_free() and stops the chip. However, from the
> > > > > > runtime PM point of view, the device remains active, because the PCI
> > > > > > subsystem makes it active on probe, and it's still bound. It prevents
> > > > > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > > > > power management for the video and audio devices).
> > > > > > 
> > > > > > Fix it by forcing the device to the suspended state in azx_free().
> > > > > > 
> > > > > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > > > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > > > 
> > > > > What if this device probe is skipped (e.g. adding your device entry to
> > > > > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > > > > runtime-suspended state?
> > > > 
> > > > I added the following:
> > > > 
> > > > { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> > > > 
> > > > The probe was apparently skipped (the device is not attached to a
> > > > driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> > > > DynOff.
> > > 
> > > OK, that's good.
> > > 
> > > > However, I'm not sure whether it's a good idea to blacklist 540M
> > > > entirely, as there might be other laptops with this GPU that have sound,
> > > > and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.
> > > 
> > > You should specify the PCI SSID of your device instead of 0:0 in the
> > > above, so that it's picked up only for yours.
> > 
> > Where can I get it?
> > 
> > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_vendor
> > 0x0000
> > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_device
> > 0x0000
> 
> Ouch, Lenovo didn't set it right.
> Alternatively we may introduce a deny list based on DMI.  Hmm...

A DMI-based quirk sounds better than blocking any NVIDIA 540M, it would
also allow handling alternative GPUs on this laptop model.

But could you explain what's wrong with a generic approach that I
suggest (probe_continue failed => mark as suspended)? It doesn't require
any lists. Any drawbacks?

> 
> 
> Takashi
> 
> 
> > 
> > Is it not the right place?
> > 
> > > 
> > > Takashi
> > > 
> > > > Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
> > > > although I don't know whether it can be done without recompiling the
> > > > kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.
> > > > 
> > > > (Note that I need to set nouveau.modeset=2 either way, otherwise it
> > > > stays in DynPwr if the screen is on.)
> > > > 
> > > > > 
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > Takashi
> > > > > 
> > > > > > ---
> > > > > >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> > > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > > > index b79020adce63..65fcb92e11c7 100644
> > > > > > --- a/sound/pci/hda/hda_intel.c
> > > > > > +++ b/sound/pci/hda/hda_intel.c
> > > > > > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> > > > > >  	if (use_vga_switcheroo(hda)) {
> > > > > >  		if (chip->disabled && hda->probe_continued)
> > > > > >  			snd_hda_unlock_devices(&chip->bus);
> > > > > > -		if (hda->vga_switcheroo_registered)
> > > > > > +		if (hda->vga_switcheroo_registered) {
> > > > > >  			vga_switcheroo_unregister_client(chip->pci);
> > > > > > +
> > > > > > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > > > > > +			 * leaving the device probed but non-functional. As long
> > > > > > +			 * as it's probed, the PCI subsystem keeps its runtime
> > > > > > +			 * PM status as active. Force it to suspended (as we
> > > > > > +			 * actually stop the chip) to allow GPU to suspend via
> > > > > > +			 * vga_switcheroo.
> > > > > > +			 */
> > > > > > +			pm_runtime_disable(&pci->dev);
> > > > > > +			pm_runtime_set_suspended(&pci->dev);
> > > > > > +			pm_runtime_enable(&pci->dev);
> > > > > > +		}
> > > > > >  	}
> > > > > >  
> > > > > >  	if (bus->chip_init) {
> > > > > > -- 
> > > > > > 2.46.0
> > > > > > 

