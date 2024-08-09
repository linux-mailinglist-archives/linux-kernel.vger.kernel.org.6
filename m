Return-Path: <linux-kernel+bounces-281580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E72394D862
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3151F232B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3E1684AB;
	Fri,  9 Aug 2024 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b="c4lOIJ2S"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23099225D6;
	Fri,  9 Aug 2024 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238212; cv=none; b=s2JJfQKfqdk526/6NE02BR3dNgCIyMpRk5/KHjxESJt7y+7JyaiwdxPokO2ORHPZ5xcPnA/RTqKyONblS99lBvixlG96IJ/EYpPweEUWXuPnGPEvk7ldkInYZEoQ8DKWfX2akwv3tQhboDzeoTPBrAnV5eYLB8msY4gAgEwL/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238212; c=relaxed/simple;
	bh=3sHnrlgBst2vs2zoVMb7+BfNAceWGuziTRBozcPZflY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xpsr2Yuqz5JHQc37Fr04TJB5ecbVl9s++j6FIoQwV8ntknp+0sHjVICH964DM3XAzto4jNEFzaiNCLc/ZjcWIIBidxs43ocseIDML5JvkijLogXxNN47igZ5jRwa9ag+S+AKIBtRxZ/wQftTG+8WksS1EBjlOJORLv3ZJKA6iGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de; spf=pass smtp.mailfrom=matthias-fetzer.de; dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b=c4lOIJ2S; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-fetzer.de
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4Wgc4J4dDyz8XLf;
	Fri,  9 Aug 2024 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matthias-fetzer.de;
	s=key2; t=1723237792;
	bh=3sHnrlgBst2vs2zoVMb7+BfNAceWGuziTRBozcPZflY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c4lOIJ2Simr6CKegbFFTHjlSveZMb9AMriy+Fl7yKXe3dC9mG3PFHJoWitGUWpWTq
	 KJtR44YjNC3IaTf42GHyYadZ0ytxVGYD1SXqV0sPAnE+QLvTsekOeD85U/J/gXzHSi
	 fNUs4QJ2ay/QBV9UL59cRPCfIil4ofi7Jcp/3N7B9Z8KhCsr/q9JdHjZkZhF6IaT8g
	 6aYkl6+KGBWdJQhbyXTDoRvTbkiNsaaytdB07uIrDnkP7fLNkx3eQVvaBKVpNJqz2E
	 i57uvBp/vfe0vOYMl6WeHuqwEvF81wV3JdEFIaZOJ/NQLvZYnbluHC+/q3wNPTo+3A
	 lqpZqytFQNd6Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4Wgc4J3snyz8Zs6;
	Fri,  9 Aug 2024 21:09:52 +0000 (UTC)
Received: from mxf9a3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Wgc0c4D5Sz8sZf;
	Fri,  9 Aug 2024 23:06:40 +0200 (CEST)
Received: from [IPV6:2001:9e8:1a76:2600:c5f1:566f:8693:31b4] (unknown [IPv6:2001:9e8:1a76:2600:c5f1:566f:8693:31b4])
	by mxf9a3.netcup.net (Postfix) with ESMTPSA id 67338402D7;
	Fri,  9 Aug 2024 23:06:35 +0200 (CEST)
Authentication-Results: mxf9a3;
        spf=pass (sender IP is 2001:9e8:1a76:2600:c5f1:566f:8693:31b4) smtp.mailfrom=kontakt@matthias-fetzer.de smtp.helo=[IPV6:2001:9e8:1a76:2600:c5f1:566f:8693:31b4]
Received-SPF: pass (mxf9a3: connection is authenticated)
Message-ID: <5a22f1ff-44e9-4e1a-bdbe-cc168f718693@matthias-fetzer.de>
Date: Fri, 9 Aug 2024 23:06:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan
 support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240714165054.2261305-1-kontakt@matthias-fetzer.de>
 <ee9624b2-5b24-9976-4746-c622fcba21a6@linux.intel.com>
Content-Language: en-US, de-DE
From: Matthias Fetzer <kontakt@matthias-fetzer.de>
In-Reply-To: <ee9624b2-5b24-9976-4746-c622fcba21a6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <172323759583.12787.8869904824999468791@mxf9a3.netcup.net>
X-Rspamd-Queue-Id: 67338402D7
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: B0rRHBtvFxq2Ah61PT2285jdKpD16c032Jkvc3Mxdm9bZH6qL+v1T8eQ


Thanks for the review!

Am 08.08.24 um 15:14 schrieb Ilpo Järvinen:
> On Sun, 14 Jul 2024, Matthias Fetzer wrote:
> 
>> Fan control on the E531 is done using the ACPI methods FANG and
>> FANW. The correct parameters and register values were found by
>> analyzing EC firmware as well as DSDT. This has been tested on
>> my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).
>>
>> Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
>> ---
>>   drivers/platform/x86/thinkpad_acpi.c | 159 +++++++++++++++++++++++++++
>>   1 file changed, 159 insertions(+)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index 397b409064c9..a171a2b39ac9 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -7751,6 +7751,28 @@ static struct ibm_struct volume_driver_data = {
>>    * 	EC 0x2f (HFSP) might be available *for reading*, but do not use
>>    * 	it for writing.
>>    *
>> + * TPACPI_FAN_RD_ACPI_FANG:
>> + * 	ACPI FANG method: returns fan control register
>> + *
>> + *	Takes one parameter which is 0x8100 plus the offset to EC memory
>> + *	address 0xf500 and returns the byte at this address.
>> + *
>> + *	0xf500:
>> + *		When the value is less than 9 automatic mode is enabled
>> + *	0xf502:
>> + *		Contains the current fan speed from 0-100%
>> + *	0xf504:
>> + *		Bit 7 has to be set in order to enable manual control by
>> + *		writing a value >= 9 to 0xf500
>> + *
>> + * TPACPI_FAN_WR_ACPI_FANW:
>> + * 	ACPI FANG method: sets fan control registers
>> + *
>> + * 	Takes 0x8100 plus the offset to EC memory address 0xf500 and the
>> + * 	value to be written there as parameters.
>> + *
>> + *	see TPACPI_FAN_RD_ACPI_FANG
>> + *
>>    * TPACPI_FAN_WR_TPEC:
>>    * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode
>>    * 	Supported on almost all ThinkPads
>> @@ -7884,6 +7906,7 @@ enum {					/* Fan control constants */
>>   enum fan_status_access_mode {
>>   	TPACPI_FAN_NONE = 0,		/* No fan status or control */
>>   	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
>> +	TPACPI_FAN_RD_ACPI_FANG,	/* Use ACPI FANG */
>>   	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
>>   	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga gen2 etc.) */
>>   };
>> @@ -7891,6 +7914,7 @@ enum fan_status_access_mode {
>>   enum fan_control_access_mode {
>>   	TPACPI_FAN_WR_NONE = 0,		/* No fan control */
>>   	TPACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
>> +	TPACPI_FAN_WR_ACPI_FANW,	/* Use ACPI FANW */
>>   	TPACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
>>   	TPACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
>>   };
>> @@ -7924,9 +7948,13 @@ TPACPI_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
>>   TPACPI_HANDLE(gfan, ec, "GFAN",	/* 570 */
>>   	   "\\FSPD",		/* 600e/x, 770e, 770x */
>>   	   );			/* all others */
>> +TPACPI_HANDLE(fang, ec, "FANG",	/* E531 */
>> +	   );			/* all others */
>>   TPACPI_HANDLE(sfan, ec, "SFAN",	/* 570 */
>>   	   "JFNS",		/* 770x-JL */
>>   	   );			/* all others */
>> +TPACPI_HANDLE(fanw, ec, "FANW",	/* E531 */
>> +	   );			/* all others */
>>   
>>   /*
>>    * Unitialized HFSP quirk: ACPI DSDT and EC fail to initialize the
>> @@ -8033,6 +8061,23 @@ static int fan_get_status(u8 *status)
>>   
>>   		break;
>>   	}
>> +	case TPACPI_FAN_RD_ACPI_FANG: {
>> +		/* E531 */
>> +		int mode, speed;
>> +
>> +		if (unlikely(!acpi_evalf(fang_handle, &mode, NULL, "dd", 0x8100)))
>> +			return -EIO;
>> +		if (unlikely(!acpi_evalf(fang_handle, &speed, NULL, "dd", 0x8102)))
>> +			return -EIO;
>> +
>> +		if (likely(status)) {
>> +			*status = speed * 7 / 100;
>> +			if (mode < 9)
>> +				*status |= TP_EC_FAN_AUTO;
>> +		}
>> +
>> +		break;
>> +	}
>>   	case TPACPI_FAN_RD_TPEC:
>>   		/* all except 570, 600e/x, 770e, 770x */
>>   		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
>> @@ -8147,6 +8192,17 @@ static int fan2_get_speed(unsigned int *speed)
>>   		if (speed)
>>   			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
>>   		break;
>> +	case TPACPI_FAN_RD_ACPI_FANG: {
>> +		/* E531 */
>> +		int speed_tmp;
>> +
>> +		if (unlikely(!acpi_evalf(fang_handle, &speed_tmp, NULL, "dd", 0x8102)))
>> +			return -EIO;
>> +
>> +		if (likely(speed))
>> +			*speed =  speed_tmp * 65535 / 100;
>> +		break;
>> +	}
>>   
>>   	default:
>>   		return -ENXIO;
>> @@ -8157,6 +8213,7 @@ static int fan2_get_speed(unsigned int *speed)
>>   
>>   static int fan_set_level(int level)
>>   {
>> +	int rc;
>>   	if (!fan_control_allowed)
>>   		return -EPERM;
>>   
>> @@ -8206,6 +8263,36 @@ static int fan_set_level(int level)
>>   			tp_features.fan_ctrl_status_undef = 0;
>>   		break;
>>   
>> +	case TPACPI_FAN_WR_ACPI_FANW:
>> +		if ((!(level & TP_EC_FAN_AUTO) &&
>> +		    ((level < 0) || (level > 7))) ||
>> +		    (level & TP_EC_FAN_FULLSPEED))
>> +			return -EINVAL;
> 
> I'd split this into two to make it more readable:
> 
> 		if (!(level & TP_EC_FAN_AUTO) && (level < 0 || level > 7))
> 			return -EINVAL;
> 		if (level & TP_EC_FAN_FULLSPEED)
> 			return -EINVAL;

This is much better, thanks.

> 
> I'm not sure if -EINVAL is really the right code to return though in these
> cases.
> 

I thought that since those are invalid values/parameters the return code 
of -EINVAL
would be a good choice. What do you suggest to use instead?

>> +		if (level & TP_EC_FAN_AUTO) {
>> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {
> 
> Curiously enough, the comment above doesn't cover offset 0xf506 but the
> comment mentions 0xf504 that is never touched anywhere? Is that a typo?
> 

Good catch! This indeed is a typo.


