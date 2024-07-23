Return-Path: <linux-kernel+bounces-260169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED793A40E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CC5B21C68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB36157495;
	Tue, 23 Jul 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKrFPClq"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEB157469
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750118; cv=none; b=ZckTA3DNr5gclUHg1fWupVXhUp63SWOElCRb0X05CmRmTAy+a8JPbl5aHR3n3Gn13LeSBtq10j65cdc/FbDYc3CPIzdhnsv0PAVAw5ZDUkAg42LRYAPcfU02n9Lq+P2Hk7sN7QmKwoe46MAQ9aJjkanwQC40oienFiusiXoFexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750118; c=relaxed/simple;
	bh=pKgz77waICa546rfGgU6tjUnrgO9VIGblXenGg93D5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLNg7+nwC90KOKiqd7s/mopOw1L54SvTmrLW81sZKBpAP7J39+7cjdWN4Bfq5jXZZAPhqLo5hE6JDISomes39QbYJtjtS8buWeDuFhhvnwHouHJ460/sizbD24f+IRLDc+0jaq+Uv39I5i0GejWrDJtGYBsZbsMlIRrPhGuYDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKrFPClq; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f906800b4cso30781639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721750116; x=1722354916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lg1BsDoFTVJYikAOrp8+ys3hLPaS+7BQa4llRdXSLUA=;
        b=dKrFPClqg0C1za62cMZAEPTk6u1uSifz7yjGAEMmRKdeSvdHH0FTwT56FKm6lOtN29
         b3FT42j7gxjHmiVp0y1vU/9HUsYciq2Ao3N/Cxg9p+64lZMDKpYLj55uz8R/2J6VatJi
         NJ0rU+FzJPupZM0kAztJzwIf9WwgZR/++wNjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750116; x=1722354916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg1BsDoFTVJYikAOrp8+ys3hLPaS+7BQa4llRdXSLUA=;
        b=PXCZq3ru+zDq90wlrXMHJCFKSsuZl2Od5A4JGkwLuwFiKFGdXulEfJ31fBBb66Ua58
         XoDPd9Lk1g833lgjUvRC2cPmKP436fSqG3jqHu9w1w0T5qGSdDe3+9Z8ei8hD/3DMh/w
         4F6HO6+ntxYRm4WzZke86KNYZCjK1TkMGT8ZgbeusOM3+BOlENZ/46/mBj22Am2HEEuv
         uETQonxzxV5/bDoXL9QD3pXm1F4muNbtcdoGWmoVisefNeHv4eYChp7lVJI9AC+OHRi4
         2718BJI14cOohsK5ehrE/6oV+6eTrW4j/m7GJZQ8PjDbe93JQOz7ynpDPG3fIFSEy05A
         4/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV3brUhJEBpBhuIdzd9shCRsp3eaZJD9QpZkiJiGbIU1J2+d2Up3ho23xRWfdZSTx7D9Fuyp2OMHPaGw3Ei6qq90DwetXNiH87qxnrA
X-Gm-Message-State: AOJu0YwumlzFmVEO4D+T5IMFmXWDQ4+v+bxXni1fj4cGnS5tVM4GfQ0m
	SXIDt0sSguCmZYedMAzXxo5ATfBCwrEdxhg78oQVSyAD6QsZ8ksNvUHBbOmJX+0=
X-Google-Smtp-Source: AGHT+IH3jhqVl6/DZ+4DZmo8QwwuG+XqV7XSC40U/FhKoPqCMXQg5gRdnLSL4oPL6QjiMiA5bL2Wzw==
X-Received: by 2002:a05:6602:2543:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-81aa4ccdb27mr693914339f.1.1721750116383;
        Tue, 23 Jul 2024 08:55:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-819aba13e14sm314871639f.2.2024.07.23.08.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 08:55:15 -0700 (PDT)
Message-ID: <2ee0f5df-9a9e-4625-ab09-b21596a0685f@linuxfoundation.org>
Date: Tue, 23 Jul 2024 09:55:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] selftests: Add a test mangling with uc_sigmask
To: Dev Jain <dev.jain@arm.com>, Oleg Nesterov <oleg@redhat.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
 mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240627035215.1527279-1-dev.jain@arm.com>
 <20240627035215.1527279-3-dev.jain@arm.com>
 <20240630151808.GA13321@redhat.com>
 <09370b2d-2b52-4133-8e0d-83e66b801ff8@arm.com>
 <abd97c85-c9d9-43c9-b0c2-36f6f0e442e0@linuxfoundation.org>
 <01e41c46-255a-419a-9b72-485a2798205f@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <01e41c46-255a-419a-9b72-485a2798205f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 22:30, Dev Jain wrote:
> 
> On 7/22/24 20:28, Shuah Khan wrote:
>> On 7/15/24 05:49, Dev Jain wrote:
>>>
>>> On 6/30/24 20:48, Oleg Nesterov wrote:
>>>> I see nothing wrong, but perhaps this test can be simplified?
>>>> Feel free to ignore.
>>>>
>>>> Say,
>>>>
>>>> On 06/27, Dev Jain wrote:
>>>>> +void handler_usr(int signo, siginfo_t *info, void *uc)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * Break out of infinite recursion caused by raise(SIGUSR1) invoked
>>>>> +     * from inside the handler
>>>>> +     */
>>>>> +    ++cnt;
>>>>> +    if (cnt > 1)
>>>>> +        return;
>>>>> +
>>>>> +    ksft_print_msg("In handler_usr\n");
>>
>> This message isn't very useful. Why do you need this message?
> 
> 
> There isn't any specific use; I am just showing the progress
> 
> of the test. If you think this is just waste output....

Showing progress will not be useful unless it is also giving useful
information to the user. It doesn't look like it in this case.

You can drop this message.

> 
>>
>>>>> +
>>>>> +    /* SEGV blocked during handler execution, delivered on return */
>>>>> +    if (raise(SIGSEGV))
>>>>> +        ksft_exit_fail_perror("raise");>>> +
>>>>> +    ksft_print_msg("SEGV bypassed successfully\n");
>>>> You could simply do sigprocmask(SIG_SETMASK, NULL, &oldset) and check if
>>>> SIGSEGV is blocked in oldset. SIG_SETMASK has no effect if newset == NULL.
>>>>
>>>
>>> IMHO, isn't raising the signal, and the process not terminating, a stricter test? I have already included your described approach in
>>> the last testcase; so, the test includes both ways: raising the
>>> signal -> process not terminating, and checking blockage with sigprocmask().
>>

thanks,
-- Shuah


