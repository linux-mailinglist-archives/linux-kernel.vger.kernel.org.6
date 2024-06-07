Return-Path: <linux-kernel+bounces-206753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF7900D54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F89A1C217BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CF81552EB;
	Fri,  7 Jun 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PEuQ6y0o"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8F14D6F6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794478; cv=none; b=aV8drNYoHuLku1Hf/TOJvS9yvk1v7ueraDWE6FFVOC5w417SfuiZ9seeYpnUnzSId8VFHwb2Mw7/wjBHBJqyJWIUOmITiZUAIm6aqCCOm6dbXFcvgzqvOw0roLZ4UvVBp+bJb89KBITrtWkGKIcK0YDvHzAYPqA9i7ljL0ZMoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794478; c=relaxed/simple;
	bh=nBJASMGq5hxKlEp7Qa5tE/1ZxMwz/w6SfDWZGairEX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2e2bw/KZvUg1QtuVBBQKoDNRQCQKl4OD7kuPtb+BFfnwJSfpzbRb5V8AjMeCvSaiMB4dQLUf0TRjyPvoQHY5KTm8q9jhCXT9J47Fy1Ltdqfscb53zp8XrO6FzDPieoz6uMY7YPJLB6vD7ggwmS40CZGHKPV9O611ra8gecmg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PEuQ6y0o; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-374a69879b8so1603675ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717794476; x=1718399276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opkEZYVK07qHwj50BkzFi5KXf8XbLahD3Gf/Sesibnc=;
        b=PEuQ6y0oNyq99n2nXeLGYNojasXGlsz0p6SSCLnxh3iZoZl8eyBF5EGwqsvJmFnA9W
         A+xhXcgeWNLWEtiInQjbj58jy3QfuTaSCmjFpGj6qyRP/Iowgp/rJ8nMA/NhTC/9j6wa
         o++8lGuYcRb3FEscKD1jeEzP3uGf9CRzAlBK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717794476; x=1718399276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opkEZYVK07qHwj50BkzFi5KXf8XbLahD3Gf/Sesibnc=;
        b=kU4Ybgz0/ZwD3p8DTn3akGY5+of55wiOX0ouVy3YPUHpJLkNOTeHI6xVT33p+gsVte
         cAzkD1SFzpWjtiI9jjNXqZhzAVangcUN343y4UeMaPqSrHtdeiaDVsoqRw1TnlYvobwA
         CkLr4b/QYT5jPvK22QFNO+mD8BMiFZOwMju5eEDtEzUsWY0QJKDsi32WFJg3uQZepBoL
         HNNIPvdDJGcKU/Mu0GUM8dHfytQNF/Pj4V1l40Bd243h/RiZRYoo5XoZ08v6GyBcVvrX
         aN7zzgOeSLTWgFaKyVxDAa98A+cGf9zZEMEYGKdWJf9GLFVAg2MZjLZu/opVs9mDe7v/
         vWrA==
X-Forwarded-Encrypted: i=1; AJvYcCXa2pKYCzQ1lHJoz3+fdUfEO0HTZsKkhTfn9lpH+Vdy7+DLvzwrdSQjemRPeMh9JqBgGn79paDtiAwXZa4nlOyACFGwHUAAeSKRqpvW
X-Gm-Message-State: AOJu0YzMrjRSChhVHLAR+FEbDrx106Zx9VXkYRfJ4IcxDUnQMXD0uyAN
	uDQuOvf+KtRgl1Uhzo/f2/JkQscAvUG5J0A0ds1Ku7JXiKhCWtGDU2wH7Mq8m3A=
X-Google-Smtp-Source: AGHT+IE7tvMe96r8ufodVrIgG/09n7+ppcky/jlH+QE5cAwmEOUs0YSrCECRwGvXlETqSvXHbeUxYA==
X-Received: by 2002:a05:6602:112:b0:7e1:8829:51f6 with SMTP id ca18e2360f4ac-7eb57237d10mr380861239f.1.1717794475857;
        Fri, 07 Jun 2024 14:07:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a24a37a7sm986679173.133.2024.06.07.14.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 14:07:55 -0700 (PDT)
Message-ID: <987ba13d-e645-496a-8ec8-91b6399efa4c@linuxfoundation.org>
Date: Fri, 7 Jun 2024 15:07:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Modify the watchdog selftest for execution with
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <646f0597-240a-4251-b45e-e45f504734a9@linuxfoundation.org>
 <20240607095347.127823-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240607095347.127823-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 03:53, Laura Nao wrote:
> Hi Shuah,
> 
> On 6/7/24 01:03, Shuah Khan wrote:
>> On 6/6/24 03:57, Laura Nao wrote:
>>> Hi Shuah,
>>>
>>> On 5/6/24 13:13, Laura Nao wrote:
>>>> The watchdog selftest script supports various parameters for testing
>>>> different IOCTLs. The watchdog ping functionality is validated by
>>>> starting
>>>> a loop where the watchdog device is periodically pet, which can only
>>>> be
>>>> stopped by the user interrupting the script.
>>>>
>>>> This results in a timeout when running this test using the kselftest
>>>> runner
>>>> with no non-oneshot parameters (or no parameters at all):
>>
>>
>> Sorry for the delay on this.
>>
>> This test isn't include in the default kselftest run? How are you
>> running this?
>>
> 
> The goal of this series is to enable the test to be run using the
> kselftest runner individually, not as part of the default run. So for
> example w/out args:
> 
> make -C tools/testing/selftests TARGETS=watchdog run_tests
> 
> or with args:
> 
> KSELFTEST_WATCHDOG_TEST_ARGS='-b -d -e -s -t 12 -T 3 -n 7 -N -L' make -C
> tools/testing/selftests TARGETS=watchdog run_tests
>   
>>>>
>>>>     TAP version 13
>>>>     1..1
>>>>     # timeout set to 45
>>>>     # selftests: watchdog: watchdog-test
>>>>     # Watchdog Ticking Away!
>>>>     # .............................................#
>>>>     not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
>>>>
>>>> To address this issue, the first patch in this series limits the
>>>> loop
>>>> to 5
>>>> iterations by default and adds support for a new '-c' option to
>>>> customize
>>>> the number of pings as required.
>>>>
>>>> The second patch conforms the test output to the KTAP format.
>>>>
>>>
>>> Gentle ping - any thoughts on this series? It would simplify running
>>> the
>>> watchdog kselftest in CI environments by leveraging the runner.
>>>
>>
>> This test isn't intended to be included in the default run. It
>> requires
>> loading a watchdog driver first. Do you load the driver from the
>> runner?
>>
> 
> I get this test requires watchdog drivers to be loaded (which in this
> case can't be added to a config fragment that goes with the selftest, as
> they are platform-specific) and therefore cannot be included in the
> default run. However, having ktap output support and limiting the ping
> loop would allow the test to be run individually in the same way as
> other selftests (so through the kselftest runner).
> 
> Naturally, driver dependencies must be met for the test to run and
> produce valid results. From my understanding the runner itself cannot
> ensure this, so in this case it would be up to the user or CI to
> enable/load the appropriate drivers before running the test.
> If these dependencies are not satisfied, the test could just exit
> with a skip code.
> 
> Does this make sense to you? or is the kselftest runner intended to be
> used to run exclusively a subset of tests in the selftests directory
> (i.e. the ones that don't have platform-specific driver requirements)?
> 

There are several tests that aren't included in the default run because
they have dependencies and potentially damaging to the running system.
These tests are not included for a reason.

The first step would to be ensure writing shell script to load and
unload the watchdog module and then pass in existing parameters such
as the oneshot to run the test.

There is no need to add a new parameter yet. Also there is no need to
convert this to ktap yet.

thanks,
-- Shuah




