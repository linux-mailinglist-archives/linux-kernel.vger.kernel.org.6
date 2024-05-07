Return-Path: <linux-kernel+bounces-171184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9F8BE0CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9111F263D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57C152168;
	Tue,  7 May 2024 11:17:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE61514F8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080644; cv=none; b=Aan1hOEy3ETh+JT2bdYUz+voEnKHvWK00s18B5dmLBVN2d8RnbSLGbzd45X3V6InSOi/Ah+OtVzMP4T7DnRd2YAc01sC5DA+UdTwZLnw3kWCODrPRHWx5rwiBDE5zj4JzKoFO4bvPxM1ptmImuzWlnvRp3QpZ9djBdJe/DqhsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080644; c=relaxed/simple;
	bh=4RWDb3dhbxFzvMPLfYEXGp9RHbWBGzBigcrnGPG2AOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnoWq9bCMiyqvbk6iT9PY7c4VFgoB2ZiQjl2v1bGP5BTApz34PMKLLPhT4QcIdsHH/rtWBi2qrgiTGW16NQFjwR4tmF+K46/4ZaAnqiHnNYYHT8u8e8km/DFmiV/8PWduY1OYSxFEXFhEKzNjGClNRCtyS6tymodFkHbClj3FOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 743D41063;
	Tue,  7 May 2024 04:17:47 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009423F587;
	Tue,  7 May 2024 04:17:19 -0700 (PDT)
Message-ID: <3764382b-9fa6-4e94-ad5b-2e22e3e7c71a@arm.com>
Date: Tue, 7 May 2024 12:17:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] arm64/mm: Enable userfaultfd write-protect
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly
 <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240507110750.GA22289@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240507110750.GA22289@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 12:07, Will Deacon wrote:
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

Oh great - thanks!

Catalin was previously proposing to hold this until 6.11 - I'll leave you two to
fight it out in case that's still his preference ;-)

> 
> Thanks!
> 
> Will


