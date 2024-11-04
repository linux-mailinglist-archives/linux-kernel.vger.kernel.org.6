Return-Path: <linux-kernel+bounces-394208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EE9BABE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AF5281AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0E18B494;
	Mon,  4 Nov 2024 04:58:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DB185B72
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730696324; cv=none; b=faKH3q4gElfr1Q4vtS2nDeVE5m85kOA5oBZBRKrSxm9887QgnnjDOwGur4zDOmTG0ySYsxF79sg54Mc/UzVkCbkHZe33dZZ5cZgz+kbIqRtm+xGV+s0AITHfcX49KFm7ZbbPrqD06V1LEnS0QfWDUDcJ6VaDzgJPNJdUun8UFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730696324; c=relaxed/simple;
	bh=GP8NFJZ9Vc2NhQ5c1RdXbTOwE62fCpa0BEN8uXl0+cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2rG3m92htp8XzLus4Zzgggm48rtMWelY40lV/KFZHNe4eJdX5mLDkCjM69XOV7+74o04ruwqhUNLxbGFwTkUZhSEPWmqbPj6f2C/3PwJMsxeAoGApodiUUmpyp2NPJ6FjLXnxQud46xgnzKTEvnfZA+fb082TvS4UIf5KCx7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B741FEC;
	Sun,  3 Nov 2024 20:59:10 -0800 (PST)
Received: from [10.162.16.84] (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2D93F66E;
	Sun,  3 Nov 2024 20:58:38 -0800 (PST)
Message-ID: <1a724b58-d61b-443d-9f3d-aebcd35e9610@arm.com>
Date: Mon, 4 Nov 2024 10:28:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Re-organize arch_make_huge_pte()
To: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org
References: <20241029044529.2624785-1-anshuman.khandual@arm.com>
 <173048223682.1108539.16990086073905192650.b4-ty@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <173048223682.1108539.16990086073905192650.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/24 23:05, Catalin Marinas wrote:
> On Tue, 29 Oct 2024 10:15:29 +0530, Anshuman Khandual wrote:
>> Core HugeTLB defines a fallback definition for arch_make_huge_pte(), which
>> calls platform provided pte_mkhuge(). But if any platform already provides
>> an override for arch_make_huge_pte(), then it does not need to provide the
>> helper pte_mkhuge().
>>
>> arm64 override for arch_make_huge_pte() calls pte_mkhuge() internally, thus
>> creating an impression, that both of these callbacks are being used in core
>> HugeTLB and hence required to be defined. This drops off pte_mkhuge() which
>> was never required to begin with as there could not be any section mappings
>> at the PTE level. Re-organize arch_make_huge_pte() based on requested page
>> size and create the entry for the applicable page table level as needed. It
>> also removes a redundancy of clearing PTE_TABLE_BIT bit followed by setting
>> both PTE_TABLE_BIT and PTE_VALID bits (via PTE_TYPE_MASK) in the pte, while
>> creating CONT_PTE_SIZE size entries.
>>
>> [...]
> 
> Applied to arm64 (for-next/misc), thanks!
> 
> [1/1] arm64/mm: Re-organize arch_make_huge_pte()
>       https://git.kernel.org/arm64/c/f8192813dcbe
> 
> I think we can now get pte_mkcont() to only set PTE_CONT without
> touching PTE_TYPE_PAGE. Previously it wasn't possible because
> pte_mkhuge() was clearing the PTE_TABLE_BIT and we added it back via
> pte_mkcont(). Give it a try and send an additional patch cleaning up
> pte_mkcont() if this works. Thanks.

Yes, it does indeed work. Sent the following patch for the same.

https://lore.kernel.org/all/20241104041617.3804617-1-anshuman.khandual@arm.com/

