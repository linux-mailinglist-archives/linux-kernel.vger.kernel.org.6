Return-Path: <linux-kernel+bounces-374215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C59A66F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482D01C21CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E71E573E;
	Mon, 21 Oct 2024 11:47:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5078C76
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511250; cv=none; b=mxiLPGOioQ8tEonVunjev5/9iSHhjRoGOmEWAknslRZWGeum2HCTmIdmZ91N2dRf4OXkNpuOh0ykgcF5U826IYFP2hqiPaZfED5r4A9eLKmroPOls2ph0HGjRbhWh7HwxNjRkvSjapCoqJWS9UF++YvCUUmScwVthf/sSXR6B1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511250; c=relaxed/simple;
	bh=xaBuZygWljh0LEf8iFtseyr07Hc0MHq7asoOtTGbQoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+zP2Px5tCZlZ+M9eSVmb7VpNNm17a8POgXEDWkXMmen+xEDkYSDRPu4TtGUJJ1CS06FO2Hr8dvBYpBHvMkDFZewnSfh0/mVdxq0G3cKkbiAod7gJLwRttHzzXyDwr96Z2kJmGOWcerpV4dkJ8BGQ41DS0TVaKFfyU2wOe213UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52C9EDA7;
	Mon, 21 Oct 2024 04:47:56 -0700 (PDT)
Received: from [10.57.87.148] (unknown [10.57.87.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 824FD3F528;
	Mon, 21 Oct 2024 04:47:23 -0700 (PDT)
Message-ID: <059721e2-5dd8-47da-b7f8-d6423f912216@arm.com>
Date: Mon, 21 Oct 2024 12:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Petr Tesarik <ptesarik@suse.com>, Michael Kelley <mhklinux@outlook.com>
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
 <20241018145600.0473b1bd@mordecai.tesarici.cz>
 <20241018164105.0e5cc7a9@mordecai.tesarici.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241018164105.0e5cc7a9@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/10/2024 15:41, Petr Tesarik wrote:
> On Fri, 18 Oct 2024 14:56:00 +0200
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
>> On Thu, 17 Oct 2024 13:32:43 +0100
>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>>> On 17/10/2024 13:27, Petr Tesarik wrote:  
>>>> On Mon, 14 Oct 2024 11:55:11 +0100
>>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>     
>>>>> [...]
>>>>> The series is arranged as follows:
>>>>>
>>>>>   - patch 1:	   Add macros required for converting non-arch code to support
>>>>>   		   boot-time page size selection
>>>>>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>>>>>   		   non-arch code    
>>>>
>>>> I have just tried to recompile the openSUSE kernel with these patches
>>>> applied, and I'm running into this:
>>>>
>>>>   CC      arch/arm64/hyperv/hv_core.o
>>>> In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
>>>> ../include/linux/hyperv.h:158:5: error: variably modified ‘reserved2’ at file scope
>>>>   u8 reserved2[PAGE_SIZE - 68];
>>>>      ^~~~~~~~~
>>>>
>>>> It looks like one more place which needs a patch, right?    
>>>
>>> As mentioned in the cover letter, so far I've only converted enough to get the
>>> defconfig *image* building (i.e. no modules). If you are compiling a different
>>> config or compiling the modules for defconfig, you will likely run into these
>>> types of issues.
>>>
>>> That said, I do have some patches to fix Hyper-V, which Michael Kelley was kind
>>> enough to send me.
>>>
>>> I understand that Suse might be able to help with wider performance testing - if
>>> that's the reason you are trying to compile, you could send me your config and
>>> I'll start working on fixing up other drivers?  
>>
>> You're right, performance testing is my goal.
>>
>> Heh, the openSUSE master config is cranked up to max. ;-) That would be
>> a lot of work, and we don't need all those options for running our test
>> suite. Let me disable the conflicting options instead.
>> [...]
>> I'll see if I can do something about btrfs. Then I can try to boot the
>> kernel...
> 
> FWIW the kernel builds and _boots_ after applying this patch:

Amazing - thanks for doing this!

> 
>  fs/btrfs/compression.h  |    2 +-
>  fs/btrfs/defrag.c       |    2 +-
>  fs/btrfs/extent_io.h    |    2 +-
>  fs/btrfs/scrub.c        |    2 +-
>  include/linux/raid/pq.h |    4 ++--
>  lib/raid6/algos.c       |    2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -33,7 +33,7 @@ struct btrfs_bio;
>  /* Maximum length of compressed data stored on disk */
>  #define BTRFS_MAX_COMPRESSED		(SZ_128K)
>  #define BTRFS_MAX_COMPRESSED_PAGES	(BTRFS_MAX_COMPRESSED / PAGE_SIZE)
> -static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
> +static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE_MAX) == 0);
>  
>  /* Maximum size of data before compression */
>  #define BTRFS_MAX_UNCOMPRESSED		(SZ_128K)
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1144,7 +1144,7 @@ next:
>  }
>  
>  #define CLUSTER_SIZE	(SZ_256K)
> -static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
> +static_assert(IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE_MAX));
>  
>  /*
>   * Defrag one contiguous target range.
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -89,7 +89,7 @@ enum {
>  int __init extent_buffer_init_cachep(void);
>  void __cold extent_buffer_free_cachep(void);
>  
> -#define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
> +#define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE_MIN)

While this works, I'm not sure if you would want to have 2 separate macros; 1
for worst-case static allocation, and 1 for dynamic allocation and iterating. I
could imagine if you allocate PAGE_SIZE_MAX pages into the worst case number of
slots that would increase memory. I'm not familiar with the code so don't know
if this is a problem in practice. Certainly what you have done is much simpler
if acceptable.

>  struct extent_buffer {
>  	u64 start;
>  	u32 len;
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -100,7 +100,7 @@ enum scrub_stripe_flags {
>  	SCRUB_STRIPE_FLAG_NO_REPORT,
>  };
>  
> -#define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE)
> +#define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE_MIN)

Same comment.

Thanks,
Ryan

>  
>  /*
>   * Represent one contiguous range with a length of BTRFS_STRIPE_LEN.
> --- a/include/linux/raid/pq.h
> +++ b/include/linux/raid/pq.h
> @@ -12,7 +12,7 @@
>  
>  #include <linux/blkdev.h>
>  
> -extern const char raid6_empty_zero_page[PAGE_SIZE];
> +extern const char raid6_empty_zero_page[PAGE_SIZE_MAX];
>  
>  #else /* ! __KERNEL__ */
>  /* Used for testing in user space */
> @@ -39,7 +39,7 @@ typedef uint64_t u64;
>  #ifndef PAGE_SHIFT
>  # define PAGE_SHIFT 12
>  #endif
> -extern const char raid6_empty_zero_page[PAGE_SIZE];
> +extern const char raid6_empty_zero_page[PAGE_SIZE_MAX];
>  
>  #define __init
>  #define __exit
> --- a/lib/raid6/algos.c
> +++ b/lib/raid6/algos.c
> @@ -19,7 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/gfp.h>
>  /* In .bss so it's zeroed */
> -const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(256)));
> +const char raid6_empty_zero_page[PAGE_SIZE_MAX] __attribute__((aligned(256)));
>  EXPORT_SYMBOL(raid6_empty_zero_page);
>  #endif
>  
> 
> Petr T


