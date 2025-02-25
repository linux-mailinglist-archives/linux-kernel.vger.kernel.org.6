Return-Path: <linux-kernel+bounces-531054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C208BA43BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8B219C73C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6985726738F;
	Tue, 25 Feb 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n0J+ghyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F238F4A;
	Tue, 25 Feb 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479053; cv=none; b=cWQFnJvPYVNGb12It5eyzRQ/1ms3taqTYWd4wizM78Pj/E7U2FGn2lKqigS7DkVXbskkzGgsDGr94+Yv/Y4pjb2ScDz2g6tYYhGmlwLJUumrDuLp6GxIQqtKWnuvuoDJ9JI/UWHM/oi7jI5tpGR2wexeQlCSjvkGb9pRDkCH18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479053; c=relaxed/simple;
	bh=6h84qLfGwbImfITzfTzkYlb6/rJQLyKiI2OtAkuKs38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik6b8VcklNyVlNNtbIiPOC2XTQVUqMwZzpor/HfG938MokR2hnwYbpvk+VmbYFglCYQfA1wXVRz/4FJjRfVEaqxJslwhMlA81GJoY1CkPGIe1uLHPQk1Jv5b8WEcpsmSXFn5hW9SStyndpn37rtmXiFctyHWB9OQwIn+GlfiKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n0J+ghyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B74C4CEDD;
	Tue, 25 Feb 2025 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740479053;
	bh=6h84qLfGwbImfITzfTzkYlb6/rJQLyKiI2OtAkuKs38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0J+ghyw53Zmv7eUA0gehh3FmrVJ1Qb0IFjnKgl5/Qjyr5h+kz7UQ8v7iVUnWW7HI
	 nu19c2c2h09tgoSNtxWHfLlaKjn3OqMk0MUXNLAitT4k4PqNQonrKeTDPN4SjYiiWJ
	 nE0W3Jkw5MmcUsPbal/ExLmJ3ORuSmLofw7H+pRI=
Date: Tue, 25 Feb 2025 11:23:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: miscdevice: change how f_ops vtable is constructed
Message-ID: <2025022523-charbroil-overtime-4e68@gregkh>
References: <20250117-miscdevice-fops-change-v1-1-ec04b701c076@google.com>
 <2025021926-transport-fridge-bc43@gregkh>
 <CAH5fLggCjB0ePQvPFeTuy9m0UC_KkHa6-qU8AhQ+P8oHbAhZLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggCjB0ePQvPFeTuy9m0UC_KkHa6-qU8AhQ+P8oHbAhZLA@mail.gmail.com>

On Tue, Feb 25, 2025 at 11:10:17AM +0100, Alice Ryhl wrote:
> On Wed, Feb 19, 2025 at 4:58 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 17, 2025 at 02:22:32PM +0000, Alice Ryhl wrote:
> > > I was helping someone with writing a new Rust abstraction, and we were
> > > using the miscdevice abstraction as an example. While doing this, it
> > > became clear to me that the way I implemented the f_ops vtable is
> > > confusing to new Rust users, and that the approach used by the block
> > > abstractions is less confusing.
> > >
> > > Thus, update the miscdevice abstractions to use the same approach as
> > > rust/kernel/block/mq/operations.rs.
> > >
> > > Sorry about the large diff. This changes the indentation of a large
> > > amount of code.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >  rust/kernel/miscdevice.rs | 295 ++++++++++++++++++++++------------------------
> > >  1 file changed, 141 insertions(+), 154 deletions(-)
> >
> > This doesn't apply against a clean 6.14-rc2 tree, what is is made
> > against?
> 
> I will rebase.
> 
> Are there any other miscdevice commits that have landed this cycle
> that it might conflict with? If so, I can base it on your branch to
> avoid such conflicts.

Nope, I don't see any at the moment, or in my review queue, so it should
be fine.

thanks,

greg k-h

