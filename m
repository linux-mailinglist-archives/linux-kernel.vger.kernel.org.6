Return-Path: <linux-kernel+bounces-448687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547B9F444E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597201890192
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4A17277F;
	Tue, 17 Dec 2024 06:41:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA2143C63
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417719; cv=none; b=dpFYLd7djEQmScl/u/NUj5Hw+uILwPP5QEAAzzIAzp6G1VfhiOt3OSDFLnlbXeZzhMgz7x+hWBdcFS4jireUSQB/3C4AIWTzNNVgr1Lu0bGnt/XpCFff30lK4EPhkXQk/Sz74hBrWcmcR14EmJewaeM3dpRVl4+f4psFKngT0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417719; c=relaxed/simple;
	bh=sj1X3z302B3dUwrzqRaXvIySoO0xcDOiC91wPzq8SY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8y0UbYvCtlkyDyvQcPziALtlxh+ZBbnlD5lo3+WWSm+x2mv0iRhujG6Wm5ZyjVLTFVdisVxHDr1Dpi5XCYRasJGF23j459PrusbNWaWppZDFVhOoPNvOndlhaSFde9+N9ps4PrZ68BcU2ydhOwpgE69JQ+vJdgmRZc8df6N2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97BD31007;
	Mon, 16 Dec 2024 22:42:23 -0800 (PST)
Received: from [10.162.40.67] (K4MQJ0H1H2.blr.arm.com [10.162.40.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5B53F528;
	Mon, 16 Dec 2024 22:41:45 -0800 (PST)
Message-ID: <82c8712b-b7c3-4b58-8b29-dbc436d885be@arm.com>
Date: Tue, 17 Dec 2024 12:11:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] khugepaged: Generalize
 __collapse_huge_page_isolate()
To: Matthew Wilcox <willy@infradead.org>, g@casper.infradead.org
Cc: akpm@linux-foundation.org, david@redhat.com,
 kirill.shutemov@linux.intel.com, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-6-dev.jain@arm.com>
 <Z2D-5y65onX_qOLi@casper.infradead.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z2D-5y65onX_qOLi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/12/24 10:02 am, Matthew Wilcox wrote:
> On Mon, Dec 16, 2024 at 10:20:58PM +0530, Dev Jain wrote:
>>   {
>> -	struct page *page = NULL;
>> -	struct folio *folio = NULL;
>> -	pte_t *_pte;
>> +	unsigned int max_ptes_shared = khugepaged_max_ptes_shared >> (HPAGE_PMD_ORDER - order);
>> +	unsigned int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
>>   	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>> +	struct folio *folio = NULL;
>> +	struct page *page = NULL;
> why are you moving variables around unnecessarily?

In a previous work, I moved code around and David noted to arrange the declarations
in reverse Xmas tree order. I guess (?) that was not spoiling git history, so if
this feels like that, I will revert.

>
>>   	bool writable = false;
>> +	pte_t *_pte;
>>   
>> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>> +
>> +	for (_pte = pte; _pte < pte + (1UL << order);
> spurious blank line

My bad

>
>
> also you might first want to finish off the page->folio conversion in
> this function first; we have a vm_normal_folio() now.

I did not add any code before we derive the folio...I'm sorry, I don't get what you mean...


