Return-Path: <linux-kernel+bounces-555493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E3A5B887
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E361706CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43661EBA09;
	Tue, 11 Mar 2025 05:28:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D0F1EB9E5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670888; cv=none; b=EYL0Fv+gJH0FPLpfw6AyhYD5Xglxo6J9I9KLUqaFyIRVNAr2JQl6P/D+aFFqiI9w03mYTIFy+2v2lGjYgdlG8KWFyOjdJEPq3DCHr9pdSssGHwvplFwnYAbaKSChgZXZ9lHLkERANqXm+Mv4IYChwLrv8+NKM8B+/sZVurSgxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670888; c=relaxed/simple;
	bh=eKRlHLWaBspEoRQ8S57NlVWYi2I+xHjGl2BFk2h+y7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNHF7OxodecxvuvJttFssQjlo1lJ7zRBYyUg0zGTmNbvePWEJksVXxOoGtTDkVdVw8xqOTVKO7kHDn0nmbEpO6cRVFKYmOTmIZMtGNkwnDjYVeSMIWmaRnz0DesxfY9Y3G7ZOC1jbSD3E6maVvN6FTRNO+nFkSOxGmC+ALdzVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1734D1516;
	Mon, 10 Mar 2025 22:28:17 -0700 (PDT)
Received: from [10.162.40.19] (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA103F694;
	Mon, 10 Mar 2025 22:28:03 -0700 (PDT)
Message-ID: <dd8aa408-5260-4f53-b057-2c14c9a585d7@arm.com>
Date: Tue, 11 Mar 2025 10:58:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: use ptep_get() instead of directly dereferencing
 pte_t*
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250310140418.1737409-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250310140418.1737409-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 19:34, Ryan Roberts wrote:
> It is best practice for all pte accesses to go via the arch helpers, to
> ensure non-torn values and to allow the arch to intervene where needed
> (contpte for arm64 for example). While in this case it was probably safe
> to directly dereference, let's tidy it up for consistency.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 22e270f727ed..33a22c2d6b20 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -202,7 +202,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  		return false;
>  	VM_BUG_ON_PAGE(!PageAnon(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> +	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> 
>  	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>  	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> --
> 2.43.0
> 
> 

LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

