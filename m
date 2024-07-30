Return-Path: <linux-kernel+bounces-267851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FA2941753
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1D1C23285
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A6189904;
	Tue, 30 Jul 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EehEXzYf"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C218800D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355688; cv=none; b=EHNfbxc+o4qQNKIijf+reK8sAPWq71VxNZFobINGfpF33Db++Ic1mLSTXTgoNFy/mQsDLwLkzuyaiflgzr+dV/WAce/sO9Piq+SutNwtqsCgeNCs4/QVQV0lA/0yQXEQa9bF4XL9XGjG6w7yDkkukT+LQjsvUyOh+VFYMU+dJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355688; c=relaxed/simple;
	bh=ZDnikaofMadZq4q098kRslXOLdgwFs2m0s1TYIRWPdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ULdEUrdoSUPeac41Ex4P6XD3lePnLLkxyb7xuK6xjsZQJoi7BTDHtd5UwGlRwRvt3d7o8NCFC1GqJCOvs5btytFbZ4H1UyLb+3C2Jl8fZ99OHj57cPV92NdCgPJdeGrS/KoYTWViV89IvWBe/xLtoch172NnUdafwIFSCIYfBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EehEXzYf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240730160804euoutp02885df9bdde4fc189aa338f03719af189~nCV6RHXru0267202672euoutp020
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:08:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240730160804euoutp02885df9bdde4fc189aa338f03719af189~nCV6RHXru0267202672euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722355684;
	bh=D2FnM7fGhh0TbxsAVGiQSzwNJHvbQMWTJOueFpqVWUg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EehEXzYfLquHEKjlOSwNSaqxGpjikC047eVlqSNUqWYxBxADsRoy72L4U1514TLRr
	 r+4ZoU8O8vesCmvjvQ4msi3Fc8f4HAICMoFAPj+tkmXhWjKfGJdIFIrzByGv9gQI0f
	 F2Jnl8Z7oVqLXAQbGiNtRX4pNcUtDxmFD+Xmgw/A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240730160804eucas1p1b48bc9cb1158530295f18182c9592b07~nCV6Dr6t80043700437eucas1p1g;
	Tue, 30 Jul 2024 16:08:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.D2.09620.3EF09A66; Tue, 30
	Jul 2024 17:08:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240730160803eucas1p18569f012751560f5d4e5d3c17a88dff4~nCV5rUoug0988309883eucas1p1k;
	Tue, 30 Jul 2024 16:08:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730160803eusmtrp27d19536c872a1f8d3baacd67ea532368~nCV5qRUMs2657726577eusmtrp2-;
	Tue, 30 Jul 2024 16:08:03 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-7a-66a90fe33c99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.68.09010.3EF09A66; Tue, 30
	Jul 2024 17:08:03 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240730160802eusmtip1cdffbf7ba0218fe3298cf1c448deaa5b~nCV5EDYwC3203132031eusmtip1x;
	Tue, 30 Jul 2024 16:08:02 +0000 (GMT)
Message-ID: <d2dc8e9e-c3f8-4aa2-b9bf-0aeb3bb9aba4@samsung.com>
Date: Tue, 30 Jul 2024 18:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Muchun
	Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>, Oscar Salvador
	<osalvador@suse.de>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <82e77547-5116-4ef2-a232-f5ab1fca7e02@redhat.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qP+VemGazbbWoxZ/0aNouv638x
	W1zeNYfN4t6a/6wWy3Y+ZLE4M63IYsv+b+wO7B6bPk1i9zgx4zeLx8KGqcwe7/ddZfPYfLra
	4/MmuQC2KC6blNSczLLUIn27BK6M+Yt3MRfcEqp4scGkgXEOfxcjJ4eEgInE9aMnmLoYuTiE
	BFYwSqzf1s8O4XxhlDjZ0s8K4XwGykyYywjT8uD3CWaIxHJGiRl/LkNVfWSU+NK+CCjDwcEr
	YCfx6VoESAOLgKrE34ZLYM28AoISJ2c+YQGxRQXkJe7fmsEOYgsLeEp8/NfBBNIqIuAmMWFR
	JMhIZoE1jBJ3++eD1TALiEvcejKfCcRmEzCU6HrbxQZicwKt2rVnPxtEjbxE89bZYMdJCDzh
	kFj3fT3U1S4Sm/ufMUHYwhKvjm9hh7BlJP7vnM8E0dDOKLHg930oZwKjRMPzW1Dd1hJ3zv1i
	AzmPWUBTYv0ufYiwo8T0A41gD0sI8EnceCsIcQSfxKRt06HCvBIdbUIQ1WoSs46vg1t78MIl
	5gmMSrOQgmUWkjdnIXlnFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQIT0el/
	x7/uYFzx6qPeIUYmDsZDjBIczEoivPFXlqYJ8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8V
	EkhPLEnNTk0tSC2CyTJxcEo1MBkbNxws2zfhV0xuZdCRuuaMCbddrNQcWfuPSlxYoZlj9er0
	45k7q/duDp0toZ3toHn10eOtl3/X/nYxMGr1+bdcMbuBZz/Diuy7ZapCDZVsYk9/NZiVF02a
	8KJ8Znufo/L5nT31HxkvB347dWuTzpyoJ8nsJ/S7jV7s0wryCTNNE51sWTttstHfZav3F/st
	jhI167/edXvbh4riBdcq8jM26HYlMir8iLyqys+0ppPzF/fdPPXTnq2vLdz+rZfibNh0o7/3
	rcAU0f85t97eWmRn8ZexwDTHcdOuXRyqyz44yEbusp/4pfvJ6+6nzlOeq293WXy99QxPqMBL
	b+V9lzd3y149obP1nEdQxPeb0kosxRmJhlrMRcWJALcp3P+zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xu7qP+VemGcyfIG8xZ/0aNouv638x
	W1zeNYfN4t6a/6wWy3Y+ZLE4M63IYsv+b+wO7B6bPk1i9zgx4zeLx8KGqcwe7/ddZfPYfLra
	4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
	BL2M+Yt3MRfcEqp4scGkgXEOfxcjJ4eEgInEg98nmLsYuTiEBJYySvxpusUCkZCRODmtgRXC
	Fpb4c62LDaLoPaNE28fjQEUcHLwCdhKfrkWA1LAIqEr8bbjECGLzCghKnJz5BGyOqIC8xP1b
	M9hBbGEBT4mP/zqYQFpFBNwkJiyKBBnJLLCGUeJ481eoI64xSXw93Q3WwCwgLnHryXwmEJtN
	wFCi6y3IEZwcnEB7d+3ZzwZRYybRtbWLEcKWl2jeOpt5AqPQLCR3zEIyahaSlllIWhYwsqxi
	FEktLc5Nzy020itOzC0uzUvXS87P3cQIjLxtx35u2cG48tVHvUOMTByMhxglOJiVRHjjryxN
	E+JNSaysSi3Kjy8qzUktPsRoCgyMicxSosn5wNjPK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQS
	SE8sSc1OTS1ILYLpY+LglGpgWi1nOGfZecu0c/unfHu2fM6/z8F1qzQutrr7l05aUqhuES+/
	tm2KlspX59snnsXyts+sdNJNZSudfl0iRVDeqltVU7hm/9v3aYuk2R+fzfG+9K9+xY9JwYq9
	11ZLyfP1uWaF3pJpk9/0IHBBzJ3+nB+eBsHys/tXtTUvP7Js9yxeWfONRR2an7W8HhgnfRZf
	lmyhq2U0X+61rlml9bIXORPi+guz37esWdniOok/N/pFcoVoYO6s0My3hl8PRjVt6oiMsQmy
	9xO85/SUadb3BM7JVd7vJk9pql/5nDny0PV1OwS2/K+I2b8g4JzugmSlkDCmuo5Fi+foS258
	Etc9v4jjH//2m15MCpeUw5OVWIozEg21mIuKEwGKv7TBRQMAAA==
X-CMS-MailID: 20240730160803eucas1p18569f012751560f5d4e5d3c17a88dff4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3
References: <20240725183955.2268884-1-david@redhat.com>
	<20240725183955.2268884-2-david@redhat.com>
	<CGME20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3@eucas1p2.samsung.com>
	<97d87df8-6076-4df0-90a9-a8f5ddea42e9@samsung.com>
	<c3af0b48-f303-456b-bca3-537a61255ec5@redhat.com>
	<82e77547-5116-4ef2-a232-f5ab1fca7e02@redhat.com>

On 30.07.2024 17:49, David Hildenbrand wrote:
> On 30.07.24 17:45, David Hildenbrand wrote:
>> On 30.07.24 17:30, Marek Szyprowski wrote:
>>> On 25.07.2024 20:39, David Hildenbrand wrote:
>>>> pte_lockptr() is the only *_lockptr() function that doesn't consume
>>>> what would be expected: it consumes a pmd_t pointer instead of a pte_t
>>>> pointer.
>>>>
>>>> Let's change that. The two callers in pgtable-generic.c are easily
>>>> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
>>>> pte_offset_map_nolock() to obtain the lock, even though we won't 
>>>> actually
>>>> be traversing the page table.
>>>>
>>>> This makes the code more similar to the other variants and avoids 
>>>> other
>>>> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
>>>> reside now only in  pgtable-generic.c.
>>>>
>>>> Maybe, using pte_offset_map_nolock() is the right thing to do because
>>>> the PTE table could have been removed in the meantime? At least it 
>>>> sounds
>>>> more future proof if we ever have other means of page table reclaim.
>>>>
>>>> It's not quite clear if holding the PTE table lock is really required:
>>>> what if someone else obtains the lock just after we unlock it? But 
>>>> we'll
>>>> leave that as is for now, maybe there are good reasons.
>>>>
>>>> This is a preparation for adapting hugetlb page table locking logic to
>>>> take the same locks as core-mm page table walkers would.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> This patch landed in today's linux-next as commit e98970a1d2d4 ("mm: 
>>> let
>>> pte_lockptr() consume a pte_t pointer"). Unfortunately it causes the
>>> following issue on most of my ARM 32bit based test boards:
>>>
>>
>> That is ... rather surprising.
>>
>> The issue below seems to point at __pte_offset_map_lock(), where we
>> essentially convert from
>>
>> ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>>
>> to
>>
>> ptlock_ptr(virt_to_ptdesc(pte));
>
> I'm wondering, is highmem involved here such that the PTE would be 
> kmap'ed and virt_to_page() would not do what we would expect it to do?

Yes, highmem is enabled on those boards and all of them have 1GB+ of 
RAM. For other kernel configuration options see 
arch/arm/configs/exynos_defconfig.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


