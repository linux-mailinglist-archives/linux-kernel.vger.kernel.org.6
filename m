Return-Path: <linux-kernel+bounces-256410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD88934DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF19B1F238FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475D313D2A9;
	Thu, 18 Jul 2024 13:22:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1A71BF37
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308920; cv=none; b=e+z6fSEo4dfOe/1bIUJAqfhDW0wjtSmieT6lkXgP7v+n5EJCPGmJeZbHaprtmR3JX0DbO5Rg3HPG/+9i2DKuxFUmxzJIKozUdD4EFfRy/9UT54cYQRK13NpEy0TdqFg/kTrg/y3dMzIyzDffjtmDlNl26duPuRCsZqhd1pX0IL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308920; c=relaxed/simple;
	bh=JHANG8f8IhvWHGPtxZFQ+4PpDwovt0i74Bz48lAJWVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAz2HszydHmWOHLgYPdXP9rnUQSSEHPf5ZLK3IAQWemqNopzmi9nMTLjECeasMPITkTqzDT/MSV942Lw6NfFkPMdAGx4otpqofNHCNeoyQhooT0T/cNKlqeSeQC6BI6RTfcBq6QTAbKELFRelLGSBB431iX2v2gf7IImY/cNEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA57C1063;
	Thu, 18 Jul 2024 06:22:21 -0700 (PDT)
Received: from [10.162.42.20] (e116581.arm.com [10.162.42.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08A1C3F73F;
	Thu, 18 Jul 2024 06:21:52 -0700 (PDT)
Message-ID: <5a16730d-3153-45d2-870d-6ecdc2097b5b@arm.com>
Date: Thu, 18 Jul 2024 18:51:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
To: Will Deacon <will@kernel.org>, Asahi Lina <lina@asahilina.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com,
 mark.rutland@arm.com, ardb@kernel.org
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
 <20240718131428.GA21243@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240718131428.GA21243@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/18/24 18:44, Will Deacon wrote:
> Hi Lina, [+Ard, Mark and Ryan],
>
> On Thu, Jul 18, 2024 at 06:39:10PM +0900, Asahi Lina wrote:
>> I ran into this with the Asahi Linux downstream kernel, based on v6.9.9,
>> but I believe the problem is also still upstream. The issue seems to be
>> an interaction between folding one page table level at compile time and
>> another one at runtime.
> Thanks for reporting this!
>
>> With this config, we have:
>>
>> CONFIG_PGTABLE_LEVELS=4
>> PAGE_SHIFT=14
>> PMD_SHIFT=25
>> PUD_SHIFT=36
>> PGDIR_SHIFT=47
>> pgtable_l5_enabled() == false (compile time)
>> pgtable_l4_enabled() == false (runtime, due to no LPA2)
> I think this is 'defconfig' w/ 16k pages, although I wasn't able to
> trigger the issue quickly under QEMU with that. Your analysis looks
> correct, however.

Hi Will,

I was also trying to debug this; indeed this is 16K defconfig, and
pgtable_l4_enabled() is returning false on non-LPA2 hardware. Is this
the intended behaviour? Don't we require 4-level pagetable to resolve
virtual addresses on 16K?

>
>> With p4d folded at compile-time, and pud folded at runtime when LPA2 is
>> not supported.
>>
>> With this setup, pgd_offset() is broken since the pgd is actually
>> supposed to become a pud but the shift is wrong, as it is set at compile
>> time:
>>
>> #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>>
>> static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
>> {
>>          return (pgd + pgd_index(address));
>> };
>>
>> Then we follow the gup logic (abbreviated):
>>
>> gup_pgd_range:
>>      pgdp = pgd_offset(current->mm, addr);
>>      pgd_t pgd = READ_ONCE(*pgdp);
>>
>> At this point, pgd is just the 0th entry of the top level page table
>> (since those extra address bits will always be 0 for valid 47-bit user
>> addresses).
>>
>> p4d then gets folded via pgtable-nop4d.h:
>>
>> gup_p4d_range:
>>      p4dp = p4d_offset_lockless(pgdp, pgd, addr);
>>           = p4d_offset(&(pgd), address)
>>           = &pgd
>>      p4d_t p4d = READ_ONCE(*p4dp);
>>
>> Now we have p4dp = stack address of pgd, and p4d = pgd.
>>
>> gup_pud_range:
>>      pudp = pud_offset_lockless(p4dp, p4d, addr);
>>           -> if (!pgtable_l4_enabled())
>>             = p4d_to_folded_pud(p4dp, addr);
>>             = (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
>>      pud_t pud = READ_ONCE(*pudp);
>>
>> Which is bad pointer math because it only works if p4dp points to a real
>> page table entry inside a page table, not a single u64 stack address.
> Cheers for the explanation; I agree that 6.10 looks like it's affected
> in the same way, even though I couldn't reproduce the crash. I think the
> root of the problem is that p4d_offset_lockless() returns a stack
> address when the p4d level is folded. I wondered about changing the
> dummy pXd_offset_lockless() definitions in linux/pgtable.h to pass the
> real pointer through instead of the address of the local, but then I
> suppose _most_ pXd_offset() implementations are going to dereference
> that and it would break the whole point of having _lockless routines
> to start with.
>
> What if we provided our own implementation of p4d_offset_lockless()
> for the folding case, which could just propagate the page-table pointer?
> Diff below.
>
>> This causes random oopses in internal_get_user_pages_fast and related
>> codepaths.
> Do you have a reliable way to trigger those? I tried doing some GUPpy
> things like strace (access_process_vm()) but it all seemed fine.
>
> Thanks,
>
> Will
>
> --->8
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index f8efbc128446..3afe624a39e1 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1065,6 +1065,13 @@ static inline bool pgtable_l5_enabled(void) { return false; }
>   
>   #define p4d_offset_kimg(dir,addr)      ((p4d_t *)dir)
>   
> +static inline
> +p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
> +{
> +       return p4d_offset(pgdp, addr);
> +}
> +#define p4d_offset_lockless p4d_offset_lockless
> +
>   #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
>   
>   #define pgd_ERROR(e)   \
>
>

