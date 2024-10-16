Return-Path: <linux-kernel+bounces-367584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F075A9A041F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3436EB217C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19671D131D;
	Wed, 16 Oct 2024 08:23:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5461CEADB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067038; cv=none; b=e/dtPMCD1uIW/6YY2b1DdZuCI/6zoF94+FJ8X5+a2m1UnKLnoAC4PcztoaIyzmQewboFhPpI3I4J/JQ2F50tfi5HXzsZAZEbhEzM+DAhoY+ap0If8MAq6sNyPS/XP41Ie/irrOlmJd0evzqUJHO4LUGteMVjcPFldMep+vKHPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067038; c=relaxed/simple;
	bh=T3a57vO/EK3K8OANC2/bfVHOCqU5fTRim/qd0mPoAu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FteYPABKLFPckT2e4UvoS2iET5tKLwCfV3M1HOPx3wpUDLRFkmMHQ27Sgr7dMeR2ASGqcs5wtTGrYcxdi09216Yx7jI/9VGNAtdyeduu3NQD+q6Kyp6GchsRc+oW82tdTpMl9bwXLlXKo2RnqTAjLXcBZaz+I4ahq6lmlvm1kMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6AB4FEC;
	Wed, 16 Oct 2024 01:24:25 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACE163F71E;
	Wed, 16 Oct 2024 01:23:51 -0700 (PDT)
Message-ID: <0369a16f-9298-4a38-bfb9-ee7caa95b976@arm.com>
Date: Wed, 16 Oct 2024 09:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Michael Kelley <mhklinux@outlook.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <SN6PR02MB415751CB966BAC5EE1D4FF02D4452@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <SN6PR02MB415751CB966BAC5EE1D4FF02D4452@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 19:38, Michael Kelley wrote:
> From: Ryan Roberts <ryan.roberts@arm.com> Sent: Monday, October 14, 2024 3:55 AM
>>
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
>  
> [snip]
> 
> This is pretty cool. :-)  FWIW, I've built a kernel with this patch set, and
> have it running in a RHEL 8.7 guest on Hyper-V in the Azure public cloud.
> Ran with 4K, 16K, and 64K page sizes, and the basic smoke tests work.

That's great to hear - thanks for taking the time to test!

> 
> The Hyper-V specific code in the Linux kernel needed a few tweaks to
> deal with PAGE_SIZE and friends no longer being constant, but it's nothing
> significant. Getting the kernel built in the first place was a little harder
> because my .config file is fairly generic with a lot of device drivers and file
> system code that aren't really needed for Hyper-V guests. I had to
> weed out the ones that won't build. My RHEL 8.7 install uses LVM, so I> hacked the 'dm' code to make it compile and run.

Yeah, getting all this sorted is going to be the long tail. I feel I've had
enough positive response to this RFC that I should probably just get on and
start that work to get a real feel for how much of it there is going to be.

> 
> As this work moves forward, I can supply the necessary patches for
> the Hyper-V support.  Let me know if you want to include them in the
> main patch set.

Great! If you are happy to forward them to me, I'll include them in future
versions of the series (or more likely, serieses).

Thanks,
Ryan

> 
> I've added a couple of Microsoft's Linux people to this email's addressee
> list so they are aware of what's going on.
> 
> Michael Kelley


