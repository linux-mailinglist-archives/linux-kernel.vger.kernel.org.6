Return-Path: <linux-kernel+bounces-260022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC2393A19B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0659A1F22C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8B153565;
	Tue, 23 Jul 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfHjhnId"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366F208A0;
	Tue, 23 Jul 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741621; cv=none; b=jpcQdQJx4xBw0qi2VM36QYd9i+06OvtSbgQpqiAVdkmSc99SHDbWcjgqOZ7YTz8QJDksG51KOtLgYdm5xG/xtZ5v9kxb3LAVBUZUsAjqlG2C5fL2o8bJxEyTXAPAntlbmNmfNdS0oSuk0XGs/ZHQtR5vusJ6Xz9rsHhbpCuL8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741621; c=relaxed/simple;
	bh=sbp9otUqlv/cDrBswp3q8g8x24As4Td5+acClwkG1Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kisgTo/KnvQB7KBfTOX0/K6A9XD1RjVX5NGw0QuVGUtVST8fJot8KHlqm5j07jhXgPuDHfPqmtMaKTzuvtFBVa3dKoDM6680AHSoiBm/rghAV5sa6qPykKMA1ybaRlJyoRjLTx1AGGg7k8FsxgTCqmFyY/gf6A43RC7bslKPkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfHjhnId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318F5C4AF0A;
	Tue, 23 Jul 2024 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721741620;
	bh=sbp9otUqlv/cDrBswp3q8g8x24As4Td5+acClwkG1Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfHjhnIdE5SMmArN8TsXhyZc5mfeB4oxz5+nXPOTLu7hd4bk+ndBHFqhgv58waBJM
	 7N0ga68G/gzkct6mID7Mz4VybS56sB/UiTAzKgRdpPSfz+t+/9irxMvD3/diQvkngS
	 eJwWsCCeKZLKNq7Tn45nl/OR5YpYlMq9CtkgoszKd9OYjaVxXb+L3cJozuY4FUd9d/
	 EI0pG6uLwrX92pdtgV6antoWWaF3I1IaGf3QSH0yHQlt7SFLoLxCE3MLEOL5yvUy/A
	 BIcMe0UMfDK2StiRWAcmPwBan9anDoyr6Rl/4Fd9seiZEnCZ0H+D1NQqdpGNfQn7Ni
	 wgXbaoFPvFgJg==
Date: Tue, 23 Jul 2024 15:33:32 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <Zp-xLOa7NFOt4r1V@pollux>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-3-dakr@kernel.org>
 <Zp9gtelmvzN5tfpS@tiehlicka>
 <Zp-JCWCPbDLkzRVw@pollux>
 <Zp-MMcf1xUgqtFGS@tiehlicka>
 <Zp-aRJAIVI9B2pKb@pollux>
 <Zp-eJ6QTsT0wrlS-@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-eJ6QTsT0wrlS-@tiehlicka>

On Tue, Jul 23, 2024 at 02:12:23PM +0200, Michal Hocko wrote:
> On Tue 23-07-24 13:55:48, Danilo Krummrich wrote:
> > On Tue, Jul 23, 2024 at 12:55:45PM +0200, Michal Hocko wrote:
> > > On Tue 23-07-24 12:42:17, Danilo Krummrich wrote:
> > > > On Tue, Jul 23, 2024 at 09:50:13AM +0200, Michal Hocko wrote:
> > > > > On Mon 22-07-24 18:29:24, Danilo Krummrich wrote:
> > > [...]
> > > > > > Besides that, implementing kvrealloc() by making use of krealloc() and
> > > > > > vrealloc() provides oppertunities to grow (and shrink) allocations more
> > > > > > efficiently. For instance, vrealloc() can be optimized to allocate and
> > > > > > map additional pages to grow the allocation or unmap and free unused
> > > > > > pages to shrink the allocation.
> > > > > 
> > > > > This seems like a change that is independent on the above and should be
> > > > > a patch on its own.
> > > > 
> > > > The optimizations you mean? Yes, I intend to do this in a separate series. For
> > > > now, I put TODOs in vrealloc.
> > > 
> > > No I mean, that the change of the signature and semantic should be done along with
> > > update to callers and the new implementation of the function itself
> > > should be done in its own patch.
> > 
> > Sorry, it seems like you lost me a bit.
> > 
> > There is one patch that implements vrealloc() and one patch that does the change
> > of krealloc()'s signature, semantics and the corresponding update to the
> > callers.
> > 
> > Isn't that already what you ask for?
> 
> No, because this second patch reimplements kvrealloc wo to use krealloc
> and vrealloc fallback. More clear now?

I'm very sorry, but no. The second patch just changes kvrealloc(), how do you
want to split it up?

> > > > > > +	if (is_vmalloc_addr(p))
> > > > > > +		return vrealloc_noprof(p, size, flags);
> > > > > > +
> > > > > > +	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
> > > > > > +	if (!n) {
> > > > > > +		/* We failed to krealloc(), fall back to kvmalloc(). */
> > > > > > +		n = kvmalloc_noprof(size, flags);
> > > > > 
> > > > > Why don't you simply use vrealloc_noprof here?
> > > > 
> > > > We could do that, but we'd also need to do the same checks kvmalloc() does, i.e.
> > > > 
> > > > 	/*
> > > > 	 * It doesn't really make sense to fallback to vmalloc for sub page
> > > > 	 * requests
> > > > 	 */
> > > > 	if (ret || size <= PAGE_SIZE)
> > > > 		return ret;
> > > 
> > > With the early !size && p check we wouldn't right?
> > 
> > I think that's unrelated. Your proposed early check checks for size == 0 to free
> > and return early. Whereas this check bails out if we fail kmalloc() with
> > size <= PAGE_SIZE, because a subsequent vmalloc() wouldn't make a lot of sense.
> 
> It seems we are not on the same page here. Here is what I would like
> kvrealloc to look like in the end:
> 
> void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
> {
>         void *newp;
> 
>         if (!size && p) {
>                 kvfree(p);
>                 return NULL;
>         }
> 
>         if (!is_vmalloc_addr(p))
>                 newp = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
> 
>         if (newp)
>                 return newp;
> 
>         return vrealloc_noprof(p, size, flags);
> }
> EXPORT_SYMBOL(kvrealloc_noprof);

This looks weird. The fact that you're passing p to vrealloc_noprof() if
krealloc_noprof() fails, implies that vrealloc_noprof() must be able to deal
with pointers to kmalloc'd memory.

Also, you never migrate from kmalloc memory to vmalloc memory and never free p.
Given the above, do you mean to say that vrealloc_noprof() should do all that?

If so, I strongly disagree here. vrealloc() should only deal with vmalloc
memory.

> 
> krealloc_noprof should be extended for the maximum allowed size

krealloc_noprof() already has a maximum allowed size.

> and so does vrealloc_noprof.

Probably, but I don't think this series is the correct scope for this change.
I'd offer to send a separate patch for this though.

> The implementation of the kvrealloc cannot get any
> easier and more straightforward AFAICS. See my point?
> -- 
> Michal Hocko
> SUSE Labs
> 

