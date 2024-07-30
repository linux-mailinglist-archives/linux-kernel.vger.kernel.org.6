Return-Path: <linux-kernel+bounces-268205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4739421A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3505B24196
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08818CBF4;
	Tue, 30 Jul 2024 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EbDwYwoN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05E1684BE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371473; cv=none; b=CMTL7PcK2QPh0VSKmRFammdOMc8Ta8sN3a2ofsd1is1MAyM+j/mMD6d584ljj27haZC1nOUscHy2SaNewRB2KImnvbv7RsmrLlgJx9LqljumMLg/p2kLDPYMONsnRV91mpcVDCjO5hVmb8jDKT3emQKSAublxx1ViRvYWJT4eKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371473; c=relaxed/simple;
	bh=L9LJLEF4Y6p/2yxTdyr9c533JPHoNLKbpTwRH9JUtnk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ksls+WxZqwgEwW00/SrBqGuBBiSsxAURP5q7UFXzxLyDVoj49S2ZMZeuCEfjKk/e8PiThFWeNTL+r8cOqPZy+ivy5oBMs8s0WMZUWe2J/Wptm6SUaYrKnlrLjyeUZiGLJGjs2yXNVyl+9LLoXCvHKzfeJoJXiYBbwA8JiTmfRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EbDwYwoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACEAC4AF0B;
	Tue, 30 Jul 2024 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722371472;
	bh=L9LJLEF4Y6p/2yxTdyr9c533JPHoNLKbpTwRH9JUtnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EbDwYwoNKUocRBBgSecGIn8A3tOfN/0arc68+tvaKGxfyydiSqxN7QJUAT9euMZ67
	 Mk8bAHSjG0AEOv6I3Nd4BfrojmDZ7ckWlP0nA0/7747hAOkOmTc/TtrAUEpFtt3ht6
	 957spyvWyAa7tCz04lf/gLEIJo6Hev3f5wjiUxJg=
Date: Tue, 30 Jul 2024 13:31:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: krealloc: consider spare memory for __GFP_ZERO
Message-Id: <20240730133111.d180e1a6fc63b2883fe99821@linux-foundation.org>
In-Reply-To: <20240730194214.31483-1-dakr@kernel.org>
References: <20240730194214.31483-1-dakr@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 21:42:05 +0200 Danilo Krummrich <dakr@kernel.org> wrote:

> As long as krealloc() is called with __GFP_ZERO consistently, starting
> with the initial memory allocation, __GFP_ZERO should be fully honored.
> 
> However, if for an existing allocation krealloc() is called with a
> decreased size, it is not ensured that the spare portion the allocation
> is zeroed. Thus, if krealloc() is subsequently called with a larger size
> again, __GFP_ZERO can't be fully honored, since we don't know the
> previous size, but only the bucket size.

Well that's bad.

> Example:
> 
> 	buf = kzalloc(64, GFP_KERNEL);

If this was kmalloc()

> 	memset(buf, 0xff, 64);
> 
> 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
> 
> 	/* After this call the last 16 bytes are still 0xff. */
> 	buf = krealloc(buf, 64, GFP_KERNEL | __GFP_ZERO);

then this would expose uninitialized kernel memory to kernel code, with
a risk that the kernel code will expose that to userspace, yes?

This does seem rather a trap, and I wonder whether krealloc() should
just zero out any such data by default.

> Fix this, by explicitly setting spare memory to zero, when shrinking an
> allocation with __GFP_ZERO flag set or init_on_alloc enabled.
> 
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1273,6 +1273,13 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  
>  	/* If the object still fits, repoison it precisely. */
>  	if (ks >= new_size) {
> +		/* Zero out spare memory. */
> +		if (want_init_on_alloc(flags)) {
> +			kasan_disable_current();
> +			memset((void *)p + new_size, 0, ks - new_size);

Casting away the constness of `*p'.  This is just misleading everyone,
really.  It would be better to make argument `p' have type "void *".

> +			kasan_enable_current();
> +		}
> +
>  		p = kasan_krealloc((void *)p, new_size, flags);


