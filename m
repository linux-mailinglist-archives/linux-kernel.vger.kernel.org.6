Return-Path: <linux-kernel+bounces-319808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9D797027C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FA828420F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749115C14C;
	Sat,  7 Sep 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfpb1lxZ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F614C5A7;
	Sat,  7 Sep 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716747; cv=none; b=Wg/dvDvSPe9JlAd4ij3bnOZMw8Q8M3BLIw6saLa++QNLCsQk3v0MFUCYY+yIv2tqrfR9iurEmYG4Iqdh/g6i9KXx/4rvCFp5iVmNfuFiiW1/O2nGESzhgKIUNPyLDScbsvglfJLrCA/eRWlcLt9F+Mvo3CpUs7vo30tKcyiJoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716747; c=relaxed/simple;
	bh=Bs2n4cacEbnXtn2sQA8ItigCb6VPZc5QtlT9Gy+AfNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJQwI27kUKZjYooUFRb1kBf14Pm2f4cwUCkIbKExCvqFVWqerH+u8gf/UQgMsOAWs85FnJR0WMpQnUjXiC4x6vsJt6v2YMTy9BpoEpIEl4j4qyx6yKl366u8BjEuxo1rKcc4nN1ynhlBzQMfhwvXoGqCZUeRD6iib/Q/ubdE/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfpb1lxZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so310837166b.3;
        Sat, 07 Sep 2024 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725716744; x=1726321544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qamyypXDvEru6GslpFCZ82pmRTAeT54q4yjZx4Pbqk0=;
        b=Zfpb1lxZNZnGvte0AKRiwwC0mOLD/i8rn4ggFx29EwLNol7caocCxEwoBJIEFJpRpi
         jKAtQlphgfwBF+NQkN50A9hNAD783+d9mIbBVRBAYIAVRoBSeLbIEUiXemLDXoA9jml5
         R0YdhUmlFdRpOhky7BThVAxeBHns5drpQJ70fFvOIPP2PN/MZP/X+1Pz2KQBkJDBBQQy
         bzVkKnNQAEufxkYEe17+Hh6wXVYt9f3XHLAxoN5plSSTdeZo3Ep36OEcrcqTfmFGsccO
         l1qywMdQSaTD1RRK2gfIhAJgivYa4O0Xb3oq3Tbwm8w2/Xe4mxw584YTilc/LZGrJ9aL
         OJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725716744; x=1726321544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qamyypXDvEru6GslpFCZ82pmRTAeT54q4yjZx4Pbqk0=;
        b=AplQRg9zqo7U4n/UVdDy6izDR93/umhnJtgEmdrFriMmoqfBciwF3n7toH8FYRxd2m
         3D0JkpbPgA6qDdkB5yfHPLyaMzBP0G3HTeqTrCmMpZCJgxdfne5dcWSohtaYQgnkBwHO
         cDxgGfgz75HRHHdIJc/Bp+e3gbhNXiAWeYTeB1wmIDgvFdqpwZI1ag7I8XKGv9dQPHdB
         nH4de51dBtFDnu99uCGM+TRNIS2BeiTvw7wy1vl/R6qZHLhpHsmnT5PmpFqOPEJCjfAh
         GAmLsaiAPa6NBAMEf/gSQN7ZgizxXSYdWpGJBjxlsJlkczELnIwa1bqyGFx+GwQZQkk2
         RNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCMjrYbiCcMXD12wd4Sm3AQraYsDp7/a0yPmQnm8TA98u6qUz8hPveYp3kMFGa0YwyRUNSInj/dqpgEaU=@vger.kernel.org, AJvYcCWCZnWfBOFQ9Fjg7lk+zr/tgFE2wtSQ9l3Ts5gM1xr9pyVG2LfAr5TjwFKUX0qWYL251gTxcFt99cUrw4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKiJ5jPjgBiJKEqgElMcrOaqpCp8IZdsHIzkPKpjsBtkP1chy
	6NoyC9FX5TlqVbC8l8m1f7916VXM+2kuqEISJ/XbZvR4ZpHt32WE
X-Google-Smtp-Source: AGHT+IHKqGgUUaqNiJSQpf0jmoZxO/skTBmkl21vQfXBsk0PJvCPqZwJ8i9pI1sFapK20PMq4xB30Q==
X-Received: by 2002:a17:906:c156:b0:a7a:a89e:e230 with SMTP id a640c23a62f3a-a8a88667698mr405094866b.30.1725716743307;
        Sat, 07 Sep 2024 06:45:43 -0700 (PDT)
Received: from localhost (tor-exit-46.for-privacy.net. [185.220.101.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2592647esm73436466b.48.2024.09.07.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 06:45:42 -0700 (PDT)
Date: Sat, 7 Sep 2024 16:45:41 +0300
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
Message-ID: <ZtxZBUjlF8TeIUKC@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
 <871q1ygov9.wl-tiwai@suse.de>
 <ZttEUjeYFzdznYKM@mail.gmail.com>
 <87wmjndbha.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmjndbha.wl-tiwai@suse.de>

On Sat, 07 Sep 2024 at 12:06:25 +0200, Takashi Iwai wrote:
> On Fri, 06 Sep 2024 20:05:06 +0200,
> Maxim Mikityanskiy wrote:
> > 
> > On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > > On Wed, 04 Sep 2024 22:39:55 +0200,
> > > Maxim Mikityanskiy wrote:
> > > > 
> > > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> > 
> > Spotted a typo: s/520M/540M/
> > 
> > > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > > up probed, but calls azx_free() and stops the chip. However, from the
> > > > runtime PM point of view, the device remains active, because the PCI
> > > > subsystem makes it active on probe, and it's still bound. It prevents
> > > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > > power management for the video and audio devices).
> > > > 
> > > > Fix it by forcing the device to the suspended state in azx_free().
> > > > 
> > > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > 
> > > What if this device probe is skipped (e.g. adding your device entry to
> > > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > > runtime-suspended state?
> > 
> > I added the following:
> > 
> > { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> > 
> > The probe was apparently skipped (the device is not attached to a
> > driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> > DynOff.
> 
> OK, that's good.
> 
> > However, I'm not sure whether it's a good idea to blacklist 540M
> > entirely, as there might be other laptops with this GPU that have sound,
> > and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.
> 
> You should specify the PCI SSID of your device instead of 0:0 in the
> above, so that it's picked up only for yours.

Where can I get it?

# cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_vendor
0x0000
# cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_device
0x0000

Is it not the right place?

> 
> Takashi
> 
> > Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
> > although I don't know whether it can be done without recompiling the
> > kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.
> > 
> > (Note that I need to set nouveau.modeset=2 either way, otherwise it
> > stays in DynPwr if the screen is on.)
> > 
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > > ---
> > > >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > index b79020adce63..65fcb92e11c7 100644
> > > > --- a/sound/pci/hda/hda_intel.c
> > > > +++ b/sound/pci/hda/hda_intel.c
> > > > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> > > >  	if (use_vga_switcheroo(hda)) {
> > > >  		if (chip->disabled && hda->probe_continued)
> > > >  			snd_hda_unlock_devices(&chip->bus);
> > > > -		if (hda->vga_switcheroo_registered)
> > > > +		if (hda->vga_switcheroo_registered) {
> > > >  			vga_switcheroo_unregister_client(chip->pci);
> > > > +
> > > > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > > > +			 * leaving the device probed but non-functional. As long
> > > > +			 * as it's probed, the PCI subsystem keeps its runtime
> > > > +			 * PM status as active. Force it to suspended (as we
> > > > +			 * actually stop the chip) to allow GPU to suspend via
> > > > +			 * vga_switcheroo.
> > > > +			 */
> > > > +			pm_runtime_disable(&pci->dev);
> > > > +			pm_runtime_set_suspended(&pci->dev);
> > > > +			pm_runtime_enable(&pci->dev);
> > > > +		}
> > > >  	}
> > > >  
> > > >  	if (bus->chip_init) {
> > > > -- 
> > > > 2.46.0
> > > > 

