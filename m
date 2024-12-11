Return-Path: <linux-kernel+bounces-442202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBE9ED944
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79634188B49F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC01F2C24;
	Wed, 11 Dec 2024 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cw0MaO6Y"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485C1F0E49
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954517; cv=none; b=a3BGMEdGKdhUV7I5fppXRcAxfXOXhyB65WBw2pe86fOh7iqQGLlDk1VhYnJxyMFrhYCMpo5dcRncNwxc72YyzSrKqHwXl4ye53IHcGZ+SrIblWEGGVgt+7JHGVbq6KLRwNDlUptvPHqNj2F4kU1RHh2ko8PrCJNKydOAkJXph5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954517; c=relaxed/simple;
	bh=Hu2ByqklQuQmDfnHBLNSZnJnXSQP/3lhW+QeaRZXie8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf4UrJ5c3JGIDOEiQjxOjpyyF3qoJ6ZoxAmNdgvvKTSbMlAb5QzRVwlxSvKnSCu5icaBlLMv3coDHrSl6hb0RhreOJeRKHmTtfePBXEa+8MqZlc/HVBZvioqCjJ3EzhJWbqlFgwuAy8poQhgiLHelgR5OusIJ4kTudvb6UIr0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cw0MaO6Y; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71ddc7325beso413785a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733954513; x=1734559313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfgiN8bKA/zV2iECs+IeycK2wa4XqflJ7gHTNLn9LPA=;
        b=cw0MaO6YPlIWZR4oO/H/vhAMl1A1V9xCiU4H7Gz2sXHb1XG6dJm/mW0fkuY4pwYqPs
         oc2JnUpC+N3E+B6PMcJi1yxrEBGILxOnpsyxaBxzokr3zzewyeaGJ73NYofP5uFJZHRF
         VZndnVhfnu6ifHJHD2TtNeExs75JZ43ehqvmi971EHnSEfR2nH3pLbN3yI7s0O39N+1+
         W3MH8d+MIgfDn/GpMQ0IJ52xneuMYqhnTFodT2KYTr2g6jpQjA64BP6ZVpOco5/7VpA5
         SpH9l6m4WDjTUgu2ViRj8RVvSUWWoYRuLRK/I8UNNAVNufjQRXI4AOmj5rHWwneA7Jbw
         jJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954513; x=1734559313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfgiN8bKA/zV2iECs+IeycK2wa4XqflJ7gHTNLn9LPA=;
        b=HLg1WWKwC7k1MWzmcW4J0lxrMzEy8kI/UNsDpdkFUFB+16RqW3k12vN0tl9KajySD8
         zhL7A4NnRdwtoZQTvp1NUA0XHb+BOT4j7P5jXQdyrCT3dHIS36CL3SnhnnJoPGHRCIdf
         0LvZnNdj38dmgj49D4vDDpvH9I4WQDNp0pBMRMTBe1RJN8cpz/tuWbmbmb6+5L55z2IF
         FYWoq+7Ar1voKcPRrp1sFsHzyIQOtSrMZfYqqTYE0YCe6pntYiDPu4bib/l840j8NDYh
         F8Gq/WdCCxIStCObl8WExJIkKEfNOqUFfqX8t/nYlQHct4isUZAHKaEFK+jo6i3qul1E
         aW/g==
X-Forwarded-Encrypted: i=1; AJvYcCUKbTDJDKTPRUiihiSFLRsMzqsnhMLQ03Yh/DKQttPgWjcl3zfWxPshUwb3HFGXrriSpLZsysa5mriGCvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuO9VODKh9xFxrGBgogDGvIDxw7XYJsfX8xOEVDwgMR0wXc89z
	3r3buFs5UFGma74tQh43LGciKx96JboznQ7mwtxbBMxi08pj0cQgQhlp6SEqNWU=
X-Gm-Gg: ASbGncsmiNjQqk1hB5oM95Xe8/eHEcNoLFTvE2m7uhBc4iTnnj1xQ3m94GA255X02uf
	QR6iJEpslvcnB9+of+D431NsGA/nNZsSuXBBxg/PM5U/LV/cvUNJqWHiTDsvzKPqNqRxS0MFo/d
	L2jAEBlCWT3NGbgO7rBBG4u5CYBrZHoYXocGwLvhW3xkhwU5urB4SK4im3ilyFA1iOU2YvQNJoM
	Xv5E5W+D8nMLOvabvpa+HDRiDzGzlF2bvyYFBqFO1bpXnsualBTKSWR/ofrIz10JsFnRLwoS3s5
	Am1wq16SYzK91EE=
X-Google-Smtp-Source: AGHT+IE1lOU8aJHTLEOGRoysIOnnkI1kkr5ONpELSEis3dXuvxQLyp4Yadpz+/hT2lXzq9apzGKBPg==
X-Received: by 2002:a05:6870:5490:b0:29d:c870:74 with SMTP id 586e51a60fabf-2a012dc23acmr3059922fac.27.1733954512698;
        Wed, 11 Dec 2024 14:01:52 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29fb0192599sm2701232fac.39.2024.12.11.14.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 14:01:51 -0800 (PST)
Message-ID: <9ff2ba8c-fdb6-4792-905a-71ca2ddc58b9@baylibre.com>
Date: Wed, 11 Dec 2024 16:01:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: iio: dac: adi-axi-adc: Add ad7606
 variant
To: Guillaume Stols <gstols@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jstephan@baylibre.com, aardelean@baylibre.com,
 adureghello@baylibre.com
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
 <20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 4:46 AM, Guillaume Stols wrote:
> A new compatible is added to reflect the specialized version of the HDL.
> We use the parallel interface to write the ADC's registers, and
> accessing this interface requires to use
> ADI_AXI_REG_CONFIG_RD,ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL
> in a custom fashion.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index e1f450b80db2..6c3fc44422cc 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -17,13 +17,22 @@ description: |
>    interface for the actual ADC, while this IP core will interface
>    to the data-lines of the ADC and handle the streaming of data into
>    memory via DMA.
> +  In some cases, the AXI ADC interface is used to perform specialized
> +  operation to a particular ADC, e.g access the physical bus through
> +  specific registers to write ADC registers.
> +  In this case, we use a different compatible whch indicates the target

s/whch/which/

> +  chip(s)'s name.

s/chip(s)'s/IP core's/

> +  The following IP is currently supported:
> +    -axi_ad7606X: Backend for all the chips from the ad7606 family.

s/axi_ad7606X/AXI AD7606X/ # proper name of the IP core
s/Backend/Specialized version of the IP core/

>  
>    https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> +  http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
>  
>  properties:
>    compatible:
>      enum:
>        - adi,axi-adc-10.0.a
> +      - adi,axi-ad7606x
>  
>    reg:
>      maxItems: 1
> @@ -53,6 +62,24 @@ required:
>    - reg
>    - clocks
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,axi-ad7606x
> +    then:
> +      patternProperties:
> +        "^adc@[0-9a-f]+$":
> +          type: object
> +          properties:
> +            reg:
> +              maxItems: 1
> +          additionalProperties: true
> +          required:
> +            - compatible
> +            - reg
> +

The preferred way to compatible-specific bindings is to add
everything at the top level and then disable ones that don't
apply using -if: blocks.

So under the top-level properties:, add

  '#address-cells':
    const: 1
  '#size-cells':
    const 0

and move the patternProperties: to the top level.

Then add not: to the -if: and make the then:

    properties:
      '#address-cells': false
      '#size-cells': false
    patternProperties:
      "^adc@[0-9a-f]+$": false

>  additionalProperties: false
>  
>  examples:
> @@ -65,4 +92,30 @@ examples:
>          clocks = <&axi_clk>;
>          #io-backend-cells = <0>;
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    axi-adc@44a00000 {

Shouldn't we have the label iio_backend: here?

Also, could use a more generic name like "parallel-bus-controller"
instead of "axi-adc".

> +        compatible = "adi,axi-ad7606x";
> +        reg = <0x44a00000 0x10000>;
> +        dmas = <&rx_dma 0>;
> +        dma-names = "rx";
> +        clocks = <&ext_clk>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adi_adc@0 {
> +            compatible = "adi,ad7606b";
> +            reg = <0>;
> +            pwms = <&axi_pwm_gen 0 0>;
> +            pwm-names = "cnvst_n";
> +            avcc-supply = <&adc_vref>;
> +            reset-gpios = <&gpio0 91 GPIO_ACTIVE_HIGH>;
> +            standby-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
> +            adi,range-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
> +            adi,oversampling-ratio-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH
> +                            &gpio0 87 GPIO_ACTIVE_HIGH
> +                            &gpio0 86 GPIO_ACTIVE_HIGH>;
> +            io-backends = <&iio_backend>;
> +        };
> +    };
>  ...
> 


