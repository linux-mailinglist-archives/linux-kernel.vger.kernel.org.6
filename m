Return-Path: <linux-kernel+bounces-334783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BB497DC16
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02CCB22144
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6260015445D;
	Sat, 21 Sep 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvbBu6PI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495D15098F;
	Sat, 21 Sep 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906243; cv=none; b=i2q4vmGnLULM3Vn423h7pNGsqmfhMnNiFC4yD5bQTqbF5/D4wME/I6sr//cxrUa3YnfVDaYX3RXQzs/a70oLYGYX0Jxyv9aHl0Qyg9qGcuGknDb2Og0jmuDERaLbJD2BJMfBuiOrIMzpZwbMMr3wiHYcHEJ3HywKxHvfEWOP3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906243; c=relaxed/simple;
	bh=hIiykcwMUHrmR8fPg9W7KtQVG1INi5KWpVc/i10zqTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC/5aqi2+96wKH50Rs/6iDdVqXL0Y4Gs3eozV7D5TjUmpWz2WO/t+/bq9nkKevdiiUO7gxUC19yoc6tp7VvKrTVF41L2sO/e2mZasCJnd4hpNrqJHSb9pxEcGs1v/3Hb0XZiPC4pJVjlBzm4W/otI3+d9dhH+jj52Wwa2d+7nS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvbBu6PI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso472406866b.0;
        Sat, 21 Sep 2024 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726906240; x=1727511040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ewVnOv5AHYUNwqENpFQHGDlvppKV6TVLikXGgL6txgQ=;
        b=cvbBu6PIxHI0YGauBDtbDVf9OhGtIG3PU774ix3PDZe5ge3WLmZyJt+WjXnOaJUKD/
         Yw7fEEFuwzuawExwE2ZcVWzpKqL+uZA4nyuuN2cGu8iN3zgJXm8QAIxkDzZPZXOKhiy9
         aSqsnfayTbEeA0JngToYClIkTnEzAoNNxNLVViDy1GeaSBPZ9xFF9MiR0V2jzY/3shSU
         Igg24MZe0js+FBAYcuRMOhZILq5Yg67vwrlJIbTPjRNNKmofKa9EUMT6bAJmiVSyLxrn
         ysqOThP7H2tybXhhsCzHLe0mEUszEvjBLM8JuArEccelfTpPfbbM2rzMS+5cjQ+1CeHf
         qQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726906240; x=1727511040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewVnOv5AHYUNwqENpFQHGDlvppKV6TVLikXGgL6txgQ=;
        b=lWuzPWB0S5BDkIZ9kvEp+44Znvt2U/+Xrcwg9+c8kcSNu5+yvqb5kiy4w0z1n7K83Q
         C02uOhY3DQhzl1/3lBq+ROVdzgN8DvUsr4+6a130xkqk5hIqzWt/7EWhOe17PBK10o7s
         nXgegYbRN+zCKP8wFq0k+nQipkVszjyEbrUHUBBHWzDV5wnRZNLoblSA1tq2lF6RWRYD
         lVlIsqZfpFIU9jwxYMISzZEY+NUgOwUf29l1cxHQh/6jA1E5Tq31Jx3Vy22+WQrxYPH8
         w+xAdVr3gqStUiZj5MshOaWAdUb0HQ/aZCw++n74zFU59s/taUId+LGdVWSRB+9yZX0k
         IAgg==
X-Forwarded-Encrypted: i=1; AJvYcCVH+xOlrKk5bIKD2mju6xNyRZ2XS8rXq+ttmD5QH6JCOuW9r8vuMV9RfP+MOP4iPJTTSyqBg5QsoH41g0c=@vger.kernel.org, AJvYcCXOTv8YTIUEW3s1OBdg99DBu9mWjiOPQc+Ah5CP0ACj5RuT6muBWLigb/VZT6eM7DfN6aM2OLlPdHwnbTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpnbeQR7E1W8XBMvsjwlKolMGL+Z4OHIcnGzmD6jvmePE01gL
	2+u+oqLQyZzFPDbjPPUueafwB6Uk6Hofz5kjqX2Wka9l9HKKlCos
X-Google-Smtp-Source: AGHT+IFcPdvp9vYOkPt75UxWmFpkBRFuJtBTwoTQqXlUrmCI2lxcPqmc0U0fva3KZ3xyMoniYeaVzQ==
X-Received: by 2002:a17:907:268e:b0:a8a:754a:e1c1 with SMTP id a640c23a62f3a-a90c1c73fabmr952458966b.8.1726906239535;
        Sat, 21 Sep 2024 01:10:39 -0700 (PDT)
Received: from localhost ([185.220.101.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061321568sm940425466b.191.2024.09.21.01.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 01:10:38 -0700 (PDT)
Date: Sat, 21 Sep 2024 11:10:37 +0300
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
Message-ID: <Zu5_faxUwoIl09fW@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
 <871q1ygov9.wl-tiwai@suse.de>
 <ZttEUjeYFzdznYKM@mail.gmail.com>
 <87wmjndbha.wl-tiwai@suse.de>
 <ZtxZBUjlF8TeIUKC@mail.gmail.com>
 <87jzfncvm0.wl-tiwai@suse.de>
 <ZtyMWSA0bg1SjFSU@mail.gmail.com>
 <87ed5vcp23.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed5vcp23.wl-tiwai@suse.de>

On Sat, 07 Sep 2024 at 20:10:44 +0200, Takashi Iwai wrote:
> On Sat, 07 Sep 2024 19:24:41 +0200,
> Maxim Mikityanskiy wrote:
> > 
> > On Sat, 07 Sep 2024 at 17:49:11 +0200, Takashi Iwai wrote:
> > > On Sat, 07 Sep 2024 15:45:41 +0200,
> > > Maxim Mikityanskiy wrote:
> > > > 
> > > > On Sat, 07 Sep 2024 at 12:06:25 +0200, Takashi Iwai wrote:
> > > > > On Fri, 06 Sep 2024 20:05:06 +0200,
> > > > > Maxim Mikityanskiy wrote:
> > > > > > 
> > > > > > On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > > > > > > On Wed, 04 Sep 2024 22:39:55 +0200,
> > > > > > > Maxim Mikityanskiy wrote:
> > > > > > > > 
> > > > > > > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> > > > > > 
> > > > > > Spotted a typo: s/520M/540M/
> > > > > > 
> > > > > > > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > > > > > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > > > > > > up probed, but calls azx_free() and stops the chip. However, from the
> > > > > > > > runtime PM point of view, the device remains active, because the PCI
> > > > > > > > subsystem makes it active on probe, and it's still bound. It prevents
> > > > > > > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > > > > > > power management for the video and audio devices).
> > > > > > > > 
> > > > > > > > Fix it by forcing the device to the suspended state in azx_free().
> > > > > > > > 
> > > > > > > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > > > > > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > > > > > 
> > > > > > > What if this device probe is skipped (e.g. adding your device entry to
> > > > > > > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > > > > > > runtime-suspended state?
> > > > > > 
> > > > > > I added the following:
> > > > > > 
> > > > > > { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> > > > > > 
> > > > > > The probe was apparently skipped (the device is not attached to a
> > > > > > driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> > > > > > DynOff.
> > > > > 
> > > > > OK, that's good.
> > > > > 
> > > > > > However, I'm not sure whether it's a good idea to blacklist 540M
> > > > > > entirely, as there might be other laptops with this GPU that have sound,
> > > > > > and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.
> > > > > 
> > > > > You should specify the PCI SSID of your device instead of 0:0 in the
> > > > > above, so that it's picked up only for yours.
> > > > 
> > > > Where can I get it?
> > > > 
> > > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_vendor
> > > > 0x0000
> > > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_device
> > > > 0x0000
> > > 
> > > Ouch, Lenovo didn't set it right.
> > > Alternatively we may introduce a deny list based on DMI.  Hmm...
> > 
> > A DMI-based quirk sounds better than blocking any NVIDIA 540M, it would
> > also allow handling alternative GPUs on this laptop model.
> > 
> > But could you explain what's wrong with a generic approach that I
> > suggest (probe_continue failed => mark as suspended)? It doesn't require
> > any lists. Any drawbacks?
> 
> As you noticed, it will leave the device bound with driver, i.e. this
> looks as if it were operative.  It means that the sound driver is
> still responsible for suspend/resume or whatever action even though
> it's totally useless.  In that sense, it makes more sense to give it
> away at the early stage before actually binding it, and the deny list
> is exactly for that.

Thanks for your feedback!

Do you happen to know whether there is a way for a driver to unbind
itself after probe() returned success? I've never seen anything like
this, but it would be a perfect solution: no lists and no driver bound
after the delayed initialization fails.

> Apart from that, the suggested change itself can be applied
> independently from the deny list update, too.  It'd be good for other
> similar devices, too.

I was trying to avoid lists, because it's a maintainance nightmare (the
lists are never complete, there might be false positives, etc.), and
we'd need to add another type of a list for DMI quirks. Moreover, adding
both my change and a list entry has a drawback that similarly broken
devices will use different workaround code (i.e. less robust), and the
ones that use the generic fallback will never get on the list, because
no one will report it.

As a maintainer, what's your preferred approach?

1. Unbind ourselves on failure in azx_probe_continue() (but I don't know
whether it's possible).

2. Add a DMI deny list to hda_intel.

3. Add a DMI check to quirk_nvidia_hda (i.e. don't enable a non-existent
HDA if it's not enabled by BIOS on this laptop model).

4. Driver becomes a stub no failure in azx_probe_continue() (this
patch).

5. Some combo of 4 and 2/3?

> Though, a slight concern is the sequence of runtime PM you applied in
> the patch.  Is it a standard idiom to perform pm_runtime_disable(),
> set_suspended() and enable()?

I'm not an expert in PM. Before I wrote this code, I was meditating on
the docs for a few hours, and what I understood was:

1. As we are disabling the device (below in the same function), we need
set_suspended() to just update the state.

2. set_suspended() must be called with PM disabled (see the comment
above the function).

3. Disable and enable must come in pairs, because there is refcounting.

I've seen set_suspended() after disable() on device remove (e.g.,
rt9120_remove()). For hda_intel, assuming that disable/enable are
already paired, adding a new disable without a matching enable would
break refcounting. Hence such a sequence.

I'd love to hear an opinion from someone more experienced in PM.

> Also, azx_free() is the common
> destructor, hence it's called also at the regular driver unbinding.
> I'm not entirely sure whether it's OK to call there also at
> unbinding.

I don't have hardware to test this flow, but theoretically it looks OK
to me: we set the suspended state as we disable the device.

> 
> thanks,
> 
> Takashi
> 
> > 
> > > 
> > > 
> > > Takashi
> > > 
> > > 
> > > > 
> > > > Is it not the right place?
> > > > 
> > > > > 
> > > > > Takashi
> > > > > 
> > > > > > Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
> > > > > > although I don't know whether it can be done without recompiling the
> > > > > > kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.
> > > > > > 
> > > > > > (Note that I need to set nouveau.modeset=2 either way, otherwise it
> > > > > > stays in DynPwr if the screen is on.)
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > thanks,
> > > > > > > 
> > > > > > > Takashi
> > > > > > > 
> > > > > > > > ---
> > > > > > > >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> > > > > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > > > > > index b79020adce63..65fcb92e11c7 100644
> > > > > > > > --- a/sound/pci/hda/hda_intel.c
> > > > > > > > +++ b/sound/pci/hda/hda_intel.c
> > > > > > > > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> > > > > > > >  	if (use_vga_switcheroo(hda)) {
> > > > > > > >  		if (chip->disabled && hda->probe_continued)
> > > > > > > >  			snd_hda_unlock_devices(&chip->bus);
> > > > > > > > -		if (hda->vga_switcheroo_registered)
> > > > > > > > +		if (hda->vga_switcheroo_registered) {
> > > > > > > >  			vga_switcheroo_unregister_client(chip->pci);
> > > > > > > > +
> > > > > > > > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > > > > > > > +			 * leaving the device probed but non-functional. As long
> > > > > > > > +			 * as it's probed, the PCI subsystem keeps its runtime
> > > > > > > > +			 * PM status as active. Force it to suspended (as we
> > > > > > > > +			 * actually stop the chip) to allow GPU to suspend via
> > > > > > > > +			 * vga_switcheroo.
> > > > > > > > +			 */
> > > > > > > > +			pm_runtime_disable(&pci->dev);
> > > > > > > > +			pm_runtime_set_suspended(&pci->dev);
> > > > > > > > +			pm_runtime_enable(&pci->dev);
> > > > > > > > +		}
> > > > > > > >  	}
> > > > > > > >  
> > > > > > > >  	if (bus->chip_init) {
> > > > > > > > -- 
> > > > > > > > 2.46.0
> > > > > > > > 

