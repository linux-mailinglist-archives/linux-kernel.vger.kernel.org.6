Return-Path: <linux-kernel+bounces-271398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F15944DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F241C23038
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6851A4875;
	Thu,  1 Aug 2024 14:07:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19A516DECD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521259; cv=none; b=emM1TBTm2XeCBThLR7uvOS5r/JtqeTcbYpP8XxI6qu25AVBLmkK9Tj6L3Pmpecvnjq2EvN0WQp4MZJTN1ICqzjNXnqD1N/RRdHeNbEe/WEej9oWCHFVpPwsxS7Qh1Wgtli6YnavgpwQtddLntbESncL8iaPDznsKNA7JibXW3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521259; c=relaxed/simple;
	bh=51a62OkD3auz+ui0Ndei3bZFmYLN0yT07KuYiU9gbMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp7CU21Kn/UJhz747QPABLxm2ZHbeGFgFbhpiISj4Endwi1+XFJhudNZFbcZEwVxFy5WMd5450oA49jM9ZazmnP+VC73FtpkJDpdfgm+m31PZmJGfLg+CBMfDMRNhWd9b3wC1YCN75Mh0KHH1W4/wUG+Ca6HhFrrY8n76F2CG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82DEB15A1;
	Thu,  1 Aug 2024 07:07:59 -0700 (PDT)
Received: from [10.1.28.152] (XHFQ2J9959.cambridge.arm.com [10.1.28.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E2E3F766;
	Thu,  1 Aug 2024 07:07:32 -0700 (PDT)
Message-ID: <b0a34ffa-5a5e-4048-8b44-ff2c9510ec9a@arm.com>
Date: Thu, 1 Aug 2024 15:07:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Avoid direct referencing page table enties in
 map_range()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
References: <20240725091052.314750-1-anshuman.khandual@arm.com>
 <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
 <20240801113440.GB4476@willie-the-truck>
 <c65c0bcc-149e-4f30-9bab-e5377230d2cd@arm.com>
 <20240801132326.GA4794@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240801132326.GA4794@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2024 14:23, Will Deacon wrote:
> On Thu, Aug 01, 2024 at 01:48:17PM +0100, Ryan Roberts wrote:
>> On 01/08/2024 12:34, Will Deacon wrote:
>>> On Thu, Jul 25, 2024 at 11:36:56AM +0100, Ryan Roberts wrote:
>>>> On 25/07/2024 10:10, Anshuman Khandual wrote:
>>>>> Like else where in arm64 platform, use WRITE_ONCE() in map_range() while
>>>>> creating page table entries. This avoids referencing page table entries
>>>>> directly.
>>>>
>>>> I could be wrong, but I don't think this code is ever operating on live
>>>> pgtables? So there is never a potential to race with the HW walker and therefore
>>>> no need to guarrantee copy atomicity? As long as the correct barriers are placed
>>>> at the point where you load the pgdir into the TTBRx there should be no problem?
>>>>
>>>> If my assertion is correct, I don't think there is any need for this change.
>>>
>>> Agreed.
>>
>> I think I need to row back on this. It looks like map_range() does act on live
>> pgtables; see map_kernel() where twopass == true. init_pg_dir is populated then
>> installed in TTBR1, then permissions are modified with 3 [un]map_segment()
>> calls, which call through to map_range().
> 
> I think the permission part is fine, but I hadn't spotted that
> unmap_segment() uses map_range() to zap the ptes mapping the text. That
> *does* need single-copy atomicity, so should probably use
> __set_pte_nosync().

Yes, nice.

> 
>> So on that basis, I think the WRITE_ONCE() calls are warranted. And to be
>> consistent, I'd additionally recommend adding a READ_ONCE() around the:
>>
>> if (pte_none(*tbl)) {
> 
> Why? I don't think we need that.

I Agree its not technically required. I was suggesting it just for consistency with the other change. So perhaps __ptep_get()?


diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 5410b2cac5907..3f6c5717ff782 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -55,13 +55,14 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
                         * This chunk needs a finer grained mapping. Create a
                         * table mapping if necessary and recurse.
                         */
-                       if (pte_none(*tbl)) {
-                               *tbl = __pte(__phys_to_pte_val(*pte) |
-                                            PMD_TYPE_TABLE | PMD_TABLE_UXN);
+                       if (pte_none(__ptep_get(tbl))) {
+                               __set_pte_nosync(tbl,
+                                            __pte(__phys_to_pte_val(*pte) |
+                                            PMD_TYPE_TABLE | PMD_TABLE_UXN));
                                *pte += PTRS_PER_PTE * sizeof(pte_t);
                        }
                        map_range(pte, start, next, pa, prot, level + 1,
-                                 (pte_t *)(__pte_to_phys(*tbl) + va_offset),
+                                 (pte_t *)(__pte_to_phys(__ptep_get(tbl)) + va_offset),
                                  may_use_cont, va_offset);
                } else {
                        /*
@@ -79,7 +80,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
                                protval &= ~PTE_CONT;
 
                        /* Put down a block or page mapping */
-                       *tbl = __pte(__phys_to_pte_val(pa) | protval);
+                       __set_pte_nosync(tbl, __pte(__phys_to_pte_val(pa) | protval));
                }
                pa += next - start;
                start = next;


> 
> Will


