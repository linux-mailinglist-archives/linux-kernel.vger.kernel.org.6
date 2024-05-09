Return-Path: <linux-kernel+bounces-174121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A48C0A70
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE15D1C215D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCAE14831C;
	Thu,  9 May 2024 04:24:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C71487C7
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228642; cv=none; b=dZnHaWOwkNrGu6TqaCaYzVEGwRnHIRPuFthYowsI0Zvi+snsUKb/u8fd3PerFqmENg40lVOMYS+yyjUF7l+UEs2kXaqlHw2HZUwwMmuMgDwdDuWxN5ZQqqP+dy22ixQocVJQJrxhg6xbby6SaOtlvuyQOyqdqqM+s6iEhCugggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228642; c=relaxed/simple;
	bh=vHLv/5Bi0v1adLKSRnjB3dDVr6pKB8384v9uj8v0KsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qz2BxkeaEHr9187nV7zfDHpM3/bKwk4WD4PrxNoYLdEgdOQVwYa42WqqOJDDlLrFPkZVPZoH7NGynpGf7w2tjJ/Nbdnv7U+WjYLtvor5XtS2GBPZi6lF4Cpg61E+Nq3b2JnNIXDYqDE9y+RfTGmExUrB1aanXi+bkkHP79SUarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEBD3106F;
	Wed,  8 May 2024 21:24:23 -0700 (PDT)
Received: from [10.163.37.187] (unknown [10.163.37.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1E93F6A8;
	Wed,  8 May 2024 21:23:54 -0700 (PDT)
Message-ID: <ea88e906-3219-48c0-884c-3bb13ca0d18f@arm.com>
Date: Thu, 9 May 2024 09:53:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
 <c1ba9ba3-b0d6-4c6c-d628-614751d737c2@gentwo.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <c1ba9ba3-b0d6-4c6c-d628-614751d737c2@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/24 22:45, Christoph Lameter (Ampere) wrote:
> On Wed, 8 May 2024, Anshuman Khandual wrote:
> 
>>> The atomic RMW instructions, for example, ldadd, actually does load +
>>> add + store in one instruction, it may trigger two page faults, the
>>> first fault is a read fault, the second fault is a write fault.
>>
>> It may or it will definitely create two consecutive page faults. What
>> if the second write fault never came about. In that case an writable
>> page table entry would be created unnecessarily (or even wrongfully),
>> thus breaking the CoW.
> 
> An atomic RMV will always perform a write? If there is a read fault then write fault will follow.

Alright, but the wording above in the commit message is bit misleading.

> 
>>> Some applications use atomic RMW instructions to populate memory, for
>>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>>
>> But why cannot normal store operation is sufficient for pre-touching
>> the heap memory, why read-modify-write (RMW) is required instead ?
> 
> Sure a regular write operation is sufficient but you would have to modify existing applications to get that done. x86 does not do a read fault on atomics so we have an issue htere.

Understood, although not being able to change an application to optimize
might not be a compelling argument on its own, but treating such atomic
operations differently in page fault path for improved performance sounds
feasible. But will probably let others weigh in on this and possible need
for parity with x86 behaviour.

> 
>> If the memory address has some valid data, it must have already reached there
>> via a previous write access, which would have caused initial CoW transition ?
>> If the memory address has no valid data to begin with, why even use RMW ?
> 
> Because the application can reasonably assume that all uninitialized data is zero and therefore it is not necessary to have a prior write access.

Alright, but again I wonder why an atomic operation is required to init
or pre-touch uninitialized data, some how it does not make sense unless
there is some more context here.

> 
>>> Some other architectures also have code inspection in page fault path,
>>> for example, SPARC and x86.
>>
>> Okay, I was about to ask, but is not calling get_user() for all data
>> read page faults increase the cost for a hot code path in general for
>> some potential savings for a very specific use case. Not sure if that
>> is worth the trade-off.
> 
> The instruction is cache hot since it must be present in the cpu cache for the fault. So the overhead is minimal.
> 

But could not a pagefault_disable()-enable() window prevent concurring
page faults for the current process thus degrading its performance.

