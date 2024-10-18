Return-Path: <linux-kernel+bounces-370789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19399A321D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F801F23251
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940B71747;
	Fri, 18 Oct 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/dUjc6n"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7E5674D;
	Fri, 18 Oct 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215416; cv=none; b=KaHjcvlQfUBpU1hoSWucZDevUr8YEdYCw7j4yzBK4cgXSJnd4oNu8J3w/88pKWsdjT87LYYIyw9fsibjf0ed3ikimcNYmq496K+5OSr5F+/BR7P2WD8VaYmWqQ4j/r6KimJ//M5P3pu8hLBxmQlW+cs7SuCFPkG3Tw4WD8w0A5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215416; c=relaxed/simple;
	bh=0fuLe0ABsogbbSX7Gog7snbodCFjvfjN7pH6/YTi0yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrbi2oJ5jfdVm74zwhMLK5ta1R+rGvIk7msU5w7Oc5g824cPcYxNRedemwrDgEg5AIDzXzyhI05RwmTBYaQrKUdx2RfNAVhu0eFt+AozSu60nVztnSaALzq2ClvpKdK5ALBz1WdqRWhrkk9TpKzOYlu+sqNUX/s4eoVM90IxsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/dUjc6n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e31977c653so228008a91.0;
        Thu, 17 Oct 2024 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729215414; x=1729820214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pq+RtYnwTu+tV+EPidhczlNwvnckhnNKGaN3wMd6h20=;
        b=V/dUjc6nQKdVWtgcBmW5N9Qos0um/jQVVdBmmnH085HsBf4SiQAAk42hmuxKZUAlCE
         aUsO2P/qUxzLA3AfoC4EYAh300l81C/YhwZtMEFR7SRxTTYzDBEueAWXotuCTQEuwdM/
         E2jxrBW821RwHm4NWCL7zXfWC8HPWqpCvDIOB6vb4PMB6ZIFqnffpALxaP1jmoFrrkbI
         ilWyfQDCajBgLDVe+6l1a8bQdDxrBFHLNyb3xDGwT5BiC2yJB3/Em6tfvJA+aiFsCPa2
         YFRjFYu7kjWmckp+vF7hHHcbYW1/bcX0LxNQJi4jieg3lnuztdc+bteMwXXpfklxbFEW
         Q+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729215414; x=1729820214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq+RtYnwTu+tV+EPidhczlNwvnckhnNKGaN3wMd6h20=;
        b=XCUrifKayetWKP90VTfJTQjtdCcEKMLGkzVDSgXLsXMQBkYr153UL2cuf/VsO9cY8e
         RJ2xYBA7A17zJOtO6JVnmYN+DQgAXge+A+R/DpmDdPauI4Iy/kBDNjhhaYqhrRY4xKJf
         m48YVo5azesvuDxCA+7MAmNmWdVi8twLPTSPG7ZlFQnOvLlp3fY0TAk1EPOKEJCuD2cU
         Oioys4uemiJBKfv0l1mVlOHrzH+f5XXYj3V8YGgdCLL1m3c+KUNpVnv/P8acVa06aD3q
         BSgtpcRVm5oM6AfRUvPni83gpgsfdkfas6G55ZnMPBMJghN56N9x9TJXN7uruqLozvwI
         d/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUn6biaLF8WjBtGxWy0CJV8mboCfLruc5CzYliVKNTtthXWJ/p75pROKPebDMdXDyMdBqVMlNk6p+EC@vger.kernel.org, AJvYcCUpv8K1dy+r9jJfCb0ZBxd+XdVSlyLrAAsP1Bs49xVAufyluyC4NbbYjKv7umiZGAgzjSzm3LUQv8bxxwTh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QpfCsgk445+oqiDGF/QKS4KUPjzPV4+guxVQitEsJs4V9ZKK
	PX5L3VzUNkZiukWzgM+V9o9U7iyc8qDNyMQIMT1sgIGVce6IN4PTolXucw==
X-Google-Smtp-Source: AGHT+IFraYLP89MmMGaLWHqJFkXlo/amHQDE+XSWH3Hog92OGLzw5xKZ73BT2TktxfYdK1JdUmKnhg==
X-Received: by 2002:a17:90a:e607:b0:2e1:682b:361e with SMTP id 98e67ed59e1d1-2e5616eb630mr480804a91.4.1729215413581;
        Thu, 17 Oct 2024 18:36:53 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5612d0777sm425166a91.53.2024.10.17.18.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 18:36:53 -0700 (PDT)
Message-ID: <8f3bd853-55fc-4da5-8d68-eae5754f6933@gmail.com>
Date: Fri, 18 Oct 2024 09:36:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: rockchip-naneng-combo: Support rk3576
To: Vinod Koul <vkoul@kernel.org>
Cc: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com,
 Kever Yang <kever.yang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>
References: <20241016023533.12018-1-frawang.cn@gmail.com>
 <20241016023533.12018-2-frawang.cn@gmail.com> <ZxEgdHCQ3dTQeMRm@vaman>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <ZxEgdHCQ3dTQeMRm@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vinod,

On 2024/10/17 22:34, Vinod Koul wrote:
> On 16-10-24, 10:35, Frank Wang wrote:
>> From: Kever Yang <kever.yang@rock-chips.com>
>>
>> phy0: pcie, sata
>> phy1: pcie, sata, usb3
> Can this be more verbose to explain what is being added in the patch
> below?

Sure, I'll amend and send a new version.

>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>> Changelog:
>> v2:
>>   - using constants macro instead of magic values.
>>   - add more comments for PHY tuning operations.
>>
>> v1:
>>   - https://patchwork.kernel.org/project/linux-phy/patch/20241015013351.4884-2-frawang.cn@gmail.com/
>>
>>   .../rockchip/phy-rockchip-naneng-combphy.c    | 274 ++++++++++++++++++
>>   1 file changed, 274 insertions(+)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> index 0a9989e41237f..25aa8d1981abc 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> @@ -37,6 +37,10 @@
>>   #define PHYREG8				0x1C
>>   #define PHYREG8_SSC_EN			BIT(4)
>>   
>> +#define PHYREG10			0x24
>> +#define PHYREG10_SSC_PCM_MASK		GENMASK(3, 0)
>> +#define PHYREG10_SSC_PCM_3500PPM	7
>> +
>>   #define PHYREG11			0x28
>>   #define PHYREG11_SU_TRIM_0_7		0xF0
>>   
>> @@ -61,12 +65,19 @@
>>   #define PHYREG16			0x3C
>>   #define PHYREG16_SSC_CNT_VALUE		0x5f
>>   
>> +#define PHYREG17			0x40
>> +
>>   #define PHYREG18			0x44
>>   #define PHYREG18_PLL_LOOP		0x32
>>   
>> +#define PHYREG21			0x50
>> +#define PHYREG21_RX_SQUELCH_VAL		0x0D
>> +
>>   #define PHYREG27			0x6C
>>   #define PHYREG27_RX_TRIM_RK3588		0x4C
>>   
>> +#define PHYREG30			0x74
>> +
>>   #define PHYREG32			0x7C
>>   #define PHYREG32_SSC_MASK		GENMASK(7, 4)
>>   #define PHYREG32_SSC_DIR_SHIFT		4
>> @@ -79,6 +90,7 @@
>>   #define PHYREG33_PLL_KVCO_MASK		GENMASK(4, 2)
>>   #define PHYREG33_PLL_KVCO_SHIFT		2
>>   #define PHYREG33_PLL_KVCO_VALUE		2
>> +#define PHYREG33_PLL_KVCO_VALUE_RK3576	4
>>   
>>   struct rockchip_combphy_priv;
>>   
>> @@ -98,6 +110,7 @@ struct rockchip_combphy_grfcfg {
>>   	struct combphy_reg pipe_rxterm_set;
>>   	struct combphy_reg pipe_txelec_set;
>>   	struct combphy_reg pipe_txcomp_set;
>> +	struct combphy_reg pipe_clk_24m;
>>   	struct combphy_reg pipe_clk_25m;
>>   	struct combphy_reg pipe_clk_100m;
>>   	struct combphy_reg pipe_phymode_sel;
>> @@ -584,6 +597,263 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
>>   	.combphy_cfg	= rk3568_combphy_cfg,
>>   };
>>   
>> +static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
>> +{
>> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
>> +	unsigned long rate;
>> +	u32 val;
>> +
>> +	switch (priv->type) {
>> +	case PHY_TYPE_PCIE:
>> +		/* Set SSC downward spread spectrum */
>> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
>> +					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
>> +					 PHYREG32);
> If we use FIELD_GET|PREP, we can get rid of SHIFT defines

got it, thanks.

>> +
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
>> +		break;
> Break here and before each case please

Okay.

>> +	case PHY_TYPE_USB3:
>> +		/* Set SSC downward spread spectrum */
>> +		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
>> +					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
>> +					 PHYREG32);
>> +
>> +		/* Enable adaptive CTLE for USB3.0 Rx */
>> +		val = readl(priv->mmio + PHYREG15);
>> +		val |= PHYREG15_CTLE_EN;
>> +		writel(val, priv->mmio + PHYREG15);
>> +
>> +		/* Set PLL KVCO fine tuning signals */
>> +		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK, BIT(3), PHYREG33);
>> +
>> +		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
>> +		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
>> +
>> +		/* Set PLL input clock divider 1/2 */
>> +		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
>> +					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
>> +					 PHYREG6);
>> +
>> +		/* Set PLL loop divider */
>> +		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
>> +
>> +		/* Set PLL KVCO to min and set PLL charge pump current to max */
>> +		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
>> +
>> +		/* Set Rx squelch input filler bandwidth */
>> +		writel(PHYREG21_RX_SQUELCH_VAL, priv->mmio + PHYREG21);
>> +
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
>> +		break;
>> +	case PHY_TYPE_SATA:
>> +		/* Enable adaptive CTLE for SATA Rx */
>> +		val = readl(priv->mmio + PHYREG15);
>> +		val |= PHYREG15_CTLE_EN;
>> +		writel(val, priv->mmio + PHYREG15);
>> +
>> +		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
>> +		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
>> +		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
>> +		writel(val, priv->mmio + PHYREG7);
>> +
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);
>> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
>> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con1_for_sata, true);
>> +		break;
>> +	default:
>> +		dev_err(priv->dev, "incompatible PHY type\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	rate = clk_get_rate(priv->refclk);
>> +
>> +	switch (rate) {
>> +	case REF_CLOCK_24MHz:
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
>> +		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
>> +			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
>> +			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
>> +			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
>> +						 val, PHYREG15);
>> +
>> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
>> +
>> +		} else if (priv->type == PHY_TYPE_PCIE) {
>> +			/* PLL KVCO tuning fine */
>> +			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
>> +			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
>> +						 val, PHYREG33);
>> +
>> +			/* Set up rx_pck invert and rx msb to disable */
>> +			writel(0x00, priv->mmio + PHYREG27);
>> +
>> +			/*
>> +			 * Set up SU adjust signal:
>> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
>> +			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b011
>> +			 * su_trim[31:24], CKDRV adjust
>> +			 */
>> +			writel(0x90, priv->mmio + PHYREG11);
>> +			writel(0x02, priv->mmio + PHYREG12);
>> +			writel(0x57, priv->mmio + PHYREG14);
>> +
>> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
>> +		}
>> +		break;
>> +	case REF_CLOCK_25MHz:
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
>> +		break;
>> +	case REF_CLOCK_100MHz:
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
>> +		if (priv->type == PHY_TYPE_PCIE) {
>> +			/* gate_tx_pck_sel length select work for L1SS */
>> +			writel(0xc0, priv->mmio + PHYREG30);
>> +
>> +			/* PLL KVCO tuning fine */
>> +			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
>> +			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
>> +						 val, PHYREG33);
>> +
>> +			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
>> +			writel(0x4c, priv->mmio + PHYREG27);
>> +
>> +			/*
>> +			 * Set up SU adjust signal:
>> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
>> +			 * su_trim[15:8],  bypass PLL loop divider code, and
>> +			 *                 PLL LPF R1 adujst bits[9:7]=3'b101
>> +			 * su_trim[23:16], CKRCV adjust
>> +			 * su_trim[31:24], CKDRV adjust
>> +			 */
>> +			writel(0x90, priv->mmio + PHYREG11);
>> +			writel(0x43, priv->mmio + PHYREG12);
>> +			writel(0x88, priv->mmio + PHYREG13);
>> +			writel(0x56, priv->mmio + PHYREG14);
>> +		} else if (priv->type == PHY_TYPE_SATA) {
>> +			/* downward spread spectrum +500ppm */
>> +			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
>> +			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
>> +			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
>> +
>> +			/* ssc ppm adjust to 3500ppm */
>> +			rockchip_combphy_updatel(priv, PHYREG10_SSC_PCM_MASK,
>> +						 PHYREG10_SSC_PCM_3500PPM,
>> +						 PHYREG10);
>> +		}
>> +		break;
>> +	default:
>> +		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (priv->ext_refclk) {
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
>> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
>> +			val = PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT;
>> +			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
>> +						 val, PHYREG33);
>> +
>> +			/* Set up rx_trim: PLL LPF C1 85pf R1 2.5kohm */
>> +			writel(0x0c, priv->mmio + PHYREG27);
>> +
>> +			/*
>> +			 * Set up SU adjust signal:
>> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
>> +			 * su_trim[15:8],  bypass PLL loop divider code, and
>> +			 *                 PLL LPF R1 adujst bits[9:7]=3'b101.
>> +			 * su_trim[23:16], CKRCV adjust
>> +			 * su_trim[31:24], CKDRV adjust
>> +			 */
>> +			writel(0x90, priv->mmio + PHYREG11);
>> +			writel(0x43, priv->mmio + PHYREG12);
>> +			writel(0x88, priv->mmio + PHYREG13);
>> +			writel(0x56, priv->mmio + PHYREG14);
>> +		}
>> +	}
>> +
>> +	if (priv->enable_ssc) {
>> +		val = readl(priv->mmio + PHYREG8);
>> +		val |= PHYREG8_SSC_EN;
>> +		writel(val, priv->mmio + PHYREG8);
>> +
>> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
>> +			/* Set PLL loop divider */
>> +			writel(0x00, priv->mmio + PHYREG17);
>> +			writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
>> +
>> +			/* Set up rx_pck invert and rx msb to disable */
>> +			writel(0x00, priv->mmio + PHYREG27);
>> +
>> +			/*
>> +			 * Set up SU adjust signal:
>> +			 * su_trim[7:0],   PLL KVCO adjust bits[2:0] to min
>> +			 * su_trim[15:8],  PLL LPF R1 adujst bits[9:7]=3'b101
>> +			 * su_trim[23:16], CKRCV adjust
>> +			 * su_trim[31:24], CKDRV adjust
>> +			 */
>> +			writel(0x90, priv->mmio + PHYREG11);
>> +			writel(0x02, priv->mmio + PHYREG12);
>> +			writel(0x08, priv->mmio + PHYREG13);
>> +			writel(0x57, priv->mmio + PHYREG14);
>> +			writel(0x40, priv->mmio + PHYREG15);
>> +
>> +			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
>> +			writel(PHYREG33_PLL_KVCO_VALUE_RK3576 << PHYREG33_PLL_KVCO_SHIFT,
>> +			       priv->mmio + PHYREG33);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct rockchip_combphy_grfcfg rk3576_combphy_grfcfgs = {
>> +	/* pipe-phy-grf */
>> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
>> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
>> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
>> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
>> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
>> +	.pipe_clk_24m		= { 0x0004, 14, 13, 0x00, 0x00 },
>> +	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
>> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
>> +	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
>> +	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
>> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
>> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
>> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
>> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
>> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
>> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
>> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
>> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
>> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
>> +	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0129 },
>> +	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0000 },
>> +	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c1 },
>> +	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
>> +	/* php-grf */
>> +	.pipe_con0_for_sata	= { 0x001C, 2, 0, 0x00, 0x2 },
>> +	.pipe_con1_for_sata	= { 0x0020, 2, 0, 0x00, 0x2 },
>> +};
>> +
>> +static const struct rockchip_combphy_cfg rk3576_combphy_cfgs = {
>> +	.num_phys = 2,
>> +	.phy_ids = {
>> +		0x2b050000,
>> +		0x2b060000
>> +	},
>> +	.grfcfg		= &rk3576_combphy_grfcfgs,
>> +	.combphy_cfg	= rk3576_combphy_cfg,
>> +};
>> +
>>   static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>>   {
>>   	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
>> @@ -775,6 +1045,10 @@ static const struct of_device_id rockchip_combphy_of_match[] = {
>>   		.compatible = "rockchip,rk3568-naneng-combphy",
>>   		.data = &rk3568_combphy_cfgs,
>>   	},
>> +	{
>> +		.compatible = "rockchip,rk3576-naneng-combphy",
>> +		.data = &rk3576_combphy_cfgs,
>> +	},
>>   	{
>>   		.compatible = "rockchip,rk3588-naneng-combphy",
>>   		.data = &rk3588_combphy_cfgs,
>> -- 
>> 2.25.1


