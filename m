Return-Path: <linux-kernel+bounces-554661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCFA59B11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500957A6902
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FDC230BE6;
	Mon, 10 Mar 2025 16:31:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149BD230BCE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624303; cv=none; b=KOM3A+/VSOXWrzJVBfHivRYTpE8Fms28r0/h1Kip4IK3wF4kHv6FITEHi4SfdyUpI4q/LYMhgsJIZ3M+Isdb3u3h5yTDMLbwDlOC5jBPTpEBO1nC896UqyafVl5X6qbsYDuPoOZwEbC5Z2RAA0deFVhvHNDvpepctPnb6u2q/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624303; c=relaxed/simple;
	bh=wPxmxtZ0L1CpbfM5XV6kkpSzMXwHwYpSGhpvzwxys2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDK/yE4VriOy6NGXLD3789L3M1yisHiGdcsnzU45t+oq3MB5nKf8AQ3nSdQa6oFWlmDpSgpSGczQKSZ49n2aeSrcWTxfVEyjTZCs6TLoWrBH3tw+/QskG4yIra6CYPlwJzwtp2CRLt83Vksxf14WMefGvEFjNqyi44f2vBucpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D031692;
	Mon, 10 Mar 2025 09:31:52 -0700 (PDT)
Received: from [10.57.83.165] (unknown [10.57.83.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D4A3F5A1;
	Mon, 10 Mar 2025 09:31:40 -0700 (PDT)
Message-ID: <661898ee-c1f9-4f51-a73d-b70fe2eccd84@arm.com>
Date: Mon, 10 Mar 2025 16:31:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: use ptep_get() instead of directly dereferencing
 pte_t*
Content-Language: en-GB
To: Qi Zheng <zhengqi.arch@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250310140418.1737409-1-ryan.roberts@arm.com>
 <f0d9986d-b3f0-42db-8fb6-d6087dd77f7d@bytedance.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f0d9986d-b3f0-42db-8fb6-d6087dd77f7d@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2025 15:51, Qi Zheng wrote:
> Hi Ryan,
> 
> On 3/10/25 10:04 PM, Ryan Roberts wrote:
>> It is best practice for all pte accesses to go via the arch helpers, to
>> ensure non-torn values and to allow the arch to intervene where needed
>> (contpte for arm64 for example). While in this case it was probably safe
>> to directly dereference, let's tidy it up for consistency.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/migrate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This looks good to me. So
> 
> Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks!

> 
> BTW, there are many other places in the kernel that directly
> dereference pmd_t* and pud_t*, etc.

It's all a little bit murky. For now, from arm64's perspective at least, there
is only a hard requirement for ptes to be accessed through the arch helper. This
is because arm64's contpte layer may apply a transform when reading the pte.

In general there are also potential issues with tearing, if you don't at least
read with READ_ONCE(). But often to consumer of the value is tolerant to tearing
(e.g. pmd_none(), etc). Also, in practice on arm64 the compiler will emit
instructions that ensure single-copy-atomicity for direct dereferences, so it
all works out.

That said, Anshuman (cc'ed) has been looking at supporting FEAT_D128 (128 bit
page table descriptors) on arm64. The compiler does not emit single-copy-atomic
loads for direct dereferences of 128 bit data, so he has been working on
converting the other levels to use the accessors for that reason.

But that has some potentially problematic interactions with level folding that
need to be solved. Some arches rely on the compiler optimizing away the direct
dereferences when folded. But it can't do that for a READ_ONCE().

I believe Anshuman is aiming to post a series to do this at some point in the
future.

Thanks,
Ryan

> 
> For example:
> 
> root@debian:~# grep "*vmf->pmd" . -rwn
> ./mm/memory.c:5113:    if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
> ./mm/memory.c:5207:    if (unlikely(!pmd_none(*vmf->pmd)))
> ./mm/memory.c:5339:    if (pmd_none(*vmf->pmd)) {
> ./mm/memory.c:5490:    if (pmd_none(*vmf->pmd)) {
> ./mm/memory.c:5996:    if (unlikely(pmd_none(*vmf->pmd))) {
> ./mm/filemap.c:3612:    if (pmd_trans_huge(*vmf->pmd)) {
> ./mm/filemap.c:3618:    if (pmd_none(*vmf->pmd) &&
> folio_test_pmd_mappable(folio)) {
> ./mm/filemap.c:3628:    if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
> ./mm/huge_memory.c:1237:    if (unlikely(!pmd_none(*vmf->pmd))) {
> ./mm/huge_memory.c:1352:        if (pmd_none(*vmf->pmd)) {
> ./mm/huge_memory.c:1496:    if (pmd_none(*vmf->pmd)) {
> ./mm/huge_memory.c:1882:    if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
> ./mm/huge_memory.c:1947:    if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
> ./mm/huge_memory.c:1965:        if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
> ./fs/dax.c:1935:    if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
> ./fs/dax.c:2058:    if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
> ./fs/dax.c:2059:            !pmd_devmap(*vmf->pmd)) {
> 
> Would it be best to clean them up as well?
> 
> Thanks,
> Qi
> 
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 22e270f727ed..33a22c2d6b20 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -202,7 +202,7 @@ static bool try_to_map_unused_to_zeropage(struct
>> page_vma_mapped_walk *pvmw,
>>           return false;
>>       VM_BUG_ON_PAGE(!PageAnon(page), page);
>>       VM_BUG_ON_PAGE(!PageLocked(page), page);
>> -    VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
>> +    VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>>
>>       if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>>           mm_forbids_zeropage(pvmw->vma->vm_mm))
>> -- 
>> 2.43.0
>>
> 


