Return-Path: <linux-kernel+bounces-366319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0EB99F3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4841C222BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD141F76DA;
	Tue, 15 Oct 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZIHyo+Rb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2B17335C;
	Tue, 15 Oct 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012137; cv=none; b=k6r0Z1q+mneYLwT41vkTFdV3uJLFf3Jj5w2r4JQ9stw0EBJHnvde1xf+XYmR+XIlDMlbGE+cvvYXdUU6k16dXdgKGx14XufbTdqBKQrvQJakcpooPkbqPuIhO+UbgTUQNpLsMeJbPLy+DlTTR4N0V0XVCUjSyh8n2SFI+sMyD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012137; c=relaxed/simple;
	bh=7x79Q1s8OSa307Oj/n+6Lbu2xwm7cWo5fwwTIA0RjBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8ZOe2HoTZ/GdT4an/yubRmPgvOrwKbphe26tCr1g2YcSHcNYDG70TlAWNLQBN51ls+vPFN4KWznF88Zj8A/zjUlst6MF27s2Ehkhsx4YfMolksVJ6TPuIgb1khY7Jribc2RNtjg7Dfhz+HxI4cq1ptcTJRdF+v+xlGupXmg1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZIHyo+Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF5C4CEC6;
	Tue, 15 Oct 2024 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729012136;
	bh=7x79Q1s8OSa307Oj/n+6Lbu2xwm7cWo5fwwTIA0RjBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIHyo+Rb6bvCUhNAVg16blxDjGcFEjS8mk4XX0lLCxzlifyCN6A7TuqyqL0eQY7+Y
	 4uNGQR8WSatufJRQUU3um/o4rUBoeHOfk9muzdKnG+1HV7HO2hb0qmGAXvHlAAJ2Lp
	 kEjreIfiP89TXGZOsWPjYvAKokxq4lwlHvq7hiy0=
Date: Tue, 15 Oct 2024 19:08:53 +0200
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
Subject: Re: [PATCH] rust: miscdevice: fix warning on c_uint to u32 cast
Message-ID: <2024101545-reentry-extenuate-58ce@gregkh>
References: <20241015-miscdevice-cint-cast-v1-1-fcf4b75700ac@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-miscdevice-cint-cast-v1-1-fcf4b75700ac@google.com>

On Tue, Oct 15, 2024 at 02:13:22PM +0000, Alice Ryhl wrote:
> When building miscdevice with clippy warnings, the following warning is
> emitted:
> 
> 	warning: casting to the same type is unnecessary (`u32` -> `u32`)
> 	   --> /home/aliceryhl/rust-for-linux/rust/kernel/miscdevice.rs:220:28
> 	    |
> 	220 |     match T::ioctl(device, cmd as u32, arg as usize) {
> 	    |                            ^^^^^^^^^^ help: try: `cmd`
> 	    |
> 	    = help: for further information visit
> 	      https://rust-lang.github.io/rust-clippy/master/index.html#unnecessary_cast
> 	    = note: `-W clippy::unnecessary-cast` implied by `-W clippy::all`
> 	    = help: to override `-W clippy::all` add `#[allow(clippy::unnecessary_cast)]`
> 
> Thus, fix it.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This fixes a warning on my patches in char-misc-next. Greg, can you take
> this through that tree?

Will do, thanks!

greg k-h

