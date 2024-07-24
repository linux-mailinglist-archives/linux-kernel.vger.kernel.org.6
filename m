Return-Path: <linux-kernel+bounces-260727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE6593AD74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B910B22628
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA017EF04;
	Wed, 24 Jul 2024 07:52:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D4354670
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807564; cv=none; b=GuHJT0vkhMbExBpYRalPyLNs11zGRX11fE5KUVgl+w0nORaLbIPnDG1de3JR/PzObSAki77jDd2H8P0dcW0pRs9GazfaRp6DnoJHnZ3EqsgrL52HYOdF2OQvqCzZu2mZikRlcuRm98GjPt08f0uXhBdx2xqb30KeA4uk8TN9o/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807564; c=relaxed/simple;
	bh=xkb7OzF0fBfK2YQN1tmiK8pz0zLUbfutQRmUVa25EUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dId+/IGr1Kg1v4m5YvizJJXJec6zFDTEUrheUxufWsFKIjR3mf0hoxOcdq0+355P3EKi600MK02ECFZtQTTjGfrvy1OU+F35DZRDW9gViKqlv/h9de3SqwKVyJ2RfD3c4MPMAsODvqm+mT1N6aO2SocvFEAPA40N6bSooQGPOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1324106F;
	Wed, 24 Jul 2024 00:53:06 -0700 (PDT)
Received: from [10.57.78.42] (unknown [10.57.78.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809013F766;
	Wed, 24 Jul 2024 00:52:40 -0700 (PDT)
Message-ID: <8f6b7735-5746-4bd0-b248-677638d54c7c@arm.com>
Date: Wed, 24 Jul 2024 08:52:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop PMD_SECT_VALID
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240724044712.602210-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240724044712.602210-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2024 05:47, Anshuman Khandual wrote:
> This just drops off the macro PMD_SECT_VALID which remains unused. Because
> macro PMD_TYPE_SECT with same value (_AT(pmdval_t, 1) << 0), gets used for
> creating or updating given block mappings.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 1f60aa1bc750..86e803ea8885 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -135,7 +135,6 @@
>  /*
>   * Section
>   */
> -#define PMD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
>  #define PMD_SECT_USER		(_AT(pmdval_t, 1) << 6)		/* AP[1] */
>  #define PMD_SECT_RDONLY		(_AT(pmdval_t, 1) << 7)		/* AP[2] */
>  #define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)


