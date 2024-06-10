Return-Path: <linux-kernel+bounces-207986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D993901EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5A31F25C50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09E762EB;
	Mon, 10 Jun 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p4fUkysN"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CE282EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013853; cv=none; b=AslIFMbMNLmKRZ6gzkSVZsyPCrxz+PIvMbkPODt3btBLnsD04kH1aWRSbg2gzvf8qlsFVYShPR+vcwlha8Tk6XPwSZcJUWSabgoh42djzII5EjVFFClY55vJjg1XcgLPTWAVpDB4EFWFK5F0OpbQSCUn+ukfg6dAowP6PqiuHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013853; c=relaxed/simple;
	bh=M+z9EGehKc7WekRDesUv7b2e6+dLTQHN5H+ZQO0R5LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DUk6eoFHTYqIsVUN35ypCdQuBp5+Lxa7iEgY5cs70DFjwrBMjNoFHORoI1uEEHZ9fGRrLW6tFceq0mI+rPFUTqd7inIkB+NNaXsCztGf6gDOl73XSXHJiyJyVg1Me71JJ149N5onfFNEC4PKWKlXwAuEBTxZ/0a9/VMkhIGSoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p4fUkysN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354b722fe81so3635336f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718013850; x=1718618650; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgW8B70Q8zX7acFGE+7FKzyC1rI3PYnZTOkuVMqMUeM=;
        b=p4fUkysNAAmS3y6BvkkKl96K1aimot1o+27iV3h8jsAJt2J0oDjoEHQwARrrDRU1+9
         J3SlTk7QaYoQhhBMydqdopBM4xSDFInp2E8VWVaESmUR6o5pJz+AxiMtg6tixUbzFn/3
         t1+KfW8AX+IWqzM8whW2HHyYjrn1vtiTmGIzaaQ7Z1C/Z9s/itAWG2y+JhZYXqku0dfN
         Pa5uIXMGsCitU4MzV0+dga0dg3gRWxz5llPYeRd+CSK85s0aSvA79YQkrvobY6bXlKNy
         OcU7NgFFqgjL06UzvZ5nglK8L+fHfxMBk3ocq2DR+lomrRcLVchJ1ENH691HJXTnmgc5
         yfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013850; x=1718618650;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgW8B70Q8zX7acFGE+7FKzyC1rI3PYnZTOkuVMqMUeM=;
        b=sjAHoTq6+FCtIJtXbGp20Oek7p9OFPUhagE7CvVFaWL1iBP/kryEpTCiAPmysr7AJ/
         8TEDkucFcgl5i+nvjSxZPIgOTFaQB0c0tevprQynHe6nLTn3axnOWO/AxLrNj9cM6Ujo
         +xe9u1gNhCLNiiCyFrlkmqzN6zgQ78eJ8+yZfeLM61OVCKGNjqU9aXAdGXl+IKNbj1iX
         VKuYz9Rep6p8pdORxl+7SfKW9vZ4H0WxTi1VmuH+qvKQ4jf+UuvXFreYije4WqXPN93e
         zxNey/Iprooh+BIkiuJxt0QLCB88htians9wHIdQgggfDgox5Fi5J9xjdEnO5jBjOe3p
         6gRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM2+mv9AZ4J2vW7iJkZHEs7iX610RTkRxfk33LnkA9SiGntSasHbrSy1l/DQuTAFd7/yuDPTPP9rSDOo3/pbtUIqZsMxBpKGc7uhoc
X-Gm-Message-State: AOJu0YxV5tjOKCj4l0idO/LqktPYGImUvJbcZzN4RTNBC4Ci9Iazvu+d
	Se+pvIP05p6mjra4W/HcIfq5kLtQkm5dvOsmMARtLhAI1by6U4f03gLgzxU2l5M=
X-Google-Smtp-Source: AGHT+IGSgkd3LqLIyxqDoIX0DW/WYOv65XykZ7jmOpZ9kbZonCQsXNHJT+NKtkJEDBC3j4DrawCjIw==
X-Received: by 2002:adf:f6c4:0:b0:35f:16a4:6b99 with SMTP id ffacd0b85a97d-35f16a46c11mr2450784f8f.4.1718013850018;
        Mon, 10 Jun 2024 03:04:10 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:afd3:66ee:5486:4249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0e49e898sm6844132f8f.22.2024.06.10.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:04:09 -0700 (PDT)
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
In-Reply-To: <20240515185103.20256-7-ddrokosov@salutedevices.com> (Dmitry
	Rokosov's message of "Wed, 15 May 2024 21:47:29 +0300")
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
	<20240515185103.20256-7-ddrokosov@salutedevices.com>
Date: Mon, 10 Jun 2024 12:04:09 +0200
Message-ID: <1jtti1p10m.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 15 May 2024 at 21:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Add the documentation and dt bindings for Amlogic A1 CPU clock
> controller.
>
> This controller consists of the general 'cpu_clk' and two main parents:
> 'cpu fixed clock' and 'syspll'. The 'cpu fixed clock' is an internal
> fixed clock, while the 'syspll' serves as an external input from the A1
> PLL clock controller.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/clock/amlogic,a1-cpu-clkc.yaml   | 64 +++++++++++++++++++
>  .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   | 19 ++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
> new file mode 100644
> index 000000000000..f4958b315ed4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,a1-cpu-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic A1 CPU Clock Control Unit
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Dmitry Rokosov <ddrokosov@salutedevices.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a1-cpu-clkc
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: input fixed pll div2
> +      - description: input fixed pll div3
> +      - description: input sys pll
> +      - description: input oscillator (usually at 24MHz)

According to the documentation, fdiv5 is also an input of the CPU clock
tree.

That is typically the kind of things we'd prefer to get right from the
beginning to avoid modifying the bindings later.

> +
> +  clock-names:
> +    items:
> +      - const: fclk_div2
> +      - const: fclk_div3
> +      - const: sys_pll
> +      - const: xtal
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@fd000000 {
> +            compatible = "amlogic,a1-cpu-clkc";
> +            reg = <0 0xfd000080 0 0x8>;

If reg is <0 0xfd000080 0 0x8> then node name should be clock-controller@fd000080

> +            #clock-cells = <1>;
> +            clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> +                     <&clkc_pll CLKID_FCLK_DIV3>,
> +                     <&clkc_pll CLKID_SYS_PLL>,
> +                     <&xtal>;
> +            clock-names = "fclk_div2", "fclk_div3", "sys_pll", "xtal";
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/amlogic,a1-cpu-clkc.h b/include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
> new file mode 100644
> index 000000000000..1d321c6eddb7
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
> + */
> +
> +#ifndef __A1_CPU_CLKC_H
> +#define __A1_CPU_CLKC_H
> +
> +#define CLKID_CPU_FSOURCE_SEL0	0
> +#define CLKID_CPU_FSOURCE_DIV0	1
> +#define CLKID_CPU_FSEL0		2
> +#define CLKID_CPU_FSOURCE_SEL1	3
> +#define CLKID_CPU_FSOURCE_DIV1	4
> +#define CLKID_CPU_FSEL1		5
> +#define CLKID_CPU_FCLK		6
> +#define CLKID_CPU_CLK		7
> +
> +#endif /* __A1_CPU_CLKC_H */

-- 
Jerome

