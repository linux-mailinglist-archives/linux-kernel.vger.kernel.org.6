Return-Path: <linux-kernel+bounces-212997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988B3906994
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA982872CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EABB1420DB;
	Thu, 13 Jun 2024 10:03:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025A1411CD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272994; cv=none; b=mxyFDngJfFWKIQ9Tm9clABf98s4+ITvRX7ZshAQVgQoU9P8zXPWsQI419CC6O8Cq1Z/2D95taPev3L2uJZpaqyyHYIsgddpjlKS8Qm0BzC3NUt2mfqnZJmElsX+sT/6sXSvOHWqJkYjilfSIwUF8U5D587+XV2gj5uv9KG1WQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272994; c=relaxed/simple;
	bh=2eQt5SP0pccUa93m1JxYU6eE81JMnIzL+PPDsnKtaJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdqMqf6/dgKuK5jmSgmKBbRVaryyeUOZpbd115iydDplA0l+wax4RsrTVqnDU12X9TcN86pjONHHgT+/Sg+uPoV12OnHvlXxtPIJ7ZngqlrImSg57ugwdf9w8nqK/G+ywl0r3IgPI9P/f4t9I6WwGfaSUenwTie/8gWaVUEdAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E1EC1063;
	Thu, 13 Jun 2024 03:03:36 -0700 (PDT)
Received: from [10.1.28.178] (XHFQ2J9959.cambridge.arm.com [10.1.28.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15A63F5A1;
	Thu, 13 Jun 2024 03:03:10 -0700 (PDT)
Message-ID: <3665e735-1927-49b3-ad93-c50eb919b370@arm.com>
Date: Thu, 13 Jun 2024 11:03:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop ESR_ELx_FSC_TYPE
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240613094538.3263536-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240613094538.3263536-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2024 10:45, Anshuman Khandual wrote:
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

This certainly looks like a nice clean up from a readability point of view, and
will also make it easier to support extra levels in future. It's probably
marginally slower, but given you are comparing the lowest level first, which I
guess is most likely to fault, you will short circuit most comparisons most of
the time. So:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

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


