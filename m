Return-Path: <linux-kernel+bounces-322736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D7972CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5D8B255CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF08188004;
	Tue, 10 Sep 2024 09:08:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4B1891A1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959295; cv=none; b=CT8o/oFp12GrnGZpQmXMpvqnzRHDpuHx9QCfTtlvVHhAfQ12LsU4SyOmVwA8y+aQObxFISVQ819mPiwowqo3n/OmLSZ3WJ/DkXJ4iEc0t7aM1EsDEghFCiyoyHjqWC4HUgiDEMrIa8EHprY1qYjGGVOp+aTSUdTU9x+C0y41DbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959295; c=relaxed/simple;
	bh=01FRvvTi5m/r+REJN0RtRssXNTLAPSFP4bvJC8tZuHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjz9Rzg2nXALy5qOiRS46A8Px4M5S64HcL5fWnvXE3LJfITtpTdUTJTZufQhCM4u+TVlegtgsqd6lMsmC7g71PL2cqGPSIOoBcrK8aha3OWxoTFCetJejBFehi1fxC86PO9f3FN6JQ8tT/RHLhXB11diyo85GBz0XPGI9O357BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31B2A113E;
	Tue, 10 Sep 2024 02:08:42 -0700 (PDT)
Received: from [10.1.35.188] (XHFQ2J9959.cambridge.arm.com [10.1.35.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DC613F66E;
	Tue, 10 Sep 2024 02:08:12 -0700 (PDT)
Message-ID: <cae9c32d-c96e-463e-9375-91d9a7ad196a@arm.com>
Date: Tue, 10 Sep 2024 10:08:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Drop unused set_pte_safe()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20240910090409.374424-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240910090409.374424-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2024 10:04, Anshuman Khandual wrote:
> All set_pte_safe() usage have been dropped after the commit eccd906484d1
> ("x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page")
> This just drops now unused helper set_pte_safe().

It would be good to add some comment here to mention that the macro was buggy
due to doing direct dereferencing of the pte, and that if it were to be kept, it
should have been updated to use a single call to ptep_get().

With that:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks,
Ryan

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/pgtable.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..aeabbf0db7c8 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1058,12 +1058,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>   * same value. Otherwise, use the typical "set" helpers and flush the
>   * TLB.
>   */
> -#define set_pte_safe(ptep, pte) \
> -({ \
> -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> -	set_pte(ptep, pte); \
> -})
> -
>  #define set_pmd_safe(pmdp, pmd) \
>  ({ \
>  	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \


