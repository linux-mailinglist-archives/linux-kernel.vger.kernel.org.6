Return-Path: <linux-kernel+bounces-204783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276B8FF38C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92841B248B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795081990B0;
	Thu,  6 Jun 2024 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wok4sVe4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2491953BE;
	Thu,  6 Jun 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694264; cv=none; b=D23c3cj4I6/+5wG9OUwv79jq6dGp51WB2lU4OtlU/LcWKSwCwz/fbB07Akbs9Q8Z5g0Qj7Qkxp447ln0Ueo1Ldp/ASTpyVPr4PhV6GLaHuhJGY/J3z3jvdXXZVyomU84tfkL345GqP7l/kd0lWAO6npVDUavzWLk3FequAwCnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694264; c=relaxed/simple;
	bh=9IUioiHf+0CfzzRSrrW2yPTQee4YtZf8QnwdmjHvJTA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e3VmAjozlC7iW1xTJRDGxWtu0Fm5XTtg1Iqq+EOuBnmheUxPMmGHjzkpGP6mblZesCCeaO1748A8vWHdyHeWlZUJItWrV1YIlddSWy+ZEvR1fRFK5dpO2hGXzAgkKmGDmdxu9pJiqXFl9x18FWrypDrnSx3qeOQmpa9PIPwyhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wok4sVe4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024d571d8eso1042973b3a.0;
        Thu, 06 Jun 2024 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694262; x=1718299062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VzKt5qR4vcG3CrhIiC2botHnUeXtUfLzDNaS3bHPYZE=;
        b=Wok4sVe4vr3oR4V69rrnh78HIixfFfudYZpSXsk34ePCSSOxvfukJbFNEbjmmew5ja
         jgHD52UCeQRTYd1JtSmX/tlVrlKXdi6+tLQ4RAM4GwykLSVD61gA43oOf7bqAosQp7ez
         MH73UYLrIKh3Vto6AGZ3A7AsZCZ5cQJ5zDCHfIMcSBXeBXHF4pWTBNvJpe8++w7dkPFq
         ITQIJJe72FQbhglLpgPKrtJDnT2HhoVjf46vuKGDUtbToKiCLc4C2IAiQHRPq+jcWnQq
         +XKegy1crz/g6alJfh45yAXy38UdUiZ0GfJQZRAiJlOc5oofMz5LZc+kGPR2gpKBQaFM
         FFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694262; x=1718299062;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzKt5qR4vcG3CrhIiC2botHnUeXtUfLzDNaS3bHPYZE=;
        b=J/FoMnL3RtObRdTu9cBQOGmwSIH7mwTxmpM90q6UYaroOthkJe4OOTb4UgnUKm/7tk
         8uFum7hsIftTfdPLfg3MKVeV5JvT5yWl2t+y9ax5ByvLUYnkKcmfAUF5HCco+p5go6eH
         ztGalw5glFUhVpfmgWYWyd65oD6+fAk+bUuqKNUWd+o5Uk1FRkHx1Dgr9y7BC/MGPM+z
         uECxYaZC/t1uDMot5Mfv2NpftASoURioR9D2c7owmJhTA7lxWPbDPXybk9351xBCUHtz
         8aLTxCGgd6RlfOppcYv4emYBON1J1D51XMoWGaemLfaZr2BomaXTB6MDIT77yYXk/Doo
         8V4w==
X-Forwarded-Encrypted: i=1; AJvYcCUMsMOuIdbXDGVd8EiGMJBwnmPVIvGAKph+RdW6lcVEM1Q9HIOoO/YhGYqs/iuhQwL/JCKP0pNdDLKACEXUBJR+8cjAW55SKOgPUHeMsgu0ZVUzUycAUbB6eOZhtt66nDj4i71wnzvCg70=
X-Gm-Message-State: AOJu0YxcqdwxrmaEnoJORGmyyO+43kzeLnHfp22/jM2iBtDX1vQqAJva
	XWXVn2ZK0IXzhEtksrRNNvLoxQh0kWS22Mv3pPA2vg9SpmJWYYDR
X-Google-Smtp-Source: AGHT+IEh/oxPQ6LkR8xV3A8IfnigDTD0OKrTIlmxI43tcoscl3sWZJ794LVCh2Qdudv5Fz0kPgddMA==
X-Received: by 2002:a05:6a00:194f:b0:6f4:1799:c714 with SMTP id d2e1a72fcca58-7040c630b3cmr90020b3a.12.1717694261911;
        Thu, 06 Jun 2024 10:17:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd50bc7bsm1369547b3a.178.2024.06.06.10.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:17:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4c670e57-d92e-4eab-8bd4-7d8c5b6642ee@roeck-us.net>
Date: Thu, 6 Jun 2024 10:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] Remove use of i2c_match_id in HWMON
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Davis <afd@ti.com>
Cc: Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240403203633.914389-1-afd@ti.com>
 <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
 <77b2f8ce-0b71-4a7a-81bc-a64a1af3566d@ti.com>
 <fcafe904-383c-49c0-b576-81cbcde045c5@roeck-us.net>
 <cd6ae1f7-33e7-4e1b-bac8-c5566b22b392@roeck-us.net>
 <fce93a8b-7225-4775-b265-d283a863f969@ti.com>
 <340e8274-dd6b-49b0-906b-32da60745b22@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <340e8274-dd6b-49b0-906b-32da60745b22@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 06:42, Guenter Roeck wrote:
> On Tue, Apr 16, 2024 at 12:08:50PM -0500, Andrew Davis wrote:
>> On 4/16/24 9:16 AM, Guenter Roeck wrote:
>>> On Mon, Apr 08, 2024 at 04:49:43AM -0700, Guenter Roeck wrote:
>>>> On Wed, Apr 03, 2024 at 05:06:43PM -0500, Andrew Davis wrote:
>>>>> On 4/3/24 4:30 PM, Guenter Roeck wrote:
>>>>>> On Wed, Apr 03, 2024 at 03:36:02PM -0500, Andrew Davis wrote:
>>>>>>> Hello all,
>>>>>>>
>>>>>>> Goal here is to remove the i2c_match_id() function from all drivers.
>>>>>>> Using i2c_get_match_data() can simplify code and has some other
>>>>>>> benefits described in the patches.
>>>>>>>
>>>>>>
>>>>>> The return value from i2c_match_id() is typically an integer (chip ID)
>>>>>> starting with 0. Previously it has been claimed that this would be
>>>>>> unacceptable for i2c_get_match_data(), and chip IDs were changed to start
>>>>>> with 1. Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()")
>>>>>> is an example. Either this series is wrong, or the previous claim that
>>>>>> chip IDs (i.e., the content of .driver_data or .data) must not be 0 was
>>>>>> wrong. Which one is it ? I find it very confusing that the chip type for
>>>>>> some drivers now starts with 1 and for others with 0. Given that, I am not
>>>>>> inclined to accept this series unless it is explained in detail why the
>>>>>> chip type enum in, for example, drivers/hwmon/pmbus/lm25066.c has to start
>>>>>> with one but is ok to start with 0 for all drivers affected by this
>>>>>> series. Quite frankly, even if there is some kind of explanation, I am not
>>>>>> sure if I am going to accept it because future driver developers won't
>>>>>> know if they have to start chip types with 0 or 1.
>>>>>>
>>>>>
>>>>> i2c_get_match_data() has no issue with returning 0 when the driver_data
>>>>> for the match is also 0 (as it will be when the chip type is 0 here).
>>>>>
>>>>> The confusion might be that returning 0 is also considered a failure code.
>>>>> This is a problem in general with returning errors in-band with data, and
>>>>> that is nothing new as i2c_match_id() does the same thing.
>>>>>
>>>>> Actually, i2c_match_id() is worse as most of these drivers take the result
>>>>> from that and immediately dereference it. Meaning if i2c_match_id() ever did
>>>>> failed to find a match, they would crash before this series. Luckily i2c_match_id()
>>>>> can't fail to find a match as far as I can tell, and so for the same reason
>>>>> neither can i2c_get_match_data(), which means if 0 is returned it is always
>>>>> because the chip ID was actually 0.
>>>>>
>>>>> At some point we should switch all the *_get_match_data() functions to
>>>>> return an error code and put the match if found as a argument pointer.
>>>>> Forcing everyone to changing the chip type to avoid 0 as done in
>>>>> ac0c26bae662 is the wrong way to fix an issue like that.
>>>>>
>>>>
>>>> That doesn't really answer my question. It does not explain why it was
>>>> necessary to change the chip ID base for other drivers from 0 to 1,
>>>> but not for the drivers in this series. I fail to see the difference,
>>>> and I have to assume that others looking into the code will have the
>>>> same problem.
>>>>
>>>
>>> Just to follow up: I am not going to apply this series until I understand
>>> why the chip ID range had to be changed from 0.. to 1.. for other hardware
>>> monitoring drivers (lm25066, nct6775) but not for the drivers changed
>>> in this series. I have been telling people that chip IDs need to start
>>> with 1 if i2c_get_match_data() is used. I'll need understand when and
>>> why this is needed to be able to provide guidance to other developers.
>>>
>>
>> I was hoping one of those patch authors that made those 0->1 changes
>> would speak up (+Rob), I can't know what their thinking was, only
>> offer my best guess as I did above.
>>
> 
> I can see three possibilities.
> 
> - Chip IDs must start with 1 if i2c_get_match_data() is used, as I was told
>    previously. If so, this series is wrong.
> - It is ok for chip IDs to start with 0. If so, what I have been told
>    previously is wrong, and the patches changing chip IDs to start with 1
>    can and should be partially reverted to avoid confusion.
> - Chip IDs must sometimes, but not always, start with 1. If so, the
>    conditions will have to be documented to help driver developers decide
>    the valid starting value and to be able to determine if all the patches
>    in this series follow the rules.
> 
> Someone will have to step up and explain to me which one it is.
> 

Unfortunately, that step-in never happened. Instead, I keep getting patches
similar to this series. So, I applied the series, and I'll submit
patches to update all drivers to have the chip ID enum start with 0,
and/or to remove the complexity introduced under the assumption that it must
not be 0 / NULL.

Guenter


