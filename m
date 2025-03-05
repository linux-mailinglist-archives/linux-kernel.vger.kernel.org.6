Return-Path: <linux-kernel+bounces-546666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A9A4FD79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8034D188F043
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EC6233701;
	Wed,  5 Mar 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe204XPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68F23717D;
	Wed,  5 Mar 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173663; cv=none; b=AQbnRmMflZ1m9Pnwo3hohs3JQYdbx7OSjBbT/tXB4FUMe/ZsCjpp8l5KN5Ecaei0iPXJUbzZ31bur1lPeFaEBFY2LNnxAdI0zT8oRvtUw7KGXewq2cf4hjXb1b610abdCBhR4/4g9RLvzIUb3f9qP/G8N+lSdIQ3e+pJDFv7toM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173663; c=relaxed/simple;
	bh=vyRxcS57ZvnzwUa+x+EWVuX/n8bdy00KR20m21ZjHlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIlNBYKJy4UwdSGytBbgLlTPhnM4uVmPvHlLfGuzGWnWOHeoBi8CezKbCotafgPvv0j54rM2aK399zGPXkyPqY10ff0n4eewQxVWmmcWJ6LfswxqpnfchnkfNguHyeuzWxdL1v0i4dMrrf+9dpdtZu68Ibhugg9wRzf7vDrV9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe204XPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C39AC4CEE2;
	Wed,  5 Mar 2025 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173662;
	bh=vyRxcS57ZvnzwUa+x+EWVuX/n8bdy00KR20m21ZjHlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oe204XPsQS9p3T+rnJLPN1tCuKZ38FsaFusXLZ8EXRxLJhpF7/2ff/juP/+673PU5
	 r7BqIYgRSOPmO2vJxXJLjHKkUUndrQjz2W3sKVnkEywZQbGBTXb1Mk4Iym+z9ORTvv
	 OYuF+Alc6M9Vpg32ct0kNNMLzf9gU9JRJIItWAT7i2oFBrLYVdyX2t7AvNZG8K0AbC
	 5HjHCYVjsP0o+nzRvZVBNOGVxpds9EGpV4uSqMFmz0YFubVnW6zRX/ARR+ow7WW9ZN
	 y7m9l0/3Z2WMeAlIcd3/n2eZfyaW1sbkHeXfPOosWdl3gS9XAq8F6W1kKxRKmHDPnT
	 IihSAujqJ75CA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/22] rust: pin-init: move `InPlaceInit` and impls of
 `InPlaceWrite` into the kernel crate
In-Reply-To: <20250304225245.2033120-9-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:54:16 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<iamkKusKoPQ37SKTEy2SbZjH0szdD4f3Zss6AcRF5jAkltpuR9blYqQ3Qc0Vd_gJBwPbefblnClu4okTA-TLLg==@protonmail.internalid>
	<20250304225245.2033120-9-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 12:18:39 +0100
Message-ID: <87frjrene8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> In order to make pin-init a standalone crate, move kernel-specific code
> directly into the kernel crate. This includes the `InPlaceInit<T>`
> trait, its implementations and the implementations of `InPlaceWrite` for
> `Arc` and `UniqueArc`. All of these use the kernel's error type which
> will become unavailable in pin-init.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/alloc/kbox.rs |   3 +-
>  rust/kernel/init.rs       |  55 +++++++++++++++++
>  rust/kernel/prelude.rs    |   3 +-
>  rust/kernel/sync/arc.rs   |  65 +++++++++++++++++++-
>  rust/pin-init/src/lib.rs  | 125 ++------------------------------------
>  5 files changed, 127 insertions(+), 124 deletions(-)
>

[...]

> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -10,7 +10,7 @@
>  //! To initialize a `struct` with an in-place constructor you will need two things:
>  //! - an in-place constructor,
>  //! - a memory location that can hold your `struct` (this can be the [stack], an [`Arc<T>`],
> -//!   [`UniqueArc<T>`], [`KBox<T>`] or any other smart pointer that implements [`InPlaceInit`]).
> +//!   [`KBox<T>`] or any other smart pointer that supports this library).

Would you not want to remove references to `KBox` here as well? Even
though you don't have to move the impl, I don't imagine `KBox` exist in
user space?


Best regards,
Andreas Hindborg



