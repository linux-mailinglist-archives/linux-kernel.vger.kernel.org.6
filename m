Return-Path: <linux-kernel+bounces-399606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7619C0185
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC63B22D64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6371E8834;
	Thu,  7 Nov 2024 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba+vNHZ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D41E9068
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973108; cv=none; b=gJCDySUjK5Aok4Isbuhnol9FrvzEUg6cFZT/QdQwASxAwHUXoJMgHM0uNU6DeH9+GdMPngzlO2QvBbLU3C9lI/B6+cFijQhuiCeF8rluEzdXDgFKCvfBUKoSeTjXmZppu/oYb65TFbYgbb+IPNcuiHQxeUb+UU6sbp+XV4V9HVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973108; c=relaxed/simple;
	bh=uINfh8++aKD5Z5gH0g1YPuI5jEgTaPGo9o0bTh0k924=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaaicFnLHKvAv/5lT8Eu9BvdgtXyq2mA2S2YqIaeBVl1aulfvM6MO2qOaBxL+gAS6KU4GvRr0iUHIzFYIX/DULv9KottSd/HzcBgWJOXmwnfQue4z61KyQhhyTOCny2xzDJKltbGkQHaj6/3Pf7Y3SrXvAkiHOD391wABU4+JQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ba+vNHZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730973105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rma9vBSb1ll+jBX/h15QWhJLF+FcIH84Xs+DeZo3nOw=;
	b=ba+vNHZ/HAW5TR8h2F0pg/pvjHsA/vN/GPatNaWgBNCaS17I2UOd9uTwCAlOC28GPBwgbg
	LulOeJICqsCNgNXIeLEvou49KqlvJFjzxt/1JduGPhyKlhjRkFpkNpfhtf/DSc16o+s9jW
	lWCTznTSGoiILp+qDyJTAoVLR4gO+3E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Knl4kPaxMGyIUMqEOpwOuA-1; Thu, 07 Nov 2024 04:51:43 -0500
X-MC-Unique: Knl4kPaxMGyIUMqEOpwOuA-1
X-Mimecast-MFC-AGG-ID: Knl4kPaxMGyIUMqEOpwOuA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99f084683fso62175366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973102; x=1731577902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rma9vBSb1ll+jBX/h15QWhJLF+FcIH84Xs+DeZo3nOw=;
        b=Fo1MtcnB1PpQcpGPMVV2K0Z0SSSbk+Vn1LLQtT0OFYxvvgMJRFY1UtjMAjZXzISagT
         0BvjHeY/EoggmXVfsXQtw0IEHw4D2fZynr8u9FMCVUZwqoU3muFXV78zNkeT5FzpiGOi
         M8c2IBaOa42eeN3sPp/UqKkXph5KtowMdSVC+IwWT/+LWXpb5k8Kcq/LVPx7mgEymD9q
         GhIBDo5BVYW3rNhIDDgBkxVa+IsQxFBJ9TK96z/3okITbdB0ZaGu22l+GoaSSikNOwsw
         UwCnrjzh0/j7np1Z1gI8EW2gAOI5qd/TiBEGFis9BUwALeik7uR5Rt38+oNKmU4jVxUj
         5tPw==
X-Forwarded-Encrypted: i=1; AJvYcCW/2fdog+NFHee7IPTOMTpTYZ0mCBGFIWnn5Ve5YEaDK0R4W2nmrmXi9OK/VkHHLk33rqNjjf1sYmMDgz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3mtjDjkik/znFfEfmJG4ac7WxkZlT9o7Ijm/zPwmDq2Ze0hF
	nkuXjooHn8K6K31cC9LbPoIT2/i/SGXb/tN32iZ5+IF3oUHyyy+zIRL9aj5ksQxHYObZTDeUG2w
	7Um1EXwI0YJSGj7nSMfqhhpU7EsbfJ9ZC9Ttu9YKbs2zSRovLsilw6r5UIJZMAw==
X-Received: by 2002:a17:907:970a:b0:a9a:4a:284a with SMTP id a640c23a62f3a-a9de5d8690amr4315298666b.26.1730973102510;
        Thu, 07 Nov 2024 01:51:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO6gxHlF3A+5l3TcMj/vhwbz9Uy0C6KWrgNLbP/Zy1E8A/m8386Wb6kbTAQKI819XkxJOF9g==
X-Received: by 2002:a17:907:970a:b0:a9a:4a:284a with SMTP id a640c23a62f3a-a9de5d8690amr4315295666b.26.1730973102068;
        Thu, 07 Nov 2024 01:51:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dee5e6sm69162766b.137.2024.11.07.01.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 01:51:41 -0800 (PST)
Message-ID: <f1d86afe-42fb-4883-be24-d6032de26f6e@redhat.com>
Date: Thu, 7 Nov 2024 10:51:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Fix inconsistent use of
 thermal policies
To: Armin Wolf <W_Armin@gmx.de>, corentin.chary@gmail.com, luke@ljones.dev,
 mohamed.ghanmi@supcom.tn
Cc: srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 Michael@phoronix.com, casey.g.bowman@intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241107003811.615574-1-W_Armin@gmx.de>
 <20241107003811.615574-2-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241107003811.615574-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7-Nov-24 1:38 AM, Armin Wolf wrote:
> When changing the thermal policy using the platform profile API,
> a Vivobook thermal policy is stored in throttle_thermal_policy_mode.
> 
> However everywhere else a normal thermal policy is stored inside this
> variable, potentially confusing the platform profile.
> 
> Fix this by always storing normal thermal policy values inside
> throttle_thermal_policy_mode and only do the conversion when writing
> the thermal policy to hardware. This also fixes the order in which
> throttle_thermal_policy_switch_next() steps through the thermal modes
> on Vivobook machines.
> 
> Tested-by: Casey G Bowman <casey.g.bowman@intel.com>
> Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan profiles")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
>  1 file changed, 21 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ab9342a01a48..ce60835d0303 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3696,10 +3696,28 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>  /* Throttle thermal policy ****************************************************/
>  static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  {
> -	u8 value = asus->throttle_thermal_policy_mode;
>  	u32 retval;
> +	u8 value;
>  	int err;
> 
> +	if (asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO) {
> +		switch (asus->throttle_thermal_policy_mode) {
> +		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> +			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> +			break;
> +		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> +			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> +			break;
> +		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> +			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		value = asus->throttle_thermal_policy_mode;
> +	}
> +
>  	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
>  				    value, &retval);
> 
> @@ -3804,46 +3822,6 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>  static DEVICE_ATTR_RW(throttle_thermal_policy);
> 
>  /* Platform profile ***********************************************************/
> -static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, int mode)
> -{
> -	bool vivo;
> -
> -	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> -
> -	if (vivo) {
> -		switch (mode) {
> -		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> -			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> -		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> -			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> -		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> -			return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> -		}
> -	}
> -
> -	return mode;
> -}
> -
> -static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int mode)
> -{
> -	bool vivo;
> -
> -	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> -
> -	if (vivo) {
> -		switch (mode) {
> -		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
> -			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> -		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
> -			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> -		case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
> -			return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> -		}
> -	}
> -
> -	return mode;
> -}
> -
>  static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>  					enum platform_profile_option *profile)
>  {
> @@ -3853,7 +3831,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>  	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
>  	tp = asus->throttle_thermal_policy_mode;
> 
> -	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> +	switch (tp) {
>  	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
>  		*profile = PLATFORM_PROFILE_BALANCED;
>  		break;
> @@ -3892,7 +3870,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>  		return -EOPNOTSUPP;
>  	}
> 
> -	asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
> +	asus->throttle_thermal_policy_mode = tp;
>  	return throttle_thermal_policy_write(asus);
>  }
> 
> --
> 2.39.5
> 


