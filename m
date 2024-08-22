Return-Path: <linux-kernel+bounces-298036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A081595C0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F221C20E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD61D1F43;
	Thu, 22 Aug 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hiTuIV5U"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871717555
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366566; cv=none; b=OB4f+sZfvLs3BGSZzppJz4THjC3jWC/qzouk0L7Y270yG3GVTjJHl9/2kfu0zkAperm87vDzZ8bUSxQfPfilgMCgLk6fBmE/OaYQrk+PnFFscc/dBaznxLDagd3SmEY+okRoXkmt5z8NaLNTT9ajoFua8H+fAiKIVWHKPG+UH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366566; c=relaxed/simple;
	bh=ec7BD7zlqlSTYQdqBrt92Xq3wnGqdl9qts/tYxkJbGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RvV1yjd1GyN5ytcSRUF4h3cOJdAVX7SYWeUqvtFlM8UNi31eAu1XCLKIRs0McYeBt+OwzKEjAF6oZetZP9drrLVTPkmzEG5L6pEvu7Mi9oVIjM/CZeYoQF2yBDmOt/krMHc9SbKxE3d2dj/PgXnm8kH3urNMlAOSibRCO5Ake4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hiTuIV5U; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MMgR01028654;
	Thu, 22 Aug 2024 17:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724366547;
	bh=FshhZTDnQBKG5aOfv5hwgtx/UsN9ux0MY7vw1oAtIvk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hiTuIV5UoF7g4nZR4s96EMDCb54vB/YChU54IPYwDInVIXVJpFLvlcdnfnSrJo/W8
	 YaWM3TsDmlZmUtco1axKOzZGIcb7HyTJ3rgkXY7FR9tijbxmv/coBmMtAu75G0Ulb0
	 nReYpQaHJ6AHeyyUvcrpYE2MgMWBSu6wgkZGD9MY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MMgRwx008337
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 17:42:27 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 17:42:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 17:42:26 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MMgQaH117500;
	Thu, 22 Aug 2024 17:42:26 -0500
Message-ID: <9c4f2bb2-6a72-438f-8370-9c71ce80f41e@ti.com>
Date: Thu, 22 Aug 2024 17:42:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
To: Nishanth Menon <nm@ti.com>, Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
References: <20240819204352.1423727-1-jm@ti.com>
 <ZsTHj/Fyffi2LxIu@hu-bjorande-lv.qualcomm.com>
 <20240821110940.s5ubbcozk2bouklh@chaps>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240821110940.s5ubbcozk2bouklh@chaps>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Nishanth,

Apologies for the late reply,

On 8/21/24 6:09 AM, Nishanth Menon wrote:
> On 09:42-20240820, Bjorn Andersson wrote:
>> On Mon, Aug 19, 2024 at 03:43:52PM -0500, Judith Mendez wrote:
>>> SK-AM62A-LP is a device targeting automotive front-camera applications
>>> among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
>>> to power the SoC and various other peripherals on the board [1].
>>>
>>> MMCSD requires the PMIC to be setup correctly before setting the bus
>>> pins to 1.8V using the TPS6594 driver interfaced over i2c.
>>>
>>> Currently, the following could be seen when booting the am62ax platform:
>>>
>>> "platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
>>> "vdd_mmc1: disabling"
>>
>> Is this the regulator framework disabling the "unused" vdd_mmc1 while
>> you still have a probe deferred client?
>>
>> That's not right.
> 
> I think context of the full log might be missing, hence misleading - but
> if this is correct, regulator framework might have a problem as well -
> it does not change the fact that we will need regulator driver to
> support switch from 3.3v to 1.8v to enable UHS (which is another
> topic as well - do not trust the bootloader either for the default
> voltage enabled in the system).
> 
> Judith: This is why providing links to previous versions of patches AND
> providing links to the full before and after logs in the diffstat
> section helps reviewers - please do that in the next revision.

Understood, will fix for v2.

> 
>>
>>>
>>> and a failure to boot the SK-AM62A-LP.
>>>
>>> One solution is to use initramfs [2], but using initramfs increases the
>>> boot time for this automotive solution which requires faster boot time
>>> parameters.
>>>
>>> Another solution is to change MFD_TPS6594_I2C to built-in, that way the
>>> PMIC is setup and the regulators are ready before MMCSD switches to UHS
>>> mode, this is the preferred solution since it does not increase boot time
>>> like the initramfs solution does.
> 
> What is the adder in cost? bloat-o-meter report summary should have
> been part of commits that increase vmlinux

Will include in v2.

> 
>>>
>>> [1] https://www.ti.com/lit/zip/sprr459
>>> [2] https://lore.kernel.org/linux-devicetree/5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org/
>>> Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>>   arch/arm64/configs/defconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 7d32fca649965..61f767246d3a5 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -756,7 +756,7 @@ CONFIG_RZ_MTU3=y
>>>   CONFIG_MFD_TI_AM335X_TSCADC=m
>>>   CONFIG_MFD_TI_LP873X=m
>>>   CONFIG_MFD_TPS65219=y
>>> -CONFIG_MFD_TPS6594_I2C=m
>>> +CONFIG_MFD_TPS6594_I2C=y
>>
>> These things should work with =m, and then you can make them =y in your
>> product config to avoid the probe deferral.
> 
> I think this is inline with the discussion with Krystoff on the topic as
> well
> 
> 
> Judith: you just need the regulator, for sd/mmc to work. Why is there
> half a dozen unrelated stuff coming with it [1] report from
> bloat-o-meter? Please fix the driver dependencies before adding
> un-necessary stuff to the kernel Image file.
> 
> [1] https://gist.github.com/nmenon/0caff032a430bbf649ad1107e6f12f9a

Ok, will check this out, thanks for reviewing. (:

~ Judith

> 


