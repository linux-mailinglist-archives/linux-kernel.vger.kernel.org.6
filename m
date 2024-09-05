Return-Path: <linux-kernel+bounces-317847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F996E46E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9076C1C23E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C21A4F08;
	Thu,  5 Sep 2024 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWXNffVR"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705221A4F13
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569478; cv=none; b=WKvuYVtQaG2QlLPuWDxmVJSd1qv65POyV+E0aM3iJ7vSMQd0lt1O2H0tmPmX2eOwbZdWv7m+JiNldDpjrtj/3I3h40gbbtbldeNGKwtORBed+UheNPEiipVpF9ng7Gg/LqfkC6235hKaFnigzXL9xjA3iS4uZ+6Gcv/XEOHSFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569478; c=relaxed/simple;
	bh=J2rP/br0hWv4OHDbl2HNYBrJkl3/C1Bc7GkaM6DRb2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPj9jcIc8QJUoUqopqhcBBMDeSuhvDME5MPiSJYp9RUzjJOk/S/yJ/WcM6HPX3aOIgC6hmrCGUdcpKXta8JqIwX2EHCZ1FzxdiYuJI3vdfZc/fRSqcz72WDTZipzl+3795V6bFENEbkVqo0+DXpjyU6JTk3ApywuAa5i4QxXzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWXNffVR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7143165f23fso1054219b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725569476; x=1726174276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2NvshF8/ZtPNMsxmp/JkcJcQCwOKNjq+EiTXFOfxL0=;
        b=RWXNffVRnVwtRHWNfzHj7wrYK9MzwSgmbz+oU1xWj+cOBW7sdSKHR1KHDAZx+RsZTb
         tq5Ur8VGbzcNS6ls8J7C1LMBb5iTvZsEmepfJxYQE+YAoEsM8lPHxoYdC+6tDxe4bolj
         TQppwL1aaanSJFlj7IfvFz09XjCwY9/DrVPQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725569476; x=1726174276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2NvshF8/ZtPNMsxmp/JkcJcQCwOKNjq+EiTXFOfxL0=;
        b=IhzupPeTicidjHYKEl0tnNSLUNykv06qnUu+E2XTb7fZq5Vi5KBx1tLTQHHq1ktqIa
         gyoU61ezr99Lb0p/a6/WDMtuaE9LXjO9e0qXt3SMcA8OBdDclFl9A6gM5WiSvTJLxure
         ZiSv7nU0KOjecQszm+csq6tEIUFBMlEowO2XfmG1bWd/hkGqukWESoK9WwRwA/Mi4NxD
         Trp8sBsEYuUgBGxXfvZDx03yGjgwu0YPHrWg85Hq4tWeqolfyUI9usp+Zr/7ByMRDNTR
         1KEB5newt5uN4ULx6Yrcg+m1EfB/N/jWGAWxea7GDjU0SSb4SocfqYxt0o42tS+q6ME9
         Q24g==
X-Forwarded-Encrypted: i=1; AJvYcCUwfSFgktuAVkjuaQE7YGRT/cNZFCw6Ly80EtxBF0syJCrKGSDA1jzLgYrE3Ko55bGgMP/nXYRvPlG7nyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGHUoNwiClOKt1Hgw8n5MjNYCl/SuZMuoMwGFx5uD4MEfSuHX
	tXoWgnIu8QkUg2jkUaYp502YTSqPL9oRloy2QUTcv4F2AFA98TwdkUMNq+iFXtQ=
X-Google-Smtp-Source: AGHT+IHaez+gLJRaVGB1GHyftvHz9kaE9lhikt1k+E8IgxrNSnpyzsh3WBBD9mZjJcJcphKFqH219A==
X-Received: by 2002:a05:6a21:10b:b0:1cf:36c:446c with SMTP id adf61e73a8af0-1cf1d2290f0mr259604637.47.1725569475603;
        Thu, 05 Sep 2024 13:51:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b520fsm3590967b3a.187.2024.09.05.13.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 13:51:15 -0700 (PDT)
Message-ID: <6248ae6a-c11e-466d-a32e-e9db15472777@linuxfoundation.org>
Date: Thu, 5 Sep 2024 14:51:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
To: Reinette Chatre <reinette.chatre@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu
 <fenghua.yu@intel.com>,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
 <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
 <d2a4ca5c-3352-e570-687c-9d7ec90dbe33@linux.intel.com>
 <b4b7147f-64cf-4244-a896-07a88f08d0f1@linuxfoundation.org>
 <d8ffc136-876b-db3f-fc87-a1442e53a451@linux.intel.com>
 <f65237fe-a1b9-4d63-9a06-dd7a49765c9f@linuxfoundation.org>
 <1e7c1609-342f-404e-b5eb-87528ee1b4f0@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1e7c1609-342f-404e-b5eb-87528ee1b4f0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/24 14:43, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 9/5/24 11:06 AM, Shuah Khan wrote:
>> On 9/4/24 06:54, Ilpo Järvinen wrote:
>>> On Wed, 4 Sep 2024, Shuah Khan wrote:
>>>
>>>> On 9/4/24 06:18, Ilpo Järvinen wrote:
>>>>> On Tue, 3 Sep 2024, Shuah Khan wrote:
>>>>>
>>>>>> On 9/3/24 08:45, Ilpo Järvinen wrote:
>>>>>>> This series first generalizes resctrl selftest non-contiguous CAT check
>>>>>>> to not assume non-AMD vendor implies Intel. Second, it improves
>>>>>>> selftests such that the use of __cpuid_count() does not lead into a
>>>>>>> build failure (happens at least on ARM).
>>>>>>>
>>>>>>> While ARM does not currently support resctrl features, there's an
>>>>>>> ongoing work to enable resctrl support also for it on the kernel side.
>>>>>>> In any case, a common header such as kselftest.h should have a proper
>>>>>>> fallback in place for what it provides, thus it seems justified to fix
>>>>>>> this common level problem on the common level rather than e.g.
>>>>>>> disabling build for resctrl selftest for archs lacking resctrl support.
>>>>>>>
>>>>>>> I've dropped reviewed and tested by tags from the last patch in v3 due
>>>>>>> to major changes into the makefile logic. So it would be helpful if
>>>>>>> Muhammad could retest with this version.
>>>>>>>
>>>>>>> Acquiring ARCH in lib.mk will likely allow some cleanup into some
>>>>>>> subdirectory makefiles but that is left as future work because this
>>>>>>> series focuses in fixing cpuid/build.
>>>>>>
>>>>>>>
>>>>>>> v4:
>>>>>>> - New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
>>>>>>>      (would cause __cpuid_count() related build fail otherwise)
>>>>>>>
>>>>>> I don't like the way this patch series is mushrooming. I am not
>>>>>> convinced that changes to lib.mk and x86 Makefile are necessary.
>>>>>
>>>>> I didn't like it either what I found from the various makefiles. I think
>>>>> there are many things done which conflict with what lib.mk seems to try to
>>>>> do.
>>>>>
>>>>
>>>> Some of it by desig. lib.mk offers framework for common things. There
>>>> are provisions to override like in the case of x86, powerpc. lib.mk
>>>> tries to be flexible as well.
>>>>
>>>>> I tried to ask in the first submission what test I should use in the
>>>>> header file as I'm not very familiar with how arch specific is done in
>>>>> userspace in the first place nor how it should be done within kselftest
>>>>> framework.
>>>>>
>>>>
>>>> Thoughts on cpuid:
>>>>
>>>> - It is x86 specific. Moving this to kselftest.h was done to avoid
>>>>    duplicate. However now we are running into arm64/arm compile
>>>>    errors due to this which need addressing one way or the other.
>>>>
>>>> I have some ideas on how to solve this - but I need answers to
>>>> the following questions.
>>>>
>>>> This is a question for you and Usama.
>>>>
>>>> - Does resctrl run on arm64/arm and what's the output?
>>>> - Can all other tests in resctrl other tests except
>>>>    noncont_cat_run_test?
>>>> - If so send me the output.
>>>
>>> Hi Shuah,
>>>
>>> As mentioned in my coverletter above, resctrl does not currently support
>>> arm but there's an ongoing work to add arm support. On kernel side it
>>> requires major refactoring to move non-arch specific stuff out from
>>> arch/x86 so has (predictably) taken long time.
>>>
>>> The resctrl selftests are mostly written in arch independent way (*) but
>>> there's also a way to limit a test only to CPUs from a particular vendor.
>>> And now this noncont_cat_run_test needs to use cpuid only on Intel CPUs
>>> (to read the supported flag), it's not needed even on AMD CPUs as they
>>> always support non-contiguous CAT bitmask.
>>>
>>> So to summarize, it would be possible to disable resctrl test for non-x86
>>> but it does not address the underlying problem with cpuid which will just
>>> come back later I think.
>>>
>>> Alternatively, if there's some a good way in C code to do ifdeffery around
>>> that cpuid call, I could make that too, but I need to know which symbol to
>>> use for that ifdef.
>>>
>>> (*) The cache topology may make some selftest unusable on new archs but
>>> not the selftest code itself.
>>>
>>>
>>
>> I agree that suppressing resctrl build is not a solution. The real problem
>> is is in defining __cpuid_count() in common code path.
>>
>> I fixed it and send patch in. As I was testing I noticed the following on
>> AMD platform:
>>
>> - it ran the L3_NONCONT_CAT test which is expected.
>>
>> # # Starting L3_NONCONT_CAT test ...
>> # # Mounting resctrl to "/sys/fs/resctrl"
>> # ARCH_AMD - supports non-contiguous CBM
>> # # Write schema "L3:0=ff" to resctrl FS
>> # # Write schema "L3:0=fc3f" to resctrl FS
>> # ok 5 L3_NONCONT_CAT: test
>>
>> - It went on to run L2_NONCONT_CAT - failed
> 
> It is not intended to appear as a failure but instead just skipping of
> a test since the platform does not support the feature being tested.
> 
>>
>> # ok 6 # SKIP Hardware does not support L2_NONCONT_CAT or L2_NONCONT_CAT is disabled
> 
> The output looks as intended. When I run the test on an Intel system without
> L2 CAT the output looks the same.
> 
>>
>> Does it make sense to run both L3_NONCONT_CAT and L2_NONCONT_CAT
>> on AMD? Maybe it is? resctrl checks L3 or L2 support on Intel.
> 
> The selftests test the features as exposed by the generic resctrl kernel
> subsystem instead of relying on its own inventory of what features
> need to be checked for which vendor. selftests will thus only
> test L3 or L2 if resctrl kernel subsystem indicates it is supported on
> underlying platform. Only afterwards may it use platform specific
> knowledge to help validate the feature.
> In this scenario resctrl indicated that L2 CAT is not supported
> by underlying platform and the test was skipped. It looks good
> to me.
> 

Thanks for the detailed explanation. Sounds good to me.

thanks,
-- Shuah


