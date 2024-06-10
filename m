Return-Path: <linux-kernel+bounces-208100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4429020A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482191F220E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0807E111;
	Mon, 10 Jun 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xjNQzTA0"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E626FB6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020033; cv=none; b=hf2JNu7DfhkXwrjJ4/J/AXn4Am/GS8x5Z1F6vRkEKmjo251ZfGAym+hEMUq5foUX/VQHlCG0BDr7v4tK5g3KycdetLk0xz9sRkhGtuQHOSDeBbOQGC26x8fPRfeJE7KOkoU6PnuFTSvJN2WSC1stjE5TiplWlp/a3bup61qAmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020033; c=relaxed/simple;
	bh=tOvzwj5vokdXnrKvZHntZn8CKFCMZxBZ2+KO2btHdC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HtsZaruF564HslG0PPXcZcp3wba1hOggtD2zchwdk+cda0XVbsesnt4fxVnE5gdrz0JVkOzTaXryveaO/yGNi5JfqRGk/0+tHbdQG/xp7Tr+wqZ++VU6u7BK8IX3qugUBq/AJOaIh5YphFW6HGwlYtumV9c59iACwZDLiwZmZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xjNQzTA0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f225ac23bso909807f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718020028; x=1718624828; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rb8Pgp2xqT7cIYki1CL83VCOh424IkKn+0tsBgMjwTI=;
        b=xjNQzTA0mihmhrpbuYY0JfiCN+AFdFwcjdRTzmpMg7z4UDu37JzXgLnNyRpMCd0pN/
         9BpetK/fJw56rdeP46i8kQhNCKVtX9yQMalKC9U5wozmmLjAQtR5VIqoIai6YSca/xmn
         a5GwQXehViYhMShwEENU98FYHbn4irU9RQVorIVhLTrgNXyAbPyodHSLzV8GBhtUTSNe
         AZu82932erNaEu6BH7EkkQonFubl51OK9VRxLXz2wpH56ut6cj2LjeLFV3419PrNYSeU
         J8fIIu39YtviJsv4eo6NR9xkluR2/mLK5FfKlqmWjil5S9FZrFtmZXyuiOoV07vOi5eJ
         9oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020028; x=1718624828;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rb8Pgp2xqT7cIYki1CL83VCOh424IkKn+0tsBgMjwTI=;
        b=rQtCJtNfGXh4Tekm+DLO+OkRLPwPkbr2AAX1WAukC9TTj1KsrhQbk0/65cyOwJHz9V
         rarkzDpa50jpZO11Ym+xefKNz0oBsDGpzxetsQwf/pvk2o7OniE640HxClPhyK28sQ+H
         422uEoexJap+wEtIYxoVRnBtdSLWueOlc28hml5Ih0V7rzIFiLP/IBOaWOH4+xqsQvP3
         IpNwICjdDTRn47s9hXUPWF5dElyr3tNeF7JWGcQtay5n8dGzKlJOdnNI8o6aTf+icxZ7
         VcgBqpzXzC0vYs7IPvzbEXHlvnif4ZWiLt8osKwXzIfKIRjx/4hNGBoP5PiAaWgZb0Ox
         MWig==
X-Forwarded-Encrypted: i=1; AJvYcCVuKoZp9TZziPREDfz5us1tEbmuPGmJp+OaqPKsqgThFFRP2FH0CMulnku0yCPIrFX2BH/AcrxpyHWdi7LIXPiTZT+0D2Zgtfjf8o2r
X-Gm-Message-State: AOJu0YywG/aS4jweOkJ1KleHJztqZEauajNL8qW84GV9d6lzise/m1hI
	IoaedFv+g7FebWiAkB4S834XGLMvZuGfpyj5Bs/BnkTeTX6tmolSFvkqkg3Sw/c=
X-Google-Smtp-Source: AGHT+IHALXrUP/ilTuRks1bDqpKHDSOZ0fxOLIroYwbtLGrwC2bQGMJQpHI/3NMnoy0xSxmxFpGrmw==
X-Received: by 2002:a05:6000:1886:b0:35f:17c8:fe2d with SMTP id ffacd0b85a97d-35f17c8ff54mr5235072f8f.37.1718020027718;
        Mon, 10 Jun 2024 04:47:07 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:afd3:66ee:5486:4249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f209c4a4asm3601821f8f.43.2024.06.10.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:47:07 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: <neil.armstrong@linaro.org>,  <mturquette@baylibre.com>,
  <sboyd@kernel.org>,  <robh+dt@kernel.org>,
  <krzysztof.kozlowski+dt@linaro.org>,  <khilman@baylibre.com>,
  <martin.blumenstingl@googlemail.com>,  <jian.hu@amlogic.com>,
  <kernel@sberdevices.ru>,  <rockosov@gmail.com>,
  <linux-amlogic@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: clock: meson: add A1 CPU clock
 controller bindings
In-Reply-To: <20240610111826.im3mz64hjfkxrxhr@CAB-WSD-L081021> (Dmitry
	Rokosov's message of "Mon, 10 Jun 2024 14:18:26 +0300")
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
	<20240515185103.20256-7-ddrokosov@salutedevices.com>
	<1jtti1p10m.fsf@starbuckisacylon.baylibre.com>
	<20240610111826.im3mz64hjfkxrxhr@CAB-WSD-L081021>
Date: Mon, 10 Jun 2024 13:47:06 +0200
Message-ID: <1j7cexow91.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 10 Jun 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Hello Jerome,
>
> Thank you for the review!
>
> On Mon, Jun 10, 2024 at 12:04:09PM +0200, Jerome Brunet wrote:
>> On Wed 15 May 2024 at 21:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> 
>> > Add the documentation and dt bindings for Amlogic A1 CPU clock
>> > controller.
>> >
>> > This controller consists of the general 'cpu_clk' and two main parents:
>> > 'cpu fixed clock' and 'syspll'. The 'cpu fixed clock' is an internal
>> > fixed clock, while the 'syspll' serves as an external input from the A1
>> > PLL clock controller.
>> >
>> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>> > ---
>> >  .../bindings/clock/amlogic,a1-cpu-clkc.yaml   | 64 +++++++++++++++++++
>> >  .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   | 19 ++++++
>> >  2 files changed, 83 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
>> >  create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
>> >
>> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
>> > new file mode 100644
>> > index 000000000000..f4958b315ed4
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
>> > @@ -0,0 +1,64 @@
>> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/clock/amlogic,a1-cpu-clkc.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Amlogic A1 CPU Clock Control Unit
>> > +
>> > +maintainers:
>> > +  - Neil Armstrong <neil.armstrong@linaro.org>
>> > +  - Jerome Brunet <jbrunet@baylibre.com>
>> > +  - Dmitry Rokosov <ddrokosov@salutedevices.com>
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: amlogic,a1-cpu-clkc
>> > +
>> > +  '#clock-cells':
>> > +    const: 1
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  clocks:
>> > +    items:
>> > +      - description: input fixed pll div2
>> > +      - description: input fixed pll div3
>> > +      - description: input sys pll
>> > +      - description: input oscillator (usually at 24MHz)
>> 
>> According to the documentation, fdiv5 is also an input of the CPU clock
>> tree.
>> 
>> That is typically the kind of things we'd prefer to get right from the
>> beginning to avoid modifying the bindings later.
>> 
>
> Could you please share which documentation you are referencing? I have
> the A113L documentation, and there is no mention of the CPU clock IP.

You should get in touch with Amlogic.

> I retrieved below register map from the vendor's custom driver:
>
> ===
> CPUCTRL_CLK_CTRL0
>
> bits 1:0 - cpu_fsource_sel0
>     0 - xtal
>     1 - fclk_div2
>     2 - fclk_div3
>
> bit 2 - cpu_fsel0
>     0 - cpu_fsource_sel0
>     1 - cpu_fsource_div0
>
> bit 3 - UNKNONWN
>
> bits 9:4 - cpu_fsource_div0
>     Divider value
>
> bit 10 - cpu_fclk
>     0 - cpu_fsel0
>     1 - cpu_fsel1
>
> bit 11 - cpu_clk
>     0 - cpu_fclk
>     1 - sys_pll
>
> bits 15:12 - UNKNONWN
>
> bits 17:16 - cpu_fsource_sel1
>     0 - xtal
>     1 - fclk_div2
>     2 - fclk_div3
>
> bit 18 - cpu_fsel1
>     0 - cpu_fsource_sel1
>     1 - cpu_fsource_div1
>
> bit 19 - UNKNONWN
>
> bits 25:20 - cpu_fsource_div1
>     Divider value
>
> bits 31:26 - UNKNONWN
> ===
>
> As you can see it doesn't have any other inputs except fclk_div2,
> fclk_div3, sys_pll and xtal.

You might not know what to do with it yet, still it is part of the
documentation and should be part of the bindings too

>
>> > +
>> > +  clock-names:
>> > +    items:
>> > +      - const: fclk_div2
>> > +      - const: fclk_div3
>> > +      - const: sys_pll
>> > +      - const: xtal
>> > +
>> > +required:
>> > +  - compatible
>> > +  - '#clock-cells'
>> > +  - reg
>> > +  - clocks
>> > +  - clock-names
>> > +
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
>> > +    apb {
>> > +        #address-cells = <2>;
>> > +        #size-cells = <2>;
>> > +
>> > +        clock-controller@fd000000 {
>> > +            compatible = "amlogic,a1-cpu-clkc";
>> > +            reg = <0 0xfd000080 0 0x8>;
>> 
>> If reg is <0 0xfd000080 0 0x8> then node name should be clock-controller@fd000080
>> 
>
> Okay, I will fix that example in the next version.
>
> [...]

-- 
Jerome

