Return-Path: <linux-kernel+bounces-320947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F997125E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66921283F71
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA71B14F3;
	Mon,  9 Sep 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1ZUPUKXD"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6571B1D74;
	Mon,  9 Sep 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871403; cv=none; b=NfjYZSQgU/YrXLJZKCH6fjLpwuw413GAhwzJ9BZOI2VlzuRUbhRNTF8q2Hbfp6WCA2ElJINKdlwLIpA6je426eltfEN/b88J0Lz+yHVyHYJuRbjvpX42Pl3mijicXV/uk1K3wiYtjU7jYFSdBvM0UktCemLbNrLqutqQY1F2V2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871403; c=relaxed/simple;
	bh=NCvZaRmInNyO6/bn+alAoJC9fBdeWLO6ORxUU1OwehI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sn5i/bPG4I3o3EIWxLyC530JdFapmV2DV2hBSnL0rbNy5h1p9tq8EoMQoEMgCgMyANoNqAwqiKgNmhY7u1g1ULiFkMrN+zG+c2QvvM066olcGvLS5A0sbwIZeGOU3th4L5nkJrzlS6N1XNmg8Va3WCutVCzR1Y63KF9fiAd0o2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1ZUPUKXD; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4898JE8Z024312;
	Mon, 9 Sep 2024 10:42:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	n6xIfcMW57LQttpcgJ8NDKLX/2xFxLOZhvVevVVN+Qo=; b=1ZUPUKXDqxzLmXgx
	UlOfaf0b6I06jcd2hXkX659nNr42+Q+wxv9YGYdv+0LusFhvvyijmgRioNjaLyBR
	C7jfBi+jtC5KrGHQr9cSPwcWA6uX5pDHPjbWZ9I4T2zkmcXS9KrL4MXpstwl/qSh
	Mmbv5u1L6wmqK2D3IStQ+qC/B7hz7gAE+pf8DrDODGdrg5pCBLeyIOssaqb5HPiY
	P6BrPaFqBoGz6nqTuHDkbaYYbvVuVmPnXGvY8dfB4x/vlVJkQpoMXKtuUsE9GYn8
	B4hXI0mwo9soGWFmMQRWujrl4Md7tQJeiAI9Uhn7brLmhglfOEJvKt3joUaDjZns
	kx2PDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41gyaum1hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 10:42:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1963C4002D;
	Mon,  9 Sep 2024 10:41:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AE4ED24EE46;
	Mon,  9 Sep 2024 10:40:46 +0200 (CEST)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Sep
 2024 10:40:46 +0200
Message-ID: <f7cead97-7f26-4923-b04d-7ce812a32577@foss.st.com>
Date: Mon, 9 Sep 2024 10:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
To: Philipp Zabel <p.zabel@pengutronix.de>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
References: <20240903121303.2953150-1-christian.bruel@foss.st.com>
 <20240903121303.2953150-3-christian.bruel@foss.st.com>
 <d743de28a5dd643cf775f4d8a3baaabd09d48c48.camel@pengutronix.de>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <d743de28a5dd643cf775f4d8a3baaabd09d48c48.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

On 9/6/24 15:44, Philipp Zabel wrote:
> Hi,
> 
> On Di, 2024-09-03 at 14:13 +0200, Christian Bruel wrote:
>> Addition of the COMBOPHY driver found on STM32MP25 platforms
>>
>> This single lane PHY is shared (exclusive) between the USB3 and PCIE
>> controllers.
>> Supports 5Gbit/s for PCIE gen2 or 2.5Gbit/s for PCIE gen1.
>>
>> Supports wakeup-source capability to wakeup system using remote-wakeup
>> capable USB device
>>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   drivers/phy/st/Kconfig              |  11 +
>>   drivers/phy/st/Makefile             |   1 +
>>   drivers/phy/st/phy-stm32-combophy.c | 590 ++++++++++++++++++++++++++++
>>   3 files changed, 602 insertions(+)
>>   create mode 100644 drivers/phy/st/phy-stm32-combophy.c
>>
> [...]
>> diff --git a/drivers/phy/st/phy-stm32-combophy.c b/drivers/phy/st/phy-stm32-combophy.c
>> new file mode 100644
>> index 000000000000..305ba124d092
>> --- /dev/null
>> +++ b/drivers/phy/st/phy-stm32-combophy.c
>> @@ -0,0 +1,590 @@
> [...]
>> +static int stm32_combophy_pll_init(struct stm32_combophy *combophy)
>> +{
>> +	int ret;
>> +	u32 refclksel, pllmult, propcntrl, val;
>> +	u32 clk_rate;
>> +	struct clk *clk;
>> +
>> +	if (combophy->have_pad_clk)
>> +		clk = combophy->clks[PAD_CLK].clk;
>> +	else
>> +		clk = combophy->clks[KER_CLK].clk;
>> +
>> +	clk_rate = clk_get_rate(clk);
>> +
>> +	reset_control_assert(combophy->phy_reset);
>> +
>> +	dev_dbg(combophy->dev, "%s pll init rate %d\n",
>> +		combophy->have_pad_clk ? "External" : "Ker", clk_rate);
>> +
>> +	/*
>> +	 * vddcombophy is interconnected with vddcore. Isolation bit should be unset
>> +	 * before using the ComboPHY.
>> +	 */
>> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
>> +			   SYSCFG_COMBOPHY_CR2_ISO_DIS, SYSCFG_COMBOPHY_CR2_ISO_DIS);
>> +
>> +	if (combophy->type != PHY_TYPE_PCIE)
>> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
>> +				   SYSCFG_COMBOPHY_CR1_REFSSPEN, SYSCFG_COMBOPHY_CR1_REFSSPEN);
> 
> Could the multiple accesses to SYSCFG_COMBOPHY_CR1 be consolidated into
> a single regmap_update_bits()?

yes, thanks

> 
>> +
>> +	if (combophy->type == PHY_TYPE_PCIE && !combophy->have_pad_clk)
>> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
>> +				   STM32MP25_PCIEPRGCR_EN, STM32MP25_PCIEPRGCR_EN);
>> +
>> +	if (of_property_present(combophy->dev->of_node, "st,ssc-on")) {
>> +		dev_dbg(combophy->dev, "Enabling clock with SSC\n");
>> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
>> +				   SYSCFG_COMBOPHY_CR1_SSCEN, SYSCFG_COMBOPHY_CR1_SSCEN);
>> +	}
>> +
>> +	if (!of_property_read_u32(combophy->dev->of_node, "st,rx-equalizer", &val)) {
>> +		dev_dbg(combophy->dev, "Set RX equalizer %u\n", val);
>> +		if (val > SYSCFG_COMBOPHY_CR4_RX0_EQ) {
>> +			dev_err(combophy->dev, "Invalid value %u for rx0 equalizer\n", val);
> 
> This path looks like it should deassert the phy_reset as well.

Ack

> 
>> +			return -EINVAL;
>> +		}
>> +
>> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR4,
>> +			   SYSCFG_COMBOPHY_CR4_RX0_EQ, val);
>> +	}
>> +
>> +	if (combophy->type == PHY_TYPE_PCIE) {
>> +		ret = stm32_impedance_tune(combophy);
>> +		if (ret) {
>> +			reset_control_deassert(combophy->phy_reset);
>> +			goto out;
>> +		}
>> +
>> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
>> +				   SYSCFG_COMBOPHY_CR1_REFUSEPAD,
>> +				   combophy->have_pad_clk ? SYSCFG_COMBOPHY_CR1_REFUSEPAD : 0);
>> +	}
>> +
>> +	switch (clk_rate) {
>> +	case 100000000:
>> +		pllmult = MPLLMULT_100;
>> +		refclksel = REFCLKSEL_0;
>> +		propcntrl = 0x8u << 4;
>> +		break;
>> +	case 19200000:
>> +		pllmult = MPLLMULT_19_2;
>> +		refclksel = REFCLKSEL_1;
>> +		propcntrl = 0x8u << 4;
>> +		break;
>> +	case 25000000:
>> +		pllmult = MPLLMULT_25;
>> +		refclksel = REFCLKSEL_0;
>> +		propcntrl = 0xeu << 4;
>> +		break;
>> +	case 24000000:
>> +		pllmult = MPLLMULT_24;
>> +		refclksel = REFCLKSEL_1;
>> +		propcntrl = 0xeu << 4;
>> +		break;
>> +	case 20000000:
>> +		pllmult = MPLLMULT_20;
>> +		refclksel = REFCLKSEL_0;
>> +		propcntrl = 0xeu << 4;
>> +		break;
>> +	default:
>> +		dev_err(combophy->dev, "Invalid rate 0x%x\n", clk_rate);
>> +		reset_control_deassert(combophy->phy_reset);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	};
>> +
>> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
>> +			   SYSCFG_COMBOPHY_CR1_REFCLKDIV2, REFCLDIV_0);
>> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
>> +			   SYSCFG_COMBOPHY_CR1_REFCLKSEL, refclksel);
>> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
>> +			   SYSCFG_COMBOPHY_CR1_MPLLMULT, pllmult);
>> +
>> +	/*
>> +	 * Force elasticity buffer to be tuned for the reference clock as
>> +	 * the separated clock model is not supported
>> +	 */
>> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR5,
>> +			   SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS, SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS);
>> +
>> +	reset_control_deassert(combophy->phy_reset);
>> +
>> +	ret = regmap_read_poll_timeout(combophy->regmap, SYSCFG_COMBOPHY_SR, val,
>> +				       !(val & STM32MP25_PIPE0_PHYSTATUS),
>> +				       10, 1000);
>> +	if (ret) {
>> +		dev_err(combophy->dev, "timeout, cannot lock PLL\n");
>> +		goto out;
>> +	}
>> +
>> +	if (combophy->type == PHY_TYPE_PCIE) {
>> +		val = readl_relaxed(combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
>> +		val &= ~COMBOPHY_PROP_CNTRL;
>> +		val |= propcntrl;
>> +		writel_relaxed(val, combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
>> +	}
>> +
>> +	return 0;
>> +
>> +out:
>> +	if (combophy->type == PHY_TYPE_PCIE && !combophy->have_pad_clk)
>> +		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
>> +				   STM32MP25_PCIEPRGCR_EN, 0);
>> +
>> +	if (combophy->type != PHY_TYPE_PCIE)
>> +		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
>> +				   SYSCFG_COMBOPHY_CR1_REFSSPEN, 0);
>> +
>> +	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
>> +			   SYSCFG_COMBOPHY_CR2_ISO_DIS, 0);
>> +
>> +	return ret;
>> +}
>> +
> [...]
>> +
>> +static int stm32_combophy_probe(struct platform_device *pdev)
>> +{
>> +	struct stm32_combophy *combophy;
>> +	struct device *dev = &pdev->dev;
>> +	struct phy_provider *phy_provider;
>> +	int ret, irq;
>> +
>> +	combophy = devm_kzalloc(dev, sizeof(*combophy), GFP_KERNEL);
>> +	if (!combophy)
>> +		return -ENOMEM;
>> +
>> +	combophy->dev = dev;
>> +
>> +	dev_set_drvdata(dev, combophy);
>> +
>> +	combophy->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(combophy->base))
>> +		return PTR_ERR(combophy->base);
>> +
>> +	if (stm32_combophy_get_clocks(combophy))
>> +		return ret;
>> +
>> +	combophy->phy_reset = devm_reset_control_get(dev, "phy");
> 
> Please use devm_reset_control_get_exclusive() directly.

OK,

thanks,
Christian
> 
> regards
> Philipp

