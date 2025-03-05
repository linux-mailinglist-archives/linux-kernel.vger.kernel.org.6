Return-Path: <linux-kernel+bounces-546439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C5A4FAB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC483ADB97
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2C2066C3;
	Wed,  5 Mar 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FumxnhAf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197D205518;
	Wed,  5 Mar 2025 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168394; cv=none; b=KG8/Vbq2lwEoWM6GcOR+TVCeokv794tleZpC3Myv8h1Y1WJ6IGIN49mkxrZl88CaXR/ITy3+WHgiiahBZMTvExj+gPY6GU/yf8UFZECnBSIHukTyuh9kzyrjhWUEuk/M1iMwdrK+AHXZhB5upKe7VCpPMtjzZZIA0E6q539BZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168394; c=relaxed/simple;
	bh=UML+iHb2dTlgk19CzW49qLsC4xLAUZs1v41pgqomKkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNHJSjdoAa+UKBn2cxO5DkD3Pq68kYWeJyOlgQsn8YXbu0QJdd1iNMQR7Fy+J2NZUXVeRCnsQXE2aFFo1PPsqqVTLUw83euxPn5HMg0lQTjtY3yot1EB3/e3Pg2gy5iyoPRLzMZT6mSy0jFbmftCzgkdcVTOJk+AbUttDAdevyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FumxnhAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287AEC4CEE2;
	Wed,  5 Mar 2025 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168393;
	bh=UML+iHb2dTlgk19CzW49qLsC4xLAUZs1v41pgqomKkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FumxnhAfZ61FgXfJiNgxadYUcoWd9QhgLpStY2IJ5W8kXY412KeyaVvVkFPzC4vJF
	 KfJgK5egnM4lVpcJnFeMEGcHytIqeUf/JGpABOFCBDuwCqT49ZPtSc9Qnx9gWgvNi2
	 eDWxCDIfHaxBS69T7ynbLFaA2keRkWu4u2GLG2v8MvqaqSZxcNkLQ6q81JAt8fd4hR
	 YkMJPWP7BdmLl5VDTtxqXQWMyvoi3Jwilvkh5deRRVp/VDOm7SCV8tF1wjhPkLNkOO
	 +GAOUZ/2gC1GJiNcb9rPP0ZKdOyr4wV8Ow3Zv4jSznYePGfvyjsanE4TetohjxmsUo
	 2RO3zKPNMk5Zg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 02/22] rust: move pin-init API into its own directory
In-Reply-To: <20250304225245.2033120-3-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:16 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<tvMbtzZXTxG78GP05XwEiqdeUOb_IML2s97GEvGeEMHTYdJh2PKo7gRP7FPhaTlJnS16gC34KvGWMg16mR69VQ==@protonmail.internalid>
	<20250304225245.2033120-3-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 10:03:59 +0100
Message-ID: <87jz93g874.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> In preparation of splitting off the pin-init crate from the kernel
> crate, move all pin-init API code (including proc-macros) into
> `rust/pin-init`.
>
> Moved modules have their import path adjusted via the `#[path = "..."]`
> attribute. This allows the files to still be imported in the kernel
> crate even though the files are in different directories.
>
> Code that is moved out of files (but the file itself stays where it is)
> is imported via the `include!` macro. This also allows the code to be
> moved while still being part of the kernel crate.
>
> Note that this commit moves the generics parsing code out of the GPL-2.0
> file `rust/macros/helpers.rs` into the Apache-2.0 OR MIT file
> `rust/pin_init/internal/src/helpers.rs`. I am the sole author of that
> code and it already is available with that license at [1].
> The same is true for the entry-points of the proc-macros `pin_data`,
> `pinned_drop` and `derive_zeroable` in `rust/macros/lib.rs` that are
> moved to `rust/pin_data/internal/src/lib.rs`. Although there are some
> smaller patches that fix the doctests.
>
> Link: https://github.com/Rust-for-Linux/pinned-init [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




