Return-Path: <linux-kernel+bounces-330069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DCB979935
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F661F21C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F726F2F8;
	Sun, 15 Sep 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQcgC3A+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36A4779F;
	Sun, 15 Sep 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726436267; cv=none; b=efHKTJGNdasW3R4Ey7yvEn+m6ZsJN247yE1/nlNunPzekJtYkdIfcGx/ovtYPnLTns0oco0UPTrqR/EGyDF+2d527zazQE70udVOZeW/dEHt3m0l6QYVM/QulpCFOsQc1P73U9gnRUIRoboyWeldglRWHIGgqFpZiid8WFUL8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726436267; c=relaxed/simple;
	bh=cFetZ0+pK2Z2v93rcqzXBuQ7IfsY3UoObSRCY2KoNlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ2rnPYCAruIreInnBqJlRksTjpyUWsybvuNDxqA8qT3jX7+Eqe1Zb3zSlf2c4083FBwygD41pWv3Xvm1jVsC6uRaMFRefNObGMS+li3d9UYFBxW8Y1wf30UkZtPsjtYDlYxaKvcxO48vE9w7yhTJ1RTEbXLJi1dOMo4JSrS6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQcgC3A+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92E7C4CEC4;
	Sun, 15 Sep 2024 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726436266;
	bh=cFetZ0+pK2Z2v93rcqzXBuQ7IfsY3UoObSRCY2KoNlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQcgC3A+5UyJfuiIQUzVgwzNMgU/GY/avkfzGcA4LaF2kdN0F3yUuBlxab5fEvQcl
	 9XiIHi0tnp2vfwLrbQxZ+UwfqqXQCNsn5+nyi3PVBxs/z+YiLhhJP08V8WtgIyr3wg
	 u2+UNkrLtI/zdTxgWuviGikO+pmx6hQcv/3tBFRW3dqMFTczaJnhSQTmhzjdkERJPh
	 eGkUbQcdUfPqsih17gTrq+jnkeKjIkDF+x9BICgNfW3mRJEcJ/jGUIOxw5+ZMIKoZ7
	 DF8zAONumxFHNHB9SV2WTygew7XC+VHhGAU4PzRoGVKxbvp/jZA/+H9KLu1szW4Vf/
	 5rySmtahMopIQ==
Date: Sun, 15 Sep 2024 23:37:38 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 01/26] rust: alloc: add `Allocator` trait
Message-ID: <ZudTon205iOCdQbq@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-2-dakr@kernel.org>
 <20240915162813.149e21f2.gary@garyguo.net>
 <ZucTMDCcoVH4oGs1@pollux>
 <20240915202242.7a16b3d3.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915202242.7a16b3d3.gary@garyguo.net>

On Sun, Sep 15, 2024 at 08:22:42PM +0100, Gary Guo wrote:
> On Sun, 15 Sep 2024 19:02:40 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> > There is also 4.
> > 
> > Let `alloc` and `realloc` return a properly aligned dangling pointer for
> > `size == 0` and don't accept dangling pointers in `realloc` and `free`.
> 
> I'll consider the API design to be bad if I can't pass allocated pointer to
> free. If caller needs to handle ZST specially then we might as well
> just ban it completely.

Fine for me -- I don't see a need to support ZSTs with `Allocator`.

I think its main purpose is to give us an interface to actually allocate memory.
We probably don't need it to be a "dangling pointer generator".

> 
> > And 5.
> > 
> > Reject the combination of `None` and `size == 0` entirely, as earlier proposed
> > by Benno.
> > 
> > I'm fine with both, 4. and 5. with a slight preference for 4.
> > 
> > I'd also go along with 1., as a mix of 4. and 5.
> > 
> > I really don't like making `alloc` unsafe, and I really don't want to have
> > `old_layout` in `free`. Please let's not discuss this again. :-)
> 
> I don't buy it.
> 
> Your argument for having `old_layout` is so that the caller doesn't
> need to care about the size. But as demonstrated the caller *does* need
> to care about whether the size is zero.
> 
> Our previous discussion doesn't cover the particular case of ZST and
> you said that it reason arise that we need this extra parameter, then
> it could be added. It feels to me that sane behaviour when it comes
> to ZST allocation is a very good reason.

I don't see why we should "optimize" the API for creating dangling pointers and
be able to pass them to `free` (which does not serve any practical purpose).

I don't want to add arguments that are meaningless for the actual backing
allocators (such as Kmalloc, Vmalloc, etc.), only to be able to generate and
"free" pointers for ZSTs with arbitrary alignment.

Do we even have use cases for ZSTs with other alignments?

> 
> > 
> > > 
> > > Best,
> > > Gary
> > >   
> > > > 
> > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > ---
> > > >  rust/kernel/alloc.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 112 insertions(+)
> 

