Return-Path: <linux-kernel+bounces-287930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7D952E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8351C210F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7917C9B6;
	Thu, 15 Aug 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Qxzjlm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA060B96;
	Thu, 15 Aug 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725207; cv=none; b=RK/HQ5nlz4laEFLK/vHuw253AH7Rhi5X1IZvTYVvneHTY4p/MrbsCOvw/aFvnzYKLyxqqE1et3y/4eZTF34MJe3vZRseuKGgOXAW0mD+65cwzimyj6QGF0VmzXiYGsj0IhDrSlExJrsR5gqBUR1TP1wVjAONE0WSkZP+1z6LsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725207; c=relaxed/simple;
	bh=aFz6QZuvfklNKy+lGLokX91B3P7oStHD3S4UrY7+mxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM0/gaV4buxl9mOVMsN5Parvhpjh/iCJNCYZMoak6cTtMg9do2SpY7+gNwHDGe7l61Sm1OKOTD4FCNttW1/VwTx892/NrH+AvvqRTQ38uG5hcvZUTJzlH3YwvoT8JTa0262GCVI4YqLerH96I5eipGZUengBQG8C+pXS8D7ufmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1Qxzjlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC07C4AF0B;
	Thu, 15 Aug 2024 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723725205;
	bh=aFz6QZuvfklNKy+lGLokX91B3P7oStHD3S4UrY7+mxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1QxzjlmzHIWRxp+GaMG0YjawSSaxCHv3jHbKHPInQoPZzf1nuHi1T6l23l5izyJa
	 GEXdmb9wwxsqluXvX/0xrmP2lkoMQSq67WSRqr3LRbC+GuttD3GhFYhH1sC439zq0u
	 qED0H7kKAcsXUgaubAKZcf0hva0Tg7CB0JUDtrDpYG5RNtwaJwAjknUt1m/p82em/P
	 pCC2aq7vujNOPiJwKfRLjzj3JwFhczkC1XDdfVtXUaCDMKItIRYbxrW7dqCt9tkkiC
	 BcYCZbS2dKFrij/ZhpgsdGtdMJP7KHtJDjY/kopZDG9p20hvbZ9MKNm/IILrW1Gk0E
	 DmB4x6pCR270g==
Date: Thu, 15 Aug 2024 14:33:18 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <Zr31jqnA2b3qHK5l@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <Zr0GP0OXliPRqx4C@boqun-archlinux>
 <Zr1teqjuOHeeFO4Z@cassiopeiae>
 <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjvuE5uU00u4y+HyHTkQU_OBYvHe6NS5ohAhrLntTX1zQ@mail.gmail.com>

On Thu, Aug 15, 2024 at 11:20:32AM +0200, Alice Ryhl wrote:
> On Thu, Aug 15, 2024 at 4:52 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
> > > Hi Danilo,
> > >
> > > I'm trying to put your series on rust-dev, but I hit a few conflicts due
> > > to the conflict with `Box::drop_contents`, which has been in rust-dev
> > > for a while. And the conflict is not that trivial for me to resolve.
> > > So just a head-up, that's a requirement for me to put it on rust-dev for
> > > more tests from my end ;-)
> >
> > I rebased everything and you can fetch them from [1].
> >
> > I resolved the following conflicts:
> >
> >   - for `Box`, implement
> >     - `drop_contents`
> >     - `manually_drop_contents` [2]
> 
> Not sure I like this name. It sounds like something that runs the
> destructor, but it does the exact opposite.

I thought it kinda makes sense, since it's analogous to `ManuallyDrop::new`.

What about `Box::forget_contents` instead?

> 
> >     - ``move_out` [2]
> >     - `BorrowedMut` for `ForeignOwnable` for `Box<T, A>` and `Pin<Box<T, A>>`
> >     - `InPlaceWrite` and updated `InPlaceInit`
> >   - for `RBTreeNode`, make use of `Box::move_out` to replace the original
> >     implementation partially moving out of `Box`
> >
> > @Alice: Please have a look at the changes for `RBTreeNode`. Maybe it's also
> > worth having them in a separate patch.
> 
> RBTree changes LGTM.
> 
> Alice
> 

