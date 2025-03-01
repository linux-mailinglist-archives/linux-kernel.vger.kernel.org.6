Return-Path: <linux-kernel+bounces-539804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6932A4A8F8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325A6171196
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 05:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CBA1C3BF1;
	Sat,  1 Mar 2025 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OkeMPNkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052F1C3306;
	Sat,  1 Mar 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740807149; cv=none; b=Mke1QgTQ0MUtd0bzRtCTkiJ6hwMOd0+YGdWUn7b01hxX1mrPhEkG3XJas/UUJ/0+6YamGkFdSeXPmy3+GzgdeYeD6z2Ikk0drH4rgEoGdcehf8HjoOvTo56bg33gGu19q+6i8mFS4lpBcJCA/BO/Cgoa4/ETtS37hVzEms3OAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740807149; c=relaxed/simple;
	bh=CA6olSGGKBIH/ON8PnnZwKMlP0vmMnXmOSf0Ag+M+ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9bU77xVQRUz7aXV+qrzMvKXHDllG+YVCxsnZmiOX90XblCdXGlhgMe2LHkYFxQz+FAhZ+r7gcqrYlyeCFIz1scZTVUYLwcl/8AUUheyb1BFH4T/J7f5yRx40tk2OFayU/QQRE3vHEI90thEvu8QiiOVXpBiULvjIzhqU02mvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OkeMPNkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B41FC4CEDD;
	Sat,  1 Mar 2025 05:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740807149;
	bh=CA6olSGGKBIH/ON8PnnZwKMlP0vmMnXmOSf0Ag+M+ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkeMPNkjrqbqtX4lRcqOvLTD7bGsj98v/EQ2uvWbUh+plLbt+o7uJt6ImjjUc3tKT
	 s3VDU4HXrw83PtDLtE52x40Ib5pIRpI/5jRV17tV7X3TWK/Y4ZXzkZNFlqREXO3B5X
	 WlV4MxleGQq1+K0SJER51vIqFE7gGznMZGncWY4w=
Date: Fri, 28 Feb 2025 20:43:49 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/5] Check Rust signatures at compile time
Message-ID: <2025022838-dole-skittle-112f@gregkh>
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-export-macro-v2-0-569cc7e8926c@google.com>

On Fri, Feb 28, 2025 at 12:39:29PM +0000, Alice Ryhl wrote:
> Rust has two different tools for generating function declarations to
> call across the FFI boundary:
> 
> * bindgen. Generates Rust declarations from a C header.
> * cbindgen. Generates C headers from Rust declarations.
> 
> In the kernel, we only use bindgen. This is because cbindgen assumes a
> cargo-based buildsystem, so it is not compatible with the kernel's build
> system. This means that when C code calls a Rust function by name, its
> signature must be duplicated in both Rust code and a C header, and the
> signature needs to be kept in sync manually.
> 
> To eliminate this manual checking, introduce a new macro that verifies
> at compile time that the two function declarations use the same
> signature. The idea is to run the C declaration through bindgen, and
> then have rustc verify that the function pointers have the same type.
> 
> The main commit of this series is "rust: add #[export] macro". Please
> see its commit message for more details.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

