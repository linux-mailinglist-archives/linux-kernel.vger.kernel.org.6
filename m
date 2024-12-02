Return-Path: <linux-kernel+bounces-427424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D99E00BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4477281BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD91FC7D0;
	Mon,  2 Dec 2024 11:38:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538D1FA245
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139520; cv=none; b=uJCXmedJNhYNygCaDEZMEkxL5uGnOFg7ZMyXPqeCwbGq8Sg83yW612Dlr4F9HUpQ7Xd7sMIqlwsA9C/NZHArdE51/sk1wMpT+XrsmzNGJMzJkqeoPVcHsWFzoSzXBj9Cv1SeUDYA7iQKCK5uhIwYMdzV5lw108M/xohMNNjqKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139520; c=relaxed/simple;
	bh=ymonn20zYpw0rKeavtvy9q7IRdmT4MmXM3fILnPyT9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T82ezHJMv4e8TrSD9hsSMqlslwph4iMaMBzk4bwlnA5K5zH89+e9IAq7sneiATgSmLJh1xglMYTjbSnvM/5sfE1XgHF8AEbGes8+iJONFSkkyTBMZ46QVnROvq7SUBBUt8/SI8NStihxVz0+msE62RnGGbEvL0xO1YF+wRY2tJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF6E91063;
	Mon,  2 Dec 2024 03:39:05 -0800 (PST)
Received: from [10.57.93.76] (unknown [10.57.93.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 183063F71E;
	Mon,  2 Dec 2024 03:38:35 -0800 (PST)
Message-ID: <3050a0b3-95f6-48aa-8850-e921bd848f85@arm.com>
Date: Mon, 2 Dec 2024 11:38:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop INIT_MM_CONTEXT()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org
References: <20241202043553.29592-1-anshuman.khandual@arm.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241202043553.29592-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 04:35, Anshuman Khandual wrote:
> Platform override for INIT_MM_CONTEXT() is redundant because swapper_pg_dir
> always gets assigned as the pgd during init_mm initialization. So just drop
> this override on arm64.
> 
> Originally this override was added via the 'commit 2b5548b68199 ("arm64/mm:
> Separate boot-time page tables from swapper_pg_dir")' because non standard
> init_pg_dir was assigned as the pgd. Subsequently it was changed as default
> swapper_pg_dir by the 'commit ba5b0333a847 ("arm64: mm: omit redundant
> remap of kernel image")', which might have also just dropped this override.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> This patch applies on v6.13-rc1
> 
>  arch/arm64/include/asm/mmu.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 2ec96d91acc6..662471cfc536 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -109,8 +109,5 @@ static inline bool kaslr_requires_kpti(void)
>  	return true;
>  }
>  
> -#define INIT_MM_CONTEXT(name)	\
> -	.pgd = swapper_pg_dir,
> -
>  #endif	/* !__ASSEMBLY__ */
>  #endif


