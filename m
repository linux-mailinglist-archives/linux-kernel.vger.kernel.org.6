Return-Path: <linux-kernel+bounces-338320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47406985666
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A38A1C20C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB4015C131;
	Wed, 25 Sep 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsP4uClB"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4013AA53;
	Wed, 25 Sep 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256810; cv=none; b=X3RQ/3criFo4VVTb3Hd/C6QRSb3cLvO2Cf9tBT3LNJV+LTKTDuqAnpEUhFvxA3/32yrOnfr/WJ486YmCeScNwOoQrDj9P8TxOErIDzGJRfRohks5rlOQ7yqtQ5F/Kz848RJ6KllQ/hbxg23Qv8MG1kt+qZbj7mVR1HUA+wAeIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256810; c=relaxed/simple;
	bh=ZnbvCMF96CsvEbtClCAAQImg2PvPZlO/DszJ/+cx2TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onO8pc9a9S8TxUiLQYQXG1x7yfcqOt7EFJvxSjOyfPb8Gk/OQsJbVUv7kUqWcf1t3BFycQOPEwHd4PTt1HlkKGXl1RWUeWUWgoXLiFHrxbZSD9oux7hf0vJ2/Or7ameN1J8JuBLqmQm6rk93vCUnOsxu3zVy6UMI4FzOSOMEYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsP4uClB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d8741c85bdso1229702a91.1;
        Wed, 25 Sep 2024 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727256808; x=1727861608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTnW+x3uiY9PZFBuRS08htcBxI/l7aF5p3MhMKHERVk=;
        b=WsP4uClBKHVaxN52U0Q/bq3b7NUMawzWx6nKKuIktqAvkL70V1ZVIofopLjw8WFSDE
         06n0R1RHy7iULqJ4p1we23JESntZXAlLZWIVBvURlnypqwL6uW7E/qhAcyYPZFV5UZjK
         0ErTTQ0/xYC4FnGYFBAmDRIxN9/EyiE+ZArFetnXV1GU54dTlU2xdyyjAQFwhWvSaJNd
         NRovqFLJnGm7HJSWNXe9EFWAB3ZbQ7DVKvHYH5myFTFh2UuY+FiZ2xfTER8GZ3EgIaRz
         vabKC4/OCCDtK+miuNdOQhnNeFttWF0zK2mbe9oynB7qyfIDIGTH5Rbp5j3z9geWB0Kj
         0KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727256808; x=1727861608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTnW+x3uiY9PZFBuRS08htcBxI/l7aF5p3MhMKHERVk=;
        b=K0cKN7jO6r1KwYXH1jErNAKpnscVMxnRrLd3F2+AugH//CR1GcjNh9aYiu0kG0R5qW
         P1Iwr5Y1/XGuAfO1RFM9xnref2nDioJO2slh6YhY7A9bK1fD+J3Cm+PhQ2XwCiQwqwW7
         8JI1y7X5X5RnJgTBR1xIYJx8fiOhZ3mDpEii6HHe3S8VynLUrKKR2y0dM5KFdEXG5AOz
         CkfHypsXbSfPcUuKfxGsdqL/I4NF2iXHZOYOOpAa7JA6vYm9U6K4Wut4rPenn7akrq4P
         ZJHqCnouTr7CjxsjLW78caUs5PRKiwwS9XWQp9kS+6TsPENd/RScalQQ5a0/0F+X4hHP
         wmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT4+TcAAr+j6ulbSXjLJ8MWJebCjNMm0vG+d0VJii/xssSj6gXD5um+7BXWlFArfaH+e7odYTh6baM@vger.kernel.org, AJvYcCWEhdl48k+v9cljZwTLlQE3t20ENg92tUrfbocqMlEfCrlVCrk43ntjFSAmC84kzfCYGT6Gy8GEAAnlx2na@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gzqwIFFocFHcu1PrjacUWjMZ+E0so5IyINnXVkv2Zcns8x1E
	7kQ84WMVdMEfGlbaUkipo2ONpqJbGX4TXV8t+43II6aSjsAN8fdfjB8dsozw
X-Google-Smtp-Source: AGHT+IFoqwRa4nudCQClQnXhVG/UtD92iscogH08fGdF4mcVCB1T5D4jAdS0xo8eFS8JNXfP2KU3og==
X-Received: by 2002:a17:902:c409:b0:207:428d:ecc0 with SMTP id d9443c01a7336-20afc4d8c51mr12165995ad.8.1727256808306;
        Wed, 25 Sep 2024 02:33:28 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e070dsm21527165ad.9.2024.09.25.02.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 02:33:27 -0700 (PDT)
Message-ID: <ea3b0968-ffff-4629-b65b-db508f6e1395@gmail.com>
Date: Wed, 25 Sep 2024 17:33:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com,
 Frank Wang <frank.wang@rock-chips.com>
References: <20240924085510.20863-1-frawang.cn@gmail.com>
 <20240924-overtly-curable-13df2e7fdc9b@spud>
 <87146372-6d05-4994-8f64-47f4cb07e2b4@gmail.com>
 <2a4200ac-3ea2-4449-94ac-c4b9f37ad800@kernel.org>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <2a4200ac-3ea2-4449-94ac-c4b9f37ad800@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024/9/25 15:16, Krzysztof Kozlowski wrote:
> On 25/09/2024 04:09, Frank Wang wrote:
>> Hi Conor,
>>
>> On 2024/9/25 0:11, Conor Dooley wrote:
>>> On Tue, Sep 24, 2024 at 04:55:09PM +0800, Frank Wang wrote:
>>>> From: Frank Wang <frank.wang@rock-chips.com>
>>>>
>>>> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
>>>>
>>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>>    - Categorize clock names by oneOf keyword.
>>>>
>>>> v1:
>>>>    - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/
>>>>
>>>>    .../bindings/phy/rockchip,inno-usb2phy.yaml      | 16 ++++++++++++++--
>>>>    1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>>> index 5254413137c64..8af4e0f8637fc 100644
>>>> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>>>> @@ -20,6 +20,7 @@ properties:
>>>>          - rockchip,rk3366-usb2phy
>>>>          - rockchip,rk3399-usb2phy
>>>>          - rockchip,rk3568-usb2phy
>>>> +      - rockchip,rk3576-usb2phy
>>>>          - rockchip,rk3588-usb2phy
>>>>          - rockchip,rv1108-usb2phy
>>>>    
>>>> @@ -34,10 +35,20 @@ properties:
>>>>        const: 0
>>>>    
>>>>      clocks:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 3
>>>>    
>>>>      clock-names:
>>>> -    const: phyclk
>>>> +    minItems: 1
>>>> +    maxItems: 3
>>> clock-names isn't a required property, you can't allow jumbling the order
>>> like this does without breaking the ABI. Why can't the new device have
>>> phyclk in position 1?
>> I sent a draft changes in patch v1 comments which put the "phyclk" in
> No, you did not. You sent buggy code which was never tested.
>
>> position 1, Krzysztof said I have messed the order, so I reorder them in v2.
> No, I did not. I said your current code (from your reply or patch v2)
> messes the order. Even though I sent you reply that this code is wrong,
> you still decided to ignore my feedback and send it.
Sorry I misunderstood the 'oneOf' and "order" you said.

I shall amend the patch and send v3 later.

BR.
Frank

> To be clear:
> NAK
>
>> Did I misunderstand? anyway, should the changes like the below?
> Read all the answers again instead of putting wrong words to wrong patches.
>
>
> Best regards,
> Krzysztof
>


