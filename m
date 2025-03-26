Return-Path: <linux-kernel+bounces-577176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3CA71984
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E55F3A8921
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842651F30AD;
	Wed, 26 Mar 2025 14:54:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679D1E502
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000878; cv=none; b=N4jcn7kWdtT4wRgyfS/eUTEn40m4M4zSwFzeAvyt27Yq96Fdg1xr8jOot0bP8Z9ZgGcoJNceGnxugOQMSxTbOfx0WLDQCUDJeZhCckJ4o70HyOJ5RJEYjmAMsdiKv1CHGLb98IEq096AzeWFcM1FIUrK0x01M//L0CjPj1GnjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000878; c=relaxed/simple;
	bh=Se+K6Wfd9Bfl7Oq4768qjGj5L6qzm3coIJCKps4g66k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGSgU3hPtzb0jEh8CvA7ez4g+wMYs5FeH9ixYIh9h9iVsn34+jV88QNadJKTrp9K80peImJbHxaKEbrtljTQ4FvhAs7Qd6h8xc5Ff0lVQbaKFAV/gzKgPPQoqyovxJx6LRDQarl/cBNTKlUrhlcIKrpqQGz6z+mezcYWxcJSNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F099D1424;
	Wed, 26 Mar 2025 07:54:35 -0700 (PDT)
Received: from [10.57.82.15] (unknown [10.57.82.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E974F3F63F;
	Wed, 26 Mar 2025 07:54:26 -0700 (PDT)
Message-ID: <5a5f22cb-1bd7-4dcb-85cc-f412de79b87b@arm.com>
Date: Wed, 26 Mar 2025 10:54:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] mm/page_table_check: Batch-check pmds/puds just
 like ptes
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250304150444.3788920-1-ryan.roberts@arm.com>
 <20250304150444.3788920-4-ryan.roberts@arm.com>
 <CA+CK2bA3ctd6+G9DrJZ3RvnehPCrf7hEJ3boFJ5pkMTZyVmDSQ@mail.gmail.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CA+CK2bA3ctd6+G9DrJZ3RvnehPCrf7hEJ3boFJ5pkMTZyVmDSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 10:48, Pasha Tatashin wrote:
>> -void __page_table_check_pud_set(struct mm_struct *mm, pud_t *pudp, pud_t pud)
>> +void __page_table_check_puds_set(struct mm_struct *mm, pud_t *pudp, pud_t pud,
>> +               unsigned int nr)
>>  {
>> +       unsigned int i;
>> +       unsigned long stride = PUD_SIZE >> PAGE_SHIFT;
> 
> nit: please order declarations from longest to shortest, it usually
> helps with readability. (here and in pmd)

Noted, I'll fix this.

> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks!

> 
> Pasha


