Return-Path: <linux-kernel+bounces-527178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B1A40826
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F6D19C20C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B0A20AF7A;
	Sat, 22 Feb 2025 11:56:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC120AF6D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225408; cv=none; b=frbgLt5OmIFO+BTxK22jXi09vV13QrDXbOxfnCJ0HLCmNqRGb1cGfyCO241J65qVD99Vv//9T9qRwxZwFPDK+FrOD7IbcC5dhrgHlr2uASidFGLTLwdoOCHEJKqtIKp9TpZHSe7YRengrCOHhUAmktGgLLfeHNgwWNdyniN6WDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225408; c=relaxed/simple;
	bh=Qj0P/xDVIsaTi1wQhxrzNY7tf/z5/1wnR8B55/bmgb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kq+jS/kDnjA1CfpFTBNoZiyH9qYleMb2k5yqHjiv4k+tqZ5Xbx2/juMH8u0gGmMVo8EbXGNVKQFPoDP9kkFyKsQ3f/BII7ul66RR5lqjQFLychTXNcQ6nuZZYZ9YRxFf/Y0LLey/ZAbi9gL4qvuoo50J76mWROz6X3LUhY+FEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D3DC4CED1;
	Sat, 22 Feb 2025 11:56:45 +0000 (UTC)
Date: Sat, 22 Feb 2025 11:56:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v2 06/14] arm64/mm: Hoist barriers out of
 set_ptes_anysz() loop
Message-ID: <Z7m7e1W8LpYvV_h0@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-7-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140809.1702789-7-ryan.roberts@arm.com>

On Mon, Feb 17, 2025 at 02:07:58PM +0000, Ryan Roberts wrote:
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index e255a36380dc..e4b1946b261f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -317,10 +317,8 @@ static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
>  	WRITE_ONCE(*ptep, pte);
>  }
>  
> -static inline void __set_pte(pte_t *ptep, pte_t pte)
> +static inline void __set_pte_complete(pte_t pte)
>  {
> -	__set_pte_nosync(ptep, pte);
> -
>  	/*
>  	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
>  	 * or update_mmu_cache() have the necessary barriers.

Unrelated to this patch but I just realised that this comment is stale,
we no longer do anything in update_mmu_cache() since commit 120798d2e7d1
("arm64: mm: remove dsb from update_mmu_cache"). If you respin, please
remove the update_mmu_cache() part as well.

Thanks.

-- 
Catalin

