Return-Path: <linux-kernel+bounces-288181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797559536F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F21C20F52
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2B1AC437;
	Thu, 15 Aug 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vf4Y5PFn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B817BEA5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735227; cv=none; b=sk00GrS5zA4jE3gufGaqXCFxBlYrM2lg9NOIGbiYLkxRnbc39dVNU8PA6mgr0p01Xvch1lKjE3PwIVFpmdVAuA4aZ1/cMEJk3PPYzpwh5h+oQVLIVo95G/0JHlSJ9yNLpVqoNooRm7uWyMQP4lwwaUatiVEuDqLybT387V2jgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735227; c=relaxed/simple;
	bh=kynn0aDXaFm7QAh66HtBgvf/rrrNs3iw+NMTFkx0KDY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QWzNx6AdjeMGsHbj7Z793EHDNKlByi6gMttxQlqmz1cwvqMktI8/lm4o+WhEhQPstoFIyQ7J7oNNEf5kCoQUmEcE+mt6rBODIy2e79EKaxGYkHMavR82YPQbBgzHSWwiyIiJGBoj52NUbQwAedcSiHigFfy8VUogcfeBnt0Eim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vf4Y5PFn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-429e29933aaso6911125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723735224; x=1724340024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77DObEs8JyX6qlVaOpYeNL1lsgUGU/YYzxon+g94vZI=;
        b=Vf4Y5PFnC2jj8sD8W+d8QIuhfqcgriqMLFpufLwm0K3V+No8ye/qohcoQBgPW2HCPM
         EabEB4j8oamG9ril8Yo/3/lQm0wrDU1sikoV7wGOXu256iCV97+K2J0BOX32oSQjvegp
         GugoVPpEqAaVsGjerRL1yfUub+bTKDkeE99MgGjW0ZcbmSzFZJZWeMFNXUflSSQrATeQ
         6A8lAJ9Pm06doRRkJe4gemMtvLh56ji9noA5DP86nnqtB3/D2Q7/BPuoGdwcY6ISgH76
         m1Xnjz7QUAolB8DNsrM27MHcfY78kZcyUldt/7kBPSUgsDjhbui+aTxjhBR6qU20aWyO
         tApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735224; x=1724340024;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77DObEs8JyX6qlVaOpYeNL1lsgUGU/YYzxon+g94vZI=;
        b=QJ51DLgTBMJO24xo2vvQ+bjwG6zPTygLONurpo7lVwnCo6Woaqs9vvLxHPAjmHyaab
         6y2KlWNQi2g50ZRW8aSvpmhFVAPVMX7Si3uWG0B3BJKJgIuU4DRgRFfGRZTXNKGXQ9i9
         mJlbA1C53YRjBn5ELS7tMnigOBJ1DN8qDqs/V3RAiT03hDohs12ujZnckmWQYMbJR2Lq
         3tkzj7vzBvlCbWBskxJ3f4yehhu4QYNg6ZHoZhAHH578j4UOxtr635K7WLO0bJ6OkOCG
         sKRm6hMS/WOvzFf9OK6U7ALVPhXw8TxljHa5Ta/ieKlShjHXBZA9ktBh62nHFt5AUflU
         /2ag==
X-Forwarded-Encrypted: i=1; AJvYcCUSU/iCMjyWSD2+mESJ8GEaItdM7Tr2FMXTyDhh23FMXNF/Ps8MeAQEgRm8LbvJF4aRrHWJ8UmYStnReLT1TPzzbl9vEKfa+Ms/FsFD
X-Gm-Message-State: AOJu0YweOWyzIchloSqUnLxBS4oxNGFubXtqKfTIEIYNtZMAYMiKmrc2
	PihK+5MCcM2acNmme3udqh8yM+lAOk2hZxb1qCRTquWRcAurHCm33StiuZ3fVcU=
X-Google-Smtp-Source: AGHT+IGqMleaD0yuCnI3sW+DxpEGDkIUT2PMFVSMNi6ePjupPJkLEGDnKEcO/CRoXc3Deb9XPcPDdg==
X-Received: by 2002:a05:600c:1990:b0:428:1d27:f3db with SMTP id 5b1f17b1804b1-429dd26c213mr40980305e9.35.1723735223450;
        Thu, 15 Aug 2024 08:20:23 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a3a3sm1773010f8f.12.2024.08.15.08.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 08:20:22 -0700 (PDT)
Message-ID: <351904c9-d661-46bc-94cf-b6cea8371dad@linaro.org>
Date: Thu, 15 Aug 2024 16:20:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
From: James Clark <james.clark@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Clark <james.clark@arm.com>, "cc: Marc Zyngier" <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org> <ZrzeRM3ekLl9zp3z@x1>
 <348ea015-eccf-4f44-a332-a1d9d8baf81f@linaro.org>
Content-Language: en-US
In-Reply-To: <348ea015-eccf-4f44-a332-a1d9d8baf81f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/08/2024 4:15 pm, James Clark wrote:
> 
> 
> On 14/08/2024 5:41 pm, Arnaldo Carvalho de Melo wrote:
>> On Wed, Aug 14, 2024 at 05:28:42PM +0100, James Clark wrote:
>>>
>>>
>>> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
>>>> On 01.08.24 21:05, Ian Rogers wrote:
>>>>> On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
>>>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>
>>>>>> [TLDR: This mail in primarily relevant for Linux kernel regression
>>>>>> tracking. See link in footer if these mails annoy you.]
>>>>>>
>>>>>> On 22.11.23 00:43, Bagas Sanjaya wrote:
>>>>>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost 
>>>>>>>> everything), and
>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) 
>>>>>>>> since v6.5.
>>>>>>
>>>>>> #regzbot fix: perf parse-events: Make legacy events lower priority 
>>>>>> than
>>>>>> sysfs/JSON
>>>>>> #regzbot ignore-activity
>>>>>
>>>>> Note, this is still broken.
>>>>
>>>> Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
>>>> this? Or is this a "we are screwed one way or another and someone 
>>>> has to
>>>> bite the bullet" situation?
>>>>
>>>> Ciao, Thorsten
>>>>
>>>>> The patch changed the priority in the case
>>>>> that you do something like:
>>>>>
>>>>> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
>>>>>
>>>>> but if you do:
>>>>>
>>>>> $ perf stat -e 'cycles' benchmark
>>>>>
>>>>> then the broken behavior will happen as legacy events have priority
>>>>> over sysfs/json events in that case. To fix this you need to revert:
>>>>> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
>>>>> events over legacy"
>>>>>
>>>>> This causes some testing issues resolved in this unmerged patch 
>>>>> series:
>>>>> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
>>>>>
>>>>> There is a bug as the arm_dsu PMU advertises an event called "cycles"
>>>>> and this PMU is present on Ampere systems. Reverting the commit above
>>>>> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
>>>>> __evlist__add_default") to fix ARM's BIG.little systems (opening a
>>>>> cycles event on all PMUs not just 1) will cause the arm_dsu event to
>>>>> be opened by perf record and fail as the event won't support sampling.
>>>>>
>>>>> The patch 
>>>>> https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
>>>>> fixes this by only opening the cycles event on core PMUs when choosing
>>>>> default events.
>>>>>
>>>>> Rather than take this patch the revert happened as Linus runs the
>>>>> command "perf record -e cycles:pp" (ie using a specified event and not
>>>>> defaults) and considers it a regression in the perf tool that on an
>>>>> Ampere system to need to do "perf record -e
>>>>> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
>>>>> will choose the cycles event correctly and with better precision the
>>>>> pp for systems that support it, but it was still considered a
>>>>> regression in the perf tool so the revert was made to happen. There is
>>>>> a lack of perf testing coverage for ARM, in particular as they choose
>>>>> to do everything in a different way to x86. The patch in question was
>>>>> in the linux-next tree for weeks without issues.
>>>>>
>>>>> ARM/Ampere could fix this by renaming the event from cycles to
>>>>> cpu_cycles, or by following Intel's convention that anything uncore
>>>>> uses the name clockticks rather than cycles. This could break people
>>>>> who rely on an event called arm_dsu/cycles/ but I imagine such people
>>>>> are rare. There has been no progress I'm aware of on renaming the
>>>>> event.
>>>>>
>>>>> Making perf not terminate on opening an event for perf record seems
>>>>> like the most likely workaround as that is at least something under
>>>>> the tool maintainers control. ARM have discussed doing this on the
>>>>> lists:
>>>>> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
>>>>> but since the revert in v6.10 no patches have appeared for the v6.11
>>>>> merge window. Feature work like coresight improvements and ARMv9 are
>>>>> being actively pursued by ARM, but feature work won't resolve this
>>>>> regression.
>>>>>
>>>
>>> I got some hardware with the DSU PMU so I'm going to have a go at 
>>> trying to
>>> send some fixes for this. My initial idea was to try incorporate the 
>>> "not
>>> terminate on opening" change as discussed in the link directly above. 
>>> And
>>> then do the revert of the "revert of prefer sysfs/json".
>>>
>>> FWIW I don't think Juno currently is broken if the kernel supports 
>>> extended
>>> type ID? I could have missed some output in this thread but it seems 
>>> like
>>> it's mostly related to Apple M hardware. I'm also a bit confused why the
>>> "supports extended type" check fails there, but maybe the v6.9 commit
>>> 25412c036 from Mark is missing?
>>>
>>> I sent a small fix the other day to make perf stat default arguments 
>>> work on
>>> Juno, and didn't notice anything out of the ordinary: 
>>> https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e54ca43f6@linaro.org/T/#t
>>> I agree that change is quite narrow but it does incrementally improve 
>>> things
>>> for the time being. It's possible that it would become redundant if I 
>>> can
>>> just include Ian's change to use strings for Perf stat.
>>>
>>> Of course I only think I have a handle on the issue right now, seems 
>>> like it
>>> has a lot of moving parts and something else always comes up. If I hit a
>>> wall at some point I will come back here.
>>
>> Thanks for working on this, hopefully we'll get to a solution that keeps
>> all the expectations expressed in this thread about not breaking
>> existing muscle memory and that allows us to progress on this matter.
>>
>> - Arnaldo
> 
> Hi Arnaldo,
> 
> In one of your investigations here 
> https://lore.kernel.org/lkml/Zld3dlJHjFMFG02v@x1/ comparing "cycles", 
> "cpu-cycles" and "cpu_cycles" events on Arm you say only some of them 
> open events on both core types. I wasn't able to reproduce that on 
> perf-tools-next (27ac597c0e) or v6.9 (a38297e3fb) for perf record or 
> stat. I guessed the 6.9 tag because you only mentioned it was on tip and 
> it was 29th May. For me they all open exactly the same two legacy events 
> with the extended type ID set.

Minor correction, one opens using the PMU type rather a legacy event 
with extended type ID. But importantly they do all open on both CPU types.


