Return-Path: <linux-kernel+bounces-287305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA80952629
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF0728517F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5314EC79;
	Wed, 14 Aug 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFotiRHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F914B954;
	Wed, 14 Aug 2024 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723677666; cv=none; b=EyiFiJCuKsTduaM+Cm2WIPHjCe4uXzk31z1qxVZNHGmg/DnyL+arRCgzStgfgUeZZxNeck8iy8qKR1N+wir9WsVVt9rPc8n9aivNZZs9bbw2iceqYDqvgwNkTW/ebm50JyMJB2IiTppFZ/5posINuKLcUIVztqy8GfWQYX7XL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723677666; c=relaxed/simple;
	bh=4a7ZlA74vWDlCN9VZFGaIdiwH7xx/e/zJNrlaQbo+G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPZQ8olBp4unyqlsd0hMYJLm1JmDfZajYaEmn08tEl7ON8jSkQ1FrHgdntEnMtbKSEylcZ5JH4uMJrFh9kSr6wybQmKCNY5F0KOEthYvOMpV2vZD10NQQgUWo6WyUwe4Bosp1TCySpjvqJR5AzbwYXGhSdXUK5UTVCGjSIHFS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFotiRHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AFDC116B1;
	Wed, 14 Aug 2024 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723677665;
	bh=4a7ZlA74vWDlCN9VZFGaIdiwH7xx/e/zJNrlaQbo+G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFotiRHu7gmqVX7vYiru0C3Y+GoXeKj4bfovAzecyqAdLX1vrYBY//vVc/51GS/gX
	 gOugq/QXhkvcSP5msIEQK9bXoWZyBnbESwu3i+xcYUHZL3BRdXYX6BZjc5W1eMdDmI
	 Y2QBh6X7X5Qsy7/OCMD8awa4qtPRQDWMK24dmoB4QIqoj0oVF/8X5fYgujG1frAqOA
	 ofRVHYbCeujeuEwn1GtZwQ8VY+T+PmAMEzcQRbBBCry7n9qCbyj5ykWYQBeMjbfAk6
	 RvYYIHvozt0Ffv565DD0BfnK/YXnz3RF1wuUmEABRjJ2rOpPiPPOXGKm8k3mY1Ymy1
	 LmsSX/8aIKOTg==
Date: Thu, 15 Aug 2024 01:20:58 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <Zr072oSej9KIc1S6@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-7-dakr@kernel.org>
 <c9d57e77-8748-4e58-a39b-7a23f750ceda@proton.me>
 <Zr0r6sSFMSQIpHEX@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr0r6sSFMSQIpHEX@cassiopeiae>

On Thu, Aug 15, 2024 at 12:13:06AM +0200, Danilo Krummrich wrote:
> 
> > 
> > > +        ptr: Option<NonNull<u8>>,
> > > +        layout: Layout,
> > > +        flags: Flags,
> > > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > > +        // TODO: Support alignments larger than PAGE_SIZE.
> > > +        if layout.align() > bindings::PAGE_SIZE {
> > > +            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
> > > +            return Err(AllocError);
> > 
> > I think here we should first try to use `build_error!`, most often the
> > alignment will be specified statically, so it should get optimized away.
> 
> Sure, we can try that first.

I think I spoke too soon here. I don't think `build_error!` or `build_assert!`
can work here, it would also fail the build when the compiler doesn't know the
value of the alignment, wouldn't it? I remember that I wasn't overly happy about
failing this on runtime either when I first thought about this case, but I also
couldn't think of something better.

In the end it's rather unlikely to ever hit this case, and probably even more
unlikely to hit it for a sane reason.

> 
> > 
> > How difficult will it be to support this? (it is a weird requirement,
> > but I dislike just returning an error...)
> 
> It's not difficult to support at all. But it requires a C API taking an
> alignment argument (same for `KVmalloc`).
> 
> Coming up with a vrealloc_aligned() is rather trivial. kvrealloc_aligned() would
> be a bit weird though, because the alignment argument could only be really
> honored if we run into the vrealloc() case. For the krealloc() case it'd still
> depend on the bucket size that is selected for the requested size.
> 
> Adding the C API, I'm also pretty sure someone's gonna ask what we need an
> alignment larger than PAGE_SIZE for and if we have a real use case for that.
> I'm not entirely sure we have a reasonable answer for that.
> 
> I got some hacked up patches for that, but I'd rather polish and send them once
> we actually need it.

