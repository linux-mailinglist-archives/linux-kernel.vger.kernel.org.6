Return-Path: <linux-kernel+bounces-241625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68B927D41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558CE1C22016
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664857347A;
	Thu,  4 Jul 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PWhx7M6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A345979
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118440; cv=none; b=rc4dHDhgGlwS00gR/UNVmIIzL8a0jV1NLhXHcC7z+zj7f5M/NDMRwQK/DxsEvJ7pwSKenlJmJ+V4RTSEr1qsHxkmd5C2p1/Mfk4WKUY1w1B48QUVQNpTYj08aKruPYnb1dK+UP+QT1rEpORO66aRKJdhvwKhKp5kx9gdfgvDWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118440; c=relaxed/simple;
	bh=nhg+Bi09+TPPdWbw61GDrYuj2tqg++lywQVcHOgIO+g=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r8rmKFHO7sPVkDns/Pbeebg2B42+6F8PEQfd78e8qlaCI+UmYvJk7vh3CIXm/u7SztIDxfDX7J41dOB/vBB0EpAZ0ulukncHhGXq1MR6Cx4ZndCJetFyDT/jNTDEm6o7oDrpRZplfthxydjAe+tlV71LDd5BBybDgL9+WpHtkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PWhx7M6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AE0C3277B;
	Thu,  4 Jul 2024 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720118440;
	bh=nhg+Bi09+TPPdWbw61GDrYuj2tqg++lywQVcHOgIO+g=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=PWhx7M6v0H2jvvAPaDzQTKcyjy7tQ7/R70XHudmBNfID8Iwa3Ke30BBG3P15WknlF
	 Thx3VYDp4lK0pz5NWTFj+58PzZX/RQJfhs1hAiai4R7nspy0ko3cF4B38zUjJXvPf8
	 66FLDn8uVLDBx6YLribdSAENqz4UX8cwm6SdvZDM=
Date: Thu, 4 Jul 2024 11:40:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peng Zhang <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
 <ying.huang@intel.com>, <fengwei.yin@intel.com>, <david@redhat.com>,
 <aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
 <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH] filemap: replace pte_offset_map() with
 pte_offset_map_nolock()
Message-Id: <20240704114039.4fd0739593cd0a96fe428496@linux-foundation.org>
In-Reply-To: <20240625140643.bf4a1a19b0d534d802764610@linux-foundation.org>
References: <20240313012913.2395414-1-zhangpeng362@huawei.com>
	<20240625140643.bf4a1a19b0d534d802764610@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 14:06:43 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 13 Mar 2024 09:29:13 +0800 Peng Zhang <zhangpeng362@huawei.com> wrote:
> 
> > From: ZhangPeng <zhangpeng362@huawei.com>
> > 
> > The vmf->ptl in filemap_fault_recheck_pte_none() is still set from
> > handle_pte_fault(). But at the same time, we did a pte_unmap(vmf->pte).
> > After a pte_unmap(vmf->pte) unmap and rcu_read_unlock(), the page table
> > may be racily changed and vmf->ptl maybe fails to protect the actual
> > page table.
> > Fix this by replacing pte_offset_map() with pte_offset_map_nolock().
> > 
> > ...
> >
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3207,7 +3207,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
> >  	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
> >  		return 0;
> >  
> > -	ptep = pte_offset_map(vmf->pmd, vmf->address);
> > +	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
> > +				     &vmf->ptl);
> >  	if (unlikely(!ptep))
> >  		return VM_FAULT_NOPAGE;
> >  
> 
> whoops, I'm still sitting on this because I didn't know whether we
> should backport it.
> 
> And...  guess what I say next.  Can we please describe what are the
> userspace visible effects of the bug?
> 

Nobody?

Oh well, I'll add cc:stable amd move this into mm-hotfixes.


From: ZhangPeng <zhangpeng362@huawei.com>
Subject: filemap: replace pte_offset_map() with pte_offset_map_nolock()
Date: Wed, 13 Mar 2024 09:29:13 +0800

The vmf->ptl in filemap_fault_recheck_pte_none() is still set from
handle_pte_fault().  But at the same time, we did a pte_unmap(vmf->pte). 
After a pte_unmap(vmf->pte) unmap and rcu_read_unlock(), the page table
may be racily changed and vmf->ptl maybe fails to protect the actual page
table.  Fix this by replacing pte_offset_map() with
pte_offset_map_nolock().

Link: https://lkml.kernel.org/r/20240313012913.2395414-1-zhangpeng362@huawei.com
Fixes: 58f327f2ce80 ("filemap: avoid unnecessary major faults in filemap_fault()")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/filemap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/filemap.c~filemap-replace-pte_offset_map-with-pte_offset_map_nolock
+++ a/mm/filemap.c
@@ -3231,7 +3231,8 @@ static vm_fault_t filemap_fault_recheck_
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map(vmf->pmd, vmf->address);
+	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
+				     &vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
 
_


