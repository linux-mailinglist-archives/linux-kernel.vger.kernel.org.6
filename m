Return-Path: <linux-kernel+bounces-537339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69490A48AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6BE7A517E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C2327128C;
	Thu, 27 Feb 2025 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NFvilmyF"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9C1A9B2A;
	Thu, 27 Feb 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692380; cv=none; b=SdSTXymt3YEhONWX8YqrJI/eLzFUWKiiRxWKtT5qeKyacqBbnpmY1DKoXhOnYcfD3nf5jdQ3XKeyDSZt7pIbCJ6l16unF7RW+BzJKjFjLBZBU4gDGbvHR1lOAfRXXVsNiYaqZicvZ8qeYLxtkKeqzUjvuXACgJg5a5lHgbCu9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692380; c=relaxed/simple;
	bh=Y3E7VGIAhO0Vv9/c8425Yr/gdlv8MZnGhkzpRUXwtNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bE4M1dWkQmU30IvoQsxLGzyUJTnU3lNP/lGlp0FsNHJpe2WpFKxXLwrEgdgjJIccJUO0Ei6dpCSKstdlpzPAur0FjFwW/zCBTtOmh3XlnSpa1ywIhEduq2CKGRLvouaWX9etDsjeGbZzYTH2LbwZFiGcGtZ2uzeFKWgao7vt4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NFvilmyF; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RLdRdo2469570
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Feb 2025 15:39:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740692367;
	bh=nVZYza+MC2QljsqmOtf10Gpoo5weCxof9ntu9Cj1Hxs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NFvilmyFCUXFa6DvuSlPY4UKrb8yobGSZ6qeBJKJKx1G9vvOx0HPQlpIx6IOFRzYA
	 MSbEhX8U2eK7UHYfu++1/mYI0Lgy28mBOQgbI5UhZ0gvUY4fZ3ASlWvpqf9U5R4yjO
	 2WBZle8Txdr1tDLJVdK8xhpgfruOUa2SSBkjePUU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RLdRCx038307;
	Thu, 27 Feb 2025 15:39:27 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 15:39:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 15:39:27 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RLdQAv018642;
	Thu, 27 Feb 2025 15:39:26 -0600
Message-ID: <3b232103-3c02-4d7a-864c-45e6a3de3095@ti.com>
Date: Thu, 27 Feb 2025 15:39:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] mux: mmio: Extend mmio-mux driver to configure
 mux with new DT property
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250227202206.2551305-1-c-vankar@ti.com>
 <20250227202206.2551305-3-c-vankar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250227202206.2551305-3-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 2/27/25 2:22 PM, Chintan Vankar wrote:
> MMIO mux driver is designed to parse "mux-reg-masks" and "idle-states"
> property independently to configure mux registers. Drawback of this
> approach is, while configuring mux-controller one need to specify every
> register of memory space with offset and mask in "mux-reg-masks" and
> register state to "idle-states", that would be more complex for devices
> with large memory space.
> 
> Add support to extend the mmio mux driver to configure a specific register
> or set of register in memory space.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>   drivers/mux/mmio.c | 148 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 122 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index 30a952c34365..8937d0ea2b11 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -2,7 +2,7 @@
>   /*
>    * MMIO register bitfield-controlled multiplexer driver
>    *
> - * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
> + * Copyright (C) 2017-2025 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
>    */
>   
>   #include <linux/bitops.h>
> @@ -33,10 +33,84 @@ static const struct of_device_id mux_mmio_dt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids);
>   
> +static int reg_mux_get_controllers(const struct device_node *np, char *prop_name)
> +{
> +	int ret;
> +
> +	ret = of_property_count_u32_elems(np, prop_name);
> +	if (ret == 0 || ret % 2)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static int reg_mux_get_controllers_extended(const struct device_node *np, char *prop_name)
> +{
> +	int ret;
> +
> +	ret = of_property_count_u32_elems(np, prop_name);
> +	if (ret == 0 || ret % 3)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static int reg_mux_parse_dt(const struct device_node *np, bool *mux_reg_masks_state,
> +			    int *num_fields)
> +{
> +	int ret;
> +
> +	if (*mux_reg_masks_state) {
> +		ret = reg_mux_get_controllers_extended(np, "mux-reg-masks-state");
> +		if (ret < 0)
> +			return ret;
> +		*num_fields = ret / 3;
> +	} else {
> +		ret = reg_mux_get_controllers(np, "mux-reg-masks");
> +		if (ret < 0)
> +			return ret;
> +		*num_fields = ret / 2;
> +	}
> +	return ret;
> +}
> +
> +static int mux_reg_set_parameters(const struct device_node *np, char *prop_name, u32 *reg,
> +				  u32 *mask, int index)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u32_index(np, prop_name,
> +					 2 * index, reg);
> +	if (!ret)
> +		ret = of_property_read_u32_index(np, prop_name,
> +						 2 * index + 1, mask);
> +
> +	return ret;
> +}
> +
> +static int mux_reg_set_parameters_extended(const struct device_node *np, char *prop_name, u32 *reg,
> +					   u32 *mask, u32 *state, int index)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u32_index(np, prop_name,
> +					 3 * index, reg);

This is some odd line wrapping, why newline at 55 chars here?
You can go to 80 or 100 if it is readable.

> +	if (!ret) {

Just return early, no need for this MISRA-like "single return" junk.

> +		ret = of_property_read_u32_index(np, prop_name,
> +						 3 * index + 1, mask);
> +		if (!ret)
> +			ret = of_property_read_u32_index(np, prop_name,
> +							 3 * index + 2, state);
> +	}
> +
> +	return ret;
> +}
> +
>   static int mux_mmio_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> +	bool mux_reg_masks_state = false;
>   	struct regmap_field **fields;
>   	struct mux_chip *mux_chip;
>   	struct regmap *regmap;
> @@ -59,15 +133,19 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, PTR_ERR(regmap),
>   				     "failed to get regmap\n");
>   
> -	ret = of_property_count_u32_elems(np, "mux-reg-masks");
> -	if (ret == 0 || ret % 2)
> -		ret = -EINVAL;
> +	if (of_property_present(np, "mux-reg-masks-state"))
> +		mux_reg_masks_state = true;
> +
> +	ret = reg_mux_parse_dt(np, &mux_reg_masks_state, &num_fields);

Why are you passing this bool by pointer? You don't modify it in the function..

>   	if (ret < 0) {
> -		dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
> -			ret);
> +		if (mux_reg_masks_state)
> +			dev_err(dev, "mux-reg-masks-state property missing or invalid: %d\n",
> +				ret);
> +		else
> +			dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
> +				ret);
>   		return ret;
>   	}
> -	num_fields = ret / 2;
>   
>   	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
>   				       sizeof(*fields));
> @@ -79,19 +157,25 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   	for (i = 0; i < num_fields; i++) {
>   		struct mux_control *mux = &mux_chip->mux[i];
>   		struct reg_field field;
> -		s32 idle_state = MUX_IDLE_AS_IS;
> +		s32 state, idle_state = MUX_IDLE_AS_IS;
>   		u32 reg, mask;
>   		int bits;
>   
> -		ret = of_property_read_u32_index(np, "mux-reg-masks",
> -						 2 * i, &reg);
> -		if (!ret)
> -			ret = of_property_read_u32_index(np, "mux-reg-masks",
> -							 2 * i + 1, &mask);
> -		if (ret < 0) {
> -			dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
> -				i, ret);
> -			return ret;
> +		if (!mux_reg_masks_state) {
> +			ret = mux_reg_set_parameters(np, "mux-reg-masks", &reg, &mask, i);
> +			if (ret < 0) {
> +				dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
> +					i, ret);
> +				return ret;
> +			}
> +		} else {
> +			ret = mux_reg_set_parameters_extended(np, "mux-reg-masks-state", &reg,
> +							      &mask, &state, i);
> +			if (ret < 0) {
> +				dev_err(dev, "bitfield %d: failed to read custom-states property: %d\n",
> +					i, ret);
> +				return ret;
> +			}
>   		}
>   
>   		field.reg = reg;
> @@ -115,16 +199,28 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   		bits = 1 + field.msb - field.lsb;
>   		mux->states = 1 << bits;
>   
> -		of_property_read_u32_index(np, "idle-states", i,
> -					   (u32 *)&idle_state);
> -		if (idle_state != MUX_IDLE_AS_IS) {
> -			if (idle_state < 0 || idle_state >= mux->states) {
> -				dev_err(dev, "bitfield: %d: out of range idle state %d\n",
> -					i, idle_state);
> -				return -EINVAL;
> +		if (!mux_reg_masks_state) {
> +			of_property_read_u32_index(np, "idle-states", i,
> +						   (u32 *)&idle_state);

 From here down, both branches of this are almost identical, idle_state and
your new "state" var do the same thing, why do you need both?

Andrew

> +			if (idle_state != MUX_IDLE_AS_IS) {
> +				if (idle_state < 0 || idle_state >= mux->states) {
> +					dev_err(dev, "bitfield: %d: out of range idle state %d\n",
> +						i, idle_state);
> +					return -EINVAL;
> +				}
> +
> +				mux->idle_state = idle_state;
> +			}
> +		} else {
> +			if (state != MUX_IDLE_AS_IS) {
> +				if (state < 0 || state >= mux->states) {
> +					dev_err(dev, "bitfield: %d: out of range idle state %d\n",
> +						i, state);
> +					return -EINVAL;
> +				}
> +
> +				mux->idle_state = state;
>   			}
> -
> -			mux->idle_state = idle_state;
>   		}
>   	}
>   

