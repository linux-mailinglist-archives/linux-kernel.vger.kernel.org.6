Return-Path: <linux-kernel+bounces-567074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC6A680C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABEC3B78E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01A2080EE;
	Tue, 18 Mar 2025 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idYD+lgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009C1DED62;
	Tue, 18 Mar 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340944; cv=none; b=qACVwL3WNJ55iq2yhLrEAKVv2bOPXYzQMZtykxvxrRx67BDpGSkeTxk0U9oJJCQbpmBWc9aMpMLREpGiUnA15DWMFlFTMBmu0RHD2OoCsLMpeW+k+klM3Dm4jNiWhygac/hv7vn7b3Yt6LDg3j//dohl1T/b/shhfoIzFM++Yco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340944; c=relaxed/simple;
	bh=4IVcs9YZr3otoyqBA+adK0IyFOywTE4SWOr0nExun5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuNunFxRReh9fXMJWAAufe7UM/Y0g9hWDyyYsDGKVJdE79BsOFPJ/9qmA7fdJPyjlNhDrAxiEt/rrV6s4MXWH6oQ2JioJ9pilu6KpzDxi6PichHVwA/NIZWgMkmFCmvqCqPx5MDdKUxZTeasdnLLvGHDjssB7NNlz1mtwdrRrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idYD+lgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6BCC4CEDD;
	Tue, 18 Mar 2025 23:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742340939;
	bh=4IVcs9YZr3otoyqBA+adK0IyFOywTE4SWOr0nExun5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idYD+lgTiQ8etxPoLwzo/bFdbKC+Hz1XU0jd2LvYX9TjiOXPstG18HbME+pqDTLc6
	 2xMbcaWWqTev1HGYalywJjUoRj4rqFCkk9BZS5U5KAVPLQTH33G82S1nkJHh4afFPB
	 ShnUwNnHEsHK3VPJ5KNUVaFXDnwMsNYFLkqgzfho=
Date: Tue, 18 Mar 2025 16:34:21 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Rust support for `struct iov_iter`
Message-ID: <2025031804-eardrum-surplus-5ff9@gregkh>
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <9pOFLtAJ1ScEHfLe7L2KqghIKBzL8sTupJttIVRB70ZmvdUpiEYrxCxIpJD_cBJVwv-TKxosDL-l6cq3qt563Q==@protonmail.internalid>
 <2025031140-saffron-kilobyte-bd2e@gregkh>
 <878qp2hx9o.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qp2hx9o.fsf@kernel.org>

On Tue, Mar 18, 2025 at 09:57:55PM +0100, Andreas Hindborg wrote:
> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
> >> This series adds support for the `struct iov_iter` type. This type
> >> represents an IO buffer for reading or writing, and can be configured
> >> for either direction of communication.
> >>
> >> In Rust, we define separate types for reading and writing. This will
> >> ensure that you cannot mix them up and e.g. call copy_from_iter in a
> >> read_iter syscall.
> >>
> >> To use the new abstractions, miscdevices are given new methods read_iter
> >> and write_iter that can be used to implement the read/write syscalls on
> >> a miscdevice. The miscdevice sample is updated to provide read/write
> >> operations.
> >
> > Nice, this is good to have, but what's the odds of tieing in the
> > "untrusted buffer" logic here so that all misc drivers HAVE to properly
> > validate the data sent to them before they can touch it:
> > 	https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me
> >
> > I'd like to force drivers to do this, otherwise it's just going to force
> > us to audit all paths from userspace->kernel that happen.
> >
> 
> I think that for user backed iterators (`user_backed_iter(iter) != 0`)
> we will have the same problems as discussed in [1]. To validate, we
> would have to copy the data to another buffer and then validate it
> there, in a race free place. But the copying is apparently a problem.

We already copy all data first, that's not an issue.  Validate it after
it has been copied before you do something with it, just like we do
today for normal ioctl C code.  Same goes for data coming from hardware,
it's already been copied into a buffer that you can use, no need to copy
it again, just "validate" it before using it.

thanks,

greg k-h

