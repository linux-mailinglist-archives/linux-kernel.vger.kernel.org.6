Return-Path: <linux-kernel+bounces-251480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E331930556
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020411F21B96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B028861FF8;
	Sat, 13 Jul 2024 11:05:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B660263
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868737; cv=none; b=o6GYQHWqE7h7SDQBeNtsBGD3DfmDBWtqnh/k0vrJzl3s91cnq7uN83DS7+8SGGV6SgAEiAcgn1uUgBDJ4s9yOxMh4Y/TWfwHSUJxBt04ef2FxydKNvf4BIgsrVQCM3psHizCu1aSZ4DIVc5qhuorvM+4bhuRVVvyeK2ZEhOFUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868737; c=relaxed/simple;
	bh=NfDz3riJCs+yz/7Ke3ZKJhU6e5Q313Wy6qLKatzHHB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLYqC5DaUozWJfyhJKg2O464kJLNCRhLNy9Ve6TgJNruw6NxmHbfk3D8pWQWM7Ifj0ofE3/8MfGU/txbi13qs2dKb3eJfJBamlQfzhLFWGnFU3GvFn4QytCQXDPHeQg0rFm5Q+paXrzqatDH4hdy85RE0Ltv1+ldvRT6igdKvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAC6B1007;
	Sat, 13 Jul 2024 04:05:59 -0700 (PDT)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963F53F762;
	Sat, 13 Jul 2024 04:05:33 -0700 (PDT)
Message-ID: <aed6f61e-49ed-414b-acc1-25f5ed6d4e09@arm.com>
Date: Sat, 13 Jul 2024 12:05:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, william.kucharski@oracle.com, david@redhat.com,
 shan.gavin@gmail.com
References: <20240711104840.200573-1-gshan@redhat.com>
 <ZpBEwEn3swH7IFbI@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZpBEwEn3swH7IFbI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2024 21:46, Matthew Wilcox wrote:
> On Thu, Jul 11, 2024 at 08:48:40PM +1000, Gavin Shan wrote:
>> +++ b/mm/huge_memory.c
>> @@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  
>>  		while (orders) {
>>  			addr = vma->vm_end - (PAGE_SIZE << order);
>> -			if (thp_vma_suitable_order(vma, addr, order))
>> +			if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
>> +			    thp_vma_suitable_order(vma, addr, order))
>>  				break;
> 
> Why does 'orders' even contain potential orders that are larger than
> MAX_PAGECACHE_ORDER?
> 
> We do this at the top:
> 
>         orders &= vma_is_anonymous(vma) ?
>                         THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
> 
> include/linux/huge_mm.h:#define THP_ORDERS_ALL_FILE     (BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> ... and that seems very wrong.  We support all kinds of orders for
> files, not just PMD order.  We don't support PUD order at all.
> 
> What the hell is going on here?

Just to try to justify this a little, it was my perspective when adding (anon)
mTHP that memory was either anon or file; Anything that populated vma->vm_file
was file, including shmem, DAX, etc. Before my change THP could install PMD size
mappings for anon, and PMD or PUD size mappings for file memory (but yes, PUD
was only really applicable to DAX in practice, I believe).

I agree it would be good to clean this up, but I don't think the current code is
quite as mad as you're implying, Matthew?


