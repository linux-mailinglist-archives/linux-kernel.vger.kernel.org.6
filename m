Return-Path: <linux-kernel+bounces-304580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B12962214
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B51F248F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FF315B0E8;
	Wed, 28 Aug 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6kgi0Rt"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977815B0F8;
	Wed, 28 Aug 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832830; cv=none; b=XVlnLEcSPMzssXgOXM17401Y2mQPWqAa5sqWAbUddHAmPaZjvI/Y4/GOwn/KckroRpAdgvdqSWa2ptkpK40gqIEAlL9XMjOo8HcB4ZJ82/0B5QYprS+FrmqjO288YkvFacaZuaiMJzhycM14JJpgIydnaEcta11kaMEB+Lb11f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832830; c=relaxed/simple;
	bh=2sxTen+hqWD9md4i6/YSDCChiC3x9Q7bIP07H37D5HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7nyk8rmvK6InrvgCM7rj+TIbFw25dP9+zYZAxqL/wdNXxi7U3FgNDVCEGvJI+9TK7ZuvJ/CTPNRA/lBZGcPN1Spuv8084fFgmYVh1zGLKKFF0ZcF8q/lXIU5W8PwpC8iTZU/QxizuZnr8sl7M4SCaRFj1E5CSQmu8bH8ZCIOZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6kgi0Rt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso273325b3a.0;
        Wed, 28 Aug 2024 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724832828; x=1725437628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEeuJ6OEQj6tArNvQ3MuOMDLK/qII+FALymrAkia2Aw=;
        b=d6kgi0RtVQ7Ag14fEX0XUvm5V/QRsxoykxAB2DGucMjHBr2QRxqsQzzdlpWrA9KF21
         VnEAISCI1xYRwUplhRN2VizH8PhXxLHgAv8dWsP1vjopYz9sb1QdpimyqGAhSGi9MjxK
         wDyCwyaxk/AEYQPwPyNJxBfXGhaKDY1/Et9Xuk6IQWxvvc2po8rE37/oXQ86ohuMaPZ+
         i1V7CrxIL6KuHnHjpY8O5M6aH/QaS/hpomvYI/o3QSGsi41r9PV9SJ4sv5JFfkIyFQP5
         5RJfQhAPEQ04HxAIkrvZmOiPtjo6ZtQJlwByeZTaTgXfBzi72XlbwVEWT3vd8l/rHe0c
         BEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724832828; x=1725437628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEeuJ6OEQj6tArNvQ3MuOMDLK/qII+FALymrAkia2Aw=;
        b=VRZH+OBwraGnx5Oo2mlqK5eZNTwQs/zg11TwIuixo5XgxmENrXxBEufaXMX0ZpCU+c
         CCJJV0QLqTTR3Y3X2PGPO47InWfhAkfQRfVFxHMCibwTiLLRls0lI+mUYFYJBSmSmg9D
         6GzH4xvMNTAYQgl03SigJsO8Dw21qZRw0FlOVZYpDwvyUK5WN20leTPBfEivqs3zeFBX
         ikhKeH0i0nxDzwmxC1yYaDYZf9BsreT2hzCmlUECvv5rgeQBrP7EmRjSr/d3mTKLUxrv
         qx6pW4E+8fNDEK5r1gerGGjsH+x8zKrWILQNay5HpLvNWYFhcETPBW9BwlQ5kM01Kxa/
         ZlhA==
X-Forwarded-Encrypted: i=1; AJvYcCXYo87MOiL6WL1fQ+DOk+Jk62X00Zgl/ExYKe0AhBX7m4RHbStIa2xv98JpN3D0qLWYjgsKkJGu9z07X6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2V1Rqu6Q5muJJ0deQAp9Mz43ZO/iAQ1azPIHoWUGG2GKVVVSG
	I3WJalvK/xaK6DnJqNBV67+eC4Q0WcbiriezF9wlFbcCbkw7jfDTFnBKBhz1
X-Google-Smtp-Source: AGHT+IFzeLbkxJqoDcVup/+Yq5NuZ87lSZ1xmGqjPADirUwgzOQ2oAhBgnGc7o6r9zLTS4dgJIKtAg==
X-Received: by 2002:a05:6a21:7783:b0:1c3:3d23:c325 with SMTP id adf61e73a8af0-1ccd1b54bdbmr1797433637.24.1724832827990;
        Wed, 28 Aug 2024 01:13:47 -0700 (PDT)
Received: from [0.0.0.0] (ec2-54-193-105-225.us-west-1.compute.amazonaws.com. [54.193.105.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ecf9sm9641427b3a.20.2024.08.28.01.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 01:13:47 -0700 (PDT)
Message-ID: <1a689627-851b-4929-aaf8-3dcddb57af6b@gmail.com>
Date: Wed, 28 Aug 2024 01:14:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] clk: sifive: prci: Add release_reset hooks for
 gemgxlpll/cltxpll
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Pragnesh.patel@sifive.com,
 aou@eecs.berkeley.edu, erik.danie@sifive.com, hes@sifive.com,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 sboyd@kernel.org, schwab@linux-m68k.org, zong.li@sifive.com
References: <cover.1724827635.git.ganboing@gmail.com>
 <e47b943c0f685cd028ebd477e97e1706f184a7b6.1724827635.git.ganboing@gmail.com>
 <20240828-duplex-skillful-752582090412@wendy>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20240828-duplex-skillful-752582090412@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Conor,

Thanks for replying so quickly. See inline.

On 8/28/24 00:58, Conor Dooley wrote:
> On Tue, Aug 27, 2024 at 11:55:20PM -0700, Bo Gan wrote:
>> This patch adds the release_reset hook interface to __prci_wrpll_data.
>> During clock enablement, the function (if present) will be called after PLL
>> registers are configured. It aligns the logic to the driver in u-boot. When
>> there's a previous bootloader stage, such as u-boot, it usually enables the
>> gemgxlpll clock when trying to PXE/network boot. The kernel boots fine, but
>> we should not depend on it being our previous stage, and the logic within:
>>
>>   a. We (linux) can get directly invoked by firmware (OpenSBI).
>>   b. U-boot doesn't necessarily have to initialize ethernet and enable the
>>      clock (when not enabled in CONFIG).
>>
>> When the kernel is the first to initialize gemgxlpll, it must also release
>> the corresponding reset. Otherwise the chip will just hang during macb
>> initialization, and even external JTAG debugger will lose control over the
>> risc-v debug module. (Observed with my Sifive Unmatched Rev.B board)
>>
>> The patch took the dt-bindings and logics directly from u-boot with some
>> additional modifications:
>>   - Use __prci_writel after __prci_readl to have barrier semantic. U-boot
>>     has the strong version of readl/writel, but linux has the relaxed ones.
>>   - Use pd->reset.rcdev.ops to access the reset regs.
>>   - Split reset bindings for FU540/FU740 and use them directly, instead of
>>     looking it up through reset-names.
> 
> The macb driver already supports using a reset at boot time (see zynq and
> mpfs) if hooked up in the devicetree, why doesn't that work for you in
> this situation?
> 
> Thanks,
> Conor.
> 

That a good idea. I never tried it. It's probably a cleaner solution, and I'll
try it some later time. I used the same logic in u-boot partially because the
way how sifive people coded this up. Specifically, PROCMONCFG is set between
the releases of 2 resets. I assume there's some dependency between those regs.
If reset is triggered from the macb driver side, there's really no proper way
to set PROCMONCFG. Also from the FU740 manual, I can't find any mentioning
about PROCMONCFG. If it's not needed, surely it's better to just let macb do
the resetting. Perhaps I should wait for Sifive folks to fill in the gap.

Thanks!
Bo

<Removed Yash Shah and Pragnesh Patel. Looks like they left Sifive>

>>
>> Signed-off-by: Bo Gan <ganboing@gmail.com>
>> ---
>>   drivers/clk/sifive/fu540-prci.h  | 16 ++++++++++++++++
>>   drivers/clk/sifive/fu740-prci.h  | 31 +++++++++++++++++++++++++++++++
>>   drivers/clk/sifive/sifive-prci.c | 23 +++++++++++++++++++++++
>>   drivers/clk/sifive/sifive-prci.h |  8 ++++++++
>>   4 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
>> index e0173324f3c5..9d2ca18f47a4 100644
>> --- a/drivers/clk/sifive/fu540-prci.h
>> +++ b/drivers/clk/sifive/fu540-prci.h
>> @@ -23,9 +23,24 @@
>>   #include <linux/module.h>
>>   
>>   #include <dt-bindings/clock/sifive-fu540-prci.h>
>> +#include <dt-bindings/reset/sifive-fu540-prci.h>
>>   
>>   #include "sifive-prci.h"
>>   
>> +/**
>> + * sifive_fu540_prci_ethernet_release_reset() - Release ethernet reset
>> + * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mux reg
>> + *
>> + */
>> +static void sifive_fu540_prci_ethernet_release_reset(struct __prci_data *pd)
>> +{
>> +	/* Release GEMGXL reset */
>> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU540_PRCI_RST_GEMGXL_N);
>> +
>> +	/* Procmon => core clock */
>> +	sifive_prci_set_procmoncfg(pd, PRCI_PROCMONCFG_CORE_CLOCK_MASK);
>> +}
>> +
>>   /* PRCI integration data for each WRPLL instance */
>>   
>>   static struct __prci_wrpll_data sifive_fu540_prci_corepll_data = {
>> @@ -43,6 +58,7 @@ static struct __prci_wrpll_data sifive_fu540_prci_ddrpll_data = {
>>   static struct __prci_wrpll_data sifive_fu540_prci_gemgxlpll_data = {
>>   	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
>>   	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
>> +	.release_reset = sifive_fu540_prci_ethernet_release_reset,
>>   };
>>   
>>   /* Linux clock framework integration */
>> diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
>> index f31cd30fc395..dd0f54277a99 100644
>> --- a/drivers/clk/sifive/fu740-prci.h
>> +++ b/drivers/clk/sifive/fu740-prci.h
>> @@ -10,9 +10,38 @@
>>   #include <linux/module.h>
>>   
>>   #include <dt-bindings/clock/sifive-fu740-prci.h>
>> +#include <dt-bindings/reset/sifive-fu740-prci.h>
>>   
>>   #include "sifive-prci.h"
>>   
>> +/**
>> + * sifive_fu740_prci_ethernet_release_reset() - Release ethernet reset
>> + * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mux reg
>> + *
>> + */
>> +static void sifive_fu740_prci_ethernet_release_reset(struct __prci_data *pd)
>> +{
>> +	/* Release GEMGXL reset */
>> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_GEMGXL_N);
>> +
>> +	/* Procmon => core clock */
>> +	sifive_prci_set_procmoncfg(pd, PRCI_PROCMONCFG_CORE_CLOCK_MASK);
>> +
>> +	/* Release Chiplink reset */
>> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_CLTX_N);
>> +}
>> +
>> +/**
>> + * sifive_fu740_prci_cltx_release_reset() - Release cltx reset
>> + * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mux reg
>> + *
>> + */
>> +static void sifive_fu740_prci_cltx_release_reset(struct __prci_data *pd)
>> +{
>> +	/* Release CLTX reset */
>> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_CLTX_N);
>> +}
>> +
>>   /* PRCI integration data for each WRPLL instance */
>>   
>>   static struct __prci_wrpll_data sifive_fu740_prci_corepll_data = {
>> @@ -30,6 +59,7 @@ static struct __prci_wrpll_data sifive_fu740_prci_ddrpll_data = {
>>   static struct __prci_wrpll_data sifive_fu740_prci_gemgxlpll_data = {
>>   	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
>>   	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
>> +	.release_reset = sifive_fu740_prci_ethernet_release_reset,
>>   };
>>   
>>   static struct __prci_wrpll_data sifive_fu740_prci_dvfscorepll_data = {
>> @@ -49,6 +79,7 @@ static struct __prci_wrpll_data sifive_fu740_prci_hfpclkpll_data = {
>>   static struct __prci_wrpll_data sifive_fu740_prci_cltxpll_data = {
>>   	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
>>   	.cfg1_offs = PRCI_CLTXPLLCFG1_OFFSET,
>> +	.release_reset = sifive_fu740_prci_cltx_release_reset,
>>   };
>>   
>>   /* Linux clock framework integration */
>> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
>> index caba0400f8a2..ae8055a84466 100644
>> --- a/drivers/clk/sifive/sifive-prci.c
>> +++ b/drivers/clk/sifive/sifive-prci.c
>> @@ -249,6 +249,9 @@ int sifive_prci_clock_enable(struct clk_hw *hw)
>>   	if (pwd->disable_bypass)
>>   		pwd->disable_bypass(pd);
>>   
>> +	if (pwd->release_reset)
>> +		pwd->release_reset(pd);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -448,6 +451,26 @@ void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd)
>>   	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
>>   }
>>   
>> +/*
>> + * PROCMONCFG
>> + */
>> +
>> +/**
>> + * sifive_prci_set_procmoncfg() - set PROCMONCFG
>> + * @pd: struct __prci_data * PRCI context
>> + * @val: u32 value to write to PROCMONCFG register
>> + *
>> + * Set the PROCMONCFG register to @val
>> + *
>> + * Context: Any context.  Caller must prevent concurrent changes to the
>> + *          PROCMONCFG_OFFSET register.
>> + */
>> +void sifive_prci_set_procmoncfg(struct __prci_data *pd, u32 val)
>> +{
>> +	__prci_writel(val, PRCI_PROCMONCFG_OFFSET, pd);
>> +	__prci_readl(pd, PRCI_PROCMONCFG_OFFSET);	/* barrier */
>> +}
>> +
>>   /* PCIE AUX clock APIs for enable, disable. */
>>   int sifive_prci_pcie_aux_clock_is_enabled(struct clk_hw *hw)
>>   {
>> diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
>> index 91658a88af4e..825a0aef9fd5 100644
>> --- a/drivers/clk/sifive/sifive-prci.h
>> +++ b/drivers/clk/sifive/sifive-prci.h
>> @@ -210,6 +210,9 @@
>>   
>>   /* PROCMONCFG */
>>   #define PRCI_PROCMONCFG_OFFSET			0xf0
>> +#define PRCI_PROCMONCFG_CORE_CLOCK_SHIFT	24
>> +#define PRCI_PROCMONCFG_CORE_CLOCK_MASK					\
>> +		(0x1 << PRCI_PROCMONCFG_CORE_CLOCK_SHIFT)
>>   
>>   /*
>>    * Private structures
>> @@ -235,6 +238,7 @@ struct __prci_data {
>>    * @disable_bypass: fn ptr to code to not bypass the WRPLL (or NULL)
>>    * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base address
>>    * @cfg1_offs: WRPLL CFG1 register offset (in bytes) from the PRCI base address
>> + * @release_reset: fn ptr to code to release clock reset
>>    *
>>    * @enable_bypass and @disable_bypass are used for WRPLL instances
>>    * that contain a separate external glitchless clock mux downstream
>> @@ -246,6 +250,7 @@ struct __prci_wrpll_data {
>>   	void (*disable_bypass)(struct __prci_data *pd);
>>   	u8 cfg0_offs;
>>   	u8 cfg1_offs;
>> +	void (*release_reset)(struct __prci_data *pd);
>>   };
>>   
>>   /**
>> @@ -290,6 +295,9 @@ void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd);
>>   void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd);
>>   void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd);
>>   
>> +/* PROCMONCFG */
>> +void sifive_prci_set_procmoncfg(struct __prci_data *pd, u32 val);
>> +
>>   /* Linux clock framework integration */
>>   long sifive_prci_wrpll_round_rate(struct clk_hw *hw, unsigned long rate,
>>   				  unsigned long *parent_rate);
>> -- 
>> 2.34.1
>>

