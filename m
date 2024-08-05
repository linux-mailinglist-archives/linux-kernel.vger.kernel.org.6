Return-Path: <linux-kernel+bounces-274056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC559472A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E76B211E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E412D057;
	Mon,  5 Aug 2024 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzJtC9vD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CE27456;
	Mon,  5 Aug 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722819290; cv=none; b=nz0WBaG5+sz4O2u7Dg0UZ7pu7OKTrpCgl+6z1qiRghuaW32tQgmZhYvf3e/lQ9n2usOF0WzzxJvXNTcAY/SUMRxldWuanCcLxb5WVyGmfjNgJv5+JmjwRy8qUMuHStdMSN7AfQyOS/E284Qwso4ryPlwNTWSNxpTt4T5v27AlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722819290; c=relaxed/simple;
	bh=9jk2LYQQJtrrk9iFLGskRmEKMBMgClztVJRPefwAmBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbYpO8aJzjm3HmT45UxRPNcyv2SY6GVr1cSOxrUS/CrFKSZqgdlWpXiJiUn1AePz96b9UvfCBSt3kd1fcS1g2rklFQcdSllYWpfw6arTGxa50JbdxuR1P12mbN0Yt7iTmpHyD0RtkIHLxkg2BffqDFJMdDUo55/SnrybjaJYTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzJtC9vD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766A0C32786;
	Mon,  5 Aug 2024 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722819289;
	bh=9jk2LYQQJtrrk9iFLGskRmEKMBMgClztVJRPefwAmBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzJtC9vDe3UycGbXmq2kHn5+HfEHfbt21tX8GZa2cL3lpvcBQdGFwRiM+OuD50Gmr
	 uJguh9TBLT9YLVkcNl6196X+lmGsUPCSd3MSd84VsYVO1WRORxZkOSiF9Mjhi5iDbC
	 1bPYB4MAYgrxCqJDeYFDvHLnH5EC0wVX61pL+81L7lrRIyPP0xFT9b0pSA/wv9FzxP
	 JANRWKawWD7kHj4kdFI98y6OyVHtSDq03KkBrY6hlyPxFVKlqlhm22t8/jYYI6kN58
	 EQhPwfHuEeuXfeDRRLYEOe1o4LEwfO1IciDqLRY8mcYVtOsnWQyYIEWTqrMx1cP4re
	 4QZszt7BJPanw==
Date: Mon, 5 Aug 2024 02:54:41 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 06/25] rust: alloc: implement `Vmalloc` allocator
Message-ID: <ZrAi0faIw0cS3x6k@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-7-dakr@kernel.org>
 <Zq8jamaDSKWmj_-4@boqun-archlinux>
 <Zq927hO2fcV5LJME@pollux>
 <Zq-bWJFwtWG23O-L@pollux>
 <Zq-86Ma1nMybty-f@cassiopeiae>
 <ZrAVagw5Wy5p0sXj@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrAVagw5Wy5p0sXj@boqun-archlinux>

On Sun, Aug 04, 2024 at 04:57:30PM -0700, Boqun Feng wrote:
> On Sun, Aug 04, 2024 at 07:39:52PM +0200, Danilo Krummrich wrote:
> [...]
> > > > > > +unsafe impl Allocator for Vmalloc {
> > > > > > +    unsafe fn realloc(
> > > > > > +        ptr: Option<NonNull<u8>>,
> > > > > > +        layout: Layout,
> > > > > > +        flags: Flags,
> > > > > > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > > > > > +        let realloc = ReallocFunc::vrealloc();
> > > > > > +
> > > > > 
> > > > > IIUC, vrealloc() calls __vmalloc_noprof() in allocation case, that is
> > > > > calling __vmalloc_node_noprof() with align=1. In such a case, how would
> > > > > vmalloc() guarantee the allocated memory is aligned to layout.align()?
> > > > 
> > > > True, good catch. I thought of this a while ago and then forgot to fix it.
> > > 
> > > Just for clarification, we're always PAGE_SIZE aligned (guaranteed by
> > > __alloc_vmap_area()), which probably would always be sufficient. That's why I
> > > didn't gave it too much attention in the first place and then forgot about it.
> > > 
> > > However, we indeed do not honor layout.align() if it's larger than PAGE_SIZE.
> > 
> > Another note on that:
> > 
> > My plan for this series was to just fail allocation for alignment requests
> > larger than PAGE_SIZE. And, if required, address larger alignments in a later
> 
> Yeah, this sounds reasonable.
> 
> > series, since this one is probably big enough already.
> > 
> > However, for `Vmalloc` we could support it right away, since it's trivial. For
> > `KVmalloc` though it requires a bit more effort.
> > 
> 
> Could you elaborate why it requires a bit more effort? Because
> kvrealloc() and kvmalloc() in C don't have a way to specify alignment
> requirement?

Yes, exactly that.

> If so, I think a solution to that would be just providing
> the K-or-V switch in Rust code, i.e. just `Vmalloc` and `Kmalloc` to
> implement `KVmalloc`, which I don't think is a bad idea.

I really think we should do it in C. Look at all the special cases is
__kvmalloc_node_noprof(): fixup page flags, sanity check the size on kmalloc
failure, fail on certain page flags, etc.

I think we really want to keep all this logic in a single place and not
replicate it on the Rust side.

> 
> Regards,
> Boqun
> 
> > For consistancy it would probably be better to support alignments larger than
> > PAGE_SIZE either for `Vmalloc` and `KVmalloc` or neither of those though.
> > 
> > My personal tendency goes a bit more into the direction of picking consistancy.
> > 
> > Any other opinions?
> > 
> [...]
> 

