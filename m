Return-Path: <linux-kernel+bounces-357127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3E996BDB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E88D1F21D98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA7198A29;
	Wed,  9 Oct 2024 13:29:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FEB18C92A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480591; cv=none; b=tGnk5ftAEYgnXt3fdHBjbzp2O5vAFCg2tu4EQIxeX3YSlAsQavHoMe43R22SQ2lQAr4ORVxURAzrgOgmLokWR8yuCtRDc+fqeKO8BdyXzQap0CNC7OKylm/Smz885QSqFY+HTLC/5R391Lihnu20G58FKuNMNJXi7ldY4QvT9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480591; c=relaxed/simple;
	bh=MOH0aLrszP/7+AYlkDVCm5CN76bwWTO+1ItQcDjDNcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBPZLgourLfZC12qel/GEqJyX4H8MklMMgSQvk0cAIgUWl3u4UXRhe54b8jhTUTtoKn+qlTgI2xHTy172YE7AAJZbfDiCZetA7Gi5PsMXt4oStvq9JvHCYBMMmbKHww6pwpLf6SsnCGNaM+MhXzT2E+AqOGtY5uBP39W31GNoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EED2FEC;
	Wed,  9 Oct 2024 06:30:19 -0700 (PDT)
Received: from [10.57.85.216] (unknown [10.57.85.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D94E3F58B;
	Wed,  9 Oct 2024 06:29:48 -0700 (PDT)
Message-ID: <db908eb5-fa01-400a-a6c1-36a5ebddb47c@arm.com>
Date: Wed, 9 Oct 2024 14:29:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64/ptdump: Test PMD_TYPE_MASK for block mapping
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241005123824.1366397-1-anshuman.khandual@arm.com>
 <20241005123824.1366397-4-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241005123824.1366397-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 13:38, Anshuman Khandual wrote:
> arm64 block mapping requires given page table entry's bits[1:0] to be "01".
> But now only bit[1] is checked to be clear, while also implicitly assuming
> bit[0] to be set. This modifies ptdump to check both the relevant bits via
> the mask PMD_TYPE_MASK and check the resultant value against PMD_TYPE_MASK.
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
>  arch/arm64/mm/ptdump.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 264c5f9b97d8..8cec0da4cff2 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -80,10 +80,10 @@ static const struct ptdump_prot_bits pte_bits[] = {
>  		.set	= "CON",
>  		.clear	= "   ",
>  	}, {
> -		.mask	= PTE_TABLE_BIT,
> -		.val	= PTE_TABLE_BIT,
> -		.set	= "   ",
> -		.clear	= "BLK",
> +		.mask	= PMD_TYPE_MASK,
> +		.val	= PMD_TYPE_SECT,
> +		.set	= "BLK",
> +		.clear	= "   ",
>  	}, {
>  		.mask	= PTE_UXN,
>  		.val	= PTE_UXN,


