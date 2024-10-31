Return-Path: <linux-kernel+bounces-389878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D89B7260
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3981F2509E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1972A84A51;
	Thu, 31 Oct 2024 02:08:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02611BD9F7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340535; cv=none; b=tvcN2tOhdgQjrtExHyAEKSqprfH/bFD+If1hPJimp39OIt38tTIrKr2zQM/pyI0RbEk7iNhW2z8TP+jRXEmCPkH1yqib0gQslOPadb1hPv8AnC0Fft5Ssmg4kBxwOwll924qdgrx1fvHEuPh3DD4YJRT7uInFrLZMQJ3hwQn0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340535; c=relaxed/simple;
	bh=Su52DJjvaUEtS310hQDQCUdqq/9Ep6frU4psaYiiK40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO4s58FDRf6B+Y75DWImB4AewoSD41u2zxchfnWPoo06sxaAWZ4+B84oEv2hh/Fnnu/hwMfLkWwiMtfPUvfYXzQ7J/f8M/hKQkdG2GbznI6kYm9AHpssKwNYeQxvTZfabMXXL0RQ8PgBRrysDK6eH4UQXixybJ3aZKr76Bzt13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ECDD1063;
	Wed, 30 Oct 2024 19:09:21 -0700 (PDT)
Received: from [10.0.0.145] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AF693F73B;
	Wed, 30 Oct 2024 19:08:50 -0700 (PDT)
Message-ID: <86b2aef1-8926-47c8-8a33-9f02e3dd7d72@arm.com>
Date: Wed, 30 Oct 2024 21:08:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: steven.price@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, sami.mujawar@arm.com, linux-kernel@vger.kernel.org
References: <20241029141114.7207-1-jeremy.linton@arm.com>
 <32211eb5-eed5-4c71-b62a-362d32e1af47@redhat.com>
 <b62b9ba4-eaf9-4533-9a97-7d5e2929b1e8@arm.com>
 <98b47e47-9014-45d1-86c7-4b78ff36bf54@redhat.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <98b47e47-9014-45d1-86c7-4b78ff36bf54@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 10/30/24 5:48 PM, Gavin Shan wrote:
> Hi Jeremy,
> 
> On 10/31/24 1:16 AM, Jeremy Linton wrote:
>> On 10/29/24 7:23 PM, Gavin Shan wrote:
>>> On 10/30/24 12:11 AM, Jeremy Linton wrote:
>>>> The TSM module provides both guest identification as well as
>>>> attestation when a guest is run in CCA mode. Lets assure by creating a
>>>> dummy platform device that the module is automatically loaded during
>>>> boot. Once it is in place it can be used earlier in the boot process
>>>> to say decrypt a LUKS rootfs.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>   arch/arm64/include/asm/rsi.h                    |  2 ++
>>>>   arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>>>>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  7 +++++++
>>>>   3 files changed, 24 insertions(+)
>>>>
>>>
>>> I don't understand how the TSM module is automatically loaded and 
>>> arm_cca_guest_init()
>>> is triggered because of the newly introduced platform device. Could 
>>> you please provide
>>> more details? Apart from it, some nick-picks as below.
>>
>> I think your asking how the module boilerplate here works, AKA how the 
>> standard uevent/udev/modalias/kmod stuff works? The short version is 
>> that the platform bus uevents an add device with a modalias and 
>> userspace udev + kmod finds matching modules, and their dependencies, 
>> and loads them which triggers the module_init() calls.
>>
>> The suse folks have a detailed description of how this works:
>> https://doc.opensuse.org/documentation/leap/reference/html/book- 
>> reference/cha-udev.html#sec-udev-kernel
>>
>> So, this is a fairly common misuse of the platform bus, in this case 
>> to avoid needing a HWCAP. Assuring the module exists in the initrd 
>> will then result in it being loaded along any other modules required 
>> for the rootfs pivot.
>>
>>
> 
> Thanks for the explanation and details. The module won't be 
> automatically loaded if
> udev daemon isn't in place or the DEV_ADD event is ignored for whatever 
> reasons. For
> example the corresponding ACTION for DEV_ADD of this particular device 
> is null in the
> udev rules. So it's not guranteed that the module can be automatically 
> loaded until udev
> is in place and udev rules have been configured properly. It's a best- 
> effort attempt
> if I don't miss anything.

This functionality has been standard in all but the most deeply 
enmbedded linux systems for a couple decades now (AFAIK). The platform 
and modalias logic should largely just work everywhere that its 
appropriate to be building this as a module. And to be clear that is 
without updating any of the existing rules.

> 
> Could you please update the change log to mention the automatic module 
> loading depends
> on udev and its rules? In this way, readers will know it's a best-effort 
> attempt at least.
> 
> Thanks,
> Gavin
> 


