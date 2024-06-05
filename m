Return-Path: <linux-kernel+bounces-202921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD78FD303
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5271C21D82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E2514C592;
	Wed,  5 Jun 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gJGH32+u"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300314A638
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605472; cv=none; b=lannMOsZQRA1xjJLJM4gkylwHw8FheihYG50XbSb3dQ871Bn34mQyr9wo5Xi+FYz2DKwifxHrcPGUYkT6HyD22U4hiqwEpm7h0V1mZLj8k2vZnckOAO+lcK9+cuEcvHAB7UIdNYNAnkys7uGga6AqhgF9m99rIbkvOfK0zgO5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605472; c=relaxed/simple;
	bh=XX+huwjwxXiAHXaDzDQLJsOQbXWNqBU1ceVOi7U6icA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=als1ACH0HZ1SNtgUhRwr0ZPR2jsRA8H6n3sfz7Q2cDJqT+Nz75inr8ClXE0hGnja1i70x2SIuOCWQC567j4NsIjtzZpBczfhwQMbiWwI32xgHfylPBTjfgOHqHBHuG4XdmMBJjffYJv4DmzzwGZdGt3bP7ijLJYVd8dn9r5xGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gJGH32+u; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f93d757f29so1096226a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717605470; x=1718210270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T88mtNqFFHidmLO+o44TI3fxSRgnbbp5OjSG+hBl1R0=;
        b=gJGH32+ufMVZ2+lp5KAbAKFqUDUcUQf12CFlUGm8UT/nQSwsHa46nwdpuczqh9qVEB
         +UGDdZ/9KOB/IiIhQ0/eKnh9qR0KO0ZDQnZhSrb1e4HyRc66fvibVLf+VJ21sPsZfaJi
         XMZwUj2ChWFl1Y7I4qkWDRTzKFu4vKunum2xVQWg72MzeiXZizMNcB9JXRaSquD0o9or
         0ryMSLNt6fWsv0ihzPMbnhAxKpMjulJOEBwrI76QqcfSUMVDs5Pz55mqOGBIn0CK4FgO
         Fi5NmSmupZxAAxSKQ6vVWBG/heq+tbrL3LxzsZMsJfTsL5j7Aumg8ysqtjs/UtaVuCNR
         x7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717605470; x=1718210270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T88mtNqFFHidmLO+o44TI3fxSRgnbbp5OjSG+hBl1R0=;
        b=rSwz89uhbHtod0gWxMkPuxAKoP4Q1U7p8MXARWI9aFjxhAmV847hrLD/ahffxPfLnp
         uD6hPqLlJys4OJgMVAct9m/L1z5rkCUYxaQfNtkBx0cf9nHemPVoM/HSKfd2/5kceBrE
         ORCa9TfJ+avKF/sM4ZHh9oplHm0nCLuXUbDriHoNDNHLT6csDnASOMmVefcwaLXOMtMU
         6Rkg/l/OOOk3KYuAE7if4ksb8VVKskHf8wsPAcSWiIz7ahKXVwdrYo1NiaBmuWEZZjtG
         upwXWdT3aSti7QnOOrnSFbcES3bBidm4ormfzZxr47OeQ83RcB07EfvgC7eHSz3Lnjne
         sa5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJBelvx/IDL3d1G8ekb+ff69S+3oUg1ZM/3lBEk2teHqoJFQ63knrS1blrkS5TFmX7XKXNNkCrfz3bOdvYKH97ItCMWq99bvNmwonK
X-Gm-Message-State: AOJu0YzgM04Z7YvwwrZknYR+FPVqrm5Mka5kK3AjKXoJwcctQrnFH+k1
	h7yB+AdV6gg8NglAByXD5n3OHxiKgwx5jMs+QCt6h0dzbzJXBMqiR1iwYb0jMn0=
X-Google-Smtp-Source: AGHT+IG1+TSyofiZMeM3CSQ8w9yLrOVnPAlk8gySjDLEmwRAAzZr5h8YZ9HpFDMVBpblaXTkPD5Jpg==
X-Received: by 2002:a05:6808:2998:b0:3d2:9e0:b435 with SMTP id 5614622812f47-3d209e0b734mr94984b6e.5.1717605469848;
        Wed, 05 Jun 2024 09:37:49 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1fb7e7ccasm849977b6e.35.2024.06.05.09.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 09:37:49 -0700 (PDT)
Message-ID: <5dcd9701-2725-4aff-9e73-d8f2e038be75@baylibre.com>
Date: Wed, 5 Jun 2024 11:37:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
To: Mark Brown <broonie@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 7:24 AM, Mark Brown wrote:
> On Tue, Jun 04, 2024 at 07:41:47PM -0300, Marcelo Schmitt wrote:
> 
>> The behavior of an SPI controller data output line (SDO or MOSI or COPI
>> (Controller Output Peripheral Input) for disambiguation) is not specified
>> when the controller is not clocking out data on SCLK edges. However, there
>> exist SPI peripherals that require specific COPI line state when data is
>> not being clocked out of the controller.

I think this description is missing a key detail that the tx data line
needs to be high just before and also during the CS assertion at the start
of each message.

And it would be helpful to have this more detailed description in the
source code somewhere and not just in the commit message.

> 
> This is an optimisation for accelerating devices that need a specific
> value, really if these devices need a value they should send it.
> 
>>  #define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
>> +#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave mosi line high when idle */
> 
> Realistically we'll have a large set of drivers that are expecting the
> line to be held low so I'm not sure we need that option.  I would also
> expect to have an implementation of these options in the core which
> supplies buffers with the relevant data for use with controllers that
> don't have the feature (similar to how _MUST_TX and _MUST_RX are done).
> Even without that we'd need feature detection so that drivers that try
> to use this aren't just buggy when used with a controller that doesn't
> implement it, but once you're detecting you may as well just make things
> work.

I could see something like this working for controllers that leave the
tx data line in the state of the last bit of a write transfer. I.e. do a
write transfer of 0xff (using the smallest number of bits per word
supported by the controller) with CS not asserted, then assert CS, then
do the rest of actual the transfers requested by the peripheral.

But it doesn't seem like it would work for controllers that always
return the tx data line to a low state after a write since this would
mean that the data line would still be low during the CS assertion
which is what we need to prevent.



