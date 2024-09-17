Return-Path: <linux-kernel+bounces-331372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2DD97ABF6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C230282C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A0C136352;
	Tue, 17 Sep 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxAZQLM/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1E4594D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557744; cv=none; b=s/DiG0m/P3qgGg2kt4R8u4Hz0K+1x+bBx+yFn/qBy4EO/hm8YR0cl4QN4TiDiiz95EHofDgM9RAmU5l9T/12r7Q9gw48slSaYhT+L1KxUiuKYedlyhtwO1tdgCRUXuR46WXCUz+bevhtWkE+ZmS/AUv7v8JUG6dAsPRR0rnlnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557744; c=relaxed/simple;
	bh=EXosztwyNJ5epeSTdrIp9xX9X4TY8HE1nbbC7P7snp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4D4nTOe3XERuFjLA5yMxVeSuCNrPLS5pPIPUQg6psVDzMVyGR4rlVyub6391+KQ6rMOkRmJkJo0st6iyg566BmGYaAManPClSeNZhFLlUpCz4xm1vk6Ge/T1ky1Jb2JHmzayqlb72efbBcDRf/PWev+LkR2EbFaqrQOQyjLZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxAZQLM/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so33351925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726557740; x=1727162540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTfn5RtEW0BHfgAEJj/p2eepLow2Hx5yPD5gDz7PNO0=;
        b=cxAZQLM/awzTF01TxZmYFXccfQ8ufmMz+R2RTEnmGYDIPawk9d3yZ7R7j8W1GII2Vu
         Vpk7UeVgbgx2aZ8++pZplPbiP1VViWAAZKP92CN64Vw6CwPTzT48wuAEcLqjYg2Ct4JG
         REg709Uk81KoI+kj53lKO3NveFKwEcwTRKVXZu63xwJhicJBN13P1eziYgIjZfQ2Bwks
         ms1ntJodBfTa/o12UErZPSfskkxT712reMIumzskHQxukeBhxJQy6vaAH7/s3bZnBAAr
         iHz2hAptvKvTpHWEMz6TQJvagxpQD+3FDfR5TakbVLMYA4MxKQfWAtyhX/hZB9IEeE04
         L+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726557740; x=1727162540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTfn5RtEW0BHfgAEJj/p2eepLow2Hx5yPD5gDz7PNO0=;
        b=UVc0LA3u8fcDGN2rOqTrwZH8Y014lUPqX23CVTwn7Dg/elaI3R7WEhJ0R1JSAbwedu
         8VGYUTX+BsEiQOCv8ub+94EDBNxEtTR3Ueh2GwxOdzkWKUlr/1RHnIwQMo5ah64oOtRM
         kHIqbaSNWVqQI1Nl/ogw5jJElT1WX3HCggWYkmdV83cuRgLyxSv1PmuoMFxLHZ1g49xh
         VNerYCI+mMM2Dv2JA17K7W48SwpJtxNkhbNz+ciclfhut38Ab/jDrbdaJezNgBj9Taq6
         54JXtHMfYnwiUnKYgIWaULQvBI5yytkOFbrIUdaxiC2BMzdJsWc8eDgeQ/JvZvEwvdhZ
         HDhg==
X-Forwarded-Encrypted: i=1; AJvYcCXXcDADrW2LnwIwhYNHJ/mhbLiAEZQf8eCjrqFsVGJC4o9U52tR4Z9z4IGivkpDH5P3XIks66Bx8d2Phwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzcQ3lzzJ37nLpqJOTPJechdQoAu3DdaBc2GwgR2whF/aV8pJ
	UGm/lZGz/2bhGXDQd3dy8Iq26cT4voluh19opxwTBUOQrtZW8o48zefS+YFxxkY=
X-Google-Smtp-Source: AGHT+IEs3i+jEeRyv1/BqTTM4EXjo9wtLDdr/wLvkxkXwQKCsGaLcSJy1Ldi9iMlPSaFT1+hS0S36w==
X-Received: by 2002:a05:600c:1d17:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-42d964d8563mr99634035e9.25.1726557740344;
        Tue, 17 Sep 2024 00:22:20 -0700 (PDT)
Received: from [192.168.7.95] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1947cfsm128395345e9.42.2024.09.17.00.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 00:22:19 -0700 (PDT)
Message-ID: <94e37138-ae66-4336-93ac-79683f2058aa@linaro.org>
Date: Tue, 17 Sep 2024 09:22:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
 op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
 <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
 <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
 <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/16/24 11:38, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
>> On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
>>> On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
>>>> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>
>>>>> Replace the custom approach with the %pUl printk() format specifier.
>>>>> No functional change intended.
>>>
>>>> Thanks, the patch looks like a nice simplificatrion.
>>>
>>> Thank you for the review.
>>>
>>>> Rijo, Devaraj, does this work for you?
>>>
>>> Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
>>> but in this driver IIUC it's guid_t (UUID LE).
>>
>> No, this does not work for us. I tested this patch, it does not work as expected.
>>
>> %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x).
>> But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.
>>
>> Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
>> While, in our TA naming we are using 3 hyphens (-).
> 
> Ah, good catch! Can somebody add a comment there to explain that this uses
> non-standard human-readable representation of GUID/UUID?

Could this be due to some copying/pasting from the OP-TEE code base which had
a similar mistake prior to v2.3.0 [1][2][3]?

[1] https://github.com/OP-TEE/optee_os/blob/2.3.0/CHANGELOG.md?plain=1#L40-L45
[2] https://github.com/OP-TEE/optee_client/commit/a5b1ffcd26e3
[3] https://github.com/OP-TEE/optee_client/commit/365657667f89

> 
> P.S. Thank you for testing!
> 

Regards,
-- 
Jerome

