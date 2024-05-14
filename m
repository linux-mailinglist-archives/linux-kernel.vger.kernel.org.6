Return-Path: <linux-kernel+bounces-178958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0918C59CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B04FB20AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939992B9AF;
	Tue, 14 May 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYMEDT0v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E8365
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704490; cv=none; b=JMSxlcHRukQdD5SjFj2N3Oy9OqyJMjNB74+ooEK40PBlIpBPLaHZY0tLuwNr4m4ftY12399AKEPdbeLX2Gh5HLgacp1m7kOgsL6kb9fWeeWUq8foJJHxQN0XH5b/8rU47IUWQaYwB04320iayruG5nAKCjDN6BD4nxd039tcmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704490; c=relaxed/simple;
	bh=bquuasHCV5I/L0YtYX6erf/Sqf5ntgz+jwR6bM97uoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpoEjLJkRH6c2rwMwLOGEx9/hTnoepqeukvcyT+8QuwlKniiBWcvoVo/Ky+qpzz9I3FxG4XbrF7aocnDVYHTcASGSwSUtfUb/8uTBzMT0FY7yWagSVXDxAwtx84tM5vKJjEznyJN74HvraLOhZNYQfP9Y3OLHaxn55klskAgWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYMEDT0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3170C2BD10;
	Tue, 14 May 2024 16:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715704490;
	bh=bquuasHCV5I/L0YtYX6erf/Sqf5ntgz+jwR6bM97uoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FYMEDT0vkpzQD1yVnU2etV+jk/xcPPcRTnjJp1dXIe/kvA6wjKMmb83lmvnh8j5Dn
	 FwLVn5mOCLtsTAdqA8e9IKWDT8E1G/31jkuFdgTQUCFVqcwxZht7KJGKevoP0JH57J
	 zIBXGFM5s+eE2aQNps/yAwPufE7fmtUFgh5S+pdLnqdIwIE0yH8pddlodbrR/Hh68c
	 J+fx3cQBjp5VlcuCQVssVUXpZBD4CM8gk4ClcVRitd++N7JJMo/HaUn7xM2sRhbxoc
	 Y6npf+jqNIb0LcL/u5Ot+hkLv2CRV/M1fhsdaJAuwPjh2aZYzFqDbdqvwGc5WIeaJ4
	 ZKaBEjhF8DWgw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: David Hildenbrand <david@redhat.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Andrew Bresticker
 <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>, Santosh Mamila
 <santosh.mamila@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
In-Reply-To: <267be75e-ed4a-45d0-883f-51c7324c30f1@redhat.com>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-5-bjorn@kernel.org>
 <267be75e-ed4a-45d0-883f-51c7324c30f1@redhat.com>
Date: Tue, 14 May 2024 18:34:46 +0200
Message-ID: <87r0e4tkrd.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Hildenbrand <david@redhat.com> writes:

> On 14.05.24 16:04, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> For an architecture to support memory hotplugging, a couple of
>> callbacks needs to be implemented:
>>=20
>>   arch_add_memory()
>>    This callback is responsible for adding the physical memory into the
>>    direct map, and call into the memory hotplugging generic code via
>>    __add_pages() that adds the corresponding struct page entries, and
>>    updates the vmemmap mapping.
>>=20
>>   arch_remove_memory()
>>    This is the inverse of the callback above.
>>=20
>>   vmemmap_free()
>>    This function tears down the vmemmap mappings (if
>>    CONFIG_SPARSEMEM_VMEMMAP is enabled), and also deallocates the
>>    backing vmemmap pages. Note that for persistent memory, an
>>    alternative allocator for the backing pages can be used; The
>>    vmem_altmap. This means that when the backing pages are cleared,
>>    extra care is needed so that the correct deallocation method is
>>    used.
>>=20
>>   arch_get_mappable_range()
>>    This functions returns the PA range that the direct map can map.
>>    Used by the MHP internals for sanity checks.
>>=20
>> The page table unmap/teardown functions are heavily based on code from
>> the x86 tree. The same remove_pgd_mapping() function is used in both
>> vmemmap_free() and arch_remove_memory(), but in the latter function
>> the backing pages are not removed.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>   arch/riscv/mm/init.c | 242 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 242 insertions(+)
>>=20
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 6f72b0b2b854..7f0b921a3d3a 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1493,3 +1493,245 @@ void __init pgtable_cache_init(void)
>>   	}
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
>> +{
>> +	pte_t *pte;
>> +	int i;
>> +
>> +	for (i =3D 0; i < PTRS_PER_PTE; i++) {
>> +		pte =3D pte_start + i;
>> +		if (!pte_none(*pte))
>> +			return;
>> +	}
>> +
>> +	free_pages((unsigned long)page_address(pmd_page(*pmd)), 0);
>> +	pmd_clear(pmd);
>> +}
>> +
>> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
>> +{
>> +	pmd_t *pmd;
>> +	int i;
>> +
>> +	for (i =3D 0; i < PTRS_PER_PMD; i++) {
>> +		pmd =3D pmd_start + i;
>> +		if (!pmd_none(*pmd))
>> +			return;
>> +	}
>> +
>> +	free_pages((unsigned long)page_address(pud_page(*pud)), 0);
>> +	pud_clear(pud);
>> +}
>> +
>> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
>> +{
>> +	pud_t *pud;
>> +	int i;
>> +
>> +	for (i =3D 0; i < PTRS_PER_PUD; i++) {
>> +		pud =3D pud_start + i;
>> +		if (!pud_none(*pud))
>> +			return;
>> +	}
>> +
>> +	free_pages((unsigned long)page_address(p4d_page(*p4d)), 0);
>> +	p4d_clear(p4d);
>> +}
>> +
>> +static void __meminit free_vmemmap_storage(struct page *page, size_t si=
ze,
>> +					   struct vmem_altmap *altmap)
>> +{
>> +	if (altmap)
>> +		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
>> +	else
>> +		free_pages((unsigned long)page_address(page), get_order(size));
>
> If you unplug a DIMM that was added during boot (can happen on x86-64,=20
> can it happen on riscv?), free_pages() would not be sufficient. You'd be=
=20
> freeing a PG_reserved page that has to be freed differently.

I'd say if it can happen on x86-64, it probably can on RISC-V. I'll look
into this for the next spin!

Thanks for spending time on the series!


Cheers,
Bj=C3=B6rn

