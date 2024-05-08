Return-Path: <linux-kernel+bounces-173008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3382A8BF9F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EF6282970
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024B79B8E;
	Wed,  8 May 2024 10:00:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392A3FE3F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162427; cv=none; b=dei9pXt5BoSKpBvRM3Ibv/0A7mAVRuI8XuWGqOgmaDxbJW9RyvfoJDpv/kCvQq4W63lhQdvTDulzi5PxigsR5e65rS+S2iKFIyaCwakgNJYi+DdrJKZMjaVpEVfo+DV88XUHLSap8dhH005LSUno/uE4GKJZzdOWRVcm2/b6uZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162427; c=relaxed/simple;
	bh=Clksgg3nQKgJU4IUYhhUlpLCznOj3chtVCYbTOvxo4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXrg/5n+RzINbXPB++pQZn+23sIK1uL3QgP0WJiOij/DsLvMhH5/3tVxoZ5i0o5USCxthd/rrn3TsDjoM2MRWnGs+rw9nlNGeNa3bvvQ/HNA+ACXjWX8oGTTocwFglhxARx3HhmrNmwdHzhe/QHR8y7rwiWgohnE9xIe7kZ1RdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980B71063;
	Wed,  8 May 2024 03:00:49 -0700 (PDT)
Received: from [10.163.34.220] (unknown [10.163.34.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6BA3F587;
	Wed,  8 May 2024 03:00:19 -0700 (PDT)
Message-ID: <674dac6b-4fd5-4460-81fd-6b215b21434e@arm.com>
Date: Wed, 8 May 2024 15:30:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] arm64/mm: Enable userfaultfd write-protect
Content-Language: en-US
To: Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly
 <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240507110750.GA22289@willie-the-truck>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240507110750.GA22289@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/7/24 16:37, Will Deacon wrote:
> Hi Ryan,
> 
> On Fri, May 03, 2024 at 03:45:58PM +0100, Ryan Roberts wrote:
>> This series adds uffd write-protect support for arm64.
>>
>> Previous attempts to add uffd-wp (and soft-dirty) have failed because of a
>> perceived lack of available PTE SW bits. However it actually turns out that
>> there are 2 available but they are hidden. PTE_PROT_NONE was previously
>> occupying a SW bit, but can be moved, freeing up the SW bit. Bit 63 is marked as
>> "IGNORED" in the Arm ARM, but it does not currently indicate "reserved for SW
>> use" like it does for the other SW bits. I've confirmed with the spec owner that
>> this is an oversight; the bit is intended to be reserved for SW use and the spec
>> will clarify this in a future update.
>>
>> So now we have two spare bits; patch 4 enables uffd-wp on arm64, using the SW
>> bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
>> (e.g. soft-dirty - see RFC at [4] - or some other usage).
>>
>> ---
>>
>> This applies on top of v6.9-rc5.
> 
> I chucked this into the CI on Friday and it looks to have survived the
> long weekend, so I've gone ahead and merged it into for-next/core. Short
> of any last minute failures (touch wood), this should land in 6.10.

It would be great to have some memory migration tests (including THP and HugeTLB)
thrown at this series, which should test the mapped, migration entry transitions
etc. But not sure if there are any such tests off the shelf and readily available
in the CI system.

