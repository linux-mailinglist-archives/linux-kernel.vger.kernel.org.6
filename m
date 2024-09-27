Return-Path: <linux-kernel+bounces-341319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD81987E40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5931C221E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C36C172BB9;
	Fri, 27 Sep 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA0APSyc"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEB52F74;
	Fri, 27 Sep 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417811; cv=none; b=MhiV+3YEq84/YNLbOwZ1eDx7jbSNHOJd67QY+AZS5mUsZ0X+uo69sN0MNWeHAVBKkzz/Sht1ZWXf5IOlUzNG8WpVWu50tRCvgb6IRoZ/cMxaUUpF8D6jT6OWAToQlNNFfnIC9zrFfKu739ppWTkGgqOBPcemf8Z7K/I1NHyNGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417811; c=relaxed/simple;
	bh=pk0EhutWfXshVlwVkCjUb7C2pwlJpTvsYXfR/yqB0LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM58UKOiYjCoGZ03IQ0Evi2s/U1BOoQRlF8rCRUGDlB4z3DAqg8arlJakqmRXMly5rg1ZhulPReThJ53ZF3DUGA3HiecBrtBy4CRW1CPg+wulYZbLskbsN6dESugQAIcsKt87NS1aK2O0vFcMzvjid8KlhVwd9pl05zjiMt6qv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA0APSyc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718ef6a26dbso114273b3a.1;
        Thu, 26 Sep 2024 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727417809; x=1728022609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFMu5nIK1XA2U6Jv3UWdl8l0/cwS3LFilHd5/wyNgKU=;
        b=lA0APSycx5UYqjyu+27mw3i/yd7iIDtNMJNaTuWwmSj2b4NLYkmhqQAyuALyDIKaWx
         /04cGFoCHtFHUo9sUeHzDGrIW6eUMo5OdAXX2nL4cqRqSQ+Vid7uCmNNqyVsPbphmPKl
         I1QDYhv/BXhY3VtYEAHtHYCHJkaFMACimtGEgZMiAn82cbMDldPZSxaZ63XiqpkhA5lK
         8szcXaevtbT3VArzlOIf/v6HxftYLkLw62RAokIv0KPC/tEF/iCvNardKYmt+DaIWMWf
         jA57XgBFScCa0tauYVoLH2T/OesScF74BVjvGEBfjNf/2gbHjCuaZsgGeNw8wJlG2uJy
         yvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727417809; x=1728022609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFMu5nIK1XA2U6Jv3UWdl8l0/cwS3LFilHd5/wyNgKU=;
        b=jaw8FCY86LERalettWZc82rx2sftIFgrJy1Z2DgQm9L2eiQS/UydrjHQruprv0Ymee
         KDba8Xcp39G2e2ME1ZVma+hDkCaZiYjBy7HUslfkMzdl1GEfsoPQ3Ta/Skz3qyhAs1Fa
         52ahLJcUqekRv/1ikHtHObeem/VWLbWM9bWMOUwW4SV8BU9EV67wsoJuVfkdCsCNHJPH
         Z357LkoG3laJFGYG6HyFlh0BA1U43hqIfQFOgUXJuj6yCIw7t4oU27RvmalKtSjaB6ek
         OOhb74V6LXMAVPER2z67YGUnzBDqbj3Pcz4J6qnRyddXNwU2/nhFAN7Jh+yAkoH055/Q
         zl2g==
X-Forwarded-Encrypted: i=1; AJvYcCUZUnN3jcoiKhGpYnFAPdkuZ6iKYwgubwKs3XfhOsLLoF2HGFuha/ZFKljp4jQE338/uj/IYdWqhm3n@vger.kernel.org, AJvYcCXp8p8d8yJbrr/Wqawoh2VdHT3bObXdrUkhOSINMylWIOOf7rC5+6xhd7dtuzJ9acroxZQ0mbM5/GkYJOqO@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNxeYVCPwNzTYZdc9aLwPqd7QX+02Y9NIBB1NsX6/uRSdFah7
	APoO3PgSPfFeqV0z/jLdMMtOPabYANeWctFHDHB9XN9JvACyUztL8EDTOO8w
X-Google-Smtp-Source: AGHT+IFMk1Agg28AI0P5xMasf2xXouzCk5MXC6T3rgBYjc4+jgRDD/x2a4D4CmpENKmag+Or5NCmng==
X-Received: by 2002:a05:6a00:190e:b0:71b:64c:813f with SMTP id d2e1a72fcca58-71b2607eb74mr1501331b3a.6.1727417808721;
        Thu, 26 Sep 2024 23:16:48 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264be25dsm857173b3a.84.2024.09.26.23.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 23:16:48 -0700 (PDT)
Message-ID: <9cc2d594-a930-4c4a-86ee-47228af28936@gmail.com>
Date: Fri, 27 Sep 2024 14:16:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: rockchip: inno-usb2: Add usb2 phys support
 for rk3576
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240926103223.29538-1-frawang.cn@gmail.com>
 <20240926103223.29538-2-frawang.cn@gmail.com> <10867555.aFP6jjVeTY@phil>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <10867555.aFP6jjVeTY@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heiko,

On 2024/9/26 18:48, Heiko Stuebner wrote:
> Am Donnerstag, 26. September 2024, 12:32:23 CEST schrieb Frank Wang:
>> From: William Wu <william.wu@rock-chips.com>
>>
>> The RK3576 SoC has two independent USB2.0 PHYs, and each PHY has
>> one port.
>>
>> This change also converts the clock management from single to bulk
>> as some Rockchip SoCs (e.g RK3576) have more than one clock.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>> Changelog:
>> v3:
>>   - amend the commit log adds clocks converting.
>>   - retrieve the clock by "clks.id" in *_clk480m_register() function.
>>
>> v2:
>>   - no changes.
>> v1:
>>   - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-2-frank.wang@rock-chips.com/
>>
>>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 139 +++++++++++++++++-
>>   1 file changed, 131 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> index 4f71373ae6e1..642c7857c5ae 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> @@ -229,9 +229,10 @@ struct rockchip_usb2phy_port {
>>    * @dev: pointer to device.
>>    * @grf: General Register Files regmap.
>>    * @usbgrf: USB General Register Files regmap.
>> - * @clk: clock struct of phy input clk.
>> + * @clks: array of phy input clocks.
>>    * @clk480m: clock struct of phy output clk.
>>    * @clk480m_hw: clock struct of phy output clk management.
>> + * @num_clks: number of phy input clocks.
>>    * @phy_reset: phy reset control.
>>    * @chg_state: states involved in USB charger detection.
>>    * @chg_type: USB charger types.
>> @@ -246,9 +247,10 @@ struct rockchip_usb2phy {
>>   	struct device	*dev;
>>   	struct regmap	*grf;
>>   	struct regmap	*usbgrf;
>> -	struct clk	*clk;
>> +	struct clk_bulk_data	*clks;
>>   	struct clk	*clk480m;
>>   	struct clk_hw	clk480m_hw;
>> +	int			num_clks;
>>   	struct reset_control	*phy_reset;
>>   	enum usb_chg_state	chg_state;
>>   	enum power_supply_type	chg_type;
>> @@ -376,7 +378,9 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>>   {
>>   	struct device_node *node = rphy->dev->of_node;
>>   	struct clk_init_data init;
>> +	struct clk *refclk = NULL;
>>   	const char *clk_name;
>> +	int i;
>>   	int ret = 0;
>>   
>>   	init.flags = 0;
>> @@ -386,8 +390,15 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>>   	/* optional override of the clockname */
>>   	of_property_read_string(node, "clock-output-names", &init.name);
>>   
>> -	if (rphy->clk) {
>> -		clk_name = __clk_get_name(rphy->clk);
>> +	for (i = 0; i < rphy->num_clks; i++) {
>> +		if (!strncmp(rphy->clks[i].id, "phyclk", 6)) {
>> +			refclk = rphy->clks[i].clk;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!IS_ERR(refclk)) {
>> +		clk_name = __clk_get_name(refclk);
>>   		init.parent_names = &clk_name;
>>   		init.num_parents = 1;
>>   	} else {
>> @@ -1406,22 +1417,29 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>>   	if (IS_ERR(rphy->phy_reset))
>>   		return PTR_ERR(rphy->phy_reset);
>>   
>> -	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
>> -	if (IS_ERR(rphy->clk)) {
>> -		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
>> +	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
>> +	if (ret == -EPROBE_DEFER) {
>> +		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
>>   				     "failed to get phyclk\n");
>>   	}
>>   
>> +	/* Clocks are optional */
>> +	rphy->num_clks = ret < 0 ? 0 : ret;
>> +
>>   	ret = rockchip_usb2phy_clk480m_register(rphy);
>>   	if (ret) {
>>   		dev_err(dev, "failed to register 480m output clock\n");
>>   		return ret;
>>   	}
>>   
>> +	ret = clk_bulk_prepare_enable(rphy->num_clks, rphy->clks);
>> +	if (ret)
>> +		return ret;
>> +
> Do you actually need that separate enable step?
> There exists devm_clk_bulk_get_all_enable()
>
> https://elixir.bootlin.com/linux/v6.11/source/include/linux/clk.h#L511
>
> which you could use above. Especially as otherwise you'd need a remove
> callback to disable the clock on driver unbind?
>

Using devm_clk_bulk_get_all() just can get clocknumbers, 
anddevm_clk_bulk_get_all_enable() is not.
It seems that there is no other API can get the number of clocks separately.


>>   	if (rphy->phy_cfg->phy_tuning) {
>>   		ret = rphy->phy_cfg->phy_tuning(rphy);
>>   		if (ret)
>> -			return ret;
>> +			goto disable_clks;
>>   	}
>>   
>>   	index = 0;
>> @@ -1484,6 +1502,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>>   
>>   put_child:
>>   	of_node_put(child_np);
>> +disable_clks:
>> +	clk_bulk_disable_unprepare(rphy->num_clks, rphy->clks);
>>   	return ret;
>>   }
>>   
>> @@ -1495,6 +1515,30 @@ static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
>>   				BIT(2) << BIT_WRITEABLE_SHIFT | 0);
>>   }
>
> I still maintain, that this maybe should be two separate patches.
> And you even seem to have nice "cut-here" in it ;-)
>
> The code above converts the driver to use clk_bulk to handle
> multiple clocks for controller variants needing it.
>
>
> And the code below adds the rk3576-specific data to the driver.
>

Make sense, I shall split two separate patches in the next version.
BTW, should I send the clk_bulk process patch as a separate series? I 
mean I shouldn't send it together with this series, right?


Best regards,
Frank

>
>> [...]
>>
>> +
>>   static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>>   	{
>>   		.reg = 0x0000,
>> @@ -2094,6 +2216,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
>>   	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
>>   	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
>>   	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
>> +	{ .compatible = "rockchip,rk3576-usb2phy", .data = &rk3576_phy_cfgs },
>>   	{ .compatible = "rockchip,rk3588-usb2phy", .data = &rk3588_phy_cfgs },
>>   	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
>>   	{}
>>
>


