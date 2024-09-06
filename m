Return-Path: <linux-kernel+bounces-318505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837B96EED8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5D31F255DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61B1C7B92;
	Fri,  6 Sep 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yb8Oxr65"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A761C7B7C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613973; cv=none; b=MtsWb5CpUgkTO+qocM4Rld+pwDd0NSnvZLy3xTe73NHLyuAxmFxLp5wsAivSPzOeJ+7bJaBUNG2CWs+iFe7K3u4ysrJUv4v2VZBB7uP4VzXnvwLAuUZt76T1RCZq10OWNp+d/jjVAyTbeMEw+09jUKKb/quJZ/PskwAqnP3cEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613973; c=relaxed/simple;
	bh=3P4U2c/xG3RMaKJu/FZmMqv7gk2YDpQyenJgLHL65qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZji/2BumjMT2kHZrDgVV6db8A5VMsZn6RE+jTFw0pkVQyJeo9ei1Tb+oXzVar1uQiKaVD7ikVvHwguxQwm5t+EBnyEhmPte1P3Vft7b25MrGvvPj5dEQENugCLFvHuga4G8b/L5UHchqo1wgmsjvqJo+iQ/lBw5SFc9cTCLcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Yb8Oxr65; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so1080026f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725613969; x=1726218769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s+UppKbAeqOL7Uk1qqGcQjsJvrUCCT+GeLwSOaPGy8=;
        b=Yb8Oxr659fNszjDv80UTSEkMADBUHAq4S6pyztDn/p1j3W6tmS5vwkb63yzL+YzacQ
         zWWfR78zykAv+9BG8MELVfq4CMFk7BNZlMDjjREquFAmhfe6ZKrW8TmF9+InA7554VLI
         C/pUsNxnDenTDX5dc1/haFcoGhPtG8Law6dov8X+9XPmcWn248NlJygArB6lNaA5/GXH
         liLfIgV4Y5eM1woBkJ+cWClESoj+XTwe94Zc5WLbg7gcwZsQgCD9Cz8mpDwVbVhe6Ino
         1gjFhAnSmWpjsCb9vx2sOW/zZF/L/Ax2TyjuzM5RfoB9qACLwY36+Q7zKQeaaRHGKa9f
         2LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613969; x=1726218769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s+UppKbAeqOL7Uk1qqGcQjsJvrUCCT+GeLwSOaPGy8=;
        b=otba77oZZJC48Rgdu70sYspawsdqX8yynQ8YEK+Htp56f0gi1NSYwU9n4VAMr6Weiq
         vGBwQZgIiJU/OHdCqZKCy48PCaBiIRGG806+khzKuzM8G57clfXKJtWzt7k9f3iwpLjl
         kmb851gSFm7Rdr67xjiShwjiKxD5DPsVGYJZpKcUAAkta3QBEFfSkJXjv5NSqxJoLXpT
         Q/kLG2ipZfJUql41O49o/uhTLYndEOJ4Hi1l2/jTqG9UHt76Wzw7CRFKPLHIUHsgc2do
         9H6g3rveJM2cwGV65kWVfDJUODgzizTqrOz0orWxSTQotaaHlK6tFvPwf6s2gMRNATba
         +ghg==
X-Forwarded-Encrypted: i=1; AJvYcCVXhvLv9TbXDOmr4H9HT7YArQyqe7TYG62K+cgZqjIChuL2z3GBqr0F5Y75vNh7H7moqyDUVgAo19B848k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQXoc/7BpVc8gmfFMj/bMQ6wPreIzEKNYAgFKPWJuNS1PGlVK
	9JQ4TcrtQIeXuvuUyMphvbEIoNTncFtGL0CNhMTSZ5PMAX5ln72mChTNZHPbIt4=
X-Google-Smtp-Source: AGHT+IFb8h9Am+OxujV9k6mxhWxZfBdfSFD5yvzHGeIL2yjli1dhEsNM1lVw5wVFjsaybqLmFMEcNg==
X-Received: by 2002:a05:6000:1fa7:b0:374:c847:85e with SMTP id ffacd0b85a97d-374c8470bbamr14020255f8f.13.1725613969139;
        Fri, 06 Sep 2024 02:12:49 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef81146sm21321686f8f.82.2024.09.06.02.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 02:12:48 -0700 (PDT)
Message-ID: <fd3f4874-b410-4e98-acba-d0fac041a40e@baylibre.com>
Date: Fri, 6 Sep 2024 11:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
 <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 06/09/24 9:22 AM, Krzysztof Kozlowski wrote:
> On Thu, Sep 05, 2024 at 05:17:35PM +0200, Angelo Dureghello wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add a new compatible for the ad3552r variant of the generic DAC IP.
>>
>> The ad3552r DAC IP variant is very similar to the generic DAC IP,
>> register map is the same, but some register fields are specific to
>> this IP, and also, a DDR QSPI bus has been included in the IP.
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
>>   Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>> index a55e9bfc66d7..c0cccb7a99a4 100644
>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>> @@ -24,6 +24,7 @@ properties:
>>     compatible:
>>       enum:
>>         - adi,axi-dac-9.1.b
>> +      - adi,axi-dac-ad3552r
> I am sorry, but what is the product here? It looks like either wrong
> order or even completely redundant. What is ad3552r?
>
> And why versions are mixed with real products but without any
> compatibility. What does the version express in such case?

dac-ad3552r IP (fpga) is a variant of the dac IP, very similar,
about the version, it still reads as 9.1.b

so i can eventually change it to:

adi,axi-dac-ad3552-9.1.b

Should be more correct.

> Best regards,
> Krzysztof
>
-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


