Return-Path: <linux-kernel+bounces-369763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD39A2249
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F21D281FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F311DD533;
	Thu, 17 Oct 2024 12:32:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D21D45F2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168370; cv=none; b=p4rB951JcbS2HcI8TW8V8avVbwQVwHI42r7Ig532YWl6wiVMfQ5DsF2pVs+87tRVX+LdDreWMcb4L/CYULsYjvsnPCnmkS1xU3YVdVmksVDmP9Yw5idUWvcrumR7WuhszDOxPpcLprgXXOElOER1T8gesx6mg9jeNP/76JDSenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168370; c=relaxed/simple;
	bh=jD5nb/E+c0k+5H9SP0IURWphgAE7LYgPCcFQ2X8jmQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfLClslajpTUxXZCZvqgss3mBGGEXK9BO4NCrT+A/BHSVwnlhG4tNN2nupgHlDEbLpJg5Xr872K+VV9l33FguxTd/dXiVREsM3j5YpnW167yk+Bm7uJxwEgwZTn6VqO7NCAz2fiO6GrxNReSNqss6pyFvuMUxOr8SgQH+fYRAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04472FEC;
	Thu, 17 Oct 2024 05:33:16 -0700 (PDT)
Received: from [10.1.34.186] (XHFQ2J9959.cambridge.arm.com [10.1.34.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599A83F71E;
	Thu, 17 Oct 2024 05:32:44 -0700 (PDT)
Message-ID: <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
Date: Thu, 17 Oct 2024 13:32:43 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241017142752.17f2c816@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/10/2024 13:27, Petr Tesarik wrote:
> On Mon, 14 Oct 2024 11:55:11 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> [...]
>> The series is arranged as follows:
>>
>>   - patch 1:	   Add macros required for converting non-arch code to support
>>   		   boot-time page size selection
>>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>>   		   non-arch code
> 
> I have just tried to recompile the openSUSE kernel with these patches
> applied, and I'm running into this:
> 
>   CC      arch/arm64/hyperv/hv_core.o
> In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
> ../include/linux/hyperv.h:158:5: error: variably modified ‘reserved2’ at file scope
>   u8 reserved2[PAGE_SIZE - 68];
>      ^~~~~~~~~
> 
> It looks like one more place which needs a patch, right?

As mentioned in the cover letter, so far I've only converted enough to get the
defconfig *image* building (i.e. no modules). If you are compiling a different
config or compiling the modules for defconfig, you will likely run into these
types of issues.

That said, I do have some patches to fix Hyper-V, which Michael Kelley was kind
enough to send me.

I understand that Suse might be able to help with wider performance testing - if
that's the reason you are trying to compile, you could send me your config and
I'll start working on fixing up other drivers?

Thanks,
Ryan

> 
> Petr T


