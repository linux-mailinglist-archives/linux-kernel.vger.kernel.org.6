Return-Path: <linux-kernel+bounces-262119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4D93C0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E7E282952
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28314199243;
	Thu, 25 Jul 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJLcSc9q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AC16D4C3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907561; cv=none; b=MzLhY4Gji5gZTxmMdh8lwjMkH0CFuC435t6KJZnulHLEbqIYlb3LDi7N1Jdn7zJNSUmwgjeL9pSn9GYq+F+2s0iafswtYiHUTjFhtsao/G6+bnxlNxdSpEg+cxOGTjoEKoPyUOTwhLWlLk6CBm3XFRTYNfyD88oVHucK1gBubDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907561; c=relaxed/simple;
	bh=8ZfUZAq6XdkrQiyQrPe6P1AmF2ujJI33OZ6ila6gD1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMgWuhjf2MONkfrlkYX7KMGnZ2nE+g6A1QeRH7YE32VYdGCVIQCNbmNBUJmTTL4GmwWITDYjzvyxEcaNY49seKVDCsCrdXewthlf2BCmkqdlwV/Tswb75se5XrJmIdAc6SV9+z72hR9+GlHO7Ib/P1DuhPrFHHPsxQuQPGyEk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJLcSc9q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721907558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGbeiqKRT+tHcz5I4U4+03vVdQrB/TWsSocFYpZneWA=;
	b=VJLcSc9qL72TEz7DXrzlwSMlPyJs327RU5t8lW/uv0dUyKkB3YMxo0jZGcEBWQSobfJFvT
	V/AJST56bZmj/slJr2Do+e4bGiXNTt+HqzS/Mrecyy31jyaDmzZl6PtdzMwpJ79lPJr+Wp
	ReqEbKRYORJelIOVO+98IX8K9Q7xaK0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-92xIQx3xP2GvFj0tQGUHpA-1; Thu,
 25 Jul 2024 07:39:12 -0400
X-MC-Unique: 92xIQx3xP2GvFj0tQGUHpA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060E21955D4D;
	Thu, 25 Jul 2024 11:39:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 194243000194;
	Thu, 25 Jul 2024 11:39:07 +0000 (UTC)
Date: Thu, 25 Jul 2024 19:39:03 +0800
From: Baoquan He <bhe@redhat.com>
To: hailong.liu@oppo.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
References: <20240725035318.471-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725035318.471-1-hailong.liu@oppo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/25/24 at 11:53am, hailong.liu@oppo.com wrote:
> From: "Hailong.Liu" <hailong.liu@oppo.com>
> 
> The scenario where the issue occurs is as follows:
> CONFIG: vmap_allow_huge = true && 2M is for PMD_SIZE
> kvmalloc(2M, __GFP_NOFAIL|GFP_XXX)
>     __vmalloc_node_range(vm_flags=VM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=9) --->allocs order9 failed and fallback to order0
>                                         and phys_addr is aligned with PMD_SIZE
>             vmap_pages_range
>                 vmap_pages_range_noflush
>                     __vmap_pages_range_noflush(page_shift = 21) ----> incorrect vmap *huge* here
> 
> In fact, as long as page_shift is not equal to PAGE_SHIFT, there
> might be issues with the __vmap_pages_range_noflush().
> 
> The patch also remove VM_ALLOW_HUGE_VMAP in kvmalloc_node(), There
> are several reasons for this:
> - This increases memory footprint because ALIGNMENT.
> - This increases the likelihood of kvmalloc allocation failures.
> - Without this it fixes the origin issue of kvmalloc with __GFP_NOFAIL may return NULL.
> Besides if drivers want to vmap huge, user vmalloc_huge instead.

Seem there are two issues you are folding into one patch:

one is the wrong informatin passed into __vmap_pages_range_noflush();
the other is you want to take off VM_ALLOW_HUGE_VMAP on kvmalloc().

About the 1st one, do you think below draft is OK to you?

Pass out the fall back order and adjust the order and shift for later
usage, mainly for vmap_pages_range().

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 260897b21b11..5ee9ae518f3d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3508,9 +3508,9 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
 
 static inline unsigned int
 vm_area_alloc_pages(gfp_t gfp, int nid,
-		unsigned int order, unsigned int nr_pages, struct page **pages)
+		unsigned int *page_order, unsigned int nr_pages, struct page **pages)
 {
-	unsigned int nr_allocated = 0;
+	unsigned int nr_allocated = 0, order = *page_order;
 	gfp_t alloc_gfp = gfp;
 	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
@@ -3611,6 +3611,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		cond_resched();
 		nr_allocated += 1U << order;
 	}
+	*page_order = order;
 
 	return nr_allocated;
 }
@@ -3654,7 +3655,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	page_order = vm_area_page_order(area);
 
 	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
-		node, page_order, nr_small_pages, area->pages);
+		node, &page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	if (gfp_mask & __GFP_ACCOUNT) {
@@ -3686,6 +3687,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
+
+	set_vm_area_page_order(area, page_order);
+	page_shift = page_order + PAGE_SHIFT;
+
 	/*
 	 * page tables allocations ignore external gfp mask, enforce it
 	 * by the scope API


