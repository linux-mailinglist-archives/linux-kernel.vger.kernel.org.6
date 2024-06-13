Return-Path: <linux-kernel+bounces-213000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9E90699F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C530286EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D6E1411D6;
	Thu, 13 Jun 2024 10:06:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191313CA95
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273180; cv=none; b=KLrNWtVEJq1zHIn9ta20PyUIE+0TMAP1yKqUtnolM1MFpr4uujohFhPqouUQGOS9tX6m9D4dBvHvvvP0Js/4XLVslhksv2nFIyZSfV2AoVhdFhhtA1lHW5C+7RWo4NEGzAYa8q+aRthrm5P6oi79SJZDBsL9BFJ3G6gqBxNcF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273180; c=relaxed/simple;
	bh=pQzXEQ8bNVHfnjKZhVB2atAMbAFdV7HmJnc0c921B6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS4kOmwPmFk+MSCCZlByIejqZ0AMxyhmFuCP6DR3bcvODUdbh7LoB7zXfeNU7OBHUArTygCga7PNSgRyV3ORGGmsskIFyhnwmTq1NsFeblP4QllgxjqbgRS5WCKWAmIYgRKm2wT94i11q6PCe5bNs3RSVyBI7c37V99sa0RoVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7C51063;
	Thu, 13 Jun 2024 03:06:42 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30AC63F5A1;
	Thu, 13 Jun 2024 03:06:16 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:06:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop ESR_ELx_FSC_TYPE
Message-ID: <ZmrEkvXpP5L8SOAY@J2N7QTR9R3>
References: <20240613094538.3263536-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613094538.3263536-1-anshuman.khandual@arm.com>

On Thu, Jun 13, 2024 at 03:15:38PM +0530, Anshuman Khandual wrote:
> Fault status codes at page table level 0, 1, 2 and 3 for access, permission
> and translation faults are architecturally organized in a way, that masking
> out ESR_ELx_FSC_TYPE, fetches Level 0 status code for the respective fault.
> 
> Helpers like esr_fsc_is_[translation|permission|access_flag]_fault() mask
> out ESR_ELx_FSC_TYPE before comparing against corresponding Level 0 status
> code as the kernel does not yet care about the page table level, the fault
> really occurred previously.
> 
> This scheme is starting to crumble after FEAT_LPA2 when level -1 got added.
> Fault status code for translation fault at level -1 is 0x2B which does not
> follow ESR_ELx_FSC_TYPE, requiring esr_fsc_is_translation_fault() changes.
> 
> This changes above helpers to compare against individual fault status code
> values for each page table level and drop ESR_ELx_FSC_TYPE which is losing
> its value as a common mask.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> This applies on 6.10-rc3
> 
>  arch/arm64/include/asm/esr.h | 42 +++++++++++++++++++++++++++---------
>  arch/arm64/mm/fault.c        |  4 ++--
>  2 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 7abf09df7033..8cc0311d3fba 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -109,14 +109,23 @@
>  
>  /* Shared ISS fault status code(IFSC/DFSC) for Data/Instruction aborts */
>  #define ESR_ELx_FSC		(0x3F)
> -#define ESR_ELx_FSC_TYPE	(0x3C)
>  #define ESR_ELx_FSC_LEVEL	(0x03)
>  #define ESR_ELx_FSC_EXTABT	(0x10)
>  #define ESR_ELx_FSC_MTE		(0x11)
>  #define ESR_ELx_FSC_SERROR	(0x11)
> -#define ESR_ELx_FSC_ACCESS	(0x08)
> -#define ESR_ELx_FSC_FAULT	(0x04)
> -#define ESR_ELx_FSC_PERM	(0x0C)
> +#define ESR_ELx_FSC_ACCESS_L0	(0x08)
> +#define ESR_ELx_FSC_ACCESS_L1	(0x09)
> +#define ESR_ELx_FSC_ACCESS_L2	(0x0A)
> +#define ESR_ELx_FSC_ACCESS_L3	(0x0B)
> +#define ESR_ELx_FSC_FAULT_LN1	(0x2B)
> +#define ESR_ELx_FSC_FAULT_L0	(0x04)
> +#define ESR_ELx_FSC_FAULT_L1	(0x05)
> +#define ESR_ELx_FSC_FAULT_L2	(0x06)
> +#define ESR_ELx_FSC_FAULT_L3	(0x07)
> +#define ESR_ELx_FSC_PERM_L0	(0x0C)
> +#define ESR_ELx_FSC_PERM_L1	(0x0D)
> +#define ESR_ELx_FSC_PERM_L2	(0x0E)
> +#define ESR_ELx_FSC_PERM_L3	(0x0F)
>  #define ESR_ELx_FSC_SEA_TTW(n)	(0x14 + (n))
>  #define ESR_ELx_FSC_SECC	(0x18)
>  #define ESR_ELx_FSC_SECC_TTW(n)	(0x1c + (n))
> @@ -388,20 +397,33 @@ static inline bool esr_is_data_abort(unsigned long esr)
>  
>  static inline bool esr_fsc_is_translation_fault(unsigned long esr)
>  {
> -	/* Translation fault, level -1 */
> -	if ((esr & ESR_ELx_FSC) == 0b101011)
> -		return true;
> -	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
> +	esr = esr & ESR_ELx_FSC;
> +
> +	return (esr == ESR_ELx_FSC_FAULT_L3) ||
> +	       (esr == ESR_ELx_FSC_FAULT_L2) ||
> +	       (esr == ESR_ELx_FSC_FAULT_L1) ||
> +	       (esr == ESR_ELx_FSC_FAULT_L0) ||
> +	       (esr == ESR_ELx_FSC_FAULT_LN1);
>  }
>  
>  static inline bool esr_fsc_is_permission_fault(unsigned long esr)
>  {
> -	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM;
> +	esr = esr & ESR_ELx_FSC;
> +
> +	return (esr == ESR_ELx_FSC_PERM_L3) ||
> +	       (esr == ESR_ELx_FSC_PERM_L2) ||
> +	       (esr == ESR_ELx_FSC_PERM_L1) ||
> +	       (esr == ESR_ELx_FSC_PERM_L0);
>  }
>  
>  static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
>  {
> -	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_ACCESS;
> +	esr = esr & ESR_ELx_FSC;
> +
> +	return (esr == ESR_ELx_FSC_ACCESS_L3) ||
> +	       (esr == ESR_ELx_FSC_ACCESS_L2) ||
> +	       (esr == ESR_ELx_FSC_ACCESS_L1) ||
> +	       (esr == ESR_ELx_FSC_ACCESS_L0);
>  }
>  
>  /* Indicate whether ESR.EC==0x1A is for an ERETAx instruction */
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 451ba7cbd5ad..7199aaff2a29 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -440,7 +440,7 @@ static void set_thread_esr(unsigned long address, unsigned long esr)
>  			 */
>  			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL |
>  				ESR_ELx_CM | ESR_ELx_WNR;
> -			esr |= ESR_ELx_FSC_FAULT;
> +			esr |= ESR_ELx_FSC_FAULT_L0;
>  			break;
>  		case ESR_ELx_EC_IABT_LOW:
>  			/*
> @@ -449,7 +449,7 @@ static void set_thread_esr(unsigned long address, unsigned long esr)
>  			 * reported with that DFSC value, so we clear them.
>  			 */
>  			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL;
> -			esr |= ESR_ELx_FSC_FAULT;
> +			esr |= ESR_ELx_FSC_FAULT_L0;
>  			break;
>  		default:
>  			/*
> -- 
> 2.30.2
> 
> 

