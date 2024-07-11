Return-Path: <linux-kernel+bounces-249495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F67792EC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA87B24070
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DB416CD17;
	Thu, 11 Jul 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qz5aLucv"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7915F40D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714478; cv=none; b=aC0EW/Z9cE+8bb4JSf9IK9S+t03Sw1qMDF4/uGfEtlO+vZwvw1SCFZiSLJb9ardWszaZDCv4Zej3FwxcQZGDFrKB8wV/wbcKkh1rwXFeiyAC3HqfuGEhm/cSvuOWt2Bsfi10bBWWeK7+Ic846VGimoiuEvx8eE0CAZm9b7GQzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714478; c=relaxed/simple;
	bh=p0Fd5kqP/qELdWU/vCSn4X7+8f2/BPDr6C4O+78HNvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7s5iiLBg00s2Ziq9njZb51Ay3VPxZzn8LwjRvn7MEa5aSkcxUuBo+yawqG2juTCRk1sRbom+Ll7ED7YWBwUeQBgWdI9rVvQF/t6Tl3GVTKh7cG1NKyxq4XgoAaaovnv3zbRTGeaOYo7RZz477KKXlAVbvto48q78j/8UcIAkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qz5aLucv; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eb41831704so2527039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720714476; x=1721319276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiasLvVkTXNMoP1/ktol3zYB4Lu4so/sXSPfIuMBjOQ=;
        b=Qz5aLucvlf/bSSgVdKS+FXDEHc2cJHKFBytwnBaEBmh21lQCO6AhWfblRILnoQArLF
         yhe2ENCRxCVNbO0oNb+0x3J5iXTLT0EocEdrGkl7okWzpGvVrcWc9wrcYiI5WbKa9fid
         pmgDJfPk2HipTl9bIwN6G9qfxfZ767W43Q4+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714476; x=1721319276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiasLvVkTXNMoP1/ktol3zYB4Lu4so/sXSPfIuMBjOQ=;
        b=rwXbfbkeRZrsfDnnW0TT+TXv76rVRvP2VnXZOxpM67FVwpBdo/z0xaet1OT2ZoiNik
         b5jAi2xh6w+zkCpQr8UZrIepeerJ3eu/asFsDM7rY5qxF/4zE+LRbd3sqhH/Ieaj8XsA
         greFI6PNDv4J/Oj+EoQpoEROaIxZozslRfebqsauqBjflgfPakgdC46nSDul0jBlb3Ov
         jkuJK8jkW6gIgMrB+zPpK546I2FdrQreTt+CbGEk37l2Pe0nGD9w6mVAfn0KIOvT+jXq
         ezH7H26JuKbGZfjVXl4DUZCJD3zfyO9H0NXu2rCiXYj+pRH0czOYsOPwv2npxJoSRc0I
         mevA==
X-Forwarded-Encrypted: i=1; AJvYcCVHZk7jS254y9mNB488ZvOfaEyXOxei3A88QUVnFJsVnSnB+Yidvjde8IOXFrPNzAdcGKBs6eAMplpdoGXLDWduzgZCcmRD7sL6JuO+
X-Gm-Message-State: AOJu0YwUXjZ6dGmGBzWi20BBya1+b1QCmqtzLIOZ3PWHoMoaCRxWm4FN
	47SXRYrsfCpR2vvzimT6ptQ2HOKQM4cSWg32PFE0RXWKk6zvCpEx9+jOybWvQ/IUw6LT6Qijzye
	M
X-Google-Smtp-Source: AGHT+IGmK81I/5GXFu3J42YAbYO3XZVPUmrRPMyz4POXr/27hNbZoYV8FRFcwColnWFsAKPbFW7I8w==
X-Received: by 2002:a5e:de42:0:b0:7f9:3fd9:cbb with SMTP id ca18e2360f4ac-806e171b3a5mr298153439f.1.1720714475739;
        Thu, 11 Jul 2024 09:14:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c12750sm1895166173.125.2024.07.11.09.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 09:14:35 -0700 (PDT)
Message-ID: <c5981eeb-4f6b-41d4-b630-5b17a1e2a00a@linuxfoundation.org>
Date: Thu, 11 Jul 2024 10:14:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
 <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
 <386da8e3-1559-4ec2-9a66-f5f3f6405a2b@collabora.com>
 <23db41bb-1f3b-4b7b-95ac-960b8775a062@collabora.com>
 <fb305513-580a-4bac-a078-fe0170a6ffa2@linuxfoundation.org>
 <f7eb356d-6fe7-4e36-9fd2-1518addc7bdb@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f7eb356d-6fe7-4e36-9fd2-1518addc7bdb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/24 02:58, Muhammad Usama Anjum wrote:
> Hi Shuah,
> 
> Thank you for replying.
> 
> On 7/10/24 4:39 AM, Shuah Khan wrote:
>> On 7/2/24 04:17, Muhammad Usama Anjum wrote:
>>> On 6/10/24 10:19 AM, Muhammad Usama Anjum wrote:
>>>> Adding Borislav, Dave and x86 mailing list:
>>>>      Please review the series.
>>> Kind reminder
>>>
>>
>> Usama,
>>
>> As I mentioned another TAP conversion patch from you  patch if the
>> following command gives you TAP, there is  no need to convert.
>>
>> make -C tools/testing/tmp2 run_tests
>> make kselftest TARGETS=tmp2
>>
>> kselftest framework lib.mk and runtests wrappers take care for
>> TAP. The reason to take care of this at framework level is to
>> avoid changes to individual tests. The wrapper keys off of
>> KSFT_* codes returned from tests.
>>
>> Please don't send TAP conversion patches like this one. The output
>> from the commands will have duplicate messages. The reason tests
>> return
>>
>> make -C tools/testing/tmp2 run_tests
>> make kselftest TARGETS=tmp2
> The current series have several improvements which are beneficial in
> several ways. I think these improvements should be included. While
> conforming for TAP following improvements have been made:
> 
> *[PATCH 1/4] check_initial_reg_state*
> Removes manual counting of pass and fail tests
> Increase readability and maintainability of tests
> Print logs in standard format (without [RUN], [OK] tags)
> 
> *[PATCH 2/4] corrupt_xstate_header*
> Correct the skip, pass and fail return codes. Otherwise the test always
> return 0
> Returns correct number of stats about passed/failed tests
> Print logs in standard format
> 
> *[PATCH 3/4] fsgsbase_restore*
> Add test skip support instead of returning success at skip time for the
> kselftest script to understand correct exit status
> Print details about errno if error occurs
> Increase readability and maintainability
> Print logs in standard format
> 
> *[PATCH 4/4 entry_from_vm86*
> Remove manual pass/fail tests counting
> Increase readability
> Print details about errno if error occurs
> Print logs in standard format
> 
> 
> These improvements aren't evident from the description of patches as I
> thought converting to TAP achieves all this by default. But I can improve
> the patches description and send patch revision. Thoughts?
> 

Please drop the TAP conversion and make the other changes in your v2.

thanks,
-- Shuah

