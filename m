Return-Path: <linux-kernel+bounces-427428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6F09E01D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630B8B23D45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE41FC0E8;
	Mon,  2 Dec 2024 11:42:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E61D932F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139731; cv=none; b=odZE9NfSte602lJmyLbEs25NBZJ5dvz7dbUgk0tbrce9tPNy3B2mYbZr85h6PQyuo/pUr5XrDBMfNr2+1/E5BasSJMPBvd6mQu6kcvr0GopD1E6AZtAaDznr+6LCtPi7aDLNLhjqNDkk30OCO4GjMUbG8/1DPnsS3vNYia2+9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139731; c=relaxed/simple;
	bh=c7B08i3UF6WW1RRqTTznDaUtOQmZzu4+ezyL94SiidM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfELlgKP7cBXI0NBdJXJhtBmKVFZXV3UxY0F5JYJHVSheNP/FIZa7Iri7rXmesY8lOd8XDoR2ElFCeULCws2RIg9A5lDUlkTs7X8UZFlukyTj8ffsgAK/1EzMtQ74O8ja5Ny3hvu6cPKSiLlgmKob+qAcBDKJHfEYYHT1g0Byuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 972BE1063;
	Mon,  2 Dec 2024 03:42:37 -0800 (PST)
Received: from [10.57.93.76] (unknown [10.57.93.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A873F71E;
	Mon,  2 Dec 2024 03:42:07 -0800 (PST)
Message-ID: <85b1bf12-54cc-4d17-9aa1-ab496cb04d36@arm.com>
Date: Mon, 2 Dec 2024 11:42:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Replace open encodings with PXD_TABLE_BIT
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org
References: <20241202083850.73207-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241202083850.73207-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 08:38, Anshuman Khandual wrote:
> [pgd|p4d]_bad() helpers have open encodings for their respective table bits
> which can be replaced with corresponding macros. This makes things clearer,
> thus improving their readability as well.
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
>  arch/arm64/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 6986345b537a..e20b80229910 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -896,7 +896,7 @@ static inline bool mm_pud_folded(const struct mm_struct *mm)
>  	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
>  
>  #define p4d_none(p4d)		(pgtable_l4_enabled() && !p4d_val(p4d))
> -#define p4d_bad(p4d)		(pgtable_l4_enabled() && !(p4d_val(p4d) & 2))
> +#define p4d_bad(p4d)		(pgtable_l4_enabled() && !(p4d_val(p4d) & P4D_TABLE_BIT))
>  #define p4d_present(p4d)	(!p4d_none(p4d))
>  
>  static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
> @@ -1023,7 +1023,7 @@ static inline bool mm_p4d_folded(const struct mm_struct *mm)
>  	pr_err("%s:%d: bad p4d %016llx.\n", __FILE__, __LINE__, p4d_val(e))
>  
>  #define pgd_none(pgd)		(pgtable_l5_enabled() && !pgd_val(pgd))
> -#define pgd_bad(pgd)		(pgtable_l5_enabled() && !(pgd_val(pgd) & 2))
> +#define pgd_bad(pgd)		(pgtable_l5_enabled() && !(pgd_val(pgd) & PGD_TABLE_BIT))
>  #define pgd_present(pgd)	(!pgd_none(pgd))
>  
>  static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)


