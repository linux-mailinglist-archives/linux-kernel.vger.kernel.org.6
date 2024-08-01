Return-Path: <linux-kernel+bounces-271255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37549944BAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D0A1C23D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3F91A01BB;
	Thu,  1 Aug 2024 12:48:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F616C695
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516501; cv=none; b=dca/cQKSMg/5sJPoL3zw7m/jKhOvVCudsiH4H7sL5Rf03CYo51lZhvkJCl0uo3b5XRlRKQBbOq4rKWgjsTHBJhbkBTZ8F6zQdp8e2duk+Nja7WHLXewPMWu+Yv4bCibmKR7k+2kNFOVI0Ot6XSV0ul1KTD1w066LdS8Ocg9jjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516501; c=relaxed/simple;
	bh=IB1QbQ24+gBeGbC6Xy8gCliZdX6B6R/cYnxpwsnbRIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqiqIzjZtRtlkwKUyb49Kj3xHSqI60bfMj507Smh3FMl7RgHGRf1nqOCv2FSuEGESp0vWWyFM7RuTq+Qb/hdbWOsaSKKDmXtqMcP8YDpznGPRVQwVh33aA2I/sIjjFoBnuEUx1rvDz6fGAAaIUeMH9BXykJY2Hj20OUtUuOVQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 203AB15A1;
	Thu,  1 Aug 2024 05:48:45 -0700 (PDT)
Received: from [10.1.28.152] (XHFQ2J9959.cambridge.arm.com [10.1.28.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA6D3F766;
	Thu,  1 Aug 2024 05:48:18 -0700 (PDT)
Message-ID: <c65c0bcc-149e-4f30-9bab-e5377230d2cd@arm.com>
Date: Thu, 1 Aug 2024 13:48:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Avoid direct referencing page table enties in
 map_range()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
References: <20240725091052.314750-1-anshuman.khandual@arm.com>
 <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
 <20240801113440.GB4476@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240801113440.GB4476@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2024 12:34, Will Deacon wrote:
> On Thu, Jul 25, 2024 at 11:36:56AM +0100, Ryan Roberts wrote:
>> On 25/07/2024 10:10, Anshuman Khandual wrote:
>>> Like else where in arm64 platform, use WRITE_ONCE() in map_range() while
>>> creating page table entries. This avoids referencing page table entries
>>> directly.
>>
>> I could be wrong, but I don't think this code is ever operating on live
>> pgtables? So there is never a potential to race with the HW walker and therefore
>> no need to guarrantee copy atomicity? As long as the correct barriers are placed
>> at the point where you load the pgdir into the TTBRx there should be no problem?
>>
>> If my assertion is correct, I don't think there is any need for this change.
> 
> Agreed.

I think I need to row back on this. It looks like map_range() does act on live
pgtables; see map_kernel() where twopass == true. init_pg_dir is populated then
installed in TTBR1, then permissions are modified with 3 [un]map_segment()
calls, which call through to map_range().

So on that basis, I think the WRITE_ONCE() calls are warranted. And to be
consistent, I'd additionally recommend adding a READ_ONCE() around the:

if (pte_none(*tbl)) {

Thanks,
Ryan

> 
> Will


