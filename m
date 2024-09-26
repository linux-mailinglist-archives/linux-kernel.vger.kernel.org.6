Return-Path: <linux-kernel+bounces-340994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999E987A01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0472835B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E48168491;
	Thu, 26 Sep 2024 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZJjzu6FE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A317F4F7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381457; cv=none; b=mkwgMOa8I6bkcr3mpMDsB1d/Enh9jBjhGO+2oyiCJ9/gcOzWWkY6JOa5LvEC8fYJQO5SucLufufSvHSKTZvlbmNgD/8RD9RcYpWMQfW0vxGaW4l5s8YbyWiXEoB+7MPirZSx/sGm8iRRAz766B6nwhruAIMKeHyvarg5vllnwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381457; c=relaxed/simple;
	bh=Oew1F34mtV7x31gAePkACrpqznQNjr9U92ItRlAvpLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UR2RN7/em+hOKjUqueeGnzx7Tl8j76Te9/jVrXhyI9WgMfB7AyCpHsu+8RdwnSmmdIATWwjGlIpaKyhbWqfqOqnNQWRfimRlWXKGQ12yjxpDS6x2uiN9MEvXIvdti26Gmg/WdYZ6eWGLqmq1GcmfmabN73btqTUkInIukXFfj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZJjzu6FE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48QKAdAV036359;
	Thu, 26 Sep 2024 15:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727381439;
	bh=CWXzNSwJGDLIly+lgoLVLkiz2czDebFNAK4Ataxvfkw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZJjzu6FE6bM1eFcFBBCX2/hJcZPk+N2mVyGnLn9nmQOL9wfJUsOuf+SSdeKZ7Lcbl
	 3IHrpeF6WmjLftT+D0G0oxZ2LmAjP2qzo8Jd2KbB0qo+8UewaOZ6VkaVZkTghREool
	 JRevra2oxiL7DK9/BFeoeMVXXtP3xItmwrxsJ3WM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48QKAcxP075743
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 15:10:38 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 15:10:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 15:10:38 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48QKAc8e077102;
	Thu, 26 Sep 2024 15:10:38 -0500
Message-ID: <8119c948-5609-4f61-bf49-aaaf82cd9597@ti.com>
Date: Thu, 26 Sep 2024 15:10:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
To: Nishanth Menon <nm@ti.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
        Bjorn
 Andersson <quic_bjorande@quicinc.com>
References: <20240819204352.1423727-1-jm@ti.com>
 <ZsTHj/Fyffi2LxIu@hu-bjorande-lv.qualcomm.com>
 <20240821110940.s5ubbcozk2bouklh@chaps>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240821110940.s5ubbcozk2bouklh@chaps>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nishanth,

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


It seems like TPS6594_I2C driver has a few dependencies:

select MFD_TPS6594
select REGMAP_I2C
select CRC8
depends on I2C

I am not sure what could be done here to change the driver to built
in without increasing the size of the kernel this much:

Total: Before=19064141, After=19108349, chg +0.23%

Please advice.
Thanks,

~ Judith




