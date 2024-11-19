Return-Path: <linux-kernel+bounces-414585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468849D2A67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0091D1F216BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4411CF7D6;
	Tue, 19 Nov 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SabAcmey"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFC3C463;
	Tue, 19 Nov 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032176; cv=none; b=pG8XRPfK0g1R+c1UGpxi0dnPFY/El/8rszcFa0PJG6d7o1RiGbcbLxvO32P6Lo43KgUg583VQdBiWoOFPx3p+0ge6uIkN+5dIqcWiqqOIwW68SYXH/wVX2MvEr0psTuPmyE/c9j27SOOSsDX0sxNTx6sTakE4hu9wxanR1kNkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032176; c=relaxed/simple;
	bh=PMYFSJUT1pi6Fr8Vig3d+ug0BvX9b/ClH1Umr5O9ihg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTnUgL1uv1LvH2A1Cs+gawfUhAx2UPmO12pcj8b8BbGtcuxnSzTbZWWL3ERU21XxGEu6VfMbjq+W8heJs4FFdO7KyI8pPmawSxXVIg7Ui2cKozt1TZXU4FmNtOPKhjRVrKSopdYKmllchPeQ8YbFq9Rdw9MnJn8nthd+akzlPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SabAcmey; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbcd71012so37138055ad.3;
        Tue, 19 Nov 2024 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732032174; x=1732636974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wsX4cBQyLupu/44wKL56m7/Ymw1x0fn7GLe6kacIQ28=;
        b=SabAcmeyo5dGu5Q9hsHgkODbVn7u4RYYv5cfeHYHqewu5I/W0QvvciqVZcAtK9qw4b
         O8AexJfMtldZKEKPflsjQcW0BZut9+5W60OssZDP8ANtbzlu9e5X4n/O3CNZ51khnAo3
         23eLNd9dGFm220Jsnpvyp/4kwmXBGfUgM0avc/kMr9gvsg8o+d4RnLXLQIrPwYNJ0dJ+
         w7XN9mKUrl1JLSDJziGnk5Xnf2in055usahquqHLh/Lj7QfnzULL77j2A5fcMCpXLSvt
         Hbwu9kH7HXEC9Wm15JDmlQVA1+bm1uFlvdsiS6GdEm6Od6vQQ4FIMKSkpuKorRQAQVOt
         eKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732032174; x=1732636974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsX4cBQyLupu/44wKL56m7/Ymw1x0fn7GLe6kacIQ28=;
        b=ebZfyoRE/S0UZrV/6ZUUYWRTAyD4gJnPN5UjqEnUCvb7mGZe1z7AB+PgeNa0vxwiwC
         /rOKNeF8bPjCKC0LsZBhoLmnGSo2FtZbhzpnqyq7nvxcSaqRqBEzkXAryDXKs1TEUChj
         s1eUHAbQGpa9/ftUd2TxwZxLRjZUtkhF50Qv6/ayVSAyIVnmFHrjv2I7gZ7xNqOxt+hm
         yBXpus03L8Io/UjVtdgEp5fBueuUhJQRXfU7dCv6X3Q2nTUF5deVu9Pnx9XDt8uaSAoy
         m5CmNeOToBDPpc4N6Kp4Hsg6XP2U6DB8DZw4pQhJlELua3OpMQ6J0el3gjsMn/UKqhGz
         H77Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5ErWsz82yprM135OpXQfUmUTA4bMxT2ioHrA0VymrAyYELJNLl0xaDvEL0N43a0YHBBrrclk2t2N1rQA=@vger.kernel.org, AJvYcCXIday0s/seWsOmRnSgkFAoGym0qMzDivcS9dxpfzD4qZzB+wT38c9cQ9iR+fsETYi675xAkdh8NiVCaKUnbVet5EOxLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkreozhW5bu88PlIgf6mHvOZ4UwpyBoKxGb/pGgcOeT9wSWYl
	YrmWxuJyOGFNr9JyiEv4RPCxsXuyz36ZXe9IrUvDDyKCDeZshih740Aao+p/
X-Google-Smtp-Source: AGHT+IHLhf92WHo2Vyab0wPYnzl0RIw4tk4rJvVkSrTa6g+7PHtw1bZ1MVQlBD3U81FkFLVRMcnNpw==
X-Received: by 2002:a17:903:944:b0:211:eb15:9b73 with SMTP id d9443c01a7336-211eb159ca2mr195260755ad.26.1732032173567;
        Tue, 19 Nov 2024 08:02:53 -0800 (PST)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e8ad1sm8285757b3a.168.2024.11.19.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:02:53 -0800 (PST)
Date: Tue, 19 Nov 2024 13:02:49 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [PATCH 5/5] alienware-wmi: Improves sysfs groups creation
Message-ID: <mfsvtwib6o4jom5jafqennrlzbok3fqfdxq2pwpcifu72div5w@cbocomkua2vy>
References: <20241119043534.25683-1-kuurtb@gmail.com>
 <6705ecb2-96df-60f0-0e06-90ed4d8554ab@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6705ecb2-96df-60f0-0e06-90ed4d8554ab@linux.intel.com>

On Tue, Nov 19, 2024 at 10:40:50AM +0200, Ilpo Järvinen wrote:
> On Tue, 19 Nov 2024, Kurt Borja wrote:
> 
> > Devices with hdmi_mux, amplifier or deepslp quirks create a sysfs group
> > for each available feature. To accomplish this, helper create/remove
> > functions were called on module init, but they had the following
> > problems:
> > 
> >  - Create helpers called remove helpers on failure, which in turn tried
> >    to remove the sysfs group that failed to be created
> >  - If group creation failed mid way, previous successfully created groups
> >    were not cleaned up
> >  - Module exit only removed hdmi_mux group
> > 
> > To improve this, drop all helpers in favor of two helpers that make use
> > of sysfs_create_groups/sysfs_remove_groups to cleanly create/remove
> > groups at module init/exit.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> > 
> > I have a question. Do the created sysfs groups get removed when their
> > kobj reference count goes to 0? I ask because I want to know if this is
> > a bug fix.
> > 
> > ---
> >  drivers/platform/x86/dell/alienware-wmi.c | 105 ++++++++--------------
> >  1 file changed, 36 insertions(+), 69 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 44f1f7b57d0a..e9ed2089cba0 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -410,8 +410,10 @@ struct wmax_u32_args {
> >  	u8 arg3;
> >  };
> >  
> > +
> >  static struct platform_device *platform_device;
> >  static struct platform_zone *zone_data;
> > +const struct attribute_group *wmax_groups[4];
> >  static struct platform_profile_handler pp_handler;
> >  static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
> >  
> > @@ -810,22 +812,6 @@ static const struct attribute_group hdmi_attribute_group = {
> >  	.attrs = hdmi_attrs,
> >  };
> >  
> > -static void remove_hdmi(struct platform_device *dev)
> > -{
> > -	if (quirks->hdmi_mux > 0)
> > -		sysfs_remove_group(&dev->dev.kobj, &hdmi_attribute_group);
> > -}
> > -
> > -static int create_hdmi(struct platform_device *dev)
> > -{
> > -	int ret;
> > -
> > -	ret = sysfs_create_group(&dev->dev.kobj, &hdmi_attribute_group);
> > -	if (ret)
> > -		remove_hdmi(dev);
> > -	return ret;
> > -}
> > -
> >  /*
> >   * Alienware GFX amplifier support
> >   * - Currently supports reading cable status
> > @@ -864,22 +850,6 @@ static const struct attribute_group amplifier_attribute_group = {
> >  	.attrs = amplifier_attrs,
> >  };
> >  
> > -static void remove_amplifier(struct platform_device *dev)
> > -{
> > -	if (quirks->amplifier > 0)
> > -		sysfs_remove_group(&dev->dev.kobj, &amplifier_attribute_group);
> > -}
> > -
> > -static int create_amplifier(struct platform_device *dev)
> > -{
> > -	int ret;
> > -
> > -	ret = sysfs_create_group(&dev->dev.kobj, &amplifier_attribute_group);
> > -	if (ret)
> > -		remove_amplifier(dev);
> > -	return ret;
> > -}
> > -
> >  /*
> >   * Deep Sleep Control support
> >   * - Modifies BIOS setting for deep sleep control allowing extra wakeup events
> > @@ -942,22 +912,6 @@ static const struct attribute_group deepsleep_attribute_group = {
> >  	.attrs = deepsleep_attrs,
> >  };
> >  
> > -static void remove_deepsleep(struct platform_device *dev)
> > -{
> > -	if (quirks->deepslp > 0)
> > -		sysfs_remove_group(&dev->dev.kobj, &deepsleep_attribute_group);
> > -}
> > -
> > -static int create_deepsleep(struct platform_device *dev)
> > -{
> > -	int ret;
> > -
> > -	ret = sysfs_create_group(&dev->dev.kobj, &deepsleep_attribute_group);
> > -	if (ret)
> > -		remove_deepsleep(dev);
> > -	return ret;
> > -}
> > -
> >  /*
> >   * Thermal Profile control
> >   *  - Provides thermal profile control through the Platform Profile API
> > @@ -1165,6 +1119,34 @@ static void remove_thermal_profile(void)
> >  		platform_profile_remove();
> >  }
> >  
> > +static int __init create_wmax_groups(struct platform_device *pdev)
> > +{
> > +	int no_groups = 0;
> > +
> > +	if (quirks->hdmi_mux) {
> > +		wmax_groups[no_groups] = &hdmi_attribute_group;
> > +		no_groups++;
> > +	}
> > +
> > +	if (quirks->amplifier) {
> > +		wmax_groups[no_groups] = &amplifier_attribute_group;
> > +		no_groups++;
> > +	}
> > +
> > +	if (quirks->deepslp) {
> > +		wmax_groups[no_groups] = &deepsleep_attribute_group;
> > +		no_groups++;
> > +	}
> > +
> > +	return no_groups > 0 ? device_add_groups(&pdev->dev, wmax_groups) : 0;
> 
> Couldn't these use .dev_groups and .is_visible?

You're right, I will use this instead!

> 
> -- 
>  i.
> 
> 
> > +}
> > +
> > +static void __exit remove_wmax_groups(struct platform_device *pdev)
> > +{
> > +	if (!wmax_groups[0])
> > +		device_remove_groups(&pdev->dev, wmax_groups);
> > +}
> > +
> >  static int __init alienware_wmi_init(void)
> >  {
> >  	int ret;
> > @@ -1203,23 +1185,9 @@ static int __init alienware_wmi_init(void)
> >  		goto fail_platform_device1;
> >  	}
> >  
> > -	if (quirks->hdmi_mux > 0) {
> > -		ret = create_hdmi(platform_device);
> > -		if (ret)
> > -			goto fail_prep_hdmi;
> > -	}
> > -
> > -	if (quirks->amplifier > 0) {
> > -		ret = create_amplifier(platform_device);
> > -		if (ret)
> > -			goto fail_prep_amplifier;
> > -	}
> > -
> > -	if (quirks->deepslp > 0) {
> > -		ret = create_deepsleep(platform_device);
> > -		if (ret)
> > -			goto fail_prep_deepsleep;
> > -	}
> > +	ret = create_wmax_groups(platform_device);
> > +	if (ret)
> > +		goto fail_prep_groups;
> >  
> >  	if (quirks->thermal) {
> >  		ret = create_thermal_profile();
> > @@ -1236,9 +1204,8 @@ static int __init alienware_wmi_init(void)
> >  fail_prep_zones:
> >  	remove_thermal_profile();
> >  fail_prep_thermal_profile:
> > -fail_prep_deepsleep:
> > -fail_prep_amplifier:
> > -fail_prep_hdmi:
> > +	remove_wmax_groups(platform_device);
> > +fail_prep_groups:
> >  	platform_device_unregister(platform_device);
> >  fail_platform_device1:
> >  	platform_driver_unregister(&platform_driver);
> > @@ -1251,7 +1218,7 @@ module_init(alienware_wmi_init);
> >  static void __exit alienware_wmi_exit(void)
> >  {
> >  	alienware_zone_exit(platform_device);
> > -	remove_hdmi(platform_device);
> > +	remove_wmax_groups(platform_device);
> >  	remove_thermal_profile();
> >  	platform_device_unregister(platform_device);
> >  	platform_driver_unregister(&platform_driver);
> > 
> 

