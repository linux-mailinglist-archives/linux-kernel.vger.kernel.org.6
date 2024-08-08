Return-Path: <linux-kernel+bounces-279554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2E94BEDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54DB1C23030
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835118E77C;
	Thu,  8 Aug 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFk2Ttr9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E618E76C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125259; cv=none; b=f4u3cQls0T6K4Uom2icHW+VflxKFNdZX8oOwyCaI7/aA2phyNG3EzU47b+8TMSVxkUhcuPXk/2QXVhS8FWBfQ4vlTb4AB5DBkvjJmIuXePFBTXmo27Zl9uLBQ5/h2W6lCiSnUYBI7C/YBisxqtHkyZR+OLFQVI2Mg75H7Hm0ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125259; c=relaxed/simple;
	bh=E3mylxwK2j9dSfCDY8AmWwN5N773xPCqpltI8MuPpEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ki1ailf9mRlX6xIs4OmNYHVFq7ShEQs/ByDNw/WojWqx/fCGaLCPFFZoSg13tBxhBZME2HPhqbAhZIxqnvjHAFpW8dA1UZNxRTLZmUxQtogefk1yh0opYtFICFXaJQ285iYVNZ8n7bXi7vq8ZbLMS9ByGO1Dym3kJUUK7pDm1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFk2Ttr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2299FC32782;
	Thu,  8 Aug 2024 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723125259;
	bh=E3mylxwK2j9dSfCDY8AmWwN5N773xPCqpltI8MuPpEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uFk2Ttr9mb4WqqTaJmJBHVaswmH4ItcuY9NBFZZH6xzpuTIHzwXIG6JSZT6qAkSED
	 pYyTzZT2+edUKxvuyxRuM++V67zX/sGOSfM2p/g9YohlIGCkGYeq2ph9kRLgcqSnO+
	 Pen9tcTEf6KIkQBYwXSs+GlmeCc1cAR7ydnN+69/hY+ff+QjFoC77MohJYkGQLBI2F
	 vvsdFfzP/b6VhleaQ1cFbLlSVSVPSIh0upCAfWOTi1ZmzZMjVe81E41PWegvMo2HSk
	 fV4oCBYJ6rmEVZ+v+IAaGBoMEPeGk8p7hCSl+HesioXY4h4zNGtnDBjnnpK/0zDEWx
	 U0ZwAyzOIJcpQ==
Message-ID: <8afd879e-aa31-40ef-bc8e-1de4c9bd2e7e@kernel.org>
Date: Thu, 8 Aug 2024 15:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] mm: abstract duplicated policy comparison
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <bf56244f473e6ac9378cfce420b51c4dac7783a7.1722849859.git.lorenzo.stoakes@oracle.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <bf56244f473e6ac9378cfce420b51c4dac7783a7.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/24 14:13, Lorenzo Stoakes wrote:
> Both can_vma_merge_before() and can_vma_merge_after() are invoked after
> checking for compatible VMA NUMA policy, we can simply move this to
> is_mergeable_vma() and abstract this altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 8 +++-----
>  mm/vma.c  | 9 ++++-----
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f931000c561f..721ced6e37b0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1422,8 +1422,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
> -	if (next && next->vm_start == end && !vma_policy(next) &&
> -	    can_vma_merge_before(&vmg)) {
> +	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
>  		merge_end = next->vm_end;
>  		vma = next;
>  		vmg.pgoff = next->vm_pgoff - pglen;
> @@ -1435,8 +1434,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	}
>  
>  	/* Check prev */
> -	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> -	    can_vma_merge_after(&vmg)) {
> +	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
>  		merge_start = prev->vm_start;
>  		vma = prev;
>  		vmg.pgoff = prev->vm_pgoff;
> @@ -1798,7 +1796,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Expand the existing vma if possible; Note that singular lists do not
>  	 * occur after forking, so the expand will only happen on new VMAs.
>  	 */
> -	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> +	if (vma && vma->vm_end == addr) {
>  		struct vma_merge_struct vmg = {
>  			.prev = vma,
>  			.flags = flags,
> diff --git a/mm/vma.c b/mm/vma.c
> index 20c4ce7712c0..b452b472a085 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -19,6 +19,8 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
>  	 */
>  	bool may_remove_vma = merge_next;
>  
> +	if (!mpol_equal(vmg->policy, vma_policy(vma)))
> +		return false;
>  	/*
>  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
>  	 * match the flags but dirty bit -- the caller should mark
> @@ -971,17 +973,14 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  		vma_pgoff = prev->vm_pgoff;
>  
>  		/* Can we merge the predecessor? */
> -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> -		    && can_vma_merge_after(vmg)) {
> -
> +		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
>  			merge_prev = true;
>  			vma_prev(vmg->vmi);
>  		}
>  	}
>  
>  	/* Can we merge the successor? */
> -	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> -	    can_vma_merge_before(vmg)) {
> +	if (next && can_vma_merge_before(vmg)) {
>  		merge_next = true;
>  	}
>  


