Return-Path: <linux-kernel+bounces-337890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91119850B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB7B283E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E31482FE;
	Wed, 25 Sep 2024 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDzV6dgS"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC152E83F;
	Wed, 25 Sep 2024 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228991; cv=none; b=iLzGCVxDC0YtF6FUE10hXywpf22TLg/pPiTd4FvnEJT3bv0K1h4XLzNMTctITwqZJOR4X5CuQPqHExBYBh6ad3P/Y45TIYLEEOs+FZlYwFi3a6HyJb0iM7Ou7MR1ZAn5egO1JUoHE12DqaLgnJ1VIGJ0L4/HGkrwB5J7VWHHeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228991; c=relaxed/simple;
	bh=T/RmI0pD5sA7gq7g/Xw6pv9qbfNnWgxjYriM68Tj61U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It5UZl8O1+QrXrgZ1y3qY1Sx+Ad+5BEZuwu2zvlvCKQOESaMw0bdZZvtzzT0k+xYEWn2jst6eQh7NcTwtzgir+N2tu6nXONCvY0mbrj+PzCqrbmw2TAHb2H1QEmS3CYxPtSZrMtFTVKKP/YkMss2P15xMPRSGSEqDmf4Wah+CWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDzV6dgS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2db6b13c6a0so1123824a91.1;
        Tue, 24 Sep 2024 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727228989; x=1727833789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfgOUAOcbkxFyXWTo9S/L0xB7TtcO2Ot01YMhuKobrk=;
        b=TDzV6dgSM79VaE9UbZ0KBt0+/ox/GF3GC47JbTlA5Abe17A8+d6m9W3b/28jlkcFxj
         QX30/Wg032ugpclqyYEYLI+t8Uoz8x07fWWWLQN20CWkxqIpvpo/vB+xXVqzwnEcjeuv
         Nc8VVVb/xcprjzr8U5OGWbbt64qEJoOflrsO5NZaw2Es0B+VwMTtA+sdoOlMPtCaQB7i
         8k/+43OykpW2d1Di+y50jogWUJTDN//BGI4k9PXkPRDX2pRMweunLK+9TsySGnubMdku
         biJpNtn4aJpnsU4A2rAt6XLOBGd5DO7Tqc3uB/v8MQO7ceMMV4Qpo3/OQzd7lPdbcbyH
         3qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727228989; x=1727833789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfgOUAOcbkxFyXWTo9S/L0xB7TtcO2Ot01YMhuKobrk=;
        b=pwBBdTIDCPyxzcGkC1S0LjOU0sTtqcz5nwNgYnBxg+wgFvEJSwjJb90pmnZDSmD/wc
         ENwJ8hyd0SHuA8qB16VdQaGO+pcGDoZdCOvhu6By1mP2TM7MkC+0YnV6dZbGYZX4g+os
         8b4pkt1ViY/2qykrbQtmW+aX4QfW8PIxI5JkEQaKk8o8IYpekLn8/eHdFo1o96OqCUAz
         ycMm9TEqYklebJlTKUaLMlGoDH5gGDBgRvU5WALJINkTN2HI2H9H13mfLIBk9FKrjtJz
         N5MXSgAXR/4PpVcrrog3OiH02SZPEnJmOHz2PADQW1XKBqEbv0B0sGS0mJH2+2RlhCPW
         QjOA==
X-Forwarded-Encrypted: i=1; AJvYcCUxspAaO6IpkAZPDPL5OBytDMMJANlmQ8yp0qG/sh/UaQ7JxaIBkRl0EflnlZb0Wxl+SlDu+fMCroXX@vger.kernel.org, AJvYcCWk14rXG+6HBOBJRh2n8XxwgqFMIBDYzZeGN10bLESrSLT+LH4Ahkd+ctu6JVOJ2zjG7s/8KtTT/gZXtyB1@vger.kernel.org
X-Gm-Message-State: AOJu0YxJU8rQ+Mi6NjKyr1UsB5uwp13NVreRqrUS+RlTOSCvMy3aDy+P
	OZ+mSyQEj4rP8UpYfr/yh/zoM7Sg2u4LqwCspQKCFshU0+tlvxwW
X-Google-Smtp-Source: AGHT+IF42uHxU+McaJwOYqt74xfZ3X9l8ZaBFNhvW3sc2MTkO66TCrdx6QmGA70vRyBEU069n7D27w==
X-Received: by 2002:a17:902:eccc:b0:205:9112:6c38 with SMTP id d9443c01a7336-20afc47bbe0mr6799845ad.10.1727228988969;
        Tue, 24 Sep 2024 18:49:48 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e5551sm15517245ad.6.2024.09.24.18.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 18:49:48 -0700 (PDT)
Message-ID: <285d7b52-956a-412d-ba85-7641e95226e5@gmail.com>
Date: Wed, 25 Sep 2024 09:49:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
References: <20240924085510.20863-1-frawang.cn@gmail.com>
 <11146778.5MRjnR8RnV@phil>
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <11146778.5MRjnR8RnV@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heiko,

On 2024/9/24 18:01, Heiko Stuebner wrote:
> Hi Frank,
>
> Am Dienstag, 24. September 2024, 10:55:09 CEST schrieb Frank Wang:
>> From: Frank Wang <frank.wang@rock-chips.com>
>>
>> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
> can you please add some details to the commit message, about those
> new clocks. I.e. what they do.

OK, I shall add in the next version.

BR.
Frank

> Thanks
> Heiko
>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>> Changelog:
>> v2:
>>   - Categorize clock names by oneOf keyword.
>>
>> v1:
>>   - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/
>>
>>   .../bindings/phy/rockchip,inno-usb2phy.yaml      | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> index 5254413137c64..8af4e0f8637fc 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> @@ -20,6 +20,7 @@ properties:
>>         - rockchip,rk3366-usb2phy
>>         - rockchip,rk3399-usb2phy
>>         - rockchip,rk3568-usb2phy
>> +      - rockchip,rk3576-usb2phy
>>         - rockchip,rk3588-usb2phy
>>         - rockchip,rv1108-usb2phy
>>   
>> @@ -34,10 +35,20 @@ properties:
>>       const: 0
>>   
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     clock-names:
>> -    const: phyclk
>> +    minItems: 1
>> +    maxItems: 3
>> +    items:
>> +      oneOf:
>> +        - description: aclk for USB MMU.
>> +          const: aclk
>> +        - description: aclk_slv for USB MMU.
>> +          const: aclk_slv
>> +        - description: PHY input reference clocks.
>> +          const: phyclk
>>   
>>     assigned-clocks:
>>       description:
>> @@ -143,6 +154,7 @@ allOf:
>>             contains:
>>               enum:
>>                 - rockchip,rk3568-usb2phy
>> +              - rockchip,rk3576-usb2phy
>>                 - rockchip,rk3588-usb2phy
>>   
>>       then:
>>


