Return-Path: <linux-kernel+bounces-269547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D2294341B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF41F224C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D41BC075;
	Wed, 31 Jul 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UB39etOI"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8D1799F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443177; cv=none; b=uqWV8eCYFP5BtGrrAQFYNtGVLYPOvKH3EUJVNLanXJafptI00dfAA5fs3buoBLWP7rWPVjcGvSbh3ZlLEh5sjgYYdv8rg3ZO0lZ29TCIQPDq23LRAzAphH4kzHem+2Jq7Rk/L0b3rggLakE8Uw/ATWlUo93dhG8NQSY3Ad0wNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443177; c=relaxed/simple;
	bh=Xl4TiW5SeD2WM656o31Xvn4ZJhLVboZMA3CyRCM21cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uX0Dykzg4HTZwtTFDYhaCs7QNhb5S23ELQZhMfwoDBndaj6ruzwrboLKUqQ26Dho/X0zHSQdbbfoCfEG78PAsJWu5BG1nvs/E9wDxUANiF/4MRiPjnchkDHYDN8880Fj2TNTTYBFEuLjOPsgP4HBd+6dH75ECry0yaCR25I84Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UB39etOI; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-810ca166fd4so35498139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722443174; x=1723047974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESfT6J5DiPicCIoTYmPg83+VN4FfF1ZZyIzlRD0R3PM=;
        b=UB39etOIjsbSzJ83Y9GL3JmAro5r69+LcrWO/DoNtLNSBrDVMoj5nCRqGRgZCfGqo6
         ArNmKpv2fpenptxpVih0XPNpfOJJfF0TKBWa7colrmAMBXqpfppb7fHWyDCyHEKVniPx
         fX6annwYOw6epi+yf8lXJ1/lb+ZxJFhtGwaqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443174; x=1723047974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESfT6J5DiPicCIoTYmPg83+VN4FfF1ZZyIzlRD0R3PM=;
        b=lEKc27yCv6Jm76IZDEVtmanKTUqv1tv9/3HUxhfgVRuReCyYZpfUJcC1J+U2Tgp/s8
         3IdotcLlkbGhfLmDs+1BHqv95R/LGwvWojIe6QOIKRI+Xx9VLG3orYh7cKat0vmaL+G+
         St/4GCJcJ10MrMSZ3J7YEbPdYzR6i2KVbR7s95o0oFSwUPGQZX0P1hcjUtZXKHgn5yBz
         Zl5G5wNP7Zjc3dNzpNWW5sty8SWGq9T7lDTHMp1GGyZ54JVR3rWzLnrwIhkobPHuExpM
         4I+WfGtiCqFif7ezgbrX2HBL3iv0lOWlDJn1Cwxi2fgO8ZOSR5RYrZUp4okpJCXX/W7T
         mWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfUbDTG58Eoz6rWY7bKg0sbW+rqy22QTSC9+k/dzBQdCtsXcEWovUp3OVIWgn6DryFl0WiBmHIbnbmsgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZUyTaf0QJnkDjoEwu2DexciVP0x96Bdc/SVpf2vHOForG0X1
	TVYAVBIGkr/xCU6q/Bc/ek61ZpTkHMsTUAbQ2ezpcEzXhZl1nDi5P6kwbafHgYY=
X-Google-Smtp-Source: AGHT+IGiwZHilRDwsGrCq4IEcRdtEcK65HuE5W0tixLUguurZs7WFY535o9hhl7dIy3NatXECDK8wQ==
X-Received: by 2002:a6b:7b4d:0:b0:81f:c609:df28 with SMTP id ca18e2360f4ac-81fc609df84mr145755339f.3.1722443173857;
        Wed, 31 Jul 2024 09:26:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc3cea7sm3238717173.153.2024.07.31.09.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:26:13 -0700 (PDT)
Message-ID: <c41b8745-d7c9-4ff7-93df-3dd771c30a56@linuxfoundation.org>
Date: Wed, 31 Jul 2024 10:26:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: David Gow <davidgow@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
 <49108735-c776-4b6f-8264-62a827dd7b26@collabora.com>
 <0c2a5c8e-e48a-40f1-bc84-01669a5b8741@linuxfoundation.org>
 <CABVgOSmTtox4kdEFHwkZR=N0iHQY3tpugWSFU0exYzHOHYJp_Q@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmTtox4kdEFHwkZR=N0iHQY3tpugWSFU0exYzHOHYJp_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 21:06, David Gow wrote:
> On Tue, 30 Jul 2024 at 23:49, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/29/24 02:29, Muhammad Usama Anjum wrote:
>>> On 7/27/24 12:26 AM, Shuah Khan wrote:
>>>> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
>>>>> In this series, test_bitmap is being converted to kunit test. Multiple
>>>>> patches will make the review process smooth.
>>>>>
>>>>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
>>>>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
>>>>>               configuration options
>>>>> - Patch-3: Remove the bitmap.sh selftest
>>>>>
>>>>> Muhammad Usama Anjum (3):
>>>>>      bitmap: convert test_bitmap to KUnit test
>>>>>      bitmap: Rename module
>>>>>      selftests: lib: remove test_bitmap
>>>>>
>>>>>     MAINTAINERS                           |   2 +-
>>>>>     lib/Kconfig.debug                     |  15 +-
>>>>>     lib/Makefile                          |   2 +-
>>>>>     lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
>>>>>     tools/testing/selftests/lib/Makefile  |   2 +-
>>>>>     tools/testing/selftests/lib/bitmap.sh |   3 -
>>>>>     tools/testing/selftests/lib/config    |   1 -
>>>>>     7 files changed, 295 insertions(+), 354 deletions(-)
>>>>>     rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
>>>>>     delete mode 100755 tools/testing/selftests/lib/bitmap.sh
>>>>>
>>>>
>>>> Can you tell me how this conversion helps?
>>>>
>>>> It is removing the ability to run bitmap tests during boot.
>>>> It doesn't make sense to blindly convert all test under lib
>>>> to kunit - Nack on this change or any change that takes away
>>>> the ability to run tests and makes them dependent on kunit.
>>> Let's discuss this on discussion thread [1].
>>
>> So - it doesn't mean that it is a done deal. Each patch will be
>> reviewed on individual basis. This test in particular clearly its
>> use-case right in the config which was deleted without understanding
>> it.
>>
>> -config TEST_BITMAP
>> -       tristate "Test bitmap_*() family of functions at runtime"
>> -       help
>> -         Enable this option to test the bitmap functions at boot.
>>
>>
>> This line above is the important piece of information which tells
>> you how the test is intended to be used.
>>
>> 1. You can enable this option and boot the kernel to check for regressions.
> 
> Converting the test to KUnit _does not break this_. You can still
> enable this option and boot the kernel to test for regressions if it's
> a KUnit test.
> 
>> 2. You can load the module on a running kernel to check for health.
> 
> This is where the disagreement lies in my mind. While you can do this
> with KUnit, the kernel does have to have been built with CONFIG_KUNIT
> enabled (either built-in or as a module).

Right. It appears the confusion is coming in because "What's the problem
enabling CONFIG_KUNIT". The question is would you recommend enabling
CONFIG_KUNIT in distribution kernels - there is a confusion that
unit testing can be enabled in all environments.

The answer is no. Running tests should not require should not require
CONFIG_KUNIT - I would call this not disagreement, but not understanding
the role of unit (open box) vs closed box testing.

We want to users to be able to run as many tests possible without
needing to enable KUnit or other config options to verify kernels
they build. KUnit is a tool for kernel developers to verify - it
is a unit testing framework that is where it brings value.

It isn't a replacement for selftests and other tests. I am not happy
to seer tests that are supported as kselftests be changed to now
require KUNIT to be enabled.

thanks,
-- Shuah

