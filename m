Return-Path: <linux-kernel+bounces-266987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C314C940ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78208281B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E277192B75;
	Tue, 30 Jul 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5I+5eMU"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211591922DF;
	Tue, 30 Jul 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326765; cv=none; b=TTeMwWCCfbs8Cr9cQatLJDT5cxjBBAv5XgINeONSal8bZpljb5PNxyNCSyNa6BbZRTWFrfc0qgNIQfYaL01tE19YfK3F4MZ89iINN3gM4MhefPYl5qyNQeFHLgJBmBMvYkfQUS/n5l72odrDAkAzbdYRsMWci4nnyPVMsExeDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326765; c=relaxed/simple;
	bh=gLMygEK0zRY3EnoxAQzpgddOUX4k9Wz3kd8WrYwZDFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbPjgowUXF6AE0TrpR3ay7UI9RanUpkRu+cyO5g618uqmNAiUKtXG+f2ywD2uDa+rwpBiSg9O9csgKa0+v1HlUUxnzbNFskaOUK7gfca7je4+kopbYc53tywOwyY1gy6gx69D8iZxI8ArK7AOdDCy8WK4xfN4x/9HejwwZXWukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5I+5eMU; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db16b2c1d2so3119115b6e.2;
        Tue, 30 Jul 2024 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722326763; x=1722931563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VnmuEU1N5dDRQk0+bcOAjceMX+K/96omYj/mPhdj7Fo=;
        b=Q5I+5eMUl4r5oKp6R6+xu41hM1OdpNhHeBmsha1+tCqCkTSsvC8nhOtjwoC5QGaGfy
         prnUWtgWtKEhWAF9iptX8ZNCFlbpr/Mxj95mkunOlq0S4tRMYtoObXuOsTwfi0Ppf6Hd
         MyPqBLjZM7tXvbesoV00XD/1mQMUyuWhy9UXig2sqFQ6+OZjTqiAA6l8v1BrO7DmcLfk
         zk8cMbAxCIOJPJkUNY5HA0kPq2Qic6waHTl5oNj+om72rDGaDxgoM/HXc3h6T1dHursZ
         qyah9EGe3KmEHfcRfKU+kDKjxsMxJuH0/tBcVRuH55fBDvCPRfstwsqGoPfN9I8IMwPa
         e7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326763; x=1722931563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnmuEU1N5dDRQk0+bcOAjceMX+K/96omYj/mPhdj7Fo=;
        b=dVezkrxcgqfY8B2wUM46CX5ylcB/yi4OP23Kp4QmC0PH9J1xSBT38nbvARulooLI0L
         myOVp76Wal7O7SMPZVODtXlUSATOkR66nM0302GYsT12pZtaJqP26QbuUUHv/vuwV61R
         WE0ctU5qQSvfhQbcp1Qbr/xbkeyXfHssAUaW6K6QK91SHcG9t9pwfvDKSLYx/ZsD3LdS
         iVAJr2pMuLZELyA7u/XRlADYXduETAedchOV7Xx+tdyvNYOeam8szlUD7CqbNcefGHyN
         IHYIYdHJhA4f6MsthwjEd3TaurbrHNUmyX14OPn8+s10oF8n+Wd2EcvkkCFi/ptjGoYk
         TGrA==
X-Forwarded-Encrypted: i=1; AJvYcCXUdSZeK17wSnRZABLlLtFJyUJMN271cjnuGEcxpaBXP9/Y3bmCRLauc70ggTtPneHnNLFV0K/WYZxRYsyFlg4SguAvJnqxSjMY7JX0z1H7aqVBgirJKTeJWOgINdtpP4KCmm+NrO6Bqw==
X-Gm-Message-State: AOJu0Yw89xXwCxcuBHr9k4t3tJbn0RrfZY+7JUfFwyPSS03Bqa1iVUeY
	jB03CBud+qIkIUimYWbsTNYHu5LaNVILP4c0q9jIqb9F8FF2tbgB
X-Google-Smtp-Source: AGHT+IGbl7ULapgplJbjM/8/oPfogx6+4bUbzvc2wp+tUSavKIiI1R/bIhZlzQV8jlAPQNkLcNv2aA==
X-Received: by 2002:a05:6870:9691:b0:254:994b:5e6b with SMTP id 586e51a60fabf-267d4ef8f16mr12453508fac.44.1722326763010;
        Tue, 30 Jul 2024 01:06:03 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c6fcefsm8511098a12.1.2024.07.30.01.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:06:02 -0700 (PDT)
Message-ID: <a3538f0a-fd44-4aa1-8796-6adb3a753919@gmail.com>
Date: Tue, 30 Jul 2024 16:05:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: nuvoton: add new driver for the Nuvoton MA35 SoC
 USB 2.0 PHY
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729061509.83828-1-hpchen0nvt@gmail.com>
 <20240729061509.83828-3-hpchen0nvt@gmail.com>
 <7ce7f373-c738-48c7-835e-6e7d10e8ae20@kernel.org>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <7ce7f373-c738-48c7-835e-6e7d10e8ae20@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your reply.



On 2024/7/29 下午 03:32, Krzysztof Kozlowski wrote:
> On 29/07/2024 08:15, hpchen0 wrote:
>> Nuvoton MA35 SoCs support DWC2 USB controller.
>> Add the driver to drive the USB 2.0 PHY transceivers.
>>
>> Signed-off-by: hpchen0 <hpchen0nvt@gmail.com>
>> +
>> +	ret = clk_prepare_enable(p_phy->clk);
>> +	if (ret < 0) {
>> +		dev_err(p_phy->dev, "Failed to enable PHY clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
>> +	if (val & PHY0SUSPEND) {
>> +		/*
>> +		 * USB PHY0 is in operation mode already
>> +		 * make sure USB PHY 60 MHz UTMI Interface Clock ready
>> +		 */
>> +		timeout = jiffies + msecs_to_jiffies(200);
>> +		while (time_before(jiffies, timeout)) {
>> +			regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
>> +			if (val & PHY0DEVCKSTB)
>> +				return 0;
>> +			usleep_range(1000, 1500);
>> +		}
> You want some readl_poll_timeout version here.

Okay. The readl_poll_timeout function will be used instead.



>> +	}
>> +
>> +	/*
>> +	 * reset USB PHY0.
>> +	 * wait until USB PHY0 60 MHz UTMI Interface Clock ready
>> +	 */
>> +	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, (PHY0POR | PHY0SUSPEND));
>> +	timeout = jiffies + msecs_to_jiffies(200);
>> +	while (time_before(jiffies, timeout)) {
>> +		regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
>> +		if (val & PHY0DEVCKSTB)
>> +			break;
>> +		usleep_range(1000, 1500);
>> +	}
>> +
>> +	/* make USB PHY0 enter operation mode */
>> +	regmap_update_bits(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, 0x7, PHY0SUSPEND);
>> +
>> +	/* make sure USB PHY 60 MHz UTMI Interface Clock ready */
>> +	timeout = jiffies + msecs_to_jiffies(200);
>> +	while (time_before(jiffies, timeout)) {
>> +		regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
>> +		if (val & PHY0DEVCKSTB)
>> +			return 0;
>> +		usleep_range(1000, 1500);
>> +	}
>> +
>> +	dev_err(p_phy->dev, "Timed out waiting for PHY to power on\n");
>> +	ret = -ETIMEDOUT;
>> +
>> +	clk_disable_unprepare(p_phy->clk);
>> +	return ret;
>> +}
>> +
>> +static int ma35_usb_phy_power_off(struct phy *phy)
>> +{
>> +	struct ma35_usb_phy *p_phy = phy_get_drvdata(phy);
>> +
>> +	clk_disable_unprepare(p_phy->clk);
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops ma35_usb_phy_ops = {
>> +	.power_on = ma35_usb_phy_power_on,
>> +	.power_off = ma35_usb_phy_power_off,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int ma35_usb_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct phy_provider *provider;
>> +	struct ma35_usb_phy *p_phy;
>> +	const char *clkgate;
>> +	struct phy *phy;
>> +
>> +	p_phy = devm_kzalloc(&pdev->dev, sizeof(*p_phy), GFP_KERNEL);
>> +	if (!p_phy)
>> +		return -ENOMEM;
>> +
>> +	p_phy->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, p_phy);
>> +
>> +	p_phy->sysreg = syscon_regmap_lookup_by_phandle(p_phy->dev->of_node, "nuvoton,sys");
>> +	if (IS_ERR(p_phy->sysreg))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->sysreg),
>> +				     "Failed to get SYS registers\n");
>> +
>> +	/* enable clock */
>> +	of_property_read_string(p_phy->dev->of_node, "clock-enable", &clkgate);
> There is no such property.

I'm sorry, I forgot to remove this part. I will remove it and correct it.



>> +	p_phy->clk = devm_clk_get(p_phy->dev, clkgate);
> Don't mix styles of variables: you were using pdev->dev but now entirely
> different. Stick to pdev->dev.

Okay. I will consistently  use pdev->dev|.|

Thank you for the reminder.



>> +	if (IS_ERR(p_phy->clk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->clk),
> And here again pdev->dev... Bring some consistency, not random coding style.

Okay. I will consistently  use pdev->dev|.|

Thank you for the reminder.



>> +				     "Failed to get usb_phy clock\n");
>> +
>
> Best regards,
> Krzysztof


Best regards,

Hui-Ping Chen



