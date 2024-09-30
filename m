Return-Path: <linux-kernel+bounces-343483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5B8989B71
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1C11F210BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D415573F;
	Mon, 30 Sep 2024 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzzMUH7A"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F115B0F2;
	Mon, 30 Sep 2024 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681355; cv=none; b=qEBmEpAJ2zJ+tYz6kTbSL1Qw4takXwFvLONavOsem962+dL7ntJ6Wm+t0HxrRK7cP0VfazObKtZtvChGNP0Qn9k89GtREhOsDLWnW7qfroT0UNFwVedg84oaaQZHOTwSSYTgu4/VLSA5FTGxSkF9ucNRjM9flelnUU/fb+j3bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681355; c=relaxed/simple;
	bh=4cDa+u88I0pMWqWCNEMDn5VkzDxbaj2BkSk0iZiE4to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXr9IjwWaYFo0CAXNc+GzGGzvqTVumHWiYj5mwn44YpTGfif6+ccBDvgFg0rCsEGbuFhDg1+fzJL2o6N/VvNSEidjqi//2I8oVe4k0nxEn9bQpCAO7oC4dB9/WNVZ4/QNT4WrexQ9Hh7YhKwURUUeHE3j1kSG+BsCq7r5FLYXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzzMUH7A; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8323b555ae2so195227839f.2;
        Mon, 30 Sep 2024 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727681353; x=1728286153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue4slqDzCbCmGA30w+Pb5YzimVTExtoPtfBb9HsY6Oc=;
        b=QzzMUH7AJGi01UuNqEQEB798JYE/rls9dJcJr7kTb4BphstDK/An6bIqqxotb6rwhX
         KyQH9N/uxJXZ3xOJdSiiVELVA+5yRCp6LbqdKZvafCKahZWNSatLse1ZVVn8XqohGGWa
         K9UOAygy8QbTYtgOvI6rXOePWkiOdeA0lcpaGhYlbGEaY2hr2y7I5BocbIVGOg40A5B/
         y21HGnGrUqsJCJ/KAXGRz+hb0uv+/QcDT2/0L3UvaL6KT537QuAIQnh3hGGofOaKhnTz
         OXYC0W/BtuCJlOkuF0Oij/FHXA1PeuqKc/brv9Cfji+379B07Is//fr+s0SU7wGBGr8H
         +L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727681353; x=1728286153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue4slqDzCbCmGA30w+Pb5YzimVTExtoPtfBb9HsY6Oc=;
        b=vkACEnJXn+Hd7xpH7QK3XY6M6sBQz62asyyYD70ZNM0Z24WLTJnpWVpBCkmR347o0x
         Yj+nIm5Qlbh3CLpxCuI2IQ98/8y1PWVj+C9GYM10mba7L5pW8GXx/oSvYhXGpGTl6Rjf
         1UDZBxNX9lyz8W1pri4Mr/YK5AKhm/3CosKeCwV0VK45JcYCVKIWBjov9402/EqC+Zzv
         E9LSkc4pN6HzxDVzvnskhPN/csmPRWmzzLaHCVJG2v2OjN7jtNedpKx8dTa7RFRHyveM
         w1fZBRegBfR03GgawQ5YJMawWUAYhxCfbflkwOhSkyO0bvUFiHpjQByB2GuZ6+t/Ecvn
         zRZw==
X-Forwarded-Encrypted: i=1; AJvYcCU5BQAx10xTRK7KZ62qj1o4Ghct1OjC1RLZx+hrEdOQlpIKHAxoADEDudZe2AMTXyVyr/YlALsiuauv9BE=@vger.kernel.org, AJvYcCXXyGT9A21N1TRkl+jfuA/vd4Svq5PN4CDMdmBzCAF0PdLC4v4nCtzWDHSi3Noks17Y8SiYnUGGIE/N7pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOvST5enm1MQHnZxCipcpuR/7hf9tBCVlV+Mkm3/g3NhzS59D
	qAEVHGHDqvu0jKLpBS6YhZA8MemE8DkLBCL8W3c9/agV/v7fU+TP
X-Google-Smtp-Source: AGHT+IGacX11scw+O2iK40BP9s20/lwFcvx5mVYDNS4YesXdgGUPbznMoSpeqjGTjAv5kktO6CF/RQ==
X-Received: by 2002:a05:6602:2b13:b0:82a:418d:b03f with SMTP id ca18e2360f4ac-83493205446mr1095731039f.8.1727681352695;
        Mon, 30 Sep 2024 00:29:12 -0700 (PDT)
Received: from localhost ([38.97.116.244])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88884a015sm2005155173.38.2024.09.30.00.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:29:11 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:29:08 +0300
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
Message-ID: <ZvpTRLxSkcqn03Fk@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
 <871q1ygov9.wl-tiwai@suse.de>
 <ZttEUjeYFzdznYKM@mail.gmail.com>
 <87wmjndbha.wl-tiwai@suse.de>
 <ZtxZBUjlF8TeIUKC@mail.gmail.com>
 <87jzfncvm0.wl-tiwai@suse.de>
 <ZtyMWSA0bg1SjFSU@mail.gmail.com>
 <87ed5vcp23.wl-tiwai@suse.de>
 <Zu5_faxUwoIl09fW@mail.gmail.com>
 <87msjpk5el.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msjpk5el.wl-tiwai@suse.de>

On Mon, 30 Sep 2024 at 08:43:46 +0200, Takashi Iwai wrote:
> On Sat, 21 Sep 2024 10:10:37 +0200,
> Maxim Mikityanskiy wrote:
> > 
> > On Sat, 07 Sep 2024 at 20:10:44 +0200, Takashi Iwai wrote:
> > > On Sat, 07 Sep 2024 19:24:41 +0200,
> > > Maxim Mikityanskiy wrote:
> > > > 
> > > > On Sat, 07 Sep 2024 at 17:49:11 +0200, Takashi Iwai wrote:
> > > > > On Sat, 07 Sep 2024 15:45:41 +0200,
> > > > > Maxim Mikityanskiy wrote:
> > > > > > 
> > > > > > On Sat, 07 Sep 2024 at 12:06:25 +0200, Takashi Iwai wrote:
> > > > > > > On Fri, 06 Sep 2024 20:05:06 +0200,
> > > > > > > Maxim Mikityanskiy wrote:
> > > > > > > > 
> > > > > > > > On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> > > > > > > > > On Wed, 04 Sep 2024 22:39:55 +0200,
> > > > > > > > > Maxim Mikityanskiy wrote:
> > > > > > > > > > 
> > > > > > > > > > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on
> > > > > > > > 
> > > > > > > > Spotted a typo: s/520M/540M/
> > > > > > > > 
> > > > > > > > > > the discrete GPU. snd_hda_intel probes the device and schedules
> > > > > > > > > > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > > > > > > > > > up probed, but calls azx_free() and stops the chip. However, from the
> > > > > > > > > > runtime PM point of view, the device remains active, because the PCI
> > > > > > > > > > subsystem makes it active on probe, and it's still bound. It prevents
> > > > > > > > > > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > > > > > > > > > power management for the video and audio devices).
> > > > > > > > > > 
> > > > > > > > > > Fix it by forcing the device to the suspended state in azx_free().
> > > > > > > > > > 
> > > > > > > > > > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > > > > > > > > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > > > > > > > 
> > > > > > > > > What if this device probe is skipped (e.g. adding your device entry to
> > > > > > > > > driver_denylist[] in hda_intel.c)?  Is the device also in the
> > > > > > > > > runtime-suspended state?
> > > > > > > > 
> > > > > > > > I added the following:
> > > > > > > > 
> > > > > > > > { PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },
> > > > > > > > 
> > > > > > > > The probe was apparently skipped (the device is not attached to a
> > > > > > > > driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
> > > > > > > > DynOff.
> > > > > > > 
> > > > > > > OK, that's good.
> > > > > > > 
> > > > > > > > However, I'm not sure whether it's a good idea to blacklist 540M
> > > > > > > > entirely, as there might be other laptops with this GPU that have sound,
> > > > > > > > and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.
> > > > > > > 
> > > > > > > You should specify the PCI SSID of your device instead of 0:0 in the
> > > > > > > above, so that it's picked up only for yours.
> > > > > > 
> > > > > > Where can I get it?
> > > > > > 
> > > > > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_vendor
> > > > > > 0x0000
> > > > > > # cat /sys/bus/pci/devices/0000\:01\:00.1/subsystem_device
> > > > > > 0x0000
> > > > > 
> > > > > Ouch, Lenovo didn't set it right.
> > > > > Alternatively we may introduce a deny list based on DMI.  Hmm...
> > > > 
> > > > A DMI-based quirk sounds better than blocking any NVIDIA 540M, it would
> > > > also allow handling alternative GPUs on this laptop model.
> > > > 
> > > > But could you explain what's wrong with a generic approach that I
> > > > suggest (probe_continue failed => mark as suspended)? It doesn't require
> > > > any lists. Any drawbacks?
> > > 
> > > As you noticed, it will leave the device bound with driver, i.e. this
> > > looks as if it were operative.  It means that the sound driver is
> > > still responsible for suspend/resume or whatever action even though
> > > it's totally useless.  In that sense, it makes more sense to give it
> > > away at the early stage before actually binding it, and the deny list
> > > is exactly for that.
> > 
> > Thanks for your feedback!
> 
> Sorry for the late reply, as I've been off in the last weeks.
> 
> > Do you happen to know whether there is a way for a driver to unbind
> > itself after probe() returned success? I've never seen anything like
> > this, but it would be a perfect solution: no lists and no driver bound
> > after the delayed initialization fails.
> 
> I don't think it's possible for now (at least in a clean way).
> It should be a call of device_driver_detach(), but it's no exported
> API.
> 
> > > Apart from that, the suggested change itself can be applied
> > > independently from the deny list update, too.  It'd be good for other
> > > similar devices, too.
> > 
> > I was trying to avoid lists, because it's a maintainance nightmare (the
> > lists are never complete, there might be false positives, etc.), and
> > we'd need to add another type of a list for DMI quirks. Moreover, adding
> > both my change and a list entry has a drawback that similarly broken
> > devices will use different workaround code (i.e. less robust), and the
> > ones that use the generic fallback will never get on the list, because
> > no one will report it.
> > 
> > As a maintainer, what's your preferred approach?
> > 
> > 1. Unbind ourselves on failure in azx_probe_continue() (but I don't know
> > whether it's possible).
> 
> So it's no easy way.
> 
> > 2. Add a DMI deny list to hda_intel.
> > 
> > 3. Add a DMI check to quirk_nvidia_hda (i.e. don't enable a non-existent
> > HDA if it's not enabled by BIOS on this laptop model).
> 
> I'm afraid that it may break other systems; IIRC, the power up was
> needed explicitly even if it's disabled on BIOS.

I'm not suggesting full removal of quirk_nvidia_hda. If we add a DMI
check to disable quirk_nvidia_hda on this particular laptop model, it
can't break other systems, can it?

Anyways, adding a DMI check to hda_intel or quirk_nvidia_hda seems the
same level of efforts, so I can proceed with the former. It's the same
power consumption either way, right?

I'm also thinking of adding a module parameter to block probing of the
DGPU audio. Back in the days, there were plenty of similar Lenovo
laptops, which might also suffer from the same issue.

> > 4. Driver becomes a stub no failure in azx_probe_continue() (this
> > patch).
> 
> It's OK, but slightly risky.  It's kept bound, hence any unexpected
> thing might happen if the code is changed without noticing it.
> 
> > 5. Some combo of 4 and 2/3?
> 
> Not safe.
> 
> So, from the safety POV, I'd rather take the DMI deny list approach.
> 
> 
> thanks,
> 
> Takashi
> 
> > > Though, a slight concern is the sequence of runtime PM you applied in
> > > the patch.  Is it a standard idiom to perform pm_runtime_disable(),
> > > set_suspended() and enable()?
> > 
> > I'm not an expert in PM. Before I wrote this code, I was meditating on
> > the docs for a few hours, and what I understood was:
> > 
> > 1. As we are disabling the device (below in the same function), we need
> > set_suspended() to just update the state.
> > 
> > 2. set_suspended() must be called with PM disabled (see the comment
> > above the function).
> > 
> > 3. Disable and enable must come in pairs, because there is refcounting.
> > 
> > I've seen set_suspended() after disable() on device remove (e.g.,
> > rt9120_remove()). For hda_intel, assuming that disable/enable are
> > already paired, adding a new disable without a matching enable would
> > break refcounting. Hence such a sequence.
> > 
> > I'd love to hear an opinion from someone more experienced in PM.
> > 
> > > Also, azx_free() is the common
> > > destructor, hence it's called also at the regular driver unbinding.
> > > I'm not entirely sure whether it's OK to call there also at
> > > unbinding.
> > 
> > I don't have hardware to test this flow, but theoretically it looks OK
> > to me: we set the suspended state as we disable the device.
> > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > > 
> > > > > 
> > > > > 
> > > > > Takashi
> > > > > 
> > > > > 
> > > > > > 
> > > > > > Is it not the right place?
> > > > > > 
> > > > > > > 
> > > > > > > Takashi
> > > > > > > 
> > > > > > > > Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
> > > > > > > > although I don't know whether it can be done without recompiling the
> > > > > > > > kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.
> > > > > > > > 
> > > > > > > > (Note that I need to set nouveau.modeset=2 either way, otherwise it
> > > > > > > > stays in DynPwr if the screen is on.)
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > thanks,
> > > > > > > > > 
> > > > > > > > > Takashi
> > > > > > > > > 
> > > > > > > > > > ---
> > > > > > > > > >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> > > > > > > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > > > > > > > > > index b79020adce63..65fcb92e11c7 100644
> > > > > > > > > > --- a/sound/pci/hda/hda_intel.c
> > > > > > > > > > +++ b/sound/pci/hda/hda_intel.c
> > > > > > > > > > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> > > > > > > > > >  	if (use_vga_switcheroo(hda)) {
> > > > > > > > > >  		if (chip->disabled && hda->probe_continued)
> > > > > > > > > >  			snd_hda_unlock_devices(&chip->bus);
> > > > > > > > > > -		if (hda->vga_switcheroo_registered)
> > > > > > > > > > +		if (hda->vga_switcheroo_registered) {
> > > > > > > > > >  			vga_switcheroo_unregister_client(chip->pci);
> > > > > > > > > > +
> > > > > > > > > > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > > > > > > > > > +			 * leaving the device probed but non-functional. As long
> > > > > > > > > > +			 * as it's probed, the PCI subsystem keeps its runtime
> > > > > > > > > > +			 * PM status as active. Force it to suspended (as we
> > > > > > > > > > +			 * actually stop the chip) to allow GPU to suspend via
> > > > > > > > > > +			 * vga_switcheroo.
> > > > > > > > > > +			 */
> > > > > > > > > > +			pm_runtime_disable(&pci->dev);
> > > > > > > > > > +			pm_runtime_set_suspended(&pci->dev);
> > > > > > > > > > +			pm_runtime_enable(&pci->dev);
> > > > > > > > > > +		}
> > > > > > > > > >  	}
> > > > > > > > > >  
> > > > > > > > > >  	if (bus->chip_init) {
> > > > > > > > > > -- 
> > > > > > > > > > 2.46.0
> > > > > > > > > > 

