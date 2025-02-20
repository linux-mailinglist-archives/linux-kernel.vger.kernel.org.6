Return-Path: <linux-kernel+bounces-524304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE7A3E1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B2E3B84BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE35212B04;
	Thu, 20 Feb 2025 16:54:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F620C00D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070453; cv=none; b=RWku81NTVGG+qKbiN9m71Xbtz8g7zN6u3fLerejlfeHYEgpYP16WF4CNS6ip9WVHxm/r5PQly+d5oEMkH7DFFlIEkd13ZiBMSqBPFe9yh5wo3WnHcyQ7Z6GTdfn47sy42jj5jf3lYoh68I8+8OuWH644tPbhIyaHXMkNUstIglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070453; c=relaxed/simple;
	bh=0ihVrinw115rJrSYXwInOqAt0jxw5Rnkv8t8xQTnuTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDCF2o+BIV11wI56dTzyDixeG08kCZ8IV6J7q5qKW4G0z7lgoFqO08g2AaaYaRxF1kkO+0DuLvK9SApFzxgO3oxCvBZl6/t8+TrnFVD/m3gXu6aty00tDX53oo8WMwpF8KPJIchFuSniCTga6YHIfJQdkZz4MZjoNIf08g3Oo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5A0316F3;
	Thu, 20 Feb 2025 08:54:27 -0800 (PST)
Received: from [10.57.80.147] (unknown [10.57.80.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7703F5A1;
	Thu, 20 Feb 2025 08:54:06 -0800 (PST)
Message-ID: <fc199d7c-ab09-4278-b641-962184bff14d@arm.com>
Date: Thu, 20 Feb 2025 17:54:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] arm64/mm: Avoid barriers for invalid or
 userspace mappings
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-8-ryan.roberts@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250217140809.1702789-8-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 15:07, Ryan Roberts wrote:
> __set_pte_complete(), set_pmd(), set_pud(), set_p4d() and set_pgd() are

Nit: it would be more accurate to say __set_pte() instead of
__set_pte_complete(), as it is the former that actually writes the PTE
(and then issues barriers).

> used to write entries into pgtables. And they issue barriers (currently
> dsb and isb) to ensure that the written values are observed by the table
> walker prior to any program-order-future memory access to the mapped
> location.
>
> Over the years some of these functions have received optimizations: In
> particular, commit 7f0b1bf04511 ("arm64: Fix barriers used for page
> table modifications") made it so that the barriers were only emitted for
> valid-kernel mappings for set_pte() (now __set_pte_complete()). And
> commit 0795edaf3f1f ("arm64: pgtable: Implement p[mu]d_valid() and check
> in set_p[mu]d()") made it so that set_pmd()/set_pud() only emitted the
> barriers for valid mappings. set_p4d()/set_pgd() continue to emit the
> barriers unconditionally.
>
> This is all very confusing to the casual observer; surely the rules
> should be invariant to the level? Let's change this so that every level
> consistently emits the barriers only when setting valid, non-user
> entries (both table and leaf).
>
> It seems obvious that if it is ok to elide barriers all but valid kernel
> mappings at pte level, it must also be ok to do this for leaf entries at
> other levels: If setting an entry to invalid, a tlb maintenance
> operation must surely follow to synchronise the TLB and this contains
> the required barriers. If setting a valid user mapping, the previous
> mapping must have been invalid and there must have been a TLB
> maintenance operation (complete with barriers) to honour
> break-before-make. So the worst that can happen is we take an extra
> fault (which will imply the DSB + ISB) and conclude that there is
> nothing to do. These are the arguments for doing this optimization at
> pte level and they also apply to leaf mappings at other levels.
>
> For table entries, the same arguments hold: If unsetting a table entry,
> a TLB is required and this will emit the required barriers. If setting a

s/TLB/TLB maintenance/

> table entry, the previous value must have been invalid and the table
> walker must already be able to observe that. Additionally the contents
> of the pgtable being pointed to in the newly set entry must be visible
> before the entry is written and this is enforced via smp_wmb() (dmb) in
> the pgtable allocation functions and in __split_huge_pmd_locked(). But
> this last part could never have been enforced by the barriers in
> set_pXd() because they occur after updating the entry. So ultimately,
> the wost that can happen by eliding these barriers for user table

s/wost/worst/

- Kevin

> entries is an extra fault.
>
> [...]


