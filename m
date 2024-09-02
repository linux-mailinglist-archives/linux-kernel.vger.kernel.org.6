Return-Path: <linux-kernel+bounces-310814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB85968184
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525471C21E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAC178CCA;
	Mon,  2 Sep 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pmjDZ71e"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F72032A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265095; cv=none; b=qA9lMewhGfNB9x2xAwxLTN2soi5gdMWXrAWgyMhU+Y+be7OhWXb36AozfDBB5hbThlVbFBhmjQRwYQhAyPTIr0Oua8PhZtuWKJd+JRg+SMgaZHOQ0XCnbDdpzwiQwrGSBPQTwdrSPg8Ji7L+jSZeVxfR8EKRZ2p8W4RHYyftKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265095; c=relaxed/simple;
	bh=1Kc9MmOQ/kSzCGrBjAr6GqYXXaRtlodoekxze7WcFb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAulITx/C1Z8nMlhV06W/a1d9IO/I4yM9z3ILpHQEkoFhxBbM+BwmR7ssMbyRGaDAOs/Cff40eFAlDxR6HtgVJTLjPL0D7yQ77urgelrog4CBDXMCPaAphB0rcO+kkiRKrhfPmwX3L/XnIvDzqMVJOjpoU/okzELWziUuUVShRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pmjDZ71e; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86e9db75b9so416065966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725265091; x=1725869891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzIYeIsII8peMIhHeVjDubC4HaKpmyTvf1l2x00PtxI=;
        b=pmjDZ71eaKFGZfUDyPEtGrE3Ld2QX1NXDEY8FwqlUuahWxMgAuRfp4i0sEMY5Js624
         s2FLNwrmI1tyvbkjqWbTSlOevGLybu/78A70gDGUqaDVzPZNvBABu5A0u287q4VTeJWa
         9IrFvnDOJ4TbIlin/nagjWrAdgi1MLane2EWKOKoeFOOoFNvg72Z2XG1zd9FiTwRa0KK
         zQRAY+vFW4BWJtrF/5OT7nqSC4uvf81XzJ2lurzY2uZ30Oix1cc65hDn6gr3eT99xPNC
         iHfWt0sUUt81oXIdyaFqmZCJOAy9AHTCCsANkJs6wbDvGZO1yx7yXob/hmwvsFiT41Cl
         2PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265091; x=1725869891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzIYeIsII8peMIhHeVjDubC4HaKpmyTvf1l2x00PtxI=;
        b=UfhJbOX59iutkMLF/k64ax0TVA1kbSclvvyC91JeOrnBgrDzZ0jS5CH3/Nhefui24W
         E04x7Cyes8nkkKfiK8t3o8HQH5EDSuVN9ve2OWUav+niRl4MtOfb7mO9i65jzSEf23Z+
         MDLEKRR9l4V3obwZhNlxoUrMiyBj6E5uzVyrcxyW9D0vrght0j+riNaYREtelI9khAE2
         8AJdUHAJWYMpeqzNHQ7Sx6NM4ZISxp+D3RxSQDpTgKI40qrfq94dLFvCQKHFx2JVopSB
         r0iYKypb57fzGH4boWW9IGAyszVs/Ez43BonGksuor/KwYo4DrbQvz3RhZxUP6lYMn9f
         dUjg==
X-Forwarded-Encrypted: i=1; AJvYcCXnGfxUIuXrTzeu5hQ6R84UJb3/nUOV7zCS3T69mMe9o6TDij1U3ALcTwfmlTri2ukmv3HNwEwOJ44ncwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tzfAI83ZUPcXPPgDuM1zAV2lFK6r8ZrwyKtkQg1VenN0rcvm
	/ahoLpjyy38233XH1P326poHR0s55RebAbd8UjFoHKIS6kzUt/xsZWhsULTFvO8=
X-Google-Smtp-Source: AGHT+IGyjNuT3Jd8noH/CX8Q2yoyXx8AC5qPYwGuLTvAzr5k4aQrYpMhxUXeJClV7S//bvmU8bBW4A==
X-Received: by 2002:a17:907:7da4:b0:a86:91ae:85e7 with SMTP id a640c23a62f3a-a897f7892aemr1030001266b.8.1725265090514;
        Mon, 02 Sep 2024 01:18:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196715sm521843366b.113.2024.09.02.01.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 01:18:09 -0700 (PDT)
Message-ID: <0dac055e-9d31-43ff-8584-57565f53e761@tuxon.dev>
Date: Mon, 2 Sep 2024 11:18:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/bridge: microchip-lvds: Revert
 clk_prepare_enable() in case of failure
Content-Language: en-US
To: Dharma.B@microchip.com, Manikandan.M@microchip.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 Hari.PrasathGE@microchip.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
 <20240827161223.4152195-2-claudiu.beznea@tuxon.dev>
 <b9b8494e-8606-4f40-87ad-797617b72d18@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b9b8494e-8606-4f40-87ad-797617b72d18@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.09.2024 07:39, Dharma.B@microchip.com wrote:
> On 27/08/24 9:42 pm, Claudiu Beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> In case pm_runtime_get_sync() fails the clock remains enabled. Disable
>> it to save power on this failure scenario.
>>
>> Fixes: 179b0769fc5f ("drm/bridge: add lvds controller support for sam9x7")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Reviewed-and-tested-by: Dharma Balasubiramani <dharma.b@microchip.com>

This tag is not valid, AFAIK. You should use 2 different tags: Reviewed-by,
Tested-by

>> ---
>>   drivers/gpu/drm/bridge/microchip-lvds.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
>> index b8313dad6072..027292ab0197 100644
>> --- a/drivers/gpu/drm/bridge/microchip-lvds.c
>> +++ b/drivers/gpu/drm/bridge/microchip-lvds.c
>> @@ -125,6 +125,7 @@ static void mchp_lvds_enable(struct drm_bridge *bridge)
>>
>>          ret = pm_runtime_get_sync(lvds->dev);
>>          if (ret < 0) {
>> +               clk_disable_unprepare(lvds->pclk);
>>                  dev_err(lvds->dev, "failed to get pm runtime: %d\n", ret);
>>                  return;
>>          }
>> --
>> 2.39.2
>>
> 
> 

