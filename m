Return-Path: <linux-kernel+bounces-561426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C53EA61190
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1844D7AAD33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D11FECCC;
	Fri, 14 Mar 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="QXiEtGKH"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C841CD3F;
	Fri, 14 Mar 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955957; cv=none; b=OnMotUg8QS7pNbYh4+v8PvxN1MxqD2jZHxoo7FIjZZcLTcWLTzyfeF3PsZexYPxItFOvnJIUpzcBuce1ooWapIsjkKqx6Wv7ZkaNep4SPBjTtpxVLa8hoRhShwie5dmTqoEbKggQ255YHu1fhNV4HmoUpnijEIxgYHpfKrzw3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955957; c=relaxed/simple;
	bh=4jl3e9EHT+yhIQb6PgOP5J44alp/hc+GJm+3YkCowcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEdOu7+A2R1hR+k9rfbzzc5KywNY1XWnUiBlckBbsOJsdsNX2OmKzkknc5k+AoJLHey+gQAoTXbJYAhRmxOgoLpxdlpcSefzPXZ33UcC6xFS2WbJyt9VLxWj1Qy0Fe011AZqN6UQTdeG6OeuWVkqSIRZAT49AFoiw7qXa47JGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=QXiEtGKH; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id E0AD82FC0189;
	Fri, 14 Mar 2025 13:39:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741955951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNCQYv/yky3scAkSjC2rOHmTyqBkGE8fEXeEwUML4KQ=;
	b=QXiEtGKH+Yzi+OeV8OYHflVBcX9j0Xsi5voUGDCLKn8867hdSOqJv1Zn3RL0zFv6S7P7qB
	1fc8gkwnBOHMx7QcMEH55u3cblrQgDZg0L9RDWsPfWjdLDUW5rpf9SjuPlKpd1mAaDtNxP
	pW00cIDwQ0N3EmBZ6J/JlypE5lbb0XY=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <49ceb1f4-93b1-47ed-a87b-b936fee1b371@tuxedocomputers.com>
Date: Fri, 14 Mar 2025 13:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN
 via hwmon
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20250306132639.642369-1-wse@tuxedocomputers.com>
 <70633701-31d2-c2ab-f4f4-043dd186f485@linux.intel.com>
 <75556900-5fe3-4083-b81b-240994e4f8e0@tuxedocomputers.com>
 <4344644a-582b-aee6-7eef-8afd3c0ee16f@linux.intel.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <4344644a-582b-aee6-7eef-8afd3c0ee16f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, resend, mail client did html message by accident

Hi Ilpo,

Am 14.03.25 um 11:05 schrieb Ilpo Järvinen:

[snip]
>>>> +#define TUXI_MAX_FAN_COUNT 16           /* If this is increased, new
>>>> lines must
>>>> +					 * be added to hwmcinfo below.
>>>> +					 */
>>> Please use static_assert() to actually enforce what the comment says.
>> I actually struggle to come up with how to do this for the array length
>> because of the macro and the pointer
>>
>> `static_assert(TUXI_MAX_FAN_COUNT <= ARRAY_SIZE(hwmcinfo[0]->config));`
>> doesn't work
> Oh, I see. Yeah, there isn't way to get it to work in C.

ok

[snip]

>>> Add linux/limits.h include.
>> ack
>>
>> It is included in kernel.h, so I read from this that kernel.h should not be
>> used but the parts of it directly?
> kernel.h used to contain way too much of random things. Some people are
> slowly working towards splitting that up.
>
> So we try to include what is used directly, not rely on includes through
> some other include, and especially not through kernel.h.
ok
>>>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;
>>> Is the math wrong, as you do retval - TUXI_FW_TEMP_OFFSET before
>>> multiplying?
>> No, retval is in 10th of °K (but the last number is always 0) so is
>> TUXI_FW_TEMP_OFFSET which is there to convert it to 10th of °C, the * 100 is
>> then to bring it in line with hwmon wanting to output milli degrees
> So is result of S32_MAX correct when retval is 21474837?
>
> (21474837-2730)*100
> 2147210700
> 2^31-1
> 2147483647
>
> 2147210700 would have been representable but the upper bound is
> still applied (the value might be large enough to not have practical
> significance but to me the code looks still illogical why it applies the
> bound prematurely).
Yeah my though was: this check is only here to catch the firmware doing some 
crazy stuff and sending highly unrealistic values, so gifting a small bit of the 
available range away doesn't matter
> I see you already sent another version, it would have been prudent to wait
> a bit longer as you contested some of the comments so you could have seen
> my replies before sending the next version.
I'm sorry. I just wanted to show that I'm iterating as I wait for the reply if 
the design with the periodic safeguard is acceptable. If that's gets rejected 
this driver must be rewritten anyway.
>>> Shouldn't it be like this:
>>>
>>> 		retval -= TUXI_FW_TEMP_OFFSET;
>>> 		*val = min(retval * 100, (unsigned long long)S32_MAX);
>> As retval is unsigned this would not work with (theoretical) negative °C.
> So your code relies on implicit type conversion in this: (retval -
> TUXI_FW_TEMP_OFFSET) ?

I can add an explicit cast, np.

[snip]

>>>> +	}
>>>> +	if (temp >= temp_high)
>>>> +		ret = i;
> Now that I reread things, is this also incorrect, as "i" is at the
> terminator entry at this point?

Yes that's intentional, the 3 entries in the array open up 4 ranges:

lower then 1st entry i=0, between 1st and 2nd entry i=1, 2nd and 3rd i=2, higher 
then 3rd i=3 (the value that terminates the for loop)

[snip]

>>>> +
>>>> +		temp = retval > S32_MAX / 100 ?
>>>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;
>>> Same math issue comment as above.
>>>
>>> Why is the read+conversion code duplicated into two places?
>> because here it is with special error handling and didn't thought about an own
>> function for a defacto 2 liner
> A function that does read+conversion would be 6-8 lines with the error
> handling.

I can add it.

[snip]

Thanks for the code review again.


Last but not least: As already mentioned, I still wonder if the design with the 
periodic safeguard is ok or not or?

Best regards,

Werner


