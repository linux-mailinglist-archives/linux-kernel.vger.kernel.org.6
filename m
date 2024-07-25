Return-Path: <linux-kernel+bounces-262311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C61793C3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B0A1F22E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113119D069;
	Thu, 25 Jul 2024 14:18:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DC119AD94
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917136; cv=none; b=CxTmoyUuxSRpX4sd4YkAacNmhHUNc54Crf6ZO6Y6OYSwcbmF4GgWHRUk4IKdQ2e/5rMKSYqkz5ET3BKy+mIzBcWe7SvTA9QfdxmN2fwDNv+qHmmCHpkK1zuTZ9QUrZIH/IJ71OwYbsVWE6rWhIs8FEGou/tPEIdwCXOYrweaEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917136; c=relaxed/simple;
	bh=48+AwyM1NnP2TJNuZ7+Ry6RqItTHU1eayrqC+q7FuDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCwHOY1YTRSOSD16CxlR17DkBNRdsWZ1Qpd8n+KHUEwC8Sem6Lv52IM0xvMaovi9xvbUqpOQomKGOxglFFCfP8UhulQO026e9pRIkmKHIgI//dyKVSEIt71Oyrfyy+Ap2rsUo5PtJsk9tGT36lFbAYAErVTFepGpe55NLfKYPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B534B1007;
	Thu, 25 Jul 2024 07:19:19 -0700 (PDT)
Received: from [10.57.93.214] (unknown [10.57.93.214])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26DA53F73F;
	Thu, 25 Jul 2024 07:18:51 -0700 (PDT)
Message-ID: <1152aa46-281a-42c1-bcb1-42aee8fa9368@arm.com>
Date: Thu, 25 Jul 2024 15:18:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/pelt: Use rq_clock_task() for hw_pressure
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20240725114200.375611-1-yu.c.chen@intel.com>
 <38a631cf-1f6d-4d68-887a-12c7c5808ebf@arm.com>
 <ZqJafRf/fM/whI+6@chenyu5-mobl2>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <ZqJafRf/fM/whI+6@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/07/2024 15:00, Chen Yu wrote:
> Hi Hongyan,
> 
> On 2024-07-25 at 14:16:30 +0100, Hongyan Xia wrote:
>> On 25/07/2024 12:42, Chen Yu wrote:
>>> commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
>>> removed the decay_shift for hw_pressure. While looking at a related
>>> bug report, it is found that this commit uses the sched_clock_task()
>>> in sched_tick() while replaces the sched_clock_task() with rq_clock_pelt()
>>> in __update_blocked_others(). This could bring inconsistence. One possible
>>> scenario I can think of is in ___update_load_sum():
>>>
>>> u64 delta = now - sa->last_update_time
>>>
>>> 'now' could be calculated by rq_clock_pelt() from
>>> __update_blocked_others(), and last_update_time was calculated by
>>> rq_clock_task() previously from sched_tick(). Usually the former chases
>>> after the latter, it cause a very large 'delta' and brings unexpected
>>> behavior. Although this should not impact x86 platform in the bug report,
>>> it should be fixed for other platforms.
>>
>> I agree with this patch but I'm a bit confused here. May I know what you
>> mean by 'should not impact x86 platform in the bug report'? But it closes a
>> bug report on qemu x86_64, so it does have an impact?
>>
> 
> It should not have any impact on x86_64. I added the bug link here because I checked
> the code while looking at that report. But that report might be false positve,
> or at least not caused by this logic introduced by this commit, because
> CONFIG_SCHED_HW_PRESSURE was not even set in the kernel config[1]. Maybe I should
> remove the 'reported-by' and 'closes' tags?
> 
> [1] https://download.01.org/0day-ci/archive/20240709/202407091527.bb0be229-lkp@intel.com/config-6.9.0-rc1-00051-g97450eb90965
> 

Yeah, it might be a good idea to remove the link to avoid confusion, 
like you said HW pressure is not compiled in.

Even if there is pressure support, before your patch the big 'delta' 
should only result in a HW pressure value that decays more than it 
should, and should not be able to block tasks like in that bug report, 
so it's very likely that it's unrelated.

