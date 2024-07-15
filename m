Return-Path: <linux-kernel+bounces-252920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED999319E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B478C283134
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48A61FD4;
	Mon, 15 Jul 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="U1nZRdDG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72B4E1C8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066297; cv=none; b=Jue6RODTPzSXROWwXodkRts6AzwEzb0f5WyuP9Ni59L2BuezpS/qsX/RceEP2Uoia8cUIBZ5q0GlMpmFW4svUnwFB+H4eolgv0BvVIl+drL5hg73HIkynWdTF3NlB0XLNJkiQ4WiOS0Eokg4/odZvTUrbjMHvUuX4VlkIRjeCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066297; c=relaxed/simple;
	bh=hma33S0us/H5J1KAmhwdo7cjc1XHnhLFL86pri6C2Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BCjwwpIEKuEGJctDeHZXdLoJtRGeGlvVSiDxgTtHp/g/t2u32VvZWCGvHdyhh4AIkz+iAfLAs0shVDN/kLncJUwMRNL2JBCVpPaJrdJqu4GdpMpf+Q1qK/PABRN9w7DYNIEzwxB0vgonFmjp02JNKTKoLI2kszpAWO9Nm6dJLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=U1nZRdDG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36805befd01so1731781f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1721066292; x=1721671092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxE/UCaOWVOw5+At1QVf9Eh9DLjmI+murRCIv8xgIlM=;
        b=U1nZRdDGaOgyzoxuVrkb3y7P7RGrhn2SIaIDJK4HPZeypbrpWbtBF5KmaxKLotf3Xf
         bgyyUByRrTn8uQnVrz6XnAm+H1gOqE1RJDHCPTsKorY+nSVxa+GVASp7YpUfikP5iYCd
         oIGukfnyWnrdhCdk1qxWSmVGzJgh+FXEE7yLlOx2I/nKhjAVckkRCVoQqBifH1Pz0qmX
         JbzVaZvWu7fwdLiEaaqutNzC3rVH+w3UFMLz6iOtEbG/Gdu70ANRh32jOlx703K2M26/
         GXFdZOILw6cXotF1YGfG1J391qu2lSotmU4T/bOnyr3mnL1lYdkizXgYN4LEvRJf8bna
         qQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066292; x=1721671092;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxE/UCaOWVOw5+At1QVf9Eh9DLjmI+murRCIv8xgIlM=;
        b=TGgrVe0uWr73ajREdfWpEAaEwVNpQdRonqleAjRM3eklUtQeq9oPNB9hSxzcQdRLGx
         bjsdANVlflBhAvsnO77a+xmwWm7thxIaYH+2POxE+L1d4nZmYdnsH68e7a3StwRkZe2K
         Dr2Eo4bW5rqR2TgwhwUWvEzOUobYQVzn8WNdCMyO1kNxM58dHgSBKnJg8T7GyrI9CPm9
         WXqUXkylVGI3lQ78MZ5FPM5QjobY0wVmf2oKUexiQWR3JD3lOv233UxaPJsaXG93hBXH
         Obb0j+J97xuTfXiOHrArYXgJOOZDqKSh6/0YoyVhfG0wXsn67/8eAMyMoJjMZJdk2GWN
         Ngiw==
X-Forwarded-Encrypted: i=1; AJvYcCXCxw+YSxEheHZbmfJiNezdUeDzlqanv3H3CjTN0Ng4S3Z0IoQthGjlN8AS7dfzRVyBhMzFy5chvCRIeIhpyf7K/UAZFhPjjd6hVRlO
X-Gm-Message-State: AOJu0YyUZDCP+OHfUUo0GDRMLuAoXyBetTRLX8PNISQ7Pju19+nMTvKP
	5nG9RWAkGIFXpcaE/aOApK+XHSIz6hn60ZnYQIyIb4HPAFK2jQOYTnKBZ1G7CS4=
X-Google-Smtp-Source: AGHT+IGGhsMo2NnjPGL67EAbM1C5WsEOCLsUe9p5krXf+eW0Ov0v4zXnXvJ37CDgU6IC2tsrjKZXbg==
X-Received: by 2002:a5d:6dce:0:b0:364:d2b6:4520 with SMTP id ffacd0b85a97d-36823e60497mr367337f8f.0.1721066292165;
        Mon, 15 Jul 2024 10:58:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf4bsm7038304f8f.73.2024.07.15.10.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 10:58:11 -0700 (PDT)
Message-ID: <c14b3c4d-668f-49c5-b521-575b895ed2c9@tuxon.dev>
Date: Mon, 15 Jul 2024 20:58:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
Content-Language: en-US
To: Varshini.Rajendran@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102923.196556-1-varshini.rajendran@microchip.com>
 <3b077b02-b98c-4c2c-b16e-8842e2cdf27c@tuxon.dev>
 <ae365aad-efd0-43ac-bf46-dbd8f67f7dcb@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ae365aad-efd0-43ac-bf46-dbd8f67f7dcb@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.07.2024 13:47, Varshini.Rajendran@microchip.com wrote:
> Hi Claudiu,
> 
> On 14/07/24 7:14 pm, claudiu beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Varshini,
>>
>> On 03.07.2024 13:29, Varshini Rajendran wrote:
>>> Add device tree file for SAM9X7 SoC family.
>>>
>>> Co-developed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>> Changed in v5:
>>> - Sorted node properties according dts coding style.
>>> - Removed space before pwn status.
>>> - Fixed DT schema warnings related to usart.
>>> - Aligned <> braces.
>>> - Changed spaces to tabs.
>>> - Changed node names to generic names.
>>> - Corrected the typo in gpbr compatible.
>>> ---
>>>   arch/arm/boot/dts/microchip/sam9x7.dtsi | 1226 +++++++++++++++++++++++
>>>   1 file changed, 1226 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
>>> new file mode 100644
>>> index 000000000000..0e3fb94f40b6
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
>>> @@ -0,0 +1,1226 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * sam9x7.dtsi - Device Tree Include file for Microchip SAM9X7 SoC family
>>> + *
>>> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
>>> + *
>>> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> + */
>>> +
>>> +#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/dma/at91.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/mfd/at91-usart.h>
>>> +#include <dt-bindings/mfd/atmel-flexcom.h>
>>> +#include <dt-bindings/pinctrl/at91.h>
>>> +
>>> +/ {
>>> +     model = "Microchip SAM9X7 SoC";
>>> +     compatible = "microchip,sam9x7";
>>> +     #address-cells = <1>;
>>> +     #size-cells = <1>;
>>> +     interrupt-parent = <&aic>;
>>> +
>>> +     aliases {
>>> +             serial0 = &dbgu;
>>> +             gpio0 = &pioA;
>>> +             gpio1 = &pioB;
>>> +             gpio2 = &pioC;
>>> +             gpio3 = &pioD;
>>> +     };
>>> +
>>> +     cpus {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>> +
>>> +             cpu@0 {
>>> +                     compatible = "arm,arm926ej-s";
>>> +                     reg = <0>;
>>> +                     device_type = "cpu";
>>> +             };
>>> +     };
>>> +
>>> +     clocks {
>>> +             slow_xtal: clock-slowxtal {
>>> +                     compatible = "fixed-clock";
>>> +                     #clock-cells = <0>;
>>> +             };
>>> +
>>> +             main_xtal: clock-mainxtal {
>>> +                     compatible = "fixed-clock";
>>> +                     #clock-cells = <0>;
>>> +             };
>>> +     };
>>> +
>>> +     sram: sram@300000 {
>>> +             compatible = "mmio-sram";
>>> +             reg = <0x300000 0x10000>;
>>> +             ranges = <0 0x300000 0x10000>;
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +     };
>>> +
>>> +     ahb {
>>> +             compatible = "simple-bus";
>>> +             ranges;
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +
>>> +             sdmmc0: mmc@80000000 {
>>> +                     compatible = "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci";
>>> +                     reg = <0x80000000 0x300>;
>>> +                     interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 12>, <&pmc PMC_TYPE_GCK 12>;
>>> +                     clock-names = "hclock", "multclk";
>>> +                     assigned-clocks = <&pmc PMC_TYPE_GCK 12>;
>>> +                     assigned-clock-rates = <100000000>;
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             sdmmc1: mmc@90000000 {
>>> +                     compatible = "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci";
>>> +                     reg = <0x90000000 0x300>;
>>> +                     interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 26>, <&pmc PMC_TYPE_GCK 26>;
>>> +                     clock-names = "hclock", "multclk";
>>> +                     assigned-clocks = <&pmc PMC_TYPE_GCK 26>;
>>> +                     assigned-clock-rates = <100000000>;
>>> +                     status = "disabled";
>>> +             };
>>> +     };
>>> +
>>> +     apb {
>>> +             compatible = "simple-bus";
>>> +             ranges;
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +
>>> +             flx4: flexcom@f0000000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf0000000 0x200>;
>>> +                     ranges = <0x0 0xf0000000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart4: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>> According to dts coding style that vendor specific properties goes at the
>> end. I'll adjust it when applying, no need to resend for this. Valid for
>> all the uart flexcom nodes.
> Thanks Claudiu.
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(8))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(9))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     spi4: spi@400 {
>>> +                             compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
>>> +                             reg = <0x400 0x200>;
>>> +                             interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>>> +                             clock-names = "spi_clk";
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(8))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(9))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c4: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(8))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(9))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx5: flexcom@f0004000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf0004000 0x200>;
>>> +                     ranges = <0x0 0xf0004000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart5: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(10))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(11))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     spi5: spi@400 {
>>> +                             compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
>>> +                             reg = <0x400 0x200>;
>>> +                             interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>>> +                             clock-names = "spi_clk";
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(10))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(11))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c5: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(10))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(11))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             dma0: dma-controller@f0008000 {
>>> +                     compatible = "microchip,sam9x7-dma", "atmel,sama5d4-dma";
>>> +                     reg = <0xf0008000 0x1000>;
>>> +                     interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     #dma-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
>>> +                     clock-names = "dma_clk";
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             ssc: ssc@f0010000 {
>>> +                     compatible = "microchip,sam9x7-ssc", "atmel,at91sam9g45-ssc";
>>> +                     reg = <0xf0010000 0x4000>;
>>> +                     interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
>>> +                     clock-names = "pclk";
>>> +                     dmas = <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(38))>,
>>> +                            <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(39))>;
>>> +                     dma-names = "tx", "rx";
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             i2s: i2s@f001c000 {
>>> +                     compatible = "microchip,sam9x7-i2smcc", "microchip,sam9x60-i2smcc";
>>> +                     reg = <0xf001c000 0x100>;
>>> +                     interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 34>, <&pmc PMC_TYPE_GCK 34>;
>>> +                     clock-names = "pclk", "gclk";
>>> +                     dmas = <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(36))>,
>>> +                            <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(37))>;
>>> +                     dma-names = "tx", "rx";
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             flx11: flexcom@f0020000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf0020000 0x200>;
>>> +                     ranges = <0x0 0xf0020000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart11: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(22))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(23))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c11: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(22))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(23))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx12: flexcom@f0024000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf0024000 0x200>;
>>> +                     ranges = <0x0 0xf0024000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart12: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(24))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(25))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c12: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(24))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(25))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             pit64b0: timer@f0028000 {
>>> +                     compatible = "microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b";
>>> +                     reg = <0xf0028000 0x100>;
>>> +                     interrupts = <37 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 37>, <&pmc PMC_TYPE_GCK 37>;
>>> +                     clock-names = "pclk", "gclk";
>>> +             };
>>> +
>>> +             sha: crypto@f002c000 {
>>> +                     compatible = "microchip,sam9x7-sha", "atmel,at91sam9g46-sha";
>>> +                     reg = <0xf002c000 0x100>;
>>> +                     interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
>>> +                     clock-names = "sha_clk";
>>> +                     dmas = <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(34))>;
>>> +                     dma-names = "tx";
>>> +             };
>>> +
>>> +             trng: rng@f0030000 {
>>> +                     compatible = "microchip,sam9x7-trng", "microchip,sam9x60-trng";
>>> +                     reg = <0xf0030000 0x100>;
>>> +                     interrupts = <38 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             aes: crypto@f0034000 {
>>> +                     compatible = "microchip,sam9x7-aes", "atmel,at91sam9g46-aes";
>>> +                     reg = <0xf0034000 0x100>;
>>> +                     interrupts = <39 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
>>> +                     clock-names = "aes_clk";
>>> +                     dmas = <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(32))>,
>>> +                            <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(33))>;
>>> +                     dma-names = "tx", "rx";
>>> +             };
>>> +
>>> +             tdes: crypto@f0038000 {
>>> +                     compatible = "microchip,sam9x7-tdes", "atmel,at91sam9g46-tdes";
>>> +                     reg = <0xf0038000 0x100>;
>>> +                     interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
>>> +                     clock-names = "tdes_clk";
>>> +                     dmas = <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(31))>,
>>> +                            <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(30))>;
>>> +                     dma-names = "tx", "rx";
>>> +             };
>>> +
>>> +             classd: sound@f003c000 {
>>> +                     compatible = "microchip,sam9x7-classd", "atmel,sama5d2-classd";
>>> +                     reg = <0xf003c000 0x100>;
>>> +                     interrupts = <42 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&pmc PMC_TYPE_GCK 42>;
>>> +                     clock-names = "pclk", "gclk";
>>> +                     dmas = <&dma0
>>> +                             (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
>>> +                              AT91_XDMAC_DT_PERID(35))>;
>>> +                     dma-names = "tx";
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             pit64b1: timer@f0040000 {
>>> +                     compatible = "microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b";
>>> +                     reg = <0xf0040000 0x100>;
>>> +                     interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 58>, <&pmc PMC_TYPE_GCK 58>;
>>> +                     clock-names = "pclk", "gclk";
>>> +             };
>>> +
>>> +             can0: can@f8000000 {
>>> +                     compatible = "bosch,m_can";
>>> +                     reg = <0xf8000000 0x100>, <0x300000 0x7800>;
>>> +                     reg-names = "m_can", "message_ram";
>>> +                     interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +                                  <68 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     interrupt-names = "int0", "int1";
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 29>, <&pmc PMC_TYPE_GCK 29>;
>>> +                     clock-names = "hclk", "cclk";
>>> +                     assigned-clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_GCK 29>;
>>> +                     assigned-clock-rates = <480000000>, <40000000>;
>>> +                     assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
>>> +                     bosch,mram-cfg = <0x3400 0 0 64 0 0 32 32>;
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             can1: can@f8004000 {
>>> +                     compatible = "bosch,m_can";
>>> +                     reg = <0xf8004000 0x100>, <0x300000 0xbc00>;
>>> +                     reg-names = "m_can", "message_ram";
>>> +                     interrupts = <30 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +                                  <69 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     interrupt-names = "int0", "int1";
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 30>, <&pmc PMC_TYPE_GCK 30>;
>>> +                     clock-names = "hclk", "cclk";
>>> +                     assigned-clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_GCK 30>;
>>> +                     assigned-clock-rates = <480000000>, <40000000>;
>>> +                     assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
>>> +                     bosch,mram-cfg = <0x7800 0 0 64 0 0 32 32>;
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             tcb: timer@f8008000 {
>>> +                     compatible = "microchip,sam9x7-tcb","atmel,sama5d2-tcb", "simple-mfd", "syscon";
>>> +                     reg = <0xf8008000 0x100>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <0>;
>>> +                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_GCK 17>, <&clk32k 0>;
>>> +                     clock-names = "t0_clk", "gclk", "slow_clk";
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             flx6: flexcom@f8010000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8010000 0x200>;
>>> +                     ranges = <0x0 0xf8010000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart6: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(12))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(13))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c6: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(12))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(13))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx7: flexcom@f8014000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8014000 0x200>;
>>> +                     ranges = <0x0 0xf8014000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart7: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(14))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(15))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c7: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(14))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(15))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx8: flexcom@f8018000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8018000 0x200>;
>>> +                     ranges = <0x0 0xf8018000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart8: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(16))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(17))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c8: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(16))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(17))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx0: flexcom@f801c000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf801c000 0x200>;
>>> +                     ranges = <0x0 0xf801c000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart0: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(0))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(1))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     spi0: spi@400 {
>>> +                             compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
>>> +                             reg = <0x400 0x200>;
>>> +                             interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>> +                             clock-names = "spi_clk";
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(0))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(1))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c0: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(0))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(1))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx1: flexcom@f8020000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8020000 0x200>;
>>> +                     ranges = <0x0 0xf8020000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart1: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(2))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(3))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     spi1: spi@400 {
>>> +                             compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
>>> +                             reg = <0x400 0x200>;
>>> +                             interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>>> +                             clock-names = "spi_clk";
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(2))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(3))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c1: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(2))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(3))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx2: flexcom@f8024000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8024000 0x200>;
>>> +                     ranges = <0x0 0xf8024000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart2: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(4))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(5))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     spi2: spi@400 {
>>> +                             compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
>>> +                             reg = <0x400 0x200>;
>>> +                             interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>>> +                             clock-names = "spi_clk";
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(4))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(5))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c2: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(4))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(5))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx3: flexcom@f8028000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8028000 0x200>;
>>> +                     ranges = <0x0 0xf8028000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart3: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(6))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(7))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     spi3: spi@400 {
>>> +                             compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
>>> +                             reg = <0x400 0x200>;
>>> +                             interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>>> +                             clock-names = "spi_clk";
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(6))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(7))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c3: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(6))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(7))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             gmac: ethernet@f802c000 {
>>> +                     compatible = "microchip,sam9x7-gem", "microchip,sama7g5-gem";
>>> +                     reg = <0xf802c000 0x1000>;
>>> +                     interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 0 */
>>> +                                  <60 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 1 */
>>> +                                  <61 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 2 */
>>> +                                  <62 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 3 */
>>> +                                  <63 IRQ_TYPE_LEVEL_HIGH 3>,        /* Queue 4 */
>>> +                                  <64 IRQ_TYPE_LEVEL_HIGH 3>;        /* Queue 5 */
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_GCK 24>, <&pmc PMC_TYPE_GCK 67>;
>>> +                     clock-names = "hclk", "pclk", "tx_clk", "tsu_clk";
>>> +                     assigned-clocks = <&pmc PMC_TYPE_GCK 67>;
>> Is this needed?
> Sorry I missed to add this line under it. This is needed for the PTP 
> functionality.
> 
> assigned-clock-rates = <266666666>;
> 
> I can send another version if you want me to.
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             pwm0: pwm@f8034000 {
>>> +                     compatible = "microchip,sam9x7-pwm", "microchip,sam9x60-pwm";
>>> +                     reg = <0xf8034000 0x300>;
>>> +                     interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
>>> +                     #pwm-cells = <3>;
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             flx9: flexcom@f8040000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8040000 0x200>;
>>> +                     ranges = <0x0 0xf8040000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart9: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(18))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(19))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c9: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(18))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(19))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             flx10: flexcom@f8044000 {
>>> +                     compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
>>> +                     reg = <0xf8044000 0x200>;
>>> +                     ranges = <0x0 0xf8044000 0x800>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>>> +                     status = "disabled";
>>> +
>>> +                     uart10: serial@200 {
>>> +                             compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
>>> +                             reg = <0x200 0x200>;
>>> +                             interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>>> +                             clock-names = "usart";
>>> +                             atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(20))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(21))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,use-dma-rx;
>>> +                             atmel,use-dma-tx;
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +
>>> +                     i2c10: i2c@600 {
>>> +                             compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
>>> +                             reg = <0x600 0x200>;
>>> +                             interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                             clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>>> +                             dmas = <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(20))>,
>>> +                                    <&dma0
>>> +                                     (AT91_XDMAC_DT_MEM_IF(0) |
>>> +                                      AT91_XDMAC_DT_PER_IF(1) |
>>> +                                      AT91_XDMAC_DT_PERID(21))>;
>>> +                             dma-names = "tx", "rx";
>>> +                             atmel,fifo-size = <16>;
>>> +                             status = "disabled";
>>> +                     };
>>> +             };
>>> +
>>> +             sfr: sfr@f8050000 {
>>> +                     compatible = "microchip,sam9x7-sfr", "microchip,sam9x60-sfr", "syscon";
>>> +                     reg = <0xf8050000 0x100>;
>>> +             };
>>> +
>>> +             matrix: matrix@ffffde00 {
>>> +                     compatible = "microchip,sam9x7-matrix", "atmel,at91sam9x5-matrix", "syscon";
>>> +                     reg = <0xffffde00 0x200>;
>>> +             };
>>> +
>>> +             pmecc: ecc-engine@ffffe000 {
>>> +                     compatible = "microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc";
>>> +                     reg = <0xffffe000 0x300>, <0xffffe600 0x100>;
>>> +             };
>>> +
>>> +             mpddrc: mpddrc@ffffe800 {
>>> +                     compatible = "microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc";
>>> +                     reg = <0xffffe800 0x200>;
>>> +                     clocks = <&pmc PMC_TYPE_SYSTEM 2>, <&pmc PMC_TYPE_CORE PMC_MCK>;
>>> +                     clock-names = "ddrck", "mpddr";
>>> +             };
>>> +
>>> +             smc: smc@ffffea00 {
>>> +                     compatible = "microchip,sam9x7-smc", "atmel,at91sam9260-smc", "syscon";
>>> +                     reg = <0xffffea00 0x100>;
>>> +             };
>>> +
>>> +             aic: interrupt-controller@fffff100 {
>>> +                     compatible = "microchip,sam9x7-aic", "microchip,sam9x60-aic";
>>> +                     reg = <0xfffff100 0x100>;
>>> +                     #interrupt-cells = <3>;
>>> +                     interrupt-controller;
>>> +                     atmel,external-irqs = <31>;
>>> +                     microchip,nr-irqs = <70>;
>> Ah, this needs to be clarified before applying.
> Can you discard the property and apply the rest (if this version can be 
> applied)? 

I think it's not booting anyway w/o microchip,nr-irqs. Am I wrong?

> I can resolve the irq number related issue in a separate 
> series. Maybe fix the compatibles if required.

I prefer to have the driver ready before applying dts.

Thank you,
Claudiu Beznea

