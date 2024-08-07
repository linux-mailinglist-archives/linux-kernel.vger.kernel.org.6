Return-Path: <linux-kernel+bounces-278494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB47594B0FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922EE2828CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D451487CE;
	Wed,  7 Aug 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy2JlhTU"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D2145FE1;
	Wed,  7 Aug 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061497; cv=none; b=hW7QRGJMnpbYlJ2AYoFp5QPwkILUONZxxyLaPChdMbDMaMoU64N+VWGqyaorHx+AZhLsRWnG7PeoiLAf1ppZEB9t60deMao0+mQ0osjGRk3butbDoDLSMWRMIvb7SrxaqwjpDZLf4zwmbXC8C+qFnTuG3yzbcwpRi8lwFCffwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061497; c=relaxed/simple;
	bh=atOcoquHQmSAxP29PSnuOJQP1bMHVYA3Oci10HMDZiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeAK+swbitl5BE3oMVItGt02XztAs7IIcPL84OqCjAraFgVYYZjb4Jjb3jevk3P5lPMUXb3/Qa1cJKs90WO3qdvc2bx3GHFIpSnMdbVqAfyopErAGBACa3A9hJAuF01Hud32g7BQorlZw2YVlg0GOLLp/ds02CFq2E7IrrwlSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy2JlhTU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so267564a12.2;
        Wed, 07 Aug 2024 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723061493; x=1723666293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yEPlqQKqiclFA65+RP/Wb/M20mzwnH8gme0GKuUXDw=;
        b=Iy2JlhTUifyyMK+9eEvPVUTSbNC0E3lzF73KAgfcMsA7LruHGlEDRYeymsXwHqLOW6
         esa+BIfya3Mvm1y8Eevwl9OAOvYDD/jNHyB/7TlvNlk/UadPNm0qH5DZ9H2P3Bi60Ruu
         sOHdVIHRVTnpRjXGpmLChHf795MU2WkIs41YyuXELGDGFAvau+S+8yL4g6W/OJcv6WPP
         cWjtVmYTDwpa6QFYo1GdVOyn6uE8Nkm2WaherkcSMQDcsVF494DQcMKcc5J1MtPuMff6
         jwYzvLgo5ZOdaTFDia8pB7+FqUNtHT8/sQR3+8WWuGIpyxo6bBz/FWDdsMcTjRAM3mtz
         hJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723061493; x=1723666293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yEPlqQKqiclFA65+RP/Wb/M20mzwnH8gme0GKuUXDw=;
        b=QVpcL+2o7puVAgXHwQ4QOWp9IzTo6Vrgt1MUOMJPe47RksPiYRNEPixfrFPG/h9Tly
         j5tSipcQ00CYceIOatdXDr4jLJ1+XlF9g3MPhLT4nYAWSfwCUY44yoBOyJ+e7x0EO9er
         dPAp6YooXh3hT68k/hPYjTn2mY8hG3t4my3fehd0a1rijpRD1WD2b5CD0m9/MAfYltPS
         ElI5cLjxBJ43bIQ40avipKIvtn7AkQWrG5kwVS4LQ5jMtQ8yZlv2Ijcd4LMI/6uqrlM/
         bdgg4P+wHgK5WqbxEL5qcomw3U7S2yGm1Khf/5oCe2OtA5YqWQs01NoJs5LONwA1/A0U
         29Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUH+x8Ugs2Lieqv0eX1hFnA/eYoS+/PHgpl8Npnq3nxTt4RsUv4vte1nAEn87qUrDEHXSYWSC7q6eXZ/NUG4MeTidr58vJCAFgTkjmPkoC6fd8wGzv6pr3P8GmyDoJw/QH1RtGl0IX3ofQ=
X-Gm-Message-State: AOJu0YxsKHBqfrmLviNkRCrDEu/ssWj8z0lkw2GQi7HQPP5djTmo8cKE
	Ih/4ihadtEb6TDijucjXCXVKY74ciuUV5rtoM7ALoBhcUGOpVsbm
X-Google-Smtp-Source: AGHT+IGi0XNHmey2renUEsb9GTHEJnK+Q5/w8sk3a0QYeKsRIchfHo9/ymU5MK14mYkcjOlsjFf8pQ==
X-Received: by 2002:aa7:d552:0:b0:5a3:f5c6:7cd5 with SMTP id 4fb4d7f45d1cf-5b7f550a75cmr12890586a12.26.1723061493074;
        Wed, 07 Aug 2024 13:11:33 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b723e78sm7391508a12.59.2024.08.07.13.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:11:32 -0700 (PDT)
Message-ID: <b66f1fed-20a2-4de3-85c5-bf6fb90c2649@gmail.com>
Date: Wed, 7 Aug 2024 22:11:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <2419e2ab-25e2-483b-a163-6b4fbfef6866@roeck-us.net>
 <5d11350f-71b0-44fc-8631-01e1740581d6@gmail.com>
 <5208afb1-92dc-43d3-b6ed-36a2fdd40ec7@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <5208afb1-92dc-43d3-b6ed-36a2fdd40ec7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 9:50 PM, Guenter Roeck wrote:
> On 8/7/24 12:25, Maximilian Luz wrote:
>> On 8/7/24 2:32 AM, Guenter Roeck wrote:
>>> On 8/4/24 16:08, Maximilian Luz wrote:
>>
>> [...]
>>
>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>> index b60fe2e58ad6..70c6385f0ed6 100644
>>>> --- a/drivers/hwmon/Kconfig
>>>> +++ b/drivers/hwmon/Kconfig
>>>> @@ -2080,6 +2080,16 @@ config SENSORS_SURFACE_FAN
>>>>         Select M or Y here, if you want to be able to read the fan's speed.
>>>> +config SENSORS_SURFACE_TEMP
>>>> +    tristate "Microsoft Surface Thermal Sensor Driver"
>>>> +    depends on SURFACE_AGGREGATOR
>>>
>>> As the kernel test robot points out, this dependency is wrong.
>>> __ssam_device_driver_register() is only available
>>> if SURFACE_AGGREGATOR_BUS is enabled.
>>
>> Right, I should have spotted this before submission, sorry. This should
>> be
>>
>>    depends on SURFACE_AGGREGATOR
>>    depends on SURFACE_AGGREGATOR_BUS
>>
> 
> SURFACE_AGGREGATOR_BUS already depends on SURFACE_AGGREGATOR, so the extra
> dependency is not needed.

Unfortunately, SURFACE_AGGREGATOR_BUS is a bool and SURFACE_AGGREGATOR
tri-state, and the inference of whether SURFACE_AGGREGATOR needs to be
built in or not breaks because of that. Meaning we could have something
like

     SENSORS_SURFACE_TEMP=y      (tri-state, module)
     SURFACE_AGGREGATOR_BUS=y    (bool, optional-code-flag)
     SURFACE_AGGREGATOR=m        (tri-state, module)

because SURFACE_AGGREGATOR_BUS is fine with either m or y. But in
reality, SENSORS_SURFACE_TEMP=y would require SURFACE_AGGREGATOR=y.

Maybe there's a better way to solve this? I guess it should be possible
to convert SURFACE_AGGREGATOR_BUS into a tri-state (even though it's
really just a flag to build a certain part of code into
SURFACE_AGGREGATOR).

I think at this point we could also consider removing that flag entirely
and just build the bus support in unconditionally... but that discussion
is outside of the scope here.

>> I'll fix that for v3 and likely re-spin this weekend. Anything else I
>> should address for that?
>>
> 
> I didn't notice anything, but then I didn't try to build the code myself,
> or try to run checkpatch. My tools run checkpatch --strict, as necessary
> for hwmon submissions, so you might want to make sure that it passes.

Perfect, I already checked that. Thank you!

Best regards,
Max

