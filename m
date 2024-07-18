Return-Path: <linux-kernel+bounces-256342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DA934CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDFA2823EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3C13A407;
	Thu, 18 Jul 2024 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlnHvgg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908712D745;
	Thu, 18 Jul 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303034; cv=none; b=bG0jKRUStH8W5Ra+6mTNcyjupCztiGjazoBelzRW3CtAog3JCSEbL6IXPt4ml7S/oT9EC416rA1exAc/pSQOG9q2u+z7iqYrRxQ+SC5msfxfx87uEU3JuFw6tkmSLgIqFGckN1OmtFJwxriNbr2V3FroFsU0taMkVnh677MFKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303034; c=relaxed/simple;
	bh=j9ZM4sgimbHCwOKSnNzbQnPlbO19lzIBOmXEFXAmSnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PU/1XBwtKa9NcK0ErWGO4BzPr9o8CVaYT9MzY5thysBhwi7vFDcWDh3dkDkBnWQrEwG5pG1vm2ypH8rHwPT/zVan4RuPMEmn0IuWfaKzHGmVdRV5a6N2Ue9ZpX3LtKZbN5HltbjF7aCZDXKytHw4sYZne+QRwQ5b0vxoPWBeZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlnHvgg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAFFC116B1;
	Thu, 18 Jul 2024 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721303034;
	bh=j9ZM4sgimbHCwOKSnNzbQnPlbO19lzIBOmXEFXAmSnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlnHvgg7IhAplaec55DHHogreodz3snoybUI8HGsD6Y2AX0c5c0YiPTbHAdKn/gv9
	 Mnsw9q0T2OD31mYN231jIB0nqFMwuIGuuG+CE3mjF0Fz3wUUivANeJwAZkAfqDVtRM
	 DpphTzSuVLwIJGSDqPg6Gvu60XqSYpePH1+2t8scTSFKkjriIfP0GQ7FmZHvRBSFC3
	 9RukZp7VQIi48hQjjyr6C37785Yuwde20Wj0eFj7uRZF8QXzpta/ebSjOl3qXVhaId
	 /KoisvMi9PVwgjlVPYsUnr2300x8D8utnnGUFpTtKXbUB+Bzo7zU31cvvzD27DVyjK
	 Qhk08nEJGnMUw==
Date: Thu, 18 Jul 2024 13:43:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	kees@kernel.org, ojeda@kernel.org, wedsonaf@gmail.com,
	mhocko@kernel.org, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <Zpj_8-ICVU_mLg0M@pollux>
References: <20240717222427.2211-1-dakr@kernel.org>
 <20240717222427.2211-2-dakr@kernel.org>
 <ZpiJDdqhDlAb8n6T@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpiJDdqhDlAb8n6T@infradead.org>

On Wed, Jul 17, 2024 at 08:16:29PM -0700, Christoph Hellwig wrote:
> On Thu, Jul 18, 2024 at 12:24:01AM +0200, Danilo Krummrich wrote:
> > +extern void * __must_check vrealloc_noprof(const void *p, size_t size,
> > +					   gfp_t flags) __realloc_size(2);
> 
> No need for the extern here.
> 
> It would also help readability a bit to keep the __realloc_size on a
> separate like, aka:
> 
> void *__must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> 		__realloc_size(2);

Sure, will change that.

> 
> > +	if (size <= old_size) {
> > +		/* TODO: Can we optimize and shrink the allocation? What would
> > +		 * be a good metric for when to shrink the vm_area?
> > +		 */
> 
> Kernel comment style is to keep the
> 
> 		/*
> 
> on a line of it's own.

I think it differs a bit throughout subsystems - will change.


> A realloc that doesn't shrink is a bit pointless.

Indeed - the idea was to mostly clean up kvrealloc() in this series first and
implement proper shrinking and growing in a subsequent one. Does that make
sense?

> The same heuristics as for krealloc should probably apply
> here, adjust to the fact that we always deal with whole pages.

Sounds reasonable, but are there any? In __do_krealloc() if ks > new_size we
only call into kasan_krealloc() to poison things and return the original
pointer. Do I miss anything?

> 
> 
> > +	/* TODO: Can we optimize and extend the existing allocation if we have
> > +	 * enough contiguous space left in the virtual address space?
> > +	 */
> 
> I don't understand this comment.

I meant to say that we could optimze by allocating additional pages and map them
at the end of the existing allocation, if there is enough space in the VA space.

If that doesn't work, we can still allocate additional pages and remap
everything.

> 
> > +EXPORT_SYMBOL(vrealloc_noprof);
> 
> New interfaces should be EXPORT_SYMBOL_GPL.  That being said for this
> to be added an exported we'll need an actual user to start with anyway.

Besides kvrealloc(), the Rust abstractions will be a user soon, but for that we
probably don't need the export either. I will remove it for now.

