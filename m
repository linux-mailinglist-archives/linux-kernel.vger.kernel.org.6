Return-Path: <linux-kernel+bounces-211688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA0905563
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4D0283617
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98017E90F;
	Wed, 12 Jun 2024 14:40:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617F17E46F;
	Wed, 12 Jun 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203259; cv=none; b=gSmdTZw48JmbsanbJL44tv25ToxJIohqhOqiTM8cGI8BijBcfIm7iSFgQE+irnO0uey5xEVor7Jk2hIjZNTNQvfxfQJ1C38Ok9Ptyi3OJ313YO4zgnBOQi/zzoBlA/pTqrl621NRZlnjftZuzCRubLO7lYOQOFkMO99SZlDdJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203259; c=relaxed/simple;
	bh=LUiu7PHuCd17OsUpd5Mn2HbzQBhX7B6ZhtroeOKvBcM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mU4T8zZ3KQ5Z1jL43StiHXmGbO4hq82cYGthV0jCLiSHg/Ko11RxuJUp8mQxt1gsdGZOXdAQAGEtblzv3xOAskYI5RdmNPaUfhLm9GFuYBWQs6cWRUcasOgxUfnHSnKqan8DiYoXlhRbFOpzMocdG9PILf+qat2ZZWnqE9Xy89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305431042;
	Wed, 12 Jun 2024 07:41:20 -0700 (PDT)
Received: from [10.1.29.46] (e110479.arm.com [10.1.29.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3BB93F64C;
	Wed, 12 Jun 2024 07:40:52 -0700 (PDT)
Message-ID: <f685b49a-36b1-46c9-a0a3-734bca8bd968@arm.com>
Date: Wed, 12 Jun 2024 15:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] regulator: axp20x: AXP717: fix LDO supply rails
 and off-by-ones
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Ryan Walklin <ryan@testtoast.com>,
 Chris Morgan <macroalpha82@gmail.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-3-andre.przywara@arm.com>
Content-Language: en-US
In-Reply-To: <20240418000736.24338-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Broonie,

On 18/04/2024 01:07, Andre Przywara wrote:
> The X-Powers AXP717 PMIC has separate input supply pins for each group
> of LDOs, so they are not all using the same DCDC1 input, as described
> currently.
> 
> Replace the "supply" member of each LDO description with the respective
> group supply name, so that the supply dependencies can be correctly
> described in the devicetree.
> 
> Also fix two off-by-ones in the regulator macros, after some double
> checking the numbers against the datasheet. This uncovered a bug in the
> datasheet: add a comment to document this.
> 
> Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Can you please take (at least) this one patch as a fix for 6.10? Applies 
cleanly on top of v6.10-rc3. The changes are not super-critical, but 
worth fixing nevertheless.

Thanks,
Andre

> ---
>   drivers/regulator/axp20x-regulator.c | 33 ++++++++++++++++------------
>   1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 34fcdd82b2eaa..f3c447ecdc3bf 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -140,7 +140,7 @@
>   
>   #define AXP717_DCDC1_NUM_VOLTAGES	88
>   #define AXP717_DCDC2_NUM_VOLTAGES	107
> -#define AXP717_DCDC3_NUM_VOLTAGES	104
> +#define AXP717_DCDC3_NUM_VOLTAGES	103
>   #define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
>   #define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
>   
> @@ -763,10 +763,15 @@ static const struct linear_range axp717_dcdc1_ranges[] = {
>   	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
>   };
>   
> +/*
> + * The manual says that the last voltage is 3.4V, encoded as 0b1101011 (107),
> + * but every other method proves that this is wrong, so it's really 106 that
> + * programs the final 3.4V.
> + */
>   static const struct linear_range axp717_dcdc2_ranges[] = {
>   	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
>   	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> -	REGULATOR_LINEAR_RANGE(1600000, 88, 107, 100000),
> +	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
>   };
>   
>   static const struct linear_range axp717_dcdc3_ranges[] = {
> @@ -790,40 +795,40 @@ static const struct regulator_desc axp717_regulators[] = {
>   	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
>   		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
>   		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
> -	AXP_DESC(AXP717, ALDO1, "aldo1", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
>   		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
> -	AXP_DESC(AXP717, ALDO2, "aldo2", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO2, "aldo2", "aldoin", 500, 3500, 100,
>   		 AXP717_ALDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(1)),
> -	AXP_DESC(AXP717, ALDO3, "aldo3", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO3, "aldo3", "aldoin", 500, 3500, 100,
>   		 AXP717_ALDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(2)),
> -	AXP_DESC(AXP717, ALDO4, "aldo4", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO4, "aldo4", "aldoin", 500, 3500, 100,
>   		 AXP717_ALDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(3)),
> -	AXP_DESC(AXP717, BLDO1, "bldo1", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO1, "bldo1", "bldoin", 500, 3500, 100,
>   		 AXP717_BLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(4)),
> -	AXP_DESC(AXP717, BLDO2, "bldo2", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO2, "bldo2", "bldoin", 500, 3500, 100,
>   		 AXP717_BLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(5)),
> -	AXP_DESC(AXP717, BLDO3, "bldo3", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO3, "bldo3", "bldoin", 500, 3500, 100,
>   		 AXP717_BLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(6)),
> -	AXP_DESC(AXP717, BLDO4, "bldo4", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO4, "bldo4", "bldoin", 500, 3500, 100,
>   		 AXP717_BLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO0_OUTPUT_CONTROL, BIT(7)),
> -	AXP_DESC(AXP717, CLDO1, "cldo1", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO1, "cldo1", "cldoin", 500, 3500, 100,
>   		 AXP717_CLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO1_OUTPUT_CONTROL, BIT(0)),
> -	AXP_DESC(AXP717, CLDO2, "cldo2", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO2, "cldo2", "cldoin", 500, 3500, 100,
>   		 AXP717_CLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO1_OUTPUT_CONTROL, BIT(1)),
> -	AXP_DESC(AXP717, CLDO3, "cldo3", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO3, "cldo3", "cldoin", 500, 3500, 100,
>   		 AXP717_CLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO1_OUTPUT_CONTROL, BIT(2)),
> -	AXP_DESC(AXP717, CLDO4, "cldo4", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO4, "cldo4", "cldoin", 500, 3500, 100,
>   		 AXP717_CLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
>   		 AXP717_LDO1_OUTPUT_CONTROL, BIT(3)),
>   	AXP_DESC(AXP717, CPUSLDO, "cpusldo", "vin1", 500, 1400, 50,

