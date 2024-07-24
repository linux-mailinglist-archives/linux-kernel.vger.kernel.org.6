Return-Path: <linux-kernel+bounces-260740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 049A393AD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C802B22251
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEA1369A6;
	Wed, 24 Jul 2024 07:58:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685AE132492
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807937; cv=none; b=XGIzF7/jIFUbzn+47wipVEwUpbB1OwjQ2cp2QOyRcHoNNNp4Fk5iiyrXLcMHxFjWOaXIEDFs3DypHi4rYbI348d6YNkupiQ6FTAKQK9fGn3VuAB7USF9H0waHetBJ4TCe9wTkAHjQOmjG9I0Gv8iBqKaqXOLAx/+X/NNTQwH5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807937; c=relaxed/simple;
	bh=X7eBFu4LUDZb8htUsbtflXNpyNA9IfOjYGZ/zPCRAcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYiO2eS3BIFZeH9W0x/Sio3djNDW8J2VpTQe6gNpViOkhRtE2zLnpAPj+d7ALog049OnmA4+dTVAYxdQBDEHGq78Gyg+jrgVBvHh9pqRC1EBfLeXsyaoo2o8XTSNBpvczegaMHnK4TyZgDxHj85dBoke4ouYWtLGT9ZtNjAdzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF12F106F;
	Wed, 24 Jul 2024 00:59:19 -0700 (PDT)
Received: from [10.57.78.42] (unknown [10.57.78.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A9523F766;
	Wed, 24 Jul 2024 00:58:53 -0700 (PDT)
Message-ID: <1b6de5f8-fe2f-4db4-ba35-f0ab8b42c0a4@arm.com>
Date: Wed, 24 Jul 2024 08:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop TCR_SMP_FLAGS
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240724041428.573748-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240724041428.573748-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2024 05:14, Anshuman Khandual wrote:
> Earlier TCR_SMP_FLAGS gets conditionally set as TCR_SHARED with CONFIG_SMP.
> Currently CONFIG_SMP is always enabled on arm64 platforms, hence drop this
> indirection via TCR_SMP_FLAGS and instead always directly use TCR_SHARED.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/mm/proc.S | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index f4bc6c5bac06..8abdc7fed321 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -36,8 +36,6 @@
>  #define TCR_KASLR_FLAGS	0
>  #endif
>  
> -#define TCR_SMP_FLAGS	TCR_SHARED
> -
>  /* PTWs cacheable, inner/outer WBWA */
>  #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
>  
> @@ -469,7 +467,7 @@ SYM_FUNC_START(__cpu_setup)
>  	tcr	.req	x16
>  	mov_q	mair, MAIR_EL1_SET
>  	mov_q	tcr, TCR_T0SZ(IDMAP_VA_BITS) | TCR_T1SZ(VA_BITS_MIN) | TCR_CACHE_FLAGS | \
> -		     TCR_SMP_FLAGS | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> +		     TCR_SHARED | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
>  		     TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
>  
>  	tcr_clear_errata_bits tcr, x9, x5


