Return-Path: <linux-kernel+bounces-280054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D497694C518
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A94B23A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19978146D68;
	Thu,  8 Aug 2024 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZaKjK30"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6E1EEE4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723144521; cv=none; b=JDBIuZTWDpvcwnHEApBi4RKSiDS6IlH9nd3guQ8kwCcdi0s9uRgjfrAPtU1Z2g6g+ZQV86RTXwK3YFJC9jQrsNK3YZ7heJkODm7VF4k7ZSi9V3giaJTLJ3g6cimzLBRWUSTZc8Sah1sADjF6idVr/RopCqVuFCR/oyZ0k0rWLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723144521; c=relaxed/simple;
	bh=Rv/WL+sLLz5VAVZbeL+2Ym1uAPgOCY9/ZFNov9C5EdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv39SlPF94ut6Ufsx56NB+6XcioJc5NZNW4SUB8gzMkkIH+PTcWxiFPYgBncEo96bIA/ahcv2hVUWVuWNrqrrL7UXUGVbYg126ZmCqRn4lJqDqRTlnQPc0dS7kfRB5GjLdyq0BwVZlfyzACciG1uuJvefcPT2w7TgX+6mNrcYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TZaKjK30; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ds1AwY8Q+l6/8NrnY0ArKbT9/zlZWzHPWHwrnDuE+qU=; b=TZaKjK3065Lqzp3iwnAjh4vGBm
	j/LJ2l7K85rRNCs4vza+w/qLoXbiKOPCZG2ySy62O2kGo+DoQ2tY8J3tlAYgAdEwnSq99LgiQ4Nv+
	cO+x8nhfUzMASoVH7aAJJH95vvQ0g66Q7IlmNeYAmqVWXQ4s6O37faPc2CnwjLTklsjYfccX0rFOP
	Tn/8yY/sAsLlP0Io53WQh9CPKiAbL0PJ0HyY0ZcX0ZSKbkQvPkGZX7tYyo8+3LFU3H3d9zkYRuf/C
	2rYhWSUsyqFscXpw5w3Ez3vOrdrQ4kkZx3VDbf3mwVAWqCoWg/s68+PlZRqaKGG59njAY5VcfKMbQ
	LaGt+VTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc8bN-00000009I3i-16Kl;
	Thu, 08 Aug 2024 19:15:09 +0000
Date: Thu, 8 Aug 2024 20:15:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com
Subject: Re: [PATCH 1/2] maple_tree: add test to replicate low memory race
 conditions
Message-ID: <ZrUZPWZVbA-2OBaV@casper.infradead.org>
References: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808163000.25053-1-sidhartha.kumar@oracle.com>

On Thu, Aug 08, 2024 at 12:29:59PM -0400, Sidhartha Kumar wrote:
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index aa3a5df15b8e..65fba37ef999 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6997,6 +6997,18 @@ void mt_set_non_kernel(unsigned int val)
>  	kmem_cache_set_non_kernel(maple_node_cache, val);
>  }
>  
> +extern void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *));
> +void mt_set_callback(void (*callback)(void *))
> +{
> +	kmem_cache_set_callback(maple_node_cache, callback);
> +}
> +
> +extern void kmem_cache_set_private(struct kmem_cache *cachep, void *private);
> +void mt_set_private(void *private)
> +{
> +	kmem_cache_set_private(maple_node_cache, private);
> +}
> +
>  extern unsigned long kmem_cache_get_alloc(struct kmem_cache *);
>  unsigned long mt_get_alloc_size(void)
>  {

This should surely not be in lib/maple_tree.c ...

