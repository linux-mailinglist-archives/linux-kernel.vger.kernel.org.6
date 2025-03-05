Return-Path: <linux-kernel+bounces-546719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B2A4FDFE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D813ACDFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD836242904;
	Wed,  5 Mar 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwnAyeUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871A2192E5;
	Wed,  5 Mar 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175368; cv=none; b=F1MHWW/BR/SzZRpdOMd9BfztKA3i4R8gIi78/MQFAe0Rpcydt8hbO0DkFHhivbmYmxQ18gAwWltWfZvkhpidywMgjMZiMYvD8pmihsn0eG4ay6VGyJXQeL0LfL4QSpqNEJCqp+L393mp8J6V1cwxT5Chv2e/A12pUdJ3dEVp2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175368; c=relaxed/simple;
	bh=NBr9Q2RXgPKH9XXDG19sP/AHqRwo//KnQ1kt9nstHD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3Vmr5Qm6yI6tESNCdDkNNkjDE7Bx70UYRRx31dFud+JSPMCkKMKaxmqM1OwbkflYDNu1QAfYC7T7+qd0HtjTBYsUrLalag+VwAhbOrBCTlGZD/0otba9tMQz6DarujtHggcL/5M1Sv9SV5sFgPZwTh1pDJ81SsMhJIqB65xekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwnAyeUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3073EC4CEE2;
	Wed,  5 Mar 2025 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175367;
	bh=NBr9Q2RXgPKH9XXDG19sP/AHqRwo//KnQ1kt9nstHD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DwnAyeUuy6ckcVsay+nxEhBYOc15Lv3QoZ3qnqYl6oZcu2dFyEH9dui6MmbxKHivS
	 f2KlRQ3a9a5MeIrf4PcEuZw0tiRxqzgfnuOdgGSkjE7gJ0U4moiOQmpy44xTkI4/HN
	 YIj6pyeTtieti35VO1Ppq7MLqaADUULoB3LczF8x+ebcsg0rs9/zwGHNcgy+BA2Lby
	 Vx5jGyeILyjgl5sfvHIuJTlrmuieB+/RonaKcxVx1mZJZjY5sa/P6dR5pMmomeucDz
	 IBo5HpnXbPsb1ulterz3+4mhId26ZHugzWoIsQTEtLV1eLqChxONNx+9Y//UMcKbi4
	 gPyE+r25lKtQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/22] rust: pin-init: remove kernel-crate dependency
In-Reply-To: <20250304225245.2033120-13-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:50 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<3-KVPpYsvS6jLhJOL7kCLrypBUWO1rtUDTDUTfy8T_iGZObM3CP6YUK_QLHmL_QTivMtd3jfnRbZOGpClk37cQ==@protonmail.internalid>
	<20250304225245.2033120-13-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 12:49:17 +0100
Message-ID: <87senrd7eq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> In order to make pin-init a standalone crate, remove dependencies on
> kernel-specific code such as `ScopeGuard` and `KBox`.
>
> `ScopeGuard` is only used in the `[pin_]init_array_from_fn` functions
> and can easily be replaced by a primitive construct.
>
> `KBox` is only used for type variance of unsized types and can also
> easily be replaced.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

> ---
>  rust/pin-init/src/__internal.rs |  2 +-
>  rust/pin-init/src/lib.rs        | 41 +++++++++++----------------------
>  2 files changed, 15 insertions(+), 28 deletions(-)
>
> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
> index 0db800819681..74086365a18a 100644
> --- a/rust/pin-init/src/__internal.rs
> +++ b/rust/pin-init/src/__internal.rs
> @@ -105,7 +105,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
>      }
>  }
>
> -pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
> +pub struct AllData<T: ?Sized>(Invariant<T>);

Off topic, trying to learn something: You define `Invariant<T>` like so:

  pub(super) type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;

Consulting the variance table at [1], could you define it as

  pub(super) type Invariant<T> = PhantomData<*mut T>;

or is there another reason for using `fn`?


Best regards,
Andreas Hindborg


[1] https://doc.rust-lang.org/nomicon/subtyping.html#variance



