Return-Path: <linux-kernel+bounces-255919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0229346A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53B71F22D92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD32CCA3;
	Thu, 18 Jul 2024 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KimVJgmL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFE6138;
	Thu, 18 Jul 2024 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272597; cv=none; b=pLqvj8LxzQiuaUUR37xtEUxORH2m1ZIv2Ez9OdIhKWMMm7qjLjWy/FPfVqqi9j4IOAZM1lqBoc6+WRdkXi9FyEEKaR259T3aE96Gvy3878FQ0IWqePpW3GttyTPc3Cxq//Ymf1KaQJtrONmD4U7hZF5h+ODsoAaKu8BxyOPFILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272597; c=relaxed/simple;
	bh=v5q5/p0G/+33m7CBJg736C3hyR/Fq5UXFLxUE7GhW/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohmg5mj7QglJ7FZRCTJb0J2QOhdMh7qIqNqjOTccmANhDxmVDzkAdXtLG/3LJw0Jcku2iGohqA2DEwTkIjlEzwerwcafSgORuTP3k1RMFohKrlOZ/tJv9MKEZuBuTRUIwogujfPnBBZf6o3P0Uw1CqKIyt0FsPhynYKv+wl4gY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KimVJgmL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tXPglZwwvBJWWrCMOmH6w12w2LIkiUUmn9tD9p3ZAhY=; b=KimVJgmLlOshGb9X3rxu4gmg76
	m37PrvVBXwdBRpCT8SAfP6JygLD3m+ReiB2Dk7k7UNYVOQzVKbtuuAYbqQNwA9eMOxEKeQaNbq/WF
	vtYPP8D3+q1M84I1xhbR4MAQUD1swhgINhao2tVXPz9qeeZ2n7rTqu6n+fL3uFv+4+LJbtAviJFpx
	lGs5nMReJqU2KPFIDzvqxvpdmORzPBMNt2eiU/bbuIr1C9CLnwUmLbqqHN4fASmgS36mg1VaSQWTZ
	xZftpjrxyrGfyNrmXBfoJG41M+IoPxHlHDiMf00DYtqrk/vSCoj5mskU6kwtkamB97nh7uIq97EQO
	4Y+KXozA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUHd7-0000000Fbbn-16rf;
	Thu, 18 Jul 2024 03:16:29 +0000
Date: Wed, 17 Jul 2024 20:16:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
	chandan.babu@oracle.com, christian.koenig@amd.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <ZpiJDdqhDlAb8n6T@infradead.org>
References: <20240717222427.2211-1-dakr@kernel.org>
 <20240717222427.2211-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717222427.2211-2-dakr@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 18, 2024 at 12:24:01AM +0200, Danilo Krummrich wrote:
> +extern void * __must_check vrealloc_noprof(const void *p, size_t size,
> +					   gfp_t flags) __realloc_size(2);

No need for the extern here.

It would also help readability a bit to keep the __realloc_size on a
separate like, aka:

void *__must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
		__realloc_size(2);

> +	if (size <= old_size) {
> +		/* TODO: Can we optimize and shrink the allocation? What would
> +		 * be a good metric for when to shrink the vm_area?
> +		 */

Kernel comment style is to keep the

		/*

on a line of it's own.  A realloc that doesn't shrink is a bit
pointless.  The same heuristics as for krealloc should probably apply
here, adjust to the fact that we always deal with whole pages.


> +	/* TODO: Can we optimize and extend the existing allocation if we have
> +	 * enough contiguous space left in the virtual address space?
> +	 */

I don't understand this comment.

> +EXPORT_SYMBOL(vrealloc_noprof);

New interfaces should be EXPORT_SYMBOL_GPL.  That being said for this
to be added an exported we'll need an actual user to start with anyway.


