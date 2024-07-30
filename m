Return-Path: <linux-kernel+bounces-268355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD2942399
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B095A285191
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825FB1922D8;
	Tue, 30 Jul 2024 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEIOlIPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2B18E04E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722383663; cv=none; b=WI1Vmwi981StxBSbp9F/l1xnd6G9DsmyI4h21eVvog4NLTlwK+EL0tiSPs4NVJWPHzoeTLKdcZbsIEaAkwZuVDlsnK+5of+VHbpJK7y1UM6XdktaJ11bzJ7/VES+A9JMWgPj3bwi9ykd4hVaFXCTqWz7stu78U30a+kL/4J8csg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722383663; c=relaxed/simple;
	bh=tonEYU/q2zJv8yeNhlMtWuw0j+u5Hwyu1Vvs427U5G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh/SczYxtHM87/M91E1l/WAiM9RnTO60VQV8F84EPM5CNWXXRHJm6XjPpq/gKnin43jsZv4DiwHShyFBJGikqBZysfBCabYka+h4Mer8QNiK1eWx/S8A9cvoEeihaxnggps5YQ6HB8ZnUrYMPI8SVJPiTeV/DQbs+Zs4Vxq8nDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEIOlIPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA6BC32782;
	Tue, 30 Jul 2024 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722383663;
	bh=tonEYU/q2zJv8yeNhlMtWuw0j+u5Hwyu1Vvs427U5G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEIOlIPc+JHS5zlVZkivZULuFnL5V2QDbJkwbHDhORZUkNF8FaZmpBr7YKtdNuTuv
	 2G01+wUQfD47yw1RIA1VrBwACjJDBpYMruEZZafoJRvgYf8Tw7jvX0hlTC2Z9DvcI6
	 f3fpfSIh2cOHfwAoSZQE9pdoK7wwUIxVIRrs4hekx5i6fB9PVk9eEhdIkV2Ss21suL
	 Q5yq0Qq3UKsKB4bXF3KESelTIUoudMf5qfhziin0t4ADx3LlibnWggPnMaRMyt9Cs6
	 CJvDezP46dy+N2G6Pg1GHjmra3yFkjBLXKJwacbUry44cpQIk1q1hollMPoEg5/mZv
	 kwfoCnPuTOIzA==
Date: Wed, 31 Jul 2024 01:54:17 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/2] mm: krealloc: consider spare memory for __GFP_ZERO
Message-ID: <Zql9KXRDBb5Ufpp-@pollux.localdomain>
References: <20240730194214.31483-1-dakr@kernel.org>
 <66836dd6-b0c2-4f77-b2a3-c43296aa6c93@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66836dd6-b0c2-4f77-b2a3-c43296aa6c93@suse.cz>

On Tue, Jul 30, 2024 at 11:14:16PM +0200, Vlastimil Babka wrote:
> On 7/30/24 9:42 PM, Danilo Krummrich wrote:
> > As long as krealloc() is called with __GFP_ZERO consistently, starting
> > with the initial memory allocation, __GFP_ZERO should be fully honored.
> > 
> > However, if for an existing allocation krealloc() is called with a
> > decreased size, it is not ensured that the spare portion the allocation
> > is zeroed. Thus, if krealloc() is subsequently called with a larger size
> > again, __GFP_ZERO can't be fully honored, since we don't know the
> > previous size, but only the bucket size.
> > 
> > Example:
> > 
> > 	buf = kzalloc(64, GFP_KERNEL);
> > 	memset(buf, 0xff, 64);
> > 
> > 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
> > 
> > 	/* After this call the last 16 bytes are still 0xff. */
> > 	buf = krealloc(buf, 64, GFP_KERNEL | __GFP_ZERO);
> > 
> > Fix this, by explicitly setting spare memory to zero, when shrinking an
> > allocation with __GFP_ZERO flag set or init_on_alloc enabled.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  mm/slab_common.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 40b582a014b8..cff602cedf8e 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1273,6 +1273,13 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> >  
> >  	/* If the object still fits, repoison it precisely. */
> >  	if (ks >= new_size) {
> > +		/* Zero out spare memory. */
> > +		if (want_init_on_alloc(flags)) {
> > +			kasan_disable_current();
> > +			memset((void *)p + new_size, 0, ks - new_size);
> > +			kasan_enable_current();
> 
> If we do kasan_krealloc() first, shouldn't the memset then be legal
> afterwards without the disable/enable dance?

No, we always write into the poisoned area. The following tables show what we do
in the particular case:

Shrink
------
          new        old
0         size       size        ks
|----------|----------|----------|
|   keep   |        poison       |  <- poison
|--------------------------------|
|   keep   |         zero        |  <- data


Poison and zero things between old size and ks is not necessary, but we don't
know old size, hence we have do it between new size and ks.

Grow
----
          old        new
0         size       size        ks
|----------|----------|----------|
|       unpoison      |   keep   | <- poison
|--------------------------------|
|         keep        |   zero   | <- data

Zeroing between new_size and ks in not necessary in this case, since it must be
zero already. But without knowing the old size we don't know whether we shrink
and actually need to do something, or if we grow and don't need to do anything.

Analogously, we also unpoison things between 0 and old size for the same reason.

> 
> > +		}
> > +
> >  		p = kasan_krealloc((void *)p, new_size, flags);
> >  		return (void *)p;
> >  	}
> > 
> > base-commit: 7c3dd6d99f2df6a9d7944ee8505b195ba51c9b68
> 

