Return-Path: <linux-kernel+bounces-379738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA59AE2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8691C21A29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA71C878A;
	Thu, 24 Oct 2024 10:49:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1BC1C4A0E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766942; cv=none; b=Tb7+miEIplKeVXN8JN2QYRxtZ/v2P6nUhOJD5Td1w/zUlTc5107LWMcOKovcFjH2n4puYLrOCs5BB1cSObvbk5TI5RGXkLNnq5RguDCUUduTxDRQa0WJiWlKRpPJUQ9OmEl58k/DVY4dLJrkwoWitxKYxJGHC+FYasMaj/Fd1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766942; c=relaxed/simple;
	bh=0+fZRBWa7u2iPPXcIbS+QUBGTmgFe95YaEwumkuOt4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gy3TQ3dcRjMp3s7jWR3MyFUad8c3Viz6wHUDJkQblVSpl/CfL57q3Uxtk1YnROME0Uqv6qcebwyECI5oTum5b6x1JB/Vq9Gv920KkMUkth+NjuiAcZtfEJegu+/pPbJuvGPf1829z319niHR0c2NUyDAc0gDaEmp+JU5I7mZQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A7CE339;
	Thu, 24 Oct 2024 03:49:29 -0700 (PDT)
Received: from [10.57.88.37] (unknown [10.57.88.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 489843F71E;
	Thu, 24 Oct 2024 03:48:57 -0700 (PDT)
Message-ID: <df753b4a-0cf1-4544-b073-0ebf2bb71ef2@arm.com>
Date: Thu, 24 Oct 2024 11:48:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Thomas Tai <thomas.tai@oracle.com>, Petr Tesarik <ptesarik@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <fed3b427-a600-4ce5-afef-4ccbfff64931@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2024 22:00, Thomas Tai wrote:
> 
> On 10/17/2024 8:32 AM, Ryan Roberts wrote:
>> On 17/10/2024 13:27, Petr Tesarik wrote:
>>> On Mon, 14 Oct 2024 11:55:11 +0100
>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>>> [...]
>>>> The series is arranged as follows:
>>>>
>>>>    - patch 1:       Add macros required for converting non-arch code to support
>>>>               boot-time page size selection
>>>>    - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>>>>               non-arch code
>>> I have just tried to recompile the openSUSE kernel with these patches
>>> applied, and I'm running into this:
>>>
>>>    CC      arch/arm64/hyperv/hv_core.o
>>> In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
>>> ../include/linux/hyperv.h:158:5: error: variably modified ‘reserved2’ at file
>>> scope
>>>    u8 reserved2[PAGE_SIZE - 68];
>>>       ^~~~~~~~~
>>>
>>> It looks like one more place which needs a patch, right?
>> As mentioned in the cover letter, so far I've only converted enough to get the
>> defconfig *image* building (i.e. no modules). If you are compiling a different
>> config or compiling the modules for defconfig, you will likely run into these
>> types of issues.
> 
> It would be nice if you could provide the defconfig you are using; I also ran
> into build issues when using the arch/arm64/configs/defconfig.

git clean -xdfq
make defconfig

# Set CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
./scripts/config --disable CONFIG_ARM64_4K_PAGES
./scripts/config --disable CONFIG_ARM64_16K_PAGES
./scripts/config --disable CONFIG_ARM64_64K_PAGES
./scripts/config --disable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
./scripts/config --enable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE

# Set ARM64_VA_BITS_48
./scripts/config --disable ARM64_VA_BITS_36
./scripts/config --disable ARM64_VA_BITS_39
./scripts/config --disable ARM64_VA_BITS_42
./scripts/config --disable ARM64_VA_BITS_47
./scripts/config --disable ARM64_VA_BITS_48
./scripts/config --disable ARM64_VA_BITS_52
./scripts/config --enable ARM64_VA_BITS_48

# Optional: filesystems known to compile with boot-time page size
./scripts/config --enable CONFIG_SQUASHFS_LZ4
./scripts/config --enable CONFIG_SQUASHFS_LZO
./scripts/config --enable CONFIG_SQUASHFS_XZ
./scripts/config --enable CONFIG_SQUASHFS_ZSTD
./scripts/config --enable CONFIG_XFS_FS

# Optional: trace stuff known to compile with boot-time page size
./scripts/config --enable CONFIG_FTRACE
./scripts/config --enable CONFIG_FUNCTION_TRACER
./scripts/config --enable CONFIG_KPROBES
./scripts/config --enable CONFIG_HIST_TRIGGERS
./scripts/config --enable CONFIG_FTRACE_SYSCALLS

# Optional: misc mm stuff known to compile with boot-time page size
./scripts/config --enable CONFIG_PTDUMP_DEBUGFS
./scripts/config --enable CONFIG_READ_ONLY_THP_FOR_FS
./scripts/config --enable CONFIG_USERFAULTFD

# Optional: mm debug stuff known compile with boot-time page size
./scripts/config --enable CONFIG_DEBUG_VM
./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
./scripts/config --enable CONFIG_DEBUG_VM_RB
./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
./scripts/config --enable CONFIG_PAGE_TABLE_CHECK_ENFORCED

make olddefconfig
make -s -j`nproc` Image

So I'm explicitly only building and booting the kernel image, not the modules.
The kernel image contains all the drivers needed to get a VM up and running
under QEMU/KVM.

Thanks,
Ryan

>  
> Thank you,
> Thomas
> 
>>
>> That said, I do have some patches to fix Hyper-V, which Michael Kelley was kind
>> enough to send me.
>>
>> I understand that Suse might be able to help with wider performance testing - if
>> that's the reason you are trying to compile, you could send me your config and
>> I'll start working on fixing up other drivers?
>>
>> Thanks,
>> Ryan
>>
>>> Petr T
>>


