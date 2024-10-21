Return-Path: <linux-kernel+bounces-375167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6909A91CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99961284076
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9221E2304;
	Mon, 21 Oct 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M1EEiM0K"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9961E22E8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545153; cv=none; b=G0CgJJZlxEXd18GFIzEak+YwT5Fu25fLbmaW4CEB7FrQBqPDlfhOF87w3Iprl7phhUpOQBq1vD7MktjrNiA96lNZWjgp3xP8xWoUtykOfbiR3f4CqGLazzTRyrQHmHYQPst2KjOL4evd3eAeBwPnZQGRb54tefpXP1T03Lpozh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545153; c=relaxed/simple;
	bh=Mm4w5L58vIi1NbVMmEB9LuVKu16Ln/OOhXrbvFV6Si8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBigdJf3ja65LnHkKeY0p2C+ikb3EpjYEztOzjoo+3lCAopYVKDKiLSgaY/nmYjm5swC4uh2VXD36YfJDfjaxVajwcAWAMq4ELhVM7oJxpRlf4pItcwgiHBy6ro0l1LU4E4+xprsGdKpg5AbSZSlP8FNMoeYWPb0OPBpUZAck4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M1EEiM0K; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83ac4dacaf9so85767839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729545149; x=1730149949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4jbvSsez8PgCzvupOzKqlyDwviGgAHKS0mubszTe0o=;
        b=M1EEiM0KZAWqa/uXwz2T/5+7zCd38HU1wsboxUqJoY4mQVMe4uSUjCGRG6EbjDwOqU
         610vejZ/b4zCsqeGSuWvOJU4CzTkzrw3p0yrddd+u9k0Zl0j8jkE8eIYicFnb/SqB/0r
         Xr8TO6o35fozkcJyS/nPKpR/HeogljGKuE8zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545149; x=1730149949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4jbvSsez8PgCzvupOzKqlyDwviGgAHKS0mubszTe0o=;
        b=RITqGA24+Eu3BAKhdR3Mwq5K52R8r5lIjlSQgHnbCwCgBgXnZkmp8lj3W5pw9iIVN9
         YhuT1f7jx6vUh5aSZgRQE6LHl4MqDO7ynYZI/QJ5EeyqvFvONHz2MDYEV7cYcZCz5cI/
         TUfY6bxOw5nBP2ZWDyHdAXV7KYNtXWTnveblgue6lGdkcucsvv1N3JoOQyRnXr9dRxQo
         5P/2dFxp4bW4D1zPAnsTTuMTAveOVeHFOUbretmUE0tJ6gPIJkS0NCZbvEbRBTN4BxPv
         9KdwbLmSkuGOCajgYGNrc81lu7LQPu4TlrWwIbzpihqMSfJCtxp2yZw23576eKmeTi6+
         Otag==
X-Forwarded-Encrypted: i=1; AJvYcCVFtmDTZTFbjOUWusjh4l1cJPZzBXgfDi2waaTkaIExHACNp/McrNMhsBDRGWOfOdUz/XJhgOgeURDbgnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpAYdptyCkt0BccRp8i7aRuSLPDzx+ixyzIe2pxSXjMRlNGB3
	DpJyigreFldeE4LMTcniOen2EiIt9HK3r/HLyf7AAko9QiMK9Ic+Vgd2mjwlnMU=
X-Google-Smtp-Source: AGHT+IEoRjHeh1B/mF5MGtLncSvNYtxL8tCfCqHTrUFk0JN5cxWyybwj7h3AqEgKb8WBLK7wVbKSJw==
X-Received: by 2002:a05:6602:340e:b0:83a:a8c6:21ad with SMTP id ca18e2360f4ac-83aea91202amr53078539f.7.1729545148698;
        Mon, 21 Oct 2024 14:12:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a558b34sm1234701173.68.2024.10.21.14.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 14:12:28 -0700 (PDT)
Message-ID: <583282bc-17b7-4c7c-8e94-44d720c09682@linuxfoundation.org>
Date: Mon, 21 Oct 2024 15:12:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/intel_pstate: fix operand expected
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, anupnewsmail@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014172149.324639-1-alessandro.zanni87@gmail.com>
 <41d157fc-6413-4061-95af-518ec7b923f1@linuxfoundation.org>
 <4hxgkaxray75k2z4zyhhq6nb6iegsfokhsv6gdthai7bfzbpnw@6doocomldm6m>
 <CABq9Dx6b0TxXfvsmaaAMG+O=x8v3pD4CY2TTowcGzkL2q=Q1Yg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABq9Dx6b0TxXfvsmaaAMG+O=x8v3pD4CY2TTowcGzkL2q=Q1Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 09:04, Alessandro Zanni wrote:
>> On 24/10/14 06:05, Shuah Khan wrote:
>>> On 10/14/24 11:21, Alessandro Zanni wrote:
>>>> This fix solves theses errors, when calling kselftest with
>>>> targets "intel_pstate":
>>>>
>>>> ./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")
>>>>
>>>> ./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")
>>>>
>>>> To error was found by running tests manually with the command:
>>>> make kselftest TARGETS=intel_pstate
>>>>
>>>> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
>>>> ---
>>>>
>>>> Notes:
>>>>       v2: removed debug echos
>>>
>>> See my comments on your v1. It would help to wait a bit
>>> to send v2.
>>
>> Ok and thanks for the comments.
>>
>>> I can't reproduce this problem on Linux 6.12-rc3.
>>> What's you environment like?
>>
>> My kernel version is 6.12.0-rc3 from "make kernelversion".
>>
>> I think the errors are related to the bash type and version, rather than the kernel version.
>> My bash version is: GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)
>>
>> In fact, some shell do not complete expressions in variables and $var and command substitutions
>> are done before the arithmetic expression itself is parsed.
>> That expansion happens without regard for the arithmetic syntax, so with $var you can mess
>> with that.
>> So, I suggest to avoid to use $var inside a arithmetic expansion in order to be cross-platform.
> 
> Hello,
> any thoughts about this patch?
> 
> Were you able to replicate the error?
> 

Yes I was able to reproduce what you are seeing.

>>>>
>>>>    tools/testing/selftests/intel_pstate/run.sh | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
>>>> index e7008f614ad7..0c1b6c1308a4 100755
>>>> --- a/tools/testing/selftests/intel_pstate/run.sh
>>>> +++ b/tools/testing/selftests/intel_pstate/run.sh
>>>> @@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
>>>>    # Get the ranges from cpupower
>>>>    _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
>>>> -min_freq=$(($_min_freq / 1000))
>>>> +min_freq=$((_min_freq / 1000))
>>>>    _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
>>>> -max_freq=$(($_max_freq / 1000))
>>>> +max_freq=$((_max_freq / 1000))
>>>>    [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
>>>

The patch is fine. I applied and run it. I found another problem
when cpupower command doesn't run

# ./run.sh: line 89: cpupower: command not found
# ./run.sh: line 91: cpupower: command not found

So you would have to check if min_freq and max_freq are valid
and don't continue if cpupower isn't found. This test depends
on cpupower.

You can do that as a separate patch and send it as a series with
commit log changes I suggested on v1 of this patch.

thanks,
-- Shuah

