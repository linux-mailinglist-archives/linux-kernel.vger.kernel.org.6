Return-Path: <linux-kernel+bounces-372228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1A9A45E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5773A1F24E78
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04447204027;
	Fri, 18 Oct 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDJddxkP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEC17A58F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276073; cv=none; b=SXiXC7NKbQSdwCHcW4V5pmbJPnwgfthhBJRDqVfk4Y5zML63zvhLLKChvUl2hS/ABXBlEPXwPUpPhz7eiC9t03RIj9vZ5jHd03u7dljym9CKsUFBbKWaIlkzHaYJUXmXZtNbxDOQc09z22k0iYyAguRn5haSbeFbzaB3FJO0f7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276073; c=relaxed/simple;
	bh=tIA7OuzGUSMqLjhwKsD5DjfI+z1amvj5cR6WePjgp/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKirtR6Ki0JHSQimCivE/c0V+Wxhj9ApTTPLyiphm0tHxzTq5Es3EEHTW1OrsAHK12GHiblflyCGFjtOBJiEJ8SHef3f0FHhrxSmTY0XeggFot7oNA9Q4lPIVwUMa+uM+NLxQQPSK2yz+XlvT2TjIKgez3q39zPUjSLS17hSz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDJddxkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729276069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oWzHD+S+eYvC8Kofjs1m/2ZKY2D2ZZbJSw430+2E0y8=;
	b=PDJddxkPe/e66OxE/8IR8HyjLY7IUXDpH8Rvx/Lm7zbedwGaYgIV2XRVLstYUSZB5778dk
	G14+YrPeeZGvSD6P/LV3ZXg3erTRsL6T78Yj7d6YtRsIJetld6EdNIpG4W13+Pm9BP/wUs
	u/QqpCy5IDHS7LP8LjMa9+lhvgAdDcI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-2Vscs2-lNN6yCv56HjTiyw-1; Fri, 18 Oct 2024 14:27:48 -0400
X-MC-Unique: 2Vscs2-lNN6yCv56HjTiyw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d49887a2cso1406972f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729276066; x=1729880866;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWzHD+S+eYvC8Kofjs1m/2ZKY2D2ZZbJSw430+2E0y8=;
        b=wGHNczmLACoqIDWeWmkrp0F0HVeqYbsDOpYv2PyxA6xZb61itAUC5WwgsMmVoufhzU
         Sl85H7CkjghbwxBkTahN9YlSBJCGNsGl5ZYkh5kfYdDFnvEXGarHG7JUY1kv3ZjbHKkR
         CcAqzpZg4hsj/5pHwyd4CV8xH3iN9E8vCVZ88OgXzTNK3OKR+wHrPRvrhH5pVhheueKE
         vPx9qVq2W/qREmMXPObkCMk3jL8SlvG1bW4qQDrciJDaRwZC9vHBZY9EFBpbWUpmM4dO
         FNQjx1G3PgaVv49nGQpJBj92ZBmtFc8RkO4IEnoLtr1wxFaynFM3nNpZrH9ahvOFrJlp
         q7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXTyhJp3lU1YoyNUnqpfZCUKVmOYEdHAnMhXReot9+qxdtaWXSm9dCOcdIwtYXYmvQ9vpAqaERdBazg0Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKDiAEZHsEop7Sfzc4YwglXyWMb/qStuHH9bFyvr7k2LA2EKf
	5ZfYI5DYXkiHekjC/TA4oVB7QMz7XIxizepMvBcz57JvxviAZHchqxvWeiUlXKwuY5bvhNpPMvg
	i9OBrYb4jAHxo3hScd1fR+rfFSya+4vhpUelbM7xnfHFqPmM/RzDTfedKCduWnw==
X-Received: by 2002:adf:fb89:0:b0:374:c613:7c58 with SMTP id ffacd0b85a97d-37d93e4ca10mr5080259f8f.29.1729276065894;
        Fri, 18 Oct 2024 11:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHb3dR9f7SV3fNKSqN5YcAHOn6dEthNGMVZwwETnJCZVl3+8v4Do+MkzJsUGMSlhHhMlMC1g==
X-Received: by 2002:adf:fb89:0:b0:374:c613:7c58 with SMTP id ffacd0b85a97d-37d93e4ca10mr5080245f8f.29.1729276065313;
        Fri, 18 Oct 2024 11:27:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2400:68a3:92e0:906f:b69d? (p200300cbc707240068a392e0906fb69d.dip0.t-ipconnect.de. [2003:cb:c707:2400:68a3:92e0:906f:b69d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dbe78asm30375845e9.7.2024.10.18.11.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 11:27:44 -0700 (PDT)
Message-ID: <915e2f0c-f603-4617-8429-da4dacc862c4@redhat.com>
Date: Fri, 18 Oct 2024 20:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
To: Joseph Salisbury <joseph.salisbury@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <f5baa653-fec1-4f6e-91b0-ed8368d3c725@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f5baa653-fec1-4f6e-91b0-ed8368d3c725@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.10.24 20:15, Joseph Salisbury wrote:
> 
> 
> 
> On 10/14/24 06:55, Ryan Roberts wrote:
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
>>
>> Status
>> ======
>>
>> When CONFIG_ARM64_BOOT_TIME_PAGE_SIZE is selected, I've only implemented enough
>> to compile the kernel image itself with defconfig (and a few other bits and
>> pieces). This is enough to build a kernel that can boot under QEMU or FVP. I'll
>> happily do the rest of the work to enable all the extra drivers, but wanted to
>> get feedback on the shape of this effort first. If anyone wants to do any
>> testing, and has a must-have config, let me know and I'll prioritize enabling it
>> first.
>>
>> The series is arranged as follows:
>>
>>     - patch 1:	   Add macros required for converting non-arch code to support
>>     		   boot-time page size selection
>>     - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>>     		   non-arch code
>>     - patches 37-38: Some arm64 tidy ups
>>     - patch 39:	   Add macros required for converting arm64 code to support
>>     		   boot-time page size selection
>>     - patches 40-56: arm64 changes to support boot-time page size selection
>>     - patch 57:	   Add arm64 Kconfig option to enable boot-time page size
>>     		   selection
>>
>> Ideally, I'd like to get the basics merged (something like this series), then
>> incrementally improve it over a handful of kernel releases until we can
>> demonstrate that we have feature parity with the compile-time build and no
>> performance blockers. Once at that point, ideally the compile-time build options
>> would be removed and the code could be cleaned up further.
>>
>> One of the bigger peices that I'd propose to add as a follow up, is to make
>> va-size boot-time selectable too. That will greatly simplify LPA2 fallback
>> handling.
>>
>> Assuming people are ammenable to the rough shape, how would I go about getting
>> the non-arch changes merged? Since they cover many subsystems, will each piece
>> need to go independently to each relevant maintainer or could it all be merged
>> together through the arm64 tree?
>>
>> Image Size
>> ==========
>>
>> The below shows the size of a defconfig (+ xfs, squashfs, ftrace, kprobes)
>> kernel image on disk for base (before any changes applied), compile (with
>> changes, configured for compile-time page size) and boot (with changes,
>> configured for boot-time page size).
>>
>> You can see the that compile-16k and 64k configs are actually slightly smaller
>> than the baselines; that's due to optimizing some buffer sizes which didn't need
>> to depend on page size during the series. The boot-time image is ~1% bigger than
>> the 64k compile-time image. I believe there is scope to improve this to make it
>> equal to compile-64k if required:
>>
>> | config      | size/KB | diff/KB |  diff/% |
>> |-------------|---------|---------|---------|
>> | base-4k     |   54895 |       0 |    0.0% |
>> | base-16k    |   55161 |     266 |    0.5% |
>> | base-64k    |   56775 |    1880 |    3.4% |
>> | compile-4k  |   54895 |       0 |    0.0% |
>> | compile-16k |   55097 |     202 |    0.4% |
>> | compile-64k |   56391 |    1496 |    2.7% |
>> | boot-4K     |   57045 |    2150 |    3.9% |
>>
>> And below shows the size of the image in memory at run-time, separated for text
>> and data costs. The boot image has ~1% text cost; most likely due to the fact
>> that PAGE_SIZE and friends are not compile-time constants so need instructions
>> to load the values and do arithmetic. I believe we could eventually get the data
>> cost to match the cost for the compile image for the chosen page size by freeing
>> the ends of the static buffers not needed for the selected page size:
>>
>> |             |    text |    text |    text |    data |    data |    data |
>> | config      | size/KB | diff/KB |  diff/% | size/KB | diff/KB |  diff/% |
>> |-------------|---------|---------|---------|---------|---------|---------|
>> | base-4k     |   20561 |       0 |    0.0% |   14314 |       0 |    0.0% |
>> | base-16k    |   20439 |    -122 |   -0.6% |   14625 |     311 |    2.2% |
>> | base-64k    |   20435 |    -126 |   -0.6% |   15673 |    1359 |    9.5% |
>> | compile-4k  |   20565 |       4 |    0.0% |   14315 |       1 |    0.0% |
>> | compile-16k |   20443 |    -118 |   -0.6% |   14517 |     204 |    1.4% |
>> | compile-64k |   20439 |    -122 |   -0.6% |   15134 |     820 |    5.7% |
>> | boot-4K     |   20811 |     250 |    1.2% |   15287 |     973 |    6.8% |
>>
>> Functional Testing
>> ==================
>>
>> I've build-tested defconfig for all arches supported by tuxmake (which is most)
>> without issue.
>>
>> I've boot-tested arm64 with CONFIG_ARM64_BOOT_TIME_PAGE_SIZE for all page sizes
>> and a few va-sizes, and additionally have run all the mm-selftests, with no
>> regressions observed vs the equivalent compile-time page size build (although
>> the mm-selftests have a few existing failures when run against 16K and 64K
>> kernels - those should really be investigated and fixed independently).
>>
>> Test coverage is lacking for many of the drivers that I've touched, but in many
>> cases, I'm hoping the changes are simple enough that review might suffice?
>>
>> Performance Testing
>> ===================
>>
>> I've run some limited performance benchmarks:
>>
>> First, a real-world benchmark that causes a lot of page table manipulation (and
>> therefore we would expect to see regression here if we are going to see it
>> anywhere); kernel compilation. It barely registers a change. Values are times,
>> so smaller is better. All relative to base-4k:
>>
>> |             |    kern |    kern |    user |    user |    real |    real |
>> | config      |    mean |   stdev |    mean |   stdev |    mean |   stdev |
>> |-------------|---------|---------|---------|---------|---------|---------|
>> | base-4k     |    0.0% |    1.1% |    0.0% |    0.3% |    0.0% |    0.3% |
>> | compile-4k  |   -0.2% |    1.1% |   -0.2% |    0.3% |   -0.1% |    0.3% |
>> | boot-4k     |    0.1% |    1.0% |   -0.3% |    0.2% |   -0.2% |    0.2% |
>>
>> The Speedometer JavaScript benchmark also shows no change. Values are runs per
>> min, so bigger is better. All relative to base-4k:
>>
>> | config      |    mean |   stdev |
>> |-------------|---------|---------|
>> | base-4k     |    0.0% |    0.8% |
>> | compile-4k  |    0.4% |    0.8% |
>> | boot-4k     |    0.0% |    0.9% |
>>
>> Finally, I've run some microbenchmarks known to stress page table manipulations
>> (originally from David Hildenbrand). The fork test maps/allocs 1G of anon
>> memory, then measures the cost of fork(). The munmap test maps/allocs 1G of anon
>> memory then measures the cost of munmap()ing it. The fork test is known to be
>> extremely sensitive to any changes that cause instructions to be aligned
>> differently in cachelines. When using this test for other changes, I've seen
>> double digit regressions for the slightest thing, so 12% regression on this test
>> is actually fairly good. This likely represents the extreme worst case for
>> regressions that will be observed across other microbenchmarks (famous last
>> words). Values are times, so smaller is better. All relative to base-4k:
>>
>> |             |    fork |    fork |  munmap |  munmap |
>> | config      |    mean |   stdev |   stdev |   stdev |
>> |-------------|---------|---------|---------|---------|
>> | base-4k     |    0.0% |    1.3% |    0.0% |    0.3% |
>> | compile-4k  |    0.1% |    1.3% |   -0.9% |    0.1% |
>> | boot-4k     |   12.8% |    1.2% |    3.8% |    1.0% |
>>
>> NOTE: The series applies on top of v6.11.
>>
>> Thanks,
>> Ryan
>>
>>
>> Ryan Roberts (57):
>>     mm: Add macros ahead of supporting boot-time page size selection
>>     vmlinux: Align to PAGE_SIZE_MAX
>>     mm/memcontrol: Fix seq_buf size to save memory when PAGE_SIZE is large
>>     mm/page_alloc: Make page_frag_cache boot-time page size compatible
>>     mm: Avoid split pmd ptl if pmd level is run-time folded
>>     mm: Remove PAGE_SIZE compile-time constant assumption
>>     fs: Introduce MAX_BUF_PER_PAGE_SIZE_MAX for array sizing
>>     fs: Remove PAGE_SIZE compile-time constant assumption
>>     fs/nfs: Remove PAGE_SIZE compile-time constant assumption
>>     fs/ext4: Remove PAGE_SIZE compile-time constant assumption
>>     fork: Permit boot-time THREAD_SIZE determination
>>     cgroup: Remove PAGE_SIZE compile-time constant assumption
>>     bpf: Remove PAGE_SIZE compile-time constant assumption
>>     pm/hibernate: Remove PAGE_SIZE compile-time constant assumption
>>     stackdepot: Remove PAGE_SIZE compile-time constant assumption
>>     perf: Remove PAGE_SIZE compile-time constant assumption
>>     kvm: Remove PAGE_SIZE compile-time constant assumption
>>     trace: Remove PAGE_SIZE compile-time constant assumption
>>     crash: Remove PAGE_SIZE compile-time constant assumption
>>     crypto: Remove PAGE_SIZE compile-time constant assumption
>>     sunrpc: Remove PAGE_SIZE compile-time constant assumption
>>     sound: Remove PAGE_SIZE compile-time constant assumption
>>     net: Remove PAGE_SIZE compile-time constant assumption
>>     net: fec: Remove PAGE_SIZE compile-time constant assumption
>>     net: marvell: Remove PAGE_SIZE compile-time constant assumption
>>     net: hns3: Remove PAGE_SIZE compile-time constant assumption
>>     net: e1000: Remove PAGE_SIZE compile-time constant assumption
>>     net: igbvf: Remove PAGE_SIZE compile-time constant assumption
>>     net: igb: Remove PAGE_SIZE compile-time constant assumption
>>     drivers/base: Remove PAGE_SIZE compile-time constant assumption
>>     edac: Remove PAGE_SIZE compile-time constant assumption
>>     optee: Remove PAGE_SIZE compile-time constant assumption
>>     random: Remove PAGE_SIZE compile-time constant assumption
>>     sata_sil24: Remove PAGE_SIZE compile-time constant assumption
>>     virtio: Remove PAGE_SIZE compile-time constant assumption
>>     xen: Remove PAGE_SIZE compile-time constant assumption
>>     arm64: Fix macros to work in C code in addition to the linker script
>>     arm64: Track early pgtable allocation limit
>>     arm64: Introduce macros required for boot-time page selection
>>     arm64: Refactor early pgtable size calculation macros
>>     arm64: Pass desired page size on command line
>>     arm64: Divorce early init from PAGE_SIZE
>>     arm64: Clean up simple cases of CONFIG_ARM64_*K_PAGES
>>     arm64: Align sections to PAGE_SIZE_MAX
>>     arm64: Rework trampoline rodata mapping
>>     arm64: Generalize fixmap for boot-time page size
>>     arm64: Statically allocate and align for worst-case page size
>>     arm64: Convert switch to if for non-const comparison values
>>     arm64: Convert BUILD_BUG_ON to VM_BUG_ON
>>     arm64: Remove PAGE_SZ asm-offset
>>     arm64: Introduce cpu features for page sizes
>>     arm64: Remove PAGE_SIZE from assembly code
>>     arm64: Runtime-fold pmd level
>>     arm64: Support runtime folding in idmap_kpti_install_ng_mappings
>>     arm64: TRAMP_VALIAS is no longer compile-time constant
>>     arm64: Determine THREAD_SIZE at boot-time
>>     arm64: Enable boot-time page size selection
>>
>>    arch/alpha/include/asm/page.h                 |   1 +
>>    arch/arc/include/asm/page.h                   |   1 +
>>    arch/arm/include/asm/page.h                   |   1 +
>>    arch/arm64/Kconfig                            |  26 ++-
>>    arch/arm64/include/asm/assembler.h            |  78 ++++++-
>>    arch/arm64/include/asm/cpufeature.h           |  44 +++-
>>    arch/arm64/include/asm/efi.h                  |   2 +-
>>    arch/arm64/include/asm/fixmap.h               |  28 ++-
>>    arch/arm64/include/asm/kernel-pgtable.h       | 150 +++++++++----
>>    arch/arm64/include/asm/kvm_arm.h              |  21 +-
>>    arch/arm64/include/asm/kvm_hyp.h              |  11 +
>>    arch/arm64/include/asm/kvm_pgtable.h          |   6 +-
>>    arch/arm64/include/asm/memory.h               |  62 ++++--
>>    arch/arm64/include/asm/page-def.h             |   3 +-
>>    arch/arm64/include/asm/pgalloc.h              |  16 +-
>>    arch/arm64/include/asm/pgtable-geometry.h     |  46 ++++
>>    arch/arm64/include/asm/pgtable-hwdef.h        |  28 ++-
>>    arch/arm64/include/asm/pgtable-prot.h         |   2 +-
>>    arch/arm64/include/asm/pgtable.h              | 133 +++++++++---
>>    arch/arm64/include/asm/processor.h            |  10 +-
>>    arch/arm64/include/asm/sections.h             |   1 +
>>    arch/arm64/include/asm/smp.h                  |   1 +
>>    arch/arm64/include/asm/sparsemem.h            |  15 +-
>>    arch/arm64/include/asm/sysreg.h               |  54 +++--
>>    arch/arm64/include/asm/tlb.h                  |   3 +
>>    arch/arm64/kernel/asm-offsets.c               |   4 +-
>>    arch/arm64/kernel/cpufeature.c                |  93 ++++++--
>>    arch/arm64/kernel/efi.c                       |   2 +-
>>    arch/arm64/kernel/entry.S                     |  60 +++++-
>>    arch/arm64/kernel/head.S                      |  46 +++-
>>    arch/arm64/kernel/hibernate-asm.S             |   6 +-
>>    arch/arm64/kernel/image-vars.h                |  14 ++
>>    arch/arm64/kernel/image.h                     |   4 +
>>    arch/arm64/kernel/pi/idreg-override.c         |  68 +++++-
>>    arch/arm64/kernel/pi/map_kernel.c             | 165 ++++++++++----
>>    arch/arm64/kernel/pi/map_range.c              | 201 ++++++++++++++++--
>>    arch/arm64/kernel/pi/pi.h                     |  63 +++++-
>>    arch/arm64/kernel/relocate_kernel.S           |  10 +-
>>    arch/arm64/kernel/vdso-wrap.S                 |   4 +-
>>    arch/arm64/kernel/vdso.c                      |   7 +-
>>    arch/arm64/kernel/vdso/vdso.lds.S             |   4 +-
>>    arch/arm64/kernel/vdso32-wrap.S               |   4 +-
>>    arch/arm64/kernel/vdso32/vdso.lds.S           |   4 +-
>>    arch/arm64/kernel/vmlinux.lds.S               |  48 +++--
>>    arch/arm64/kvm/arm.c                          |  10 +
>>    arch/arm64/kvm/hyp/nvhe/Makefile              |   1 +
>>    arch/arm64/kvm/hyp/nvhe/host.S                |  10 +-
>>    arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   4 +-
>>    arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c    |  16 ++
>>    arch/arm64/kvm/mmu.c                          |  39 ++--
>>    arch/arm64/lib/clear_page.S                   |   7 +-
>>    arch/arm64/lib/copy_page.S                    |  33 ++-
>>    arch/arm64/lib/mte.S                          |  27 ++-
>>    arch/arm64/mm/Makefile                        |   1 +
>>    arch/arm64/mm/fixmap.c                        |  38 ++--
>>    arch/arm64/mm/hugetlbpage.c                   |  40 +---
>>    arch/arm64/mm/init.c                          |  26 +--
>>    arch/arm64/mm/kasan_init.c                    |   8 +-
>>    arch/arm64/mm/mmu.c                           |  53 +++--
>>    arch/arm64/mm/pgd.c                           |  12 +-
>>    arch/arm64/mm/pgtable-geometry.c              |  24 +++
>>    arch/arm64/mm/proc.S                          | 128 ++++++++---
>>    arch/arm64/mm/ptdump.c                        |   3 +-
>>    arch/arm64/tools/cpucaps                      |   3 +
>>    arch/csky/include/asm/page.h                  |   3 +
>>    arch/hexagon/include/asm/page.h               |   2 +
>>    arch/loongarch/include/asm/page.h             |   2 +
>>    arch/m68k/include/asm/page.h                  |   1 +
>>    arch/microblaze/include/asm/page.h            |   1 +
>>    arch/mips/include/asm/page.h                  |   1 +
>>    arch/nios2/include/asm/page.h                 |   2 +
>>    arch/openrisc/include/asm/page.h              |   1 +
>>    arch/parisc/include/asm/page.h                |   1 +
>>    arch/powerpc/include/asm/page.h               |   2 +
>>    arch/riscv/include/asm/page.h                 |   1 +
>>    arch/s390/include/asm/page.h                  |   1 +
>>    arch/sh/include/asm/page.h                    |   1 +
>>    arch/sparc/include/asm/page.h                 |   3 +
>>    arch/um/include/asm/page.h                    |   2 +
>>    arch/x86/include/asm/page_types.h             |   2 +
>>    arch/xtensa/include/asm/page.h                |   1 +
>>    crypto/lskcipher.c                            |   4 +-
>>    drivers/ata/sata_sil24.c                      |  46 ++--
>>    drivers/base/node.c                           |   6 +-
>>    drivers/base/topology.c                       |  32 +--
>>    drivers/block/virtio_blk.c                    |   2 +-
>>    drivers/char/random.c                         |   4 +-
>>    drivers/edac/edac_mc.h                        |  13 +-
>>    drivers/firmware/efi/libstub/arm64.c          |   3 +-
>>    drivers/irqchip/irq-gic-v3-its.c              |   2 +-
>>    drivers/mtd/mtdswap.c                         |   4 +-
>>    drivers/net/ethernet/freescale/fec.h          |   3 +-
>>    drivers/net/ethernet/freescale/fec_main.c     |   5 +-
>>    .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   4 +-
>>    drivers/net/ethernet/intel/e1000/e1000_main.c |   6 +-
>>    drivers/net/ethernet/intel/igb/igb.h          |  25 +--
>>    drivers/net/ethernet/intel/igb/igb_main.c     | 149 +++++++------
>>    drivers/net/ethernet/intel/igbvf/netdev.c     |   6 +-
>>    drivers/net/ethernet/marvell/mvneta.c         |   9 +-
>>    drivers/net/ethernet/marvell/sky2.h           |   2 +-
>>    drivers/tee/optee/call.c                      |   7 +-
>>    drivers/tee/optee/smc_abi.c                   |   2 +-
>>    drivers/virtio/virtio_balloon.c               |  10 +-
>>    drivers/xen/balloon.c                         |  11 +-
>>    drivers/xen/biomerge.c                        |  12 +-
>>    drivers/xen/privcmd.c                         |   2 +-
>>    drivers/xen/xenbus/xenbus_client.c            |   5 +-
>>    drivers/xen/xlate_mmu.c                       |   6 +-
>>    fs/binfmt_elf.c                               |  11 +-
>>    fs/buffer.c                                   |   2 +-
>>    fs/coredump.c                                 |   8 +-
>>    fs/ext4/ext4.h                                |  36 ++--
>>    fs/ext4/move_extent.c                         |   2 +-
>>    fs/ext4/readpage.c                            |   2 +-
>>    fs/fat/dir.c                                  |   4 +-
>>    fs/fat/fatent.c                               |   4 +-
>>    fs/nfs/nfs42proc.c                            |   2 +-
>>    fs/nfs/nfs42xattr.c                           |   2 +-
>>    fs/nfs/nfs4proc.c                             |   2 +-
>>    include/asm-generic/pgtable-geometry.h        |  71 +++++++
>>    include/asm-generic/vmlinux.lds.h             |  38 ++--
>>    include/linux/buffer_head.h                   |   1 +
>>    include/linux/cpumask.h                       |   5 +
>>    include/linux/linkage.h                       |   4 +-
>>    include/linux/mm.h                            |  17 +-
>>    include/linux/mm_types.h                      |  15 +-
>>    include/linux/mm_types_task.h                 |   2 +-
>>    include/linux/mmzone.h                        |   3 +-
>>    include/linux/netlink.h                       |   6 +-
>>    include/linux/percpu-defs.h                   |   4 +-
>>    include/linux/perf_event.h                    |   2 +-
>>    include/linux/sched.h                         |   4 +-
>>    include/linux/slab.h                          |   7 +-
>>    include/linux/stackdepot.h                    |   6 +-
>>    include/linux/sunrpc/svc.h                    |   8 +-
>>    include/linux/sunrpc/svc_rdma.h               |   4 +-
>>    include/linux/sunrpc/svcsock.h                |   2 +-
>>    include/linux/swap.h                          |  17 +-
>>    include/linux/swapops.h                       |   6 +-
>>    include/linux/thread_info.h                   |  10 +-
>>    include/xen/page.h                            |   2 +
>>    init/main.c                                   |   7 +-
>>    kernel/bpf/core.c                             |   9 +-
>>    kernel/bpf/ringbuf.c                          |  54 ++---
>>    kernel/cgroup/cgroup.c                        |   8 +-
>>    kernel/crash_core.c                           |   2 +-
>>    kernel/events/core.c                          |   2 +-
>>    kernel/fork.c                                 |  71 +++----
>>    kernel/power/power.h                          |   2 +-
>>    kernel/power/snapshot.c                       |   2 +-
>>    kernel/power/swap.c                           | 129 +++++++++--
>>    kernel/trace/fgraph.c                         |   2 +-
>>    kernel/trace/trace.c                          |   2 +-
>>    lib/stackdepot.c                              |   6 +-
>>    mm/kasan/report.c                             |   3 +-
>>    mm/memcontrol.c                               |  11 +-
>>    mm/memory.c                                   |   4 +-
>>    mm/mmap.c                                     |   2 +-
>>    mm/page-writeback.c                           |   2 +-
>>    mm/page_alloc.c                               |  31 +--
>>    mm/slub.c                                     |   2 +-
>>    mm/sparse.c                                   |   2 +-
>>    mm/swapfile.c                                 |   2 +-
>>    mm/vmalloc.c                                  |   7 +-
>>    net/9p/trans_virtio.c                         |   4 +-
>>    net/core/hotdata.c                            |   4 +-
>>    net/core/skbuff.c                             |   4 +-
>>    net/core/sysctl_net_core.c                    |   2 +-
>>    net/sunrpc/cache.c                            |   3 +-
>>    net/unix/af_unix.c                            |   2 +-
>>    sound/soc/soc-utils.c                         |   4 +-
>>    virt/kvm/kvm_main.c                           |   2 +-
>>    172 files changed, 2185 insertions(+), 951 deletions(-)
>>    create mode 100644 arch/arm64/include/asm/pgtable-geometry.h
>>    create mode 100644 arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>>    create mode 100644 arch/arm64/mm/pgtable-geometry.c
>>    create mode 100644 include/asm-generic/pgtable-geometry.h
>>
>> --
>> 2.43.0
>>
>>
> 
> Hi Ryan,
> 
> First off, this is excellent work!  Your cover page was very detailed
> and made the patch set easier to understand.
> 
> Some questions/comments:
> 
> Once a kernel is booted with a certain page size, could there be issues
> if it is booted later with a different page size?  How about if this is
> done frequently?

I think that is the reason why you are only given the option in RHEL to 
select the kernel (4K vs. 64K) to use at install time.

Software can easily use a different data format for persistance based on 
the base page size. I would suspect DBs might be the usual suspects.

One example is swap space I think, where the base page size used when 
formatting the device is used, and it cannot be used with a different 
page size unless reformatting it.

So ... one has to be a bit careful ...

-- 
Cheers,

David / dhildenb


