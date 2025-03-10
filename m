Return-Path: <linux-kernel+bounces-554966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2621A5A3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D19F17463B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED2D235C17;
	Mon, 10 Mar 2025 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="s34v09VR"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887AD23314B;
	Mon, 10 Mar 2025 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635826; cv=none; b=JIke/rxwkuekrSy8E43FW/6labcEZwW1WusonaPEuJTwDc47W3KwUh7TUaC/gXjZ0zAStjbYs2vyp3QA/RYs6ER3/w2i+qHrglnjQcC4ybi+Kw4yOBc69HjGXTelZXik3d3oZ9sRo/WIc0l0DBWi1FQDX6LgZ7Cx6gHbyoE70Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635826; c=relaxed/simple;
	bh=EBeSqGsWh99jM7FdCeMPDFr6tUW4TS/q4W5vwqPndiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIPA83HCES3LSzc/DVxtudIuaxG1PqGA9lGdAQTZjJyklabMmGbMX8Jw8wRoBHIyBvHuDxewMgpTkPZ8EtqJxD1p8d9gsytCv7AVCYIB69jaVqbZ6MoRMdQaMQFjEVM0FjHuGm3a0SoGi2/Jm7ugz+JcEz3kbPRBq/DMcR9JNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=s34v09VR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZBS4X1mdqz9t8y;
	Mon, 10 Mar 2025 20:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741635820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdPzsDpFzcns41Z4zrZFjOaxo/jUnhJPhdoDRImnHR4=;
	b=s34v09VRiXKWoFrGgB+V5h+P8ouHIQYzPEBA+c/z+hSfFpSlRxFIPtGATNd0i20dRVVJ1e
	ED7z4XeniVEE8KJ/bLYfTx0/KhV1jnBuP1wn9MG75MuFveDoF5ymHxV0pSH2YmyYd5xJoO
	8dt3MMq1G3lqUqicaoiVDG91VYUn+XriQugepbpHfcC4QpePzJRi9SHaOPinE+I3bvKkX2
	4D1J/9nzU4yOrvCx8LaFBYYefMT864MAADjYRwbugublUaK06Oc92oWCME4p/DkmCXJSTs
	Df6KWUtlaOpL0FaVh/MsJd8Ejk8igc6hruP2BhnIXoUFt26dR86f0QvO1LiqVg==
Date: Mon, 10 Mar 2025 15:43:34 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] rust/kernel/faux: mark Registration methods inline
Message-ID: <whxgrdl7iuqrwei5orxyaohs7k52sy4ytc5jib64bi2wy5zsqu@m2vzkawsk5tt>
References: <20250309-faux-inline-v1-1-c1b692862433@ethancedwards.com>
 <2025031053-tribute-crudely-0e1d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031053-tribute-crudely-0e1d@gregkh>

On 25/03/10 07:19PM, Greg Kroah-Hartman wrote:
> On Sun, Mar 09, 2025 at 10:14:36PM -0400, Ethan Carter Edwards wrote:
> > When building the kernel on Arch Linux using on x86_64 with tools:
> > $ rustc --version
> > rustc 1.84.0 (9fc6b4312 2025-01-07)
> > $ cargo --version
> > cargo 1.84.0 (66221abde 2024-11-19)
> > $ clang --version
> > clang version 19.1.7
> > Target: x86_64-pc-linux-gnu
> > 
> > The following symbols are generated:
> > $ nm vmlinux | rg ' _R' | rustfilt | rg faux
> > ffffffff81959ae0 T <kernel::faux::Registration>::new
> > ffffffff81959b40 T <kernel::faux::Registration as core::ops::drop::Drop>::drop
> > 
> > However, these Rust symbols are wrappers around bindings in the C faux
> > code. Inlining these functions removes the middle-man wrapper function
> > After applying this patch, the above function signatures disappear.
> > 
> > Link: https://github.com/Rust-for-Linux/linux/issues/1145
> > Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> > ---
> >  rust/kernel/faux.rs | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> This does not apply to my tree.  Can you regenerate it against either
> the driver-core.git driver-core-next branch, or the linux-next tree and
> resend it?

Will do. My apologies, I based this patch off linux-next. I thought it
was customary to use the -next tree for whatever subsystem one is
developing against. I'll do it off of linux-next and send a v2.

> 
> What release/branch did you make this against?

Tree: https://github.com/rust-for-linux/linux
Branch: rust-next

> 
> thanks,
> 
> greg k-h

Thanks,
Ethan

