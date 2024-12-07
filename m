Return-Path: <linux-kernel+bounces-435872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46729E7E20
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4157A1887585
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4492D047;
	Sat,  7 Dec 2024 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRliZ/+q"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF6139B;
	Sat,  7 Dec 2024 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733543276; cv=none; b=JRqRx0q//7TZlJHU2fwYw3MGXLxYxvQOVNDx6XvhDh5102M5iMoGgSKy50vCOVJj5ED/AozxGbESq2i31K28/gO8h4vX0HK9X29t9t7dpaBWPYYMkudImwfaUlMVNgK2ab1na46hQGWo+/DwDQI03i9UQewg0twMlo8ZWyijV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733543276; c=relaxed/simple;
	bh=bL4UHHgwHtOXxZInwYp270JO0RzzcHFY1NBzrA7Xf0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb6jcBzWMiYCtFa7ccTWhBqLk1++dZ70UJY2pDLbdQYUrZQSzRGCFTP9ffqOUt3jKFn1HMaOYlrygpJOrwdHZOyb5BetMK1v43M+bmmk51PEMds284qfpNgzILObBYGZWPDzVedY3R8FU9+GNf2Jf/7Z+v3pLraAP29lVZeU/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRliZ/+q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7259d6ae0c8so2580113b3a.0;
        Fri, 06 Dec 2024 19:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733543274; x=1734148074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEX9heLh15P12gpBauA89Y/zxaF7Atg5q8U8hP8Bozs=;
        b=DRliZ/+qnWdyO74wNrzSiPENDw99FC6T894w9fjrNM9pMUH4OgU/Oxg3yOYHnpGqCj
         UqTWDntw/cRgeug7rm9Y+HEjv+Iw49UAYQX79trjL4R1+4hOuyi08gpuBFped+VVQG84
         3hryi/kCHO9YgR3gH6r6EgIy/cd6+6P2hgkIawSI2r2i9Drz/m6xYbQqLqm3+yHaGbay
         0V9BXI0XG9ZRQ4Whw2O0ivJ10twCsIGq/PfNA4USUWA8sgNTuKRvO3kC+DMBdZ0fyLss
         6yh2XUX4LxlwMblK8zkBvTwdBIcy3E75M8+pEM1HfiwhLRNkRfF9zYNsTcWw6QgRsM4q
         d1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733543274; x=1734148074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEX9heLh15P12gpBauA89Y/zxaF7Atg5q8U8hP8Bozs=;
        b=putF0rZi9BXXTH7ohJuNwLA2+3zoF4Erh9FFuK/RJ0zttQpX0PItAyPTya1lVIMDBl
         ZbbmLAHLueg8Etmh6piz9Q7TzvDDmaojgYpIbJgnCxm8IqRMTIu6fFRB5J6+bmT1deg9
         L+7yB913U2zpD1IlRKaERbipJjpMRT7mX9ENgpoholnNF6GYRpsm+PettQzlfFV3w1xG
         sl3CG7CqAAPAVqg/j4+l6l1mRb2AHM3YYOZuuAdCyGTO+YT9PxoUO8cdZG2jayHBZq8/
         lM+Ozt3c186gBaiA8RITW9/PLdSalpsl3GCMx0cVGdq8ARDo7rKpbHmZhBOiureumvsu
         q/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUP57S5jl8C3ReA73JGDPWyWZcCT+gdkwQFuM7tfIzqP00yNKzU+X0N+4IQtqpCP0MgD1wnyJFOsP9R16I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/tIUCjfafadCou71kZxl02d6uJQFt2byj1liJ4zKkcFoyTlD
	OuCWKJU5tEMkNV8K+q6sZ6fpYI+8m3oHvGJyWSgAURQ4lFiH7vrT
X-Gm-Gg: ASbGncvP57FxDZg/dyJwwDZdsOnDIRdtj9KG41LMYoOGOxgKWw1UI/ma+2jX0RoOyYG
	bUPAx2kXiAEhfpCjRQt+gg7tcEd1mO9tQlPtNz5fxHlylO7ct00IWuH7yCzMOWJ1kpFvk70V/Jx
	lg8W8P9tVwXBl0ojiBSK36fG6fETBrNr3sTnGuMqUz3+SJjV4zrR8ievyP8JK1O/3dEmDyVmxDS
	r/dGej/iwb0UVOBFo27frzqbHATpUD2imVa1ysz4qNCJK/GDS8YEERPGrogEGgE8wPlpo/b7pqF
	JyaoEdNX
X-Google-Smtp-Source: AGHT+IGQR+lrqcQm7UvNNoLMlegWqd/KfCB16h9OQ2AQHYSXjwNrvhrjQcDdb36aIBuBE+fUe8VLVA==
X-Received: by 2002:a05:6a00:9292:b0:725:9ec3:7ed9 with SMTP id d2e1a72fcca58-725b81a783emr7937108b3a.21.1733543273582;
        Fri, 06 Dec 2024 19:47:53 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5aeesm3672238b3a.10.2024.12.06.19.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 19:47:53 -0800 (PST)
Date: Sat, 7 Dec 2024 00:47:50 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com
Subject: Re: [RFC PATCH 00/21] alienware-wmi driver rework
Message-ID: <hw6bhq4jhb5unzhpojoifufotqsbwik5p2mkwg4rvpqsrianxw@oebpysg3yswp>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <eec050e3-1b60-4430-b0ff-91e4e250d8f3@gmx.de>
 <w3sxt2kt64g2b6gjucnsmnydfm4r74pzf2sl6fcjmjwvk3jyd5@2miohw3pslwk>
 <38399b6a-e31c-4b99-a10e-01dc20649c24@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38399b6a-e31c-4b99-a10e-01dc20649c24@gmx.de>

On Sat, Dec 07, 2024 at 04:20:09AM +0100, Armin Wolf wrote:
> Am 07.12.24 um 02:59 schrieb Kurt Borja:
> 
> > On Sat, Dec 07, 2024 at 12:26:20AM +0100, Armin Wolf wrote:
> > > Am 05.12.24 um 01:27 schrieb Kurt Borja:
> > > 
> > > > Hi :)
> > > > 
> > > > This series are a follow-up to this discussion [1], in which I proposed
> > > > migrating the alienware-wmi driver to use:
> > > > 
> > > > 1. State container driver model
> > > > 2. Modern WMI driver design
> > > > 3. Drop use of deprecated WMI methods
> > > > 
> > > > Of course, this was much harder than expected to do cleanly. Main
> > > > problem was that this driver "drives" two completely different devices
> > > > (I'm not referring to the WMI devices, which also happen to be two).
> > > > 
> > > > Throughout these series we will call these devices AlienFX and AWCC.
> > > > 
> > > > As a preamble
> > > > =============
> > > > 
> > > > AlienFX exposes a LED, hdmi, amplifier and deepsleep interface to
> > > > userspace through a platform device named "alienware-wmi". Historically
> > > > this driver handled this by leveraging on two WMI devices as a backend.
> > > > This devices named LEGACY and WMAX were very similar, the only
> > > > difference was that WMAX had more features, but share all features
> > > > LEGACY had. Although it's a stretch, it could be argued this WMI devices
> > > > are the "same", just different GUID.
> > > > 
> > > > Later Dell repurposed the WMAX WMI device to serve as a thermal control
> > > > interface for all newer "gaming" laptops. This new WMAX device has an
> > > > ACPI UID = "AWCC" (I discovered this recently). So it could also be
> > > > argued that old WMAX and AWCC WMAX are not the same device, just same
> > > > GUID.
> > > > 
> > > > This drivers manages all these features using deprecated WMI methods.
> > > I think there is a misunderstanding here.
> > > 
> > > The WMAX WMI device is identical with the AWCC WMI device, only the UID might be different.
> > > The reason why the thermal control WMI methods are not available on older WMAX devices is
> > > that Dell seemed to have introduced this WMI methods after the usual WMAX WMI methods.
> > > 
> > > Because of this i advise against splitting WMAX (LED, attributes, ...) and AWCC functionality
> > > into separate files.
> > By examining the ACPI tables of the devices that support the AWCC
> > functionality, I realized none of the newer devices support the LED
> > interface.
> 
> You are right, i misread the decoded bmof buffer xd.
> 
> > At the time I added quirks for those devices I assigned `num_zones = 2`,
> > because I mimicked the default behavior of the driver, which was
> > assigning quirk_unknown to devices not listed on the DMI table.
> > 
> > This is of course my bad, but fortunately in all these cases the WMAX
> > device returned an error code safely.
> > 
> > I can send a fix for this, but it would require a bit of refactoring of
> > the init function, which I think would cause merge conflicts if we end
> > up reworking this driver. Also we don't know "FOR SURE" which devices
> > don't support the LED interface, although I'm pretty sure it comes down
> > to the UID of the device, but it's just a guess in the end.
> 
> If you do not know for sure which devices _you_ added support the LED interface, then
> i would prefer to remove the "num_zones = 2" quirk from those devices for now.
> 
> > Thoughts on sending a fix? I believe leaving zones is pretty harmless in
> > the end.
> 
> Please send a fix for your quirk entries, so we can avoid forgetting this little detail.

Sure! I'll fix this weekend.

> 
> > I would love to have advice from Dell on this too. Hopefully they'll
> > get back at us at some point. Any time now...
> > 
> > > > Approach I took for the rework
> > > > ==============================
> > > > 
> > > > Parts 1-7 sort of containerize all AlienFX functionality under the
> > > > "alienware-wmi" platform driver so WMI drivers can prepare and register
> > > > a matching platform device from the probe.
> > > > 
> > > > Parts 8-12 create and register two WMI drivers for the LEGACY and WMAX
> > > > devices respectively. The code for these probes is VERY similar and
> > > > all "differences" are passed to the platform device via platform
> > > > specific data (platdata). Also AlienFX functionality is refactored to
> > > > use non-deprecated WMI methods.
> > > > 
> > > > Parts 13-17 migrate all AWCC methods to use non-deprecated WMI methods
> > > > and the state container driver model.
> > > > 
> > > > Parts 18-21 I splitted the alienware-wmi.c module into the different
> > > > features this driver manages.
> > > > 
> > > > alienware-wmi-base.c is in charge of initializing WMI drivers and
> > > > define some platform specific data, like operations (Part 10 for more
> > > > info). alienware-wmi-alienfx.c has all AlienFX functionality and
> > > > alienware-wmi-awcc.c has all AWCC functionality.
> > > I would rather split the drivers into:
> > > 
> > > - alienware-wmi-legacy, which handles the LEGACY WMI device and registers a alienware-wmi platform device
> > > 
> > > - alienware-wmi-wmax, which handles the modern WMAX WMI device and also registers a alienware-wmi platform device
> > > 
> > > - alienware-wmi-base, which provides a driver for the alienware-wmi platform device
> > If you don't change your mind with the information given above, I'm ok
> > with this. That's why I splitted the driver at the end of the series :p
> 
> I did not change my mind.
> 
> I can understand that most devices either support the original WMAX WMI methods or the AWCC WMI methods,
> but from a technical point of view it is still the same device. Also Dell could combine both sets of WMI methods
> in a future device, and i would prefer being prepared for that.
> 
> We can still split alienware-wmi-wmax into multiple files (which get linked together) later should the source code
> of it get too big in the future.
> 
> Also having a separate alienware-wmi-legacy would allow users to disable this driver when building the kernel.

Makes sense, I'll split it that way in the next iteration.

> 
> > > This of course only works if the LEGACY WMI device and the WMAX WMI device are newer both present at the same time,
> > > in this case alienware-wmi-legacy could use wmi_has_guid() as a band aid check to avoid probing if a WMAX WMI device
> > > is present.
> > > 
> > > Using the platform_data mechanism to decouple the alienware-wmi device driver from the underlying hardware implementation
> > > should be fine IMHO.
> > This is good to know!
> > 
> > > > Coments
> > > > =======
> > > > 
> > > > This is still kind of a draft, but I did some testing and it works!
> > > > 
> > > > Of course I will do thorough testing and cleanup when I send the
> > > > non-RFC version. I just want to get some comments on the general
> > > > approach before proceeding further.
> > > > 
> > > > I think this is quite messy in it's current state so I apollogize.
> > > > 
> > > > @Mario Limonciello: I included the reviews you gave me on [2]. I
> > > > included some of those patches here, and dropped the ones that did not
> > > > make sense with this design. As this is another series let me know if
> > > > you want me to drop the tags!
> > > > 
> > > > @Armin Wolf: I don't like the amount of files I made. As the maintainer
> > > > of the wmi module, what do you think about making two independent
> > > > modules, one for AlienFX and one for AWCC. In order to not register two
> > > > drivers for the WMAX device the module init would check if the "AWCC"
> > > > UID is present.
> > > I know of at least one device which support both AWCC thermal control and
> > > WMAX LED control, so splitting the WMAX device driver like this could cause
> > > problems.
> > > 
> > > Like i said before, you should view the WMAX WMI device as having different
> > > capabilities (= WMI methods) depending of the machine the kernel is running on.
> > Yes, it's really unfortunate Dell didn't make a new device for the
> > thermal methods.
> 
> I agree, sadly this god object architecture is very common with some hardware manufactures :(
> 
> > 
> > > If a capability is available (currently determined via quirks), the driver should
> > > do the necessary things to handle it.
> > > 
> > > As a side note: i am currently exploring if we can decode the WMI BMOF buffers inside
> > > the kernel, so that in the far future we can remove those quirks and automatically detect
> > > which methods are available. But this will take a long time, so it has nothing to do with
> > > this patch series.
> > This would be an awesome feature! Will you implement Pali Rohar's decoder?
> > I'll be sure to make the necessary improvements once is done.
> 
> I will base my work on Pali Rohars decoder, but sadly the source code is quite convoluted, so i will
> need to do some reverse-engineering.
> 
> The decompression alogrithm is already finished:
> 
> https://github.com/Wer-Wolf/libdeds

Wow this is MUCH more readable now, nice work! I remember pulling gdb
just to get a general idea of what was going on. The parsing code should
be able to be simplified, but it is indeed very convoluted.

> 
> Thanks,
> Armin Wolf
> 
> > 
> > > I will take a look at the other patches tomorrow.
> > Thank you very much!
> > 
> > ~ Kurt
> > 
> > > Thanks,
> > > Armin Wolf
> > > 
> > > > The approach for that would be basically the same, and I think the
> > > > series would change very little.
> > > > 
> > > > I would like this a lot because I still think old and new WMAX devices
> > > > are different, but I couldn't find another example of where an OEM
> > > > repurposed a WMI device.
> > > > 
> > > > @Everyone: I know this is VERY long. Thank you so much for your time in
> > > > advance!
> > > > 
> > > > This series were made on top of the 'for-next' branch:
> > > > 
> > > > Commit c712e8fd9bf4 ("MAINTAINERS: Change AMD PMC driver status to "Supported"")
> > > > 
> > > > ~ Kurt
> > > > 
> > > > [1] https://lore.kernel.org/platform-driver-x86/6m66cuivkzhcsvpjv4nunjyddqhr42bmjdhptu4bqm6rm7fvxf@qjwove4hg6gb/T/#u
> > > > [2] https://lore.kernel.org/platform-driver-x86/20241120163834.6446-3-kuurtb@gmail.com/
> > > > 
> > > > Kurt Borja (21):
> > > >     alienware-wmi: Modify parse_rgb() signature
> > > >     alienware-wmi: Move Lighting Control State
> > > >     alienware-wmi: Remove unnecessary check at module exit
> > > >     alienware-wmi: Improve sysfs groups creation
> > > >     alienware-wmi: Refactor rgb-zones sysfs group creation
> > > >     alienware-wmi: Add state container and alienfx_probe()
> > > >     alienware-wmi: Migrate to state container pattern
> > > >     alienware-wmi: Add WMI Drivers
> > > >     alienware-wmi: Initialize WMI drivers
> > > >     alienware-wmi: Add alienfx OPs to platdata
> > > >     alienware-wmi: Refactor LED control methods
> > > >     alienware-wmi: Refactor hdmi, amplifier, deepslp
> > > >     alienware-wmi: Add a state container for AWCC
> > > >     alienware-wmi: Migrate thermal methods to wmidev
> > > >     alienware-wmi: Refactor sysfs visibility methods
> > > >     alienware-wmi: Make running control state part of platdata
> > > >     alienware-wmi: Drop thermal methods dependency on quirks
> > > >     platform-x86: Add header file for alienware-wmi
> > > >     platform-x86: Rename alienare-wmi
> > > >     platform-x86: Split the alienware-wmi module
> > > >     platform-x86: Add config entries to alienware-wmi
> > > > 
> > > >    MAINTAINERS                                   |    3 +-
> > > >    drivers/platform/x86/dell/Kconfig             |   25 +-
> > > >    drivers/platform/x86/dell/Makefile            |    5 +-
> > > >    .../platform/x86/dell/alienware-wmi-alienfx.c |  531 +++++++
> > > >    .../platform/x86/dell/alienware-wmi-awcc.c    |  282 ++++
> > > >    .../platform/x86/dell/alienware-wmi-base.c    |  525 +++++++
> > > >    drivers/platform/x86/dell/alienware-wmi.c     | 1267 -----------------
> > > >    drivers/platform/x86/dell/alienware-wmi.h     |  141 ++
> > > >    8 files changed, 1505 insertions(+), 1274 deletions(-)
> > > >    create mode 100644 drivers/platform/x86/dell/alienware-wmi-alienfx.c
> > > >    create mode 100644 drivers/platform/x86/dell/alienware-wmi-awcc.c
> > > >    create mode 100644 drivers/platform/x86/dell/alienware-wmi-base.c
> > > >    delete mode 100644 drivers/platform/x86/dell/alienware-wmi.c
> > > >    create mode 100644 drivers/platform/x86/dell/alienware-wmi.h
> > > > 

