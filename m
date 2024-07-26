Return-Path: <linux-kernel+bounces-263123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E693D154
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A14FB2181E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67F17836D;
	Fri, 26 Jul 2024 10:45:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3467F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990722; cv=none; b=ouokgB8o/x/2/rgkUJ379trNNHcFXf2FVk04eIXlmoguefCtnZPcetljnKeWSUxPH3A+/JgLxLbvAFHKONC9q5abmeSISngOQnVIARB9XNE5XXeXHTHVHN3L3G2uhmJxD2c51RCwGs7vFIu8e9LPwYf2CyDCpsdIxOsyndb5HZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990722; c=relaxed/simple;
	bh=jO0E0sieOzH/MBK294S4mRe+gujdtebcb/LZ9lsPU/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVpli4MIQqeW0yv4f1ARRCne2lcZIAnGlaVV515Kd3mSeIfoTe+Q2qr1/+fRG7i/F6wG8emA2EfBbDrjLniFb+odshW3KCg+L+BD5chyrBGERK9XkoUU11QFxK77LeRBQfwURfQleweMrq0pPiZMKLSpXo5X4aGCYKsQr/zLeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27C911007;
	Fri, 26 Jul 2024 03:45:44 -0700 (PDT)
Received: from [10.57.78.186] (unknown [10.57.78.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866A13F73F;
	Fri, 26 Jul 2024 03:45:16 -0700 (PDT)
Message-ID: <fdae26b5-1fe1-4544-b496-2273b2c2b523@arm.com>
Date: Fri, 26 Jul 2024 11:45:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: don't start_stop_khugepaged for non-PMD
 THP
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Yang Shi <shy828301@gmail.com>,
 Zi Yan <ziy@nvidia.com>
References: <20240726082818.260008-1-21cnbao@gmail.com>
 <aeb0fcb9-7c84-4bc4-b89a-5f0f86478aaf@arm.com>
 <a9ff9028-a73a-4a80-b38a-266d1e8c20fe@redhat.com>
 <CAGsJ_4wN0TBnPDj5oeFdPqCZk6XkMaJ0JbLY+fETWn52npwjjg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wN0TBnPDj5oeFdPqCZk6XkMaJ0JbLY+fETWn52npwjjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/07/2024 11:04, Barry Song wrote:
> On Fri, Jul 26, 2024 at 9:48 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.07.24 11:43, Ryan Roberts wrote:
>>> On 26/07/2024 09:28, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> khugepaged will be automatically started when PMD-sized THP is enabled
>>>> (either of the per-size anon control or the top-level control are set
>>>> to "always" or "madvise"), and it'll be automatically shutdown when
>>>> PMD-sized THP is disabled (when both the per-size anon control and the
>>>> top-level control are "never").
>>>>
>>>> It seems unnecessary to call start_stop_khugepaged() for non-PMD THP,
>>>> as it would only waste CPU time.
>>>>
>>>> Cc: Lance Yang <ioworker0@gmail.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>> ---
>>>>   mm/huge_memory.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 41460847988c..bd365e35acf7 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -514,7 +514,7 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
>>>>      } else
>>>>              ret = -EINVAL;
>>>>
>>>> -    if (ret > 0) {
>>>> +    if (ret > 0 && order == HPAGE_PMD_ORDER) {
>>>>              int err;
>>>>
>>>>              err = start_stop_khugepaged();
>>>
>>> Personally I see this as a bit of a layering violation; its
>>> start_stop_khugepaged() that should decide the policy for when to start and stop
>>> the daemon. thpsize_enabled_store() should just be calling
>>> start_stop_khugepaged() to notify that something potentially pertinent to the a
>>> policy decision has changed.
>>
> 
> My impression is that it slightly deviates from the huge page documentation in
> Documentation/admin-guide/mm/transhuge.rst.
> 
> khugepaged will be automatically started when PMD-sized THP is enabled
> (either of the per-size anon control or the top-level control are set
> to "always" or "madvise"), and it'll be automatically shutdown when
> PMD-sized THP is disabled (when both the per-size anon control and the
> top-level control are "never").

But start_stop_khugepaged() doesn't unconditionally start khugepaged, it takes
action based on hugepage_pmd_enabled() which only returns true if there are any
pmd sized THP enabled (currently looking at anon and file, but should also look
at shmem in future; that's a known bug that's been there forever). So I don't
think it is inconsistent with the documentation?

> 
> non-PMD size is not involved in khugepaged, but I agree the policy might change
> in the future.
> 
>> Agreed, skimming the subject I was under the impression that we would be
>> fixing something here.
> 
> working on another swapin_enabled and reviewing the enabled source code.
> I don't need this startstop for all sizes in that case, so I made a
> quick adjustment
> to this part as well. If neither of you likes it, that's fine with me :-)
> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Thanks
> Barry


