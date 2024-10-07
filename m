Return-Path: <linux-kernel+bounces-353655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E89930D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1C41F24420
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C431D79A5;
	Mon,  7 Oct 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="CzL9WzLt"
Received: from mail-m2482.xmail.ntesmail.com (mail-m2482.xmail.ntesmail.com [45.195.24.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024F1D27A5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313933; cv=none; b=Adpe/3tilx7wncXNyL6uhRD+CCAdGyKpGRuTLDnjxA/T/NppWu3/TODpGgasJ4lXp80lWnQJCmEWEk4s9/fPgg09OyuMGi8TqOmpF8A99Ku9z9UIXjnjp3Bsms+DXeBaAEfaaeQLgzOY7wSsc7aYk09HdW8m7BGtIHIgg03XN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313933; c=relaxed/simple;
	bh=txvpmzLao1v1uT1h5ATcVF1ivjx944dXCiD+8GYRE/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNHTrOPXn/rJsM4usTRJAR0JEk0MCUfH5uyQnl+p9q5b1DtlGRRA5wAVznLdHkPXLh5sDCpruI4fY8JF2k3qum8HSOIcOGZP/nyV5lrDgNe7YMiN9lBeIBSu90nlkMtLpDcaFqEeV8c5oWWhxQFWxu1kHOu/BJqZQ/jWMU3kA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=CzL9WzLt; arc=none smtp.client-ip=45.195.24.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
DKIM-Signature: a=rsa-sha256;
	b=CzL9WzLt6gXE39cady1xUQWL/R4OOlyiSfVv/VtIAOfhDAnVRIeCDbDw3btAaf4I7HdL4cBzDmYE8/tLDn9D/JTkjwh4fJ514WS0kqQ1Fdn8F5G8xGu7YQgmBLKdz0t5XmiQw1gOzpBcoRqdq5817mO/azKXdkhG1jkH45aAeDQ=; s=default; c=relaxed/relaxed; d=ucloud.cn; v=1;
	bh=GuEfmkR6uSSIGq2LPxg5NsQYWXV41FAYulYx32Qyh5g=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [106.75.210.166])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 66DA074046A;
	Mon,  7 Oct 2024 17:12:49 +0800 (CST)
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: 42.hyeyoo@gmail.com
Cc: akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	vbabka@suse.cz,
	yuan.gao@ucloud.cn
Subject: Re: [PATCH] mm/slub: Avoid list corruption when removing a slab from the full list 
Date: Mon,  7 Oct 2024 17:12:43 +0800
Message-ID: <20241007091245.8476-1-yuan.gao@ucloud.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAB=+i9Rfy_+4vvbbuLPrVUDU=9n-Mpp2ab5t2f2fq6NG=RAXYA@mail.gmail.com>
References: <CAB=+i9Rfy_+4vvbbuLPrVUDU=9n-Mpp2ab5t2f2fq6NG=RAXYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxhJVkpMGRpNT05JQhgeSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUpLVUpNTVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
X-HM-Tid: 0a926640b5b40236kunm66da074046a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6MDo4GTchAkw*DzodGT8L
	ERcaCxRVSlVKTElDSUJJSExLSEpMVTMWGhIXVQIOGhVVHBoUOw4YFxQOH1UYFUVZV1kSC1lBWUpL
	TVVMTlVJSktVSk1NWVdZCAFZQUhDSko3Bg++

On 24/10/06 10:00PM, Hyeonggon Yoo wrote:
> On Sun, Oct 6, 2024 at 1:48 PM yuan.gao <yuan.gao@ucloud.cn> wrote:
> >
> > Boot with slub_debug=UFPZ.
> >
> > If allocated object failed in alloc_consistency_checks, all objects of
> > the slab will be marked as used, and then the slab will be removed from
> > the partial list.
> >
> > When an object belonging to the slab got freed later, the remove_full()
> > function is called. Because the slab is neither on the partial list nor
> > on the full list, it eventually lead to a list corruption.
> 
> Good catch! Thanks for investigating the cause and fixing it.
> 
> > So we need to add the slab to full list in this case.
> 
> While I believe that behavior is not intended by alloc_debug_processing(),
> I can't think of a better fix here without adding some complexity.
> The approach looks fine to me.
> 
> > ---
> >  mm/slub.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 21f71cb6cc06..a99522b9efc0 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2746,6 +2746,8 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
> >
> >         if (!alloc_debug_processing(s, slab, object, orig_size)) {
> >                 remove_partial(n, slab);
> > +               if (slab->inuse == slab->objects)
> > +                       add_full(s, n, slab);
> 
> Shouldn't this be (folio_test_slab(slab_folio(slab))) instead of
> (slab->inuse == slab->objects)?
> Oh wait. the kernel also should not call remove_partial() for non-slab folios.
> 
> So I think it should be:
> 
> if (!alloc_debug_processing(s, slab, object, orig_size)) {
>         if (folio_test_slab(slab_folio(slab))) {
>                 remove_partial(n, slab);
>                 add_full(s, n, slab);
>         }
> }

Thank you for reminding me of this. I didn't notice the subtle differences here. 
 
> By the way, SLUB always messes with struct page fields even when it is
> not a slab,
> and I think SLUB should avoid modifying those fields before confirming
> it is a slab.
> (specifically, calling alloc_debug_processing() before updating
> ->freelist, ->inuse fields)
> 
> That is beyond the scope of this patch, but do you want to address it
> in the next version
> of your patch series?
> 
> Cheers,
> Hyeonggon
> 

I'm glad to do that, just takes time.

Thanks

