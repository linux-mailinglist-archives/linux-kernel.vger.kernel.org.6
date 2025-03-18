Return-Path: <linux-kernel+bounces-566101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00DA67331
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9FA88041E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52E204080;
	Tue, 18 Mar 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNXw2L1Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555B3FC2;
	Tue, 18 Mar 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298790; cv=none; b=Y8CM6U8ANrMzNLy/ilDfACeTuA06NgYtGkNUxTgPFPLcwooq+Ofp5eTEsYUIr0zZNWMWgqem3+4yUagDcWfs30n2sMSnvmgf3XToXKlYOWPoInzQX/Qjp8x5E+uPEKcwUrhwDKRHgOHzzl6KezC43a3PCJrGckqIoNq3yp8NhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298790; c=relaxed/simple;
	bh=gRmHonTx+tXy1+AP4ILZnp3ZnyyajmJA8Y5guRqzNFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoRGpOClioC1xFmUMZShzwt6scSRxQKd7geDgXJ7e2mgAh8+UsnPISQyA4/H28SmwgHPSQYXA7IY6uRiw6SkKKw3keY30XjYLW+uCnNe2MS/YV9+45lTl1J+EjqDXM93m6CFqXnNDu6XT4o8ty3pXKclKjRi6QbzyPbl7jx87O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNXw2L1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD02C4CEDD;
	Tue, 18 Mar 2025 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298790;
	bh=gRmHonTx+tXy1+AP4ILZnp3ZnyyajmJA8Y5guRqzNFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNXw2L1Y1fdh/nn4aLtHxDFTU8pGYPXyfTAh4aGqj+oejyzSBabAmXHU8SbXGUUjf
	 wWtXj4puZzFqW0WKxgShTVOHAVkQuu2uChoAgu9rMemhhJhmurWI3qUImGjB7M6b3H
	 8Io8P7HtgI9ODZM07yQ2Oq+1HWgl1hJ3UXVCxav/c71kJ1/J4LicZKllnw60fjaboX
	 2tLNsEeDTUrYQ7qRNKTJ9KV21nKgd8aHg1du7geUUmqYMJbbj/9K58aWxKJqvfSJKa
	 UrarGx6gLxdhX5iXy4QpGBdN5+gwnega7HZ5oPPjPO+JrAl0vQGEMqqnjtE5bXouI6
	 nNgZR7d2PyOSA==
Date: Tue, 18 Mar 2025 12:53:04 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Message-ID: <Z9leoGrF5pQeZ3tH@pollux>
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
 <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me>
 <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com>
 <Z9hXMcFVdF8MMusU@cassiopeiae>
 <D8IPQUN25M12.2CIZR4QHJ201N@proton.me>
 <Z9hcT4KPwgtHmiTT@cassiopeiae>
 <D8IQ5BDTLCLZ.1UBNYUXLK12X0@proton.me>
 <CAJ-ks9=xLLXovsaduKFBfxvkfzYgTaSPhhW_oRN5y1QOuKJFkQ@mail.gmail.com>
 <Z9k7cwE5UNOIyoXR@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9k7cwE5UNOIyoXR@google.com>

On Tue, Mar 18, 2025 at 09:22:59AM +0000, Alice Ryhl wrote:
> On Mon, Mar 17, 2025 at 01:55:18PM -0400, Tamir Duberstein wrote:
> > > >
> > > >       fn dec_len(&mut self, count: usize) -> &mut [T] {
> > > >           self.len = self.len.saturating_sub(count);
> > > >
> > > >           // Potentially broken, since maybe `count > self.len`, hence need an
> > > >           // additional check.
> > > >           unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.len), count) }
> > > >       }
> > >
> > > Ah sorry, in my mental model the function returned `()`. Do we need the
> > > return value?
> > 
> > The return value is the whole genesis of `dec_len`, we want to return
> > something to let the caller know they need to drop or copy the memory.
> 
> Hold on .. it returns &mut [T]. You're usually not allowed to take
> ownership of or drop values behind a mutable reference.

I think it should be fine. dec_len(), by returning this slice, indicates to the
caller what's left behind in case no action is taken.

Subsequent operations are unsafe anyways and can easily justify their validity
by saying that they only take over, what otherwise would have been left behind.

Do I miss anything?

