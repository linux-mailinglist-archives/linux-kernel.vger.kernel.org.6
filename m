Return-Path: <linux-kernel+bounces-243704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73230929965
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E582828188D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7A56766;
	Sun,  7 Jul 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg5l14D6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70D2E85E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720379091; cv=none; b=cbWWds3znr2h6VYicrvFEDm/RhH5OB4Ef4D8fEDNyxLrFLpePUF8WADffGQ3Ok0qSy5dYoJ8IaMwNbU3ILzO9ejMZUHFq2PttyCXrGU5x+ZU7c53FcNZvSYwpNEjaJ1hPmS9mB0huyTL99ZOvDEQ7VxPsyOkH7V6SVPmiWDO0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720379091; c=relaxed/simple;
	bh=X1MoMcv4ihI14QVx4/wOJq/twGd7U0UyjiqdjnaqMOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPSyxvXlTUk6+/RGDensGX+97IljkWPOYsa2uxlh9sJEhEGvdClDdxyknFGX+WH7ZHE8JHrr4FWlxUIxTVQX4SPU9mXssvDo3UTfWDV37vpDgBYrR79fQ+isZ0T/kVs61FMP0dJrASAhtyW6sbIlQJTBa2BQ6GNbi/otWWPmUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg5l14D6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720379089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkjOQU+aJaRi20NLE4drQggtIvxh43TsFHmIsrhDuZY=;
	b=Sg5l14D63/LjXo0CiWm2/+GdY27O0rD3csWbYHmvTu4GKrOi7Pucw1s6flGLYa+32PkY0R
	wnMi4ON8DW78YVT4j2MHZWO7KqT5bqrm2Uvgw/2U6Cu2+MW8p6UHciE2RZXDXh+h2p1i8k
	kTLclonH//6Seu2K65vdni1H3xPdt5U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-GuZJBXhQNBa4g4VQNbnkog-1; Sun,
 07 Jul 2024 15:04:47 -0400
X-MC-Unique: GuZJBXhQNBa4g4VQNbnkog-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA94D196CDF4;
	Sun,  7 Jul 2024 19:04:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 85BB319560AE;
	Sun,  7 Jul 2024 19:04:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Jul 2024 21:03:09 +0200 (CEST)
Date: Sun, 7 Jul 2024 21:03:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Mike Rapoport <rppt@kernel.org>,
	akpm@linux-foundation.org, brauner@kernel.org, mjguzik@gmail.com,
	tandersen@netflix.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_pages()
Message-ID: <20240707190304.GC11914@redhat.com>
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
 <Zoe4XN-gKJnjJtzi@kernel.org>
 <20240706012805.uuvysz2qgapgqj6p@master>
 <9f38e4f1-0ad3-4cd4-bcb7-5ec287859051@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f38e4f1-0ad3-4cd4-bcb7-5ec287859051@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

As I have already said, I can't review this patch.

But I am curious, why set_max_threads() is the only user of the new helper?
Say, should files_maxfiles_init() use it too or not? Perhaps the changelog
can explain this?

Thanks,

Oleg.

On 07/07, David Hildenbrand wrote:
>
> On 06.07.24 03:28, Wei Yang wrote:
> >On Fri, Jul 05, 2024 at 12:09:48PM +0300, Mike Rapoport wrote:
> >>On Wed, Jul 03, 2024 at 12:51:49AM +0000, Wei Yang wrote:
> >>>Instead of using raw memblock api, we wrap a new helper for user.
> >>
> >>The changelog should be more elaborate and explain why this function is
> >>needed.
> >>
> >>>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >>>---
> >>>  include/linux/memblock.h |  1 +
> >>>  mm/memblock.c            | 19 +++++++++++++++++++
> >>>  2 files changed, 20 insertions(+)
> >>>
> >>>diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >>>index 40c62aca36ec..7d1c32b3dc12 100644
> >>>--- a/include/linux/memblock.h
> >>>+++ b/include/linux/memblock.h
> >>>@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
> >>>  phys_addr_t memblock_phys_mem_size(void);
> >>>  phys_addr_t memblock_reserved_size(void);
> >>>+unsigned long memblock_estimated_nr_pages(void);
> >>>  phys_addr_t memblock_start_of_DRAM(void);
> >>>  phys_addr_t memblock_end_of_DRAM(void);
> >>>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> >>>diff --git a/mm/memblock.c b/mm/memblock.c
> >>>index e81fb68f7f88..c1f1aac0459f 100644
> >>>--- a/mm/memblock.c
> >>>+++ b/mm/memblock.c
> >>>@@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
> >>>  	return memblock.reserved.total_size;
> >>>  }
> >>>+/**
> >>>+ * memblock_estimated_nr_pages - return number of pages from memblock point of
> >>>+ * view
> >>
> >>This function returns the estimate for free pages, not the number of pages
> >>in RAM.
> >>
> >>How about memblock_estimated_nr_free_pages()?
> >>
> >>>+ * some calculation before all pages are freed to buddy system, especially
> >>>+ * when CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> >>
> >>I'm failing to parse this sentence. The return value here won't depend on
> >>CONFIG_DEFERRED_STRUCT_PAGE_INIT.
> >>
> >>>+ *
> >>>+ * At this point, we can get this information from memblock. Since the system
> >>>+ * state is not settle down and address alignment, the value is an estimation.
> >>>+ *
> >>>+ * Return:
> >>>+ * An estimated number of pages from memblock point of view.
> >>
> >>                            ^ free
> >>
> >>>+ */
> >>>+unsigned long __init memblock_estimated_nr_pages(void)
> >>>+{
> >>>+	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
> >>>+}
> >>>+
> >>>  /* lowest address */
> >>>  phys_addr_t __init_memblock memblock_start_of_DRAM(void)
> >>>  {
> >>>-- 
> >>>2.34.1
> >>>
> >
> >Thanks for review. Is this one looks better?
> >
> >Subject: [PATCH] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
> >
> >During bootup, system may need the number of free pages in the whole system
> >to do some calculation before all pages are freed to buddy system. Usually
> >this number is get from totalram_pages(). Since we plan to move the free
> >pages accounting in __free_pages_core(), this value may not represent
> >total free pages at the early stage, especially when
> >CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> >
> >Instead of using raw memblock api, let's introduce a new helper for user
> >to get the estimated number of free pages from memblock point of view.
> >
> >Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >CC: David Hildenbrand <david@redhat.com>
> >---
> >  include/linux/memblock.h |  1 +
> >  mm/memblock.c            | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >index 40c62aca36ec..7d1c32b3dc12 100644
> >--- a/include/linux/memblock.h
> >+++ b/include/linux/memblock.h
> >@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
> >  phys_addr_t memblock_phys_mem_size(void);
> >  phys_addr_t memblock_reserved_size(void);
> >+unsigned long memblock_estimated_nr_pages(void);
> >  phys_addr_t memblock_start_of_DRAM(void);
> >  phys_addr_t memblock_end_of_DRAM(void);
> >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> >diff --git a/mm/memblock.c b/mm/memblock.c
> >index e81fb68f7f88..00decc42e02b 100644
> >--- a/mm/memblock.c
> >+++ b/mm/memblock.c
> >@@ -1729,6 +1729,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
> >  	return memblock.reserved.total_size;
> >  }
> >+/**
> >+ * memblock_estimated_nr_free_pages - return estimated number of free pages
> >+ * from memblock point of view
> >+ *
> >+ * During bootup, system may need the number of free pages in the whole system
> >+ * to do some calculation before all pages are freed to buddy system. Usually
> >+ * this number is get from totalram_pages(). Since we plan to move the free
> >+ * pages accounting in __free_pages_core(), this value may not represent total
> >+ * free pages at the early stage, especially when > + * CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> 
> These historical details should be dropped. "Since we plan ..." will easily
> get outdated soon.
> 
> * During bootup, subsystems might need a rough estimate of the number of *
> free pages in the whole system, before precise numbers are available
> * from the buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the
> * numbers obtained from the buddy might be very imprecise during bootup.
> 
> ?
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


