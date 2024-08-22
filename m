Return-Path: <linux-kernel+bounces-296789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E495AF31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB911F26B10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFB17E8E2;
	Thu, 22 Aug 2024 07:20:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18D317E473
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311207; cv=none; b=f2zX3cmwceHsNcifYRkTcnZwUVaZ+DpwHfk28EanTz0JRX4FLZnD3xFYLuDt5fOHNFHWPYqMw+jxEnfG8r3IpMfJKlhzPux1rN2fUQvldYa6vWgB6InNVd+RAg1bxy8nhfePbgtpLslPLz7ENrsnW61+RENA/USwDB0OY33DzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311207; c=relaxed/simple;
	bh=J+e0DiGmS/Khmab0iizda+PoBBvpWgzMRkiIs38ta+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMutnsPRNO3ZmMIYtbpRfHKtZppDAXDbRAZ2Ukl71AE7hffxzey/Nn0y+D9c5Am4Si6hAddpEUqbm8hevs16SmIZ5jnSt+sZ2v+RqEduBJWEfm/eNkcCtoZjNiEPL8f3W+UGGmTO9L0xt19siFVC91rkxOmW4N8Q5xpjHD+IeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF97ADA7;
	Thu, 22 Aug 2024 00:20:23 -0700 (PDT)
Received: from [10.29.19.105] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6521E3F58B;
	Thu, 22 Aug 2024 00:19:53 -0700 (PDT)
Message-ID: <6580b2f6-ef95-4cd9-a573-ded7c8a4ef7d@arm.com>
Date: Thu, 22 Aug 2024 09:19:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI based
 system
To: Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 tglx@linutronix.de, peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, yangyicong@hisilicon.com,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, xuwei5@huawei.com,
 guohanjun@huawei.com
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-4-yangyicong@huawei.com>
 <ec8c46f2-d819-43d7-a866-d272169178d3@arm.com>
 <04ed0569-5026-9c4f-b09f-3e8798d5b551@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <04ed0569-5026-9c4f-b09f-3e8798d5b551@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 09:03, Yicong Yang wrote:
> On 2024/8/16 23:55, Dietmar Eggemann wrote:
>> On 06/08/2024 10:53, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>

[...]

>> So the xarray contains one element for each core_id with the information
>> how often the core_id occurs? I assume you have to iterate over all
>> possible CPUs since you don't know which logical CPUs belong to the same
>> core_id.
>>
> 
> Each xarray element counts the thread number of a certain core id. so the logic is like below:
> 1. if the "core id" entry doesn't exists, then we're accessing this core for the 1st time. create
>    one and make the thread number to 1
> 2. otherwise increment the thread number of "core id" this cpu belongs (PPTT already
>    told us which core this CPU belongs to). Update the max_smt_thread_num if necessary.
> 
> Then we can know max_smt_thread_num by meanwhile iterating the PPTT table and
> build the topology for all the possible CPUs.
> 
> Otherwise we need to do a second scan for the max thread number after built the
> topology. This way is implemented in v1 and it's complained about the overhead on large
> scale systems since we need to loop the CPUs twice.

OK.

[...]

>> Tested on ThunderX2:
>>
>> $ cat /proc/schedstat | head -6 | tail -4 | awk '{ print $1, $2 }'
>> cpu0 0
>> domain0 00000000,00000000,00000000,00000000,00000001,00000001,00000001,00000001
>>                                                    ^        ^        ^        ^
>> domain1 00000000,00000000,00000000,00000000,ffffffff,ffffffff,ffffffff,ffffffff
>> domain2 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
>>
>> detecting 'max_smt_thread_num = 4' correctly.
>>
> 
> Thanks for the testing. ok for a tag?

Yes, please go ahead.

[...]

