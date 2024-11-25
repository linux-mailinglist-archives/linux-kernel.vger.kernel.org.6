Return-Path: <linux-kernel+bounces-420732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD19D82B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33774B2D264
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9219258B;
	Mon, 25 Nov 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrvPaGZH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FC190477
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527606; cv=none; b=YjXVtWHXWS2iyjzUWVXrBhZsV4cnH95BLBa3hE5YlRcVqdD28YtYOmb3+IIz998eHkILcQ9XJ/pYMxFkdEyxrugPQq8eE/96ZiT2/rxsHxiheh0xJCWmzoSPb/WC52jxkgqSBykhPAiowVIpwgYjiWc8q01D8DJvuCLMrfd59/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527606; c=relaxed/simple;
	bh=cOpE0c+LyUVWwbcDeKJBtPbzMortWcCvzht78xT5aFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhZJwfBSdt5HV6g8oFIiEsoDGJYOLRMEbPeVHgsb46Niz8nrhb0r2NFs280zN1tAFgIFVB8w3cxN2E4EGnMt2Vlm7/WLGVit26u/BGQFpzDIT8/p47Fx+I4kb+NZMTX1+1fOya1UDspd84jAzxK8+Or/CukGma8+IfL6yYR8OMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrvPaGZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732527603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYb0srWcbDisGIXUS7s0SfGyL9DUOFJ4d9y9eJeg7jU=;
	b=MrvPaGZHIBKiIBPG8YAw8AIyzJp/YFm8X7AXA+dqcGroXXvMgho/2WzrUVrJKNdyUhtusP
	t/iwmCcsdMrwzV9LPAg9swzm2TbsE0Ya/3SKwmQxCdmrVwiwq/u9TL7uYWKg+CXq5yNPSW
	6VDhs0KyKDk3JRiCm1clHCq5GpwGEQM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-4SiCbKEYP3u5hz3BL49R8w-1; Mon, 25 Nov 2024 04:40:01 -0500
X-MC-Unique: 4SiCbKEYP3u5hz3BL49R8w-1
X-Mimecast-MFC-AGG-ID: 4SiCbKEYP3u5hz3BL49R8w
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa527da110bso191263166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527600; x=1733132400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYb0srWcbDisGIXUS7s0SfGyL9DUOFJ4d9y9eJeg7jU=;
        b=WBkdWSJHMDqopMLwtbDfUhqYA69DhfSH1WyuDYvjJTLf0zpAkkMxZ4gopikpBfzTut
         U9aK9wucEsJizzXsF1jrizN/8xX6Q/c91zybzH8bmuEQv6GKEr+8DnF6r9VylkQac7yD
         KKLlxEB87d5G+ffNXm5vIeQZUdPEjNuk7NNj/50g9D7TXrs88ukFhrtMAnkYOFmy0Zt3
         KRc53Vq+PMP25Atd0FK+ZDWuTWiAZXQZdBviZd78aHZrrGWZb0z3upQtp0/2Ol3kflb/
         TrdKDrm2a1fB9+OmLlpGHjh0iuwSWW7E8/tVkc240jF3Fda7fTNOdx5zzpFqOIxh+zV/
         d8+g==
X-Forwarded-Encrypted: i=1; AJvYcCWHmXbq1P5dwno+tBllH0k+YYL1bUTGyljgsGEcRFv4ehV9cE58jPpBzcBUyJHAi5IHsVfoz9NzX0JY2Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2EC0ZBFbbFZu9rSuu4m6RjjhelfdzyZpR+GdiK/uQ3i3A9xA
	zbc2zjqiWq8FhqgqAmRyS77ha5BF6gqq5azG0Z3GKr54VUHmiOaigActM3QrPkQjSSfHXUD/8Qp
	UkOq6oM/LiPbfWYEsGsBts8cO+mfRStijU7Z5VWfQebVjKJCUOD02mfwYpH7HQA==
X-Gm-Gg: ASbGncvtsgjqIGePzV2pzABPTIMmBIz6EPlC5Rr01Iu9y5CcVoIxnHONzEQbf/bYn3P
	p/lZy0l5ggBbV6Vy+dtkBdER6qX30BHQJYM2wclftL1qQkHYwK6RDNtZnBNkM+m6wuAc1CrfjYs
	Bqit6/vVqs9ASgc77CHtS05MYTMgAHnukdt3d4dCfAlkqoYzi6BDinve8BOUJONQhTSojFvdF6M
	p0Kqvqe76DJzMJmPNKFFWW8brb5DTX2Y62aDep6sYy1mhXvQVbVH33tvT8/mHPxe7sIgLu9oMA/
	w8EcDf55AOvceBAxztQ8rtyB/DCouZm/JWRCjWxVLq2+/kA67j9n+JOlMn+fCVMJw3hPgBzrRGG
	noV3/ShMipm4EzyxEnV2u5xo5
X-Received: by 2002:a17:906:9c2:b0:aa5:297a:429f with SMTP id a640c23a62f3a-aa5297a431cmr756539366b.51.1732527600489;
        Mon, 25 Nov 2024 01:40:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGeiriE0b8Iux0eyUY22xZRptZbW/6+Lgi16hErdHIBckumrlRFBkkEPjGo8VVvQ/rPfvj7g==
X-Received: by 2002:a17:906:9c2:b0:aa5:297a:429f with SMTP id a640c23a62f3a-aa5297a431cmr756538166b.51.1732527600104;
        Mon, 25 Nov 2024 01:40:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f044dsm439226266b.46.2024.11.25.01.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 01:39:59 -0800 (PST)
Message-ID: <13590dd6-1529-487c-842a-85b44c577811@redhat.com>
Date: Mon, 25 Nov 2024 10:39:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore return value when writing
 thermal policy
To: Armin Wolf <W_Armin@gmx.de>, auslands-kv@gmx.de,
 corentin.chary@gmail.com, luke@ljones.dev
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241124171941.29789-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241124171941.29789-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 24-Nov-24 6:19 PM, Armin Wolf wrote:
> On some machines like the ASUS Vivobook S14 writing the thermal policy
> returns the currently writen thermal policy instead of an error code.
> 
> Ignore the return code to avoid falsely returning an error when the
> thermal policy was written successfully.
> 
> Reported-by: auslands-kv@gmx.de
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219517
> Fixes: 2daa86e78c49 ("platform/x86: asus_wmi: Support throttle thermal policy")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/asus-wmi.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ba8b6d028f9f..8bd187e8b47f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3696,7 +3696,6 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
>  /* Throttle thermal policy ****************************************************/
>  static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  {
> -	u32 retval;
>  	u8 value;
>  	int err;
> 
> @@ -3718,8 +3717,8 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  		value = asus->throttle_thermal_policy_mode;
>  	}
> 
> -	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
> -				    value, &retval);
> +	/* Some machines do not return an error code as a result, so we ignore it */
> +	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev, value, NULL);
> 
>  	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
>  			"throttle_thermal_policy");
> @@ -3729,12 +3728,6 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  		return err;
>  	}
> 
> -	if (retval != 1) {
> -		pr_warn("Failed to set throttle thermal policy (retval): 0x%x\n",
> -			retval);
> -		return -EIO;
> -	}
> -
>  	/* Must set to disabled if mode is toggled */
>  	if (asus->cpu_fan_curve_available)
>  		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
> --
> 2.39.5
> 


