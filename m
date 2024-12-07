Return-Path: <linux-kernel+bounces-435856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00009E7DEA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B20028734C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814342744E;
	Sat,  7 Dec 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6gTOFNz"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DF25632;
	Sat,  7 Dec 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536782; cv=none; b=ctetrGmlDY5Rc7dC/mVXXmwISLaZPRLTPXLL10HOkikLBm1B0qhMVUUT+OOv8FOwUPpNIMKGFweNNJYfgBOvU86Fw4nZ20oSPhopirh4ds4dpi0ea1gGRWLgWWrQ88SIDEY62jB16Zs/RAtXqRjTMFqTaCwNVCZXPoQ5ef+kd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536782; c=relaxed/simple;
	bh=3uGJqITsETUOQFTFlWZ9MGG3XmLzoexlQeg4UPEtrQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsSNxJ/K1BtCOCnbLKRPg8L6Fsr2UmJqsnYSwVVCaRDISE0OIS7TwTaM+ruoaQELHN5lbKmlKIEu5hgaKWx92dDk1g6wWg6mKQWHlX58yrCwETU5GVJC0RNuJfTyh72wIOTc3FlOmlP+OjQF0MWfgnKbxkJs3cTkjBEc5F/lA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6gTOFNz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso2090835a91.3;
        Fri, 06 Dec 2024 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733536780; x=1734141580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdDk2yGNuQsB8tuRebQSzwsyv4jcZj0j6IHin6uB0Dg=;
        b=l6gTOFNzmrvpHhwew3dlGawJ/10xb5C2R4ytY1TCeUa+kIen5d6n9Km6sx8tJPMkAH
         tY9MShQk1r42i58Fz/fOQRPYu7DPHHomY0Jh4mm4g6YULkbmxBbdGXf3YMOSPs8dinxq
         F/FxLO2Pc6bt3hBzFrhK/1mYTz/RwBSmT6TWG/qN0uLny7tZ981X8WGqt2bTGE42E8sW
         5QWlbVcVlh/vLMHtC/FneR1XGmx0cKL/7X1rXKldsrokD6gzfPKGrLNtBR1P3xEsvLT0
         J4b0lET+PSU/UIr6av/PSA6rnTsTi8MIflwLClJkJu/TouvoFqsCmhqSvR41gx27g9XH
         qVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733536780; x=1734141580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdDk2yGNuQsB8tuRebQSzwsyv4jcZj0j6IHin6uB0Dg=;
        b=ceZC3wouTPBdyIgvAeKZbj9JkTSCpI7TWdDCg3ADFl9AS7KAyrhg+qZDlY5sgQehpQ
         vm2pcmxY9IGUIp0e15icpaoA+Cgu9/8u9OLbDeu53Y2k993HgUr0aJdEmvPinmFyR1pL
         Rez4SaucyVMOqnVgx+wcdnyCtvFZcPV9Ol5JpJHTdepOOAlEecqCHjuFm0AkvANHr4Wa
         PYw0+Vghzm6pV2qNrCGJ8oWHlNi88ew0vLLhVzeyL3F6xSUEgct5cq0kgWboLecl7ONf
         PhVJoKT9XD2M8PuWlBaa4jlC/LfmYXrFqmgOou1OwxfjSopfQd/hWTLf4jujL4pKz4Pg
         dbqg==
X-Forwarded-Encrypted: i=1; AJvYcCXLN25OFFsIH1TAgzdLw2RKU6WRW8kfJgFJAeg1f7lZlfuBGiF7cjhN21/UBNRhRRodgmP0JOI50C+i1sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGaQLu489CwQbP+os6Gb3rrXwntXPGKkBrGM9Ts4jz9C3AFxj
	coXG6PhaQB0Ev/bAFLeyC+cXzdmeKWdag1n0YHXKMQ2PbM9/VEao
X-Gm-Gg: ASbGnct0kKRkGLiLCP7ZjfbXrIrYVlX9hEupUSAauTwHYKzOuMXynh+4AUAwEXeDdUI
	qcvfRSBF8BXEtGRcSofdVmKu7yQ5Bwrh27xIMtPx+GClU/OBVQRBdvIt8ZeLoNVl1Kq6pyXnJvq
	Ru/PxoYYpAJAeQ1q3egsp59Pd5VWEKhJvR3R5IAOb4EqcogEkKe7GGSK/rrlYI4kC8ZVPtWfH8f
	QFjXI0pnoStDp/PjyHJnmRytCeJsn47giHx/aZZepdXDxu8Ogb8QTBuS4dDqosqFRivOYfokzGT
	3iTXL7uP
X-Google-Smtp-Source: AGHT+IEf0yRplLDgeuChr+UXCZtXb3OOz9gfnwYq26SWcx5VmMhAKFdQGDBT3heD1m8C3qgWEnYx9g==
X-Received: by 2002:a17:90b:1d81:b0:2ee:ee77:227c with SMTP id 98e67ed59e1d1-2ef6955a2e7mr7942886a91.3.1733536779863;
        Fri, 06 Dec 2024 17:59:39 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm2191172a91.36.2024.12.06.17.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 17:59:39 -0800 (PST)
Date: Fri, 6 Dec 2024 22:59:35 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com
Subject: Re: [RFC PATCH 00/21] alienware-wmi driver rework
Message-ID: <w3sxt2kt64g2b6gjucnsmnydfm4r74pzf2sl6fcjmjwvk3jyd5@2miohw3pslwk>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <eec050e3-1b60-4430-b0ff-91e4e250d8f3@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec050e3-1b60-4430-b0ff-91e4e250d8f3@gmx.de>

On Sat, Dec 07, 2024 at 12:26:20AM +0100, Armin Wolf wrote:
> Am 05.12.24 um 01:27 schrieb Kurt Borja:
> 
> > Hi :)
> > 
> > This series are a follow-up to this discussion [1], in which I proposed
> > migrating the alienware-wmi driver to use:
> > 
> > 1. State container driver model
> > 2. Modern WMI driver design
> > 3. Drop use of deprecated WMI methods
> > 
> > Of course, this was much harder than expected to do cleanly. Main
> > problem was that this driver "drives" two completely different devices
> > (I'm not referring to the WMI devices, which also happen to be two).
> > 
> > Throughout these series we will call these devices AlienFX and AWCC.
> > 
> > As a preamble
> > =============
> > 
> > AlienFX exposes a LED, hdmi, amplifier and deepsleep interface to
> > userspace through a platform device named "alienware-wmi". Historically
> > this driver handled this by leveraging on two WMI devices as a backend.
> > This devices named LEGACY and WMAX were very similar, the only
> > difference was that WMAX had more features, but share all features
> > LEGACY had. Although it's a stretch, it could be argued this WMI devices
> > are the "same", just different GUID.
> > 
> > Later Dell repurposed the WMAX WMI device to serve as a thermal control
> > interface for all newer "gaming" laptops. This new WMAX device has an
> > ACPI UID = "AWCC" (I discovered this recently). So it could also be
> > argued that old WMAX and AWCC WMAX are not the same device, just same
> > GUID.
> > 
> > This drivers manages all these features using deprecated WMI methods.
> 
> I think there is a misunderstanding here.
> 
> The WMAX WMI device is identical with the AWCC WMI device, only the UID might be different.
> The reason why the thermal control WMI methods are not available on older WMAX devices is
> that Dell seemed to have introduced this WMI methods after the usual WMAX WMI methods.
> 
> Because of this i advise against splitting WMAX (LED, attributes, ...) and AWCC functionality
> into separate files.

By examining the ACPI tables of the devices that support the AWCC
functionality, I realized none of the newer devices support the LED
interface.

At the time I added quirks for those devices I assigned `num_zones = 2`,
because I mimicked the default behavior of the driver, which was
assigning quirk_unknown to devices not listed on the DMI table.

This is of course my bad, but fortunately in all these cases the WMAX
device returned an error code safely.

I can send a fix for this, but it would require a bit of refactoring of
the init function, which I think would cause merge conflicts if we end
up reworking this driver. Also we don't know "FOR SURE" which devices
don't support the LED interface, although I'm pretty sure it comes down
to the UID of the device, but it's just a guess in the end.

Thoughts on sending a fix? I believe leaving zones is pretty harmless in
the end.

I would love to have advice from Dell on this too. Hopefully they'll
get back at us at some point. Any time now...

> 
> > Approach I took for the rework
> > ==============================
> > 
> > Parts 1-7 sort of containerize all AlienFX functionality under the
> > "alienware-wmi" platform driver so WMI drivers can prepare and register
> > a matching platform device from the probe.
> > 
> > Parts 8-12 create and register two WMI drivers for the LEGACY and WMAX
> > devices respectively. The code for these probes is VERY similar and
> > all "differences" are passed to the platform device via platform
> > specific data (platdata). Also AlienFX functionality is refactored to
> > use non-deprecated WMI methods.
> > 
> > Parts 13-17 migrate all AWCC methods to use non-deprecated WMI methods
> > and the state container driver model.
> > 
> > Parts 18-21 I splitted the alienware-wmi.c module into the different
> > features this driver manages.
> > 
> > alienware-wmi-base.c is in charge of initializing WMI drivers and
> > define some platform specific data, like operations (Part 10 for more
> > info). alienware-wmi-alienfx.c has all AlienFX functionality and
> > alienware-wmi-awcc.c has all AWCC functionality.
> 
> I would rather split the drivers into:
> 
> - alienware-wmi-legacy, which handles the LEGACY WMI device and registers a alienware-wmi platform device
> 
> - alienware-wmi-wmax, which handles the modern WMAX WMI device and also registers a alienware-wmi platform device
> 
> - alienware-wmi-base, which provides a driver for the alienware-wmi platform device

If you don't change your mind with the information given above, I'm ok
with this. That's why I splitted the driver at the end of the series :p

> 
> This of course only works if the LEGACY WMI device and the WMAX WMI device are newer both present at the same time,
> in this case alienware-wmi-legacy could use wmi_has_guid() as a band aid check to avoid probing if a WMAX WMI device
> is present.
> 
> Using the platform_data mechanism to decouple the alienware-wmi device driver from the underlying hardware implementation
> should be fine IMHO.

This is good to know!

> 
> > Coments
> > =======
> > 
> > This is still kind of a draft, but I did some testing and it works!
> > 
> > Of course I will do thorough testing and cleanup when I send the
> > non-RFC version. I just want to get some comments on the general
> > approach before proceeding further.
> > 
> > I think this is quite messy in it's current state so I apollogize.
> > 
> > @Mario Limonciello: I included the reviews you gave me on [2]. I
> > included some of those patches here, and dropped the ones that did not
> > make sense with this design. As this is another series let me know if
> > you want me to drop the tags!
> > 
> > @Armin Wolf: I don't like the amount of files I made. As the maintainer
> > of the wmi module, what do you think about making two independent
> > modules, one for AlienFX and one for AWCC. In order to not register two
> > drivers for the WMAX device the module init would check if the "AWCC"
> > UID is present.
> 
> I know of at least one device which support both AWCC thermal control and
> WMAX LED control, so splitting the WMAX device driver like this could cause
> problems.
> 
> Like i said before, you should view the WMAX WMI device as having different
> capabilities (= WMI methods) depending of the machine the kernel is running on.

Yes, it's really unfortunate Dell didn't make a new device for the
thermal methods.

> 
> If a capability is available (currently determined via quirks), the driver should
> do the necessary things to handle it.
> 
> As a side note: i am currently exploring if we can decode the WMI BMOF buffers inside
> the kernel, so that in the far future we can remove those quirks and automatically detect
> which methods are available. But this will take a long time, so it has nothing to do with
> this patch series.

This would be an awesome feature! Will you implement Pali Rohar's decoder?
I'll be sure to make the necessary improvements once is done.

> 
> I will take a look at the other patches tomorrow.

Thank you very much!

~ Kurt

> 
> Thanks,
> Armin Wolf
> 
> > 
> > The approach for that would be basically the same, and I think the
> > series would change very little.
> > 
> > I would like this a lot because I still think old and new WMAX devices
> > are different, but I couldn't find another example of where an OEM
> > repurposed a WMI device.
> > 
> > @Everyone: I know this is VERY long. Thank you so much for your time in
> > advance!
> > 
> > This series were made on top of the 'for-next' branch:
> > 
> > Commit c712e8fd9bf4 ("MAINTAINERS: Change AMD PMC driver status to "Supported"")
> > 
> > ~ Kurt
> > 
> > [1] https://lore.kernel.org/platform-driver-x86/6m66cuivkzhcsvpjv4nunjyddqhr42bmjdhptu4bqm6rm7fvxf@qjwove4hg6gb/T/#u
> > [2] https://lore.kernel.org/platform-driver-x86/20241120163834.6446-3-kuurtb@gmail.com/
> > 
> > Kurt Borja (21):
> >    alienware-wmi: Modify parse_rgb() signature
> >    alienware-wmi: Move Lighting Control State
> >    alienware-wmi: Remove unnecessary check at module exit
> >    alienware-wmi: Improve sysfs groups creation
> >    alienware-wmi: Refactor rgb-zones sysfs group creation
> >    alienware-wmi: Add state container and alienfx_probe()
> >    alienware-wmi: Migrate to state container pattern
> >    alienware-wmi: Add WMI Drivers
> >    alienware-wmi: Initialize WMI drivers
> >    alienware-wmi: Add alienfx OPs to platdata
> >    alienware-wmi: Refactor LED control methods
> >    alienware-wmi: Refactor hdmi, amplifier, deepslp
> >    alienware-wmi: Add a state container for AWCC
> >    alienware-wmi: Migrate thermal methods to wmidev
> >    alienware-wmi: Refactor sysfs visibility methods
> >    alienware-wmi: Make running control state part of platdata
> >    alienware-wmi: Drop thermal methods dependency on quirks
> >    platform-x86: Add header file for alienware-wmi
> >    platform-x86: Rename alienare-wmi
> >    platform-x86: Split the alienware-wmi module
> >    platform-x86: Add config entries to alienware-wmi
> > 
> >   MAINTAINERS                                   |    3 +-
> >   drivers/platform/x86/dell/Kconfig             |   25 +-
> >   drivers/platform/x86/dell/Makefile            |    5 +-
> >   .../platform/x86/dell/alienware-wmi-alienfx.c |  531 +++++++
> >   .../platform/x86/dell/alienware-wmi-awcc.c    |  282 ++++
> >   .../platform/x86/dell/alienware-wmi-base.c    |  525 +++++++
> >   drivers/platform/x86/dell/alienware-wmi.c     | 1267 -----------------
> >   drivers/platform/x86/dell/alienware-wmi.h     |  141 ++
> >   8 files changed, 1505 insertions(+), 1274 deletions(-)
> >   create mode 100644 drivers/platform/x86/dell/alienware-wmi-alienfx.c
> >   create mode 100644 drivers/platform/x86/dell/alienware-wmi-awcc.c
> >   create mode 100644 drivers/platform/x86/dell/alienware-wmi-base.c
> >   delete mode 100644 drivers/platform/x86/dell/alienware-wmi.c
> >   create mode 100644 drivers/platform/x86/dell/alienware-wmi.h
> > 

