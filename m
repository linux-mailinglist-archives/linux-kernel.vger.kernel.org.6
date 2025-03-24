Return-Path: <linux-kernel+bounces-574262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5539A6E2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D978E17026B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111B266F0D;
	Mon, 24 Mar 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JcsHAyC7"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7C1FCFDC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842568; cv=none; b=e4Q+MMB/CwEp80mnq7Xcx1f3ZXBmxLcrzF1qbSzg7hCJb+V0w18rOQtQU68wwURZ6qUYWa39+L7PcmHYNX16BSLJc3B3OlDsbv8U65ka6XO2Ji2VGRNdAqiHWV6Wys9hWBzneNGXz0315fcUsAnpUO+uO9DB4r3lOQnZhR3Qxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842568; c=relaxed/simple;
	bh=a+tVV7dh7MzB4mshZc5wigf+spuaZL1s32GUcdilUP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mk2vEm5flYvLhHfh5YEpb2Rd/a3NlXz6DuyxywghYSmNQDEzjZxsg7NjUxPcvyOqQEO/FDoRW57uV/Cf1oBRI2GkXfXjXtDWD/l+NXSpoFQ+JPP1h/ZcDWXaVD5G+6QY7xdnPX7Xx9eisFyqhPVok6p8IqPgHdB2FS9DuTFIhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JcsHAyC7; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c6f27599abso1317225fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742842565; x=1743447365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L04FanZwF3VAWkrzQjyImYypkCu6QrodmJxDltgNWqw=;
        b=JcsHAyC7/tqQh+xeDctz4orWmySjkoqUsY7JaxFWrPj5UkoQwy1PPwCj0gf5m9vJjP
         N5iGHCge5joCVBTPjxlS9SjrbBybUnutZNLRdp/XmjQApZJv95WAeR/NYHqK0aOVKdhv
         AcvZ6s+H/FtZ7fX/IM1sSz1NEbJibiV9a/JnIbP8JpXWurWPCPjzvOqNwRjn059R9y+c
         Crnh2KAMa9ghldyEud9vDPBkTSvmETtWza0HqCIHE6ylMtf2rPr4x4lh645REu1XoSgd
         NTurIAVQkXy9Sp/oJxDkI4ziWaVkp4CUbSDcDZuQmEVQL3nXnu3EaeRMaIXr0SgAxx9R
         yMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842565; x=1743447365;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L04FanZwF3VAWkrzQjyImYypkCu6QrodmJxDltgNWqw=;
        b=oxHaqSPTqAwJSTbPjSzgQemqjr4Wxf8evGpzF1t1RlZvy0F/yyXJnyzonWo+ZG5fFh
         fajgcvykBNG//9fkVbmxzlvTe77aY2u4e0LvbFSQTyNfqEl+q96oY6tCmMM3x1/IcQod
         IF0PxRnRa2119ltPajfvoiPwKRwA6TH8TUyoCTgEQfqeXvj3HK4vcARVDIFvnMNGY9SW
         WTaSjhHAoItXL1yFwVj48YScydk20Jm59Uq3s7UOadwPvYprpwLekxn8W97E2a2bqCwN
         XVez/W5MsFv//WUFBqZ9GDClNP9ddQVhLi3Hkxurv40YnpRtkzJBVV3IW5LCSU6kV8tD
         leYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRhVbhYoNNL0U0OWmkw8PJtYDA1cMvz9/jfjGsBusR8kHEJDxV0JmoitsvFhaiMj9DjLBY3w60PwFn5bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCL3JMK7DChete4v5gPjSxdbvIKydvx7gYTW+X1C5KnZUIkPx3
	kMoURObJe9NYJfrZUzXbohd+mHwA4wvNTBMh7C4xfB9/nBX8VD+icHTTLl1p3MQ=
X-Gm-Gg: ASbGncvXf9XZyql42pPVKBQsbex8bLPLPH4mKgAIChiHoRKG7krROZn+SfDyPcnJjq4
	ZoFSSBnFdiktd8sapC6j5c+jmRuD+ApACueP9YCv0TkIi0ZTtPptHZYog26xGt/EmMsq49huam2
	3E9QWRM9Pyh4RujHeB5Nyi61+HJHTXON1ycN09eBzhkFDnAgeKD6IqwJREd4pRPTEgbScTvuaWw
	GRqLOFRnPy7APgUz7c3l5oBiROD2cmBfOvbnukCXyFuBaOjhI1YIvd7PJUvIL8181OMsEzqAQ9Y
	r3pCOzNy6Y2exQ14/QNQT3RA4ioRGgFcNc/QgK9SFkTDGS7MGKPFeWwD/JwlkuLPoORQ/Jy0ug5
	tUwaQdA==
X-Google-Smtp-Source: AGHT+IFlP9h2LLyUSePPLXV5Qn0BgNwLj23B9y13aLgXoybGdVzox15RFQbnsJ7cA5/FOHEmCfbWzw==
X-Received: by 2002:a05:6871:4386:b0:2a3:c5fe:29b9 with SMTP id 586e51a60fabf-2c7804ec0e4mr10475928fac.29.1742842564445;
        Mon, 24 Mar 2025 11:56:04 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77ec51be0sm2114044fac.16.2025.03.24.11.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:56:03 -0700 (PDT)
Message-ID: <39d48315-0d05-4992-b905-ebb5b9fe77c1@baylibre.com>
Date: Mon, 24 Mar 2025 13:56:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: iio: adc: add ad7405
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-5-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250324090813.2775011-5-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/24/25 4:07 AM, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7405.yaml          | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> new file mode 100644
> index 000000000000..e312fa0cdb05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7405.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7405 family
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +
> +description: |
> +  Analog Devices AD7405 is a high performance isolated ADC, 1-channel,
> +  16-bit with a second-order Σ-Δ modulator that converts an analog input signal
> +  into a high speed, single-bit data stream.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7405.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7701.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7702.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM7703.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7405
> +      - adi,adum7701
> +      - adi,adum7702
> +      - adi,adum7703
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +

There are no child nodes, so we don't need #address-cells or #size-cells.


> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  clocks:
> +    maxitems: 1
> +
> +  io-backends:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vdd1-supply
> +  - vdd2-supply
> +  - clocks
> +  - io-backends
> +
> +unevaluatedProperties: false

Should be able to use additionalProperties: false here instead.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>

This include isn't used and can be removed.

> +    adc {
> +       #address-cells = <1>;
> +        #size-cells = <0>;

Not needed as above.

> +        compatible = "adi,ad7405";
> +        clocks = <&axi_clk_gen 0>;
> +        vdd1-supply = <&vdd1>;
> +        vdd2-supply = <&vdd2>;
> +        io-backends = <&iio_backend>;
> +    };
> +...
> \ No newline at end of file


