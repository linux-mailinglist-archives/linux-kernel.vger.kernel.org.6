Return-Path: <linux-kernel+bounces-187027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7198CCC07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F91C21DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795513B2BC;
	Thu, 23 May 2024 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQjB89iE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521872374E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716444258; cv=none; b=PWRK4h/bxwJmCNId+RYwPw2TT/l9eXYn/J361L7A2hN+85odW4Kl2QYty2YWxpZtOlRWbTovWjTy1hsQvrWYIWcfQAVh7CyfTz0xD1gnmKNKPwxQGz19WRriS2PWJT0OT2PoOj9QIuaX+Rcm7t0f0lhkcFl11AM5btMKw9eX0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716444258; c=relaxed/simple;
	bh=hYQUWqhl5uPTPNh8C7/UgZ8wfXvUfoa7XdL7RCMYTs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BS5PysZerDcSnG8tdANAcaKTz/S+nz1cMPXSnqmfErnrGwB97HS09jHwOGdYTrzD42EPGXdnvHszsLYEJhbOeXfQtqqxaL196j+bdFFw3HwuFInEHKc+YuvaH1bMxBFrfjYguVWZM8sAPcxyKRj33jgoBMYGZ4yDLCHEMZ+O8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQjB89iE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354f51ac110so1006210f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716444255; x=1717049055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i6dbk9a+uth7yFh6CNI3vvuN+SA1MsPZmlUVqAH6eR8=;
        b=cQjB89iEpbFKLouBjAseI7NSSITbi8PAff8Kfz5VkmJDlNIFI6ihu4C2qKn5DWyQmL
         oImc7s3rpY0H7/5KubfjrgPbZScbIAbcHubdfuQDj0eoNSlRKCc2NAltFZNjWMHIgmR4
         s2OQsqXHec+fXaS+sNsiOg9VBTFap4eKP/F8Vh6Wep/7xhClI8p5JVHte7f+npEOlvpn
         Gh/uiWTdA+9L1Gc3XizTAMSe+v2U6cOoZoFNvvw4iRM8U2UvI9/mg7rm4cp+050aIelF
         BybjSRg4igYagbQbWQZouwWpjD5D5IuA2CsCoSvSbtzpDMUHVxcTsaM3NqONjP+5XprJ
         aJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716444255; x=1717049055;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6dbk9a+uth7yFh6CNI3vvuN+SA1MsPZmlUVqAH6eR8=;
        b=unwfKq2WBuf0I0/GuTmJwJVJFU90x7uaZkpXEdJTzp7tUFYgB/Q3Y3s7CZuCasii04
         0eMnNVx5vAoT1zpilNyIAgYrIzN4MJCnuOaY4bqcJiJytDhBedM+emQQatArXemkUtYv
         oJ9WkV2hx3wRpLmvYJkJSCAKjyp7RbdSy8XzOtvsf7eqX8rouB9LevnxXROmT8kQl9jv
         V1zVHnzQ8bXfjxEq33JLRirXU6EaRoEbT12lD66bSap5FI2sjiuFNILRyxDCJ3H2/dT9
         a/nkhAh4OL9Xk0Fty/+6a2CcxWRJ19p4BKJuKiBYch0vNFOGKaRoTz7UwQ2CFENGJ0n6
         9hPw==
X-Forwarded-Encrypted: i=1; AJvYcCUMSzmsQx2+oOOB9lFBEA/cQzE8yHSahSHZQB6/rmvZVnnPsF5ahiPNkLbdnQpQUmXtgKi+Xjek/aPG2uNTS5531em79v6jzl37rpB5
X-Gm-Message-State: AOJu0YySWomyL/9XVUrwYaAxzMlp0S8mge+MNh45FypTL7tl6BNnNhqK
	mDx0S4kvbea+8gAh12o00IMYT3ESp+c9hbzT5nCogEsmUvjBxAGc8A4wdu38808=
X-Google-Smtp-Source: AGHT+IGxh5Tk8DFPD8rFp7ALYpXsYOIlALKHags95KPmf6Hf+jMmQIvoRHGyEUGwvmQTTwMbFR4/2g==
X-Received: by 2002:a5d:457b:0:b0:34a:4227:e9e8 with SMTP id ffacd0b85a97d-354d8d8de10mr4617489f8f.47.1716444254670;
        Wed, 22 May 2024 23:04:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354e736c71bsm2618353f8f.5.2024.05.22.23.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 23:04:14 -0700 (PDT)
Message-ID: <dc50ee9a-1fd3-429c-9b4c-5a8b8824ae1b@linaro.org>
Date: Thu, 23 May 2024 08:04:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: mt6358: Convert to dtschema
To: Kartik Agarwala <agarwala.kartik@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240518081621.63386-1-agarwala.kartik@gmail.com>
 <c05f91f5-a878-4f36-b325-0ac8e038a7e5@linaro.org>
 <dc8a05ee-ed84-4517-baad-a220d8702f07@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <dc8a05ee-ed84-4517-baad-a220d8702f07@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 23:04, Kartik Agarwala wrote:
> On 5/20/24 12:39 PM, Krzysztof Kozlowski wrote:
>> On 18/05/2024 10:16, Kartik Agarwala wrote:
>>> Convert Mediatek MT6358 Audio Codec bindings from text to dtschema.
>>>
>>> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
>>> ---
>>>  .../bindings/sound/mediatek,mt6358.yaml       | 47 +++++++++++++++++++
>>>  .../devicetree/bindings/sound/mt6358.txt      | 26 ----------
>>>  2 files changed, 47 insertions(+), 26 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>>> new file mode 100644
>>> index 000000000..f57ef2aa5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>>> @@ -0,0 +1,47 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/mediatek,mt6358.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Mediatek MT6358 Audio Codec
>>> +
>>> +maintainers:
>>> +  - Kartik Agarwala <agarwala.kartik@gmail.com>
>>> +
>>> +description: |
>>
>> Do not need '|' unless you need to preserve formatting.
> 
> Noted
> 
>>
>>> +  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
>>> +  For more detail, please visit Mediatek PMIC wrapper documentation.
>>> +  Must be a child node of PMIC wrapper.
>>
>> Did you update the PMIC wrapper binding with ref to this?
> 
> I am sorry but if I understand this comment, you are asking me to update this
> file [1], correct?
> 
> 1. https://www.kernel.org/doc/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> 
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt6358-sound
>>> +      - mediatek,mt6366-sound
>>
>> You did not test the DTS.
>>
>> I think I raised the issue already: please make necessary fixes to the
>> binding (with explanation) or to the DTS, when converting the binding.
>>
> 
> Apologies again. Just to be sure, am I correct to assume that you want 
> me to fix the dts file [1] as it has both these compatibles 
> mentioned instead of only one and I should fix that by dropping one of 
> the two compatibles?
> 
> [1] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi#L1246

No. I want these to be in sync and correct. dtbs_check must pass, which
requires either changing binding or DTS, whichever is the correct action
to do.

https://social.kernel.org/notice/Ai9hYRUKo8suzX3zNY

Best regards,
Krzysztof


