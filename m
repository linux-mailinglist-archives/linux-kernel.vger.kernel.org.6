Return-Path: <linux-kernel+bounces-565724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD941A66E18
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD4516C7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42CA1F582A;
	Tue, 18 Mar 2025 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1Zci4gc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366731E5211;
	Tue, 18 Mar 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286279; cv=none; b=msDV2D84EgdK1neWB6Jt3DkWeAZgLk98iAfrG+K7/ujjC3HF6TjtAWmh+f0MY8aYSsQ0Jdoq0LMZNuoYk+fDblLUomq78PDh8qzQ7d1Ufsi376by/AZjxXZc09eO+mQkkMD+z+dHNDKU/Afkl78qvMAsKG8IxENKi4HbfKYmRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286279; c=relaxed/simple;
	bh=gRu9LnNRDLFAairOzTMCBNyMq2GECnLmUAWlGFQxuwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLXdaDqkAjlsXAg8zsHO9SoHI8FLKLNNPXlsTu8uOwJfxDqYw9G7VldMYR3J0vwD02aVoqBeNEWMQjp/aDmShpemZWqCw6pzDnYUh+Bb+Y4anxoceo/ekarqkAcZTHf/ZMRGLlmc7T9qxxi9Oe/RVu6fZ7eOPiiwowldnhsS/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1Zci4gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042BBC4CEDD;
	Tue, 18 Mar 2025 08:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286278;
	bh=gRu9LnNRDLFAairOzTMCBNyMq2GECnLmUAWlGFQxuwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1Zci4gcCGimKE0usIWD3CZSEczFp99Gd+3jOZrGM+QlS8cWtVQAxkvZqaW0aZhLE
	 VuN88Txl3xXy8VG3SQgWp0D+4J1Kz3R/1cPlOUmqJGMYDPEe/eiFTUdyNXN0W5N55e
	 riaIy4HuXsO+z840tXwizIAZad4CT4NriuMd3F8W/SUWEXJRlZ3OYQGINUiYsVqimL
	 2J1vG7PlYPJ9+m7yUyhJhqYhem85ntexdzuBRwoYGoujbo+LtNJWidp9YL0Ihjqr9D
	 LH94nll+g8MYSAxLPm8tEPqYZw/gRvoije4c3aUyJc4Ks+gMyjpK+HJeNqHfRORCi+
	 fkYSTh7p6dJng==
Date: Tue, 18 Mar 2025 09:24:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Grace Deng <Grace.Deng006@gmail.com>
Subject: Re: [PATCH v2] rust: file: optimize rust symbol generation for
 FileDescriptorReservation
Message-ID: <20250318-ankommen-entkam-5a89f05374a9@brauner>
References: <20250317023702.2360726-1-kunwu.chan@linux.dev>
 <Z9f4Twvl-UaX1NQp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9f4Twvl-UaX1NQp@google.com>

On Mon, Mar 17, 2025 at 10:24:15AM +0000, Alice Ryhl wrote:
> Adding Christian Brauner who originally merged the
> rust/kernel/fs/file.rs file.
> 
> On Mon, Mar 17, 2025 at 10:37:02AM +0800, Kunwu Chan wrote:
> > From: Kunwu Chan <kunwu.chan@hotmail.com>
> > 
> > When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> > with ARCH=arm64, the following symbols are generated:
> > 
> > $ nm vmlinux | grep ' _R'.*FileDescriptorReservation | rustfilt
> > ... T <kernel::fs::file::FileDescriptorReservation>::fd_install
> > ... T <kernel::fs::file::FileDescriptorReservation>::get_unused_fd_flags
> > ... T <kernel::fs::file::FileDescriptorReservation as core::ops::drop::Drop>::drop
> > 
> > These Rust symbols are trivial wrappers around the C functions
> > fd_install, put_unused_fd and put_task_struct. It
> > doesn't make sense to go through a trivial wrapper for these
> > functions, so mark them inline.
> > 
> > Link: https://github.com/Rust-for-Linux/linux/issues/1145
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> > Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> > Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I mentioned various times that anything fs related goes through the VFS
tree, I hope that we're all still aware of this agreement.

