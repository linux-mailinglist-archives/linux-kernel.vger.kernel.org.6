Return-Path: <linux-kernel+bounces-268012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACF7941F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E861284C12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C818A6D9;
	Tue, 30 Jul 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="er2n6MOI"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025E18A6A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363436; cv=none; b=mTT4bLU86ehkKtxF9ol5BXAt/iQFYOqISl7nATEqsUer3JCQwX1rd95C+KTcuAiGwjZtdZ/c1VX7xjKqTvo0T7LaQUmQpbNFEUYrnrmPTXeAKa8hlphIdqps0j6E4CIWmH0rbVpF4odnEH5lHZ83XDlpfn2RxNSQGM9+PN/O5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363436; c=relaxed/simple;
	bh=0xYCKqriDm8/FaCQfy0mhXqPqVA08LHGxQL0mq5CEyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehjx2LXjqdnhEqcajfvRN5AwoypfGUEqJ8iAD/c8oxS2i1yYmzcRrZf8FYaDrzu8yB5mnunXhACIZEu/qSRE3MwrmRah5JDsdvPJG8r4txj/iijAiYegs65iEKYWDdDnxgcioKnaHamgHAFlYMOfvm8LJUDR7mCPpu9CVB+7Bmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=er2n6MOI; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-812796ac793so25467239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722363434; x=1722968234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kFXdMSSISnEMJ3bkmlAGx8cLeClwIVmn0jpSwJXKIE=;
        b=er2n6MOIwe2dPxl2B25MN9F3wrwRMu5l8wM1DCEBLtIuiAYaOnaZpsMi31PZ41Au9Q
         idr9qmODhV3yy/CJgKF7C2OYmqqFVsBslVKeyo2WUhPXyJLRx82bhVmjg/mn5MFE7P7G
         wQtWunmLeIj2vhqJXpGuPQCt6dN9Bsd8ksZjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363434; x=1722968234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kFXdMSSISnEMJ3bkmlAGx8cLeClwIVmn0jpSwJXKIE=;
        b=Ol9v0hLA7KHzFPmk68BlN9k/3ElrohfY6GA2EZ6UqcpWzWpwSYk4cW7BTpEi/vucUP
         u6Tu8uKHqCav4XUDNBkR5ARwDZtqu6yPZzoHh9buc+RUTGSqP2Y0F//chWV3psAjrFpx
         VXMyxcIOQbgKeGfX4ktP6DxBG+96SEnrMOR19VbCyxtNPo6WOFPxjFGhS+BvMUvpZ4QG
         2Dh5/27ayhRhncriWbW2tEOY9Q2tEFFZ3GUiTdlX9ftusa4i6zqZKv29CSAETGsNjMjH
         ypveWAVUgk9FXahlpbUob5/WPIW1LKmWcGaNe5NRzoLaCzyfk01k+l6Gh8m7XT136S4u
         4JTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+76sjH2L/QuOpmaqMfxmbgbmxR2DIhjK/70+jVhYsMuyXB/OlviRkfs3Wt+q6eH+heDLDGJIobXx1T8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+NL6hm+tczKsBEej3QdYMXHeW1pCyovog/OM2MKt8ATt7Pft
	B7GSeYyhpiUyzCoEjzHElOTOAHJkpZ0H5loOQQWzOr4WLzXARitP22wSoglmfcM=
X-Google-Smtp-Source: AGHT+IFp5v9TO6qmYv9utxWv+Qtek8u5aXB/S1/Mv5jSUhqJcCZ1BFhOww3oNAPi4ucZAyBm/Z5w4g==
X-Received: by 2002:a5d:9496:0:b0:80a:4582:cef1 with SMTP id ca18e2360f4ac-81f7d00ccbcmr1104272839f.3.1722363434096;
        Tue, 30 Jul 2024 11:17:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8b35847e5sm217894173.114.2024.07.30.11.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:17:13 -0700 (PDT)
Message-ID: <75a2960e-d489-4440-a8e1-487a7f84902e@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:17:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: David Gow <davidgow@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 kees@kernel.org, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <ZqUvy_h4YblYkIXU@yury-ThinkPad>
 <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
 <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
 <CABVgOSnkxgeXXXm9xp5_PvBxtMGbyFN-Jmd6YJ1u6g81MF_fyw@mail.gmail.com>
 <714e7642-6f92-4e41-aa36-c854668e0bb0@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <714e7642-6f92-4e41-aa36-c854668e0bb0@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/24 09:55, Shuah Khan wrote:
> On 7/30/24 04:10, David Gow wrote:
>> On Mon, 29 Jul 2024 at 22:09, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>
>>>
>>> On 7/29/24 1:07 AM, Muhammad Usama Anjum wrote:
>>>> On 7/27/24 10:35 PM, Yury Norov wrote:
>>>>> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
>>>>>> Rename module to bitmap_kunit and rename the configuration option
>>>>>> compliant with kunit framework.
>>>>>
>>>>> ... , so those enabling bitmaps testing in their configs by setting
>>>>> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
>>>>> not realize it until something nasty will happen.
>>>> CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
>>>> test and its config option would disappear. The same test can be run by
>>>> just enabling KUNIT default config option:
>>>>
>>>> KUNIT_ALL_TESTS=y enables this bitmap config by default.
>>>>
>>>>>
>>>>> Sorry, NAK for config rename.
>>>>>
>>>
>>> I agree with Yury. Using KUNIT takes away test coverage for people who
>>> are willing to run selftests but not use KUNIT.
> 
> This is incorrect. There are selftest that are used to
> 
> - regression test a subsystem or a abi during boot
> - spot check on a running system to debug and test by loading
>    a test module.
> 
>>
>> I can see the point that renaming the config option is just churn, but
>> is there a reason people would run the bitmap selftest but be unable
>> or unwilling to use KUnit?
>>
>> Beyond a brief period of adjustment (which could probably be made
>> quite minimal with a wrapper script or something), there shouldn't
>> really be any fundamental difference: KUnit tests can already run at
>> boot, be configured with a config option, and write output to the
>> kernel log. There's nothing really being taken away here, and the
>> bonus of having easier access to run the tests with KUnit's tooling
>> (or have them automatically run by systems which run KUnit tests)
>> would seem worthwhile to me, especially since it's optional. And
>> CONFIG_KUNIT shouldn't be heavy enough to cause problems.
>>

Shouldn't be is the operative word? This doesn't help people who
want run a run bitmap test on a running system. This is a wrong
direction to go to say all testing has to be done under kunit.

What happened to the effort to run selftests as is under KUnit? What
is the motivation to convert all tests to kunit instead of trying to
provide support to run kselftest under kunit environment?

We discussed this a few years ago as I recall. Let's work on that
instead of removing existing selftests and regressing current use-cases?

Can we look into providing:

1. running kselftest under kunit environment without changes
    as user space applications?
2. Leave kselftests alone so we don't weaken kernel testing


thanks,
-- Shuah


