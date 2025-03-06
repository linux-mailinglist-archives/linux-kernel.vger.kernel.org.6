Return-Path: <linux-kernel+bounces-549672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E9A55546
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943653ADD5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D3269CE8;
	Thu,  6 Mar 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i4KvGV7u"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3326D5C0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286709; cv=none; b=aqti6we5WW0JB9qOdyNmL697pf0tSxFROgyW4gjYVVNh1f3LuJdY83CnLZM5c+qUV+bxylsvZ8Fq3/ajvs+iQZKG63ckRNrkrblYegdUB7K1evxvKHApt0ZTvtm0hMriIpUJ8MTcaBW+IGDmeazAzy+GiLtr0tA6vljmdGov/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286709; c=relaxed/simple;
	bh=E6fUOgeux7kG3VuWbyjnZEP2/f/bAMiuVboTVqH2JPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etAOfzv3pgqG1qZPcxH2ziPEGQ2bGs8eNDvFPabZh0EH8SZE9+9D+BaHzSKWke7My4Jf3HExetx8RgdGkEuLwpuCG0feDVG7wsH5QOugONwK0EE2NTb6FR4xLnamDOfsHqyHPvnCdPfodTgaWodbdxIHJ5tgYDiu9nVi7/IBsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i4KvGV7u; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 10:45:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741286705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3hkf7euT/vaY2Nx8txG1P4pKgdK1/0zs8dcUAeUZimI=;
	b=i4KvGV7udlvq/n9zorZlenUNvq9v7B9hg5u+7HMPAvnmzR1HOH6ulDR+ov7mEFogwwlgVc
	2anmZpuEmOb+If/MpcMGpzzB2rRVgtXs8zfZbb5lH/ZuJO9MGzLWfS3Fry3yhGgQUPPhX/
	om70b0btLbq9PeUB4UonOTkCiD1EgBQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 09/16] mm/memory: split non-tlb flushing part from
 zap_page_range_single()
Message-ID: <7rnj5pt7uaftvvf6sqge4vowvcht7n4cqb4hxh3o6kzxtqumqi@p7ugsoqh6iiz>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-10-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-10-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:16:04AM -0800, SeongJae Park wrote:
> Some of zap_page_range_single() callers such as [process_]madvise() with
> MADV_DONEED[_LOCKED] cannot batch tlb flushes because
> zap_page_range_single() does tlb flushing for each invocation.  Split
> out core part of zap_page_range_single() except mmu_gather object
> initialization and gathered tlb entries flushing part for such batched
> tlb flushing usage.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/memory.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index a838c8c44bfd..aadb2844c701 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2011,38 +2011,46 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>  
> -/**
> - * zap_page_range_single - remove user pages in a given range
> - * @vma: vm_area_struct holding the applicable pages
> - * @address: starting address of pages to zap
> - * @size: number of bytes to zap
> - * @details: details of shared cache invalidation
> - *
> - * The range must fit into one VMA.
> - */
> -void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> +static void unmap_vma_single(struct mmu_gather *tlb,
> +		struct vm_area_struct *vma, unsigned long address,
>  		unsigned long size, struct zap_details *details)
>  {

Please add kerneldoc for this function and explicitly specify that tlb
can not be NULL. Maybe do that in the patch where you make it
non-static.

