Return-Path: <linux-kernel+bounces-414590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FC59D2AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7243B2C7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7F1D0786;
	Tue, 19 Nov 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDYh1CMR"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004E1D0143;
	Tue, 19 Nov 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032700; cv=none; b=Z0GAaziQQ9XVuWjOOZamTe3VlOfbRzdmoVOpwI7pKdelsrn/8BspJUpLt99QSmnpbqyZn1qLIGliwc0QasobElweH4r59HZSMh4TeHR6+mwUMb22erVktAMCdPucmJIH6CDb13hU6Afrwreo8NubCEVN1lt8ADF1EVsuxdfVrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032700; c=relaxed/simple;
	bh=Ky5jE0RdvB9YboKutJBgcm7KGaH4EImzaLapnAuUoP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY2Axd48TSr8yJvjlUhxjhYC0LlKkjtbFJeWrgAl/MaasLbjEvoC3i8L72wOHYvhyZkg8Zz1gpV4uBlpDI1hBMTjTZCXJvahn69boQULf/x9KHFZh9TmVd2anrnzVuJNI4Lq6ZmroC3POY+2BDUIW1SHdNp/Sn1GdCSFDegtdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDYh1CMR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f43259d220so2325341a12.3;
        Tue, 19 Nov 2024 08:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732032698; x=1732637498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eaCuzDaC/1NRzkvx8qhgHB8pDWVhh+Ejrmx1xbSM6w=;
        b=EDYh1CMRS2ranAm5OLKHDigZ8Qp/zlXGBswvR3pBu3B4QCJmLnEd2b2Mv9mz7lFLhG
         ViqClzkOSNNaTNgyAA/A51qhui9m94KZwOdPRPI202fNnS9vsedNi+M7ooWSbFWerdL3
         rSSdqWtm2F2jiNaRpKrwv/hoBnH8kAf9WZQUTVyf8szEDNhReFp+SJ6muHXMthTwXzWI
         M/awoYcl7h4luz0Q9YbHE8NsjEpNrpV9Bmu9pjQ7XT4T5azWGM5ZMPBVD1E3S12jggUw
         bR+y+XwORH/ZkS/HEPAAoC7HDpqv65OhugWPIw82tjWEwJylHVLHGAfORU4btSME2+ar
         n35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732032698; x=1732637498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eaCuzDaC/1NRzkvx8qhgHB8pDWVhh+Ejrmx1xbSM6w=;
        b=d8NBbdCWom8Uuh3HSD1IK5o/hq1hfvuu5vgN74nk6Mg336xWqgFqN+dXGx+jx/pClJ
         XHeVNe7HwTElJVSPUca9D28l5C20p+LrXRzAS+dE1OiCyer3JF9kUpVgAK34OInxI6/b
         GDslqhJkK1HJ06+1ddP2hrSBOtsoqRVRomQPEjn4M3nw269wYrES0NDdIM+pC6paCXbu
         7lS8Hm/CNPEAK9RO1lnw16JV5bT139wBhXF3BmH7FzAWC9ll1QB0uq6RNjESz621lWEd
         pJWjPNXLqPLe8i6vGD7MXPRTSCzU7YBRwXp4qTvQJZkkj6XYFKBhQMhHIPaNIGaYumZ9
         BA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUfoOTV22VhLV+XvCFVklDrIGRp7PJMkDL/OndD9c9wzKtoQfUyH1v7FTNe+m1roxGDsMzr1svlKocTuHKdQlSGbskhYg==@vger.kernel.org, AJvYcCVW/iTwgME00Q6aqxg0S0eAdx3idpUyjm/5u5irFQ+AKdPqr2/fgOumRiSZn285LDHmjVWW4jnbVQgoIEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEevK2mgPEFGoE+vv3pZ8vTg7zp3Z7lQ2ixKRajVwck8ti+8ZV
	zLMgpWueN2KyWpt+DSf9pwl+M6aZ41k8oXGZ6CRXDC7HSlGx2Ywh
X-Google-Smtp-Source: AGHT+IHbUDcukoHzUI4MFVnxEupgSyUMavc6tU1MCs0d9tBaMisv+F6TMLgbkwKyDJyUOuJuC/iMXw==
X-Received: by 2002:a05:6a20:d049:b0:1db:e96f:4472 with SMTP id adf61e73a8af0-1dc90bd150fmr28766213637.31.1732032697987;
        Tue, 19 Nov 2024 08:11:37 -0800 (PST)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dd3f4csm7755964a12.75.2024.11.19.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:11:37 -0800 (PST)
Date: Tue, 19 Nov 2024 13:11:34 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH 4/5] alienware-wmi: Fix module init error handling
Message-ID: <hjxcj4nlg2ikt2i64slk7uhx2i54iab76oqhy52iiho32hqudy@6fo7p7klxihu>
References: <20241119043523.25650-1-kuurtb@gmail.com>
 <e02d8687-b5b8-4970-8bd9-ad3ad9549fc0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02d8687-b5b8-4970-8bd9-ad3ad9549fc0@amd.com>

On Tue, Nov 19, 2024 at 10:06:48AM -0600, Mario Limonciello wrote:
> On 11/18/2024 22:35, Kurt Borja wrote:
> > Propagate led_classdev_register return value in case of error.
> > Call led_classdev_unregister in case sysfs_create_group fails.
> > 
> > If alienware_zone_init fails, alienware_zone_exit should not be called
> > because the latter unregisters/removes the led class and the sysfs
> > group, which may not be registered/created if the former failed
> > prematurely.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >   drivers/platform/x86/dell/alienware-wmi.c | 16 +++++++++++++---
> >   1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 980ffc545093..44f1f7b57d0a 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -628,6 +628,7 @@ static int alienware_zone_init(struct platform_device *pdev)
> >   	char *name;
> >   	struct device_attribute *zone_dev_attrs;
> >   	struct attribute **zone_attrs;
> > +	int ret;
> >   	if (interface == WMAX) {
> >   		lighting_control_state = WMAX_RUNNING;
> > @@ -675,9 +676,19 @@ static int alienware_zone_init(struct platform_device *pdev)
> >   	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
> >   	zone_attribute_group.attrs = zone_attrs;
> > -	led_classdev_register(&pdev->dev, &global_led);
> > +	ret = led_classdev_register(&pdev->dev, &global_led);
> 
> How about switching to the devm version of led_classdev_register instead so
> you can keep a simpler cleanup?

Sure! I missed that function.

> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = sysfs_create_group(&pdev->dev.kobj, &zone_attribute_group);
> > +	if (ret < 0)
> > +		goto fail_prep_zone_group;
> > +
> > +	return 0;
> > -	return sysfs_create_group(&pdev->dev.kobj, &zone_attribute_group);
> > +fail_prep_zone_group:
> > +	led_classdev_unregister(&global_led);
> > +	return ret;
> >   }
> >   static void alienware_zone_exit(struct platform_device *dev)
> > @@ -1223,7 +1234,6 @@ static int __init alienware_wmi_init(void)
> >   	return 0;
> >   fail_prep_zones:
> > -	alienware_zone_exit(platform_device);
> >   	remove_thermal_profile();
> >   fail_prep_thermal_profile:
> >   fail_prep_deepsleep:
> 

