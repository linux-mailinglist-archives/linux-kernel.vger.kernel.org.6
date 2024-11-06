Return-Path: <linux-kernel+bounces-398119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACACD9BE5C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEEE284E20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A681DF249;
	Wed,  6 Nov 2024 11:38:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F21DEFEB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893105; cv=none; b=phB/Jcdq1PhIez1im5zNOpAeHHi4og23u2Gvs7EwLjr6dV3IHq45TI3fXuwimYbsNljOe0pSVjmio1Y1ACdrW/StTcD2BoIC98q+tIQbODjUsxsxiQDH6LOTqKR9XtFQ6hAg8i9QQipjcVqxvVAzlnRUOL3IDpvK55Yd3m9UegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893105; c=relaxed/simple;
	bh=NGCZ25tpbvEKxszclDIE57z+HZeyD2o4IESPGMgEPbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxx7aGj3LfoMuo7xKNiwzRmBHivWrydAgj7YwuBn/3pPejSkPVCQzCCPIcrQGtvid7dvOpSf8QAmZo4SY1JseMzscJS11kuW5YC0HibwO95QTlHYELvdYdIOXyUOZ8IW3W8Xs0xmJwMajWbp/4sJ/SFUzcwdpwHelf1478EXX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11BCD1063;
	Wed,  6 Nov 2024 03:38:52 -0800 (PST)
Received: from [10.57.88.115] (unknown [10.57.88.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B8423F6A8;
	Wed,  6 Nov 2024 03:38:19 -0800 (PST)
Message-ID: <083d9e98-b6b8-4702-a700-24aea95cef9e@arm.com>
Date: Wed, 6 Nov 2024 11:37:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <ZyPxhF34JjT3Ky9K@arm.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZyPxhF34JjT3Ky9K@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 21:07, Catalin Marinas wrote:
> Hi Ryan,
> 
> On Mon, Oct 14, 2024 at 11:55:11AM +0100, Ryan Roberts wrote:
>> This RFC series implements support for boot-time page size selection within the
>> arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), but to date, page
>> size has been selected at compile-time, meaning the size is baked into a given
>> kernel image. As use of larger-than-4K page sizes become more prevalent this
>> starts to present a problem for distributions. Boot-time page size selection
>> enables the creation of a single kernel image, which can be told which page size
>> to use on the kernel command line.
> 
> That's great work, something I wasn't expecting to even build, let alone
> run ;). 

Cheers!

> I only looked briefly through the patches, there's probably room
> for optimisation of micro-benchmarks like fork(), maybe using something
> like runtime constants. 

Yes I suspect there is room for some optimization. Although note I already tried
using alternatives patching but for the fork() microbenchmark this performed
worse than the approach I ended up taking of just loading a global variable. I
think this was likely due to code layout changes due to all the extra
branches/nops - fork has been very sensitive to code layout changes in the past.

> The advantage for deployment and easy testing of
> different configurations is pretty clear (distros mainly, not sure how
> relevant it is for Android if apps can't move beyond 4K pages).
> 
> However, as a maintainer, my main concern is having to chase build
> failures in obscure drivers that have not been tested/developed on
> arm64. If people primarily test on x86, they wouldn't notice that
> PAGE_SIZE/PAGE_SHIFT are no longer constants. Not looking forward to
> trying to sort out allmodconfig builds every kernel release, especially
> if they turn up in subsystems I have no clue about (like most stuff
> outside arch/arm64).

Yes, I understand that concern.

> 
> So, first of all, I'd like to understand the overall maintainability
> impact better. I assume you tested mostly defconfig. If you run an
> allmodconfig build with make -k, how many build failures do you get with
> this patchset? Similarly for some distro configs.

I've roughly done:

    make alldefconfig &&
        ./scripts/config --enable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE &&
	make -s -j`nproc` -k &> allmodconfig.log

Then parsed the log for issues. Unfortunately the errors are very chatty and it
is difficult to perfectly extract stats.

If I search for r'(\S+\.[ch]):.*error:', that is optimistic because PAGE_SIZE
being non-const gets the ultimate blame for most things, but I'm interested in
the call sites. Number of affected files using this approach: 111.

If I just blindly search for all files, r'(\S+\.[ch]):', that is pessimistic
because when the issue is in a header, the full include chain is spat out.
Number of affected files using this approach: 1807.

If I just search for C files, r'(\S+\.[c]):', (all issues in headers terminate
in a C file) that is also pessimistic because the same single header issue is
reported for every C file it is included in. Number of affected files using this
approach: 1369.

In the end, I decided to go for r'(\S+\.[ch]):.*(error|note):', which is any
files described as having an error or being the callsite of the thing with the
error. I think this is likely most accurate from eyeballing the log:

|            |     C&H files | percentage of |
| directory  |      w/ error | all C&H files |
|------------|---------------|---------------|
| arch/arm64 |             7 |          1.3% |
| drivers    |           127 |          0.4% |
| fs         |            25 |          1.1% |
| include    |            27 |          0.4% |
| init       |             1 |          8.3% |
| kernel     |             7 |          1.3% |
| lib        |             1 |          0.2% |
| mm         |             6 |          3.2% |
| net        |             7 |          0.4% |
| security   |             2 |          0.8% |
| sound      |            21 |          0.8% |
|------------|---------------|---------------|
| TOTAL      |           231 |          0.4% |
|------------|---------------|---------------|

I'm not sure how best to evaluate if this is a large or small number though! For
comparison, the RFC modified 172 files.

> 
> Do we have any better way to detect this other than actual compilation
> on arm64? Can we hack something around COMPILE_TEST like redefine
> PAGE_SIZE (for modules only) to a variable so that we have a better
> chance of detecting build failures when modules are only tested on other
> architectures?

I can certainly look into this. But if the concern is that drivers are not being
compiled against arm64, what is the likelyhood of them being compiled against
COMPILE_TEST?

> 
> At the moment, I'm not entirely convinced of the benefits vs. long term
> maintainability. Even if we don't end up merging the dynamic PAGE_SIZE
> support, parts of this series are needed for supporting 128-bit ptes on
> arm64, hopefully dynamically as well.

Agreed.

Thanks,
Ryan

> 
> Thanks.
> 


