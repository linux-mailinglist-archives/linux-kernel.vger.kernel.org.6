Return-Path: <linux-kernel+bounces-361650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34799AAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510861C21D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BAF19AD97;
	Fri, 11 Oct 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="DksTBdiE"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A791E529
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670537; cv=none; b=UB7fqpjYUHS3E4JIkt8xNnYQJHQwG+P3F4QW0WAVd5IH8aot0TIf8+FL7Xx5nOJI+8SzcaIR+gscSaY3Jzs2saLxohE8U2scS8s3KAQMVFtP4H9YROTuKeLTvdwcyHknbqaCZLnS9cclCpYcAcEqkBEJe+NF3Ghzu9aS8sSnpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670537; c=relaxed/simple;
	bh=jN72lK63r7hiXDJA6UaJSN5EUVaw0AcWfoPw0fLqre8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Oc4MP6bAn/OFmQZzbNYh+PM42MVzODdpdt2mympScksYOh1bvZdIhUeN6vYxTIVcNEVVMhwIU3KkrAnX6JkPEystUI0HnNe4KLEGUa1Ob1CE614Kc+AXxNQfKtQyYAmMBzfyCQH690Mh9cmRcYiWtjT4QXc6rRaxIe9ExRTLWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=DksTBdiE; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1728670064;
	bh=jN72lK63r7hiXDJA6UaJSN5EUVaw0AcWfoPw0fLqre8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DksTBdiExM67haKxoZ3ghjy6kj3KhEHmEdeC4IKsLp5uN4tlb5XmYLsCDgTjTg1cj
	 BObMkInrvz0L4U/jgL9IJkH+00iaiK9U5cnIDKMLq0qV/KDqXUgsOXlOM9voGZR5RR
	 wCrEj3UEgugbcAuH8xVumuS3FCuABaOF4gluosJI=
Received: by gentwo.org (Postfix, from userid 1003)
	id DE23C4026E; Fri, 11 Oct 2024 11:07:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id DB77E401CB;
	Fri, 11 Oct 2024 11:07:44 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:07:44 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: "yuan.gao" <yuan.gao@ucloud.cn>
cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slub: Avoid list corruption when removing a slab
 from the full list
In-Reply-To: <20241011102020.58087-1-yuan.gao@ucloud.cn>
Message-ID: <c7b03b1e-e000-279d-f845-5808653ac3bf@gentwo.org>
References: <20241011102020.58087-1-yuan.gao@ucloud.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Oct 2024, yuan.gao wrote:

> When an object belonging to the slab got freed later, the remove_full()
> function is called. Because the slab is neither on the partial list nor
> on the full list, it eventually lead to a list corruption.

We detect list poison....

> diff --git a/mm/slab.h b/mm/slab.h
> index 6c6fe6d630ce..7681e71d9a13 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -73,6 +73,10 @@ struct slab {
>  						struct {
>  							unsigned inuse:16;
>  							unsigned objects:15;
> +							/*
> +							 * Reuse frozen bit for slab with debug enabled:

"If slab debugging is enabled then the frozen bit can bereused to
 indicate that the slab was corrupted"

> index 5b832512044e..b9265e9f11aa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1423,6 +1423,11 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
>  			slab->inuse, slab->objects);
>  		return 0;
>  	}
> +	if (slab->frozen) {
> +		slab_err(s, slab, "Corrupted slab");


"Slab folio disabled due to metadata corruption" ?


> @@ -2744,7 +2750,10 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  	slab->inuse++;
>
>  	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> -		remove_partial(n, slab);
> +		if (folio_test_slab(slab_folio(slab))) {


Does folio_test_slab test for the frozen bit??


