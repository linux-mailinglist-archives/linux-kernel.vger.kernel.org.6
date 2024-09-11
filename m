Return-Path: <linux-kernel+bounces-325658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39936975CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9984284700
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C81B29B9;
	Wed, 11 Sep 2024 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSl2JtNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D22EAE5;
	Wed, 11 Sep 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091994; cv=none; b=WK9gL6qJMaYJWzt5WI0dbX/+zl6sykzolPO4adQiqQg8/3ex4nXMHi02vegqyWfDqqvBA9PVpMvy69YTT1qY9DaTqmYJlE0SIyR4mGTcmKvxxcFltEKcLQG5jYqSqM8NamiCzqI3RMDr3Fo+lcGty3rgMDJLrAV6QTisnThUSaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091994; c=relaxed/simple;
	bh=UlBTcNzdmM6jbFUy8h3KQwR5Xjcp0b9L4pHQdeczeSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgTac/tingWiib3cyaL70TfJFgj1B0+U6V70AbS11Nf8yytUYwuNXvyDAA5AJ0nCMYmnOGWFtX3wAluJ2HJUpKgnYbNYRRtBLRu0ZooKwvBpuOk5N6DK6PyzCI3x7WRY05oMfawagFI/JeUg/Yo6qZZMhzXnvllegSFZhrR+2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSl2JtNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7399EC4CEC0;
	Wed, 11 Sep 2024 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726091994;
	bh=UlBTcNzdmM6jbFUy8h3KQwR5Xjcp0b9L4pHQdeczeSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSl2JtNfqq7Q5CPm8ZjFixzRI6Ei2nGSTwOVWUHWpoAqQ0uEqF/8DEYq4OOUm6Ukn
	 mDwuKb9IB2fx1ri8vw38d2BbJqD5Xl+4Xdri6Zc4ad9w6RNb1moJfsT+ku9QtR71WS
	 OQSGKbJcWs9+uDnRgIJhX7SBkx6UY/4Oo89GrpB7Sa+bVvme4fHmJbaPg21oMK48/J
	 y2XTL7y7edSABlgme8e9cMqiHuC31+UXHS8L4Dk4J5NuM52UAhuB1/SWdiEJ08YDGY
	 qwoproPe/7dGIjwcFGiqGwedKzdSi8eH5EUvhfGPXorZKLuoWufkfdi8fNMLtshYtW
	 x02cfN8pk4SdQ==
Date: Wed, 11 Sep 2024 23:59:46 +0200
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
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <ZuIS0lBDyxsxuHwf@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-14-dakr@kernel.org>
 <a8c31bce-aac2-4ffe-8fab-2e68c9bab035@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c31bce-aac2-4ffe-8fab-2e68c9bab035@proton.me>

On Tue, Sep 10, 2024 at 08:07:40PM +0000, Benno Lossin wrote:
> On 16.08.24 02:10, Danilo Krummrich wrote:
> > `Vec` provides a contiguous growable array type (such as `Vec`) with
> > contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> > `Vmalloc` or `KVmalloc`).
> > 
> > In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> > kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs      |   6 +
> >  rust/kernel/alloc/kvec.rs | 629 ++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/prelude.rs    |   2 +-
> >  3 files changed, 636 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/kernel/alloc/kvec.rs
> 
> I noticed that you don't have a `pop` or `remove` function implemented,
> I think it would be weird to have all the other functions but not those.

I'd rather not add them for this series anymore. We can add them in subsequent
patches, or wait until they're actually needed.

I also already have some subsequent patches in the queue. For instance, in Nova
we'll need `Vec::resize` and `Vec::truncate`.

> 
> ---
> Cheers,
> Benno
> 

