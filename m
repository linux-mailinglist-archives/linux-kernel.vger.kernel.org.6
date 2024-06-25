Return-Path: <linux-kernel+bounces-229702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC69172EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446761C226F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03317D36B;
	Tue, 25 Jun 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lVVNBFfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD74AEF6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349604; cv=none; b=SgVdrE++CLcrji9rT7rHRilPV54gqPxIQiC1/0I3YSAdyU+3v9u5/nte1VNGhnDxzb6hYeZBv4JfR+56OYC3Dmiry81wtNIls9qpD4NykBaZ3X2MynzTIZrtksRtDXZW8DNHT0W1mJiYDZmd7e8C0sAIpj9h+zKcSqiO7DXJ7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349604; c=relaxed/simple;
	bh=+KnjK9trO45Vte3HPQ/KyvbGs29+mNHnsqriXN2aw54=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fqYVqK9tls3ghs8CidnL8YOLtD7aI+kvr7k5x1xt5km8OSQ0qrM9VdEb3g22MnUy3vb7DES1QtXIyBwSjUAgEL4FpbuJULmUrpE8CkSkD4s2asCrxsUSNgaMMTeGA3djm32Lk7nCt5vNHn9ME78/Nm8TxzjjdLNEGoVmZpsKeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lVVNBFfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1B0C32781;
	Tue, 25 Jun 2024 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719349604;
	bh=+KnjK9trO45Vte3HPQ/KyvbGs29+mNHnsqriXN2aw54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVVNBFfmth+dtWyl6uliVwssxGOrcmuCM84uUz46PtSf6FN5gIQaRiEOsmIxVpsLm
	 LW/Te0JY3B+HcZ2MdHVxQdg7ste/Q7XofWLTaDhXM9y+F8Dn26w92bpuX18mZQUD0I
	 z0+u2x5fdY4lJF7rktGCuB/HDd0kdPzGV2NNY1u4=
Date: Tue, 25 Jun 2024 14:06:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <willy@infradead.org>, <ying.huang@intel.com>, <fengwei.yin@intel.com>,
 <david@redhat.com>, <aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>,
 <hughd@google.com>, <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH] filemap: replace pte_offset_map() with
 pte_offset_map_nolock()
Message-Id: <20240625140643.bf4a1a19b0d534d802764610@linux-foundation.org>
In-Reply-To: <20240313012913.2395414-1-zhangpeng362@huawei.com>
References: <20240313012913.2395414-1-zhangpeng362@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 09:29:13 +0800 Peng Zhang <zhangpeng362@huawei.com> wrote:

> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The vmf->ptl in filemap_fault_recheck_pte_none() is still set from
> handle_pte_fault(). But at the same time, we did a pte_unmap(vmf->pte).
> After a pte_unmap(vmf->pte) unmap and rcu_read_unlock(), the page table
> may be racily changed and vmf->ptl maybe fails to protect the actual
> page table.
> Fix this by replacing pte_offset_map() with pte_offset_map_nolock().
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3207,7 +3207,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>  	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
>  		return 0;
>  
> -	ptep = pte_offset_map(vmf->pmd, vmf->address);
> +	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
> +				     &vmf->ptl);
>  	if (unlikely(!ptep))
>  		return VM_FAULT_NOPAGE;
>  

whoops, I'm still sitting on this because I didn't know whether we
should backport it.

And...  guess what I say next.  Can we please describe what are the
userspace visible effects of the bug?


