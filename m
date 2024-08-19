Return-Path: <linux-kernel+bounces-291861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097E956825
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616DDB224A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D61607AF;
	Mon, 19 Aug 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU11qKYa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F0156F5F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062809; cv=none; b=BAszkGUaHHSgh7ffEXPxdcaolngl8LhvYEtIub0jb5xuAFrJdzn0goyaXAlFwKqGbuqDeUoMynK+I7JqWlcadrinORJtxPw/IoirmjDjJyuOGv7r4z51jPjiBKLzTZDYzymmuRuB2G8+t0UiCSjEjhgOTaof2RwD6C0dhybHfyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062809; c=relaxed/simple;
	bh=qaJVMTKX2YN/haWPaprtb5i3CGOYZT09tNmQOMz2HBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUoyQTfi4S6vFoRWr/yjRBDI0K7zJpLeZ1/UBMW386Uzjk64+kTdgs0yZlEqtM7Q7uswy8u2dGlT7Rr/wPNwINcYwtqphXgBM7hVq4nKKkMOsn+aZGaQsyo3oOmAJo0ixJLr4NfV+uZdpxjd24rzIL55F4G8R2mbDhub8oSnMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU11qKYa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724062807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt2LYVYKmTVkAnDYFtLFnxYZzUlQbq44aMUMUQ1jAqA=;
	b=YU11qKYaRQNH4l0QBKRLtx+B4zIsNItxcOUKRf9rlEDzVSCI7to7U6Xwz4S4Trew7f4g5A
	NCGemdnGyuzU9uEVma9QWIgYWKc26ZoVUBZGbsHlXJF7pKjSsGrfja7YXh5Hyf5t3HDiSq
	fpCaqcMthrNv0n47KkTCrbaprWpB3FA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-RYTvbTxJNqGJgCnMpi7hYw-1; Mon, 19 Aug 2024 06:20:05 -0400
X-MC-Unique: RYTvbTxJNqGJgCnMpi7hYw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5becd2ca8bbso2083390a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062804; x=1724667604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt2LYVYKmTVkAnDYFtLFnxYZzUlQbq44aMUMUQ1jAqA=;
        b=gaQ39KdxU4VJ1/Qc7RgwNNsY9nVNlXOHlwrEeYSSJgca+2DdnQdLL348GFKyPSS9/I
         UYECgSi9BDkCwhtfQs110ITmFKcvPLx0v+3boDtsEGaO9zFzc9lO8ydU6eAg/LI98cm5
         CNYLjN4j+gF+m70qe0ibHuQmTXN/cYDogM9fP/M0IuvQdbN+epAgfI5CQboFBJM2wtjf
         HVW7Ki1Z++FOTARVkJJLakkq5/eNiEhxduqcxmvyoTbVASb3kBuCLO80uNFz/YRK58gW
         sLXa96OlNiAxuJjKjE0oHBVajanr9l9923m7SUnzGbRdxL4hAHKe4fllRcC5Ohq67TAI
         C1xg==
X-Gm-Message-State: AOJu0Yw7CGp8oaVTR+2/LkGQxloZvO/Z9FKU4FL5mG8Yi6/yF2QR1yKW
	853QfveDOzPaeRBP6ElybelDwh4+HkBzPTME7GbnCyI6U2KHeXQGJOAj9mlln+9fqJ20+5fZxtU
	dVOJ+rudY6CTCda37klcOc9cJESR41i1YJURoOBy0xPJ8i3Yo9m/zduylCF2gCQ==
X-Received: by 2002:a05:6402:2707:b0:5be:fc44:d16c with SMTP id 4fb4d7f45d1cf-5befc44d688mr1453669a12.21.1724062804472;
        Mon, 19 Aug 2024 03:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVEZBeVDOcw2UccmR/xKwRwclHVYBRUiCGFShuiYXBBn7mzTfH4dJAZxcg/AEp0vLqteaXzA==
X-Received: by 2002:a05:6402:2707:b0:5be:fc44:d16c with SMTP id 4fb4d7f45d1cf-5befc44d688mr1453649a12.21.1724062803943;
        Mon, 19 Aug 2024 03:20:03 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe26fcsm5426612a12.5.2024.08.19.03.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:20:03 -0700 (PDT)
Message-ID: <32c550ec-d5f7-4422-a1e1-1fa22111d1c5@redhat.com>
Date: Mon, 19 Aug 2024 12:20:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Peter Kaestle <peter@piie.net>, platform-driver-x86@vger.kernel.org
References: <114901234.nniJfEyVGO@rjwysocki.net>
 <6709311.4vTCxPXJkl@rjwysocki.net>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6709311.4vTCxPXJkl@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 8/12/24 4:19 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the acerhdf driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> The previously existing acerhdf_bind() function bound cooling devices
> to thermal trip point 0 only, so the new callback needs to return 'true'
> for trip point 0.  However, it is straightforward to observe that trip
> point 0 is an active trip point and the only other trip point in the
> driver's thermal zone is a critical one, so it is sufficient to return
> 'true' from that callback if the type of the given trip point is
> THERMAL_TRIP_ACTIVE.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I believe it is best to merge this through the thermal(zone0 subsystem
together with the rest of the series:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> 
> v1 -> v2: No changes
> 
> This patch only depends on patch [08/17] introducing .should_bind():
> 
> https://lore.kernel.org/linux-pm/2696117.X9hSmTKtgW@rjwysocki.net/
> 
> ---
>  drivers/platform/x86/acerhdf.c |   33 ++++++---------------------------
>  1 file changed, 6 insertions(+), 27 deletions(-)
> 
> Index: linux-pm/drivers/platform/x86/acerhdf.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/acerhdf.c
> +++ linux-pm/drivers/platform/x86/acerhdf.c
> @@ -378,33 +378,13 @@ static int acerhdf_get_ec_temp(struct th
>  	return 0;
>  }
>  
> -static int acerhdf_bind(struct thermal_zone_device *thermal,
> -			struct thermal_cooling_device *cdev)
> +static bool acerhdf_should_bind(struct thermal_zone_device *thermal,
> +				const struct thermal_trip *trip,
> +				struct thermal_cooling_device *cdev,
> +				struct cooling_spec *c)
>  {
>  	/* if the cooling device is the one from acerhdf bind it */
> -	if (cdev != cl_dev)
> -		return 0;
> -
> -	if (thermal_zone_bind_cooling_device(thermal, 0, cdev,
> -			THERMAL_NO_LIMIT, THERMAL_NO_LIMIT,
> -			THERMAL_WEIGHT_DEFAULT)) {
> -		pr_err("error binding cooling dev\n");
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -static int acerhdf_unbind(struct thermal_zone_device *thermal,
> -			  struct thermal_cooling_device *cdev)
> -{
> -	if (cdev != cl_dev)
> -		return 0;
> -
> -	if (thermal_zone_unbind_cooling_device(thermal, 0, cdev)) {
> -		pr_err("error unbinding cooling dev\n");
> -		return -EINVAL;
> -	}
> -	return 0;
> +	return cdev == cl_dev && trip->type == THERMAL_TRIP_ACTIVE;
>  }
>  
>  static inline void acerhdf_revert_to_bios_mode(void)
> @@ -447,8 +427,7 @@ static int acerhdf_get_crit_temp(struct
>  
>  /* bind callback functions to thermalzone */
>  static struct thermal_zone_device_ops acerhdf_dev_ops = {
> -	.bind = acerhdf_bind,
> -	.unbind = acerhdf_unbind,
> +	.should_bind = acerhdf_should_bind,
>  	.get_temp = acerhdf_get_ec_temp,
>  	.change_mode = acerhdf_change_mode,
>  	.get_crit_temp = acerhdf_get_crit_temp,
> 
> 
> 
> 


