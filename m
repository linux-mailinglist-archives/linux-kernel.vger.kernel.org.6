Return-Path: <linux-kernel+bounces-315623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D396C510
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D119E1C24D32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6F1E0081;
	Wed,  4 Sep 2024 17:15:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB0E1E0B7A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470130; cv=none; b=TR/3h6cQw2skD4D1kqyP3+/jyBUc3TSvTBbVJvJcwJg2noBtnzmbbl1kuZ9X4Z0OpA5ErUGXfqhqn000hXkd4DIF7wRNKsBlvx8LY+LVHZCgDHIZutBxI714WXmFjeW4L9QWqMklhlvem58H8UEHoqioZjTUGJs2MasO1roqDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470130; c=relaxed/simple;
	bh=INywhDiSrY7cjU09H2U1tIMqBQ1q+sPqG1V7SEOtO4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neBTvSWQT/oQgniSVQJ6XlVZaQC7HaIbdI6edDaOSJP/uwKFiR++3EpYsEyrX6u+Y+QAMhiEeG07ev9D6jkwWBcUKBEr+8dEhLir6kY/upe1Z03zLU3EtsK2mV483PpyMlVP2byXal+T5D9/36HWu0XBEeplPfL8W04BfOSpcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BBDFFEC;
	Wed,  4 Sep 2024 10:15:53 -0700 (PDT)
Received: from [10.57.17.5] (unknown [10.57.17.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05983F73B;
	Wed,  4 Sep 2024 10:15:25 -0700 (PDT)
Message-ID: <6eccf37d-07ed-4fcd-bf76-d54603c4361b@arm.com>
Date: Wed, 4 Sep 2024 18:15:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] perf: Add driver for Arm NI-700 interconnect PMU
To: Will Deacon <will@kernel.org>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
References: <cover.1725037424.git.robin.murphy@arm.com>
 <275e8ef450eeaf837468ce34e2c6930d59091fbc.1725037424.git.robin.murphy@arm.com>
 <20240902144714.GA11443@willie-the-truck>
 <0a41657e-a52c-43c9-9b73-89fd73a376c7@arm.com>
 <20240904122356.GE13550@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240904122356.GE13550@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-04 1:24 pm, Will Deacon wrote:
> On Mon, Sep 02, 2024 at 07:47:18PM +0100, Robin Murphy wrote:
>> On 02/09/2024 3:47 pm, Will Deacon wrote:
>>>> +static ssize_t arm_ni_format_show(struct device *dev,
>>>> +				  struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct arm_ni_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
>>>> +	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
>>>> +
>>>> +	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
>>>> +}
>>>
>>> Nit: if you end up adding single-bit config fields in the future, this
>>> will quietly do the wrong thing. Maybe safe-guard the 'lo==hi' case (even
>>> if you just warn once and return without doing anything).
>>
>> The counter-argument is that I don't foresee having any reason to add
>> single-bit config fields here in future, nor indeed config1 or config2
>> fields, so I intentionally pruned the would-be dead code while copy-pasting
>> this implementation from arm-cmn. Yes, if someone were to make an incomplete
>> change without paying attention or testing they could introduce a bug, but
>> when is that ever not true?
> 
> I guess I'm just a little more wary when it comes to UAPI. Somebody starts
> relying on the broken message and then you're toast. It's also incredibly
> easy to avoid by construction and the dead code isn't hurting anybody.

Even presuming some theoretical unreviewed broken patch did get merged 
and into real-world kernels without ever being fixed, I still struggle 
to imagine how userspace could somehow grow to *rely* on one PMU driver 
displaying a format attribute in an unexpected manner inconsistent with 
every other PMU driver, as opposed to the far more likely scenario of 
going wrong trying to parse it.

Anyway, after playing with some fun compile-time checks yesterday I've 
just realised there is actually an even simpler solution for doing the 
right thing in general, so I guess thanks for leaning on this :)

>>>> +	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%d_cd_%d", ni->id, cd->id);
>>>> +	if (!name)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	err = cpuhp_state_add_instance(arm_ni_hp_state, &cd->cpuhp_node);
>>>> +	if (err)
>>>> +		return err;
>>>
>>> What happens if there's a CPU hotplug operation here? Can we end up calling
>>> perf_pmu_migrate_context() concurrently with perf_pmu_register()?
>>
>> Yes. Alternatively we could register the PMU before the hotplug handler,
>> then potentially miss a hotplug event and leave a user-visible PMU
>> associated with an invalid CPU. This is a known issue for all system PMU
>> drivers, and the conclusion 5 years ago was that it's impractical to close
>> this race from outside perf core itself[1][2].
> 
> Ok, I'm going to walk right into the trap you've set me...
> 
> Why can't we prevent hotplug (e.g. with cpus_read_lock()) while we're
> setting this up?
> 
> ... and climbing back out of that trap, is the conversation you had with
> Thomas written down anywhere?

I think that must have been the time we talked in person in Cambridge. I 
can't now remember if there is (or was) anything in perf_pmu_register() 
that's actually incompatible with being called under cpus_read_lock(), 
but I do recall that the overall concept of exporting more bits of the 
hotplug machinery in order to copy-paste the same boilerplate bodge in 
every PMU driver was... unpopular.

> I don't want to block this patch, but if five years has passed with
> nobody looking at this then we probably need to address that at some
> point before adding more and more broken drivers.

Looking at it again, is there actually a problem with the current state 
of things? Following through the call path:

   perf_pmu_migrate_context()
     __perf_pmu_remove()
       perf_event_groups_first()
         __group_cmp()
           perf_event_groups_cmp()

the "pmu" pointer only seems to be used as a key to match events in the 
current CPU context, which obviously won't find anything at this point. 
AFAICS it's never even dereferenced, unless any events *are* found for 
__perf_pmu_install() to do something with, which necessarily implies an 
initialised and registered PMU for them to have been opened in the first 
place.

Thanks,
Robin.

