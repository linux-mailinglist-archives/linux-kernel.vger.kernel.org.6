Return-Path: <linux-kernel+bounces-356115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6A995C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABB6B20E72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749618C0C;
	Wed,  9 Oct 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dLpZBjwb"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9EE137E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435687; cv=none; b=A/pVaEt4GXb3gFcPRrJl4XECBGie9wOBUtYWMgTgiH+PDmQmhRhVqlhbJIpnibEM100RHbQwuy0u59hTPHkwFqrHwT6HWf/4cxsZaVpDM/hrivr4Q+0B2Enuc5sqzLcUvSKm4nlr82upyH2ofVSI6hvM1SjU3A1piH3iI6BAaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435687; c=relaxed/simple;
	bh=Hlua7vggiPfoi2UHU3g21jqc3cnrdncpJKezKfJFIv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luERuDyXEGujuRC1zjHfFdPVeyfgpeILDzj6uS/w1YHfQKf7phqqXLIzC+TyRiX21kIvIMNpem1Oqh6e0416HDMRtMz8JHpOr4EUHfyyQpEBDH6G/Z3v7zjztRBSWIM/hnZ59gjfMtEAKMUNHIk8kAkogBynZAomv0zDx9cNaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dLpZBjwb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9a7bea3cfso365750985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728435683; x=1729040483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAxqxsiZEI5UhKg6mQ45OeLPjqDwtDP0T8PZqcd4lwY=;
        b=dLpZBjwbcDf41qDtJdkKuLKZRt+jXh0C965h56dO/t+C31XAdCf5mo0t85jLirzyuV
         OLQjudPF18g8PbgUG+gE57WyqGJ3o1zGpAtwRFVO1Zisg+rNy4jo2erxBuE98leqSEFK
         4AzJaZelx7SqlQOgRw8nlO3G2zNxO3IGWeOIhuvqKFyoiAvefEnlcsK3GOjnb7GkxoZU
         jN7qhqK4I7uaJ9x+RoMTFIaXscnA24aclx/+lE/DLtIwbfh1mj8BJ7FaHlL8tYGzF4BA
         HzrnUiWHHluIJCEciOtMz4yMLsIccRVrPGo9w1dTBHbzp8BTsSxsRb5wNLb/CLHeBGoH
         sM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435683; x=1729040483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAxqxsiZEI5UhKg6mQ45OeLPjqDwtDP0T8PZqcd4lwY=;
        b=CcwAzhjVbyHiAyXln+pbra3MW2cn8gPOdFcNIiHQL147TaA5woLSskfl0e7un8H9tr
         brccwnXZOg+2AW+RnekUvp2+4OG8wni8W14VZmXlOlI6ETiwSIOW5DtOqDG6FkZbXQ7U
         d8hztREv7DX2H6NsjhGW8zCo9PYMpIFWM9ftjHs54C2KWddK7QfqqapCuD8H0SjwxNIf
         wx8XWZqv6uQJ63X4MNZ4A9tkDtEvueKJRn3+cv1ZvUCTK4flRHMQxmYmHUilQrkLaERb
         Xainesi0EsLawgh9sTGDJBCIxnZGzUvgAmQvlfa7Ty/xMMYJkEP6pQ7JnnYeUZGgTZr+
         JxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgtUSHpGHYP31oqmvFNvkwiz0xII+MdPGKXZfdjwkPjcZp0G1ed9wrR0koBVOIn5ICl+qGSyQpENnaVPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkKgTS12HDaHI5VLDKHaHbGn1afdZBjD+WAF8XnJLrmGKFyNE
	8g2EaP4Qu3HiDD9q/frQ+b+mrM5IjUWrSAGwgXva3X6rDryG1DR0JcD1PDZD8Ig=
X-Google-Smtp-Source: AGHT+IEPtQJlB+jS7QuqGv08fQY1XB3dSoaLMX8dWHnBD76wwgyZFaTvnOY3H1afxMvTBAYbw7SRxw==
X-Received: by 2002:a05:620a:40d0:b0:7af:cdf9:8c30 with SMTP id af79cd13be357-7b079551aa3mr105196285a.37.1728435682895;
        Tue, 08 Oct 2024 18:01:22 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75661426sm408144285a.88.2024.10.08.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 18:01:21 -0700 (PDT)
Date: Tue, 8 Oct 2024 21:01:10 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, rrichter@amd.com, terry.bowman@amd.com,
	dave@stgolabs.net
Subject: Re: [PATCH v2] cxl/core/port: defer endpoint probes when ACPI likely
 hasn't finished
Message-ID: <ZwXV1gPqO6RkrAW5@PC2K9PVX.TheFacebook.com>
References: <20241004212504.1246-1-gourry@gourry.net>
 <6700836317627_964f2294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <ZwCe23k_IDefi15j@PC2K9PVX.TheFacebook.com>
 <6705b4398f0d0_964f22949e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6705b4398f0d0_964f22949e@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Oct 08, 2024 at 03:37:45PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > On Fri, Oct 04, 2024 at 05:08:03PM -0700, Dan Williams wrote:
> > > Gregory Price wrote:
> > > > In cxl_acpi_probe, we add dports and uports to host bridges iteratively:
> > > > - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_dport);
> > > > - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_uport);
> > > > 
> > > > Simultaneously, as ports are probed, memdev endpoints can also be
> > > > probed. This creates a race condition, where an endpoint can perceive
> > > > its path to the root being broken in devm_cxl_enumerate_ports.
> > > > 
> > > > The memdev/endpoint probe will see a heirarchy that may look like:
> > > >     mem1
> > > >       parent => 0000:c1:00.0
> > > >         parent => 0000:c0:01.1
> > > > 	  parent->parent => NULL
> > > > 
> > > > This results in find_cxl_port() returning NULL (since the port hasn't
> > > > been associated with the host bridge yet), and add_port_attach_ep
> > > > fails because the grandparent's grandparent is NULL.
> > > > 
> > > > When the latter condition is detected, the comments suggest:
> > > >     /*
> > > >      * The iteration reached the topology root without finding the
> > > >      * CXL-root 'cxl_port' on a previous iteration, fail for now to
> > > >      * be re-probed after platform driver attaches.
> > > >      */
> > > > 
> > > > This case results in an -ENXIO; however, a re-probe never occurs. Change
> > > > this return condition to -EPROBE_DEFER to explicitly cause a reprobe.
> > > 
> > > Ok, thanks for the additional debug. Like we chatted on the CXL Discord
> > > I think this is potentially pointing to a bug in bus_rescan_devices()
> > > where it checks dev->driver without holding the lock.
> > > 
> > > Can you give this fix a try to see if it also resolves the issue?
> > > Effectively, cxl_bus_rescan() is always needed in case the cxl_acpi
> > > driver loads waaaay after deferred probing has given up, and if this
> > > works then EPROBE_DEFER can remain limited to cases where it is
> > > absolutely known that no other device_attach() kick is coming to save
> > > the day.
> > > 
> > 
> > Funny enough, not only did it not work, but now i get neither endpoint lol
> > 
> > $ ls /sys/bus/cxl/devices/
> > decoder0.0  decoder1.0  decoder2.0  decoder3.1  mem0  port1  port3  root0
> > decoder0.1  decoder1.1  decoder3.0  decoder4.0  mem1  port2  port4
> > 
> > w/ reprobe patch
> > 
> > # ls /sys/bus/cxl/devices
> > decoder0.0  decoder1.0  decoder2.0  decoder3.1  decoder5.0  decoder6.0  endpoint5  mem0  port1  port3  root0
> > decoder0.1  decoder1.1  decoder3.0  decoder4.0  decoder5.1  decoder6.1  endpoint6  mem1  port2  port4
> 
> Such a violent result is interesting! While I would have preferred an
> "all fixed!" version of "interesting", making something fail reliably and
> completely is at least indication that the starting point was more
> fragile than expected.
> 
> Now, I tried to get cxl_test to fail by probing memdevs asynchronously
> alongside the ACPI root driver. That did reveal a use-after-free bug
> when out-of-order shutdown causes some cleanup to be skipped, will send
> a separate fixup for that, but it failed to reproduce the bug you are
> seeing.
> 
> The incremental fix here, that applies on top of the device_attach()
> fixup, is to make sure that all cxl_port instances registered by
> cxl_acpi_probe() are active before cxl_bus_rescan() runs. That can only
> be guaranteed when the cxl_port driver is pre-loaded.
> 

:< unfortunately the result is... the same but also different? 

the worst kind of result

# ls /sys/bus/cxl/devices/
decoder0.0  decoder0.2  decoder2.0  decoder3.1  mem0  port1  port3  root0
decoder0.1  decoder1.0  decoder3.0  decoder4.0  mem1  port2  port4

apparently sometimes we get decoder0.2 and sometimes we get decoder1.1

after a reboot we get it the other way

# ls /sys/bus/cxl/devices/
decoder0.0  decoder0.2  decoder2.0  decoder3.1  mem0  port1  port3  root0
decoder0.1  decoder1.0  decoder3.0  decoder4.0  mem1  port2  port4

in my experimental kernel where everything "works" I get something like

# ls /sys/bus/cxl/devices/
dax_region0  decoder0.0  decoder1.0  decoder3.1  decoder5.1  endpoint5  mem1   port3    region1
dax_region1  decoder0.1  decoder2.0  decoder4.0  decoder6.0  endpoint6  port1  port4    region2
dax_region2  decoder0.2  decoder3.0  decoder5.0  decoder6.1  mem0       port2  region0  root0

which does not have decoder1.1 - but i haven't confirmed whether this is
consistent or not.  I don't know what causes 0.N vs 1.M, maybe you do?

but in the first result (past email) you can see the reprobe patch also generated
decoder1.1 instead of decoder0.2

probably not related, more fun side quests!

Regardless, the additional patch did not resolve the problem :<

> If you are running from an initial ram disk make sure cxl_port.ko is
> included there...
> 
> -- 8< --
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82b78e331d8e..432b7cfd12a8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -924,6 +924,13 @@ static void __exit cxl_acpi_exit(void)
>  
>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
>  subsys_initcall(cxl_acpi_init);
> +
> +/*
> + * Arrange for host-bridge ports to be active synchronous with
> + * cxl_acpi_probe() exit.
> + */
> +MODULE_SOFTDEP("pre: cxl_port");
> +
>  module_exit(cxl_acpi_exit);
>  MODULE_DESCRIPTION("CXL ACPI: Platform Support");
>  MODULE_LICENSE("GPL v2");

