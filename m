Return-Path: <linux-kernel+bounces-375849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499639A9BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3E32841AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB5186E40;
	Tue, 22 Oct 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvI+eLVa"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6EF176AA9;
	Tue, 22 Oct 2024 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583941; cv=none; b=h65B1+LCRZNNYZfJBYld8663A+bMQwhBgKmluBMiCjlGFWNGYa2T5ckqWlDjk8bgQsoc7DEqZVbIan8S+JqfsD2p3B6clIMA0wyidXdfaWK5tdFJNX1/mmSwnAn76H4XxcbOjfEhWhXdPgbWyt71L3pRsLaP8ps6k7vCOgTo9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583941; c=relaxed/simple;
	bh=v6GoBW4x1zQKBQSgQfnDERVvLEH6IHtSS+CwLXRVWpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2au8AsVufEsU50eou5qxo4g6JIsxtANjeuWrjOpgLkgkPB/2C+pIsh2wJGoeW1e5zXPTd12gvl3MfJijUaJAeehrErXwXUg+Y1HKgcpK8U/MlBi9pcbH7tgBVYQajG8L74qwgTIRFWyMvF0vJ/02P/oySEEvdVWl0HvZ2RkzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvI+eLVa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so3560597b3a.0;
        Tue, 22 Oct 2024 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729583939; x=1730188739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr9U5UefwWfBs0yg88gF6SYD9KhJ5/0kT72k1JCKjiw=;
        b=jvI+eLVafxxj1oCdt5KpLUJv3Or/nRLgajn8GIDzy0mJpwEOfgAlWl/ODOomNIxII7
         l1hgNmkSvIuTdDksDE/n6RlXz1IMEepzM5tRvehcFOSzVj2ibb0hqTfYIwqF44fDmrw6
         aaJJuKpQlgARa4WvtYve5pj1YyEM/MnCXj3OmWwJ1B5bkVJclru8DP1BQ4iUu52kzhNh
         a3V1lUj/SUKXP/Lv1/GOGGTOa8qcnMY3Zo+z4bRZYNEzBJQAewtjRHtVPc2W5wJa78JT
         ojyXNP8K8Di/d19ADPmqD/djHtff88OfJlGIJp1U60jdDBNmPbD1ds1bQs9F28+ozlyw
         kxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583939; x=1730188739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr9U5UefwWfBs0yg88gF6SYD9KhJ5/0kT72k1JCKjiw=;
        b=dg4uvRs0SIBsuk2/nh8r4lzs4xmO9jXLmZIEzt/vuznRyALoocE5OKC2jaMDuJauJ3
         Pz227PMv2l5yLQL+hUhNBrjpcboVteISN9p4w3slSQEKzylt4NUZgqTuGnQTgRwu24Yo
         +9UYsZjjji++03E+vAaYtqPjm5byT8XCkHWQU1rhDyAdQkihf46jRXrAa6O8zLjO3Vk7
         teCVjTCE9hsW7tCEx7vL/SeyY4ciSBUdCVInngDfirAJ2mt9yHX6ehxi2jMkWgMZOu6v
         PQZUyf+R0nOgMeHod89FG/AoXbg/pc7YuUQuhkvIMzGUeVhK7StkVI68jI4EyiEXSXpz
         9cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nqbu5ay+SL76YVdrtDqJU3fkWZnWlvdfq6Ys+6zqcGlyXTMcMaPrg5Z2cYsSc90L8gbtaWAPxYE0YaM=@vger.kernel.org, AJvYcCWrXJsV5hGqD0VO45QG5zeIrIUKmvL8uTw8CGAb8IGRDn6XhUO1BSSqf09hslZ5oDbsVDw8PnE1OHo3wW6J2cwxDxQ46w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ERqTqGl/omDSrEronOzIplWHzH9lGnLlOBFtyBgQ+EJ3Tzsi
	GGENKFQee111uEFUafqasoXWvM4NKbK5Yb8KFo1CjcxENp7ENIFk
X-Google-Smtp-Source: AGHT+IG7FHJc4l1kz3cncuyLwXYNQzPOhwfOC3yX1clvoK25mcuZp8tISjf3pSVWruW1/Wm2i3FBHg==
X-Received: by 2002:a05:6a00:3e20:b0:71e:7b8a:5953 with SMTP id d2e1a72fcca58-71ea339776dmr21081544b3a.24.1729583938502;
        Tue, 22 Oct 2024 00:58:58 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1356b7fsm4250039b3a.94.2024.10.22.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:58:57 -0700 (PDT)
Date: Tue, 22 Oct 2024 04:58:49 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 4/5] alienware-wmi: added autodetect_thermal_profile
 for devices with quirk_unknown
Message-ID: <lzdkadbm2mjf7n73lrw7ha3buhyhheqlxmuavhqbm3prtrjwws@jr3q2dec3e7y>
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081631.127333-3-kuurtb@gmail.com>
 <9d30b2ce-68e4-4080-9068-d1c0b5a59284@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d30b2ce-68e4-4080-9068-d1c0b5a59284@gmx.de>

On Sun, Oct 20, 2024 at 10:39:09PM +0200, Armin Wolf wrote:
> Am 17.10.24 um 10:16 schrieb Kurt Borja:
> 
> > Added autodetect_thermal_profile for devices with quirk_unknown.
> > Autodetection is done through basic conditions most devices with WMAX's
> > thermal interface meet. Function exits returning 0 in case of errors.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > 
> > ---
> > I apologize for the late inclusion. This feature can extend support to
> > many devices without having to list them in alienware_quirks.
> > 
> > The conditions for selecting the automatic thermal profile are based on
> > observations on a lot of *issues* in AWCC open source alternatives.
> > 
> > I observed only Dell's G-Series laptops have WMAX_THERMAL_BALANCED
> > avaliable and when it's present none of the other profiles are
> > avaliable, except for GMODE. When a model has USTT profiles avaliable
> > usually they have all USTT profiles avaliable, except for cool on mostly
> > Alienware devices.
> > 
> > I made another implementation of this function, brute-forcing operation
> > 0x03 of Thermal_Information, which is the operation that varies the most
> > across models. I found the implementation too cumbersome to include in
> > this series, but it could potentially extend support of this driver to
> > all posible devices with this interface automatically.
> 
> I like this patch, automatic configuration is always a nice feature.
> 
> Please add support for operation 0x03, this way the driver can work automatically
> without users having to submit patches adding quirks for their machines.
> 
> Maybe you can use an array for storing the supported thermal mode ids, like this:
> 
> enum thermal_modes = {
> 	THERMAL_MODE_QUIET,
> 	...
> 	THERMAL_MODE_LOW_POWER,
> 	THERMAL_MODE_MAX
> };
> 
> const enumplatform_profile_option  thermal_mode_to_platform_profile[THERMAL_MODE_MAX] = {
> 	[THERMAL_MODE_QUIET] =PLATFORM_PROFILE_QUIET, ...
> };
> 
> const enumthermal_modes platform_profile_to_thermal_mode[PLATFORM_PROFILE_LAST] = {
> 	[PLATFORM_PROFILE_LOW_POWER] = THERMAL_MODE_LOW_POWER, ...
> };
> 
> 
> u8 thermal_modes[THERMAL_MODE_MAX] = {};
> 
> for (int i = 0; i < THERMAL_MODE_MAX; i++) {
> 	thermal_modes[i] = call_operation_3(0x06 + i);
> 	// TODO: Error handling
> 	if (thermal_modes[i] == 0xFFFFFFFF)
> 		continue;
> 
> 	set_bit(supported_profiles, thermal_mode_to_platform_profile[i]);
> }
> 
> then you can use platform_profile_to_thermal_mode[] when setting the platform profile
> and thermal_mode_to_platform_profile[] when getting the platform profile.
> I will leave it up to you on how to handle the existence of GMode.
> 
> This of course is only a rough idea, you can change anything you want in the above pseudo-code.

Thank you. I successfully added support for operation 0x03 with this
pattern. I'll comment on details on v7. 

Now that we have automatic detection, I think we should do automatic
detection on all models, meaning that 3/5 and 4/5 should be squashed
together, because code corresponding to quirk profile configuration now
seems unnecesary.

I'll wait for your advice before submitting v7.

Thank you, 
Kurt

> 
> Thanks,
> Armin Wolf
> 
> > 
> > Another possibility is just including every device I observed into
> > alienware_quirks, which I can do but I want to know your opinion first.
> > ---
> >   drivers/platform/x86/dell/alienware-wmi.c | 42 +++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 37a898273..a11ff4851 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -30,8 +30,11 @@
> >   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> >   #define WMAX_METHOD_THERMAL_INFORMATION	0x14
> >   #define WMAX_METHOD_THERMAL_CONTROL	0x15
> > +#define WMAX_METHOD_GMODE_STATUS	0x25
> > 
> > +#define WMAX_ARG_GET_DEFAULT_PROF	0x0A
> >   #define WMAX_ARG_GET_CURRENT_PROF	0x0B
> > +#define WMAX_ARG_GET_GMODE_STATUS	0x02
> > 
> >   #define WMAX_FAILURE_CODE		0xFFFFFFFF
> > 
> > @@ -968,6 +971,42 @@ static int thermal_profile_set_ustt(struct platform_profile_handler *pprof,
> >   	return 0;
> >   }
> > 
> > +static int autodetect_thermal_profile(void)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 default_profile;
> > +	u32 gmode;
> > +
> > +	in_args = WMAX_ARG_GET_DEFAULT_PROF;
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_INFORMATION, &default_profile);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return 0;
> > +
> > +	in_args = WMAX_ARG_GET_GMODE_STATUS;
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_GMODE_STATUS, &gmode);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return 0;
> > +
> > +	if (default_profile == WMAX_THERMAL_BALANCED && gmode == 1) {
> > +		quirks->thermal = WMAX_THERMAL_TABLE_SIMPLE;
> > +		quirks->gmode = 1;
> > +		return 0;
> > +	}
> > +
> > +	if (default_profile == WMAX_THERMAL_USTT_BALANCED)
> > +		quirks->thermal = WMAX_THERMAL_TABLE_USTT;
> > +
> > +	if (gmode == 0 || gmode == 1)
> > +		quirks->gmode = 1;
> > +
> > +	return 0;
> > +}
> > +
> >   static int create_thermal_profile(void)
> >   {
> >   	pp_handler.profile_get = thermal_profile_get;
> > @@ -1050,6 +1089,9 @@ static int __init alienware_wmi_init(void)
> >   			goto fail_prep_deepsleep;
> >   	}
> > 
> > +	if (interface == WMAX && quirks == &quirk_unknown)
> > +		autodetect_thermal_profile();
> > +
> >   	if (quirks->thermal > 0) {
> >   		ret = create_thermal_profile();
> >   		if (ret)

