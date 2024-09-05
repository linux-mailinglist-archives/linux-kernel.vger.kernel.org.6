Return-Path: <linux-kernel+bounces-316498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E996A96D061
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2858B1C213F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83F193068;
	Thu,  5 Sep 2024 07:29:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202813D2A9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521389; cv=none; b=dWNn8culeAJ/FrY3RKUgIkf8LwXp9yTMA1sfqVLw32eIPHjgbZUQZXtAQBBUr7CUyjFyonoVt1dPk+kxGgdsj1rt4ebdwkYjloPo1DPbXk5Er7M3gGRyy/f7gTs+dzvbzC8bRUdCrztVo0k03TXOt/aEu8H5EpTCKvipThW8yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521389; c=relaxed/simple;
	bh=eA2iuinFsqIZupLHzsLkLFBhRovt8t0ev0SYVrmfo6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8e01MTv0TzQgYpauItucOIuj3+vC9I+gMniw2BzPSG3jEQzhTits+ayxulrDDbtJxyZ6gQPZn7L98BGoJvYp3BNShEPcQy9NaC/ft7RFdp5qgiL/TBT+/9EZnxTGV6uLuM2I3b1s/xePWtKbN86KskHMo1dLWHbsIttzcCcE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78ED7FEC;
	Thu,  5 Sep 2024 00:30:12 -0700 (PDT)
Received: from [10.57.87.65] (unknown [10.57.87.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9618E3F66E;
	Thu,  5 Sep 2024 00:29:44 -0700 (PDT)
Message-ID: <78ddd0df-e8e1-414b-92fc-19a4860f183d@arm.com>
Date: Thu, 5 Sep 2024 08:29:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Gavin Shan <gshan@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240808111849.651867-1-ryan.roberts@arm.com>
 <20240808111849.651867-3-ryan.roberts@arm.com>
 <747d1319-f746-4379-bf88-a0f6c3f558b4@linux.alibaba.com>
 <f7ced14c-8bc5-405f-bee7-94f63980f525@arm.com>
 <20240904134631.4dd7a0bde6439aad3a275002@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240904134631.4dd7a0bde6439aad3a275002@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2024 21:46, Andrew Morton wrote:
> On Wed, 4 Sep 2024 11:47:29 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>>>> +static struct attribute *any_ctrl_attrs[] = {
>>>> +    NULL,
>>>> +};
>>>> +
>>>> +static const struct attribute_group any_ctrl_attr_grp = {
>>>> +    .attrs = any_ctrl_attrs,
>>>>   };
>>>
>>> I wonder why adding a NULL group?
> 
> Was this review comment addressed?

Yes, we had discussion at [1] and concluded to leave it as is; Baolin had a
preference to remove it (but no strong opinion) and Barry preferred it as is to
explicitly indicate that there are no controls shared by file/shmem/anon currently.

[1]
https://lore.kernel.org/linux-mm/CAGsJ_4z+yERPLwzm-8Mkx8MsNZAz0zZWycZfuGRjOc4kxS=HwQ@mail.gmail.com/


> 
>>
>> ...
>>
>>>> +    &shmem_alloc_attr.attr,
>>>> +    &shmem_fallback_attr.attr,
>>>> +    &shmem_fallback_charge_attr.attr,
>>>> +#endif
>>>> +    NULL,
>>>> +};
>>>> +
>>>> +static struct attribute_group file_stats_attr_grp = {
>>>> +    .name = "stats",
>>>> +    .attrs = file_stats_attrs,
>>>> +};
>>>> +
>>>> +static struct attribute *any_stats_attrs[] = {
>>>> +#ifdef CONFIG_SHMEM
>>>> +    &swpout_attr.attr,
>>>> +    &swpout_fallback_attr.attr,
>>>> +#endif
>>>
>>> Sorry I did not point it out in early version. I think file pages and shmem can
>>> also be split, while 'split_deferred' is only for anonymous page. So I think the
>>> any_stats_attrs should be:
>>> static struct attribute *any_stats_attrs[] = {
>>> #ifdef CONFIG_SHMEM
>>>     &swpout_attr.attr,
>>>     &swpout_fallback_attr.attr,
>>> #endif
>>>     &split_attr.attr,
>>>     &split_failed_attr.attr,
>>>     NULL,
>>> };
>>
>> Could you please squash the following into this patch, which is already in
>> mm-unstable? I'm hoping this sufficient and I don't need to send a whole new
>> revision since there are changes on top of this in mm-unstable, which makes
>> things tricky.
> 
> I did that.  Please send along a Signoff and a changelog?

Ahh sorry, so even though you are squashing into an existing patch which has the
change log and sign-off, the process still requires a separate one here? My bad.

----8<----

Fixup commit ("mm: Tidy up shmem mTHP controls and stats") by moving split_attr
and split_failed_attr stats to the any_stats_attrs group. All memory types can
have their folios split, so it was incorrect to only show this stat for anon memory.


Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

----8<----

Thanks,
Ryan


