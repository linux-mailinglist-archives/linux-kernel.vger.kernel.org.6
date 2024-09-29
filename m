Return-Path: <linux-kernel+bounces-343032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07498960F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BA7284E17
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7D17ADF8;
	Sun, 29 Sep 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQdwPrhL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F38F6D;
	Sun, 29 Sep 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727621549; cv=none; b=uComKv/kahejMjrXnp0NKG8WbG0Eb6KSLxNU2l4R3S+On/+yqTIS1hSTxdkVOeEpxRwBEburb4J39U7ChDE1MEWAPMAucggDJ34sEuFjGBr3bGb6mf8iFou2lYtuL2Vk9bsOCA4CITsHVJRm2t1umAiY+Jr57jA4oZXC3k5RWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727621549; c=relaxed/simple;
	bh=KCzOpXBaRXTqzAhkCrLfiC9LHlzekTchiyskk2fq0FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnIcveJpb4q47pTsx80PM/t+H9kXIL+Z0hARh0kbH1PeV1ldg4exgILxvigll65iST/aE9364+OnADIendyJf51gTkDoXzljG80xEcQPLejVDn7oQt2OJH5+Hh4OaeRDeGBac03EsVyhbPeSrLFtFfGHZpC2G1p76P8p6WvuwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQdwPrhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E881C4CEC5;
	Sun, 29 Sep 2024 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727621549;
	bh=KCzOpXBaRXTqzAhkCrLfiC9LHlzekTchiyskk2fq0FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQdwPrhLu3Mh8AlZYHEjdJFOe8Bi5q3qapODOo690Hb8/wjgQhe1Gx8WILJ9ikULa
	 yMgf49TyiRSk5r2bjvzzNZ4DRL5PnxIrAba9IDO4SxmdrIk5Q+p4Eauqxj3lHG7PIo
	 BT4JT+0ZV52FAiTdLKMeUTTC3dzfalNObRi5IaDVyFdPOztazsB5NeI+MN+C7BKqoK
	 PiNBBu5Mm06+IQIEyWnZdHCFSvBsz/w2C0X/vFlMwxLsDZFOgkq2/gNvmCQNFt3avW
	 gP4ynf9a1qZ7FV4bmh9Gw9JZOKT9cAbY/jT7graoOSbDtgQ2p314lbyFwpw6LD6TDu
	 3ia4MLo5HoTtw==
Date: Sun, 29 Sep 2024 16:52:21 +0200
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
Subject: Re: [PATCH v7 10/26] rust: treewide: switch to our kernel `Box` type
Message-ID: <ZvlppcutUjuRChPK@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-11-dakr@kernel.org>
 <20240928195913.5b2c04d8.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928195913.5b2c04d8.gary@garyguo.net>

On Sat, Sep 28, 2024 at 07:59:13PM +0100, Gary Guo wrote:
> On Thu, 12 Sep 2024 00:52:46 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Now that we got the kernel `Box` type in place, convert all existing
> > `Box` users to make use of it.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 
> Have you considered defaulting the `A` in `Box` to `Kmalloc`? This
> would avoid doing a lot of tree-wide changes.
> 
> If you have a reason against it (I'm pretty sure you have), then
> probably you should put it in the commit message.

Yes, I want people to be forced to make an explicit decision about the allocator
backend they choose, because this has relevant implications.

For instance, it's likely to be unexpected to people coming from userspace Rust,
that (with the default of `Kmalloc`) `Box` allocations larger than
`KMALLOC_MAX_SIZE` would just fail.

> 
> Best,
> Gary
> 
> > ---
> >  drivers/block/rnull.rs            |  4 +--
> >  rust/kernel/init.rs               | 51 ++++++++++++++++---------------
> >  rust/kernel/init/__internal.rs    |  2 +-
> >  rust/kernel/rbtree.rs             | 49 ++++++++++++++++-------------
> >  rust/kernel/sync/arc.rs           | 17 +++++------
> >  rust/kernel/sync/condvar.rs       |  4 +--
> >  rust/kernel/sync/lock/mutex.rs    |  2 +-
> >  rust/kernel/sync/lock/spinlock.rs |  2 +-
> >  rust/kernel/workqueue.rs          | 20 ++++++------
> >  rust/macros/lib.rs                |  6 ++--
> >  10 files changed, 81 insertions(+), 76 deletions(-)
> 

