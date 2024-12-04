Return-Path: <linux-kernel+bounces-430492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8BC9E3195
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AC1285F66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F227701;
	Wed,  4 Dec 2024 02:46:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AAABE4E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280404; cv=none; b=VoqVgkJQlv+s85Vdiieor2WT2ok4UPTV8Dq0jcG7XLoPWRCgf01CRktPAQpcvBeV/IOM7KoV3HTnDoOQ8OQjqqhHfVABtlU3dao976uRFKqzuruevQ13FUvzABbu5RwFQxksnXct/liUbpPPpY/iBq0usKIdhwL8jFl8ag2sk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280404; c=relaxed/simple;
	bh=6TfBRBylDlHYU+NrZUTyNjD7PcuWOnKS9qPYLJZ7WW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8vGcaz0Bn2iz+G2dOJgVPw2IFl5eIDpP0TzNE/IYcw5SD/q43FnmN/UcM+Rvf8NAh3MQjJY1jSt+5zZupAjBbS12i3eqCQX52XLsT1kzcaV0Md/MpW4tv5j7jveT1slwXZKpzmzQztNS0nZEzDAbRPn+XADza1AQnI7gi9AqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2D41FEC;
	Tue,  3 Dec 2024 18:47:08 -0800 (PST)
Received: from [10.162.16.41] (a077893.blr.arm.com [10.162.16.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720823F5A1;
	Tue,  3 Dec 2024 18:46:39 -0800 (PST)
Message-ID: <d0b45f75-d500-4049-8240-56a0db4038d3@arm.com>
Date: Wed, 4 Dec 2024 08:16:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/hugetlb: Make __NR_USED_SUBPAGE check conditional
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org
References: <20241203023207.123416-1-anshuman.khandual@arm.com>
 <A9973D39-9840-40F2-91DA-1CA8ADC06AA1@linux.dev>
 <3733d1e8-6e9d-4337-aeda-a6d5366d4a4c@arm.com>
 <9C1A9184-7432-45CB-89E4-D0A62C992C76@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <9C1A9184-7432-45CB-89E4-D0A62C992C76@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/24 13:50, Muchun Song wrote:
> 
> 
>> On Dec 3, 2024, at 15:46, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>
>> On 12/3/24 08:59, Muchun Song wrote:
>>>
>>>
>>>> On Dec 3, 2024, at 10:32, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>> The HugeTLB order check against __NR_USED_SUBPAGE is required only when
>>>> HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled. Hence BUG_ON() trigger should
>>>> happen only when applicable.
>>>>
>>>> Cc: Muchun Song <muchun.song@linux.dev>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> This patch applies on v6.13-rc1
>>>>
>>>> Changes in V2:
>>>>
>>>> - Fixed #ifdef with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP per Oscar
>>>>
>>>> Changes in V1:
>>>>
>>>> https://lore.kernel.org/all/20241202090728.78935-1-anshuman.khandual@arm.com/
>>>>
>>>> mm/hugetlb.c | 6 ++++--
>>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index ea2ed8e301ef..e6a5b21e3578 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -4513,11 +4513,13 @@ void __init hugetlb_add_hstate(unsigned int order)
>>>> 	struct hstate *h;
>>>> 	unsigned long i;
>>>>
>>>> - 	if (size_to_hstate(PAGE_SIZE << order)) {
>>>> + 	if (size_to_hstate(PAGE_SIZE << order))
>>>> 		return;
>>>> - 	}
>>>> +
>>>> 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
>>>> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>>> 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
>>>
>>> Hi Anshuman,
>>>
>>> __NR_USED_SUBPAGE indicates how many struct pages are used to store
>>> extra metadata for a HugeTLB page. So we need to make sure the order
>>> of a HugeTLB page should be bigger than or equal to order_base_2(__NR_USED_SUBPAGE).
>>> So It is not related to HVO. I don't think the changes make sense.
>>
>> I did think about that but order_base_2(__NR_USED_SUBPAGE) actually
>> turns out to be just 2 as __NR_USED_SUBPAGE is 3. Would not HugeTLB
>> size be always greater than four base pages in reality, thus making
>> this BUG_ON() check just redundant ?
> 
> Currently, there is no architectures supporting hugetlb page smaller
> than 4 base pages. I think the smallest size is 64KB in arm64, but who
> knows whether if certain architectures supports 8KB in the future or
> we want to uses more struct pages to store metadata for increasing
> __NR_USED_SUBPAGE (e.g. change it to 17). So I tend to keep this
> BUG_ON remain to catch unexpected bugs.

Sure, fair enough.

