Return-Path: <linux-kernel+bounces-539583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24ECA4A610
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3670A7A9E92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F8D1DED6B;
	Fri, 28 Feb 2025 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kQlLOZH+"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63C1DE4CA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782336; cv=none; b=e/QL3gepXpETrDe5O2b/QkVDfF+m1VoiWGg4umIL9/H5fezXXJQ/tZ9zCpyL/PlBM4L7iHpnAdcVFdDeAeuOZB+onM+X7HOMa3LZj47QTUmzEPjvD7bCoJjzNu7YG4oPmGILe4L+9Dj9onQ2H+p3JQbq4pV2TWHaGwcLLElM7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782336; c=relaxed/simple;
	bh=OinG4oFMJYhN2xIT5Za/iKY0tkNoEgtL1o8V6/QHk+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTdppjpK59JJoO/bPhvMXreNwT/vO+NX4HFZBCqrr+nH7a1ziYGq7GRf0Tg1pSH82H8Ki67s7PBVeWR1LYdtDNsVaixmDXQeWCjaTcswWf2NP3LhyO2hJXMbA619e412zntdMiomwqnxj+n+8WAp/wOx//Etc+LZMt+K4u311eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kQlLOZH+; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7275bc6638bso593178a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740782334; x=1741387134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+fYjTnDelyv2wmiBt70nsk1L4cOdcyvqKIdaQXfSpE=;
        b=kQlLOZH+VLYos7eF2JQ2MUR2nB9xlpqpcN1JPEf1n+JxLmnm7/bsAElguFC1lEG0Jx
         SuEA3/q9BtbMJnqJaxBkl8ZjZXpRr1+NLR86bG5f7+DcXD3aFzFssZ0TIfKO/fm7vIr8
         5EtuWnTW7eeDYuDJu28XjWB08sz/Gk6+JAKMULOyXBxb0Mtc4lUv/n4icczHciGF4d5b
         cKP/U1PfwJYYrwbwteRRRmLLkpoQ/fBW0o9dyTujqU2t7Py9juqnJMh+h0j66Dk16TNw
         povdWYJByPeTGvWnwuUxvuYpB6PZO7zX7lhee8jz5LEtnExBQM3Fiwygf3NmyY+xBX32
         ZwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782334; x=1741387134;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+fYjTnDelyv2wmiBt70nsk1L4cOdcyvqKIdaQXfSpE=;
        b=lwVCgaJdUG8ZbLJf6YWOTmBFhTtuvBtJjd6nmSjUq5dfizAyQi5zL6iPd0kSXK2AQj
         FXXAt50tG4eJSSGIqvWjnzY22U4PiW+fZZCy48DtB5Y1VBskBYs6inKEExuM+R/tG6o3
         QCSIE901wSqAjzQxqcXsl+edyElV9b3tQYgtq4QKIFs1JhirnPhkzw+IOWn85W0oQIuQ
         yEZzXZ9DT4dNa9CCzd7QsC745kSYqENNdeim11VgCj68vxR5I8r1eQIqPsiCe1UpOr2y
         3y/kY9K63JtH94xY+1BJ/xzDruRrjSLE5vNngTL+LaIu+rB+11GfumQfO0NV+6oHop7p
         ZVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCrOmJUNTE5AyBVdMKuSLp8yrYju2ZTaJ5YZ+9tli3oz0MLoG84GHNqY2XxLHXRJnIf048ktRSfC5KlPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdq3wiUguXF1tRKy6KY/C7T7+q98Hpi9UBsAUsLJszEXy5O7/
	afweJQ3bs7PlRD07ESvPemkPlBeF7EpeAwD4kRZo9x/C2HmGeooSr/Hub26+dKc=
X-Gm-Gg: ASbGncsz+BfnHEZpOIWj2F26pgMHNMy6fC3vZ4GQRl8pIscupLEUeWOHVaZFuRi3DI9
	NkNzDw4pbPajwij1AWurgikbvYr7zgrzjikEFT1LJk9+WqZwpww/raYpPTbuwP5Fm/ih75rz4cP
	Mgw6Q5FJnk+cn5Zcb6wTonTKbSkgfPGHXLgnUEiuOnHaFrTuxzlhbSGGxkSEyMuFjRM9jAHv/q7
	ZRoAqESTLH1MP7wuB16GrXmIAUwNpvZjxNeuONDsHjH+tv8f2RKq4RV4r9c+ikm5sAymkDGSdbo
	TTgIeY/DgTChoY9oW4ztZFGZUcBu1ape6HsosPGsIoRCV1sZB6mFICJt5nF66Rzvs9pzbLcw4eX
	3umtLlQ==
X-Google-Smtp-Source: AGHT+IHbvfCuPkEVbuAzfOLEf30m1LTbxhXs0FiEuN9bvvhhqT4lDEN6K7BISal6NU3hSK59m2FbIg==
X-Received: by 2002:a05:6830:6684:b0:727:421e:43db with SMTP id 46e09a7af769-728b8261559mr3476276a34.6.1740782334001;
        Fri, 28 Feb 2025 14:38:54 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-728afd0047csm825497a34.22.2025.02.28.14.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:38:53 -0800 (PST)
Message-ID: <7b2a8d71-9d83-4d40-903b-ba7ef1c686f3@baylibre.com>
Date: Fri, 28 Feb 2025 16:38:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
To: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-7-david@protonic.nl>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250227162823.3585810-7-david@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:28 AM, David Jander wrote:
> Add device-tree bindings for Analog Devices TMC5240 stepper controllers.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  .../bindings/motion/adi,tmc5240.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> 
> diff --git a/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> new file mode 100644
> index 000000000000..3364f9dfccb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/motion/adi,tmc5240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices TMC5240 Stepper Motor controller
> +
> +maintainers:
> +  - David Jander <david@protonic>
> +
> +description: |
> +   Stepper motor controller with motion engine and SPI interface.

Please include a link to the datasheet.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,tmc5240
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

I assume that this is the overvoltage output (OV pin). Would be nice to have
a description here saying that. There are also NAO and DIAG0/1 output pins, so
it's a bit ambiguous otherwise.

> +
> +  enable-supply:
> +    description: Optional external enable supply to control SLEEPn pin. Can
> +      be shared between several controllers.
> +

This doesn't look like a supply, but krzk already discussed that. But there
should be actual power supplies: vs-supply, vdd1v8-supply, vcc-io-supply. And
a reference voltage supply: iref-supply

And if there are any pins would make sense to connect to a gpio, we can add
those even if the driver doesn't use it currently.

> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: /schemas/motion/common.yaml#

If we need to know about what is connected to the output of a motor controller
I would expect it to be done with child node for each output. That way each
output can be unique, if needed. Basically, similar to iio/adc.yaml is used to
provide common properties for channel@ child nodes on iio devices.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        motor@0 {

motor-controller@ or actuator-controller@

The chip is the controller/driver, it is not a motor.

> +            compatible = "adi,tmc5240";
> +            reg = <0>;
> +            interrupts-extended = <&gpiok 7 0>;
> +            clocks = <&clock_tmc5240>;
> +            enable-supply = <&stpsleepn>;
> +            spi-max-frequency = <1000000>;
> +        };
> +    };
> +


