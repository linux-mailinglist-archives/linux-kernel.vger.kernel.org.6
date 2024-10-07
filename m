Return-Path: <linux-kernel+bounces-353051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A39927AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127411C22472
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E122087;
	Mon,  7 Oct 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAc+TxDs"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328418BBA6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291477; cv=none; b=btXUJ8dknEmqlR+W4d5Y+N3USnFYV65MfusAYuYcIJpTSBQgey7Fq6l/Z5GuAY6MPE9KEuBvrtMu3F7gK/ccfvtSIRGCdMSqT/Lg3lKufBmWdO7PSmNFocG0PdDl/grXij1eZIb0D3E3EEHvcFvzt10iYIlyfk1QtudX3Q/f3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291477; c=relaxed/simple;
	bh=o6axreySiLiy8tZaDub/QM2xsjgpMHcq9uLIaP5eleo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AaFgXL6QaLp05EqsxWuYjNODlMOnV4p1DDpNv1tIe4z4ep5G9Ea0lnPqwF8rGwYOiUVsmidUSEQDOClJSqKfyahJhoWS1Ai6FEJfsCd1QSrA77Bn3nOYrLeS2xoLy8mxWzWz3BLdY93lXvRFK1nRhUy4m0SONhYY31jKy/eB18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAc+TxDs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e5e758093so35400795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728291473; x=1728896273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGBBMU8rFx26oRjbd1HxpI/xco3E3mGApwngB2hx0UA=;
        b=SAc+TxDsNzFyGot0PfbWfmi7bonOOMeRG1X/EmKs7a/ycBoENToS9kkShgXgW6hQig
         swKmfasdkoR4Y/dNIHZUcdR5P9/ovo33iX5OWBRKYwRWN5oejMt6ClgKBWUnfW8emxc8
         tv6ZMX1Pbet0Mwhf6jvBi3ZsdjIid1h3zjyG3WBdocKFx06PShmW6BkS9Vz9LSpJKrmi
         frwcIUa3v0HmxHUeAJv9osvRBds+BTx+vBA2VgryxWZydOxH9wAPIPGkYUblemmW16ZF
         g4Bm3V52qfBNVM7tN4icd8fmk7lmpmHXUzIWs4UOdCTO3mefbSsur5uF33eGXhtRGVYE
         e41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291473; x=1728896273;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TGBBMU8rFx26oRjbd1HxpI/xco3E3mGApwngB2hx0UA=;
        b=bs7wYFmCj+7roaEK4c9mvffEhz7pUX8zCYTvcKreteXTBkTL7ksx0sFLbGMW/Zg7ou
         I70S5xHeVH1skoCtfr7gP/MfpMVmE3sZCBNISKSXwXWPOUNwMYl0FZhpIJMCJ2jOxvv7
         cNFHP9K5cgeOFhdYbiTFUWOWvu12bJGIkcbE4MCNPuojNoM+6oSBnqSig7jjyTXueiz2
         yB8weMeeztc3ALBcgjkiQMWMVVOMlVIpd29he6W2mSKlAycw7PN8ZEJl4t9sE+kqd0Bt
         R0LagnbMcT8wL2efQAABBL1TJLgAPcHf97IyrTU0kInaYJrSUxQQHzRxBUyqV+giCgqD
         cZNA==
X-Forwarded-Encrypted: i=1; AJvYcCVkEvgZvyP21VYKdSSZXr/OmSoSKKVel3Ds6aBhwLCs56bBkFRKbFb3OHb6v7yS5yrxRpggR9lV5UZrcEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Qmj4BZAZ0cyaZBdOyEZCM563jIYZZxHY/8BstzdlWRmEU+PZ
	dYJAQ5mDQwK143PYHcGOmjCYVVv4oudJTP4ewnbRCVB4qxrRTFsxVRM96rMgAMM=
X-Google-Smtp-Source: AGHT+IHb6K+lD/kBzplnC0Ubjz9+HYTIZIIEg6E9T40OzxD0plJXKDgFKpCxd+La0sGXCiOa+xkq+g==
X-Received: by 2002:a05:6000:4008:b0:371:8688:1660 with SMTP id ffacd0b85a97d-37d0e8f730fmr7003939f8f.51.1728291473181;
        Mon, 07 Oct 2024 01:57:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7? ([2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a55csm5206567f8f.37.2024.10.07.01.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 01:57:52 -0700 (PDT)
Message-ID: <f2db1521-0fc4-4cc7-b195-498e2a900191@linaro.org>
Date: Mon, 7 Oct 2024 10:57:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: document mmc-slot
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-2-5aa8bdfe01af@linaro.org>
 <5o2q5kmchnr3e4opmtp2xq3xqlzkq2hudecd5fszamoav4twhb@o3kcftkoxwzg>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <5o2q5kmchnr3e4opmtp2xq3xqlzkq2hudecd5fszamoav4twhb@o3kcftkoxwzg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/09/2024 11:15, Krzysztof Kozlowski wrote:
> On Fri, Sep 20, 2024 at 10:38:04AM +0200, Neil Armstrong wrote:
>> Document the mmc-slot, which is a subnode of a multi-slot
>> MMC controlle, each slot is represented as a full MMC controller,
> 
> typo: controller
> 
>> the top node handling all the shared resources and slot mux.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../devicetree/bindings/mmc/mmc-slot.yaml          | 40 ++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
>> new file mode 100644
>> index 000000000000..c30eda4fd2a6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/mmc-slot.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MMC/SD/SDIO slot of a multi-slot controller
>> +
>> +maintainers:
>> +  - Ulf Hansson <ulf.hansson@linaro.org>
>> +
> 
> description here saying what is the MMC slot, e.g. what you wrote in
> commit msg.

Right will fix the description, bad copy paste

> 
>> +allOf:
>> +  - $ref: mmc-controller.yaml
>> +
> 
> Just to be sure - the slots do not have dedicated resources like clocks,
> resets, power supplies, right? IOW, it is indeed one device which
> exposes multiple controllers?

Yes exact, resources are common to the slots

> 
>> +properties:
>> +  compatible:
>> +    const: mmc-slot
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
> 
> Best regards,
> Krzysztof
> 


