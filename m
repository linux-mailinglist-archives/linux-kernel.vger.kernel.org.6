Return-Path: <linux-kernel+bounces-362261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E699B2C2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1C41F22644
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990A14431B;
	Sat, 12 Oct 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="KmJuawbz"
Received: from mail-m60100.netease.com (mail-m60100.netease.com [210.79.60.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672317BA5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727251; cv=none; b=MA5ulzy0r4IsmFcgN+VJPTUoJiZ2kJGwsYKKuknSKA1UD0Lo3zmSpdqwDbDBb9GHH/vkcQqEEmMnMlKOCJHjIy1e5s7xPwrBQLznQJovW8MH4gL81YsRnAeZNrICyJz2k5dPwdur7h82Vxm1zDBKfssS26Y9SFVvZvTK05FKNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727251; c=relaxed/simple;
	bh=3kut4cCYLTeOlaOgkcrtNVftW+vdHyiXVGzMVtIgScM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpxE9RkYO26f65rxN6UZjcDkZl/CYyqnGVx/o8ew0jBOlnk8eKmswkrEHcZFC+TFBwBMjp08xy5rrMtVCUPRcTbG4VHnc00rg9jxHt50DjKDSHh+F0msHolpNhHP+hXkBifzCM/hvykO2qDLZmg4jLYqWXHz8r41FP9aQseUWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=KmJuawbz; arc=none smtp.client-ip=210.79.60.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
DKIM-Signature: a=rsa-sha256;
	b=KmJuawbzZFPhMIs1LwWRiKNQFDp0JBiVUBbO67d1SQX8AkpzFVaAT/2gcLN+p/o7P20nnGWGRx7M5OSGTWzMwO8QGfUK6+Nrdd53ON9ww6Fa1n/nl1Z1dVqqPXw6EThbQnYrj8S6CgCp6PM8Qxi2v67KeEdywtlLVEvI0yYmS00=; s=default; c=relaxed/relaxed; d=ucloud.cn; v=1;
	bh=G+BqwL9XXYYynAveH5DQ+xdOe+teFSG1ecILV2JYFLE=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost (unknown [106.75.231.159])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 43AAB66024F;
	Sat, 12 Oct 2024 12:04:27 +0800 (CST)
Date: Sat, 12 Oct 2024 12:04:26 +0800
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slub: Avoid list corruption when removing a slab
 from the full list
Message-ID: <i5vqm2ucpjzfbeteamphorouzoep3qxmh3prq5d76g4sazjarf@d3rfku3r5735>
References: <20241011102020.58087-1-yuan.gao@ucloud.cn>
 <c7b03b1e-e000-279d-f845-5808653ac3bf@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b03b1e-e000-279d-f845-5808653ac3bf@gentwo.org>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkpMVk9PGUJLSUpKT0MeT1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUhKVUpOQllXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
X-HM-Tid: 0a927ee62e14023bkunm43aab66024f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46PQw6UTcsTj08FE4LKUga
	Vk9PCitVSlVKTElDTEtOQ01MTExDVTMWGhIXVQIOGhVVHBoUOw4YFxQOH1UYFUVZV1kSC1lBWUpL
	TVVMTlVJSEpVSk5CWVdZCAFZQUhJSUI3Bg++

On 24/10/11 11:07AM, Christoph Lameter (Ampere) wrote:
> On Fri, 11 Oct 2024, yuan.gao wrote:
> 
> > When an object belonging to the slab got freed later, the remove_full()
> > function is called. Because the slab is neither on the partial list nor
> > on the full list, it eventually lead to a list corruption.
> 
> We detect list poison....
> 
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 6c6fe6d630ce..7681e71d9a13 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -73,6 +73,10 @@ struct slab {
> >  						struct {
> >  							unsigned inuse:16;
> >  							unsigned objects:15;
> > +							/*
> > +							 * Reuse frozen bit for slab with debug enabled:
> 
> "If slab debugging is enabled then the frozen bit can bereused to
>  indicate that the slab was corrupted"
> 
> > index 5b832512044e..b9265e9f11aa 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1423,6 +1423,11 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
> >  			slab->inuse, slab->objects);
> >  		return 0;
> >  	}
> > +	if (slab->frozen) {
> > +		slab_err(s, slab, "Corrupted slab");
> 
> 
> "Slab folio disabled due to metadata corruption" ?
> 
> 

Yes, that's what I meant. 
Perhaps I should change the description from "Corrupted slab" to
"Metadata corrupt"?

> > @@ -2744,7 +2750,10 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
> >  	slab->inuse++;
> >
> >  	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> > -		remove_partial(n, slab);
> > +		if (folio_test_slab(slab_folio(slab))) {
> 
> 
> Does folio_test_slab test for the frozen bit??
> 

For slab folios, slab->fronzen has been set to 1.
For non-slab folios, we should not call remove_partial().
I'm not sure if I understand this correctly.

Thanks

