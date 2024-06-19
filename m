Return-Path: <linux-kernel+bounces-220782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCD190E6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C961C21492
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8F580029;
	Wed, 19 Jun 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywh1PGmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44180034
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789185; cv=none; b=BsZNY8JZwjsKEq6Mxs+pnssWySeKJQS3D9LCsq8WyETvNNoiwsMIySgh+9P3cmzPvXbL1NfZNPs/2LoaiafLWzqti8dptYTC+CvslbVLnWbCQFmPLC11hL3AX2BeobsTmv9pdcJAAaD5ryRR6urmq7uLdsekMpj+X1+vRtqcwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789185; c=relaxed/simple;
	bh=66o7eKaXW7UoOMZm3DSXuJpSFK2xxkY0YlrIARKvwmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrUB8EVEloICqi0z57+lGJGqi+Y+VjPMwxDdGiGHtRNLq4EAwTprdD3CxpJIRLv6W5+IQ734J6MFgwgNrZDSpB8ukrVucZpeaNcAk1BVzMVlIQW+WqoZkGSb7cF2KkhN4kcYZROXBJxHpMclmihy6PaNJh/Z/dE0MpFSHlU8xjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywh1PGmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D1AC2BBFC;
	Wed, 19 Jun 2024 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718789185;
	bh=66o7eKaXW7UoOMZm3DSXuJpSFK2xxkY0YlrIARKvwmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ywh1PGmYz6kwnYVpS1LbOyH0smBbKcT5eOCc1Z3qLrpNuYqxxAzDkfv5QEcH9rZNO
	 WdgmOtycIl/4n0g7uQLS6ZwPwjk0D3Nd7HgrifSVmLyqfYAypd62HdVwM/xCyhp5Jr
	 C2usHD8Fk/mH71GgY+ai4RfZxYc9ncN6int7sHojPQWgcrv9J8JMKsxB/WEiLsNyJm
	 IOw5hejQviP3ufACa9UKC9vcWMFHfetFU4U91SfSBQayxHD9xQ61JVxqz4XYqq+s5n
	 V0lRbF33uihfC+w1MZB91+MicCXOtWLs3d+HJ6Te0mGyXL9/S+00WSX1H2/ZMpvHN9
	 XgZ8bY1aiSjzA==
Date: Wed, 19 Jun 2024 12:24:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] memblocks: Move late alloc warning down to phys alloc
Message-ID: <ZnKjuQkPvTPt-Od7@kernel.org>
References: <20240614133016.134150-1-jgowans@amazon.com>
 <ZnFpPCSTAUj90FJF@kernel.org>
 <b5be15c1b7389afad2b67bf85b26aab4d213ca19.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5be15c1b7389afad2b67bf85b26aab4d213ca19.camel@amazon.com>

On Wed, Jun 19, 2024 at 07:53:14AM +0000, Gowans, James wrote:
> On Tue, 2024-06-18 at 14:02 +0300, Mike Rapoport wrote:
> > On Fri, Jun 14, 2024 at 03:30:16PM +0200, James Gowans wrote:
> > > Subject: [PATCH] memblocks: Move late alloc warning down to phys alloc
> > 
> > Nit: memblock
> 
> Ack!
> 
> > 
> > > If a driver/subsystem tries to do an allocation after memblocks have

And another one here :)                                     ^

> > > been freed and the memory handed to the buddy allocator, it will not
> > > actually be legal to use that allocation - the buddy allocator owns the
> > > memory. This is handled by the memblocks function which does allocations
> > > and returns virtual addresses by printing a warning and doing a kmalloc
> > > instead. However, the physical allocation function does not to do this
> > > check - callers of the physical alloc function are unprotected against
> > > mis-use.
> > 
> > Did you see such misuse or this is a theoretical issue?
> 
> Yeah, I was driving the memblock allocator badly when prototyping
> something. Allocating a large contiguous block of memory for an in-
> memory filesystem and I was doing the allocation in an initcall, but by
> that point it was too late. The memblock allocator happily gave me a
> large chunk of memory, but it was already in use by the buddy allocator,
> so ended up with memory corruption. Oops! Getting this warning would
> have made the problem immediately obvious.
> 
> > 
> > > Improve the error catching here by moving the check into the physical
> > > allocation function which is used by the virtual addr allocation
> > > function.
> > > 
> > > Signed-off-by: James Gowans <jgowans@amazon.com>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Alex Graf <graf@amazon.de>
> > > ---
> > >  mm/memblock.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index d09136e040d3..dd4f237dc1fc 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -1457,6 +1457,17 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> > >               align = SMP_CACHE_BYTES;
> > >       }
> > > 
> > > +     /*
> > > +      * Detect any accidental use of these APIs after slab is ready, as at
> > > +      * this moment memblock may be deinitialized already and its
> > > +      * internal data may be destroyed (after execution of memblock_free_all)
> > > +      */
> > > +     if (WARN_ON_ONCE(slab_is_available())) {
> > > +             void *vaddr = kzalloc_node(size, GFP_NOWAIT, nid);
> > > +
> > > +             return vaddr ? virt_to_phys(vaddr) : 0;
> > > +     }
> > 
> > I'd move this before alignment check.
> 
> Ack, will do in V2.
> 
> Anything else or should I make the tweaks and post V2?
 
Looks ok to me.

> JG

-- 
Sincerely yours,
Mike.

