Return-Path: <linux-kernel+bounces-186472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EEE8CC49B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D173D1C2131E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0257E57F;
	Wed, 22 May 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkYXCDCF"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64D1E517;
	Wed, 22 May 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393672; cv=none; b=Og5HW+3I+qo6V9enHBCr+lJZy3Mx/FMpxE35w6EnE0rA01lLvNatLdnh4GzcNWQdeBHncjcuuY9le9tIvf1/HTt+YWqzda7QLDzLcnWmTouTBKLW4jcrOwXrnRLiG+KdbC7H/+X+9H4BNn95KNJAW2E87yuhgXZVm7ffTnTEwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393672; c=relaxed/simple;
	bh=0NwHELK5RWKTIivL9B23dAYfk/7VLTkrUSaOqUW7hqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQJ7iLJ0sRCu8dtGRCpWhNlXPoqwkoSpE+wRSwGQh0YL8pBxNr0rTPaCH+/dBpL4i4gtav6u/Rmm/s8kB8HlmgcYTm1BaroOnG3e6EO0+IyWABHWx+5cL8hBsWcIjOSOpSbdyYELa0aaO9eybJqmSbWQ4lKDmHEYnpqrJC6T7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkYXCDCF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5238b7d0494so6905186e87.3;
        Wed, 22 May 2024 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716393669; x=1716998469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIobeHQ9aXYpTU7pQ4MI9CNM+eyMdAdKytPPJO9Bf08=;
        b=SkYXCDCF8B/9FZoPUmbuLow4kaHaPhzN42FJAyCVxw0U5PR9kxeIm2iHXyg8LG7Dgr
         EUacUu8t05STt4jBInSgsWZg3hkewMPH9dtevw1P5Ew/PH4AG2ypRRV61HOESkzE5Ppi
         yLuhc22pUHuKDryTsektolC/4Wgi5f4lkC8MmJlS7TXc5KOGm4EbV+xO9V4DqEPMz5U1
         slMYjQge6fVb5t9+Q5XUsZx9g5/Rcf+fv9B5rPlc+T/BKZY26hrYn1DGLd1qYqewFaPM
         uHvkov3mnPHMK1vyk5wbHMQup2XGM3faefrn9xWvzjFC6JrfEi2bALTvVbRHbEJym3I5
         Oxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716393669; x=1716998469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIobeHQ9aXYpTU7pQ4MI9CNM+eyMdAdKytPPJO9Bf08=;
        b=YmVM2RLrTc5P5myGXjnhyBAzIepbeiXIOK4JkoX0AEfN6XIP+JWUWZd5nnVZY/qY1f
         0Pjzray3mTkOkuDgiQ0BC1k2zbTJB3RG3LkL+wKikd27Ym9xfM0nu7RaD4IzDi4ll6ph
         jIfaxY74mEWUKAMDpB8Ev6H/qQtu/FOqatoTE3S7wHSh5bFutPOYDIHklZSzDs4QzhjL
         tyA90XDCmr3QfdilXEkzwT8KdJr5Sg+IxfP6SkaKfLW9NYpUNkOn4udoEq0tZP6PUK9A
         JSRXoC71yShJ9uU8iuc4PaO/4pA8T/u+bf3cLhK0qiCyXbCUYP8QGTt93q8zZkJs7Bk2
         32sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUys4SvII/Y1zz6C8aLtodPsMYxS1VwZGBIpvmQyz6d6aI23o4HzgIL/5Vsjztz1eaV6nSsgvhbcI3H6yNglx3+yWAgTq1JGakYdaNuXErarTWaNVQu/vOfNRtvWHtJYNY/reBdItZ60IYeI0T8xz1lIWkhNVjez+4Z02eJOJshUuXihqgY
X-Gm-Message-State: AOJu0Yxsf4RqSMSc76O25lRdoNAdsREJXSn9f0va8k8IphAXpQGj3oR4
	ZqtvlGevKFMc1o1Z/0kfzD+WmncHok7splqGcXifvSVEBd9aZsDGTPH8CR/ZrXZt4Q==
X-Google-Smtp-Source: AGHT+IFVYF5UzsimnCAVIh2Z+2dKzfEetDxdKHKILb3hiHlU0tIrBogpWtwdPZXOPzeDuTfOJfDBVQ==
X-Received: by 2002:ac2:55b9:0:b0:51c:cc1b:a8f6 with SMTP id 2adb3069b0e04-526bf268198mr1908594e87.20.1716393668325;
        Wed, 22 May 2024 09:01:08 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39dcb62sm5029515e87.307.2024.05.22.09.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 09:01:07 -0700 (PDT)
Message-ID: <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
Date: Wed, 22 May 2024 19:01:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>, Mighty <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lopez Cruz <misael.lopez@ti.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/05/2024 18:22, Krzysztof Kozlowski wrote:
> On 22/05/2024 16:43, Péter Ujfalusi wrote:
>>>>
>>>>> +      compatible = "ti,omap4-mcpdm";
>>>>> +      reg = <0x40132000 0x7f>, /* MPU private access */
>>>>> +            <0x49032000 0x7f>; /* L3 Interconnect */
>>>>> +      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +      interrupt-parent = <&gic>;
>>>>> +      ti,hwmods = "mcpdm";
>>>>> +      clocks = <&twl6040>;
>>>>> +      clock-names = "pdmclk";
>>>>
>>>> The clocks cannot be added at the time when the node is defined, it is
>>>> board specific. This way you imply that it is OK to have it in main dtsi
>>>> file. It is not.
>>>
>>> Wait, what? That's example and pretty standard. Example should be
>>> complete. This is not an exceptional binding.
>>
>> The fclk for the McPDM is coming from external source, and the McPDM is
>> designed in pair with twl6040/6041, there were plan for other codecs to
>> support the McPDM protocol and in those cases the clock would come from
>> the connected codec.
>>
>> The example (as the original binding was bit rot) is missing reg-names,
>> dmas and dma-names to be complete.
> 
> None of these properties are allowed by the binding and during these
> five/six revisions of the patchset no one raised missing properties.

I just by accident spotted this patch, I was not in Cc.

The reg-names must be set to 'mpu' and 'dma'
The dma-names should be 'up_link' and 'dn_link'

These names go back for a long time (~2012) and have been mandatory ever
since.

Yes, the binding document was neglected pretty badly but when converting
to yaml it has to be correct since that will have ripple effect on
existing dts/dtsi files.

> I assume the DTS was validated with the binding. Isn't the case here?
> 
> Best regards,
> Krzysztof
> 

-- 
Péter

