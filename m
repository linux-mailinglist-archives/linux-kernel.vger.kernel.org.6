Return-Path: <linux-kernel+bounces-523634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9377A3D974
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44933B764B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96B1F4615;
	Thu, 20 Feb 2025 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkjYEf2R"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BD1C831A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053121; cv=none; b=usxCYf2zhNX41Y3DI9a/7WYK+On+vckZwHLFW8hJH8MWnFBgRXmqd8n0tzHqsXAHyYAR5LZWd9eQ82/FY/1+6OVRafXGP/ruuMFrVF+mhMclQlO2Ga20YKOsDEKtQHQkiO3nAW8Y2RrPs2aQP84WWayA487XW8U0c9CW2Th86cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053121; c=relaxed/simple;
	bh=+dlFiiSJSBw7lcp4JxNKzV4dzIYADYEe+wR6R/dTxxE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTAU87/Dnxb6ZBiGDVQU4YyztlOFEV+7Akpe6Y02TJ4Hj8WtiTocl5OYT541lt1PvTJRI+KqpCcTcjQt8epAv7N4rDN58U0vYwnGHTzx9miu7xGhYfiafF4EFCYvG6SBple8sspIHESOCgMMRKOHvsUDTqlmazeZMwueeB+RYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkjYEf2R; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54529eeb38aso700812e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740053117; x=1740657917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THBQ8rmEsPvpqpvxaWqxGrUia96m2+SW0Egbj+rhtyc=;
        b=KkjYEf2ReTWgtIJBkDCBwq87Dj+CGPjoF/YyhJwCWODknT3jTsnRbBn17vTk9AgOgf
         6FkoPj3rN+S9RXO11PdknyuzaB/SO1Lil89oAIInxSMogoUkMimXFMuJKGe80vCHp+DH
         7lKJEHIkGfPY+NUlWGoWRz2i/baNOKOY6jkfN34XTNB5JLuQGt5bClRLmS9HFO23HjkL
         6UvrCN/1zDe2Ppm/Hj9CslLRuFpi7NZDH0UNX/e1TMPMKT+VdNqGXOIiR3TEysAPOQiN
         bt6DWyDZ/ozRu8cCty/SAs+9vE9uIxPu2cWu3YUXoPIlMI2f6FcaojHLvAdiRVAjy0Ik
         jQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053117; x=1740657917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THBQ8rmEsPvpqpvxaWqxGrUia96m2+SW0Egbj+rhtyc=;
        b=s6++z+EiQveCIxIf2QAK3zonMmgr5WL7WUvea2PU53g/EliReNnp7OtMn3n6on88M5
         J3oiS3lC+0GxNktXAipUeelyQh1AOg8+DewUpK3u7N/lRr7r9+q3Lzbdt7qEJXoATkNO
         IDXrY4DWpO1W5UXKkXZklEXteNgimwNnwGpV0APEP6jYLBeAvRCt+1Zq9j4mk13ju4yI
         kYpID5BU89PWytOs8IUw7f/5Nkh7GV04XXyxmqH8OMaz8wS4ujNy9SoCE3wBnAe3azIw
         h3YRPj0sKY6Dv+wvDLISzzT1slh7e3+nkyaO/BA+oqT+awyf+pX/OhTQxnf4AtcXh82n
         /BUw==
X-Forwarded-Encrypted: i=1; AJvYcCVRwUH7qN5PmcMhHA7lGeZrWmV2XMDOj+z+pNOTGzF8QoX2YnsX4Wz5EhbWbb0AonMXjo1NFzAs++7WVX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsyVFyzTwsVh6iGf2mBYJCQ/lBSzGfTj7XcUx5pGGYWL2/4Tg1
	QQPiUhidxTpNnWhMB4CsDxGs5mrWL7QcejkqEiW9b101jErtz1ne
X-Gm-Gg: ASbGncsYno7Pb5uhPiFuvavJrDYKI1dhDIpyqvHSdwzaYNhW4HEPqoXvKR490mkotZ0
	xoq2dkxmLx4jFyCHwTYpS4wcbjymvVBb2QzE66qZRFLpLOo1tsbUQ1Ix+a2Me/TPz4YGbloHb37
	h1ymGvvfbfld1Tb9YLMXDh5Wkm6YNuPv4s2VEPCXrrny4F8SZAaLLTKO8gCXi2qy0wT2a5UnCmw
	wAHyR8m+cYz/k+xajV51BCdfozNUEpwp6j4P5Kv4JRbkWfmHr8BtQMx+Wk1S327+Yt/O9I/W7AN
	FT1aayo5BtUyzDBV0PU7KUUNETYY9F+jsB1vrg==
X-Google-Smtp-Source: AGHT+IGU5Vj5wxkWmZvV2e5nDdV1F53jASdsNyEf9xpcKbnZG5GFBzqm4iMH2LcngNhowR1UMJ7hEg==
X-Received: by 2002:a05:6512:3da2:b0:545:2e76:495c with SMTP id 2adb3069b0e04-5462eef4ae8mr2656543e87.25.1740053117049;
        Thu, 20 Feb 2025 04:05:17 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461addb00esm1538710e87.198.2025.02.20.04.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:05:16 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 20 Feb 2025 13:05:13 +0100
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] mm/vmalloc: Gracefully unmap huge ptes
Message-ID: <Z7caeYrH6vKFCZgN@pc636>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-10-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140809.1702789-10-ryan.roberts@arm.com>

On Mon, Feb 17, 2025 at 02:08:01PM +0000, Ryan Roberts wrote:
> Commit f7ee1f13d606 ("mm/vmalloc: enable mapping of huge pages at pte
> level in vmap") added its support by reusing the set_huge_pte_at() API,
> which is otherwise only used for user mappings. But when unmapping those
> huge ptes, it continued to call ptep_get_and_clear(), which is a
> layering violation. To date, the only arch to implement this support is
> powerpc and it all happens to work ok for it.
> 
> But arm64's implementation of ptep_get_and_clear() can not be safely
> used to clear a previous set_huge_pte_at(). So let's introduce a new
> arch opt-in function, arch_vmap_pte_range_unmap_size(), which can
> provide the size of a (present) pte. Then we can call
> huge_ptep_get_and_clear() to tear it down properly.
> 
> Note that if vunmap_range() is called with a range that starts in the
> middle of a huge pte-mapped page, we must unmap the entire huge page so
> the behaviour is consistent with pmd and pud block mappings. In this
> case emit a warning just like we do for pmd/pud mappings.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/vmalloc.h |  8 ++++++++
>  mm/vmalloc.c            | 18 ++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 31e9ffd936e3..16dd4cba64f2 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -113,6 +113,14 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, uns
>  }
>  #endif
>  
> +#ifndef arch_vmap_pte_range_unmap_size
> +static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long addr,
> +							   pte_t *ptep)
> +{
> +	return PAGE_SIZE;
> +}
> +#endif
> +
>  #ifndef arch_vmap_pte_supported_shift
>  static inline int arch_vmap_pte_supported_shift(unsigned long size)
>  {
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a7e34e6936d2..68950b1824d0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -350,12 +350,26 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			     pgtbl_mod_mask *mask)
>  {
>  	pte_t *pte;
> +	pte_t ptent;
> +	unsigned long size = PAGE_SIZE;
>  
>  	pte = pte_offset_kernel(pmd, addr);
>  	do {
> -		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
> +#ifdef CONFIG_HUGETLB_PAGE
> +		size = arch_vmap_pte_range_unmap_size(addr, pte);
> +		if (size != PAGE_SIZE) {
> +			if (WARN_ON(!IS_ALIGNED(addr, size))) {
> +				addr = ALIGN_DOWN(addr, size);
> +				pte = PTR_ALIGN_DOWN(pte, sizeof(*pte) * (size >> PAGE_SHIFT));
> +			}
> +			ptent = huge_ptep_get_and_clear(&init_mm, addr, pte, size);
> +			if (WARN_ON(end - addr < size))
> +				size = end - addr;
> +		} else
> +#endif
> +			ptent = ptep_get_and_clear(&init_mm, addr, pte);
>  		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
> -	} while (pte++, addr += PAGE_SIZE, addr != end);
> +	} while (pte += (size >> PAGE_SHIFT), addr += size, addr != end);
>  	*mask |= PGTBL_PTE_MODIFIED;
>  }
>  
> -- 
> 2.43.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>


Uladzislau Rezki

