Return-Path: <linux-kernel+bounces-572857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B573A6CF76
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED91188921A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEE7134AB;
	Sun, 23 Mar 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="iJdN6KkE"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F033B2A0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742736224; cv=none; b=lItGuLmFN5wCNL20nUTJHrhBtamGgQjDvAqCYTN3/w/K+tkkD3OjD27qbOkdIID/J/gTWDNwzQDTNhf8JA+h99beEDmdW5h4jmQKqepBiA9n4DiHywZI9gIlR1YoHT5NVwQK+H5vHwgJNISGiS+ay6199o3iaoIVYLQNQCwoX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742736224; c=relaxed/simple;
	bh=8m4ki5WTnTOqAS5pWNSqJZYFt1pRtJBBaNdNuRgGqXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuVmGZx4H7LVbj/SQ7kSO8qh/eL23Ky6a6qGPV7SAm5EdSI4zUcYQj62NDAdkBoEwI3XCM02syJjxGtyrA30QI8E5dBmqO3+cvhQ2EsCHNiHWWDNPrDWfLwQyjaFpliwc6aQVdOLMKF91rHt02DT0atDwrpAGJTGIXTfJuMMvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=iJdN6KkE; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso116471439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742736221; x=1743341021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rjwFsPUVvvPhnWO0yZbKmPZex9tHV8eOTprS6xHwcQ=;
        b=iJdN6KkEoO5d6nCwNnG8fjOVK+pA5vdpz/EQ9eFEbYOpTL1Xv4iMBif+VFjRgoEeBs
         Z+W45wdktyQnCj6zGNtK8Fm0x3D4WGqp6eVMPGu97Q+Lds4yC8rQEj0AxovYJ7HPT+Kb
         vsWAThvd39hRKJK9X+kkjcD7KC0GC1R/LsDzncDmj5qPa5jf4T8ZaLcfR1lEamMewTGF
         i+eogd+0NUM4VCcmfLPOeLqgTceV3dJwGV+r3f1WNqBTccFILEwSa+58S4E4Q9amWAGC
         5WjakV0LIQEVlqHjhgf+5x5Na5ZudN3Iz0vMBVFyNHkbMc87DfYjEVXtdxTkY8tNFupo
         VZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742736221; x=1743341021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rjwFsPUVvvPhnWO0yZbKmPZex9tHV8eOTprS6xHwcQ=;
        b=Z6O+RnmC2BXyRdzDebZJgWG1jUarfARquG+ICR8gnz30Q8rGM3HxnCMj2T+SP0uQA+
         BGSC06hCB5zvr5AhopyCk622fyrwVtFqlsUhIIw6PXESKmKFbMwH5QlXsQxb4/TI5Wlm
         dUojjJJRT/XPpfFcTikFM8TwspjoIt+st202L40Twji2h1cRYn6/sH90xC0CLuvQ8kpt
         lJSGi+SSFkRrRj2y9dG9jRgcE1QcmI+FCxmYKPSYBEaTTLgRkJMzM1fZwQ7UqRPhL1gk
         eWuHLxmxYvwP47yE6Z3TG5hFhk/up72Uqq3QkARjGTExkm/PMzHDX6Nv6UNv5VX+fOcG
         EbhA==
X-Forwarded-Encrypted: i=1; AJvYcCWtWK2HOm2WDBAGu+Cy7vwVZIMnKI5ddeZleB5VOHo+bVNNIBJwO2ziAgThU0HDC6fj8qqGG0phho5reFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuG8bt4Oqe8HG3haPfIaY9n/nwP1Iet33bqFXJGgE6rOALrd76
	2sAKr9BOW/5dnsSjela0hFF4xrSnyM9V+2RdQRL7OZ24p08P9w7Z0Z0OkQh8ifo=
X-Gm-Gg: ASbGnctlmWHRjAWiiGRPKSjsyn6QtOpRrKHbp1p4KBeLTRjq6sq42MVpb/nWGb11wiI
	RGnxrDXSUvrpIKraEJC6qrPjwmoYAW/zHyRjbg/ORk48aADFRPm/aD4ywZdjHiMelwgMRrUtif6
	VfLH85e1RGM3vAjVgtufiw21gRvzVZ2K11M6cx/FujdSKpLMzgl8dQArqzh3P6hwhEYzegrkTSj
	aoA1H06am8RgZ/u3X3kPTKifYatRXqNTe3qO9IdIKh0KavNC69j+WVU/3zo4dag/jpE9xIrGYFv
	ni61TTFqz9CYc073U0n25UJ+tKgccMj2z08VCL1VRn/Vp+cahPm+8MufzQkH+ucyhum4T5D3v6O
	Vq8rcIH1p0cEvMxRUaw==
X-Google-Smtp-Source: AGHT+IF7Fd96mUgZBjBUyzdPCTDqsovLEsSmo2AzCv+iLTRjoA03l+8HJEkqodCvbMpbBAiH42tMqg==
X-Received: by 2002:a05:6602:3a0f:b0:85b:5869:b66 with SMTP id ca18e2360f4ac-85e2ca18965mr965437839f.1.1742736220910;
        Sun, 23 Mar 2025 06:23:40 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc13d74sm125798039f.11.2025.03.23.06.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 06:23:40 -0700 (PDT)
Message-ID: <ee9fb4b7-7829-4eec-815c-1e269d6abc38@riscstar.com>
Date: Sun, 23 Mar 2025 08:23:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 4/7] clk: spacemit: define existing syscon resets
To: Yixun Lan <dlan@gentoo.org>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heylenay@4d2.org,
 guodong@riscstar.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, spacemit@lists.linux.dev, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-5-elder@riscstar.com> <20250322162909-GYA15267@gentoo>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250322162909-GYA15267@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/25 11:29 AM, Yixun Lan wrote:
> On 10:18 Fri 21 Mar     , Alex Elder wrote:
>> Define reset controls associated with the MPMU, APBC, and APMU
>> SpacemiT K1 CCUs.  These already have clocks associated with them.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/clk/spacemit/ccu-k1.c | 132 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 132 insertions(+)
>>
>> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
>> index 6d879411c6c05..be8abd27753cb 100644
>> --- a/drivers/clk/spacemit/ccu-k1.c
>> +++ b/drivers/clk/spacemit/ccu-k1.c
> ..
>> +static const struct ccu_reset_data apmu_reset_data[] = {
>> +	[RST_CCIC_4X]	= RST_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_CCIC1_PHY] = RST_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(2)),
>> +	[RST_SDH_AXI]	= RST_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(0)),
>> +	[RST_SDH0]	= RST_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_SDH1]	= RST_DATA(APMU_SDH1_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_SDH2]	= RST_DATA(APMU_SDH2_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_USBP1_AXI] = RST_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(4)),
>> +	[RST_USB_AXI]	= RST_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(0)),
> ..
>> +	[RST_USB3_0]	= RST_DATA(APMU_USB_CLK_RES_CTRL,	0,
>> +				      BIT(9)|BIT(10)|BIT(11)),
> 100 column if possible, also add one space between "BIT(9) | BIT(10) .."
> continuous bits can just use GENMASK for short?

You'll notice that every place that has multiple bits in the mask
also have a line break.  I kind of liked that as a way to highlight
that fact (i.e., it goes beyond my preference for 80 columns).

I will definitely add spaces, that was a mistake not to.

I will not define this with GENMASK().  In this case each bit
represents a single reset, and so each one is significant on
its own.  It is *not* a mask of contiguous bits, it's a set
of bits that happen to have consecutive positions.

					-Alex

> but may result slightly unreadable, anyway, either way is fine by me
> 
>> +	[RST_QSPI]	= RST_DATA(APMU_QSPI_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_QSPI_BUS] = RST_DATA(APMU_QSPI_CLK_RES_CTRL,	0, BIT(0)),
>> +	[RST_DMA]	= RST_DATA(APMU_DMA_CLK_RES_CTRL,	0, BIT(0)),
>> +	[RST_AES]	= RST_DATA(APMU_AES_CLK_RES_CTRL,	0, BIT(4)),
>> +	[RST_VPU]	= RST_DATA(APMU_VPU_CLK_RES_CTRL,	0, BIT(0)),
>> +	[RST_GPU]	= RST_DATA(APMU_GPU_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_EMMC]	= RST_DATA(APMU_PMUA_EM_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_EMMC_X]	= RST_DATA(APMU_PMUA_EM_CLK_RES_CTRL,	0, BIT(0)),
>> +	[RST_AUDIO]	= RST_DATA(APMU_AUDIO_CLK_RES_CTRL,	0,
>> +				   BIT(0) | BIT(2) | BIT(3)),
>> +	[RST_HDMI]	= RST_DATA(APMU_HDMI_CLK_RES_CTRL,	0, BIT(9)),
>> +	[RST_PCIE0]	= RST_DATA(APMU_PCIE_CLK_RES_CTRL_0,	BIT(8),
>> +				   BIT(3) | BIT(4) | BIT(5)),
>> +	[RST_PCIE1]	= RST_DATA(APMU_PCIE_CLK_RES_CTRL_1,	BIT(8),
>> +				   BIT(3) | BIT(4) | BIT(5)),
>> +	[RST_PCIE2]	= RST_DATA(APMU_PCIE_CLK_RES_CTRL_2,	BIT(8),
>> +				   BIT(3) | BIT(4) | BIT(5)),
>> +	[RST_EMAC0]	= RST_DATA(APMU_EMAC0_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_EMAC1]	= RST_DATA(APMU_EMAC1_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_JPG]	= RST_DATA(APMU_JPG_CLK_RES_CTRL,	0, BIT(0)),
>> +	[RST_CCIC2PHY]	= RST_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL,	0, BIT(2)),
>> +	[RST_CCIC3PHY]	= RST_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL,	0, BIT(29)),
>> +	[RST_CSI]	= RST_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL,	0, BIT(1)),
>> +	[RST_ISP]	= RST_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(0)),
>> +	[RST_ISP_CPP]	= RST_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(27)),
>> +	[RST_ISP_BUS]	= RST_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(3)),
>> +	[RST_ISP_CI]	= RST_DATA(APMU_ISP_CLK_RES_CTRL,	0, BIT(16)),
>> +	[RST_DPU_MCLK]	= RST_DATA(APMU_LCD_CLK_RES_CTRL2,	0, BIT(9)),
>> +	[RST_DPU_ESC]	= RST_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(3)),
>> +	[RST_DPU_HCLK]	= RST_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(4)),
>> +	[RST_DPU_SPIBUS] = RST_DATA(APMU_LCD_SPI_CLK_RES_CTRL,	0, BIT(4)),
>> +	[RST_DPU_SPI_HBUS] = RST_DATA(APMU_LCD_SPI_CLK_RES_CTRL, 0, BIT(2)),
>> +	[RST_V2D]	= RST_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(27)),
>> +	[RST_MIPI]	= RST_DATA(APMU_LCD_CLK_RES_CTRL1,	0, BIT(15)),
>> +	[RST_MC]	= RST_DATA(APMU_PMUA_MC_CTRL,		0, BIT(0)),
>> +};
>> +
>> +static const struct ccu_reset_controller_data apmu_reset_controller_data = {
>> +	.count		= ARRAY_SIZE(apmu_reset_data),
>> +	.data		= apmu_reset_data,
>> +};
>> +
>>   static const struct k1_ccu_data k1_ccu_apmu_data = {
>>   	.clk		= k1_ccu_apmu_clks,
>> +	.rst_data	= &apmu_reset_controller_data,
>>   };
>>   
>>   static struct ccu_reset_controller *
>> -- 
>> 2.43.0
>>
> 


