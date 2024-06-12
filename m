Return-Path: <linux-kernel+bounces-211760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D290567F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6031F2181F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A18181CF4;
	Wed, 12 Jun 2024 15:07:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83123181BB9;
	Wed, 12 Jun 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204873; cv=none; b=W59SgTh4YSwgTy+2FCaOroQk12m8MriCOSlsAxgexj8PSYz8nQcsRCvVChG1+ZUZQGTm/6NIM9aQGaZdsqTL/w8cgVEmIgxdqM2IeDjMzscF+zBrhpAxxgdpfeOLWBNLg917uFMX/1ud4d8aZCiB2Fm8PW7/+IkaCN3jvr5uFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204873; c=relaxed/simple;
	bh=rL+EF5Q6byjjdVzupCcKEnVCSO3NlsLUiqtz55TMyhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvAVsI2/7psw/HVDq8tnZqGsmGsYOlyWHAJNEGFmZEn+2niGAWstyHF5N205+agLohXIIYve7OPeuMUQaeFEiIfPtLsDoArbRRWCJrV0gUwfeGf6eRvTukV6osI9i6qvPmp5iYa6zb/To0WbvmjTt0NyIf6RKAsi7dxW2Z7cw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892411042;
	Wed, 12 Jun 2024 08:08:14 -0700 (PDT)
Received: from [10.1.29.46] (e110479.arm.com [10.1.29.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DECC3F73B;
	Wed, 12 Jun 2024 08:07:47 -0700 (PDT)
Message-ID: <56aef347-7582-497e-be02-d82eda7b3528@arm.com>
Date: Wed, 12 Jun 2024 16:07:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
To: Lee Jones <lee@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Ryan Walklin <ryan@testtoast.com>,
 Chris Morgan <macroalpha82@gmail.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-2-andre.przywara@arm.com>
 <20240502093907.GM5338@google.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240502093907.GM5338@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lee,

On 02/05/2024 10:39, Lee Jones wrote:
> On Thu, 18 Apr 2024, Andre Przywara wrote:
> 
>> While we list the "IRQ status *and acknowledge*" registers as volatile,
>> they are missing from the writable range array, so acknowledging any
>> interrupts was met with an -EIO error.
>>
>> Add the five registers that hold those bits to the writable array.
>>
>> Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
>> Reported-by: Chris Morgan <macromorgan@hotmail.com>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/mfd/axp20x.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Acked-by: Lee Jones <lee@kernel.org>

Can you please take just this patch as a fix for 6.10? This fixes the 
power key operation.
This applies cleanly on top of v6.10-rc3, so there is no need for any 
extra immutable branch or coordination with regulator.
(The same is true independently for patch 2/5, on the regulator side).

Cheers,
Andre

> 
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 48ce6ea693cea..d8ad4e120d379 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -210,6 +210,7 @@ static const struct regmap_access_table axp313a_volatile_table = {
>>   
>>   static const struct regmap_range axp717_writeable_ranges[] = {
>>   	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
>> +	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
>>   	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
>>   };
>>   
>> -- 
>> 2.35.8
>>
> 

