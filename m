Return-Path: <linux-kernel+bounces-379835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A919AE46C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA132830D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C721D1739;
	Thu, 24 Oct 2024 12:10:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60F17B51A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771835; cv=none; b=RGw+9jpRldWpdJBaYdwGHgAgTYX83pPWJpyA/GjIE2e7BPtIO1iIrgyLHhRbECJG8rKepEWm6nZReABuN17WHeCA0vRq5dZhHx+/irU5glhkDSTJF+56Ma9NaYJF5HN8uj4061qETBtRb+NcKyDOE2gbS7uGROUyPZm8rYSZGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771835; c=relaxed/simple;
	bh=1m7S5pqwCW444uF1ojIoDIjKlcAnEzDxOThfy1SBNa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiONBDb/TUFfnBEmcPEQgVdUofkP31HgJv9dmMeL/lmnJEfrdvFwNtmIbJwtxO0j1Q2J54hkHYk5PTLeK0OM7Brf7Z04vYlwX4N4ei+aZXKYXmAnbLyM5HQ18b2LY4avCJqagg5gQyYSVb0Oi9c+ROFmSoYxDlzRNk4uN9y5tgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEB5339;
	Thu, 24 Oct 2024 05:11:01 -0700 (PDT)
Received: from [10.57.88.37] (unknown [10.57.88.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA3F93F71E;
	Thu, 24 Oct 2024 05:10:29 -0700 (PDT)
Message-ID: <cdcb663f-afb2-4bc4-a6b9-f7e7896c9a21@arm.com>
Date: Thu, 24 Oct 2024 13:10:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Petr Tesarik <ptesarik@suse.com>
Cc: Thomas Tai <thomas.tai@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241017142752.17f2c816@mordecai.tesarici.cz>
 <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
 <fed3b427-a600-4ce5-afef-4ccbfff64931@oracle.com>
 <df753b4a-0cf1-4544-b073-0ebf2bb71ef2@arm.com>
 <20241024134519.18ed4657@mordecai.tesarici.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241024134519.18ed4657@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/10/2024 12:45, Petr Tesarik wrote:
> On Thu, 24 Oct 2024 11:48:55 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> On 23/10/2024 22:00, Thomas Tai wrote:
>>>
>>> On 10/17/2024 8:32 AM, Ryan Roberts wrote:  
>>>> On 17/10/2024 13:27, Petr Tesarik wrote:  
>>>>> On Mon, 14 Oct 2024 11:55:11 +0100
>>>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>  
>>>>>> [...]
>>>>>> The series is arranged as follows:
>>>>>>
>>>>>>    - patch 1:       Add macros required for converting non-arch code to support
>>>>>>               boot-time page size selection
>>>>>>    - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>>>>>>               non-arch code  
>>>>> I have just tried to recompile the openSUSE kernel with these patches
>>>>> applied, and I'm running into this:
>>>>>
>>>>>    CC      arch/arm64/hyperv/hv_core.o
>>>>> In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
>>>>> ../include/linux/hyperv.h:158:5: error: variably modified ‘reserved2’ at file
>>>>> scope
>>>>>    u8 reserved2[PAGE_SIZE - 68];
>>>>>       ^~~~~~~~~
>>>>>
>>>>> It looks like one more place which needs a patch, right?  
>>>> As mentioned in the cover letter, so far I've only converted enough to get the
>>>> defconfig *image* building (i.e. no modules). If you are compiling a different
>>>> config or compiling the modules for defconfig, you will likely run into these
>>>> types of issues.  
>>>
>>> It would be nice if you could provide the defconfig you are using; I also ran
>>> into build issues when using the arch/arm64/configs/defconfig.  
>>
>> git clean -xdfq
>> make defconfig
>>
>> # Set CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> ./scripts/config --disable CONFIG_ARM64_4K_PAGES
>> ./scripts/config --disable CONFIG_ARM64_16K_PAGES
>> ./scripts/config --disable CONFIG_ARM64_64K_PAGES
>> ./scripts/config --disable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>> ./scripts/config --enable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
>>
>> # Set ARM64_VA_BITS_48
>> ./scripts/config --disable ARM64_VA_BITS_36
>> ./scripts/config --disable ARM64_VA_BITS_39
>> ./scripts/config --disable ARM64_VA_BITS_42
>> ./scripts/config --disable ARM64_VA_BITS_47
>> ./scripts/config --disable ARM64_VA_BITS_48
>> ./scripts/config --disable ARM64_VA_BITS_52
>> ./scripts/config --enable ARM64_VA_BITS_48
>>
>> # Optional: filesystems known to compile with boot-time page size
>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>> ./scripts/config --enable CONFIG_XFS_FS
>>
>> # Optional: trace stuff known to compile with boot-time page size
>> ./scripts/config --enable CONFIG_FTRACE
>> ./scripts/config --enable CONFIG_FUNCTION_TRACER
>> ./scripts/config --enable CONFIG_KPROBES
>> ./scripts/config --enable CONFIG_HIST_TRIGGERS
>> ./scripts/config --enable CONFIG_FTRACE_SYSCALLS
>>
>> # Optional: misc mm stuff known to compile with boot-time page size
>> ./scripts/config --enable CONFIG_PTDUMP_DEBUGFS
>> ./scripts/config --enable CONFIG_READ_ONLY_THP_FOR_FS
>> ./scripts/config --enable CONFIG_USERFAULTFD
>>
>> # Optional: mm debug stuff known compile with boot-time page size
>> ./scripts/config --enable CONFIG_DEBUG_VM
>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK_ENFORCED
>>
>> make olddefconfig
>> make -s -j`nproc` Image
>>
>> So I'm explicitly only building and booting the kernel image, not the modules.
>> The kernel image contains all the drivers needed to get a VM up and running
>> under QEMU/KVM.
> 
> FWIW with the attached patch I was also able to boot the kernel on
> Ampere Altra bare metal and using modules.

Nice!


Thanks for the below. That was already reported and I have a fix in my branch at
[1]. That also includes the btrfs patch you sent and the hyper-v patches, as
well as other fixups from review.

[1]
https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/boot-time-page-size-v2-wip

Thanks,
Ryan

> 
> Petr T
> 
> diff --git a/arch/arm64/mm/pgtable-geometry.c b/arch/arm64/mm/pgtable-geometry.c
> index ba50637f1e9d..4eb074b99654 100644
> --- a/arch/arm64/mm/pgtable-geometry.c
> +++ b/arch/arm64/mm/pgtable-geometry.c
> @@ -15,8 +15,14 @@
>   */
>  
>  int ptg_page_shift __read_mostly;
> +EXPORT_SYMBOL_GPL(ptg_page_shift);
> +
>  int ptg_pmd_shift __read_mostly;
> +EXPORT_SYMBOL_GPL(ptg_pmd_shift);
> +
>  int ptg_pud_shift __read_mostly;
> +EXPORT_SYMBOL_GPL(ptg_pud_shift);
> +
>  int ptg_p4d_shift __read_mostly;
>  int ptg_pgdir_shift __read_mostly;
>  int ptg_cont_pte_shift __read_mostly;


