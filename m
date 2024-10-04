Return-Path: <linux-kernel+bounces-349899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D754398FCED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1131F21E63
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445306A33C;
	Fri,  4 Oct 2024 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQSntWEA"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706046F2F8;
	Fri,  4 Oct 2024 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018829; cv=none; b=NmDjki/OrbdP8qMYnf1aIy14xQSMNBCQEyFgY+CfbC1QpEnjxWeXAvRV8itzpXyCiz/cSiSPDd3eiOUJsR65jtkRuq3iiN2Qu2dB260Iizy8XaROSpLkQ34ZCXZfEwXSB79MqtnSaNBf3OOsqOp6nXKyX2etF5EVwGzQ5MgALAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018829; c=relaxed/simple;
	bh=qjQgVcsy4NwE1bCpauOykpVxN0Wl1Rru9qtcC4rwcDo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n2lDzmFy3EylED5TxAx3tN4USb1FKDwPK+tuWCJ74tMGT9Yh3B4z+UPNvizRl/XD9zUGqGos1Ysr7VC2dPioWbfNyyQJ2H7eoLkxLD6Kn5+zBRnFE8opNK6Z2q1zPTCaZKu8ki+j6esu/ti036XtZWpJzyn2MHf7ryzAGOa3lMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQSntWEA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e1bfa9ddb3so1206823a91.0;
        Thu, 03 Oct 2024 22:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728018827; x=1728623627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vK/IWld7dqP/kgyhCfCo0J0orcE4Di+Uo41suj8vGiw=;
        b=ZQSntWEAMTHwR8UvfWZ+UynVB9/+mqNRS0NaJKbOWfmmWYOhtm8pzYf7vBlOTobxPh
         4BM3Vuv4VsFdBb2514z52RZFgKNeWhC4i184FSi86NWUzoE0QFeern5uuoIf8XrvpI5X
         50zwyYSt0eWMF3IZgVmTXhfPwoxOqOKHGdhSiEc17o4RGJw+3lvIcrIflFQ8D9ZXCwP2
         6N+XU5gKIwVsjiEoLh+yxscyZZ1rd6FmGgn0TPGnc+7uZAjRAnL0vTLHxisUm5Nr/3CB
         2WhV/zoTYkX5MHoqJFmxt4dfx+KrVAza8/XNk0iIS88dnHdxCjXum0NLIijVlpxsnmAG
         qTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728018827; x=1728623627;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK/IWld7dqP/kgyhCfCo0J0orcE4Di+Uo41suj8vGiw=;
        b=WcNW5kUpqt4PSfme2eePrMhKQwwaPtXLal+Idfk3oEPXFMA8HFYj2mpBGFFzhbumaT
         FzpjjhPMV7mWSftS/i2mktt9HNMCpexwm2bEsbcXt8qoiAq/UVGnJdXO3WmaFSig06bl
         Jqz7G22THJkfySBmXJimuul8TB7I+SKiMLpele0r8GJ08AGQckyYcmITjIksMGW5LGa3
         Z/9jxHdF4nMDQCWEv614cbSNwMeTnHaJxZKPFH2pUmH3+vKwcL7OmhGj3ybwck5OX+RR
         sT1IWcU7lFziUSUTIiqdAUIdy3b+k4zheSYkiJX9CF5KC5mciD9ZBV6a6+emSHAIVWPs
         9FRA==
X-Forwarded-Encrypted: i=1; AJvYcCVomaiRDxNtN7NsawWSHjm6frsxOXDMgqiIE6MNXNfAOBo0H9WkJiOuv6qBL7P5wu10joH9Dhi1LWwKgOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkprp86/SDKbPAO/mRFKzeeCYxES4M1nrSfjry+YG7rUSWh2z
	5A+nB0BKcI3hwMRkS2Xt8qbwdhjgWt4Ui6rr/Ih8Se5WfhJUVl5X
X-Google-Smtp-Source: AGHT+IGD+MHA+RPdnrDEpdj0jtBxmDanwP3eaB8ldtEsMA6NGjjAGkL0rbHq8ryZtaHFBVTTI4b7ZQ==
X-Received: by 2002:a17:90a:4bc6:b0:2d3:ca3f:7f2a with SMTP id 98e67ed59e1d1-2e1e62674damr1525156a91.22.1728018826220;
        Thu, 03 Oct 2024 22:13:46 -0700 (PDT)
Received: from [127.0.0.1] ([154.19.47.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c13eesm531560a91.11.2024.10.03.22.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 22:13:45 -0700 (PDT)
Message-ID: <d9036e26-0e08-4838-b57f-fde6f743a4d1@gmail.com>
Date: Fri, 4 Oct 2024 13:12:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Junhui Liu <liujh2818@gmail.com>
Subject: Re: [PATCH 2/2] reset: canaan: Add reset driver for Kendryte K230
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhui Liu <liujh2818@outlook.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
 <20240924-k230-reset-v1-2-d0cdc11989eb@outlook.com>
 <e0a8da323575ec46dff2df5f804513ea64f11ca8.camel@pengutronix.de>
Content-Language: en-US
In-Reply-To: <e0a8da323575ec46dff2df5f804513ea64f11ca8.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Philipp:
Thanks for your review!

On 2024/9/24 17:17, Philipp Zabel wrote:
> On Di, 2024-09-24 at 14:00 +0800, Junhui Liu wrote:
>> From: Junhui Liu<liujh2818@outlook.com>
>>
>> Add support for the resets on Canaan Kendryte K230 SoC.
>>
>> Signed-off-by: Junhui Liu<liujh2818@outlook.com>
>> ---
>>   drivers/reset/Kconfig      |   8 ++
>>   drivers/reset/Makefile     |   1 +
>>   drivers/reset/reset-k230.c | 321 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 330 insertions(+)
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 5484a65f66b95374e25bac31f539a2dd92ae007e..716c676e9b934dd3d2b1ee28f2c43ef38daf7dba 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -133,6 +133,14 @@ config RESET_K210
>>   	  Say Y if you want to control reset signals provided by this
>>   	  controller.
>>   
>> +config RESET_K230
>> +	bool "Reset controller driver for Canaan Kendryte K230 SoC"
>> +	depends on (ARCH_CANAAN || COMPILE_TEST) && OF
>> +	help
>> +	  Support for the Canaan Kendryte K230 RISC-V SoC reset controller.
>> +	  Say Y if you want to control reset signals provided by this
>> +	  controller.
>> +
>>   config RESET_LANTIQ
>>   	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
>>   	default SOC_TYPE_XWAY
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 4411a2a124d7de29808fcf36d0829393fc79af72..f02c35607ba88947e868d33ead70e9ec91a85636 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>>   obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) += reset-imx8mp-audiomix.o
>>   obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
>>   obj-$(CONFIG_RESET_K210) += reset-k210.o
>> +obj-$(CONFIG_RESET_K230) += reset-k230.o
>>   obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>>   obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>>   obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
>> diff --git a/drivers/reset/reset-k230.c b/drivers/reset/reset-k230.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..9c693e1cee35dd725bebb6916002f846e8b4003b
>> --- /dev/null
>> +++ b/drivers/reset/reset-k230.c
>> @@ -0,0 +1,321 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2016-2017 Linaro Ltd.
>> + * Copyright (C) 2022-2024 Canaan Bright Sight Co., Ltd
>> + * Copyright (C) 2024 Junhui Liu<liujh2818@outlook.com>
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/delay.h>
>> +#include <dt-bindings/reset/canaan,k230-rst.h>
>> +
>> +/**
>> + * enum k230_rst_type - K230 reset types
>> + * @RST_TYPE_CPU0: Reset type for CPU0
>> + *	Automatically clears, has write enable and done bit, active high
>> + * @RST_TYPE_CPU1: Reset type for CPU1
>> + *	Manually clears, has write enable and done bit, active high
>> + * @RST_TYPE_FLUSH: Reset type for CPU L2 cache flush
>> + *	Automatically clears, has write enable, no done bit, active high
>> + * @RST_TYPE_HW_DONE: Reset type for hardware auto clear
>> + *	Automatically clears, no write enable, has done bit, active high
>> + * @RST_TYPE_SW_DONE: Reset type for software manual clear
>> + *	Manually clears, no write enable and done bit,
>> + *	active high if ID is RST_SPI2AXI, otherwise active low
>> + */
>> +enum k230_rst_type {
>> +	RST_TYPE_CPU0 = 0,
>> +	RST_TYPE_CPU1,
>> +	RST_TYPE_FLUSH,
>> +	RST_TYPE_HW_DONE,
>> +	RST_TYPE_SW_DONE,
>> +};
>> +
>> +struct k230_rst_map {
>> +	u32			offset;
>> +	enum k230_rst_type	type;
>> +	u32			done;
>> +	u32			reset;
>> +};
>> +
>> +struct k230_rst {
>> +	struct reset_controller_dev	rcdev;
>> +	struct device			*dev;
>> +	void __iomem			*base;
>> +	spinlock_t			lock;
>> +};
>> +
>> +static const struct k230_rst_map k230_resets[] = {
>> +	[RST_CPU0]		= { 0x4,  RST_TYPE_CPU0,    BIT(12), BIT(0) },
>> +	[RST_CPU1]		= { 0xc,  RST_TYPE_CPU1,    BIT(12), BIT(0) },
>> +	[RST_CPU0_FLUSH]	= { 0x4,  RST_TYPE_FLUSH,   0,       BIT(4) },
>> +	[RST_CPU1_FLUSH]	= { 0xc,  RST_TYPE_FLUSH,   0,       BIT(4) },
>> +	[RST_AI]		= { 0x14, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_VPU]		= { 0x1c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_HS]		= { 0x2c, RST_TYPE_HW_DONE, BIT(4),  BIT(0) },
>> +	[RST_HS_AHB]		= { 0x2c, RST_TYPE_HW_DONE, BIT(5),  BIT(1) },
>> +	[RST_SDIO0]		= { 0x34, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
>> +	[RST_SDIO1]		= { 0x34, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
>> +	[RST_SDIO_AXI]		= { 0x34, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
>> +	[RST_USB0]		= { 0x3c, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
>> +	[RST_USB1]		= { 0x3c, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
>> +	[RST_USB0_AHB]		= { 0x3c, RST_TYPE_HW_DONE, BIT(30), BIT(0) },
>> +	[RST_USB1_AHB]		= { 0x3c, RST_TYPE_HW_DONE, BIT(31), BIT(1) },
>> +	[RST_SPI0]		= { 0x44, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
>> +	[RST_SPI1]		= { 0x44, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
>> +	[RST_SPI2]		= { 0x44, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
>> +	[RST_SEC]		= { 0x4c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_PDMA]		= { 0x54, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
>> +	[RST_SDMA]		= { 0x54, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
>> +	[RST_DECOMPRESS]	= { 0x5c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_SRAM]		= { 0x64, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
>> +	[RST_SHRM_AXIM]		= { 0x64, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
>> +	[RST_SHRM_AXIS]		= { 0x64, RST_TYPE_HW_DONE, BIT(31), BIT(3) },
>> +	[RST_NONAI2D]		= { 0x6c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_MCTL]		= { 0x74, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_ISP]		= { 0x80, RST_TYPE_HW_DONE, BIT(29), BIT(6) },
>> +	[RST_ISP_DW]		= { 0x80, RST_TYPE_HW_DONE, BIT(28), BIT(5) },
>> +	[RST_DPU]		= { 0x88, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_DISP]		= { 0x90, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_GPU]		= { 0x98, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_AUDIO]		= { 0xa4, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
>> +	[RST_TIMER0]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(0) },
>> +	[RST_TIMER1]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(1) },
>> +	[RST_TIMER2]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(2) },
>> +	[RST_TIMER3]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(3) },
>> +	[RST_TIMER4]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(4) },
>> +	[RST_TIMER5]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(5) },
>> +	[RST_TIMER_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(6) },
>> +	[RST_HDI]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(7) },
>> +	[RST_WDT0]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(12) },
>> +	[RST_WDT1]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(13) },
>> +	[RST_WDT0_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(14) },
>> +	[RST_WDT1_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(15) },
>> +	[RST_TS_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(16) },
>> +	[RST_MAILBOX]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(17) },
>> +	[RST_STC]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(18) },
>> +	[RST_PMU]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(19) },
>> +	[RST_LS_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(0) },
>> +	[RST_UART0]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(1) },
>> +	[RST_UART1]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(2) },
>> +	[RST_UART2]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(3) },
>> +	[RST_UART3]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(4) },
>> +	[RST_UART4]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(5) },
>> +	[RST_I2C0]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(6) },
>> +	[RST_I2C1]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(7) },
>> +	[RST_I2C2]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(8) },
>> +	[RST_I2C3]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(9) },
>> +	[RST_I2C4]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(10) },
>> +	[RST_JAMLINK0_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(11) },
>> +	[RST_JAMLINK1_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(12) },
>> +	[RST_JAMLINK2_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(13) },
>> +	[RST_JAMLINK3_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(14) },
>> +	[RST_CODEC_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(17) },
>> +	[RST_GPIO_DB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(18) },
>> +	[RST_GPIO_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(19) },
>> +	[RST_ADC]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(20) },
>> +	[RST_ADC_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(21) },
>> +	[RST_PWM_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(22) },
>> +	[RST_SHRM_APB]		= { 0x64, RST_TYPE_SW_DONE, 0,       BIT(1) },
>> +	[RST_CSI0]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(0) },
>> +	[RST_CSI1]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(1) },
>> +	[RST_CSI2]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(2) },
>> +	[RST_CSI_DPHY]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(3) },
>> +	[RST_ISP_AHB]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(4) },
>> +	[RST_M0]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(7) },
>> +	[RST_M1]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(8) },
>> +	[RST_M2]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(9) },
>> +	[RST_SPI2AXI]		= { 0xa8, RST_TYPE_SW_DONE, 0,       BIT(0) }
>> +};
>> +
>> +#define to_k230_rst(p) container_of((p), struct k230_rst, rcdev)
> Consider turning this into an inline function.
>
>> +static void k230_rst_clear_done(struct k230_rst *rstc, unsigned long id,
>> +				bool write_en)
>> +{
>> +	const struct k230_rst_map *rmap = &k230_resets[id];
>> +	unsigned long flags;
>> +	u32 reg;
>> +
>> +	spin_lock_irqsave(&rstc->lock, flags);
> You could use guard(spinlock_irqsave)(&rstc->lock) to save a few lines.

Thanks for letting me know about this method, I will try to add it.

>> +	reg = readl(rstc->base + rmap->offset);
>> +
>> +	/* write 1 to clear */
>> +	reg |= rmap->done;
>> +	if (write_en)
>> +		reg |= rmap->done << 16;
>> +
>> +	writel(reg, rstc->base + rmap->offset);
>> +
>> +	spin_unlock_irqrestore(&rstc->lock, flags);
>> +}
>> +
>> +static int k230_rst_wait_and_clear_done(struct k230_rst *rstc, unsigned long id,
>> +					bool write_en)
>> +{
>> +	const struct k230_rst_map *rmap = &k230_resets[id];
>> +	u32 reg;
>> +	int ret;
>> +
>> +	ret = readl_poll_timeout(rstc->base + rmap->offset, reg,
>> +				 reg & rmap->done, 10, 1000);
>> +	if (ret) {
>> +		dev_err(rstc->dev, "Wait for reset done timeout\n");
>> +		return ret;
>> +	}
>> +
>> +	k230_rst_clear_done(rstc, id, write_en);
>> +
>> +	return 0;
>> +}
>> +
>> +static void k230_rst_update(struct k230_rst *rstc, unsigned long id,
>> +			    bool assert, bool write_en, bool active_low)
>> +{
>> +	const struct k230_rst_map *rmap = &k230_resets[id];
>> +	unsigned long flags;
>> +	u32 reg;
>> +
>> +	spin_lock_irqsave(&rstc->lock, flags);
> Same as above, maybe use guard(spinlock_irqsave)(&rstc->lock).
>
>> +
>> +	reg = readl(rstc->base + rmap->offset);
>> +
>> +	if (assert ^ active_low)
>> +		reg |= rmap->reset;
>> +	else
>> +		reg &= ~rmap->reset;
>> +
>> +	if (write_en)
>> +		reg |= rmap->reset << 16;
>> +
>> +	writel(reg, rstc->base + rmap->offset);
>> +
>> +	spin_unlock_irqrestore(&rstc->lock, flags);
>> +}
>> +
>> +static int k230_rst_assert(struct reset_controller_dev *rcdev, unsigned long id)
>> +{
>> +	struct k230_rst *rstc = to_k230_rst(rcdev);
>> +	const struct k230_rst_map *rmap = &k230_resets[id];
>> +	int ret;
>> +
>> +	switch (rmap->type) {
>> +	case RST_TYPE_CPU0:
> I'd expect this and the other self-clearing resets to return -ENOTSUPP,
> as reset_control_assert() most likely won't return with the reset line
> still asserted.
>
>

Okay, I will move the self-clearing resets into k230_rst_reset(), and
let them return -ENOTSUPP in assert() and deassert().

>> +		k230_rst_clear_done(rstc, id, true);
>> +		k230_rst_update(rstc, id, true, true, false);
>> +		ret = k230_rst_wait_and_clear_done(rstc, id, true);
>> +		break;
> This should be implemented in k230_rst_reset().
>
>> +	case RST_TYPE_CPU1:
>> +	case RST_TYPE_FLUSH:
>> +		k230_rst_update(rstc, id, true, true, false);
>> +		break;
>> +	case RST_TYPE_HW_DONE:
>> +		k230_rst_clear_done(rstc, id, false);
>> +		k230_rst_update(rstc, id, true, false, false);
>> +		ret = k230_rst_wait_and_clear_done(rstc, id, false);
> Same for RST_TYPE_FLUSH and RST_TYPE_HW_DONE.
>
>> +		break;
>> +	case RST_TYPE_SW_DONE:
>> +		k230_rst_update(rstc, id, true, false,
>> +				id == RST_SPI2AXI ? false : true);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int k230_rst_deassert(struct reset_controller_dev *rcdev,
>> +			     unsigned long id)
>> +{
>> +	struct k230_rst *rstc = to_k230_rst(rcdev);
>> +	int ret;
> Here ret should be initialized to 0.
>
>> +
>> +	switch (k230_resets[id].type) {
>> +	case RST_TYPE_CPU0:
>> +		break;
>> +	case RST_TYPE_CPU1:
>> +		k230_rst_update(rstc, id, false, true, false);
>> +		ret = k230_rst_wait_and_clear_done(rstc, id, true);
> This looks odd, but maybe that's how the hardware works. To be sure,
> you are waiting for the done bit *after* manually deasserting the
> reset, on purpose?


Even though this is a manual clear reset, it also has the done bit to
indicate the completion of the reset process (in this case for the
deassert operation). If it's odd here, I will move it to k230_rst_reset().

>> +		break;
>> +	case RST_TYPE_FLUSH:
>> +	case RST_TYPE_HW_DONE:
>> +		break;
>> +	case RST_TYPE_SW_DONE:
>> +		k230_rst_update(rstc, id, false, false,
>> +				id == RST_SPI2AXI ? false : true);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
> Currently this returns an uninitialized value for the self-clearing
> resets (RST_TYPE_CPU0, RST_TYPE_FLUSH, and RST_TYPE_HW_DONE).
>
>> +}
>> +
>> +static int k230_rst_reset(struct reset_controller_dev *rcdev, unsigned long id)
>> +{
>> +	int ret;
>> +
>> +	ret = k230_rst_assert(rcdev, id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	udelay(10);
> Is this delay enough for all consumers?

Thanks for your reminder. I am still confirming this issue
with the vendor and I will update it in the next version.

> Is this delay needed for the resets that wait for the done bit after
> assertion (RST_TYPE_CPU0 and RST_TYPE_HW_DONE)?
>
I will remove the delay for self-clearing reset.

>> +
>> +	return k230_rst_deassert(rcdev, id);
>> +}
>> +
>> +static const struct reset_control_ops k230_rst_ops = {
>> +	.reset		= k230_rst_reset,
>> +	.assert		= k230_rst_assert,
>> +	.deassert	= k230_rst_deassert,
>> +};
>> +
>> +static int k230_rst_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct k230_rst *rstc;
>> +
>> +	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
>> +	if (!rstc)
>> +		return -ENOMEM;
>> +
>> +	rstc->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(rstc->base))
>> +		return PTR_ERR(rstc->base);
>> +
>> +	spin_lock_init(&rstc->lock);
>> +
>> +	rstc->dev		= dev;
>> +	rstc->rcdev.owner	= THIS_MODULE;
>> +	rstc->rcdev.ops		= &k230_rst_ops;
>> +	rstc->rcdev.nr_resets	= ARRAY_SIZE(k230_resets);
>> +	rstc->rcdev.of_node	= dev->of_node;
>> +
>> +	return devm_reset_controller_register(dev, &rstc->rcdev);
>> +}
>> +
>> +static const struct of_device_id k230_rst_match[] = {
>> +	{ .compatible = "canaan,k230-rst", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, k230_rst_match);
>> +
>> +static struct platform_driver k230_rst_driver = {
>> +	.probe = k230_rst_probe,
>> +	.driver = {
>> +		.name = "k230-rst",
>> +		.of_match_table = k230_rst_match,
>> +	}
>> +};
>> +module_platform_driver(k230_rst_driver);
>> +
>> +MODULE_AUTHOR("Junhui Liu<liujh2818@outlook.com>");
>> +MODULE_DESCRIPTION("Canaan K230 reset driver");
>> +MODULE_LICENSE("GPL v2");
> regards
> Philipp

BR,
Junhui


