Return-Path: <linux-kernel+bounces-362146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89599B18C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D1EB22264
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B113CF8E;
	Sat, 12 Oct 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUiE0emP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB932581;
	Sat, 12 Oct 2024 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718175; cv=none; b=MXWip7zr3zchMYBj4jsYeo3R6Utyj5g2SvfKe76VzZOHbrQfp449iwyo3VWgfogQAjsfWBG1+4y7Ug25myaUpYBBOR8/X3jYNibwdFtQNftZvrHcnvrFAlvSNW1+VgZg1kl3oqZK5sgRYchdaOsDuNTlSRomZ9aVcHUmvyxPsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718175; c=relaxed/simple;
	bh=hzbLQKjNNbMl8Bsoa7a6J/6lgjpI06e59QNz+XS41Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv/MUrJng6agiHNx7bEdZ5JBC4Ft9sNecq/a/+CqhXStZLZOcs/2QvYDUjmuj9sEczwtX98ipqcv1PJUA/j/muoXbqTfgY0MZSbpCBPTkuxh6TUSqzJZSfL1MUnuWQVQdQCzBHgFTIJcRJf3kklSluaxggZw+NWOCA6HQerLxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUiE0emP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C09C4CEC6;
	Sat, 12 Oct 2024 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728718175;
	bh=hzbLQKjNNbMl8Bsoa7a6J/6lgjpI06e59QNz+XS41Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUiE0emPTqdb2/ZpbRmSX5jX0nv01ty7uZ3HSVXNlCz8Vd2wuLwNcWsasTFPCQKqG
	 Ht3dHj3aoQB4W4U6i4tUa5j2sFjmz/BpEhzhOtw4Pzc27cGtBP4Kuc1eNGbRIjmjeK
	 r1uFT4SgDUmQ6vrfSbTeMoPGgReoI4Xv7+V4qi7s=
Date: Sat, 12 Oct 2024 09:29:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Josef Zoller <josef@walterzollerpiano.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] Character device abstractions for Rust
Message-ID: <2024101256-amplifier-joylessly-6ca9@gregkh>
References: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>

On Fri, Oct 11, 2024 at 08:55:41PM +0200, Josef Zoller wrote:
> Writing character devices is a common way to start writing kernel code,
> especially because of the book "Linux Device Drivers", which is still
> one of the best resources to learn about Linux kernel programming. To
> allow an easier entry into Rust kernel programming specifically, this
> series adds abstractions for these kinds of devices to the Rust API.

I understand this, but if at all possible, I would prefer that people
stick to using the misc char device interface instead.  It's much
simpler and integrates better into the overall system (handles sysfs for
you automatically, etc.)

I've already merged the misc device rust bindings into my tree, so why
not just stick with them?

> I also included a sample that demonstrates how to use these abstractions
> to create the simplest example from LDD3, the "scull" device.

This is great, but why not just provide the scull example using misc
device?

> I'm also aware of the patch series about misc devices that was sent
> recently. I think these are both valuable additions to the Rust API, and
> could even be combined in some way, in which case the file operations
> abstractions in both series should probably be separated and
> generalized. But I'm still sending this series as it is, because it is
> my first ever patch and I could use some feedback on my approach.

That's great, but I'd prefer to stick with the misc code for now until
someone really really really proves that they want a "raw" char
interface.

thanks,

greg k-h

