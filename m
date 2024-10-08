Return-Path: <linux-kernel+bounces-355832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7F19957B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FA21F26997
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC225213EE2;
	Tue,  8 Oct 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th/O9M4n"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853471E0DCC;
	Tue,  8 Oct 2024 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416064; cv=none; b=ErE2YLUhCsnSPgMdvbOZZWCmvImSN/2BZIMizsotQLdLINHAyPBSBmdg3feAK2Fg5c5KB8Fl+Edbwxxf9NJ1f/0KkyUUOj3nF88VLXjD5ST9NYh+KfRqmy3aCvEPVPCS2dPoDI/sfJhVJEwY9lgvpvXe1GXNAKSonAoLH71CjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416064; c=relaxed/simple;
	bh=Rd9boGe0nKC89uzfPt+xG4ylB9eUDiqeBbQyLUB9xs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twllq02VqekheaUm61BywRyGi6O7xoFwliuulzCppaioPWRkU1Imqjy3q1Pu29vhWucqzoE/l5TlJlkwWF2OmmVtaSddIydKZOl5v7ymVKKqZUfy2fUjvPPzhLYD91DczRV02hNNm60k64BuKjVmYl/nJJp7Qbp2xO5k/VeWHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th/O9M4n; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso4109947a12.0;
        Tue, 08 Oct 2024 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728416062; x=1729020862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmsAVkNPAVmhhcMAOduEmXLVJB9Wtdi3bsvXHQgiGSM=;
        b=Th/O9M4nIAWJy6tMH00s4ELyvXLAkLfB8Zbxz9U6Uzn784DJOWvrnfPxyqnbiKORMv
         /HCYG/VhMO3KdxciQQ8gXfZZI8p7EpJ7uZ2CltoEiMhqxC5Ry3PEOEQrHjX5XqZhpnLn
         L4Qhjpfa9u8QuJQ0QuQCi6Pt3AF8GeCv24LghqU/hTmyf7GdEg8uJXbMWB1y7IhMJaEp
         g6P7uespDoh60e7wma+rcKcWhYeV3YCsVgWO4qDQNqvyvEPQfKrWSBFhY7875+1AFYPg
         XuhSDgqkgnySUg0W+5O036gI0VTlndU3BamoX+P4bFZCVFbEuT1mBXA11UhZdL16cpkv
         H7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416062; x=1729020862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmsAVkNPAVmhhcMAOduEmXLVJB9Wtdi3bsvXHQgiGSM=;
        b=D72o5RWf+zraOyKSqifmR9TW3A5xgN7O8CY0ZN47xEVMMRpoh6JM8ooDYGj+HL91Bn
         VTAQvSNwWwiakKvIkvvU3wrwvFngQMh5lVAT32Gc0P8J6dxN6wmvASxEQK3f/5IkSdNy
         P1yFaO1gj6MxOgn42nCE27HaaQxBxYziVB6Y2iYzMW5FkNsslb7ZaSjGDfU5fXaXS4Sw
         fOBDtqx+P90W8uHRU+j9HDS6Zpah3dU83ZAo5XtyzQs2fUW2iDQTeFTEO81lTywpksnc
         9hka0HykXsgY1ibIgU9dIBmA5DKv079RMEdZYbNUtPoS309PCRnqT8lcjI1ZYbI0LcJI
         SPCA==
X-Forwarded-Encrypted: i=1; AJvYcCUYndY4P0ZytBDHZefDfROGNPuysAAqxk/K+9WSo7LK5XJYS4LcuqkjwlYIdeSsUTtUdIkXIGb7sjTFlNtxVQtSo4PtMA==@vger.kernel.org, AJvYcCWzHd5995r9kPlij751XrNHqCTZ7jTsdUMyAuYzpUIalty492YcdyMXp+f10IqTFskXGTJPPDwBLynWK4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PbQzl8sfq52uklYuTGH0Cm/qqkglrlunn/rtyRPvSJ63jiu+
	JCYBRsN2ruKU6oIzGB0OiePHe5lUxZxvxT9jovyWezRM1CTg0nfJhXLZYpUQ
X-Google-Smtp-Source: AGHT+IHo7pOmCq1/90Q5LrgqrDPX0swDsHA5a36s+vA8hQNzo5ZhaDKuQk+b5RQUgRAOj3oV8yHvxA==
X-Received: by 2002:a05:6a20:559f:b0:1cf:53ea:7fbc with SMTP id adf61e73a8af0-1d8a3bf042fmr44505637.18.1728416061760;
        Tue, 08 Oct 2024 12:34:21 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c379efsm6054858a12.62.2024.10.08.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 12:34:21 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	kuurtb@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] alienware-wmi: Dell AWCC platform_profile support
Date: Tue,  8 Oct 2024 16:34:18 -0300
Message-ID: <20241008193418.34573-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <4c2c29ad-924e-876b-70c3-256f4865fc88@linux.intel.com>
References: <4c2c29ad-924e-876b-70c3-256f4865fc88@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed.

> > +static int platform_profile_get(struct platform_profile_handler *pprof,
> > +				enum platform_profile_option *profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args = 0x0B;
> 
> Use a named define instead of a magic number.
> 

Done

> > +	u32 out_data;
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_INFORMATION, (u32 *) &out_data);
> 
> Casting to the same type??
> 
> Also, alienware_wmax_command() inputs int * which makes the cast look even 
> more odd?!?
> 
> I can see there are pre-existing bogus (u32 *) casts too which would be 
> nice to clean up in another patch.
> 

Yes I thought it was odd but added them just in case. I can submit a
patch cleaning those up after this one.

> > +
> > +	if (ACPI_FAILURE(status) || out_data < 0)
> 
> u32 cannot be < 0??
> 
> Is this an indication of a problem in the error handling?
> 

Yes it was, thank you for catching it.

> > +		return -EOPNOTSUPP;
> > +
> > +	switch (out_data) {
> > +	case WMAX_THERMAL_LOW_POWER:
> > +		*profile = PLATFORM_PROFILE_LOW_POWER;
> > +		break;
> > +	case WMAX_THERMAL_QUIET:
> > +		*profile = PLATFORM_PROFILE_QUIET;
> > +		break;
> > +	case WMAX_THERMAL_BALANCED:
> > +		*profile = PLATFORM_PROFILE_BALANCED;
> > +		break;
> > +	case WMAX_THERMAL_BALANCED_PERFORMANCE:
> > +		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> > +		break;
> > +	case WMAX_THERMAL_PERFORMANCE:
> > +	case WMAX_THERMAL_GMODE:
> > +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> > +		break;
> > +	default:
> > +		return -ENODATA;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +#define SET_MASK(prof) ((prof << 8) | 1)
> 
> Name these with two defines. One define for naming that magic 1 and 
> another for the profile field, use GENMASK() + FIELD_PREP() for it.
> 
> Also, there's no need for this to be macro so change it into a static 
> function.
> 

Done.

> > +static int platform_profile_set(struct platform_profile_handler *pprof,
> > +				enum platform_profile_option profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > +		in_args = SET_MASK(WMAX_THERMAL_LOW_POWER);
> > +		break;
> > +	case PLATFORM_PROFILE_QUIET:
> > +		in_args = SET_MASK(WMAX_THERMAL_QUIET);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED:
> > +		in_args = SET_MASK(WMAX_THERMAL_BALANCED);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +		in_args = SET_MASK(WMAX_THERMAL_BALANCED_PERFORMANCE);
> > +		break;
> > +	case PLATFORM_PROFILE_PERFORMANCE:
> > +		in_args = SET_MASK(WMAX_THERMAL_PERFORMANCE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL, (u32 *) &out_data);
> 
> Cast to same type.
> 
> > +
> > +	if (ACPI_FAILURE(status) || out_data < 0)
> 
> u32 cannot be < 0.
> 
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> > +
> > +static int gmode_platform_profile_set(struct platform_profile_handler *pprof,
> > +				      enum platform_profile_option profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > +		in_args = SET_MASK(WMAX_THERMAL_LOW_POWER);
> > +		break;
> > +	case PLATFORM_PROFILE_QUIET:
> > +		in_args = SET_MASK(WMAX_THERMAL_QUIET);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED:
> > +		in_args = SET_MASK(WMAX_THERMAL_BALANCED);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +		in_args = SET_MASK(WMAX_THERMAL_BALANCED_PERFORMANCE);
> > +		break;
> > +	case PLATFORM_PROFILE_PERFORMANCE:
> > +		in_args = SET_MASK(WMAX_THERMAL_GMODE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> 
> > +					WMAX_METHOD_THERMAL_CONTROL, (u32 *) &out_data);
> > +	if (ACPI_FAILURE(status) || out_data < 0)
> 
> The same two issues here with the types.
> 
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> > +
> > +static int create_platform_profile(void)
> > +{
> > +	pp_handler.profile_get = platform_profile_get;
> > +
> > +	if (quirks->gmode > 0)
> > +		pp_handler.profile_set = gmode_platform_profile_set;
> > +	else
> > +		pp_handler.profile_set = platform_profile_set;
> > +
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> > +
> > +	return platform_profile_register(&pp_handler);
> > +}
> > +
> >  static int __init alienware_wmi_init(void)
> >  {
> >  	int ret;
> > @@ -807,6 +987,12 @@ static int __init alienware_wmi_init(void)
> >  			goto fail_prep_deepsleep;
> >  	}
> >  
> > +	if (quirks->thermal > 0) {
> > +		ret = create_platform_profile();
> > +		if (ret)
> > +			goto fail_prep_thermal_profile;
> > +	}
> > +
> >  	ret = alienware_zone_init(platform_device);
> >  	if (ret)
> >  		goto fail_prep_zones;
> > @@ -817,6 +1003,7 @@ static int __init alienware_wmi_init(void)
> >  	alienware_zone_exit(platform_device);
> >  fail_prep_deepsleep:
> >  fail_prep_amplifier:
> > +fail_prep_thermal_profile:
> >  fail_prep_hdmi:
> >  	platform_device_del(platform_device);
> >  fail_platform_device2:
> > @@ -836,6 +1023,7 @@ static void __exit alienware_wmi_exit(void)
> >  		remove_hdmi(platform_device);
> >  		platform_device_unregister(platform_device);
> >  		platform_driver_unregister(&platform_driver);
> > +		platform_profile_remove();
> 
> IIRC, I once checked that this will lead to a crash if it wasn't created 
> first (which in your driver isn't always the case).
> 

Fixed.

> -- 
>  i.

Thank you for your feedback. I will submit v3 with the corrections soon.

Kurt

