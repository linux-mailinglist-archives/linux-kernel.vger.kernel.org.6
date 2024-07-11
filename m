Return-Path: <linux-kernel+bounces-249477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3092EC3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376211F229B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CA16C857;
	Thu, 11 Jul 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2Phb2w2"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A115957E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713873; cv=none; b=JwbM84/3DnEgMje2Jf/6Gj+YpNsaYo/cp+0SM7tqrNQXlUcI4l7hQroIy8tQED4xlHMHUzZNT8NAwMmEpuNPvz5fGFgXoPHpuZ/7KixQ6rnA33qZAAojka7JRdYg+q3Y0pfEGW415fWWV647v2FBYUaAnRrNVteGeD9rlOe12NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713873; c=relaxed/simple;
	bh=nRhmfOkOiMwMxuiEsZWAibaCH3kiMmeXotujBTYqwGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLISblw5rl/48bVCH+AzoWnQrQhSVr6FD+dCVuOu64xRudE6PkVyHxRFloifONpMIFFQnOlrXrrEDovxGYTFDbUJ+JiwV0lZ/9xymodY3flDXK0+q5+O7gAQsfB7Lc3F0QuK8nK7gR0LSYFj0rtNexRPUE6kD/OuZkoNnFYmhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2Phb2w2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79ef72bb8c8so53085585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713870; x=1721318670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxN3s6nuZJqvq8DC28raU71Ooyh30+AAwSywlCQM0WQ=;
        b=x2Phb2w2O86qaf8uiFNa0GVh8RZTYG7myxShcwk9k0R8di7itgf897QhHQOpwLr9od
         Qrk0gBjJLOZvrQ42stLOD2rnWpr8I90TX1obg0zGZFBrsZQBBhbZrZjx88eL+pEROif+
         aHFlCg09/kIkqQ3xxT6xL0eAEdfbA5w+5bgUtFJgAolZBki9SY+QmPozMH/6smNtYNNp
         lGaXgUumQK2MrhiaGmW1+rbrM6FlrCOqOuDqJbXpoUnAzRSX818JtcoUnr6vpmcPqiQo
         KjXwiwlmY1Yk3+lYZb8byqsLqiDvyyW1WQOqdPrMk7MMai6//RekwPon++IXYZ/aIg0S
         nwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713870; x=1721318670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxN3s6nuZJqvq8DC28raU71Ooyh30+AAwSywlCQM0WQ=;
        b=pr/FGN9WPrAZKQauivupX/hhjbmFh8KnsuqrGcKGKcPX4hOt46cKns57WqTkBGcPi7
         aVEjJMCJ8dhY+WHTTJ9lqwgqUWcXptVD7fwhNzc+K9uFQFNdJDibr0V3cZ0EESm5y60X
         /Co0UQYHBEpr8sIvYPkbbEz+ZD14V7Uy5BkXPKKEVUBkL97lT5xeBpHdCbTMNSyDPNbi
         aMdDUGucbJDlEelmXveD8Z6V8A/3am8iHhbzKzvjfqIP1uCvsXOfuzHZZ1N03umDSxZe
         CLzSpYyoFfm4vR9bnAhkFJGxR7tTHwK6R1Gq2Ius53I6jMbzLUcd2CyfCoislEr10JL+
         FdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR/7XpJgQoxLiR1f9NQcXRj70HchFlukYq39R/4sUCUNNntDc198Nop7pHpapShKCFDwDoxpXLGyt0qXFfBoHbssQ1zDMIE3hHLSyV
X-Gm-Message-State: AOJu0YwwKc5WspR47YVDSZkgWR9qW8ALzMaSze24Kwi+7R56fNjUP7jr
	r61DDcUkKHe0yWctBddGJaJqyEDhXpEGQViLzevTbG4L2Sf6XYeOd3b9j19JZXhu1wtGr5J7A99
	Aq2bhP0ptO/Oa0PAiM5/WSFnG5F63oBX/JfMyOOvg6z+xEyKq
X-Google-Smtp-Source: AGHT+IENa/OdBJvNNewkRFuQFJPGA/W8bG6u0eoKZ4lqUN11GYxJOj6CetYAgO2dIe+YRPD8wBqsE46J87830t84DcQ=
X-Received: by 2002:a25:c7ce:0:b0:e03:c414:a8a9 with SMTP id
 3f1490d57ef6-e041b054a16mr9882636276.23.1720713849532; Thu, 11 Jul 2024
 09:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZozY+tOkzK9yfjbo@standask-GA-A55M-S2HP>
In-Reply-To: <ZozY+tOkzK9yfjbo@standask-GA-A55M-S2HP>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 18:03:31 +0200
Message-ID: <CAPDyKFqV2ubdTXZcG_=6YMCwRKdhgB2YbcVg_iA7i=mtvb7Uqg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: sdhci-sprd: convert to YAML
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baolin Wang <baolin.wang7@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 08:30, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>
> Covert the Spreadtrum SDHCI controller bindings to DT schema.
> Rename the file to match compatible. Drop assigned-* properties as
> these should not be needed.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Node name adjustments in DTS are being handled as part of:
> https://lore.kernel.org/lkml/cover.1720112081.git.stano.jakubek@gmail.com/
>
> Changes in V2:
>   - drop assigned-* properties, these shouldn't be needed (Krzysztof)
>   - reflect this change in the commit description
>
>  .../devicetree/bindings/mmc/sdhci-sprd.txt    |  67 -----------
>  .../bindings/mmc/sprd,sdhci-r11.yaml          | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> deleted file mode 100644
> index eb7eb1b529f0..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -* Spreadtrum SDHCI controller (sdhci-sprd)
> -
> -The Secure Digital (SD) Host controller on Spreadtrum SoCs provides an interface
> -for MMC, SD and SDIO types of cards.
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci-sprd driver.
> -
> -Required properties:
> -- compatible: Should contain "sprd,sdhci-r11".
> -- reg: physical base address of the controller and length.
> -- interrupts: Interrupts used by the SDHCI controller.
> -- clocks: Should contain phandle for the clock feeding the SDHCI controller
> -- clock-names: Should contain the following:
> -       "sdio" - SDIO source clock (required)
> -       "enable" - gate clock which used for enabling/disabling the device (required)
> -       "2x_enable" - gate clock controlling the device for some special platforms (optional)
> -
> -Optional properties:
> -- assigned-clocks: the same with "sdio" clock
> -- assigned-clock-parents: the default parent of "sdio" clock
> -- pinctrl-names: should be "default", "state_uhs"
> -- pinctrl-0: should contain default/high speed pin control
> -- pinctrl-1: should contain uhs mode pin control
> -
> -PHY DLL delays are used to delay the data valid window, and align the window
> -to sampling clock. PHY DLL delays can be configured by following properties,
> -and each property contains 4 cells which are used to configure the clock data
> -write line delay value, clock read command line delay value, clock read data
> -positive edge delay value and clock read data negative edge delay value.
> -Each cell's delay value unit is cycle of the PHY clock.
> -
> -- sprd,phy-delay-legacy: Delay value for legacy timing.
> -- sprd,phy-delay-sd-highspeed: Delay value for SD high-speed timing.
> -- sprd,phy-delay-sd-uhs-sdr50: Delay value for SD UHS SDR50 timing.
> -- sprd,phy-delay-sd-uhs-sdr104: Delay value for SD UHS SDR50 timing.
> -- sprd,phy-delay-mmc-highspeed: Delay value for MMC high-speed timing.
> -- sprd,phy-delay-mmc-ddr52: Delay value for MMC DDR52 timing.
> -- sprd,phy-delay-mmc-hs200: Delay value for MMC HS200 timing.
> -- sprd,phy-delay-mmc-hs400: Delay value for MMC HS400 timing.
> -- sprd,phy-delay-mmc-hs400es: Delay value for MMC HS400 enhanced strobe timing.
> -
> -Examples:
> -
> -sdio0: sdio@20600000 {
> -       compatible  = "sprd,sdhci-r11";
> -       reg = <0 0x20600000 0 0x1000>;
> -       interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> -
> -       clock-names = "sdio", "enable";
> -       clocks = <&ap_clk CLK_EMMC_2X>,
> -                <&apahb_gate CLK_EMMC_EB>;
> -       assigned-clocks = <&ap_clk CLK_EMMC_2X>;
> -       assigned-clock-parents = <&rpll CLK_RPLL_390M>;
> -
> -       pinctrl-names = "default", "state_uhs";
> -       pinctrl-0 = <&sd0_pins_default>;
> -       pinctrl-1 = <&sd0_pins_uhs>;
> -
> -       sprd,phy-delay-sd-uhs-sdr104 = <0x3f 0x7f 0x2e 0x2e>;
> -       bus-width = <8>;
> -       non-removable;
> -       no-sdio;
> -       no-sd;
> -       cap-mmc-hw-reset;
> -       status = "okay";
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml b/Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml
> new file mode 100644
> index 000000000000..b08081bc018b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sprd,sdhci-r11.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sprd,sdhci-r11.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum SDHCI controller
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sprd,sdhci-r11
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    items:
> +      - description: SDIO source clock
> +      - description: gate clock for enabling/disabling the device
> +      - description: gate clock controlling the device for some special platforms (optional)
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: sdio
> +      - const: enable
> +      - const: 2x_enable
> +
> +  pinctrl-0:
> +    description: default/high speed pin control
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    description: UHS mode pin control
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: state_uhs
> +
> +patternProperties:
> +  "^sprd,phy-delay-(legacy|mmc-(ddr52|highspeed|hs[24]00|hs400es)|sd-(highspeed|uhs-sdr(50|104)))$":
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: clock data write line delay value
> +      - description: clock read command line delay value
> +      - description: clock read data positive edge delay value
> +      - description: clock read data negative edge delay value
> +    description:
> +      PHY DLL delays are used to delay the data valid window, and align
> +      the window to the sampling clock. Each cell's delay value unit is
> +      cycle of the PHY clock.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: sdhci-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sprd,sc9860-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mmc@50430000 {
> +      compatible = "sprd,sdhci-r11";
> +      reg = <0x50430000 0x1000>;
> +      interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +
> +      clocks = <&aon_prediv CLK_EMMC_2X>,
> +               <&apahb_gate CLK_EMMC_EB>,
> +               <&aon_gate CLK_EMMC_2X_EN>;
> +      clock-names = "sdio", "enable", "2x_enable";
> +
> +      pinctrl-0 = <&sd0_pins_default>;
> +      pinctrl-1 = <&sd0_pins_uhs>;
> +      pinctrl-names = "default", "state_uhs";
> +
> +      bus-width = <8>;
> +      cap-mmc-hw-reset;
> +      mmc-hs400-enhanced-strobe;
> +      mmc-hs400-1_8v;
> +      mmc-hs200-1_8v;
> +      mmc-ddr-1_8v;
> +      non-removable;
> +      no-sdio;
> +      no-sd;
> +
> +      sprd,phy-delay-mmc-ddr52 = <0x3f 0x75 0x14 0x14>;
> +      sprd,phy-delay-mmc-hs200 = <0x0 0x8c 0x8c 0x8c>;
> +      sprd,phy-delay-mmc-hs400 = <0x44 0x7f 0x2e 0x2e>;
> +      sprd,phy-delay-mmc-hs400es = <0x3f 0x3f 0x2e 0x2e>;
> +    };
> +...
> --
> 2.34.1
>

