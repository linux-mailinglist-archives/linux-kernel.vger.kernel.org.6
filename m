Return-Path: <linux-kernel+bounces-276291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39599491C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A81F2245A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEBE1D2F5A;
	Tue,  6 Aug 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="MqFfp6uY"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5419F464
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951685; cv=none; b=i/X7b/lgFV8mgka+FXUMRaJqJmRV7ZHNt1CZy15aSZoU+cmZPnzbU6freVy1YwMVFN0wqMKtrwunMumhr9ntHbiHqaVf+m5xA/ntUfylCOlV3kGz1fbE40vAT4aJLlowrXNvDjUIcMW7oy/XjqMp4v/rY9rr+i41zszFq6W4qgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951685; c=relaxed/simple;
	bh=j5JvmOSunPkdJ8OgcG76KzviB2w8YucMua34byJeVy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvlVsjAtsQzP7G0U0fqc+bwYaAxRnEDVXcfoYXQKFjZkZZPNXntX5ntPiYhB2hYVdYvaUO42RiYhnQNs5PafNqeES8Lb4ZeEDocD9ExIahaNK9M6nVgjqxZtzDxb7UhX6bsphzcZdNt9O+Hn9SG5GOS3POOHh8s2rlvyjDP9CG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=MqFfp6uY; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 50B781D39A7;
	Tue,  6 Aug 2024 15:41:21 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722951681; bh=6iMtQdqxuJXos0Mg28nQjzB+f3b8f9BkSrZ+fyn8iGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MqFfp6uYt6c/v+y0QykSCU+rzOBOLpT7tevu6dv85jxkogcw1OsCIoiWbyCR27BSj
	 dl3xY24gNJwxC/tu12MrEtI4jmpw+4T0n6p641AuGGkjFfdzkk1Uky182ZeAN86GX/
	 vu2n5KKWhNGhSkUVyFmTVFJjsKfg/EVViQrFE8+IEcdmewjqaf9II+HHQxE4yLwiBQ
	 vMjMClZyVXSHu67/tEsUCvSDAyG1EZKNHoRhgvaDR8o+JXNcIImISHhHzsG8hVAEF7
	 gkTYspdo7OJLEfr9F1AQzV+8XBD48Hczm8NuXCe+Esk/qpieaFdEGncYQ1SGf5SP1c
	 nQ7NWSXHBHUdA==
Date: Tue, 6 Aug 2024 15:41:16 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge
 operation
Message-ID: <20240806154116.015e329a@mordecai.tesarici.cz>
In-Reply-To: <3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:13:55 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Pull this operation into its own function and have vma_expand() call
> commit_merge() instead.
> 
> This lays the groundwork for a subsequent patch which replaces vma_merge()
> with a simpler function which can share the same code.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index a404cf718f9e..b7e3c64d5d68 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
>  }
>  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
>  
> +/* Actually perform the VMA merge operation. */
> +static int commit_merge(struct vma_merge_struct *vmg,
> +			struct vm_area_struct *adjust,
> +			struct vm_area_struct *remove,
> +			struct vm_area_struct *remove2,
> +			long adj_start,
> +			bool expanded)
> +{
> +	struct vma_prepare vp;
> +
> +	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
> +
> +	if (expanded) {
> +		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> +	} else {
> +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> +				adjust->vm_end);
> +	}

It's hard to follow the logic if you the "expanded" parameter is always
true. I have to look at PATCH 09/10 first to see how it is expected to
be used. Is there no other way?

Note that this is not needed for adjust and adj_start, because they are
merely moved here from vma_expand() and passed down as parameters to
other functions.

Petr T

> +
> +	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
> +		return -ENOMEM;
> +
> +	vma_prepare(&vp);
> +	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
> +	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
> +
> +	if (expanded)
> +		vma_iter_store(vmg->vmi, vmg->vma);
> +
> +	if (adj_start) {
> +		adjust->vm_start += adj_start;
> +		adjust->vm_pgoff += PHYS_PFN(adj_start);
> +		if (adj_start < 0) {
> +			WARN_ON(expanded);
> +			vma_iter_store(vmg->vmi, adjust);
> +		}
> +	}
> +
> +	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
> +
> +	return 0;
> +}
> +
>  /*
>   * vma_merge_new_vma - Attempt to merge a new VMA into address space
>   *
> @@ -700,7 +743,6 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	bool remove_next = false;
>  	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *next = vmg->next;
> -	struct vma_prepare vp;
>  
>  	vma_start_write(vma);
>  	if (next && (vma != next) && (vmg->end == next->vm_end)) {
> @@ -713,24 +755,15 @@ int vma_expand(struct vma_merge_struct *vmg)
>  			return ret;
>  	}
>  
> -	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
>  	/* Not merging but overwriting any part of next is not handled. */
> -	VM_WARN_ON(next && !vp.remove &&
> +	VM_WARN_ON(next && !remove_next &&
>  		  next != vma && vmg->end > next->vm_start);
>  	/* Only handles expanding */
>  	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
>  
> -	/* Note: vma iterator must be pointing to 'start' */
> -	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> -	if (vma_iter_prealloc(vmg->vmi, vma))
> +	if (commit_merge(vmg, NULL, remove_next ? next : NULL, NULL, 0, true))
>  		goto nomem;
>  
> -	vma_prepare(&vp);
> -	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
> -	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> -	vma_iter_store(vmg->vmi, vma);
> -
> -	vma_complete(&vp, vmg->vmi, vma->vm_mm);
>  	return 0;
>  
>  nomem:


