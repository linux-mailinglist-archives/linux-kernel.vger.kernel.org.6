Return-Path: <linux-kernel+bounces-405582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E09C534F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13906B31818
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9B2123FD;
	Tue, 12 Nov 2024 10:19:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3432123DD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406785; cv=none; b=C36quEW3Xip3hZTpF+kW7MK+SBsSPBkj4kJSoJ/Dcp3doFwYOKQ0z7DZ2N3AJCFy/hTA4HTwHBDctADY5kVLXdEq2j7vYTj10PT4KSJJ11WS5P9Lwr1AcLGvNH7iK2oSm8KLmx3MTkrma+vrtIDM39IMCL5LYK+kGsH8YpT2ZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406785; c=relaxed/simple;
	bh=S2NI7RWEb6YS6xFU8qwMxHlLOqsu0p+4leT14oYmp/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAtVcg/lVeInk/zlX2pdp87tZqRFG+M0lOv0gohJqrDW8DbEe66HBx60voWti06yXhErZEH6+Vwuhcq6/ujzguNIcw/SzweqvMNr5nQ9xc8SsfXdjejlnVMeW3obPGTH/VXcuA3gbeh9X9k1Oj+GK9zVbtu0TZkHksHbjlK3aTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B44C25E4;
	Tue, 12 Nov 2024 02:20:08 -0800 (PST)
Received: from [10.57.89.175] (unknown [10.57.89.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA9683F66E;
	Tue, 12 Nov 2024 02:19:35 -0800 (PST)
Message-ID: <5a041e51-a43b-4878-ab68-4757d3141889@arm.com>
Date: Tue, 12 Nov 2024 10:19:34 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241112104544.574dd733@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2024 09:45, Petr Tesarik wrote:
> On Mon, 11 Nov 2024 12:25:35 +0000
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Hi Petr,
>>
>> On 11/11/2024 12:14, Petr Tesarik wrote:
>>> Hi Ryan,
>>>
>>> On Thu, 17 Oct 2024 13:32:43 +0100
>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>> [...]
>>> Third, a few micro-benchmarks saw a significant regression.
>>>
>>> Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
>>> slower with variable page size. I don't know why, but I'm looking into
>>> it. The system() library call was also about 18% slower, but that might
>>> be related.  
>>
>> OK, ouch. I think there are some things we can try to optimize the
>> implementation further. But I'll wait for your analysis before digging myself.
> 
> This turned out to be a false positive. The way this microbenchmark was
> invoked did not get enough samples, so it was mostly dependent on
> whether caches were hot or cold, and the timing on this specific system
> with the specific sequence of bencnmarks in the suite happens to favour
> my baseline kernel.
> 
> After increasing the batch count, I'm getting pretty much the same
> performance for 6.11 vanilla and patched kernels:
> 
>                         prc thr   usecs/call      samples   errors cnt/samp 
> getenv (baseline)         1   1      0.14975           99        0   100000 
> getenv (patched)          1   1      0.14981           92        0   100000 

Oh that's good news! Does this account for all 3 of the above tests (getenv,
getenvT2 and system())?

> 
>> You probably also saw the conversation with Catalin about the cost vs benefit of
>> this series. Performance regressions will all need to be considered in the cost
>> column, of course. So understanding the root cause and trying to reduce the
>> regression as much as possible will increase chances of getting it accepted
>> upstream.
> 
> Yes. Now that the biggest number is off the table, I'm going to:
> 
>  - look into the dup() slowdown
>  - verify whether VMA split/merge operations are indeed slower
> 
> Petr T


