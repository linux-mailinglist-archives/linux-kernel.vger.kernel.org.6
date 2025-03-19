Return-Path: <linux-kernel+bounces-567932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81581A68C12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB718839D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CECE253329;
	Wed, 19 Mar 2025 11:46:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AE2528F1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384786; cv=none; b=pWVivRPj2Ot0fLx82yYZw5KXPGJYgt3EJ5QKWA6/OKcsz6/doj7HfAoqLIjLRdeeVFv/v2L6cww2XkNWMGTk9dmZIKo7UnAxBNn6MDbkyUpOoBmqeVoK47RH21K4feK4H+/cr0syN9aLOUG1/uqWxNYxruIgYYHA2RpH/vR1OQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384786; c=relaxed/simple;
	bh=4kv1BD53si5749/BbYctM2eZ7xVWPTABVbnysV1gQNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/V4bjU3YDCG7V04ItRUtduNdw7wsehYFn9GspBQOvBaUOVq2ynMYmVz45uDNAnTus2DhLwp8Q9ANIeYS+V2uYv+y3hu73xMcqpEdaVxX/tf0riERKYUTrd/Ja2tWHXAREpuPn77cgEqftnu84V4EMjw925it38BHgUpDsjK4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED578113E;
	Wed, 19 Mar 2025 04:46:31 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04C193F673;
	Wed, 19 Mar 2025 04:46:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:46:19 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: axp20x: AXP717: dcdc4 doesn't have delay
Message-ID: <20250319114619.59cf9cad@donnerap.manchester.arm.com>
In-Reply-To: <20250318205147.42850-1-simons.philippe@gmail.com>
References: <20250318205147.42850-1-simons.philippe@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 21:51:47 +0100
Philippe Simons <simons.philippe@gmail.com> wrote:

Hi,

> According to AXP717 user manual, DCDC4 doesn't have a ramp delay like
> DCDC1/2/3 do.

Yes, all the AXP717 manuals I scanned only mention DCDC1/2/3 for DVM mode,
and DCDC4 has bit 7 (controlling DVM on the other DCDCs) marked as
reserved.

> Remove it from the description and cleanup the macros.
> 
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>

Changes look alright, we indeed don't need AXP_DESC_DELAY anymore.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/regulator/axp20x-regulator.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index dca99cfb7cbb..da891415efc0 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -371,8 +371,8 @@
>  		.ops		= &axp20x_ops,					\
>  	}
>  
> -#define AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
> -		 _vmask, _ereg, _emask, _ramp_delay) 				\
> +#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
> +		 _vmask, _ereg, _emask)						\
>  	[_family##_##_id] = {							\
>  		.name		= (_match),					\
>  		.supply_name	= (_supply),					\
> @@ -388,15 +388,9 @@
>  		.vsel_mask	= (_vmask),					\
>  		.enable_reg	= (_ereg),					\
>  		.enable_mask	= (_emask),					\
> -		.ramp_delay = (_ramp_delay),					\
>  		.ops		= &axp20x_ops,					\
>  	}
>  
> -#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
> -		 _vmask, _ereg, _emask) 					\
> -	AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
> -		 _vmask, _ereg, _emask, 0)
> -
>  #define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)		\
>  	[_family##_##_id] = {							\
>  		.name		= (_match),					\
> @@ -805,9 +799,9 @@ static const struct regulator_desc axp717_regulators[] = {
>  			axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
>  			AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
>  			AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
> -	AXP_DESC_DELAY(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
> +	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
>  		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3), 6400),
> +		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
>  	AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
>  		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),


