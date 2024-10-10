Return-Path: <linux-kernel+bounces-358986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A79998605
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB661C2356F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED71C6F4A;
	Thu, 10 Oct 2024 12:30:14 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC881C8FD7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563413; cv=none; b=rdZF6KN60FWhJMwm1L7PM7TRfWl+iUYVgQvfgrgKBscvK+PEC9NPkVhggFmm0gFsRLtMiBUxR21ptu56W3HLbJZLJZGgLId1cMGr990drXqNe/rn4P+uuBxMnJMf+u2vJjnGGnm7wE1ShuAIpCAued0CkaIOHoYUjv+nWrwhzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563413; c=relaxed/simple;
	bh=Hr6OGDRzNQ6Iy+ZSRQN8+TWWiZuifHW0v1wIlL4aFGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdGAuUCgUSa9IQOU0zZhX4tpOpYDODwUnCmOLGcmJrNrrQ01yjTQ88FmYazZjghm03Ng+hAZbT3aYvExrdz0LuAQNZ11YTHVsBjc3iT9B8xlpObnAYWUvDOkoOYYv79S3oL1ye+FfRT9bhqFOjQFC2e7uSWGfB/DsqVCANdir38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 528C8C103E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:29:44 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 684A940002;
	Thu, 10 Oct 2024 12:29:40 +0000 (UTC)
Message-ID: <dfe6a69e-03e6-44ca-a801-9fcdfe4efb70@ghiti.fr>
Date: Thu, 10 Oct 2024 14:29:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Prevent a bad reference count on CPU nodes
Content-Language: en-US
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>,
 paul.walmsley@sifive.com
Cc: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, palmer@dabbelt.com, cuiyunhui@bytedance.com,
 sudeep.holla@arm.com, linux-riscv@lists.infradead.org
References: <20240913080053.36636-1-mikisabate@gmail.com>
 <66fa9afe.5d0a0220.323a97.bfb6@mx.google.com>
 <670535de.7b0a0220.311e0d.f680@mx.google.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <670535de.7b0a0220.311e0d.f680@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Miquel,

On 08/10/2024 15:38, Miquel Sabaté Solà wrote:
> On dl., de set. 30 2024, Miquel Sabaté Solà wrote:
>
>> On dv., de set. 13 2024, Miquel Sabaté Solà wrote:
>>
>>> When populating cache leaves we previously fetched the CPU device node
>>> at the very beginning. But when ACPI is enabled we go through a
>>> specific branch which returns early and does not call 'of_node_put' for
>>> the node that was acquired.
>>>
>>> Since we are not using a CPU device node for the ACPI code anyways, we
>>> can simply move the initialization of it just passed the ACPI block, and
>>> we are guaranteed to have an 'of_node_put' call for the acquired node.
>>> This prevents a bad reference count of the CPU device node.
>>>
>>> Moreover, the previous function did not check for errors when acquiring
>>> the device node, so a return -ENOENT has been added for that case.
>>>
>>> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
>>> ---
>>> I was wondering if this should also be sent to stable, but  I have not seen
>>> a report on it, and this is not responsible for an oops or anything like that.
>>> So in the end I decided not to, but maybe you consider otherwise.
>>>
>>>   arch/riscv/kernel/cacheinfo.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
>>> index d6c108c50cba..d32dfdba083e 100644
>>> --- a/arch/riscv/kernel/cacheinfo.c
>>> +++ b/arch/riscv/kernel/cacheinfo.c
>>> @@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
>>>   {
>>>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>>>   	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
>>> -	struct device_node *np = of_cpu_device_node_get(cpu);
>>> -	struct device_node *prev = NULL;
>>> +	struct device_node *np, *prev;
>>>   	int levels = 1, level = 1;
>>>
>>>   	if (!acpi_disabled) {
>>> @@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
>>>   		return 0;
>>>   	}
>>>
>>> +	np = of_cpu_device_node_get(cpu);
>>> +	if (!np)
>>> +		return -ENOENT;
>>> +
>>>   	if (of_property_read_bool(np, "cache-size"))
>>>   		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>>>   	if (of_property_read_bool(np, "i-cache-size"))
>> Gently ping :)
>>
>> Could you take a look at this fix?
>>
>> Thanks,
>> Miquel
> Hello,
>
> Would it make sense to have this fix for rc3?


Sorry for the late response. It probably won't make it to rc3 but I'll 
make sure it will in rc4 :)

First:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And it needs the following Fixes tag (but no need to send a new version, 
b4 will pick it up):

Fixes: 604f32ea6909 ("riscv: cacheinfo: initialize cacheinfo's level and 
type from ACPI PPTT")

And about ccing stable, I'm not sure what could be the impact of this 
bad reference count (some warnings could appear, etc...) so as it is a 
small patch, I think it's worth backporting to stable.

Thanks,

Alex


>
> Thanks,
> Miquel
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

