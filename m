Return-Path: <linux-kernel+bounces-256343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75514934CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245141F226D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338413AA38;
	Thu, 18 Jul 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAZWFU+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4012DD88;
	Thu, 18 Jul 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303119; cv=none; b=Gbn9AylKndR5ZwTZGiXEgYqCC1khC6IWLK2AWcklf1QCPiVuYghMqiPDZaq0zAXbiDJ2XTkL43qQwjTfkoANvJRttmSmk/rHvsGksfyp3MSqP0KNA++nGAiswA9ofOEDu+aHjxmklN8ptj7QRbGL+xmcn7gxKeu6KB1dWfCwuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303119; c=relaxed/simple;
	bh=6dDkmxqvJY8h61QecQ5gJGkM7Qx9fiJB6j7R5iGc7TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCe6h7lxfcOfwSuOidc+aNtER6DFMK7UFGDldtYGfXHErY0om0/KGLgLhafM22s7p6u0jAB5DxCc7AZ6m1o7GAzhr6l54t41eCeaikazjsXitmoqoSsB3NqKRTHUekWZJgU3WfX7rqJJvgJa8ypKxOxg5TtHMpbxbiFw87gsPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAZWFU+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72AAC116B1;
	Thu, 18 Jul 2024 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721303118;
	bh=6dDkmxqvJY8h61QecQ5gJGkM7Qx9fiJB6j7R5iGc7TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAZWFU+5O9a3urAw6D6eH506PIDqNsVSfC9vYYllWtzOOOipRvFCyQRAmfO3RGLzR
	 EapBZ+yFliVUUQJ6ypC1xJaCoEZ8hM4Z4bgdB6k2uQ6DbEKK02beSf5xaiscmqMLb9
	 3qaSOftrgSs7pPf0y18DxDE5Ls9I3d2qFyOuXgrWgVwwj50HTN4Ew5dwiks8sfxo+J
	 E8+4Zvtf/d7SGJIkVXRyIGz7/wNXnvyWmecRkBAi5DVpOzEujLToxcSGrGbjavlWlc
	 wwdSu/oTKdBqNeaW4XURZg6IfXMOmKHULCMH1pAk9kh4KDv0LgQlW2CBuMcFQCS57x
	 3boscUjlhGk3Q==
Date: Thu, 18 Jul 2024 13:45:11 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	kees@kernel.org, ojeda@kernel.org, wedsonaf@gmail.com,
	mhocko@kernel.org, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <ZpkARwEkp70YMVzf@pollux>
References: <20240717222427.2211-1-dakr@kernel.org>
 <20240717222427.2211-3-dakr@kernel.org>
 <ZpiJvj1_rKodpVSt@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpiJvj1_rKodpVSt@infradead.org>

On Wed, Jul 17, 2024 at 08:19:26PM -0700, Christoph Hellwig wrote:
> > +extern void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags) __realloc_size(2);
> 
> Please drop the extern while you're at it and move the __realloc_size
> attribute to a separate line.

Will do.

> 
> > +static gfp_t to_kmalloc_flags(gfp_t flags, size_t size)
> > +{
> > +	if (size > PAGE_SIZE) {
> > +		flags |= __GFP_NOWARN;
> > +
> > +		if (!(flags & __GFP_RETRY_MAYFAIL))
> > +			flags |= __GFP_NORETRY;
> > +
> > +		/* nofail semantic is implemented by the vmalloc fallback */
> > +		flags &= ~__GFP_NOFAIL;
> > +	}
> > +
> > +	return flags;
> 
> The name for this function sounds a bit odd.  Maybe kmalloc_gfp_adjust
> instead?  Also the comment explaining these flags tweaks should move
> from the caller to this function.

kmalloc_gfp_adjust() sounds good to me. I will rename it and move the comment
up.

