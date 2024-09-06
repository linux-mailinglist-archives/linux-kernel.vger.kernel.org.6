Return-Path: <linux-kernel+bounces-319425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36DA96FC77
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48ABAB26658
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07191D5CFD;
	Fri,  6 Sep 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIzC9UgD"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622113C9A6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652773; cv=none; b=REXZdTpOv925MW/pzeQtgrUzWGwN07VifFni+HG94g+EuB7JSV0WEP9XrupzIOjzEEbFZq8TMsAy0uvsplOhglzSUSgixSKOMTNXZpfcS06k9mwjk8zkplggekSgJJ5k9RdTH0khPsXtrA7CgkkC7WR9a1w3AKxGmtmzT06gwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652773; c=relaxed/simple;
	bh=zSzs9XF+x/1KkoRiNGi5kV1jCEh/iJ2kEJcFjq7VkbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d96DY6RkL6w0wE2UDRAssM+yABZCE/NFjJ9PIfB9aJZoLTmrcqF59QKgIZUlROHfOMces22+5J3FmWcaiL3G5k6LkeEs5qFgGJl8UXaey6rImQf2mJ/VQngheSNPkmJUEENCll5ZhsuyjeHc5U4fPjVl4XN6quNbpXpcX9E9Mt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIzC9UgD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1405400b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725652770; x=1726257570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJtGxt1Yxmajuv7Da4bpt3HLYkbYaQ0buhDsfmlEWxo=;
        b=RIzC9UgDI/i1PlMjn622dB5CP8YpUNn+SXd+rdUQNE1rA9+FPuq9GwTWMApIRDX13X
         p0e2Y0FptcfSaOi4YxUW28bXscbZUosz4kZXQQvvf4Whmaz5DZLN0AW55dl0rZDTwsY4
         VIB3DLguzhH9F6Fq/8ZK3AR2qrKPdnaQuO4SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652770; x=1726257570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJtGxt1Yxmajuv7Da4bpt3HLYkbYaQ0buhDsfmlEWxo=;
        b=S9OBi+qEUlN1ldeG85lzRBAlseTd1fCcXaIy39i6Pa2e47e2jRjm1AOFtOC4draeoQ
         dpRqcJEXrobsX2G6wvTXPINdYC1hI8gY/tTrNZiQjhakmQAKM/io1dCntCFvAXKuJpCu
         tDQsEjjwwW8brek4zKu2staYU362BYdH3ZgF1JwLuaeNtqHEMyNIIZDUr0o6L6YIfVOg
         i76dfOBpgXosdiDlmrWLvXRnXslXXjNXXIMrs6dVWpCGQ5YL4BddpM1SrRFhUJ/0/Plu
         SnFO3I95KGlwoRrWNHnOWetewJ7kBZhfl8UCsivIWUzFDMeNyoJ2IgEavCNDit7QAoco
         Osww==
X-Forwarded-Encrypted: i=1; AJvYcCWiPWboFyo2gdKCBRh280A7QITMo7vTrseb2sLLIHBmGlQKulq8xblA3iBhPnU83O8zSrWj+k7yvuVrAGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPJTkFgRXReq7+qmAxuglwIroNBraEYVp21Kau2sBaEFtAyuX
	YOAl/yUdXBjS12TkBL0+M9D2tmoRsqG58Ezl2+Lkm1TzrW/8mFOkfLwpaQEM83w=
X-Google-Smtp-Source: AGHT+IG/UUgsagncAjg6+2NJnLOtzlWH0jzdVTx3NQ2SWB89VvDiS/cA4xYkFEVW0sjolGl/5jvZNw==
X-Received: by 2002:a05:6a21:7108:b0:1cf:12aa:4cf7 with SMTP id adf61e73a8af0-1cf1bf7db2emr6031827637.3.1725652770281;
        Fri, 06 Sep 2024 12:59:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e3ee88dfsm100978b3a.199.2024.09.06.12.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:59:29 -0700 (PDT)
Message-ID: <fcdbd8bc-9986-497e-8de4-86d3e619ca73@linuxfoundation.org>
Date: Fri, 6 Sep 2024 13:59:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
 <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
 <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
 <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 23:56, Dev Jain wrote:
> 
> On 9/4/24 22:35, Shuah Khan wrote:
>> On 9/3/24 22:52, Dev Jain wrote:
>>>
>>> On 9/4/24 03:14, Shuah Khan wrote:
>>>> On 8/30/24 10:29, Dev Jain wrote:
>>>>>
>>>>> On 8/27/24 17:16, Dev Jain wrote:
>>>>>>
>>>>>> On 8/27/24 17:14, Shuah Khan wrote:
>>>>>>> On 8/22/24 06:14, Dev Jain wrote:
>>>>>>>> Rename sigaltstack to generic signal directory, to allow adding more
>>>>>>>> signal tests in the future.
>>>>>>>
>>>>>>> Sorry - I think I mentioned I don't like this test renamed. Why are you sending
>>>>>>> this rename still included in the patch series?
>>>>>>
>>>>>> I am not renaming the test, just the directory. The directory name
>>>>>> is changed to signal, and I have retained the name of the test -
>>>>>> sas.c.
>>>>>
>>>>> Gentle ping: I guess there was a misunderstanding; in v5, I was
>>>>> also changing the name of the test, to which you objected, and
>>>>> I agreed. But, we need to change the name of the directory since
>>>>> the new test has no relation to the current directory name,
>>>>> "sigaltstack". The patch description explains that the directory
>>>>> should be generically named.
>>>>>
>>>>
>>>> Right. You are no longer changing the test name. You are still
>>>> changing the directory name. The problem I mentioned stays the
>>>> same. Any fixes to the existing tests in this directory can no
>>>> longer auto applied to stables releases.
>>>
>>> I understand your point, but commit baa489fabd01 (selftests/vm: rename
>>> selftests/vm to selftests/mm) is also present. That was a lot bigger change;
>>> sigaltstack contains just one test currently, whose fixes possibly would have
>>> to be backported, so I guess it should not be that much of a big problem?
>>>
>>>>
>>
>> So who does the backports whenevenr something changes? You are adding
>> work where as the automated process would just work without this
>> change. It doesn't matter if there is another test that changed
>> the name.
>>
>>>> Other than the desire to rename the directory to generic, what
>>>> other value does this change bring?
>>>
>>> Do you have an alternative suggestion as to where I should put my new test then;
>>> I do not see what is the value of creating another directory to just include
>>> my test. This will unnecessarily clutter the selftests/ directory with
>>> directories containing single tests. And, putting this in "sigaltstack" is just
>>> wrong since this test has no relation with sigaltstack.
>>>
>>
>> If this new test has no relation to sigaltstack, then why are you changing
>> and renaming the sigaltstack directory?
> 
> Because the functionality I am testing is of signals, and signals are a superset
> of sigaltstack. Still, I can think of a compromise, if semantically you want to
> consider the new test as not testing signals, but a specific syscall "sigaction"
> and its interaction with blocking of signals, how about naming the new directory "sigaction"?
>> Adding a new directory is much better
>> than going down a path that is more confusing and adding backport overhead.
>>

Okay - they are related except that you view signalstack as a subset
of signals. I saw Mark's response as well saying sigaction isn't
a good name for this.

Rename usually wipe out git history as well based on what have seen
in the past.

My main concern is backports. Considering sigstack hasn't changed
2021 (as Mark's email), let's rename it.

I am reluctantly agreeing to the rename as it seems to make sense
in this case.

thanks,
-- Shuah


