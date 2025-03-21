Return-Path: <linux-kernel+bounces-570777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79238A6B459
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E227A47BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3071E2307;
	Fri, 21 Mar 2025 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ycDv/0tM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C498836
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538056; cv=none; b=MgFl9d1yA1fwAVV5dfeNDo5SQlpaME7CG8/uMvnmLfy8h2o3Eoh7Qj32qKWfMhnbjMc7PNFEUc890fv5JE1gWj+jOOeWpFtBJRBVXNtVoh8KQb9ZGRYSm4sHDdneKvF0uIv4rpI3Lq5BmsjCWh0sq4ttuZbwIQn7VxIYA6AU6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538056; c=relaxed/simple;
	bh=CScUA6RZAjunTZQEia8fno5GArrQSBbHMDC++5vQewk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjYQkRUOOhbDNpP52sOQr72KihU4N8zgVk6fqPxf4960by7TVlzHVrQp/UmXsM+YotdYvd3agMIKIc+3HYVrug5XoRu/B/j5WxjprPT+xaUoNaa9g2KCIrwHp6m8A8DIIuzqRaIddkrElnFVZ1RU3aRjIdglvhKMK292SpIRUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ycDv/0tM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22580c9ee0aso32556695ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742538054; x=1743142854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrQp4u7BKm6gGzZCqOb8APZXqNDJNPpqpX8eEWyOLX8=;
        b=ycDv/0tM77V6zzPFnZK42xFS9mcJ70qYsEzFLmMHFWAWokVwS8IKSMoXAMXbP60Ygk
         KmLZWzuNzObQ47x5uUthRVmid9ZMFRZOFGKvsEQAnawwWMKSJ178hQMdoGsvEWaOw0wA
         mWCF78+6sdTVQEZozoOEYIkRFUM9OBIFqdBCrYX8sih6KaDgFT3e92/ha7AVJBNOOqvm
         81ZFu8O5mvubsRG87iJ8FBrNokM0zrB0EhO6vafhdKmNDPd3UJPTve1LaRKq/LF9CvHB
         5EDTQm7l8rGq1Morh9mHYQQpbEO23yPY1yp8dD72uSqLFMCq+yhVRksTzsyWh8PLrF8W
         mPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742538054; x=1743142854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrQp4u7BKm6gGzZCqOb8APZXqNDJNPpqpX8eEWyOLX8=;
        b=KT3kJ0/ArZe3fBmP+gvCDFyRqTGU0I+l/tPpomos8q3LNpFWXNJOe+oVrY9Y4MWLyI
         1zH6girFmCHcPtxcQtPjX6ecFcsin0glpEVDZzx0YBdiCai6o7+aJf7sV06o2+Ur6LnR
         mKJhV1jJKq+o1lKM0g699R4MgDFWcFlTBQpTyQworLgExtr5N0XpNkguEr5iSWp7/0Mc
         0yX/l86nuOZMY8JKsUXCNwiLbuCQPlRzxGgI9VsiaDI4EqyMD8Yi647EIwRNt6dhIpU6
         GeQ9KYzE/2fRIiEVYankBVPS+f/G78Ek9WKGDKvGnK5mBbCvV+yR32uMVIlQqyzzYe83
         ajtg==
X-Forwarded-Encrypted: i=1; AJvYcCVJQ9Fs2WMWUxA4Ydk5shirzLG4Qk6B1qk0qJo8yxh46VgsevBvX4bIjlkN89Q+LaX/QBTRsPmpnHFnh88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuX65Az8YcZkfDHC+FFh+D/sqmcUYnebxcdDf6i4vN4GEySNN
	mfS4PjFTZ36RS8+kCyfFf1rjPbohv7SP1PCB0hSXW4WDgiaSyL0PABXho/HlhCk=
X-Gm-Gg: ASbGncvc8PcmTIoaXZ/B1krvPDECAo2JY1IPSlOLWxidR1/xbI506z3JQd0cFfQH9uw
	qedJY7Ozc88Eml7xpha0obrrMzMezNZlItatXEd77jjyGHvDx+bzKyWnthGQvZvqc0Yn+YUysi+
	sqoizDJyOvPe4N5FfZkI/Tm6uB3sFQcdLxApB9RKNgZdCnVFAsuc/9xOsDAH1BDAdpVzQmlFedR
	4ZjSCQ5lDHQ1Wjz6pLJyhdpI1S7MKS+dBORWWUEi6z/U4fpNJBn47wmpfqCEx5lJq431VfLw4ex
	mQLsjfNa0QjEz8s6qu1feC98zEgTepZp2hW/UPfMPHghvBdW30CYX/UEWw==
X-Google-Smtp-Source: AGHT+IHe/Q9y2RWJQUcpyi6SzGNru8XSVxXcx9in0WkoW/tVessiSlrZXGzWXyQI3jGi8CYr6TyrAg==
X-Received: by 2002:a17:902:8b85:b0:21f:bd66:cafa with SMTP id d9443c01a7336-22780c7ba20mr26069275ad.17.1742538054144;
        Thu, 20 Mar 2025 23:20:54 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b806asm8600895ad.111.2025.03.20.23.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:20:53 -0700 (PDT)
Message-ID: <54cb5388-e278-41de-be29-d578cc5c37c5@daynix.com>
Date: Fri, 21 Mar 2025 15:20:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devel@daynix.com
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
 <Z9pze3J2_zrTk_yC@linux.dev>
 <e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
 <86plidmjwh.wl-maz@kernel.org>
 <bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
 <86o6xxmg87.wl-maz@kernel.org>
 <aabd71eb-286b-475c-a30e-d5cf5c4f2769@daynix.com>
 <86msdhmemw.wl-maz@kernel.org>
 <cd7b4528-34a3-4d87-9711-acc2c2e6f6e1@daynix.com>
 <86ldt0n9w1.wl-maz@kernel.org> <Z9sSMJAlf7cQ5viu@linux.dev>
 <0d84bc94-1c65-4737-a2eb-aa7f96a7d1e0@daynix.com>
 <86iko4m5i4.wl-maz@kernel.org>
 <ba9cd6d2-1ee5-478a-8102-42b4dac411ce@daynix.com>
 <86cyebmxo7.wl-maz@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <86cyebmxo7.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/03/21 2:14, Marc Zyngier wrote:
> On Thu, 20 Mar 2025 09:52:59 +0000,
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/20 18:10, Marc Zyngier wrote:
>>> On Thu, 20 Mar 2025 06:03:35 +0000,
>>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/20 3:51, Oliver Upton wrote:
>>>>> On Wed, Mar 19, 2025 at 06:38:38PM +0000, Marc Zyngier wrote:
>>>>>> On Wed, 19 Mar 2025 11:51:21 +0000, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>> What about setting the flag automatically when a user fails to pin
>>>>>>> vCPUs to CPUs that are covered by one PMU? There would be no change if
>>>>>>> a user correctly pins vCPUs as it is. Otherwise, they will see a
>>>>>>> correct feature set advertised to the guest and the cycle counter
>>>>>>> working.
>>>>>>
>>>>>> How do you know that the affinity is "correct"? VCPU affinity can be
>>>>>> changed at any time. I, for one, do not want my VMs to change
>>>>>> behaviour because I let the vcpus bounce around as the scheduler sees
>>>>>> fit.
>>>>
>>>> Checking the affinity when picking the default PMU; the vCPU affinity
>>>> is the only thing that rules the choice of the default PMU even now.
>>>>
>>>> Perhaps we may model the API as follows: introduce another "composite"
>>>> PMU that works on any core but only exposes the cycle counter. Robust
>>>> VMMs will choose it or one of hardware PMUs with
>>>> KVM_ARM_VCPU_PMU_V3_SET_PMU. KVM will choose the default PMU according
>>>> to the vCPU affinity at the point of KVM_ARM_VCPU_INIT otherwise. If
>>>> the affinity is covered by one hardware PMU, that PMU will be chosen
>>>> as the default. The "composite" PMU will be the default otherwise.
>>>
>>> This makes no sense to me. A VCPU is always affine to a PMU, because
>>> we do not support configurations where only some CPUs have a PMU. This
>>> is an all-or-nothing situation.
>>
>> At least isn't it fine to have the composite PMU with a new value for
>> KVM_ARM_VCPU_PMU_V3_SET_PMU?
> 
> Not sure KVM_ARM_VCPU_PMU_V3_SET_PMU is the right hook (it takes a PMU
> 'type', which is under control of the perf subsystem). But if we can
> find a value that is guaranteed to be unique, why not.
> 
>>> More importantly, you keep suggesting the same "new default", and I
>>> keep saying NO.
>>>
>>> My position is clear: if you want a *new* behaviour, you *must* add a
>>> new flag that the VMM explicitly provides to enable this CC-only PMU.
>>> No change in default behaviour at all.
>>>
>>> I'm not going to move from that.
>>
>> Why not? It will not break anything guaranteed to work in the past.
> 
> It doesn't have to be guaranteed. It just has to *exist*. That's the
> Linux ABI for you.
> 
>> Currently KVM only guarantees that the emulated PMU correctly counts
>> only when
>> 1) the vCPU affinity is contained by one PMU and
>> 2) it will not expand
>>
>> Breaking these conditions will make the behavior of the emulated PMU
>> undefined. Now I'm proposing to remove 1).
> 
> And I'm saying no to that. I'm also getting tired of arguing the same
> point on and on.
> 
> We currently have two different behaviours:
> 
> - either you explicitly set a PMU, and the affinity of this PMU
>    constraints the affinity of the vcpus. The vcpus are not allowed to
>    run outside of this affinity. Everything counts all the time.
> 
> - or you don't explicitly set a PMU, and a default PMU will be picked
>    from the current affinity of the first vcpu. Your vcpus will be able
>    to run anywhere, but the virtual PMU will *only* count when the
>    vcpus are affine to the default PMU. When the vcpus are not affine
>    to default PMU, *nothing* counts.
> 
> These two behaviours are ABI. They are not changing. They don't get
> relaxed, they don't get tightened, they stay just as they are,
> forever.

Is the latter one is really ABI? I see it as part of behaviors that are 
undefined and not included in ABI for the following reasons:

1) It depends on the scheduler behavior, which cannot be ABI.

2) It provides a broken PMU so the proposed behavioral change is similar 
a bug fix though I call it a undefined behavior instead of a bug as it 
is explicitly told that there is no assurance that the PMU works in such 
a scenario.

3) The userspace could not have relied on it so the "no regressions" 
rule cannot be applied here; how can anyone have a userspace that relies 
on a kernel behavior that depends on scheduling?

But for 3), Oliver raised a concern for the guest compatibility so I'd 
like to hear an explanation for that concern.

> 
> You want a *third* behaviour, go ahead. Define it the way you want.
> But the behaviours described above will stay unchanged.> > I'm looking forward to your patches implementing it, but I am also
> done arguing on it.

I understand the discussion is tiring but I want to know the reasoning 
behind such a design decision before sending an RFC patch to a VMM 
(QEMU) so that I can explain them why it is necessary in turn.

Regards,
Akihiko Odaki

> 
> 	M.
> 


