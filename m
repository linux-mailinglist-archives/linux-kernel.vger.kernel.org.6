Return-Path: <linux-kernel+bounces-449641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C4A9F5259
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C591893A85
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607741F8933;
	Tue, 17 Dec 2024 17:14:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316961F8697
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455681; cv=none; b=U3Glqm8l29NZGPE6wbEorFB8uZjtCNYDBfXvQwXP5Nlu0I2rPeeqqbYr6D2/jvmwAwW/8GHzbT/HhIU8yUgFS5g3J/puPD/VTk3T0CvU9P7dYVlEiiHLjvF4Dwk13O6rHJiSsTDjBG0ehqwbIGjOdW0DIvM1xPKOTiRa4zjGwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455681; c=relaxed/simple;
	bh=qR26EFUI8NqAbw/UgrpbA6zFHpDxLYDzf9KEImFQHHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9N+3j6xqes+dIOX693nuWRfn/A7L+WEBIWnM/gAtQe5Y8LYGzyqA4ZOZ+WNmXmB5MLuF1xPo1/2ONgD9+nMwsAMYc31yGNvpa9/s2RGma0znL0iOuoliAn2W1Rv9Uc/IH1SFP8Q8qSbZ0c3kDfC7py1bZY2qXtYFcrbGDN35QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D1DDFEC;
	Tue, 17 Dec 2024 09:15:06 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43E843F7B4;
	Tue, 17 Dec 2024 09:14:33 -0800 (PST)
Message-ID: <011afa85-285d-4b26-9fac-e957f0812ebf@arm.com>
Date: Tue, 17 Dec 2024 17:14:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] khugepaged: Generalize
 __collapse_huge_page_isolate()
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, Matthew Wilcox <willy@infradead.org>,
 g@casper.infradead.org
Cc: akpm@linux-foundation.org, david@redhat.com,
 kirill.shutemov@linux.intel.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu,
 haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
 surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
 zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-6-dev.jain@arm.com>
 <Z2D-5y65onX_qOLi@casper.infradead.org>
 <82c8712b-b7c3-4b58-8b29-dbc436d885be@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <82c8712b-b7c3-4b58-8b29-dbc436d885be@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/12/2024 06:41, Dev Jain wrote:
> 
> On 17/12/24 10:02 am, Matthew Wilcox wrote:
>> On Mon, Dec 16, 2024 at 10:20:58PM +0530, Dev Jain wrote:
>>>   {
>>> -    struct page *page = NULL;
>>> -    struct folio *folio = NULL;
>>> -    pte_t *_pte;
>>> +    unsigned int max_ptes_shared = khugepaged_max_ptes_shared >>
>>> (HPAGE_PMD_ORDER - order);
>>> +    unsigned int max_ptes_none = khugepaged_max_ptes_none >>
>>> (HPAGE_PMD_ORDER - order);
>>>       int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>>> +    struct folio *folio = NULL;
>>> +    struct page *page = NULL;
>> why are you moving variables around unnecessarily?
> 
> In a previous work, I moved code around and David noted to arrange the declarations
> in reverse Xmas tree order. I guess (?) that was not spoiling git history, so if
> this feels like that, I will revert.
> 
>>
>>>       bool writable = false;
>>> +    pte_t *_pte;
>>>   -    for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>>> +
>>> +    for (_pte = pte; _pte < pte + (1UL << order);
>> spurious blank line
> 
> My bad
> 
>>
>>
>> also you might first want to finish off the page->folio conversion in
>> this function first; we have a vm_normal_folio() now.
> 
> I did not add any code before we derive the folio...I'm sorry, I don't get what
> you mean...
> 

I think Matthew is suggesting helping out with the folio to page conversion work
while you are working on this function. I think it would amount to a patch that
does something like this:

----8<-----
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ffc4d5aef991..d94e05754140 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -568,7 +568,6 @@ static int __collapse_huge_page_isolate(struct
vm_area_struct *vma,
        unsigned int max_ptes_none = khugepaged_max_ptes_none >>
(HPAGE_PMD_ORDER - order);
        int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
        struct folio *folio = NULL;
-       struct page *page = NULL;
        bool writable = false;
        pte_t *_pte;

@@ -597,13 +596,12 @@ static int __collapse_huge_page_isolate(struct
vm_area_struct *vma,
                        result = SCAN_PTE_UFFD_WP;
                        goto out;
                }
-               page = vm_normal_page(vma, address, pteval);
-               if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+               folio = vm_normal_folio(vma, address, pteval);
+               if (unlikely(!folio) || unlikely(folio_is_zone_device(folio))) {
                        result = SCAN_PAGE_NULL;
                        goto out;
                }

-               folio = page_folio(page);
                VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);

                if (order !=HPAGE_PMD_ORDER && folio_order(folio) >= order) {
----8<-----


