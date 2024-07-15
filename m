Return-Path: <linux-kernel+bounces-252577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554E931564
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107AB284B06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8EE18C35C;
	Mon, 15 Jul 2024 13:09:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7B18C351
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048960; cv=none; b=HC6Jo1AbGMkVFVAVrfE6AEaNM6pjlGMBEcObxrQ0piySOZ6L9Oqp64Zkx70DDUu85dj/nRTyr5oW5V3DFqFVW2y8TOkyCycUPSCIQSPhJg1gKM1qYyke5zMu2isVM0xz+FBqLMRymOognp4MUScRx+KDYZqIrpIW6HZALe+LY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048960; c=relaxed/simple;
	bh=PR09bmX+N58F2+JMjHsofbdHfXq81neDGwKB82wteTk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ARW8s6yZXy3LFg3MeQfM5fsY1XrCyJLNciMCfWHdXO87QjSQhIe+tio6wRjZGYKHvqKwp5uGyUYT4JQmQzCAOE3DBtcflUhPlLeVVSCM+CLDPGlqZhlP932nt7ZsTjObnaL3Bve9FcTeuvFJYjp0P25D/fb6gCODasfClqaKlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61DA8FEC;
	Mon, 15 Jul 2024 06:09:43 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADF9A3F73F;
	Mon, 15 Jul 2024 06:09:16 -0700 (PDT)
Message-ID: <4595f655-aaee-4b5c-8988-0804cedda14c@arm.com>
Date: Mon, 15 Jul 2024 14:09:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dev Jain <dev.jain@arm.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com> <3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com>
In-Reply-To: <3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 11:26, Ryan Roberts wrote:
> On 01/07/2024 20:43, Catalin Marinas wrote:
>> On Fri, Jun 28, 2024 at 11:20:43AM -0700, Yang Shi wrote:
>>> On 6/28/24 10:24 AM, Catalin Marinas wrote:
>>>> This patch does feel a bit like working around a non-optimal user choice
>>>> in kernel space. Who knows, madvise() may even be quicker if you do a
>>>> single call for a larger VA vs touching each page.
>>>
>>> IMHO, I don't think so. I viewed this patch to solve or workaround some ISA
>>> inefficiency in kernel. Two faults are not necessary if we know we are
>>> definitely going to write the memory very soon, right?
>>
>> I agree the Arm architecture behaviour is not ideal here and any
>> timelines for fixing it in hardware, if they do happen, are far into the
>> future. Purely from a kernel perspective, what I want though is make
>> sure that longer term (a) we don't create additional maintenance burden
>> and (b) we don't keep dead code around.
>>
>> Point (a) could be mitigated if the architecture is changed so that any
>> new atomic instructions added to this range would also come with
>> additional syndrome information so that we don't have to update the
>> decoding patterns.
>>
>> Point (b), however, depends on the OpenJDK and the kernel versions in
>> distros. Nick Gasson kindly provided some information on the OpenJDK
>> changes. The atomic_add(0) change happened in early 2022, about 5-6
>> months after MADV_POPULATE_WRITE support was added to the kernel. What's
>> interesting is Ampere already contributed MADV_POPULATE_WRITE support to
>> OpenJDK a few months ago:
>>
>> https://github.com/openjdk/jdk/commit/a65a89522d2f24b1767e1c74f6689a22ea32ca6a
>>
>> The OpenJDK commit lacks explanation but what I gathered from the diff
>> is that this option is the preferred one in the presence of THP (which
>> most/all distros enable by default). If we merge your proposed kernel
>> patch, it will take time before it makes its way into distros. I'm
>> hoping that by that time, distros would have picked a new OpenJDK
>> version already that doesn't need the atomic_add(0) pattern. If that's
>> the case, we end up with some dead code in the kernel that's almost
>> never exercised.
>>
>> I don't follow OpenJDK development but I heard that updates are dragging
>> quite a lot. I can't tell whether people have picked up the
>> atomic_add(0) feature and whether, by the time a kernel patch would make
>> it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.
>>
>> There's a point (c) as well on the overhead of reading the faulting
>> instruction. I hope that's negligible but I haven't measured it.
>>
> 
> Just to add to this, I note the existing kernel behaviour is that if a write
> fault happens in a region that has a (RO) huge zero page mapped at PMD level,
> then the PMD is shattered, the PTE of the fault address is populated with a
> writable page and the remaining PTEs are populated with order-0 zero pages
> (read-only).
> 
> This seems like odd behaviour to me. Surely it would be less effort and more
> aligned with the app's expectations to notice the huge zero page in the PMD,
> remove it, and install a THP, as would have been done if pmd_none() was true? I
> don't think there is a memory bloat argument here because, IIUC, with the
> current behaviour, khugepaged would eventually upgrade it to a THP anyway?
> 
> Changing to this new behaviour would only be a partial solution for your use
> case, since you would still have 2 faults. But it would remove the cost of the
> shattering and ensure you have a THP immediately after the write fault. But I
> can't think of a reason why this wouldn't be a generally useful change
> regardless? Any thoughts?

Hi All,

FYI, I had some more conversation on this at [1] and the conclusion was that the
current kernel behaviour is undesirable and we should change it so that if a
write fault occurs in a ragion mapped by a huge zero page, then the huge zero
page is uninstalled and a (private) THP is installed in its place. Shattering of
the huge zero page to PTEs should *not* occur.

So we will make this change in due course and submit to the list.

[1] https://lore.kernel.org/linux-mm/1cfae0c0-96a2-4308-9c62-f7a640520242@arm.com/

Thanks,
Ryan

> 
> Thanks,
> Ryan
> 


