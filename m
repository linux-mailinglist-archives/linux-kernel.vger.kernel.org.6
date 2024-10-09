Return-Path: <linux-kernel+bounces-357364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9806E997063
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F4D1C221C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0C1F8F1B;
	Wed,  9 Oct 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpMHk/Fs"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326201DF25B;
	Wed,  9 Oct 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488375; cv=none; b=dh6n8chfBVxYdL4dYy1r3XuYfAlZVOr4qkOZWmj/7LwxpEYW/IXl5Go6ks7G9hTe/n6oG2NVtq6SrpEPBRKMq5tzq7Y07esSMujqXh8pwpFhTTrZdTXEuri2TUQXoeN+SOHvagNqiZjVb6HQ1gUd0gyG6ucZFfzlKnHVqUV7zTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488375; c=relaxed/simple;
	bh=DuHafjNkOMrLyZeViffEQgx9aLWb5sOwVL6EB1Bmajs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkO5r69THjH4ePRGlBJV6m2b9gerbSaD+mvNeF88I6pZsFXGjcEUsrbjPPbbssImg90kQ9tDFPSCw6TCfab6tUHOg4/Dv2Xf8ExyhuQdmDUWuy6bq8G72udkpSjK4X6fJ3VXvogQiqnFbPOdwplMkVjwhN29MqV37pYDqjratz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpMHk/Fs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e27f9d2354so9046a91.0;
        Wed, 09 Oct 2024 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488373; x=1729093173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iuMwBOfG/UtqEPXzWxjlYPv1Iqr8aYbX/jMMLNnmlk=;
        b=FpMHk/Fsf6QKIXeDGnUN+BpK2sT9RTd64IpthawCOPFEx6Au48YafR58PtxdVuPm+f
         GmLx6PbXhEi0zll5QOczDATF35cw2clCwWi7TtBQhSQHEsm4rZKDWB1A79+5JnhGJGo0
         yoaoNqDnqJeuxxuYqoQ9xNBgStB61UKQ4cCSbYFczTojlh+xjUAE2j+M9o+FNzEzec+6
         bL9kt+GwSPPopqIKWSIV436CuBQw/d6LSyumnsFfRu1opgJBigjX8jiRVl/dRCA1akU5
         br3Ro09eF0SOqsPOuxYhZfMuYYO74QCa/98/iN3sSowLN6kt5sUKEvMFs1QvYOorx31B
         VR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488373; x=1729093173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iuMwBOfG/UtqEPXzWxjlYPv1Iqr8aYbX/jMMLNnmlk=;
        b=OIOfVyj3jfEvqlbTvbEQUAbnGR8PiwgMK4LT7XLiOPVYJeiTy7ho8tmqTnJumCI2Lk
         6xq0FfVAdiIXhMQnXV8PZTzm8hcXz8P9d0LTq2cGy5GiX0czmc+3INCFzNDEU4wLLiR1
         /yEvk0vqjOBjv4uSYLiTmQlB0OHSjbqOQ8it1vFLRY72hPTtFcNVmECizkxjxo6IwYYS
         8aVQ9GGbD/QpXAuRe3V18yz9lWkyR5imAyc2DTkEto70F8MR0EqyOwhOzsKNgrWTOCud
         GHxTxyizTiYV4g+GpP9HUC3JrSZEOD25KnR+x+N508oJ51GJ5S6Td9fBIQEdl9VKvBMM
         LT/w==
X-Forwarded-Encrypted: i=1; AJvYcCUoi5QuVnQM7tr7lF1cS5fZ51qQSQxnlQtfNGqKyUI3gwv7UFJQmedn+/diPUWtEBFz4cHs5QfQe2HMAcc=@vger.kernel.org, AJvYcCXnc3xWgBFBrQmGi9cTZUGt3VfW/I9FPI0RWx0Z8Zq54KK4f+GuevJWjDJdcNKXSGD932ojzREexyGCkL/oA2oLsfb6Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2tl01EK4fccAlumUOajGW591OOAKXsZYbEN+ty+t1zz8T8Vt
	LiuuW2XrrddEzITNyzPM0Kj8BbfNPQpZR0NctUuZTQ1BwjYrEmTmfH3sd92S
X-Google-Smtp-Source: AGHT+IHLl+JWK0lAmMfcIACHwFDVGMXAoHhVELPVXVNfjiE9IK93MHt1a5LCheBZhu1GVLdIKMQi9Q==
X-Received: by 2002:a17:90a:f289:b0:2e2:b46f:d92a with SMTP id 98e67ed59e1d1-2e2c63338c5mr523184a91.14.1728488373400;
        Wed, 09 Oct 2024 08:39:33 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55f98a9sm1829962a91.9.2024.10.09.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:39:33 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	kuurtb@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
Date: Wed,  9 Oct 2024 12:39:29 -0300
Message-ID: <20241009153929.11344-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <0b74d43f-ef23-cd6e-19e5-212432f8b95e@linux.intel.com>
References: <0b74d43f-ef23-cd6e-19e5-212432f8b95e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ok.

> > +#define PROFILE_ACTIVATE	BIT(0)
> 
> Add driver specific prefix to the defines please.
> 

Ok.

> > +
> > +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> > +{
> > +	return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
> > +}
> > +
> > +static int thermal_profile_get(struct platform_profile_handler *pprof,
> > +				enum platform_profile_option *profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args = WMAX_ARG_GET_CURRENT_PROF;
> > +	u32 out_data;
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_INFORMATION, &out_data);
> 
> Are you sure you want to keep out_data as u32? I'm not very happy how
> alienware_wmax_command() takes int * but all callers seem to prefer u32 *
> (or pass NULL). 
>

I don't have the old WMAX interface but the new one specifies an [out]
uint32 argument for all methods, I guess it's the same for the old one.

> Should the out_data parameter for alienware_wmax_command() 
> be u32 * or int *?
 
I'd say we go with u32 * for everything to resemble as much as possible
the WMAX interface description. That way there won't be confusion in the 
future.

I will name 0xFFFFFFFF appropriately.

> In general, if you find something that doesn't make sense, it often just
> is an indication that some cleanup is in order. We're more than happy to
> consider such patches along with the feature patches as then things are
> moving into the correct direction even if the progress would be slow.

All right. I will keep it in mind.

I will send a clean up patch together with the split Armin requested
together with v4.

> > +	if (ACPI_FAILURE(status))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (out_data == 0xFFFFFFFF)
> 
> This constant too should be named if the data really is u32 and not a 
> negative error code in which case I'd be fine with < 0 (without naming
> the error code) like in the original but it would need int as the type for 
> the compare to work.
> 
> > +		return -EBADRQC;
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
> > +static int thermal_profile_set(struct platform_profile_handler *pprof,
> > +				enum platform_profile_option profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> > +		break;
> > +	case PLATFORM_PROFILE_QUIET:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
> > +		break;
> > +	case PLATFORM_PROFILE_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (out_data == 0xFFFFFFFF)
> 
> Ditto.
> 
> > +		return -EBADRQC;
> > +
> > +	return 0;
> > +}
> > +
> > +static int gmode_thermal_profile_set(struct platform_profile_handler *pprof,
> > +				     enum platform_profile_option profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> > +		break;
> > +	case PLATFORM_PROFILE_QUIET:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
> > +		break;
> > +	case PLATFORM_PROFILE_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (out_data == 0xFFFFFFFF)
> 
> Ditto.
> 
> -- 
>  i.
> 

Thank you for your feedback!

Kurt

> > +		return -EBADRQC;
> > +
> > +	return 0;
> > +}
> > +
> > +static int create_thermal_profile(void)
> > +{
> > +	pp_handler.profile_get = thermal_profile_get;
> > +
> > +	if (quirks->gmode > 0)
> > +		pp_handler.profile_set = gmode_thermal_profile_set;
> > +	else
> > +		pp_handler.profile_set = thermal_profile_set;
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
> > +static void remove_thermal_profile(void)
> > +{
> > +	if (quirks->thermal > 0)
> > +		platform_profile_remove();
> > +}
> > +
> >  static int __init alienware_wmi_init(void)
> >  {
> >  	int ret;
> > @@ -807,6 +1011,12 @@ static int __init alienware_wmi_init(void)
> >  			goto fail_prep_deepsleep;
> >  	}
> >  
> > +	if (quirks->thermal > 0) {
> > +		ret = create_thermal_profile();
> > +		if (ret)
> > +			goto fail_prep_thermal_profile;
> > +	}
> > +
> >  	ret = alienware_zone_init(platform_device);
> >  	if (ret)
> >  		goto fail_prep_zones;
> > @@ -817,6 +1027,7 @@ static int __init alienware_wmi_init(void)
> >  	alienware_zone_exit(platform_device);
> >  fail_prep_deepsleep:
> >  fail_prep_amplifier:
> > +fail_prep_thermal_profile:
> >  fail_prep_hdmi:
> >  	platform_device_del(platform_device);
> >  fail_platform_device2:
> > @@ -834,6 +1045,7 @@ static void __exit alienware_wmi_exit(void)
> >  	if (platform_device) {
> >  		alienware_zone_exit(platform_device);
> >  		remove_hdmi(platform_device);
> > +		remove_thermal_profile();
> >  		platform_device_unregister(platform_device);
> >  		platform_driver_unregister(&platform_driver);
> >  	}
> > 

