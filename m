Return-Path: <linux-kernel+bounces-181161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09708C7852
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FA51F22F11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05688147C6E;
	Thu, 16 May 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esYbWuhk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B81487E1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868894; cv=none; b=XCrxDuGvVAfiy1CHwKJ9TX4CH+RhrGUUQwyk2C4t2/uJ3gNOX4I9UKRrTIDjaY641GpiuFI7u+EsJBpaiLBIYb4rxJROVsZHp5OYMcmR81hnjFwq2l3IIVB3sGG+mBbVJEOzz16+Em5URBBJUKGytkb+J4qnz9vyUKd9uZQ7KRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868894; c=relaxed/simple;
	bh=C34TBrZ5ugDdNSq+yVLVgLcAhq0WAhMHWclweyMoEWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTvrLfASVDeFm7rdQHJqDQ2mck4WmojGKv+Ym7CCHXq8PlUrGJ1tC121N1YHEgbTBJcKEQq0D+m3HlMCxxrXutsVAXBGDpRdvdmhE0mI0og8ehspCKSWyaetcSFcPPeolsSxGFExJlDuN4jpLSTD9e/mTSUkl8a8mrtI6VwNOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esYbWuhk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so1088093e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715868891; x=1716473691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ON/wab2YZE4UmkNgg09Z7pgaaoU1oue8TaWpgW4fwFM=;
        b=esYbWuhkGhr3MXvxVV/6k0KM2jbpR6tMl+t8SDZw5EKSyrIMLk6ft9sapux8krzJWb
         E5zqkQF+2mosNJjpSyOe8Qga+LqmPNbDWE2LawHXOYcOFxhbnjnkjwIDmAQmiHo4BKQz
         tqG0474q//pi1t8uW/oYzOR329/cF2Kdn/qQAffRG0BgpdejDtbpiZovGhVYFLhtl38L
         NxFl6JdmFTb+FIwC6NTHm5+JY+xAylnua9KPn1ndbrVJTfTZEq5pEyXoXbaKudzHO1QI
         LQ5Ogi8LP9UhWgwRuDF8o3dVzjk0WHx83aAy28TBfOSyCr4/JRqPPZw39wnW1aFYWVlG
         f2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868891; x=1716473691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ON/wab2YZE4UmkNgg09Z7pgaaoU1oue8TaWpgW4fwFM=;
        b=WTZkBZGVA1bcoAupp2iSbktZCOZf93gCht83mOGbBES9+BspajCsL2frrVJcAXGNsC
         BfLpPp9N6UQZKiYA88UwAD8tFlGjnC6eTyxmGZ237XTWrARWoGlC1hXmo7VAubO5ss+V
         P9ycyi80ve2Ay/ANfRdRsH96km4oJ7kwPNCKWXv4khqLJLU5W+mVfWGBJpgZuYOEfXHR
         eQqbAAIVNOG4GXadAc+aNKLylaDmRQzgUg6dCuK6DHJkgsq03CykHJ+Pd6CTn185C+Ac
         pKpeew0n39FQpXYG2gZ+TgPBFFp72u+CbnGHPvpOFagn5JdKYQicBBGUvjUjCmwNkJae
         X8kA==
X-Forwarded-Encrypted: i=1; AJvYcCWvoYpfwBp8IDR/+pAY21IKjGbXrn+BKNlCuOuIug5UDILZP3Lyhc966r/B3p3867Lh+ghGplOofRl04wjTWCyE/ytgPCX9WzRcDDqH
X-Gm-Message-State: AOJu0YyWHqctA48DxJ2fNOPOX6DvX1ZZASgDabfgZH+eUkvymsXWtvhq
	8yId39fR/UwezrraEcimNR6VylSIiS5cm50wY0iUhFENZuO+HLPc
X-Google-Smtp-Source: AGHT+IEXdqM5LOvnTndRtmqmOy9OVg/uJa+5xlbrEpwPonOFDnExwl5+h6Ue+XjXRQIfT3J1S1AXgQ==
X-Received: by 2002:a05:6512:e94:b0:521:cee5:db36 with SMTP id 2adb3069b0e04-52210074834mr15347725e87.48.1715868890346;
        Thu, 16 May 2024 07:14:50 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba517sm3030754e87.81.2024.05.16.07.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 07:14:49 -0700 (PDT)
Message-ID: <6f3052a4-e3b9-4ffb-9251-1f469e13a1d4@gmail.com>
Date: Thu, 16 May 2024 17:14:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] regulator: don't cache vsel to ensure voltage setting
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Okan Sahin <okan.sahin@analog.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
References: <cover.1715848512.git.mazziesaccount@gmail.com>
 <a8ee4ae5532b67a5aef0f6e482cb37f5efbd8952.1715848512.git.mazziesaccount@gmail.com>
 <f7cf4ac0-afa2-4f64-818b-1275b1e8a6ee@sirena.org.uk>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <f7cf4ac0-afa2-4f64-818b-1275b1e8a6ee@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

Added some driver folks to CC. It'd be great to lean how other devices 
avoid having intermediate voltages if range and vsel write is not atomic.

On 5/16/24 14:33, Mark Brown wrote:
> On Thu, May 16, 2024 at 11:53:46AM +0300, Matti Vaittinen wrote:
> 
>> +		/*
>> +		 * Some PMICs treat the vsel_reg same as apply-bit. Force it
>> +		 * to be written even if the old selector were same as the new
>> +		 * (but range changed) by using regmap_write_bits() and not the
>> +		 * regmap_update_bits().
>> +		 */
>> +		ret = regmap_write_bits(rdev->regmap, rdev->desc->vsel_reg,
>> +					rdev->desc->vsel_mask, sel);
> 
> This feels like a special case for those devices, for devices that don't
> have this behaviour it'd be a regression in that it'd increase I/O
> traffic.

I thought most of devices which have pickable voltage ranges and a 
separate register for range and voltage selector would need some 
mechanism to prevent 'intermediate voltages' as writing the vsel and 
range won't be atomic.

Also, the "pickable ranges" is not that widely used, and many of the 
users have the range and vsel selectors in same register (and if they 
don't, they're likely to see unwanted side effects due to non atomic write).

I did actually go through the drivers. These seem to be clear:

atc260x-regulator.c: vsel and range in same register
max77650-regulator.c: vsel and range in same register
tps6287x-regulator.c: According to a data-sheet, this requires a vsel 
write for range change to take effect (just like the device I am working 
with), so the current implementation may be suffering from the bug I am 
trying to solve.

Anyways, following might be unnecessarily impacted:

max77541-regulator.c - but, I briefly looked at the data-sheet, and I am 
not sure the driver operates according to the spec. The spec I found 
stated the range bits must not be changed when the output is enabled.

mt6358-regulator.c: I didn't find proper spec details.

>  At least this should be specialised to only devices that have
> ranges I think?

This operation is the regulator_set_voltage_sel_pickable_regmap() - 
which should be only used for devices which use pickable ranges. 
Furthermore, it's inside the else branch for if (rdev->desc->vsel_reg == 
rdev->desc->vsel_range_reg) meaning the range selection bit is in 
separate register from the voltage selection.

Anyways, thanks for the heads up. I really didn't know we had other 
users which would be affected. I'll consider adding a flag to the 
regulator desc for deciding if the vsel should always be written when 
range changes.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


