Return-Path: <linux-kernel+bounces-566036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0C4A67262
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69BA3AB5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429891F8ADF;
	Tue, 18 Mar 2025 11:17:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423D1922FD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296622; cv=none; b=Gy54woly/4SYja2xxzAW7hdC4s3vwE+8r05cn2k4mZWFgYDwHKb5v2U9fqxhHc8UzYTAAh6pacToHphjn96O80AnhVGdKlTNvMCDIedH+yIJaSnsvQ36veUP32/iT37rZjY48clpehGqM6aaNOnD0er5QKl264SAG2DPzSArC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296622; c=relaxed/simple;
	bh=tB/7l3uH8h9YVq1KtWPxVtDtyEBUGbAXbDqyNoNP2Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYLGy4Bbd7kFB980y0xOn+0yMgHhZLmTqItotn6Mhbzi2Cfegdr44foqFBb+gL4HenkXbm81gycPVlwnrulJ3Y80d0JcsWtsxUkS6ewM84LfBYStddZTz+pd3DaqlPc4kVHSFyZeeFQXhnopq/tVm3GD5vPqKTVqC5qn3fXMsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2685113D5;
	Tue, 18 Mar 2025 04:17:09 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A6BC3F694;
	Tue, 18 Mar 2025 04:16:59 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:16:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/mm/hotplug: Drop redundant [pgd|p4d]_present()
Message-ID: <Z9lWJsA2hg2UKZ0T@J2N7QTR9R3>
References: <20250221094449.1188427-1-anshuman.khandual@arm.com>
 <20250221094449.1188427-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221094449.1188427-2-anshuman.khandual@arm.com>

On Fri, Feb 21, 2025 at 03:14:48PM +0530, Anshuman Khandual wrote:
> [pgd|p4d]_present() are inverse to their corresponding [pgd|p4d]_none().

Maybe their implementations happen to be inverse today, but the semantic
of pXX_present() is not the inverse of the semantic of pXX_none(). In
general, !pXX_none() does not imply pXX_present().

> So [pgd|p4d]_present() test right after corresponding [pgd|p4d]_none()
> inverse test does not make sense. Hence just drop these redundant
> checks.

I think the checks make sense in abstract, even if they're redundant
today

Is there any reason to remove these specific case?

Surely the compiler optimizes these out when they're redundant?

Mark.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b4df5bc5b1b8..66906c45c7f6 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -952,7 +952,6 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
>  		if (p4d_none(p4d))
>  			continue;
>  
> -		WARN_ON(!p4d_present(p4d));
>  		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap);
>  	} while (addr = next, addr < end);
>  }
> @@ -978,7 +977,6 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
>  		if (pgd_none(pgd))
>  			continue;
>  
> -		WARN_ON(!pgd_present(pgd));
>  		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
>  	} while (addr = next, addr < end);
>  }
> @@ -1114,7 +1112,6 @@ static void free_empty_p4d_table(pgd_t *pgdp, unsigned long addr,
>  		if (p4d_none(p4d))
>  			continue;
>  
> -		WARN_ON(!p4d_present(p4d));
>  		free_empty_pud_table(p4dp, addr, next, floor, ceiling);
>  	} while (addr = next, addr < end);
>  
> @@ -1153,7 +1150,6 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
>  		if (pgd_none(pgd))
>  			continue;
>  
> -		WARN_ON(!pgd_present(pgd));
>  		free_empty_p4d_table(pgdp, addr, next, floor, ceiling);
>  	} while (addr = next, addr < end);
>  }
> -- 
> 2.30.2
> 

