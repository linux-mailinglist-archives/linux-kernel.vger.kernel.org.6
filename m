Return-Path: <linux-kernel+bounces-259259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38CD93932D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D391C2140A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF19116EC1A;
	Mon, 22 Jul 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7Uk2kg6"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF316F0D6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668841; cv=none; b=iNh/mnnmV8+dFx++GjCTCfHVgfYoeVMA6BZwPyjLWcD2wQVHRLlnba35yojeqFnTiH5SUWvgAlCT73XC4p5K7k81CbtDLUH6al3qTwNs78ERqhN4RuMwa8Sew31ePtWPXrmzZqu8wrwwFeuu8NlQ2vlRhf2Yd3/n2JhRoxmYAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668841; c=relaxed/simple;
	bh=YaYVr5FEG0ukrEdmfqROtjn5kyvr+2FjDHKXLZ+mSeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRGDPk9UyhvMakyi7meP0aq/bRBYdR2Fr+H4xEB9DhdPaXqX+uZ6CxYHWAZz/U8E3OTEid8ugQ+CsHG6x2LygQ9Twfj0cUbI1wHKFYFWERPPMmvgdvN1YqIp9pZ3EFkG4ZNmKTFQZtjH05R1wvQrjGMZsvfoSgqKiabsG2q5YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7Uk2kg6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d26cb8f71so62675b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721668839; x=1722273639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY4sH/LbuVESp5q/QWtYd1/52TmysVKBXBzov5EpRk8=;
        b=e7Uk2kg6VaqZMREuXvFk76DSUzPHwy1vYb67R54QGnhMf6tl7R7YaLPqL87hdJAFNo
         bVP4tG58zcjTMeH/pAhcXCj1e9TWjJRA2FmwJawNV/lBq9/TU0sIHeo7umNr3F9t1lN8
         yrGHNBrVSyF5d55h0s/sgMST366ZA8UEElLPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721668839; x=1722273639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY4sH/LbuVESp5q/QWtYd1/52TmysVKBXBzov5EpRk8=;
        b=siOYyAvWdB6PiqulgAJODMznFF2C15kB9T0mMaq0nZity4QhbO3UVPKlz2EciaN5dy
         NbD50ezJGuSUtMuDC6G9myN8NNgRkslsRYoh3Mpd3uKzhZseryIoUbAWaK8O0wh5P6Bt
         5RpoN/21H4migngKbZjdM5oqToFDkkG/t+d+UsQ+Y7mf780j9TdGO/01UCYvxQjHZfJD
         jZTiYAfuJWR4E46lVEd5deNeoKHXHXKG6fS/WTx2CkpTd0V4cc58o6HW+nyf3HKju7iV
         BrrGd3AlbpThQhI7M+6CcrFjRbZkywdLr3mNWwZBgHKh7b8ZHiQyekdn0Xb+yAw93jmo
         u8bA==
X-Forwarded-Encrypted: i=1; AJvYcCVSQkXkC6sCeRtisy18SJ58BRIO96HkNjTocV6siIAtgOh89MQhq56NDpB7kfdw0VR8oDlfOmZUOYTwtIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3JN8j9RzMcxppjEtrhyl7ziegv1JUvHRRgYLIX9UdwpY+CCv
	bELhOwd1sTsJhunHb5qEwui8anxoy1JxqT0h+SIQO5IASy7sLEH0ppzvwM2cLOE=
X-Google-Smtp-Source: AGHT+IGm32gXR6X5r6y5GA2q/mGRB7+fSU8f71TNTs4ydJgPXvsr3Ng15mmawxW99+HX5deiZQJ8tg==
X-Received: by 2002:a05:6a21:2fc7:b0:1c3:c1d0:226 with SMTP id adf61e73a8af0-1c42298f233mr6914098637.7.1721668839344;
        Mon, 22 Jul 2024 10:20:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77307630sm8437570a91.21.2024.07.22.10.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 10:20:38 -0700 (PDT)
Message-ID: <1f29019c-c30b-48df-80e1-e412b0c7add0@linuxfoundation.org>
Date: Mon, 22 Jul 2024 11:20:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: x86: vdso_restorer: remove manual counting
 of pass/fail tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
 <9cf7f693-bc6a-415b-99c3-f6c59b871c4f@linuxfoundation.org>
 <77a66e39-7f34-4b3c-ac8d-e48d8c5a2830@collabora.com>
 <87fbfba4-8d4d-44ff-9fe5-e101cce3d6cb@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87fbfba4-8d4d-44ff-9fe5-e101cce3d6cb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/24 10:37, Muhammad Usama Anjum wrote:
> On 7/21/24 9:24 PM, Muhammad Usama Anjum wrote:
>> On 7/19/24 9:40 PM, Shuah Khan wrote:
>>> On 7/12/24 01:30, Muhammad Usama Anjum wrote:
>>>> Use kselftest wrapper to mark tests pass/fail instead of manually
>>>> counting.
>>>
>>> You care combining two changes in the patch.
>>>
>>> This is needed to return correct exit status. This also
>>>> improves readability and mainability.
>>>
>>> Spelling - "mainability" - checkpatch would have helped you
>>> catch this.
>> Sorry I'll fix it after following discussion. I use checkpatch with
>> spelling checker. I may have missed it for this patch.
>>
>>>
>>> The change to return the correct error fine and but not the
>>> change thaT ADDS DUPLICATE tap header.
>>>
>>>>
>>>
>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>    tools/testing/selftests/x86/vdso_restorer.c | 20 +++++++-------------
>>>>    1 file changed, 7 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/x86/vdso_restorer.c
>>>> b/tools/testing/selftests/x86/vdso_restorer.c
>>>> index fe99f24341554..8e173d71291f6 100644
>>>> --- a/tools/testing/selftests/x86/vdso_restorer.c
>>>> +++ b/tools/testing/selftests/x86/vdso_restorer.c
>>>> @@ -21,6 +21,7 @@
>>>>    #include <unistd.h>
>>>>    #include <syscall.h>
>>>>    #include <sys/syscall.h>
>>>> +#include "../kselftest.h"
>>>>      /* Open-code this -- the headers are too messy to easily use them. */
>>>>    struct real_sigaction {
>>>> @@ -44,9 +45,10 @@ static void handler_without_siginfo(int sig)
>>>>      int main()
>>>>    {
>>>> -    int nerrs = 0;
>>>>        struct real_sigaction sa;
>>>>    +    ksft_print_header();
>>>
>>> The problem with adding this header here is when
>>> make kselftest TARGETS=vDSO is run there will be
>>> duplicate TAP 13 headers.
>> Usually all TAP compliant tests print TAP 13 header at the start. These
>> tests when run from make run_tests have duplicate TAP 13 headers. I don't
>> think that this is the issue. Why do you think it is wrong?
>>
>> For example, I've attached the logs of vDSO test suite. TAP header is
>> printed at the start. Then it is printed again at the start of the test if
>> it is TAP compliant e.g., vdso_test_abi and vdso_test_getrandom. These
>> tests are already TAP compliant. Other tests in this suite aren't TAP
>> compliant.
> On CIs (make runtests or make kselftest) is used to run the tests. I'm not
> aware of the ancient history. AFAIU following is the format of messages
> (make kselftests). The TAP header mention that a new test has started. One
> test may have multiple sub-tests. For example:
> 
> TAP version 13
> 1..4
> # selftests: vDSO: test1
> # TAP version 13
> 1..5
> ok 1
> ok 2
> ok 3
> ok 4
> ok 5
> # # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: vDSO: test1
> # selftests: vDSO: test2
> # TAP version 13
> 1..5
> ok 1
> ok 2
> not ok 3
> # # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 2 selftests: vDSO: test2 # exit=1
> # selftests: vDSO: test3
> ok 1
> ok 2
> ok 3
> not ok 3 selftests: vDSO: test3
> # selftests: vDSO: test4
> ok 1
> not ok 3 selftests: vDSO: test4
> 
> 
> The test1 and test2 are TAP compliant and print header and footer of the
> tests mentioning total number of tests. The test3 and test4 don't print TAP
> header and footer. The boundary between test3 and test4 isn't that clear,
> but seems fine. Overall I would say TAP compliant tests have better boundry
> when they print header/footer and total number of tests.
> 
> Do you agree with above layout's current state because we have both TAP
> compliant and non-compliant tests.
> 

Usama,

There is a reason for not using nested TAP headers - this is what the outcome
would be with the changes you are making. The reason went with the direction
of adding TAP headers once for each test suite is to avoid nested TAP headers.

Unless that changes and we can stay backwards compatible with TAP 13, I am
not going accept TAP headers for individual patches.

You can take it as a nack from me for all such patches.

thanks,
-- Shuah



