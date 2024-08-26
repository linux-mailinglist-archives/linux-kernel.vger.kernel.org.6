Return-Path: <linux-kernel+bounces-301667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE195F3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE76DB21A57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325818757A;
	Mon, 26 Aug 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTaHrBPj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0117C9BE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682362; cv=none; b=ATilBkIl31e/IGGhD/CptEnZliFXuURIDg5039m2nK6RJY8c5yrdJCqU8RxEgvMCCt2Gs+MeaEMuN+pGJ/MKrgphkP4hFIG6MYH0CPbBcFOMKcGWKcHWQ0ST36lPWizjSz+Ybi9jiBftsMYK6BShvWmpqmd+XQtMDbCIGRcXbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682362; c=relaxed/simple;
	bh=M3+icb9ze2b0j3muau5Wzrz2Mr5zDjVxwMH/uJIEUY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcgBVo6AzHlUkneUjUz5Gs97nToCsCmUnNXyHxjN0ztfU5PvdN1LWyHd//7rG8Inp2/w7XzyPiOf6Bns9RDnGoWIxSlGiRh8gk+jzE9X6uykP3FelRH+PniPYVJbezdm+y/CH99gaX1WYPujAztrYh9vjMpxUergXxBMcd81z38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTaHrBPj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724682359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4owlqzaXy+TQHLAvRQqMwPaAPqTMmEvJ75N++pfFPMs=;
	b=DTaHrBPjZXh2wh9xlVaAdYf50eRzJP4GbLZmATjvegLgk32cc0Olo90YpeScN+SCE6YqMm
	bCVnoMPrFIJtTbHIwi+UmyrTtHWQgmlr7ejhmj1KA47EposzswVWVABFqb0YVpNqFNxXf+
	w2mIKW9pB7fMQ8IWyAn4nMJEIgJDMQI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-iCQAo7YxOcOdwGgrGED03A-1; Mon, 26 Aug 2024 10:25:58 -0400
X-MC-Unique: iCQAo7YxOcOdwGgrGED03A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a867ed4c129so369837366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682357; x=1725287157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4owlqzaXy+TQHLAvRQqMwPaAPqTMmEvJ75N++pfFPMs=;
        b=oWck5DXKLBhutFHATBcQPLq4LIfnITsAc1VRVeixQshiWCfF0AfHabV4Y4Xiuhh3iM
         6vuLWLIyMVykfWt8M8rEDMLv6//lZ/sCLokTTEV9K959UcwTbdgGKx6gzPSIJV+KQ7GK
         qZ8MuMhHLPFM8yMcZhgfiEscSzg5sDJeNZx4DNlh2xwNKJW9UAJZ/3wx8k9OV1BMzXz9
         KyF2mbVLcMJUne5nfpk1W4iR04wDAfW0jbBkEAbyMyZgYLt9iHUUhaKjGb0/7CX9bEer
         KCBon9rj+ROeYHRxyHc70t7uTrNs9NXZB8pkj0WreUzLLdX1F2DbsnmaWcVSPooC5KL8
         Ia1A==
X-Forwarded-Encrypted: i=1; AJvYcCWLangtZsw+IJmIIe0rf88x6jWbNjQoxN4Wkw4wMQIRKUaw/2AvK+IkEwLPW2erLle/r+llGqLvueFo2MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMoFL6iuol4I0A3694Cry1f0lRRjkH7YuiOO7WjuClhRSI/Mj
	eHm2KfWcVr80CfuNibfCbfq0aFz0K9QdvkWNGmFZtBBHZeyjwUb9gRpELeuU22vAyBlsOCICvgQ
	Ec4pIME7k3dpx61xXzMhwhmo3c4o65zIVyt6XcxndxDIp1ZsVgxhnIADZt9EfBg==
X-Received: by 2002:a17:906:dac4:b0:a86:ad8b:3511 with SMTP id a640c23a62f3a-a86ad8b3797mr753865166b.49.1724682357056;
        Mon, 26 Aug 2024 07:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdVXOvL8B4z58VMuOlhm1uu9XVsyzdxS83WY3dIcs/VgLKIZR7OM3EgZdMBSAHupB7xLQTuw==
X-Received: by 2002:a17:906:dac4:b0:a86:ad8b:3511 with SMTP id a640c23a62f3a-a86ad8b3797mr753862466b.49.1724682356519;
        Mon, 26 Aug 2024 07:25:56 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b5csm667649666b.164.2024.08.26.07.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:25:55 -0700 (PDT)
Message-ID: <f4313bb4-3f80-4bba-b6c2-7dcdeddf4303@redhat.com>
Date: Mon, 26 Aug 2024 16:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ABI: testing: sysfs-class-power: clarify charge_type
 documentation
To: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
References: <20240820041942.30ed42f3@5400>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240820041942.30ed42f3@5400>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/20/24 10:19 AM, Andres Salomon wrote:
> The existing docs here are a bit vague. This reformats and rewords it,
> and is based upon the wording originally used by the dell-laptop driver
> battery documentation and also sysfs-class-power-wilco.
> 
> The wording for "Long Life" and "Bypass" remain the same, because I'm
> unfamiliar with hardware that use them.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  Documentation/ABI/testing/sysfs-class-power | 38 +++++++++++++++------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 7c81f0a25a48..84973f66b42c 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -377,17 +377,33 @@ What:		/sys/class/power_supply/<supply_name>/charge_type
>  Date:		July 2009
>  Contact:	linux-pm@vger.kernel.org
>  Description:
> -		Represents the type of charging currently being applied to the
> -		battery. "Trickle", "Fast", and "Standard" all mean different
> -		charging speeds. "Adaptive" means that the charger uses some
> -		algorithm to adjust the charge rate dynamically, without
> -		any user configuration required. "Custom" means that the charger
> -		uses the charge_control_* properties as configuration for some
> -		different algorithm. "Long Life" means the charger reduces its
> -		charging rate in order to prolong the battery health. "Bypass"
> -		means the charger bypasses the charging path around the
> -		integrated converter allowing for a "smart" wall adaptor to
> -		perform the power conversion externally.
> +		Select the charging algorithm to use for a battery.
> +
> +		Standard:
> +			Fully charge the battery at a moderate rate.
> +		Fast:
> +			Quickly charge the battery using fast-charge
> +			technology. This is typically harder on the battery
> +			than standard charging and may lower its lifespan.
> +		Trickle:
> +			Users who primarily operate the system while
> +			plugged into an external power source can extend
> +			battery life with this mode. Vendor tooling may
> +			call this "Primarily AC Use".
> +		Adaptive:
> +			Automatically optimize battery charge rate based
> +			on typical usage pattern.
> +		Custom:
> +			Use the charge_control_* properties to determine
> +			when to start and stop charging. Advanced users
> +			can use this to drastically extend battery life.
> +		Long Life:
> +			The charger reduces its charging rate in order to
> +			prolong the battery health.
> +		Bypass:
> +			The charger bypasses the charging path around the
> +			integrated converter allowing for a "smart" wall
> +			adaptor to perform the power conversion externally.
>  
>  		Access: Read, Write
>  


