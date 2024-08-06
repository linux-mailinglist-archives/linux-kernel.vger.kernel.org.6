Return-Path: <linux-kernel+bounces-276177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4CD948F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791CC1F22F59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E8D1C461D;
	Tue,  6 Aug 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="SCE+sKVo"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC671DFC7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948627; cv=none; b=E1Qip+dqCh9HHNNfGx3uEQBVhU252m4VzWbzj0pv6QW3hjQyxFbnffRUNcr1B5HcUA51s1kwqhDNxb7/7l46y/rGQ6lg3ektMDpUnrHOMfdtAp6sOdSrwhNN2kFhFKm3+zWvGw1kpWQrD0atSkaKWLYy7GB+FPQmNV4o4OvkgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948627; c=relaxed/simple;
	bh=OMNNokSWIhWjatnSua94hQ0Tdvb0u2DzTMoj+bCaqqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rhp9C3h3jRoZHacCyq+s8Q/ugAnE+NY5lQCqs/FjoeFa/r8nzbauErIGH1h5iqMIrAR9xNN8tm2SXjYxLPwauPHrX32Mxce3+a3OjcX5pYKm7InBD019UdxHs1pPO/4ZbVdT5cFC8VQey3RITuTuBpHUgnWwtVKA5Jjc4vTZ32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=SCE+sKVo; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [213.235.133.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 2E5B81D3A2C;
	Tue,  6 Aug 2024 14:50:20 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722948620; bh=y6V3imBPTklgQg9pDb3ERB5uieHvs7IMBkapax2rleY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SCE+sKVoJK9wRiLzRNTOfiJn9tXWapLJX+9qKA60wTjhNwn0dgduoeQ0+QcvcdU/i
	 3y2BR26g15cQFJ1gOn86AN9mTYDBdIKRAeeoQJCj0KD+gqbrjJXTN43lZLxqHWoDgr
	 QEzZxA+Ye3BL9orS90/bZqutsT7DznSqQzDoGmEW15SOh+op9V1qQPG7a+LVAlxtKk
	 /mzX2b9brrw+yoHV8MfaHW6bZ+HwsfsnQExZGfpmpkd8J3G3ovErJk+zyZ01FztgRb
	 oRBcuDZG73BXYIZsuLDkvWCOJ1x+lj9xIh6rLw3Ht/m9rRP0zC1mtXTI+RPIu4JdFq
	 NSEeEYurgfuIg==
Date: Tue, 6 Aug 2024 14:50:14 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 03/10] mm: abstract duplicated policy comparison
Message-ID: <20240806145014.7e2c8557@mordecai.tesarici.cz>
In-Reply-To: <bf56244f473e6ac9378cfce420b51c4dac7783a7.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<bf56244f473e6ac9378cfce420b51c4dac7783a7.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:13:50 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Both can_vma_merge_before() and can_vma_merge_after() are invoked after
> checking for compatible VMA NUMA policy, we can simply move this to
> is_mergeable_vma() and abstract this altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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

Looks good.

Petr T

