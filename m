Return-Path: <linux-kernel+bounces-194746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE788D415B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E9AB2201F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141216E865;
	Wed, 29 May 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBrxKOlu"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7A15B0E6;
	Wed, 29 May 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021524; cv=none; b=Tfavl1Tj+So09NrPSZjyIqnWHC4M4fjE6VuRweNUDnNxTLBi5SjOaWE7YrKnppRHT3cTpiuqPS4eW4UJP5KkvqF78Dp0SdhRZaqfGIwHRFNhmEvnd6YCW6HMq/QeqIHAYFBISQiZjC8Hye9/sEFxqdZtvPBEuKCY88flfrCs/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021524; c=relaxed/simple;
	bh=L/g2EvHE8g2iyCUMGy0masnGn/k0AkwX8gaUiKjdt+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwWNE7GzGp7Cioi0l3DdlgxTWBTAskbxCIs1PID9cMaKEjbshlKEEzV4EDKfxst5l36olJgebXh96vvc197PcMydZMy2JXkqzfN1imdd2HKJ7ZuyZ/iCUbChYxU+A3fy6jIxFUY4iYA20eHg3i2Nxr0Svs6GP/26z7O1GjftoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBrxKOlu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bfffa3c748so175886a91.3;
        Wed, 29 May 2024 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717021522; x=1717626322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ+qSEgBrLBvhAOp1UtC+ym/4hvmQ3RllnsY91gsYcQ=;
        b=XBrxKOluTI3fStC3cmeC0gfzfWYDs0PoDCYkqlzHaPOyd0SdBCZNqyH4Im4M1CWa/F
         gDFsVKCDxgAL8XLu1Hb7soJkrh7Wnb7ANeW3RME7SHWzhL8qFBf3WVfvxNnlG4I2CLll
         bwh/TL0DbEzPTomJQO3bMFkGDKzhOpea7LNuUkVzFUO4xLCBLcFQa8UmMflF5/gi2Fm8
         dJjQjIiSV5jg68sFWfg5U2cTVkpsVoGbBUlSy8OzZamVq6OoZoNtYpY1TTJjMtsfqz7I
         G3lGpAAstDpoCLUcZPzqid4474NqUr+Gwd8SY/PGbYPOi9ErR1Zy2iM9wbP8hA3tb1qi
         w9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021522; x=1717626322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ+qSEgBrLBvhAOp1UtC+ym/4hvmQ3RllnsY91gsYcQ=;
        b=rEs926h1gK/dNT1YFILVBkV6gI25aSqz3yyEtnkd5tOgF+qasSRlo/rXgFzG7utpO2
         WwASEkmxl4/T3ezLb7j0zqNH8/5MWExf2HO1cIGt8bJTgJ5NMahmuGswMMEe6vjEwqMr
         9sDux+UTaDvWd0o5VDRgwDqt5p5UW5U+iDl3Wmk8tg5pbP4CBYpdOdAoeHYzz0+2esKj
         6Lp0bDKuZ3qGpMbvvoBnC+m3ym3mwDJGsRC/ndWj8T1Ii8PgqAQHs5Xyn/qpUSYKlfr+
         asFJQvphJU508mw5pRwMz4MFkj6Sp8rtvZvtH8Tf5+t9Ly5kFWtlaa9swDzgUUhD62Hy
         UbjA==
X-Forwarded-Encrypted: i=1; AJvYcCV29rFtIAt8j4hX44t8pCvH0yA1xdo9eaNX7L3dIbTYPslDYeG268I/6xEIxWoVjbSGvMJiT1FTlsaWbD6b59FEV4vT4yEDnCCoSa9j3ZndhfD3hzkkP8ok4cST8ysB5tKwrAn6bgummVeY69tkcRRYa4j12rSWyyYIGBxpbS9Uk1ekHyq+
X-Gm-Message-State: AOJu0YwCaI8zS0xxzZC4FfoQsfaSUsRha3VGGw0kVGnqZ41LoZ+r/2/w
	tkn5Fx1nFdixiPma8tUi66DwljB1JIlPnzUk8N04wRnxgkTCIwNG
X-Google-Smtp-Source: AGHT+IFNLl8Gjlmqq+BUmjnxhyhgz+Zw/vqVkbsklBg+WD0FCkJ5yS8cue2rTR79uuAHHZmgekfafA==
X-Received: by 2002:a17:90b:1c10:b0:2b6:2067:dd15 with SMTP id 98e67ed59e1d1-2c1abc4a29cmr454011a91.40.1717021522387;
        Wed, 29 May 2024 15:25:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a7797138sm325651a91.41.2024.05.29.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:25:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:25:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Add max6639
Message-ID: <ef2e8946-27e7-483c-a234-7e7a6df0b787@roeck-us.net>
References: <20240528125122.1129986-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528125122.1129986-1-naresh.solanki@9elements.com>

On Tue, May 28, 2024 at 06:21:21PM +0530, Naresh Solanki wrote:
> Add Devicetree binding documentation for Maxim MAX6639 temperature
> monitor with PWM fan-speed controller.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied (and I'll drop the '|' after description:).

Thanks,
Guenter

> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> 
> 
> base-commit: 5fbf8734fb36cf67339f599f0e51747a6aff690c
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> new file mode 100644
> index 000000000000..a2e37f7329b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim max6639
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +description: |
> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
> +  fan-speed controller.  It monitors its own temperature and one external
> +  diode-connected transistor or the temperatures of two external diode-connected
> +  transistors, typically available in CPUs, FPGAs, or GPUs.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max6639
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#pwm-cells':
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^fan@[0-1]$":
> +    type: object
> +    description: |
> +      Represents the two fans and their specific configuration.
> +
> +    $ref: fan-common.yaml#
> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: |
> +          The fan number.
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fan1: fan-controller@10 {
> +            compatible = "maxim,max6639";
> +            reg = <0x10>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #pwm-cells = <3>;
> +
> +            fan@0 {
> +                reg = <0x0>;
> +                pulses-per-revolution = <2>;
> +                max-rpm = <4000>;
> +                target-rpm = <1000>;
> +                pwms = <&fan1 0 25000 0>;
> +            };
> +
> +            fan@1 {
> +                reg = <0x1>;
> +                pulses-per-revolution = <2>;
> +                max-rpm = <8000>;
> +                pwms = <&fan1 1 25000 0>;
> +            };
> +        };
> +    };
> +...

