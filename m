Return-Path: <linux-kernel+bounces-319303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 633AE96FA4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E69B24DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4251D6DC5;
	Fri,  6 Sep 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7+BF0tz"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184991D2F5D;
	Fri,  6 Sep 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645912; cv=none; b=XhOxOdRY7XOrysjVQj6dxUdurDp6xtnTSZAH9tInu650/fPRuk/P1eRNB4wuLhOR+5HrV2hNNK1ZQVO0BoSDpR6cyLPVtBB6U2OijSde3TfyYpJU/r06DIJ9v72Bx0e5bA1jpLvVY1YUVN70jYTZPsbdYaRVkTMAens7tWiMgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645912; c=relaxed/simple;
	bh=wwfyt3zGFRSXRRnajlO2sI4EsCbR13SVbF95W13Iifk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpyAo5JI3qA/2FBQp0o5ykOSvyaQs/e4V9GfiApunt1M8WF8b5khcsLuJg6u60TJ3fX1YGTmitGbbJlrn+8c1phbdoS17Z7mVefjWBHNEzy7mxbHX1H4N+K4grBTkF3lvN4mLa2wYcF/jXfXY5XbZHnyJ2yE4iREQPyw/+ipkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7+BF0tz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso2382151a12.3;
        Fri, 06 Sep 2024 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725645909; x=1726250709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaSkMuqPp2OQuoE1ZrPqxc9sSDOiBqS1W3KAzwLePm8=;
        b=Q7+BF0tzFXR39xycDRhxNWuN3izKpL4tjL4LDSy3kPIdnrizzCKu2W3uQqLF0gvNOP
         bQWwAhQYGPUAZTxGDKi9wPZqv6unTlCMXxOxrMslr2TdXQBnlAU/d0tDB5xe8uYxKPwS
         tKy4cUiRY4+zb74ucZbT2KO+hWu2a8Vb8lpchKScqcXLoxRJAu8iaDeAzU42ZqpkDX86
         CspaFrHYPTw64vF3bTbTyUbMp0BG2Z2CX0N50ilnjlV3Y83E1vLwN41HhEc3vYwR1hQ+
         XwMIXerlGiEwkH9izhHp67FVxqcth8NxvaqcmbfcCQxXszxPfreJBMZeD6RoGLuafQiE
         4heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725645909; x=1726250709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaSkMuqPp2OQuoE1ZrPqxc9sSDOiBqS1W3KAzwLePm8=;
        b=fbHLGnpYZqs9HzrB/31ADfyUUuz/TTrFRxoBp7kRHrwVuERkXfHpFjLguHpUGiGBnR
         OARVdVUgin/xDlk+CqaZ9TAUxwInSJNqtnhY/2TudecWx7tqLkC4Q7TSXvxXx5zGVj+J
         wQrPQDhnYjCQzFm1FQSP/zCe2Cj/7zBiFICW/P3+DvxUBE6/jZmt+QpFrcYnnyf+L8gF
         SDf/YMQbuIzQ8GZVddlWaWmZamnn3okglk/P6DrOeV+rKI3J9mT/aI3GjAL8ApVf1191
         /4KHwgrt5sf/EoSqsL7riUtMYtJV5s9WALrVa6Pn2tWFMW1xaX1rkIiA4dwBcs4DdoOy
         V2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUgOGiVOj7zlPGu8MI3s8ISAHC6theDeUtwbWHZ1+lureSb8vB3KcICMCM8tJEHnnE4FcBesiBLvUwTxtI=@vger.kernel.org, AJvYcCXtw0xoPKBbf2WEtxg6J8JCYkLm362bgSH69yG9Jan09YYt5I2/iXLvxRWJNfwD9fmuFjBsI6zsGAg6wu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcea/oucw1Ak1W42Vjck6tc9qrJxipHH7f3NQNXjvDLNNL3JK4
	zlS2+VY/cCnmg16xLg1PrBNJMR2tGINQe5QWhPlsO6qdvLxs4v3t
X-Google-Smtp-Source: AGHT+IH9UmoWbsEL27zsa1ADWQymOOnbDM1n5xa+o9B4MQz8KL5DAW6ctdyXD5xTca/dGxrEKznZXw==
X-Received: by 2002:a17:907:7f06:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a8a885fa912mr263593866b.24.1725645908902;
        Fri, 06 Sep 2024 11:05:08 -0700 (PDT)
Received: from localhost ([185.220.101.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038d7asm305059466b.66.2024.09.06.11.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:05:08 -0700 (PDT)
Date: Fri, 6 Sep 2024 21:05:06 +0300
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
Message-ID: <ZttEUjeYFzdznYKM@mail.gmail.com>
References: <20240904203955.245085-1-maxtram95@gmail.com>
 <871q1ygov9.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q1ygov9.wl-tiwai@suse.de>

On Thu, 05 Sep 2024 at 16:24:26 +0200, Takashi Iwai wrote:
> On Wed, 04 Sep 2024 22:39:55 +0200,
> Maxim Mikityanskiy wrote:
> > 
> > Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 520M doesn't have sound on

Spotted a typo: s/520M/540M/

> > the discrete GPU. snd_hda_intel probes the device and schedules
> > azx_probe_continue(), which fails at azx_first_init(). The driver ends
> > up probed, but calls azx_free() and stops the chip. However, from the
> > runtime PM point of view, the device remains active, because the PCI
> > subsystem makes it active on probe, and it's still bound. It prevents
> > vga_switcheroo from turning off the DGPU (pci_create_device_link() syncs
> > power management for the video and audio devices).
> > 
> > Fix it by forcing the device to the suspended state in azx_free().
> > 
> > Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
> > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> 
> What if this device probe is skipped (e.g. adding your device entry to
> driver_denylist[] in hda_intel.c)?  Is the device also in the
> runtime-suspended state?

I added the following:

{ PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) },

The probe was apparently skipped (the device is not attached to a
driver), runtime_status=suspended, runtime_usage=0, the GPU goes to
DynOff.

However, I'm not sure whether it's a good idea to blacklist 540M
entirely, as there might be other laptops with this GPU that have sound,
and AFAIK there are variants of Lenovo Z570 with other NVIDIA GPUs.

Another way to make vga_switcheroo work is to disable quirk_nvidia_hda,
although I don't know whether it can be done without recompiling the
kernel. In this case, 0000:01:00.1 doesn't even appear on the bus.

(Note that I need to set nouveau.modeset=2 either way, otherwise it
stays in DynPwr if the screen is on.)

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/hda_intel.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index b79020adce63..65fcb92e11c7 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1361,8 +1361,20 @@ static void azx_free(struct azx *chip)
> >  	if (use_vga_switcheroo(hda)) {
> >  		if (chip->disabled && hda->probe_continued)
> >  			snd_hda_unlock_devices(&chip->bus);
> > -		if (hda->vga_switcheroo_registered)
> > +		if (hda->vga_switcheroo_registered) {
> >  			vga_switcheroo_unregister_client(chip->pci);
> > +
> > +			/* Some GPUs don't have sound, and azx_first_init fails,
> > +			 * leaving the device probed but non-functional. As long
> > +			 * as it's probed, the PCI subsystem keeps its runtime
> > +			 * PM status as active. Force it to suspended (as we
> > +			 * actually stop the chip) to allow GPU to suspend via
> > +			 * vga_switcheroo.
> > +			 */
> > +			pm_runtime_disable(&pci->dev);
> > +			pm_runtime_set_suspended(&pci->dev);
> > +			pm_runtime_enable(&pci->dev);
> > +		}
> >  	}
> >  
> >  	if (bus->chip_init) {
> > -- 
> > 2.46.0
> > 

