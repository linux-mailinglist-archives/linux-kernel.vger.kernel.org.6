Return-Path: <linux-kernel+bounces-317657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61F796E188
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E191AB22D21
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9317B4FA;
	Thu,  5 Sep 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VS1rjWxh"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD117BA7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559611; cv=none; b=mn+OmV5oqntl5XdBI6GsXyHoZeZCiz0NzvDEiYHgf99elLXpi5/NSA2GIYAmyNnNW09ZGyQzl5VZcIwkBPKAKlMZHEIkP99j8kD5Sdj7Pb0DF6Ll0zg+Vb4jZK3HwvONu/9QEKgoyVese6PWRBs6ApxorKCiZZVoMzi+GrxCykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559611; c=relaxed/simple;
	bh=jr/TuNoxjf8E90u+hMbdStpxIpjykTzcEnkOAwaTGYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uyhj1iCYrzhPMbIhB054RskrK2R+eh+HW67drLimgxpZ7YhECHId9FPuM/B002g3JEfphjslXUXQH7oi1XsYaeUbATr044V+LTLV0x06O6ubhJ942mwgRXAgY/8RGouIBoOK8jdBSTkWlSDXqA90lWL5iczcQHaQd22/DaJugHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VS1rjWxh; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82a3acaa1bbso39743739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725559609; x=1726164409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcyGNCRPFzfZIrApFPczHK3nKz5gOIlO6ExrEkXod08=;
        b=VS1rjWxhGvG3Ux074Vbk476kUdendNK0XCxCkFv7slSLkCH2k5RyzMeVW+v58papqE
         XJ9w8IgjNSrwcrRfuwagr5plFjgheD/ivOjQM1aMki/h9cxIcvVgs3pDnNziMnj5rYCZ
         0tfzBFObyOai+6tgDQ8OcMRoOEWPJ2JeYRvhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559609; x=1726164409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcyGNCRPFzfZIrApFPczHK3nKz5gOIlO6ExrEkXod08=;
        b=W68BT9D2AG3goh0OHXG/+udkJy6LM2RK66TSmCzsVUJJ8SH4yBc4WtHtIpbgTUeYi6
         FUgqsgbVawlTLy9mVwNiEWA73hONu+UaGIQslrajKAhYMVGJLl7hhVu/i9kNYPN5Ualy
         t9UF3LWbJDp9zyCfzhdB5zCIy4z9s9Ku84lgpSDif4hCnbbx+KgaQFGQMvW/hDM91H3h
         D6BcAoPGCOWy/STSL+PUffn5z5qXGqcwMfY79LT7ghyHX2KVsxSPiGyLJOsIyMFkRiWh
         /pZEGwDYULD8uKyXh+rZQ45cos4yFs1ZzmeV8/84RsP+WqSfg716zS5BdWk4KeXBcbDy
         WRaw==
X-Forwarded-Encrypted: i=1; AJvYcCWXVX3/zxvU1Rpm+wvZ2FQuZu0JeSF8wB+uu/y0tfCtgIHW6t/sQXfCRcvvDlgBtObbzAA11/+PIy0UrF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TTxcEApA9zXmiTkc3xEo8YOAN/R6rMUVNDFOjZcu5KYBAtWI
	zIupTDjfFyMo+vfiAH2N3EMpY29zUBYpI23YzFszQ3MFKuvrDaNoJEd/gNf++aY=
X-Google-Smtp-Source: AGHT+IFYb2H7I+Fm5f41GXCnjWtRvinZelqwmrZeSDKCjld2tXbxa9Wl+ZeRwMYp1rfSByF3y1Q3dQ==
X-Received: by 2002:a05:6602:2d8e:b0:82a:4480:badc with SMTP id ca18e2360f4ac-82a4480bcc7mr1988924939f.10.1725559608677;
        Thu, 05 Sep 2024 11:06:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a4990a6sm429977339f.43.2024.09.05.11.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 11:06:48 -0700 (PDT)
Message-ID: <f65237fe-a1b9-4d63-9a06-dd7a49765c9f@linuxfoundation.org>
Date: Thu, 5 Sep 2024 12:06:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu
 <fenghua.yu@intel.com>,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
 <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
 <d2a4ca5c-3352-e570-687c-9d7ec90dbe33@linux.intel.com>
 <b4b7147f-64cf-4244-a896-07a88f08d0f1@linuxfoundation.org>
 <d8ffc136-876b-db3f-fc87-a1442e53a451@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d8ffc136-876b-db3f-fc87-a1442e53a451@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 06:54, Ilpo Järvinen wrote:
> On Wed, 4 Sep 2024, Shuah Khan wrote:
> 
>> On 9/4/24 06:18, Ilpo Järvinen wrote:
>>> On Tue, 3 Sep 2024, Shuah Khan wrote:
>>>
>>>> On 9/3/24 08:45, Ilpo Järvinen wrote:
>>>>> This series first generalizes resctrl selftest non-contiguous CAT check
>>>>> to not assume non-AMD vendor implies Intel. Second, it improves
>>>>> selftests such that the use of __cpuid_count() does not lead into a
>>>>> build failure (happens at least on ARM).
>>>>>
>>>>> While ARM does not currently support resctrl features, there's an
>>>>> ongoing work to enable resctrl support also for it on the kernel side.
>>>>> In any case, a common header such as kselftest.h should have a proper
>>>>> fallback in place for what it provides, thus it seems justified to fix
>>>>> this common level problem on the common level rather than e.g.
>>>>> disabling build for resctrl selftest for archs lacking resctrl support.
>>>>>
>>>>> I've dropped reviewed and tested by tags from the last patch in v3 due
>>>>> to major changes into the makefile logic. So it would be helpful if
>>>>> Muhammad could retest with this version.
>>>>>
>>>>> Acquiring ARCH in lib.mk will likely allow some cleanup into some
>>>>> subdirectory makefiles but that is left as future work because this
>>>>> series focuses in fixing cpuid/build.
>>>>
>>>>>
>>>>> v4:
>>>>> - New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
>>>>>      (would cause __cpuid_count() related build fail otherwise)
>>>>>
>>>> I don't like the way this patch series is mushrooming. I am not
>>>> convinced that changes to lib.mk and x86 Makefile are necessary.
>>>
>>> I didn't like it either what I found from the various makefiles. I think
>>> there are many things done which conflict with what lib.mk seems to try to
>>> do.
>>>
>>
>> Some of it by desig. lib.mk offers framework for common things. There
>> are provisions to override like in the case of x86, powerpc. lib.mk
>> tries to be flexible as well.
>>
>>> I tried to ask in the first submission what test I should use in the
>>> header file as I'm not very familiar with how arch specific is done in
>>> userspace in the first place nor how it should be done within kselftest
>>> framework.
>>>
>>
>> Thoughts on cpuid:
>>
>> - It is x86 specific. Moving this to kselftest.h was done to avoid
>>    duplicate. However now we are running into arm64/arm compile
>>    errors due to this which need addressing one way or the other.
>>
>> I have some ideas on how to solve this - but I need answers to
>> the following questions.
>>
>> This is a question for you and Usama.
>>
>> - Does resctrl run on arm64/arm and what's the output?
>> - Can all other tests in resctrl other tests except
>>    noncont_cat_run_test?
>> - If so send me the output.
> 
> Hi Shuah,
> 
> As mentioned in my coverletter above, resctrl does not currently support
> arm but there's an ongoing work to add arm support. On kernel side it
> requires major refactoring to move non-arch specific stuff out from
> arch/x86 so has (predictably) taken long time.
> 
> The resctrl selftests are mostly written in arch independent way (*) but
> there's also a way to limit a test only to CPUs from a particular vendor.
> And now this noncont_cat_run_test needs to use cpuid only on Intel CPUs
> (to read the supported flag), it's not needed even on AMD CPUs as they
> always support non-contiguous CAT bitmask.
> 
> So to summarize, it would be possible to disable resctrl test for non-x86
> but it does not address the underlying problem with cpuid which will just
> come back later I think.
> 
> Alternatively, if there's some a good way in C code to do ifdeffery around
> that cpuid call, I could make that too, but I need to know which symbol to
> use for that ifdef.
> 
> (*) The cache topology may make some selftest unusable on new archs but
> not the selftest code itself.
> 
> 

I agree that suppressing resctrl build is not a solution. The real problem
is is in defining __cpuid_count() in common code path.

I fixed it and send patch in. As I was testing I noticed the following on
AMD platform:

- it ran the L3_NONCONT_CAT test which is expected.

# # Starting L3_NONCONT_CAT test ...
# # Mounting resctrl to "/sys/fs/resctrl"
# ARCH_AMD - supports non-contiguous CBM
# # Write schema "L3:0=ff" to resctrl FS
# # Write schema "L3:0=fc3f" to resctrl FS
# ok 5 L3_NONCONT_CAT: test

- It went on to run L2_NONCONT_CAT - failed

# ok 6 # SKIP Hardware does not support L2_NONCONT_CAT or L2_NONCONT_CAT is disabled

Does it make sense to run both L3_NONCONT_CAT and L2_NONCONT_CAT
on AMD? Maybe it is? resctrl checks L3 or L2 support on Intel.

Anyway - the problem is fixed now. Please review and test.

thanks,
-- Shuah

