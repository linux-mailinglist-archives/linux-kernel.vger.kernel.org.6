Return-Path: <linux-kernel+bounces-267794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6894E941589
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D385AB242D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815E1A2C1C;
	Tue, 30 Jul 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZoLnHw5t"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5718A92F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353949; cv=none; b=YI+hGXP0wugQ0Xgioo9ewyZnvmiAy1wy6l0n8YDtU1eSaRtsAhXzi1Ou8rBv0xHJIsMcU9XQEAViGGLhz7kVg540USydTQcJD/kFoB0viYFkvtigFlLBM5FkN65+nOjvdpzXi4DTS7RIIIfGvIY/BPhd9mnuV3ey0xH+O7JrJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353949; c=relaxed/simple;
	bh=EuOAVnCfp4UPWA3GDFWqZGwtcWgvBjh1FB/hCL0uDPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoQgqnkCg4Q4pQbPV3xHkQeSRdOX93m87veEkMbjMYtIGffLlZastiaqfrIVwDrKVWyAaiDn1j9o4CN88tXNJQMR/YOjKnyLDOiXuDmGfFPLzseSytY//XQBjLM302Orxqv37DcaOz5bJa8z9biHCrxHBQRkZwtyCxwJMx9V6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZoLnHw5t; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f8add99b6so24222639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722353947; x=1722958747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0rNsVfVxHhsdywLQglfquF9Nsn/0VQBGq8UofzYVRQ=;
        b=ZoLnHw5tT3K/tbtNusw2bKFU8xiM5FEO1R2JElP9lOoWnVFO6NLGd6/oGPm2rOEBtM
         lxEDMmtDxk+yscLiMIM0AirSRNl3MipCAutcjR96jCSPCdoq+YjYL6YH9dIZOjepufiV
         L0e9pikRvVHCk75ZRrBzNK5+Vx4DyE7EH4svo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353947; x=1722958747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0rNsVfVxHhsdywLQglfquF9Nsn/0VQBGq8UofzYVRQ=;
        b=MCuYsPQHsO1tt+Qm22XuzCnqIKmAgaujF87NAADnr0L0ZsGWzocz9Vu6a/+2rPPinT
         n3oCr1GOEpG4OPMRlizECRVSrBygwR9NXjp0QgLT8SrxCrKy1YbQ4VLUR9rCspSykNam
         TUi2RKqFgdPFUJtYq6ILPKJRWsM3L3p/gnbSWQzsqnp+JGjeyJYYtHXdwkhOZc14dK2o
         zIX8y4Yrz4oDeUajFOn30xiP+JdiG5R8IsqEUi2FUwm1izCOK4TCINZ0K1pKxxapH/2A
         1TY2FOvGcsOhbUeGCLJEpsHtSWq1LFTv6GAMTksxtrpE84oj/cafm599nBLKM8jWpn46
         PckA==
X-Forwarded-Encrypted: i=1; AJvYcCW981GP2jvpQtsG/urGxHMnmok3g1Dqqlgf0Hg5GRUho3vPOgqrSDyFsiop7jEm5CJcNtQUNcmB4QT6MyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYojlECK0QroucOPzXcfSsdbfMLFiT/dPRLgBTUM/Y8BVMtp/
	GBAT8H3v7gHPAYIKCYmq+Dto53zFvcuEnetJjYALV6n0Wbsr7fZNX3gWYHuauuk=
X-Google-Smtp-Source: AGHT+IHXpdRbt7OnQYEhsMCYwVoxdHvywHE8ECfsi0p/tWLmPyPxJ/MPcBGhL51cOz9Ryh96cLkScA==
X-Received: by 2002:a05:6602:255c:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-81f86e15d89mr1016311639f.2.1722353946614;
        Tue, 30 Jul 2024 08:39:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9fabsm2760142173.91.2024.07.30.08.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:39:06 -0700 (PDT)
Message-ID: <38f98707-3317-47f6-97f6-ef1f80bfeadd@linuxfoundation.org>
Date: Tue, 30 Jul 2024 09:39:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kees@kernel.org, David Gow <davidgow@google.com>,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
 <ZqU4FANdHOvpGc5t@yury-ThinkPad>
 <5d5b2042-f006-4c9b-b8a5-a28cbc3c7f5e@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5d5b2042-f006-4c9b-b8a5-a28cbc3c7f5e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 02:15, Muhammad Usama Anjum wrote:
> On 7/27/24 11:10 PM, Yury Norov wrote:
>> On Fri, Jul 26, 2024 at 01:26:48PM -0600, Shuah Khan wrote:
>>> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
>>>> In this series, test_bitmap is being converted to kunit test. Multiple
>>>> patches will make the review process smooth.
>>>>
>>>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
>>>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
>>>>              configuration options
>>>> - Patch-3: Remove the bitmap.sh selftest
>>>>
>>>> Muhammad Usama Anjum (3):
>>>>     bitmap: convert test_bitmap to KUnit test
>>>>     bitmap: Rename module
>>>>     selftests: lib: remove test_bitmap
>>>>
>>>>    MAINTAINERS                           |   2 +-
>>>>    lib/Kconfig.debug                     |  15 +-
>>>>    lib/Makefile                          |   2 +-
>>>>    lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
>>>>    tools/testing/selftests/lib/Makefile  |   2 +-
>>>>    tools/testing/selftests/lib/bitmap.sh |   3 -
>>>>    tools/testing/selftests/lib/config    |   1 -
>>>>    7 files changed, 295 insertions(+), 354 deletions(-)
>>>>    rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
>>>>    delete mode 100755 tools/testing/selftests/lib/bitmap.sh
>>>>
>>>
>>> Can you tell me how this conversion helps?
>>>
>>> It is removing the ability to run bitmap tests during boot.
>>> It doesn't make sense to blindly convert all test under lib
>>> to kunit - Nack on this change or any change that takes away
>>> the ability to run tests and makes them dependent on kunit.
>>
>> Hi Muhammad,
>>
>> In addition to Shuah's and John's reasoning. This patch wipes the
>> test history (git blame will point on you for most of the test),
> When files are renamed, their history isn't lost. We just need to use
> --follow option with git log to get complete history[1].
> 
>> breaks boot-time testing support, messes with config names and
>> usability, and drops kselftest support for ... exactly, what?
> AFAIU the kselftest wasn't detected the test results that's why I started
> thinking on which could be best way to detect if any failure happens in
> this test. Triggering the test from kselftest doesn't grantee the test it
> would pass every time until we check results. For this kind of in-kernel
> testing, kunit is best suites. Please find earlier discussion [2].
> 

KUnit isn't idea for cases where people would want to check a subsystem
on a running kernel - KUnit covers some use-cases and kselftest covers
others.

What happens if we are debugging a problem that requires us to debug on
a running system? Please don't go converting kselftest into kunit without
understanding how these are intended to be used.

Yes kselftest results need to be looked at. Write a parser which can
be improved. What you are doing is reducing the coverage and talking
away the ability to debug and test on running system.

Fix what needs to be fixed instead of deleting tests.

>>
>> KUNIT engine here doesn't improve on readability, neither shorten
>> the test length, to my taste.
>>
>> If you'd like to contribute to bitmaps testing - I'm all for that.
>> This is the very core and performance-sensitive piece of kernel,
>> and any extra-coverage is always welcome.
>>

+1 on this. Add new tests and look at the reports.

>> But I think the best way would be either adding new cases to the
>> existing test, or writing a new test, KUNIT-based, if you like.
>>
> 

+1

As I mentioned in my earlier message, I am going to nack all patches
that convert existing selftests to kunit such as this one.

thanks,
-- Shuah


