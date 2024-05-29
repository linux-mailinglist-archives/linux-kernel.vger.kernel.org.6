Return-Path: <linux-kernel+bounces-193724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5D8D3120
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DE91C20D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DA16B75D;
	Wed, 29 May 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yMEtW+84"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75733168C27
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970985; cv=none; b=cXADnuYawm/J9ipuBrplCx9SSti6RzKL1MtQ6eE6dI9gz7zEfXAezDCzyTYBG5xqFtVruhQeukM78v6PElTsfWOuOPYusAotfphTerSdXd/RGwRLcplWovcAffRx65floidX8n1EbpY6M5Ht2zPCtGj2TGJw1uAqkk0GJKlhnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970985; c=relaxed/simple;
	bh=v1feN2NUrI9P5EUMAciZLEbJjEX1j1A38in4ikzn1wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYapz7Nk1oVqFHwykNGHDfy5/XNtCobp8oIUDMy7lwdMrjF4kNB+uLPMiJ29yEV994+e1sCwUMmbB0U5KmnUgdq96bcYOOxGtBIKjspIcEC1EI0+oTxhU3pj1S4V5qArwIY44SfttGTJqGAM5hpVu4x3j2EqbgblJMdmBcJ5Qt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yMEtW+84; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421124a04d6so15334615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716970982; x=1717575782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cyv9PovJHSSHJvMucpyIOkl77eWjr0heW5XICt5+8X4=;
        b=yMEtW+84oVmUaG2flLfTP6tMxeq92w9NNWMWzXdcsTo3boft9KnTjJLGGBehofyIVH
         iDsH5jdVccdpz3WE14xGFcR6GYZCRutEckW4YUjTCSaNAiDtWKB/utXN4Rg3WXDJeeNP
         mCa0cPB4skWZV4YCTVNR2GmUNHwT6Qidv0E/sQkkjTO0WgCSKQbo+jmKaerx7z6a5Cac
         wN8j4h/yF/3dOAM88hwLoAQZo3a1KigQv3vdrRqpIEJd7PfT1pWuVn3NdpJeh3cVDxuW
         ONW/kejCX0nkzRl3MAwWPVEC61lY6M8/y2PNl3t83SfCDWM/CmXO1zR8HHZeM9n/V8NR
         cJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970982; x=1717575782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cyv9PovJHSSHJvMucpyIOkl77eWjr0heW5XICt5+8X4=;
        b=rhwYWlgEu7UkHJvONCQ0INGUZv/hahjqBY+WsFR3B9hgBFqySXpUk/04N22TPHZmL8
         D1d3rEYpaTADWGjJ8eO0UiFPtoCsa804hNx3aoDQVntlkPBOiGjQ8y4ac04wlJ4ldrrc
         YxwU2Q9oHOZ77aevqBD2wDle3iUHESqTehDL9Z9/eeb3xnMdmwTjxfNRu/k4R1MOwVH2
         sx2d0yTEaAZMvWDIxTD+HCXFYi9OkGiAPGYeqHVwquEQk7OVlJxeHTfnuNTPOj3Zry4E
         A40We0V4Lxquc+cRmmyx3tFWu4+lJXByguKc3+WlW39v7AEoXb4QSozBRe/URvi+W6oz
         CnBg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/tJAt5ObjkhlsSlPf6HdLd5YE1I2UvQmY8kxtSEHgkDPqtt2o1l8J/mRaeM2PFp1HcOPbDsIfS4B7GDrcilgMJFBcGcCS2cCVhWF
X-Gm-Message-State: AOJu0YzUStDDB145HviKMMFjSqyJpytMaCcS2RPVeq+3qYBgNnYyPlnG
	n6NHeXhQ8ASFB1xmMTgX+EVeUng33tmwPMUcEIlz6CJSE0gZn2Ep3ewIOl79Ehw=
X-Google-Smtp-Source: AGHT+IH+woaE6GlA+cs5xDP5OfdceRBKfbkhD/cWJbIr1gI4V+CXAq4EQPV6Kc26S2O+apzzp1XHog==
X-Received: by 2002:a05:600c:474f:b0:421:10e4:7f6b with SMTP id 5b1f17b1804b1-42110e47fd9mr78062025e9.27.1716970981790;
        Wed, 29 May 2024 01:23:01 -0700 (PDT)
Received: from [10.1.5.19] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3582917b222sm9606959f8f.93.2024.05.29.01.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 01:23:00 -0700 (PDT)
Message-ID: <1c83bd93-92b3-4986-a154-69ae792e57ba@baylibre.com>
Date: Wed, 29 May 2024 10:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] thermal: Add support of multi sensors to
 thermal_core
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-3-abailon@baylibre.com>
 <834e18c7-21b6-400e-aa61-a4f591027620@linaro.org>
Content-Language: en-US
From: Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <834e18c7-21b6-400e-aa61-a4f591027620@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/27/24 09:00, Krzysztof Kozlowski wrote:
> On 24/05/2024 16:31, Alexandre Bailon wrote:
>> This adds support of multi sensors to thermal.
>> Currently, this only support the get_temp operation.
>> This returns an average temperature of all the sensors.
>> If defined, a coefficient is applied to the value read from the sensor
>> before computing the average.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   drivers/thermal/Makefile        |   1 +
>>   drivers/thermal/thermal_core.h  |  15 ++
>>   drivers/thermal/thermal_multi.c | 332 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/thermal.h    |   5 +
>>   4 files changed, 353 insertions(+)
>>   create mode 100644 drivers/thermal/thermal_multi.c
> 
> This does not really build...
Sorry for that. I have not rebased and tested my patches on the latest 
master commit. I will be more careful for the V4.

Best regards,
Alexandre
> 
> 
> ../drivers/thermal/thermal_multi.c:249:38: error: initialization of ‘struct thermal_trip *’ from incompatible pointer type ‘struct thermal_trip_desc *’ [-Werror=incompatible-pointer-types]
> 
> Best regards,
> Krzysztof
> 

