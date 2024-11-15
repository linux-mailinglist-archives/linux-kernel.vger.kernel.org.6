Return-Path: <linux-kernel+bounces-411059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B52E9CF374
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7091BB2F71B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0612F1D54D6;
	Fri, 15 Nov 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s9mPXRHG"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3401BD4FD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690422; cv=none; b=HZTyVZGpcJgYtF/lmlQr1UbmBh4cXYy83pHTgd6SCNmIFQatAmK0Ku9PhKDs8ccaFcxaIJjokKaJzowgci0uH7eTYe712QojxzBdVXabwxENFhfUa96Qf1Nbvqua1ehiJXHX0R7nHnfM5OANCeZflVasB5URMQZ9LdzqT30DvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690422; c=relaxed/simple;
	bh=+RDuJpTH0kSLbsZcI2mfsmnn+f+iKzvdnCnv3CGvCBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0z60soqL6Qvp4UA411wrKb0PTNNhkCFa+Z0OKbu3ioRlnu2pgZsKJXNXvaYTAQ4XbAj9gV/8SB/a4o+DiDMVnhqZaYpUG7tadjsazPyhsfjjX5N/t6fFztTw0E83B4Sm8as91RZc+nwXAXh0lAxCcqJo4Bru9tMNL3H6QTdccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s9mPXRHG; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc349204cso1044733eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731690417; x=1732295217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/wkfs5bRvyD0RFgjYc8TbW0xGEDn3+7ZiFHyYcJ/+M=;
        b=s9mPXRHG7Uu1B3Yku3JwGe+zWnk5HMHGuPZVh3ktgwaNsaMypD+WVfl+sr6oqdi7EG
         iReMlPkX7wxyKvAv/VHZGkuXDEMAhqBP0eGHK2iFgNp+B5hc4ijuxzYjR/nrs9fS0qjg
         NzzHjNhgx6Ha1OQuM9dpPkS9NqO16yMaN7miIwUSBC9mBd6LmGApUwfppjb7kt7vQNgo
         vRDe3aM1qKIvsBR4gatY6YM2kuyufej37C5NHJt/+3V+a8GppRP8gDSd0C6cgcKPXY8t
         61PDux0AvKBIPMudyOezDhXF0ik2gvFgAOgU42NG0swgKAZMWdd5rFB+lsIIYmyIXGRb
         JxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690417; x=1732295217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/wkfs5bRvyD0RFgjYc8TbW0xGEDn3+7ZiFHyYcJ/+M=;
        b=X85yG5V8QUuoVO7fhKe+NQ6E79qOzjZgYJnHoJPVvPn6BnvAGF57I5AWg9hVjqz/bY
         SnCFI7LyzXJPf75sWmWV3AMztcsWLADMsybW8iLTqj9o7AQ3NeCZ77icZn+QbQNcV+qu
         hXbMwriU5G0nAUx+wI+c6AYTF7l+WgvZD4t7tzSBHpzvYod4UTMwMBxvxvIj5Fbz+FnM
         lPre/VgFaJvCc9H63wb2T0ZZOJB1nWKxL7Ah2FrU74006pp/hpxiBWrV8ttzA+Ma7XMK
         Pd04Xq26YRH8F2siTrNL3K4KC9ZlXIFF1vfRf/xjGv7WVIAryT9+MfE036A+0I6HEM0i
         fkOg==
X-Forwarded-Encrypted: i=1; AJvYcCVadeNP4/cGcLzS8saN/IHZc4enO08A1xpRfM9k+ITWnA17GcmYFLJ0L6KHzOUU2XRiWMOg+cKg5om1bkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6OLrWGRnGdx11jEi2U04fCwMGXPTj/YJ6zTeIOsgrDLlY+gF
	Pg2R1cJUI4pYiNP6GE8cYi/0mCh6HO+sh0RxozDaY00lnq6A4fACNTcN/BnTfw0=
X-Google-Smtp-Source: AGHT+IGtKLmvYpVBqTyibD1ArQBLqbqiDqyVByPpr8CtK4g6Mcr0/WOym3DJvTjErF3xMORO0TtMxw==
X-Received: by 2002:a05:6870:912b:b0:296:13f4:fb6a with SMTP id 586e51a60fabf-2962e0aee89mr3277619fac.41.1731690417451;
        Fri, 15 Nov 2024 09:06:57 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29610b59315sm1572232fac.50.2024.11.15.09.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:06:55 -0800 (PST)
Message-ID: <0b8a2d07-feea-409f-a850-7ee0c752a949@baylibre.com>
Date: Fri, 15 Nov 2024 11:06:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 5:50 PM, Marcelo Schmitt wrote:
> Extend the AD4000 series device tree documentation to also describe
> PulSAR devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4000.yaml          | 115 +++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> index e413a9d8d2a2..35049071a9de 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -19,6 +19,21 @@ description: |
>      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7694.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf

It would be nice to sort these lowest number first.

>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -63,6 +78,38 @@ properties:
>  
>        - const: adi,adaq4003
>  
> +      - const: adi,ad7946
> +      - items:
> +          - enum:
> +              - adi,ad7942
> +          - const: adi,ad7946
> +
> +      - const: adi,ad7983
> +      - items:
> +          - enum:
> +              - adi,ad7980
> +              - adi,ad7988-5
> +              - adi,ad7686
> +              - adi,ad7685
> +              - adi,ad7694
> +              - adi,ad7988-1
> +          - const: adi,ad7983
> +
> +      - const: adi,ad7688
> +      - items:
> +          - enum:
> +              - adi,ad7693
> +              - adi,ad7687
> +          - const: adi,ad7688
> +
> +      - const: adi,ad7984
> +      - items:
> +          - enum:
> +              - adi,ad7982
> +              - adi,ad7690
> +              - adi,ad7691
> +          - const: adi,ad7984
> +

IMHO, having fallbacks just makes the bindings harder to use and doesn't
actually provide any useful benefit.

And with this many chips, it can be easy to overlook a small difference
in one chips, like ad7694 not having VIO pin, so is it really fallback
compatible? Easier to just avoid the question and not have fallbacks.

>    reg:
>      maxItems: 1
>  
> @@ -129,10 +176,76 @@ required:
>    - compatible
>    - reg
>    - vdd-supply
> -  - vio-supply
>    - ref-supply
>  
>  allOf:
> +  # AD7694 doesn't have a VIO pin

It sounds like using not: could make this if: a lot shorter.

Also, it looks like ad7983 doesn't have the pin either.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad4000
> +              - adi,ad4001
> +              - adi,ad4002
> +              - adi,ad4003
> +              - adi,ad4004
> +              - adi,ad4005
> +              - adi,ad4006
> +              - adi,ad4007
> +              - adi,ad4008
> +              - adi,ad4010
> +              - adi,ad4011
> +              - adi,ad4020
> +              - adi,ad4021
> +              - adi,ad4022
> +              - adi,adaq4001
> +              - adi,adaq4003
> +              - adi,ad7685
> +              - adi,ad7686
> +              - adi,ad7687
> +              - adi,ad7688
> +              - adi,ad7690
> +              - adi,ad7691
> +              - adi,ad7693
> +              - adi,ad7942
> +              - adi,ad7946
> +              - adi,ad7980
> +              - adi,ad7982
> +              - adi,ad7983
> +              - adi,ad7984
> +              - adi,ad7988-1
> +              - adi,ad7988-5
> +    then:
> +      required:
> +        - vio-supply
> +  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.

To me, the more interesting thing to say here is that the sdi
option is omitted because these chips don't have a programmable
register.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7685
> +              - adi,ad7686
> +              - adi,ad7687
> +              - adi,ad7688
> +              - adi,ad7690
> +              - adi,ad7691
> +              - adi,ad7693
> +              - adi,ad7694
> +              - adi,ad7942
> +              - adi,ad7946
> +              - adi,ad7980
> +              - adi,ad7982
> +              - adi,ad7983
> +              - adi,ad7984
> +              - adi,ad7988-1
> +              - adi,ad7988-5
> +    then:
> +      properties:
> +        adi,sdi-pin:
> +          enum: [ high, low, cs ]
> +          default: high

For the similar ad7944, Rob suggested that the default should be the equivalent
of "cs" since that is most like "regular" SPI. So I think it makes sense do the
same here. (The adi,spi-mode property in the ad7944 binding is named a bit
different, single = high, chain = low and _property omitted_ (default) = cs)

>    # The configuration register can only be accessed if SDI is connected to MOSI
>    - if:
>        required:


