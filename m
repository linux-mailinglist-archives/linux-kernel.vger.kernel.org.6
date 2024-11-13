Return-Path: <linux-kernel+bounces-407610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB679C6FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88B4289973
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2E1DF248;
	Wed, 13 Nov 2024 12:56:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD46088F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502592; cv=none; b=ovhIFVy9LS/sIWzF9Zzs/NvEhFb8m9rI3KhklzK0/0rFk2ddAt9v712DkffDhNsPWj7pUeydzpoWTO2vmk7wQPkjfZb9aVr6zXoulpKYpEEcDltrkthAX/sULrKi8Ub6d+OtpvOkKv4mKn/aP7HanspDYxOglPRfKvcFR71+RIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502592; c=relaxed/simple;
	bh=5W3XVCZi0AeqVKhPv2nTx1LkaCHpXgsHjbigdUIU3Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGyZPVMFrySpEVDGLxGHYVN8j8MSU+5nZ2hEMv60jZWHGKWgQC86UB8/31H0PP/n5PTIwr0jKa/fZzMic+Wsk3jS3PMxtgtP9UUgNiW8OSFC0n+quvJz+QhK/pei7I5qTsaq2keRymYoG4yDz9pRhduN4dBP0r+I8OFSjZACGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738261655;
	Wed, 13 Nov 2024 04:56:58 -0800 (PST)
Received: from [10.1.38.177] (XHFQ2J9959.cambridge.arm.com [10.1.38.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D103C3F66E;
	Wed, 13 Nov 2024 04:56:25 -0800 (PST)
Message-ID: <ed43da27-30bf-4f9d-a952-3d1fe80c5302@arm.com>
Date: Wed, 13 Nov 2024 12:56:24 +0000
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
 <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
 <20241111131442.51738a30@mordecai.tesarici.cz>
 <046ce0ae-b4d5-4dbd-ad9d-eb8de1bba1b8@arm.com>
 <20241112104544.574dd733@mordecai.tesarici.cz>
 <5a041e51-a43b-4878-ab68-4757d3141889@arm.com>
 <20241112115039.41993e4b@mordecai.tesarici.cz>
 <20241113134038.5843ab73@mordecai.tesarici.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241113134038.5843ab73@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 12:40, Petr Tesarik wrote:
> On Tue, 12 Nov 2024 11:50:39 +0100
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
>> On Tue, 12 Nov 2024 10:19:34 +0000
>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>>> On 12/11/2024 09:45, Petr Tesarik wrote:  
>>>> On Mon, 11 Nov 2024 12:25:35 +0000
>>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>     
>>>>> Hi Petr,
>>>>>
>>>>> On 11/11/2024 12:14, Petr Tesarik wrote:    
>>>>>> Hi Ryan,
>>>>>>
>>>>>> On Thu, 17 Oct 2024 13:32:43 +0100
>>>>>> Ryan Roberts <ryan.roberts@arm.com> wrote:    
>>>>> [...]    
>>>>>> Third, a few micro-benchmarks saw a significant regression.
>>>>>>
>>>>>> Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
>>>>>> slower with variable page size. I don't know why, but I'm looking into
>>>>>> it. The system() library call was also about 18% slower, but that might
>>>>>> be related.      
>>>>>
>>>>> OK, ouch. I think there are some things we can try to optimize the
>>>>> implementation further. But I'll wait for your analysis before digging myself.    
>>>>
>>>> This turned out to be a false positive. The way this microbenchmark was
>>>> invoked did not get enough samples, so it was mostly dependent on
>>>> whether caches were hot or cold, and the timing on this specific system
>>>> with the specific sequence of bencnmarks in the suite happens to favour
>>>> my baseline kernel.
>>>>
>>>> After increasing the batch count, I'm getting pretty much the same
>>>> performance for 6.11 vanilla and patched kernels:
>>>>
>>>>                         prc thr   usecs/call      samples   errors cnt/samp 
>>>> getenv (baseline)         1   1      0.14975           99        0   100000 
>>>> getenv (patched)          1   1      0.14981           92        0   100000     
>>>
>>> Oh that's good news! Does this account for all 3 of the above tests (getenv,
>>> getenvT2 and system())?  
>>
>> It does for getenvT2 (a variant of the test with 2 threads), but not
>> for system. Thanks for asking, I forgot about that one.
>>
>> I'm getting substantial difference there (+29% on average over 100 runs):
>>
>>                         prc thr   usecs/call      samples   errors cnt/samp  command
>> system (baseline)         1   1   6937.18016          102        0      100     A=$$
>> system (patched)          1   1   8959.48032          102        0      100     A=$$
>>
>> So, yeah, this should in fact be my priority #1.
> 
> Further testing reveals the workload is bimodal, that is to say the
> distribution of results has two peaks. The first peak around 3.2 ms
> covers 30% runs, the second peak around 15.7 ms covers 11%. Two per
> cent are faster than the fast peak, 5% are slower than slow peak, the
> rest is distributed almost evenly between them.

FWIW, One source of bimodality I've seen on Ampere systems with 2 NUMA nodes is
placement of the kernel image vs placement of the running thread. If they are
remote from eachother, you'll see a slowdown. I've hacked this source away in
the past by effectively using only a single NUMA node (with the help of
'maxcpus' and 'mem' kernel cmdline options).

> 
> 100 samples were not sufficient to see this distribution, and it was
> mere bad luck that only the patched kernel originally reported bad
> results. I can now see bad results even with the unpatched kernel.
> 
> In short, I don't think there is a difference in system() performance.
> 
> I will still have a look at dup() and VMA performance, but so far it
> all looks good to me. Good job! ;-)

Thanks for digging into all this!

> 
> I will also try running a more complete set of benchmarks during next
> week. That's SUSE Hack Week, and I want to make a PoC for the MM
> changes I proposed at LPC24, so I won't need this Ampere system for
> interactive use.
> 
> Petr T


