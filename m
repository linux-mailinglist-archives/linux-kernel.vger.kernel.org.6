Return-Path: <linux-kernel+bounces-268360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1A9423A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99347B21462
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2A1FB4;
	Wed, 31 Jul 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJL15IV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A138C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384163; cv=none; b=N6VxbAtN9UGtVix+fmCoKTkSjzKx5qbUHWdnQQv4bccfe6IPtMbYS1ctJBHB0ZIXw3Ym1WJnup4jsaGVlWC1dwL2Z1ppEL11Bcmy5w485qOG2BEXZvhPJt8++GEmqQdpvEyyYqtSxfVJkdn+llBh+OVMlNeFnhKeN+kZqVF/JaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384163; c=relaxed/simple;
	bh=MZ84WBMb67FnZkuouahXmXGFPZ8pi0oJbpj2ztROqaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlHNRObBjjHT5/Xu4UW01EvORm9+J1RKIBuzCl6Qb+aIcuQTuA+wN8YH8l3I+jZZprLYhnXnbygFDxN/MiHeJInAO5tvki8BJSn1HPthckFWoH7jBQzx7F7XWv7vDQm8Ozoz3Y1aJNB+46bhSc5ROZigKOwuQXCwvSObMbBTo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJL15IV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492CDC32782;
	Wed, 31 Jul 2024 00:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722384163;
	bh=MZ84WBMb67FnZkuouahXmXGFPZ8pi0oJbpj2ztROqaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJL15IV3A2dLzdPyRzR5y4VCQeSSN+1p787hRsswNZ8EVKwUs+DqjQdV7hgYcr+gb
	 6OOwlGbYrHIhtYbFL6Xy55WCXEwj+OqIBqikxd4O/ekYFNhK4k22qgv/QLf/yHCxaS
	 83R41+ByGeihfOfAaQ7xfq/VSU6+nt86wFVBVtBqSbQvpJ0I7nTMulXF+IruZbn3se
	 DzsoqzTq2ObuiZADby0JYnDOEfi2yqfV0cTTjNot+vVvlzaWrtpipPLpgvMopipxKY
	 OpYqfcMJttTIUbGo2/1KtGlwZ5mnM5IKMVboWV4AHUdwMpiypK/T37wKt71Sdrg9NS
	 2DnG9nbKn+SCA==
Date: Wed, 31 Jul 2024 02:02:39 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: krealloc: clarify valid usage of __GFP_ZERO
Message-ID: <Zql_H4g9wJxmJkQJ@pollux.localdomain>
References: <20240730194214.31483-1-dakr@kernel.org>
 <20240730194214.31483-2-dakr@kernel.org>
 <20240730133540.66e215082a513509c0d8649c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730133540.66e215082a513509c0d8649c@linux-foundation.org>

On Tue, Jul 30, 2024 at 01:35:40PM -0700, Andrew Morton wrote:
> On Tue, 30 Jul 2024 21:42:06 +0200 Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Properly document that if __GFP_ZERO logic is requested, callers must
> > ensure that, starting with the initial memory allocation, every
> > subsequent call to this API for the same memory allocation is flagged
> > with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
> > honored by this API.
> > 
> > ...
> >
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -733,6 +733,14 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
> >   * @new_n: new number of elements to alloc
> >   * @new_size: new size of a single member of the array
> >   * @flags: the type of memory to allocate (see kmalloc)
> > + *
> > + * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> > + * initial memory allocation, every subsequent call to this API for the same
> > + * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> > + * __GFP_ZERO is not fully honored by this API.
> > + *
> > + * In any case, the contents of the object pointed to are preserved up to the
> > + * lesser of the new and old sizes.
> >   */
> >  static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(void *p,
> >  								       size_t new_n,
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index cff602cedf8e..faa13f42b111 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1301,11 +1301,17 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> >   * @new_size: how many bytes of memory are required.
> >   * @flags: the type of memory to allocate.
> >   *
> > - * The contents of the object pointed to are preserved up to the
> > - * lesser of the new and old sizes (__GFP_ZERO flag is effectively ignored).
> >   * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
> >   * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
> >   *
> > + * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> > + * initial memory allocation, every subsequent call to this API for the same
> > + * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> > + * __GFP_ZERO is not fully honored by this API.
> > + *
> > + * In any case, the contents of the object pointed to are preserved up to the
> > + * lesser of the new and old sizes.
> > + *
> >   * Return: pointer to the allocated memory or %NULL in case of error
> >   */
> >  void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
> 
> In both cases, we're saying "callers should do X".  I think it would be
> better to say "this implementation does A, hence callers should do X". 
> Tell people what's going on.

Sounds reasonable, I'll add an explanation here and in the fixup series for
vrealloc() / kvrealloc().

> 
> eg, "if krealloc is expanding an existing allocation, the newly-added
> memory will be uninitialized unless the caller used __GFP_ZERO".  Or
> something like that.
> 
> I assume that if the caller actually touches the uninitialized memory,
> KASAN will warn?

For the case that is fixed in patch 1 of this series, no. KASAN can't detect
this.

As you say, the memory is just uninitialized (not poisoned), where it should
have been zeroed instead.

