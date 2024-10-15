Return-Path: <linux-kernel+bounces-365709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3D99E719
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF321F2440A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1400C1E764A;
	Tue, 15 Oct 2024 11:49:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556A1CFEA9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992939; cv=none; b=N3zucA3EFDTQbwBCvK/0CSTPteCp368kEVzlPbhX83SIkKn7KJ8D4Ha/uwjEjbrPh9JZLLOM/p0KcenZp2ueSqGVHRgs70/a0k6ueq0EbLAKv42WqhITXm8IeQK+y7uU3i1JON8O3MZSDgwWKMjZKaJ6yef4x4JS+6PiUQNK0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992939; c=relaxed/simple;
	bh=IkMCuGvlaGTPHRYzqKhisXF2c3juHKSm5wDQFgL7a5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2NN0wb1zFlxhgt9reFXw9Awr4mGOMdWspwy6fMZeQiOVFOKbo08MIROy3SnkKqZbfndv/f8bj6m1RqlyWXYxBIeV1YXRelKiPLyoaP/TEKND28CgRE8z71QIZVgzEN6vnx2BvOWCLY3KOyMDTGnRRo3Q/6p6ymqvUk+GAh1u4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E89DA7;
	Tue, 15 Oct 2024 04:49:26 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BC853F51B;
	Tue, 15 Oct 2024 04:48:53 -0700 (PDT)
Message-ID: <23d2f123-ac9f-43b6-9b6e-8a77ea3b9044@arm.com>
Date: Tue, 15 Oct 2024 12:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <3e742298-2f38-496c-ba63-1e30d16318c6@broadcom.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3e742298-2f38-496c-ba63-1e30d16318c6@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 18:32, Florian Fainelli wrote:
> On 10/14/24 03:55, Ryan Roberts wrote:
>> Hi All,
>>
>> Patch bomb incoming... This covers many subsystems, so I've included a core set
>> of people on the full series and additionally included maintainers on relevant
>> patches. I haven't included those maintainers on this cover letter since the
>> numbers were far too big for it to work. But I've included a link to this cover
>> letter on each patch, so they can hopefully find their way here. For follow up
>> submissions I'll break it up by subsystem, but for now thought it was important
>> to show the full picture.
>>
>> This RFC series implements support for boot-time page size selection within the
>> arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), but to date, page
>> size has been selected at compile-time, meaning the size is baked into a given
>> kernel image. As use of larger-than-4K page sizes become more prevalent this
>> starts to present a problem for distributions. Boot-time page size selection
>> enables the creation of a single kernel image, which can be told which page size
>> to use on the kernel command line.
>>
>> Why is having an image-per-page size problematic?
>> =================================================
>>
>> Many traditional distros are now supporting both 4K and 64K. And this means
>> managing 2 kernel packages, along with drivers for each. For some, it means
>> multiple installer flavours and multiple ISOs. All of this adds up to a
>> less-than-ideal level of complexity. Additionally, Android now supports 4K and
>> 16K kernels. I'm told having to explicitly manage their KABI for each kernel is
>> painful, and the extra flash space required for both kernel images and the
>> duplicated modules has been problematic. Boot-time page size selection solves
>> all of this.
>>
>> Additionally, in starting to think about the longer term deployment story for
>> D128 page tables, which Arm architecture now supports, a lot of the same
>> problems need to be solved, so this work sets us up nicely for that.
>>
>> So what's the down side?
>> ========================
>>
>> Well nothing's free; Various static allocations in the kernel image must be
>> sized for the worst case (largest supported page size), so image size is in line
>> with size of 64K compile-time image. So if you're interested in 4K or 16K, there
>> is a slight increase to the image size. But I expect that problem goes away if
>> you're compressing the image - its just some extra zeros. At boot-time, I expect
>> we could free the unused static storage once we know the page size - although
>> that would be a follow up enhancement.
>>
>> And then there is performance. Since PAGE_SIZE and friends are no longer
>> compile-time constants, we must look up their values and do arithmetic at
>> runtime instead of compile-time. My early perf testing suggests this is
>> inperceptible for real-world workloads, and only has small impact on
>> microbenchmarks - more on this below.
>>
>> Approach
>> ========
>>
>> The basic idea is to rid the source of any assumptions that PAGE_SIZE and
>> friends are compile-time constant, but in a way that allows the compiler to
>> perform the same optimizations as was previously being done if they do turn out
>> to be compile-time constant. Where constants are required, we use limits;
>> PAGE_SIZE_MIN and PAGE_SIZE_MAX. See commit log in patch 1 for full description
>> of all the classes of problems to solve.
>>
>> By default PAGE_SIZE_MIN=PAGE_SIZE_MAX=PAGE_SIZE. But an arch may opt-in to
>> boot-time page size selection by defining PAGE_SIZE_MIN & PAGE_SIZE_MAX. arm64
>> does this if the user selects the CONFIG_ARM64_BOOT_TIME_PAGE_SIZE Kconfig,
>> which is an alternative to selecting a compile-time page size.
>>
>> When boot-time page size is active, the arch pgtable geometry macro definitions
>> resolve to something that can be configured at boot. The arm64 implementation in
>> this series mainly uses global, __ro_after_init variables. I've tried using
>> alternatives patching, but that performs worse than loading from memory; I think
>> due to code size bloat.
> 
> FWIW, this paragraph was not entirely clear to me until I looked at patch 57 to
> see that the compile time page size selection had been retained, and could
> continue to be used as-is. It was somewhat implicit, but not IMHO explicit
> enough, not a big deal though.

I intended to make that bit clear with the above sentance "arm64 does this if
the user selects the CONFIG_ARM64_BOOT_TIME_PAGE_SIZE Kconfig, which is an
alternative to selecting a compile-time page size.", but appreciate there is a
lot going on here.

> 
> Great work, thanks for doing that! This makes me wonder if we could leverage any
> of that to have a single kernel supporting both LPAE and !LPAE on ARM 32-bit,
> but that still seems like somewhat more difficult, largely due to the difference
> in the page table descriptor format (long vs. short).

We will eventually have the exact same problem with FEAT_D128 on arm64. This
introduces page tables with 128 bit PTEs. Ideally we would like to support both
in a single image, although, we have much more thinking to do on that. But my
current view is that this series solves a bunch of problems that makes it easier
(PTRS_PER_Pxx and Pxx_SHIFT all become boot-time values, for example, so we can
easily represent the different geometries).

Yes, we still need to solve the PTE size difference (in our case 64-bit vs
128-bit). I have a couple of proposals for how to do that; the "gold-plated"
approach would be to create and use a handle type to represent a PTE/PxD slot in
a table. Then increments/decrements would be enforced via explicit helpers that
know the size, and direct dereferencing would be impossible. When accessing via
helpers we would pass around pte_t/pxd_t values that are the larger size, then
narrow then when writing back.

Anshuman has a series [1] that starts to move in that direction.

If you have any other ideas, it would be good to talk!

[1]
https://lore.kernel.org/linux-mm/20240917073117.1531207-1-anshuman.khandual@arm.com/

Thanks,
Ryan




