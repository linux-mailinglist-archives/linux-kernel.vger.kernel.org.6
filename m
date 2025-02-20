Return-Path: <linux-kernel+bounces-524738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C1AA3E67E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1A54217A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC6213248;
	Thu, 20 Feb 2025 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G9MBe+tY"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC31E571F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086528; cv=none; b=tiaGetROqJzrF0e5Ca77p5dIhMKX6hmeOjk3MolAl9VKTi9so0xxw8fs6r9VM1Boc2GuVtKowgAmgVouxt1UPO2wPkTYZ7/YRjxQTSQgslfDS8SA3pkab99y+4D4q5ANNAL680/xNGlvqJFAHooLl91wQLHfkN5LXFy/JNI39Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086528; c=relaxed/simple;
	bh=gK/PZJt4q2sG2dHwxcG9hM90AJLo2wr2AMBT39R3psE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clH9PCnugnzAv7s+IgKWN1vhlTxpawqK+b+oOfD9/lZisQWypRUPsWH9o52umXtbn3Ws94MxyTGmvZF4cF7PG/wmSPWWBQ97+2rCRSFGY7yc06HuYrH9GxmjMtp0K4++186djt0EwwsDqaTzJ0a7cWsViTBG1Y3BIc/od+ftRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G9MBe+tY; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f88b61399dso1194456eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740086525; x=1740691325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRkG5vaOS0lDY9pA5VGqjHoCOhTN4lWgMCGaymcjWZA=;
        b=G9MBe+tYBa11JrS5TsgQQTahtDvYPHmlPf82vn5wvOCVrTMgoXIypZOz8XaE6aHvv5
         UTeFyQloANhzvNHQJNC+bXUXzcWDIoESN9hhXNXQ6DLHJEOdB8pj4uCLWSrU/Wp3B5se
         TNbumdYlvRt/joqJrv2Vs9iKy/onNFkTbiNKQnZRmTrDHsmQBd93ywerXZZ7SuKH/5+e
         XR3YaIlF7ZhnUzCka6UiRf3R3Qemet7oAmorZMyk6ABea3Ez4Y/8LOnRhYkkJlWrc4Er
         U9IW4UCVt37HkOT/nmVGq2hLV/Lnyt+As/hySP4bHfOut2Nf4QLeAG020dbNPMLUMyXd
         mSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086525; x=1740691325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRkG5vaOS0lDY9pA5VGqjHoCOhTN4lWgMCGaymcjWZA=;
        b=fI4WdgOsccAaK62pRXOi26pOcMj8vyI1+9npDU2iKnvIRf0fjcv2QzVElxkUkc7ybf
         6TbUKGi7ld8G8jyTvA5Q0fhSGx20hvJIwQ71bU4t4O4ohKwHgPsgf2P7o0geF0vRTZd5
         PGtwYaHvnT3GK1UAvTU7JskolzdC3FK9/WO41siC8zxP9cZNTEYjFZX2iwt9QpeLYqxq
         s6774P/9aAscLPQBUKyG9uRhwFHrGuuHbCk2ee1iGEbecQJJESW6qUJgAWt3l//+kNFN
         c0YCKHbGD5JbXHx7xYR4xl989zE/kRdKAuc8Odg2JXruprR2zNTvm/mXI3UEnGU/Ph0z
         55yg==
X-Forwarded-Encrypted: i=1; AJvYcCXPN6EFrXZY/+f4lNbUM81gTDBCUQsGhE+ivwIMz7jnZybHYou2qMwJ24kPBcVMJR2aBpKMn4LqXcNvShE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEK785n0McjPCb8q2SNPDx+Bf3raKzZgGU0531ths19x+wIg0D
	kMnP8EzafAPxjcQKye0/M89DUDsMsydCWCgpmuvq6OTcivQrUykdGUk/wVtGZP8=
X-Gm-Gg: ASbGnct9BgzxtUMw4d2BkVS8tReo1bbSoXajkFd4WDIxm4ScKbnZvboFJVTsM15LuZ4
	9mxteH/8BU7Xe2fXzvoPY+6UsqIpeN0ZXlWZSMgG1+wsQ5grAcVaDsm8Z8vBbXVpgivHF3FNYVg
	2kHZogxe8rE9cHWnBOCv8yuYsF499ORUTnRkBSxmsSNVa+X7e9kpSDCiVtt1H+qdf0uXo878Ueg
	tq4X7SbVQ0dMKYVBlfNYgAbTvPldc7LT4Zh5Fm4ItLuRVSq4szKu8fFUAGOutzejjBIwg5ha5tZ
	ZrMIdLrgVDZHm5jr1iobtxhjecpw0WOarQrDxfC/iEaHyS6nDFe4
X-Google-Smtp-Source: AGHT+IHtrPQu27iToW6SI7eNT9OONk9gLd1u3ON/T5VT69MV/0pGe9KjerOvTUnPcei575boK3DXTA==
X-Received: by 2002:a05:6820:1a07:b0:5fa:4c67:b70c with SMTP id 006d021491bc7-5fd19a941e2mr688320eaf.1.1740086524833;
        Thu, 20 Feb 2025 13:22:04 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fce04080besm2294468eaf.13.2025.02.20.13.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:22:03 -0800 (PST)
Message-ID: <e7940b89-f884-44a4-b656-383950b6f778@baylibre.com>
Date: Thu, 20 Feb 2025 15:22:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 05/17] dt-bindings: iio: adc: ad7768-1: document
 regulator provider property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <78c7d5d139d6c158423804f0e6c81cbfe9717b1b.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <78c7d5d139d6c158423804f0e6c81cbfe9717b1b.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:16 PM, Jonathan Santos wrote:
> The AD7768-1 provides a buffered common-mode voltage output
> on the VCM pin that can be used to bias analog input signals.
> 
> Add regulators property to enable the use of the VCM output,
> referenced here as vcm_output, by any other device.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * VCM is now provided as a regulator within the device, instead of a 
>   custom property.
> 
> v2 Changes:
> * New patch in v2.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index e2f9782b5fc8..38f7bb0a0e20 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -59,6 +59,19 @@ properties:
>        in any way, for example if the filter decimation rate changes.
>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
>  
> +  regulators:
> +    type: object
> +    description:
> +      list of regulators provided by this controller.
> +
> +    properties:
> +      vcm_output:

I think property names are supposed to use - and not _.

 +      vcm-output:

> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
>    reset-gpios:
>      maxItems: 1
>  
> @@ -152,6 +165,14 @@ examples:
>                  reg = <0>;
>                  label = "channel_0";
>              };
> +
> +            regulators {
> +              vcm_reg: vcm_output {
> +                regulator-name = "vcm_output";
> +                regulator-min-microvolt = <900000>;
> +                regulator-max-microvolt = <2500000>;
> +              };
> +            };
>          };
>      };
>  ...


