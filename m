Return-Path: <linux-kernel+bounces-573650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B97A6DA37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51817A3547
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A125E838;
	Mon, 24 Mar 2025 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p4AZSCXj"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1D4A05;
	Mon, 24 Mar 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819985; cv=none; b=UW/A3i3eBuHACPGeB6kLM0XD9IOE9gDDOlvKc6kf5F5QnH1dEykm9WvG47CuYt3056GaicuRVmOzxClup/OEPP4IMA2lc8rkWiz9/pOmH2ly1Y9lYZYPNClVkKiwyhMbqm5BiSPokiP8VIHVKCxfwdaqyE+yPie/niFVXi+oDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819985; c=relaxed/simple;
	bh=SXi4t8IGwMM8E7u7vKNRAcRZHyXjcVC45S77Pz2BGmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gf9Yqs6VTjq0n7AlLNbevI4JUfY25azPaG5B2FZoQFxw4CR9owX0bw4yln2opdQSbWINaCKkpwRRbuZpXIC9XfuwNsWjlHtIpp3h5tYFiYQ063f+V+e5bpVhoV6l+i4vjeoLxQVbuuXecz0BRQlZA6Vi9kLdfT7u4TDvikfXk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p4AZSCXj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=2AKhH7lBQf0mrFXw0X
	WW2eowYgHNvuDOokg2ff//N/w=; b=p4AZSCXjx9ztzvtxPbnM/zVRok8u+Pjz9x
	6RDJxWj2A9O4ZJcQDkdO0C3tM5ftvnBl/Cd/SEy5tEmiLpfVg+59exkRd2gLBnfM
	ho5VEn/B7iBetuE6ADh7xGC3hb2HWrKEXkmLfCI6Cgi3kC7gHcE77wZj+sJyVDXQ
	DOJ0dSndA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3HAdnUuFneMx5Bg--.21555S2;
	Mon, 24 Mar 2025 20:39:04 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	corbet@lwn.net,
	jdelvare@suse.com,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	wenliang202407@163.com
Subject: Re: [PATCH v5 2/2] hwmon:(ina238)Add support for SQ52206
Date: Mon, 24 Mar 2025 08:38:52 -0400
Message-Id: <20250324123852.4120-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <801599a6-81d9-4e06-8fc6-e959132eef24@roeck-us.net>
References: <801599a6-81d9-4e06-8fc6-e959132eef24@roeck-us.net>
X-CM-TRANSID:_____wD3HAdnUuFneMx5Bg--.21555S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyxCry8Gry3tr1Dur43trb_yoW7Jw4UpF
	W5Ga1DGr48Ary29397Ar4fu3W3Kw1kGrs8KrnYg34rAwn8Zryv9FsrKayF9r93Xwn3ZFW8
	Jay8t3yrCws8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUtnYrUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbBDR4Y02feGKEfqAACst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

At 2025-03-23 01:25:11, "Guenter Roeck" <linux@roeck-us.net> wrote:
>On 3/13/25 01:02, Wenliang Yan wrote:
>> Add support for SQ52206 to the Ina238 driver. Add registers,
>> add calculation formulas, increase compatibility, add
>> compatibility programs for multiple chips.
>> 
>> Signed-off-by: Wenliang Yan <wenliang202407@163.com>
>
>The patch unfortunately combines adding support for a new chip
>with adding the necessary infrastructure. I finally found the time
>to look into this further and split the changes, trying to find out
>what actually changed. Unfortunately there are some problems.
>Some of them are listed below.
>
>This is not a complete review. Also, I'll have to write module tests
>to ensure that support for existing chips is not broken.
>
>>   #define INA238_SHUNT_VOLTAGE_LSB	5 /* 5 uV/lsb */
>>   #define INA238_BUS_VOLTAGE_LSB		3125 /* 3.125 mV/lsb */
>> -#define INA238_DIE_TEMP_LSB		125 /* 125 mC/lsb */
>> +#define INA238_DIE_TEMP_LSB			1250000 /* 125 mC/lsb */
>
>This is not correct. The unit is 10ths of uC.
>

Since the temp_lsb of sq52206 is 7.8125 mC/LSB, in order to express it as an interger, 
my original intention was to use 7.8125*10000 to represent 7.8125 mC/lsb. 
At the same time, for the consistency of different devides, using 125 * 10000 to represent 125mC/lsb.

>> +#define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
>> +#define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
>>   
>... expressed in 10ths of uC.
>
>>   static const struct regmap_config ina238_regmap_config = {
>>   	.max_register = INA238_REGISTERS,
>> @@ -102,7 +114,20 @@ static const struct regmap_config ina238_regmap_config = {
>>   	.val_bits = 16,
>>   };
>>   
>> +enum ina238_ids { ina238, ina237, sq52206 };
>> +
>> +struct ina238_config {
>> +	bool has_power_highest;		/* chip detection power peak */
>> +	bool has_energy;		/* chip detection energy */
>> +	u8 temp_shift;
>> +	u32 power_calculate_factor;		/*fixed parameters for power calculate*/
>> +	u16 config_default;
>> +	int bus_voltage_lsb;    /* uV */
>> +	int temp_lsb;   /* mC */
>
>No, this is not the temperature in mC. It is the temperature in 10th of uC.
>

This is indeed a problem, I need to handle temp_lsb appropriately.

>>   			/* gain of 1 -> LSB / 4 */
>> -			*val = (regval * INA238_SHUNT_VOLTAGE_LSB) /
>> -			       (1000 * (4 - data->gain + 1));
>> +			*val = (regval * INA238_SHUNT_VOLTAGE_LSB) *
>> +					data->gain / (1000 * 4);
>
>The slight benefit of this change is that the divisor is now a constant,
>which may enable some compiler optimization. Still, it is not a necessary
>change and just makes review more difficult.
>

The original formula takes effect only when gain=1 or 4, but sq52206 has a gain=2.
The principle of this formula is the same as before.

>>   		else
>> -			*val = (regval * INA238_BUS_VOLTAGE_LSB) / 1000;
>> +			*val = (regval * data->config->bus_voltage_lsb) / 1000;
>>   		break;
>>   	case hwmon_in_max_alarm:
>>   	case hwmon_in_min_alarm:
>> @@ -225,8 +298,8 @@ static int ina238_write_in(struct device *dev, u32 attr, int channel,
>>   	case 0:
>>   		/* signed value, clamp to max range +/-163 mV */
>>   		regval = clamp_val(val, -163, 163);
>> -		regval = (regval * 1000 * (4 - data->gain + 1)) /
>> -			 INA238_SHUNT_VOLTAGE_LSB;
>> +		regval = (regval * 1000 * 4) /
>> +			 INA238_SHUNT_VOLTAGE_LSB * data->gain;
>
>This change is both unnecessary and wrong: The result is multiplied by data->gain,
>not divided by it. "INA238_SHUNT_VOLTAGE_LSB * data->gain" would have to be in ()
>to yield the same result as the original code. Also, unlike the change above,
>it makes the divisor non-constant. I don't see why this would be beneficial.
>

The original formula takes effect only when gain=1 or 4, but sq52206 has a gain=2.
"INA238_SHUNT_VOLTAGE_LSB * data->gain" should to be in (), I will change.

> > -
> > -               /* Signed, bits 15-4 of register, result in mC */
> > -               *val = ((s16)regval >> 4) * INA238_DIE_TEMP_LSB;
> > +               /* Signed, result in mC */
> > +               *val = div_s64(((s16)regval >> data->config->temp_shift) *
> > +                                               data->config->temp_lsb, 10000);
>
>This will overflow since there is no type cast to s64.
>(32767 >> 4) * 1250000 == 0x98836D30. That means that large positive temperatures
>will be reported as negative temperatures.
>
>I did not have time to validate the rest of the calculation changes,
>but each of them will require close scrutiny. I suspect that most if not all
>of the 64-bit operations can and will overflow because the first parameter is
>not type cast to s64/u64.
>
>Also, the patch should really be
>split into multiple patches:
>- Introduce ina238_config
>- Calculation optimizations such as the ones above, with rationale
>- Introduce support for SQ52206
>to simplify (and even enable) review.
>
>Thanks,
>Guenter

I will add a theoretical analysis to the calculation of each change as soon as possible
to prevent errors and reduce your review difficulty.

I will split this patch to show the changes more clearly in v6.


Thanks,
Wenliang Yan


