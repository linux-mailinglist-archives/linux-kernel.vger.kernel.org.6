Return-Path: <linux-kernel+bounces-365204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA199DEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75202839F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF20319C542;
	Tue, 15 Oct 2024 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8pFKm74"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F618BB8F;
	Tue, 15 Oct 2024 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975528; cv=none; b=KUgu2ROKKGWHAAbhsgTN59kVA14AJLCZgQtl3VX+ujq3Y9V6hElgyB2QnLh/IuBCSjWjfhF2upn/z/gXfBG3//viraJzEt6wobSyelR6SiwTsUBpHjSyQRKaDqOs2igWS21HQmUXJ4PDnG7rQgCc4kvYiSZerc0rKj45A+8H8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975528; c=relaxed/simple;
	bh=6uwY9iEupC2nz8gGrmjjlG5L8kjSkt5VX/hruS/T2pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9pgDmae8V580dVhFkHMfMxosQ5pG3AcSHU6eb73JaQ7M8RvzXQVletcwqDIEilWMB2IB66U3zVjgoJ61h51AutywIjfEzp4Yf1HZDrf4EYIs8jRjyJNpR/+gHMfiqDLBpLq0/dOTHs2JUG8yYMvAqlEB/JBgsM/7OdOQ3pGh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8pFKm74; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso823586a91.2;
        Mon, 14 Oct 2024 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728975526; x=1729580326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8O8a/W9BX22xkR7baqN01A7a4KYNQYX8/DGiUlDM8bs=;
        b=C8pFKm74C+pgC6u/2iWnQXKI6lwD6YQs0GN/ocQEx5x+imtFFNZrzvF0GglH6smzma
         fk89f5VCwAonDdJCJ9UZACwtczOscVQCXre7Rm0493XsucRqIjH4GEPBWoBW9HUbtLtF
         SBk8MvZ4amupXHAHnaD9BYkyDdtsQtK02ju/27mvfp0YCpI1RH3LUmh7fjY587vIoX7G
         KsgFfc/12g5n82vztN//RF57IpxB7p+HYaQpD12wBBwkG4RxObwYmVT63K+XpDS7UkdJ
         C+LA9EEW1IX/6tBTqSdnspV5j5mGJCWBlDjGorpVyKBH5rkNs0LF9lNcbaJXc9Ed/03+
         e6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975526; x=1729580326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O8a/W9BX22xkR7baqN01A7a4KYNQYX8/DGiUlDM8bs=;
        b=gxLsnFVBL4WZSO3N7NTp3ySslA/rhko2VfZ/PWjMwCUA20uex47bamWPoecKjx3+Sq
         A5Ab4ujYz6Pxa473HnD9IfCgLuZ1h5rWfqF27P9tZV4dEouwEN4vRLM73exM5Rd3yU0O
         e5Z8uId1NujK4jUKyVtQ6qsEry1pqFWpmUkWNvsdpVXvAXwUWCfaLIihidUDhl+lz4na
         NvRjf5MvbMpTU/hGrSCfa074gwhpnC7ZttgQrH5yRjWmwBLLDo6QKTcwiQYXxk5Z4tWt
         RSEZEmJPvrWm3VrsJiqLw+k4AOanPxbJU6EPq2HzktqBAfbiEq0m5y7beRRhLfo5pZe4
         Y4xg==
X-Forwarded-Encrypted: i=1; AJvYcCUti2iaK25mBB2FDY7tEuP5tgINHQiebJxb0eCh/OATSy3ezA/eoAjAETBot0WEV0kE9bv7prqLAhoD@vger.kernel.org, AJvYcCWWmz9rzN3NXKSz+8eADQqChbetZUjaEgJsfuoVME0j4P0Bah4kHGc5hvr4Rb876JL0gdRAtqXDbRrU6o1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpn6eWGkCUxnVeV/YikkyHlqEn8u73BwABzwTqur5Q6ixmfvZ
	0a7XZYp9E2G9/YGrymScuZMrX7bQbBYn60DDJn12lhm3wxTqcqtr
X-Google-Smtp-Source: AGHT+IEBqmxJcUAPwc0m9shaSmGmfnJw4762AWitMaevIA/PybZVcHiiqdG350ME7/zXk7SV5l8ICA==
X-Received: by 2002:a05:6a00:4b04:b0:71e:770d:2c00 with SMTP id d2e1a72fcca58-71e770d2fc9mr755063b3a.4.1728975526306;
        Mon, 14 Oct 2024 23:58:46 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c70590esm638195a12.70.2024.10.14.23.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 23:58:45 -0700 (PDT)
Message-ID: <31b9d876-3790-4427-a2d0-8e20192744eb@gmail.com>
Date: Tue, 15 Oct 2024 14:58:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: rockchip-naneng-combo: Support rk3576
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>
References: <20241015013351.4884-1-frawang.cn@gmail.com>
 <20241015013351.4884-2-frawang.cn@gmail.com> <1981070.PYKUYFuaPT@diego>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <1981070.PYKUYFuaPT@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko,

On 2024/10/15 14:15, Heiko Stübner wrote:
> Hi Frank,
>
> Am Dienstag, 15. Oktober 2024, 03:33:51 CEST schrieb Frank Wang:
>> From: Kever Yang <kever.yang@rock-chips.com>
>>
>> phy0: pcie, sata
>> phy1: pcie, sata, usb3
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   .../rockchip/phy-rockchip-naneng-combphy.c    | 202 ++++++++++++++++++
>>   1 file changed, 202 insertions(+)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> index 0a9989e41237..4c41317a8041 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> @@ -584,6 +585,203 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
>>   	.combphy_cfg	= rk3568_combphy_cfg,
>>   };
>>   
>> +static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
>> +{
>> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
>> +	unsigned long rate;
>> +
>> +	switch (priv->type) {
>> +	case PHY_TYPE_PCIE:
>> +		/* Set SSC downward spread spectrum */
>> +		rockchip_combphy_updatel(priv, GENMASK(5, 4), BIT(4), 0x7c);
> Can we get constants for those magic values please?

Ah of cause, I will amend them and send a new patch.


Best regards,
Frank


> The combophys for rk3568 and rk3588 do use actual constants to at least
> somewhat describe what happens, so it would be really nice for the rk3576
> to do this as well.
>
> Same for the rockchip_combphy_updatel and other writel calls below.
>
>
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
>> +		break;
>> +	case PHY_TYPE_USB3:
>> +		/* Set SSC downward spread spectrum */
>> +		rockchip_combphy_updatel(priv, GENMASK(5, 4), BIT(4), 0x7c);
>> +
>> +		/* Enable adaptive CTLE for USB3.0 Rx */
>> +		rockchip_combphy_updatel(priv, GENMASK(0, 0), BIT(0), 0x38);
>> +
>> +		/* Set PLL KVCO fine tuning signals */
>> +		rockchip_combphy_updatel(priv, GENMASK(4, 2), BIT(3), 0x80);
>> +
>> +		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
>> +		writel(0x4, priv->mmio + (0xb << 2));
>> +
>> +		/* Set PLL input clock divider 1/2 */
>> +		rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0x14);
>> +
>> +		/* Set PLL loop divider */
>> +		writel(0x32, priv->mmio + (0x11 << 2));
>> +
>> +		/* Set PLL KVCO to min and set PLL charge pump current to max */
>> +		writel(0xf0, priv->mmio + (0xa << 2));
>> +
>> +		/* Set Rx squelch input filler bandwidth */
>> +		writel(0x0d, priv->mmio + (0x14 << 2));
>> +
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
>> +		break;
>> +	case PHY_TYPE_SATA:
>> +		/* Enable adaptive CTLE for SATA Rx */
>> +		rockchip_combphy_updatel(priv, GENMASK(0, 0), BIT(0), 0x38);
>> +
>> +		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
>> +		writel(0x8F, priv->mmio + (0x06 << 2));
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
>> +			rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0xe << 2);
>> +
>> +			rockchip_combphy_updatel(priv, GENMASK(7, 0), 0x5f, 0xf << 2);
>> +		} else if (priv->type == PHY_TYPE_PCIE) {
>> +			/* PLL KVCO tuning fine */
>> +			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
>> +
>> +			/* Set up rx_trim */
>> +			writel(0x0, priv->mmio + (0x1b << 2));
>> +
>> +			/* Set up su_trim: T0_1 */
>> +			writel(0x90, priv->mmio + (0xa << 2));
>> +			writel(0x02, priv->mmio + (0xb << 2));
>> +			writel(0x57, priv->mmio + (0xd << 2));
>> +
>> +			writel(0x5f, priv->mmio + (0xf << 2));
> This does includes both the value as well as the register addresses,
> because a hex-value with a bit shift makes that even less readable.
>
> Thanks a lot
> Heiko
>
>
>> +		}
>> +		break;
>> +	case REF_CLOCK_25MHz:
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
>> +		break;
>> +	case REF_CLOCK_100MHz:
>> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
>> +		if (priv->type == PHY_TYPE_PCIE) {
>> +			/* gate_tx_pck_sel length select work for L1SS */
>> +			writel(0xc0, priv->mmio + 0x74);
>> +
>> +			/* PLL KVCO tuning fine */
>> +			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
>> +
>> +			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
>> +			writel(0x4c, priv->mmio + (0x1b << 2));
>> +
>> +			/* Set up su_trim: T3_P1 650mv */
>> +			writel(0x90, priv->mmio + (0xa << 2));
>> +			writel(0x43, priv->mmio + (0xb << 2));
>> +			writel(0x88, priv->mmio + (0xc << 2));
>> +			writel(0x56, priv->mmio + (0xd << 2));
>> +		} else if (priv->type == PHY_TYPE_SATA) {
>> +			/* downward spread spectrum +500ppm */
>> +			rockchip_combphy_updatel(priv, GENMASK(7, 4), 0x50, 0x1f << 2);
>> +
>> +			/* ssc ppm adjust to 3500ppm */
>> +			rockchip_combphy_updatel(priv, GENMASK(3, 0), 0x7, 0x9 << 2);
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
>> +			writel(0x10, priv->mmio + (0x20 << 2));
>> +
>> +			writel(0x0c, priv->mmio + (0x1b << 2));
>> +
>> +			/* Set up su_trim: T3_P1 650mv */
>> +			writel(0x90, priv->mmio + (0xa << 2));
>> +			writel(0x43, priv->mmio + (0xb << 2));
>> +			writel(0x88, priv->mmio + (0xc << 2));
>> +			writel(0x56, priv->mmio + (0xd << 2));
>> +		}
>> +	}
>> +
>> +	if (priv->enable_ssc) {
>> +		rockchip_combphy_updatel(priv, GENMASK(4, 4), BIT(4), 0x7 << 2);
>> +
>> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
>> +			/* Xin24M T0_1 650mV */
>> +			writel(0x00, priv->mmio + (0x10 << 2));
>> +			writel(0x32, priv->mmio + (0x11 << 2));
>> +			writel(0x00, priv->mmio + (0x1b << 2));
>> +			writel(0x90, priv->mmio + (0x0a << 2));
>> +			writel(0x02, priv->mmio + (0x0b << 2));
>> +			writel(0x08, priv->mmio + (0x0c << 2));
>> +			writel(0x57, priv->mmio + (0x0d << 2));
>> +			writel(0x40, priv->mmio + (0x0e << 2));
>> +			writel(0x5f, priv->mmio + (0x0f << 2));
>> +			writel(0x10, priv->mmio + (0x20 << 2));
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>
>


