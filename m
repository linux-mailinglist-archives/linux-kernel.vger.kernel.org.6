Return-Path: <linux-kernel+bounces-448888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741189F46D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B428A16C60C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5F1DDC05;
	Tue, 17 Dec 2024 09:05:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D91D2785
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426340; cv=none; b=OYo/oAGMtCQZEMrLacoKl6uSYqJK+UGVCYkZN431zoJZyRCHd+mboaRG8miSPAWiUqLY98j4t2XhRQcDwrBt935oXksCs/VT6QSF9VD63eDnLbwo2xP8X3tLiMkdWvWovvFfJ0fP3nchtkc8Q0lhDcw3FQIrDs/AmyPe+ccX6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426340; c=relaxed/simple;
	bh=FiuefCLrjCYPT5X7kTOJ33l/s0WS0fZp6a08VirDFcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFuDzLfZlg8qRed5ZuxsGn7LbAD3PA3k6IlR35lrFErfkC6W+vQxWIff/2l2UU74AQlC5PUgpqb6m30pewZ8b2Aw9uHjHIwenhiv1z7bW5lsqPNovm4CnRRpl21hvZyLLt90ZNx2tAP40dEuol9kzkL+G/KYGGkIKo47BggQGyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tNTWJ-0005kx-Ot; Tue, 17 Dec 2024 10:05:35 +0100
Message-ID: <d796d333-5686-455c-a414-8738f9025b7d@pengutronix.de>
Date: Tue, 17 Dec 2024 10:05:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: pca9450: use dev_err_probe on errors
 requesting resources
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20241217-pca9450-dev_err_probe-v1-1-04046092a92d@pengutronix.de>
 <7b91ef22-2996-4e2e-b791-0cfcd4ce1fdd@kontron.de>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <7b91ef22-2996-4e2e-b791-0cfcd4ce1fdd@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Frieder,

On 17.12.24 10:04, Frieder Schrempf wrote:
> On 17.12.24 9:59 AM, Ahmad Fatoum wrote:
>> Probe functions requesting resources may return -EPROBE_DEFER to
>> the driver core to instruct it to retry probe at a later time.
>> This is not unusual and printing an error message unconditionally
>> is just confusing to users:
>>
>>   nxp-pca9450 0-0025: Failed to register regulator(buck1): -517
>>
>> Using dev_err_probe remedies this:
>>
>> The error message will only be shown if the error code is not
>> -EPROBE_DEFER and if it is, the deferral reason is saved for display
>> at a later time.
>>
>> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> There is a similar change already queued in next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/regulator/pca9450-regulator.c?id=0f5c601098bd3c9cdfea3e01aacdd9d0c4010ea7

Thanks for pointing this out.

Sorry for the noise!
Ahmad

> 
>> ---
>>  drivers/regulator/pca9450-regulator.c | 25 +++++++++++--------------
>>  1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
>> index 9714afe347dcc0205b40243252638dff5f9298ad..8f5ba59f7fe52bee1e467a3e6adf81a6a5476221 100644
>> --- a/drivers/regulator/pca9450-regulator.c
>> +++ b/drivers/regulator/pca9450-regulator.c
>> @@ -953,13 +953,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>>  		config.dev = pca9450->dev;
>>  
>>  		rdev = devm_regulator_register(pca9450->dev, desc, &config);
>> -		if (IS_ERR(rdev)) {
>> -			ret = PTR_ERR(rdev);
>> -			dev_err(pca9450->dev,
>> -				"Failed to register regulator(%s): %d\n",
>> -				desc->name, ret);
>> -			return ret;
>> -		}
>> +		if (IS_ERR(rdev))
>> +			return dev_err_probe(pca9450->dev, PTR_ERR(rdev),
>> +				"Failed to register regulator(%s)\n",
>> +				desc->name);
>>  	}
>>  
>>  	if (pca9450->irq) {
>> @@ -968,9 +965,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>>  						(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
>>  						"pca9450-irq", pca9450);
>>  		if (ret != 0) {
>> -			dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
>> -				pca9450->irq);
>> -			return ret;
>> +			return dev_err_probe(pca9450->dev, ret,
>> +					     "Failed to request IRQ: %d\n",
>> +					     pca9450->irq);
>>  		}
>>  		/* Unmask all interrupt except PWRON/WDOG/RSVD */
>>  		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
>> @@ -1022,10 +1019,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>>  	 */
>>  	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
>>  
>> -	if (IS_ERR(pca9450->sd_vsel_gpio)) {
>> -		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
>> -		return PTR_ERR(pca9450->sd_vsel_gpio);
>> -	}
>> +	if (IS_ERR(pca9450->sd_vsel_gpio))
>> +		return dev_err_probe(&i2c->dev,
>> +				     PTR_ERR(pca9450->sd_vsel_gpio),
>> +				     "Failed to get SD_VSEL GPIO\n");
>>  
>>  	dev_info(&i2c->dev, "%s probed.\n",
>>  		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
>>
>> ---
>> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
>> change-id: 20241217-pca9450-dev_err_probe-778149cae5ee
>>
>> Best regards,
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

