Return-Path: <linux-kernel+bounces-555016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB12A5A480
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D5318935F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B401DF73E;
	Mon, 10 Mar 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNFjQJDr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641E1DEFF1;
	Mon, 10 Mar 2025 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637594; cv=none; b=SslX9icg3amVAhX+njqaoJ6UYhCy/bmOFjg72d6cmnRxDMJArtaprysFt2AEAh7F1Vo7FwIZiPB9DCJfW0AxIO4m+YHU7+gWqHkaZaATuOogt5GD/vukKekT0q/AH2/Zdb/fJbZ89fkfrYolVArK4+D6My2E0rGppZDZNFo3vVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637594; c=relaxed/simple;
	bh=djGQzPDRHihBhVF2Xb3tODY9B+9AzijudFGky+2x574=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dW2lb/LKTLScyA+15KASj+LYDumNEdh/HeBl9VwbsnHvkHWnlKIm2+Wqs24zw4/wSrhYh4wr9w8ubsarNdW47X/W5dCsImYtMX012wnDTakPhN5eyVLcOxHOVoo5QvPRalXQS4PFuEvyhLfldDmOgFC4D6kU7Z66Z451/u1Ef6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNFjQJDr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac25520a289so592098366b.3;
        Mon, 10 Mar 2025 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741637591; x=1742242391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84eM2Dk+TJZw7p32MuoSqAq/Wf6WjYKMiu+Het+Ec0c=;
        b=ZNFjQJDruwBZjsl+NldbLgBoJNGFbx5qfeVAAhKw/fU5gy4b/vURekr+leq2fyJYtM
         sjZ/G6r79uJDEzEL+KcLMPWcyJEJYal1zwWku8YNB5nz49wlhJL9XI8IA08o0CoPLf5J
         XTBalCx5UthAq9ktRbm6KFUkNReUb/qKHtInhO31CVcrjY4oJ0mLH2mzUs72E3AVEz0J
         Tb3wce+QI3c0GOw6rjUm4K99ZscP7n+pwWiT13klGaRlxonXox4Wg4XSFk7/a4QdK0VO
         7SUAL4Ulia6jn1iGOP+TXojquhuXX79rWyrt+CmwaV/EjPwbq5waNNPSKHk3JidNc1px
         akYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637591; x=1742242391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84eM2Dk+TJZw7p32MuoSqAq/Wf6WjYKMiu+Het+Ec0c=;
        b=kwtm9Oi2KS5QYYeMjEjkL4JBdcv5o7SbOUCBYN853QMxfVJUApJufCYhHfKR5aLkTS
         no8hEVq0OYQHS3Xs+pYYiw9JKusPz26/U1BNRzwvHgOs6tBrRWT9JFVm1kw16jtE2Fb0
         XNO1vzOEZwIZ8ddteByUidufafLRnT1oujlrThO6dvdEdjsWqUeASUbVKn3Fqpr10UEK
         EYm9swfkdhLDn37XUM/yN/rbMMgi4MggH6gaw8SzpK0N8Cufn6/bs6Aom8BHFtdrJp2+
         c0cQM3hrMmPvf5UuCSTJslX/fK2c8gWlVBIkWx9r3KQacdQEhJgK4aT73UXb4Gj1A0FY
         ybfw==
X-Forwarded-Encrypted: i=1; AJvYcCUTa27kbidrQFoNfFP7HHpuXEPwYowMYKH6qP+Kj+t/c5MVppv031jB95mgTC2CkrfQpjasOaLl5XTS@vger.kernel.org, AJvYcCWhQW0UQK6Z79dhMmycVqf8PpIScqIFwnXi6YdYe40OpFciJWxecdE5S6x74FvUixUggh64+MSzzB3t@vger.kernel.org, AJvYcCWxNjBSZrUV4RlAThe3Mu92iV8ecMM4G3ZNfRbv3kFb/kh1Y4SSRhPibTNfYp/MwRFLAycGvjhzDGuZPB+D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fZq6/QeGviJtYD0oUe9vinKopvMe7gGwyLlMK3H9uFJqtNSV
	/3817JrkuKYk+uY0tb3su+8g5NNfgh3hpiTEJ+XYq0cHsIeYFy+l
X-Gm-Gg: ASbGncvsL3f9z2zRVBEtRWTetBNVCqQ7SQSjOeDPbqJRPI+YIeHpKu9z4RD9Ev444dP
	kt0EMblTRkAjoE8twDF51rE3+eD9lHbIaWlMopt0tD3JvOUkGH87xMbFGG//gCIb/s+CoAIVlrl
	jkjANvj34JKw1GHsi2htZ1eRlxLUZON8pkKry8xOsDyesjqIInln/FGcgX4GjZvaJMzFnGlnJ/T
	U5wWBKdJHY32Cv4VliOsaIhdM+dzm7Roedps5VuJD2z6JhNXpOyG0Y6z2KkyirjSfuzbVIM7X6y
	HRbFc2mMJiZLLlsMG8KebpjYbyUpp6zWMb2bnoCqEdLd2jhZCq36H5/Lx/EkD9f3TxtU+Hpq9Nu
	4qEGjt20Q1atlkZv5BF76mA==
X-Google-Smtp-Source: AGHT+IG2vqiPQWzIE4Xso7GgDIyQfIUK5LXugs0CoXSWts52ndkzePNhOoEa8Wr3fgDWQugNCpxHUA==
X-Received: by 2002:a17:906:d283:b0:ac2:7dee:cb15 with SMTP id a640c23a62f3a-ac27deed088mr1040493466b.33.1741637590560;
        Mon, 10 Mar 2025 13:13:10 -0700 (PDT)
Received: from [192.168.50.244] (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac289a79b33sm359260966b.65.2025.03.10.13.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 13:13:10 -0700 (PDT)
Message-ID: <145c65bf-fbb1-4256-aa36-2079fe42e1a3@gmail.com>
Date: Mon, 10 Mar 2025 21:13:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dt-bindings: clock: brcm,kona-ccu: Add BCM281xx
 bus clocks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-4-d6fb5bfc3b67@gmail.com>
 <20250310-orange-frog-of-abundance-af80f3@krzk-bin>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250310-orange-frog-of-abundance-af80f3@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.03.2025 10:43, Krzysztof Kozlowski wrote:
> On Sat, Mar 08, 2025 at 08:50:42AM +0100, Artur Weber wrote:
>> Add bus clocks corresponding to peripheral clocks currently supported
>> by the BCM281xx clock driver and add the relevant clock IDs to the
>> clock/bcm281xx.h dt-bindings header.
> 
> Please squash the patch so we see complete change.

> 
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>> Changes in v3:
>> - Add more clock output names to example
>> - Drop CLOCK_COUNT defines from the DT binding header
>>
>> Changes in v2:
>> - Add this commit (BCM281xx bus clocks)
>> ---
>>   .../devicetree/bindings/clock/brcm,kona-ccu.yaml   | 33 ++++++++++++++++++++--
>>   include/dt-bindings/clock/bcm281xx.h               | 19 +++++++++++++
>>   2 files changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
>> index dff04e24e92829b890bf7cd336f0e083bdb30fa6..d00dcf916b45904177614c6f19a5df02abdf42f7 100644
>> --- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
>> +++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
>> @@ -40,7 +40,7 @@ properties:
>>   
>>     clock-output-names:
>>       minItems: 1
>> -    maxItems: 14
>> +    maxItems: 20
>>   
>>   required:
>>     - compatible
>> @@ -61,6 +61,8 @@ allOf:
>>               - const: hub_timer
>>               - const: pmu_bsc
>>               - const: pmu_bsc_var
>> +            - const: hub_timer_apb
>> +            - const: pmu_bsc_apb
>>     - if:
>>         properties:
>>           compatible:
>> @@ -86,6 +88,13 @@ allOf:
>>               - const: usb_ic
>>               - const: hsic2_48m
>>               - const: hsic2_12m
>> +            - const: sdio1_ahb
>> +            - const: sdio2_ahb
>> +            - const: sdio3_ahb
>> +            - const: sdio4_ahb
>> +            - const: usb_ic_ahb
>> +            - const: hsic2_ahb
>> +            - const: usb_otg_ahb
>>     - if:
>>         properties:
>>           compatible:
>> @@ -116,6 +125,16 @@ allOf:
>>               - const: bsc2
>>               - const: bsc3
>>               - const: pwm
>> +            - const: uartb_apb
>> +            - const: uartb2_apb
>> +            - const: uartb3_apb
>> +            - const: uartb4_apb
>> +            - const: ssp0_apb
>> +            - const: ssp2_apb
>> +            - const: bsc1_apb
>> +            - const: bsc2_apb
>> +            - const: bsc3_apb
>> +            - const: pwm_apb
> 
> Why pwm_apb cannot be after pwm? Any idea for sorting here?

I placed all bus clocks corresponding to peripheral clocks at the end of
the clock list (so as to not modify the IDs of previous clocks), in the
same order as their corresponding peripheral clocks. This applies both
to the dt-bindings/clock/bcm281xx.h header and to the clock binding
here (I kept the same order of clock names here as clock IDs in the
header).

The same reasoning applies to the BCM21664 bus clocks patch.

Best regards
Artur

