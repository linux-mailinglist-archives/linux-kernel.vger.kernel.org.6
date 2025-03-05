Return-Path: <linux-kernel+bounces-546473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABBA4FB16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A6188DE6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91A205AAB;
	Wed,  5 Mar 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Viv6OaeD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB2204F8E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168968; cv=none; b=e0w0G0XpXKA6+aMgHB0BIYb7MlVwQmIi8MAZFVI2q6B8s+d9fvb3L+MJastbjr0RRgcl7HhYZxHC2Jd9d9NsOURYyfp0peKlkap74OrOODvwk2fpXbEl8PcvbqA0fTjEwnj304eNK81+Q0BQyWBNsQwk6GnYET2UEpfq1ZLcufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168968; c=relaxed/simple;
	bh=mmktcQvaAaxjJ58+pq7rtgtn+dxe+ysiWTRYTE8jI4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKUKk9aTAWko7sWlfnbYYk9TpmHZtXj9NXnNWfuVotDUY4WxBZoGw3o1JUAfb5WsWbzEjJfLQGicKBNQCfINx21xPc04giYiN+Rh7OLphWkJwArcEe1QjL+QUZreM9mrhzS6WA8sy8xZpSypEyyHhPacu9rbcKz7g0caChpv/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Viv6OaeD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741168965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW7+rAgDKlzOI88XIbHmS2aOHp/CrzdKRrtFKo42XLM=;
	b=Viv6OaeDRJSOzLiaY3M9vuCXkcT4Cg2tAWgB0GBsirtwYOSsQvE5XLK1/sG4bPGkrgVHd0
	ruLXDqk230j85DGzeA71JRW2LK7YaZ68HpwUkCubYJO55qhMKuvWXwGa660w1TQevyfd5/
	gIs41ykS8JJhdDT9+jeCqXBuqjUrCC4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-um8LX2hKPjinaZv39n2qug-1; Wed,
 05 Mar 2025 05:02:30 -0500
X-MC-Unique: um8LX2hKPjinaZv39n2qug-1
X-Mimecast-MFC-AGG-ID: um8LX2hKPjinaZv39n2qug_1741168948
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C08B1954B36;
	Wed,  5 Mar 2025 10:02:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47A2A193EFD8;
	Wed,  5 Mar 2025 10:02:25 +0000 (UTC)
Date: Wed, 5 Mar 2025 18:02:19 +0800
From: Baoquan He <bhe@redhat.com>
To: liuye <liuye@kylinos.cn>
Cc: Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
	hch@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/vmalloc: Remove unnecessary size ALIGN in
 __vmalloc_node_range_noprof
Message-ID: <Z8ghK22l7USzuBWY@MiWiFi-R3L-srv>
References: <20250303094410.437985-1-liuye@kylinos.cn>
 <20250303094410.437985-2-liuye@kylinos.cn>
 <Z8X1U-3f35-JZTUr@pc636>
 <6701d375-8d7c-4e13-b0db-486a48088446@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6701d375-8d7c-4e13-b0db-486a48088446@kylinos.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/05/25 at 09:46am, liuye wrote:
> 
> 在 2025/3/4 02:30, Uladzislau Rezki 写道:
> > On Mon, Mar 03, 2025 at 05:44:07PM +0800, Liu Ye wrote:
> >> The same operation already exists in the function __get_vm_area_node,
> >> so delete the duplicate operation to simplify the code.
> >>
> >> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> >> ---
> >>  mm/vmalloc.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index dc658d4af181..20d9b9de84b1 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -3798,7 +3798,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> >>  			shift = arch_vmap_pte_supported_shift(size);
> >>  
> >>  		align = max(real_align, 1UL << shift);
> >> -		size = ALIGN(real_size, 1UL << shift);
> >>  	}
> >>  
> >>  again:
> >> -- 
> >> 2.25.1
> >>
> > There is a mess with:
> >
> >  unsigned long real_size = size;
> >  unsigned long real_align = align;
> >
> > "real_size" and "real_align". Those are useless. What is about:
> 
> Sorry, the order of the patches may be misleading.
> 
> The correct order is as follows：
> 
> PATCH1.  mm/vmalloc: Size should be used instead of real_size "
> PATCH2.  mm/vmalloc: Remove unnecessary size ALIGN in __vmalloc_node_range_noprof                 
> PATCH3.  mm/vmalloc: Remove the real_size variable to simplify the code "
> PATCH4.  mm/vmalloc: Rename the variable real_align to original_align to prevent misunderstanding
> 
> If PATCH1 is the correct fix, then consider PATCH2, PATCH3, and PATCH4.

Well, seems the patch split is done too subtly. It's only about the
size/align inside one function, maybe one patch is enough in this case.
My personal opinion.

> 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5c88d0e90c20..a381ffee1595 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3771,8 +3771,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> >  	struct vm_struct *area;
> >  	void *ret;
> >  	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
> > -	unsigned long real_size = size;
> > -	unsigned long real_align = align;
> >  	unsigned int shift = PAGE_SHIFT;
> >  
> >  	if (WARN_ON_ONCE(!size))
> > @@ -3781,7 +3779,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> >  	if ((size >> PAGE_SHIFT) > totalram_pages()) {
> >  		warn_alloc(gfp_mask, NULL,
> >  			"vmalloc error: size %lu, exceeds total pages",
> > -			real_size);
> > +			size);
> >  		return NULL;
> >  	}
> >  
> > @@ -3798,19 +3796,18 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> >  		else
> >  			shift = arch_vmap_pte_supported_shift(size);
> >  
> > -		align = max(real_align, 1UL << shift);
> > -		size = ALIGN(real_size, 1UL << shift);
> > +		align = max(align, 1UL << shift);
> >  	}
> >  
> >  again:
> > -	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
> > +	area = __get_vm_area_node(size, align, shift, VM_ALLOC |
> >  				  VM_UNINITIALIZED | vm_flags, start, end, node,
> >  				  gfp_mask, caller);
> >  	if (!area) {
> >  		bool nofail = gfp_mask & __GFP_NOFAIL;
> >  		warn_alloc(gfp_mask, NULL,
> >  			"vmalloc error: size %lu, vm_struct allocation failed%s",
> > -			real_size, (nofail) ? ". Retrying." : "");
> > +			size, (nofail) ? ". Retrying." : "");
> >  		if (nofail) {
> >  			schedule_timeout_uninterruptible(1);
> >  			goto again;
> > @@ -3860,7 +3857,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> >  	    (gfp_mask & __GFP_SKIP_ZERO))
> >  		kasan_flags |= KASAN_VMALLOC_INIT;
> >  	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
> > -	area->addr = kasan_unpoison_vmalloc(area->addr, real_size, kasan_flags);
> > +	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
> >  
> >  	/*
> >  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> > @@ -3878,8 +3875,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> >  fail:
> >  	if (shift > PAGE_SHIFT) {
> >  		shift = PAGE_SHIFT;
> > -		align = real_align;
> > -		size = real_size;
> >  		goto again;
> >  	}
> >  
> > ?
> >
> > --
> > Uladzislau Rezki
> 


