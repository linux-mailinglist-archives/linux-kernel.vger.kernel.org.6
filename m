Return-Path: <linux-kernel+bounces-538411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E14A4984C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8B3B8066
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB32620EE;
	Fri, 28 Feb 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npjlJ49p"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FE849C;
	Fri, 28 Feb 2025 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742081; cv=none; b=NhJaNMMEWErusiz4sqnFSnywRJz80y8wRwBsb/rlu5/KacNIRJIui9HSYVGdIv/kflIwhff4+P62E8+AjxSCigqCNX551JHTlXXXK6ShAgSvKVtvGGjC8clp1jRdlvzej/aZFvb5A4OfpbQCGtVgx4eDY2JFPQRZooQ3TEvYWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742081; c=relaxed/simple;
	bh=ph2eV75ac7TO5yWNuv/0bNjgL3+2kjs/xz3MGS4pums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6iCyMZi6ZDkY1T/dyrMf2kooyc4Ulb6kEOTPEjs9wWad90FokazBQzZJTD6dSOg3A2K/ukqOEDgnX9x9LgbxH8IFN91vtUYktGioaJh1+HYe3FIxIf5/vbuG/8CwTqJNazVYQFBiOzTnMPudmtkCfuwWL9I4y2DMecOI9A6dCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npjlJ49p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390ddf037ffso962967f8f.2;
        Fri, 28 Feb 2025 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740742077; x=1741346877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F1D7gP0Ge8LUAQxCpK6YvKiYxo3LHCFrWBKeXnCHAVs=;
        b=npjlJ49pfY463cuPkd/Q5SxBp19pnVOC/9MDZNzsFRcL1SSf8K2D4OZcTBBDG1sopp
         jV019PxPwn6QXkJ6t5I2iACtQWZx6AkCmDd5hl1F6gh0yLXss/wpnER/avPxBkOVY5E9
         NUirmp2cRba1wdg1fsGqSaG4Umt5ieV93hWbP/PMQS5f5ET3mlmy+FHL6PcB8hSH3w7v
         nvamWtZpTCh6gPSLIIAUP7qqaJw2Fp/UGtJ7CRerH35vG83a/qf4DV+GLRWFfnkM9bXk
         08lhAYZCSRj+buQwFCO6xfFVgbsBwK5IK5aUKuB0En+f1gRvySmZxTv+Vfs0D2l/PYX5
         cMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740742077; x=1741346877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1D7gP0Ge8LUAQxCpK6YvKiYxo3LHCFrWBKeXnCHAVs=;
        b=THCY1PiBniYtNmtr4b5JcmAYrzxgbixoerwfU/JcQwD+qWw4DzUvNyenLuEgN7aH4I
         pAgukjenS3qcwg+euOFZKw8E4Ae1dvo3XNuor9Vbmy5L6C2FYWKkfzwIQQRG3ht6ta7Y
         RVdk8FvLRmSy4MnTsYQjaYQ+dXY3Cg3Xq5z5+rBkiTcOUlepcWUwq9xf+znr1E4GnbRe
         C4GRwyxfJEM9DPiB9hHAfO3zfD3clVB9rO8dWn/63SNoq4rs7EjALS1xFJIv4Qj55W95
         JNvZTk5LSoMFXpHJ28b6tUeeXS4KHKy6umabmPae62lEymxZp3nhrwq8n6SBI5eDi7y8
         Ql9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPXYyhX0nfvaFGcxybPTthoznJR9ybdPZ1NE8E7riU400ZcDFfHFpyxJcld2qQ0L5YDvEaQU+dyChyA14=@vger.kernel.org, AJvYcCWHkz44GnaYzcYKkRTBwwFyOcIBNeQ1hbjgkmvVRZHYdeUATFKTvTnyTCTs7FANHRTHzCQDN6Iq7FQ0@vger.kernel.org, AJvYcCX6s2ytOU/szZRxDTK6tfdYGk7W8dLj/KFk9CMk5or6mE3Ddv0DsdoTvRueow3dY2e7AgUkjD9AkbnP0eiINMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyto8RU5TVEJEZ5SlI5IQQj/IXKLx6k5eryT0L2DZLZpOPSBbgv
	tF/Sw7Pr5Bxq+THT/O4b1Ju+GcTI/blGUESRs5e3OC4YDckVEPZl
X-Gm-Gg: ASbGncuuhCRxVLLpiCMWK1F6b2mitPYzgVbiBXM4DX+BLRchNvCfijLMUCFNj1vLNi+
	9+YCLdNz9Myi2hGlD/04Zl0sf6+dgPZ09TZfULutOMbPVX/wYXK2HnR36hBx4496B0D0VwwP7Xo
	sM4kRDG/KeL7AHqLSkJl+hPT4dzJ3KKHThj+i1j3h2cHjadjkS1ECXp8xmtRQs1UdfGkiMhvkZQ
	gWxuWgjdbwuEwx+bgr5JmOwSKY5iNhDYFX3MZqZG204c92VgXhcyzmodS6E5s6dxwT5ntwWz4EG
	zIn/thoFnhN0Xefd1RMsVNwgBg==
X-Google-Smtp-Source: AGHT+IFMjgOVhCa1fLYZSX8OFA6uz0H6ljmEFwrU+/DUQkasH7cYQWqqql8PU7bFzoHPd/2IUrYJ0w==
X-Received: by 2002:a5d:5f84:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390ec7c6a3bmr2600028f8f.3.1740742077193;
        Fri, 28 Feb 2025 03:27:57 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796051sm5000573f8f.12.2025.02.28.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 03:27:56 -0800 (PST)
Date: Fri, 28 Feb 2025 12:27:54 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-usb@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Driver core: Add faux bus devices
Message-ID: <Z8Gduj1cDdCYzaBY@fedora>
References: <2025021023-sandstorm-precise-9f5d@gregkh>
 <7d196a91-220a-41a5-8577-198b436d8440@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d196a91-220a-41a5-8577-198b436d8440@bootlin.com>

Hi everyone,

Thanks for CCing me Louis,

On Thu, Feb 27, 2025 at 02:06:21PM +0100, Louis Chauvet wrote:
> 
> 
> Le 10/02/2025 à 13:30, Greg Kroah-Hartman a écrit :
> > For years/decades now, I've been complaining when I see people use
> > platform devices for things that are obviously NOT platform devices.
> > To finally fix this up, here is a "faux bus" that should be used instead
> > of a platform device for these tiny and "fake" devices that people
> > create all over the place.
> > 
> > The api is even simpler than the normal platform device api, just two
> > functions, one to create a device and one to remove it.  When a device
> > is created, if a probe/release callback is offered, they will be called
> > at the proper time in the device's lifecycle.  When finished with the
> > device, just destroy it and all should be good.
> > 
> > This simple api should also hopefully provide for a simple rust binding
> > to it given the simple rules and lifecycle of the pointer passed back
> > from the creation function (i.e. it is alive and valid for as long as
> > you have not called destroy on it.)
> > 
> > I've also converted four different examples of platform device abuse, the
> > dummy regulator driver, the USB phy code, the x86 microcode dvice, and
> > the "regulator" device that wifi uses to load the firmware tables, to
> > use this api.  In all cases, the logic either was identical, or became
> > simpler, than before, a good sign (side note, a bug was fixed in the usb
> > phy code that no one ever noticed before).
> > 
> > Note, unless there are major objections, I'm leaning toward getting
> > patch 1 and 2 of this series merged during this -rc cycle so that all of
> > the individual driver subsystem cleanups can go through those subsystems
> > as needed, as well as allowing the rust developers to create a binding
> > and get that merged easier.  Having patch 1 merged on its own isn't
> > going to cause any changes if no one uses it, so that should be fine.
> 
> Hi all,
> 
> I have a maybe dumb question regarding the patches 3..9: do they break the
> UAPI?

I made a quick test with drm_info [1] and VKMS is not listed after moving
it to the faux bus. As far as I can tell, the reason is that drmGetDevices()
doesn't return the devices in the faux bus.

However, as drm_info is designed to list information as close as it is provided
by libdrm, I'm not sure if this should be considered a regressions or not.

Just for reference, Mutter handles the bus change correctly, and it uses
udev [2]. I think I should do something similar in my IGT tests and use udev
instead of drmGetDevices().

[1] https://gitlab.freedesktop.org/emersion/drm_info
[2] https://gitlab.gnome.org/GNOME/mutter/-/blob/main/src/backends/meta-udev.c?ref_type=heads#L174

> With a platform device, the drivers appear under /sys/bus/platform, but with
> faux device, they appear under /sys/bus/faux.
> 
> I ask because I found out that one (see my reply to [2]) of the main drm
> library expects to find all the devices under pci, usb, platform, virtio and
> host1x buses [1], so at least for the vgem and vkms driver, this library
> will be broken (it will not crash, but previously detected devices will
> suddenly disappear).
> 
> I don't know what are the rules for /sys/bus, but changing a device from one
> bus to another seems to break userspace programs. How should we handle this
> situation? Should we fix the existing drivers? Or only new drivers should
> use it?
> 
> +CC: José Expósito
> 
> Thanks,
> Louis Chauvet
> 
> [1]:https://gitlab.freedesktop.org/mesa/drm/-/blob/main/xf86drm.c#L4460-4515
> [2]:https://lore.kernel.org/all/20250218165011.9123-21-jose.exposito89@gmail.com/
> 
> > Changes from v4:
> >    - really dropped the internal name structure, remanants were left over
> >      from the last patch series
> >    - added the rust binding patch from Lyude (is this one of the first
> >      patch series that adds a new kernel api AND the rust binding at the
> >      same time?)
> >    - added a parent pointer to the api so the devices can be in the tree
> >      if the caller wants them
> >    - made probe synchronous to prevent race when using the api (when the
> >      create call returns the device is fully ready to go.)  Thanks to
> >      testing of the drm driver change to find this issue.
> >    - documentation tweaks
> >    - #include <linux/container_of.h> finally added to faux.h
> > 
> > 
> > Changes from v3:
> >    - Dropped the USB phy porting, turned out to be incorrect, it really
> >      did need a platform device
> >    - converted more drivers to the faux_device api (tlclk, lis3lv02d,
> >      vgem, and vkms)
> >    - collected some reviewed-by
> >    - lots of minor tweaks of the faux.c api, and documentation based on
> >      review, see the changelog in patch 1 for details.
> > 
> > Changes from v2:
> >    - lots of cleanups to faux.c based on reviews, see patch 1 for details
> >    - actually tested the destroy device path, it worked first try!
> >    - added 3 more example drivers
> > 
> > 
> > 
> > Greg Kroah-Hartman (8):
> >    driver core: add a faux bus for use when a simple device/bus is needed
> >    regulator: dummy: convert to use the faux device interface
> >    x86/microcode: move away from using a fake platform device
> >    wifi: cfg80211: move away from using a fake platform device
> >    tlclk: convert to use faux_device
> >    misc: lis3lv02d: convert to use faux_device
> >    drm/vgem/vgem_drv convert to use faux_device
> >    drm/vkms: convert to use faux_device

In regard of the VKMS patch, in Documentation/gpu/vkms.rst, "IGT_DEVICE" needs
to be updated to point to the new path. It can be done in this series or I can
send a follow up patch.

Best wishes,
Jose

> > 
> > Lyude Paul (1):
> >    rust/kernel: Add faux device bindings
> > 
> >   Documentation/driver-api/infrastructure.rst |   6 +
> >   MAINTAINERS                                 |   2 +
> >   arch/x86/kernel/cpu/microcode/core.c        |  14 +-
> >   drivers/base/Makefile                       |   2 +-
> >   drivers/base/base.h                         |   1 +
> >   drivers/base/faux.c                         | 232 ++++++++++++++++++++
> >   drivers/base/init.c                         |   1 +
> >   drivers/char/tlclk.c                        |  32 +--
> >   drivers/gpu/drm/vgem/vgem_drv.c             |  30 +--
> >   drivers/gpu/drm/vkms/vkms_drv.c             |  28 +--
> >   drivers/gpu/drm/vkms/vkms_drv.h             |   4 +-
> >   drivers/misc/lis3lv02d/lis3lv02d.c          |  26 +--
> >   drivers/misc/lis3lv02d/lis3lv02d.h          |   4 +-
> >   drivers/regulator/dummy.c                   |  37 +---
> >   include/linux/device/faux.h                 |  69 ++++++
> >   net/wireless/reg.c                          |  28 +--
> >   rust/bindings/bindings_helper.h             |   1 +
> >   rust/kernel/faux.rs                         |  67 ++++++
> >   rust/kernel/lib.rs                          |   1 +
> >   samples/rust/Kconfig                        |  10 +
> >   samples/rust/Makefile                       |   1 +
> >   samples/rust/rust_driver_faux.rs            |  29 +++
> >   22 files changed, 502 insertions(+), 123 deletions(-)
> >   create mode 100644 drivers/base/faux.c
> >   create mode 100644 include/linux/device/faux.h
> >   create mode 100644 rust/kernel/faux.rs
> >   create mode 100644 samples/rust/rust_driver_faux.rs
> > 
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

