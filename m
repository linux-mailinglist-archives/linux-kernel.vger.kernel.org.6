Return-Path: <linux-kernel+bounces-196829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A28D6245
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576B5288ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5AD1586CC;
	Fri, 31 May 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G7lL3qDy"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000715747C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160388; cv=none; b=XT5YIOLpo1LiGNb3OEN3aMPK4chltB7attmlyHUrZwMTIOCSfswl0sHGJmwuJ0Ruc5p6HZs1NtEg3PVJhCTrftb65DlzzqKJ9e1++MUw/HtFE7CT3qY3pPrecYjTrY2edFogTqZo8UZhjOXzraDtRAqrjng4iYyarnHzLbPsg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160388; c=relaxed/simple;
	bh=SbSIJSaxifN8ilLLlOjjSgs1ZMiaEBqAYbYSm87dysY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDWQCA4ATJNk9+XsnYFccJhMiAF48WuN3JWLPaAAPkJayF6rPoBNIV2/8zHxFgIjs5i8DTyTC2vYQpBwgH69xADiQmAjsCovV7EwxTPQHCW8A8EquNODONimoyYgAvJwLwlfzSsQEMbeGwub5b3TjeESYbqJ27imhbDqW+4XDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G7lL3qDy; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b80e5688aso2367553e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717160385; x=1717765185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgAedokl3gRs935zOQgIriLiKTu9cIN2F2d3LZv5g+w=;
        b=G7lL3qDy5+ZxjT5P/cfwMcOi1cbsdQ0w9aj4BYh+UPwTU5bqqwklbpq6cairLOC9mx
         seoRopbpZcHFgitTeVM+kyev1WDoCpRhdYXFDsNRK/jFHY6cDVN/fd3Ncj55cyX/TZvV
         Ztskw+DgtQZOOVLsYU3QzkPQt4GbF5ap2anSoRftnLDDH7/Ke0EJsu9aep5Hc3wS7TtQ
         jERxHmPA/FE2C6gZRYTxZ70C5ID48SVL7MVySA+FLbv0msOYmF0bgyEGl6Dv+z5AT5A6
         MqHYSZHyr6m/3JxLvQGB1H+SCZv6GKWev+h88u9DDbduL8lkJ9cyjrTPsTlxdR0Cgnnj
         CqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717160385; x=1717765185;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgAedokl3gRs935zOQgIriLiKTu9cIN2F2d3LZv5g+w=;
        b=ML4/knznUPr+/ZzVqSTHXWcfLnsCnaWRJgyytlBUsTwfiOUxqALTvBtjSYaXlVlE+I
         ti+N2IYV3c/zBPGQP/BVqDzg1UgfGpyvIoYUlY6QWEiE2Tf4dm2fs/y+CJxTPX0KnwXj
         GmL8bSLROnm5fGscANL+BdEleMyhH1eee0ujSD3vjon6SDyat4ILzBfnYO3uEaWrBrjq
         hNYRBmHYfnc1MuoExVnsw51s0oH9Fa5bUdeuJdVimJyjMcaRW01GFytSIYG53zH1lpgx
         ZOA1Qas6Vgz8VfixIwrsPE1BNTmF24ZdtOa8s5/K1L7qDQRlmT4ngDVxq/if3WvqUfJz
         Lxkg==
X-Forwarded-Encrypted: i=1; AJvYcCV2EYynBsrAb1Yp5y6GpjLFOJIDh8IPXjIcXzu9VZOmeUT/uESBehlD9UnXs/4JA0uMpMC42vCvDKQ7wC3cTRTaOJrjUjxGfJa9X7/+
X-Gm-Message-State: AOJu0YxPX28v7gju+cCtxrQmlr71Uwzal93QkYG9xQvZmz09jhEo+cSp
	QUnZV0FNIadV9kgmbgt4Ug2miJkuHS+iutzK+BXl/iqCaB0WxBMfILm3pD4CgkM=
X-Google-Smtp-Source: AGHT+IHlzlusjyEOgZJnGuSuPZL0kGHD+/XX/Cx4GjQtie8rM3SZ6VVnGyuOMCLAHH96a+kEylXvFA==
X-Received: by 2002:ac2:5332:0:b0:52a:5551:5606 with SMTP id 2adb3069b0e04-52b895a3e7amr1619090e87.50.1717160384912;
        Fri, 31 May 2024 05:59:44 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f03728sm84644066b.20.2024.05.31.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 05:59:44 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 31 May 2024 14:59:58 +0200
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add minimal boot support for Raspberry Pi 5
Message-ID: <ZlnJzqnvTk70O3ap@apocalypse>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
References: <cover.1717061147.git.andrea.porta@suse.com>
 <36642bd8-c981-4190-9f44-072ac3c97c6b@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36642bd8-c981-4190-9f44-072ac3c97c6b@gmx.net>

Hi Stefan,

On 12:00 Fri 31 May     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 30.05.24 um 12:11 schrieb Andrea della Porta:
> > Hi,
> > 
> > This patchset adds minimal support for the Broadcom BCM2712 SoC and for
> > the on-board SDHCI controller on Broadcom BCM2712 in order to make it
> > possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
> > console through uart.
> > Changes to arm64/defconfig are not needed since the actual options work
> > as they are.
> > This work is heavily based on downstream contributions.
> > 
> > Tested on Tumbleweed substituting the stock kernel with upstream one,
> > either chainloading uboot+grub+kernel or directly booting the kernel
> > from 1st stage bootloader. Steps to reproduce:
> > - prepare an SD card from a Raspberry enabled raw image, mount the first
> >    FAT partition.
> > - make sure the FAT partition is big enough to contain the kernel,
> >    anything bigger than 64Mb is usually enough, depending on your kernel
> >    config options.
> > - build the kernel and dtbs making sure that the support for your root
> >    fs type is compiled as builtin.
> > - copy the kernel image in your FAT partition overwriting the older one
> >    (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
> > - copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
> > - make sure you have a cmdline.txt file in FAT partition with the
> >    following content:
> >    # cat /boot/efi/cmdline.txt
> >    root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon
> >    console=ttyAMA10,115200
> > - if you experience random SD issues during boot, try to set
> >    initial_turbo=0 in config.txt.
> was this an issue since the beginning of this series?
>

I experienced this even during early testing, using the complete downstream
driver. It seems that when initual_turbo != 0, the fw can throttle the clock
to reduce the boot time and it (directly or indirectly) may affect SD functionality.
I believe that the probability of this to happen is likely a function of SD
card speed, whether it requires timing tuning, initial_turbo exact value  and whether
you are booting the kernel directly or chainloading u-boot + grub (or
whatever combination of secondary stage bootloader). For example, your 
boot setup may have a timeout in the grub boot menu that is large enough for the clocks
to settle and the boot process to end successfully, while faster boot time can lead
to the issue described. Since this behaviour seems to depend on all of this factors and
does not necessarily arise in practice, disabling initial_turbo is just a suggestion
in case things go haywire. 

> What kind of SD issues?
>

I wasn't able to boot from SD card due to clock issues.
 
> Is there a downstream reference?

Some (old) reference e.g.:
https://forums.raspberrypi.com/viewtopic.php?t=112480#:~:text=It%20sets%20turbo%20mode%20from,have%20turbo%20during%20the%20boot.

but there are probably more.

Many thanks,
Andrea

