Return-Path: <linux-kernel+bounces-546488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CDA4FB38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9498188B185
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15DC206F31;
	Wed,  5 Mar 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCK+Rieb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C92066FE;
	Wed,  5 Mar 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169220; cv=none; b=TPZjUPmqfha1wS1gozfJJuHHQt5JQpxyUM6vrbHeDO1wKReiCDCajzYc52apw303d0zhoo4dtCDiI/ulCBER+qp0DanCIStWUZl2hwGdN1xJ8x/dELeHBulLUiklpozPeWKAvxV5Y7tBcR9Zg6X/Zhsc1FIIqF0p+ie11ZbgB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169220; c=relaxed/simple;
	bh=K3xFH1dgi0cEmWScmcna/0Rx41kFEEDqgqy3D8Iy5IA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ts5nkVNY2gk/af4ZqPZiuz+5rRRD6KJb5FhUQSSGRn58o2fgALbDP6eBEpDAWZ2hvnT4sqUXymI4HPWERcbOcFv9r+6XxUs6DFFdlQGB2KxC0MWzHqJpaMivbhZFd5tU5ubprCbgMQJaFmW6hmH8iz/YpKessrDkko9Mpa43Zbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCK+Rieb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABCBC4CEE2;
	Wed,  5 Mar 2025 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169219;
	bh=K3xFH1dgi0cEmWScmcna/0Rx41kFEEDqgqy3D8Iy5IA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HCK+Riebf8ssA9tFfqvcPVw3ny7AYCaPZ7W5jo7k7aV8B7xUWXuxrfnAczebul6He
	 D8y4YDzSG6R7xn6qinlKs2wVALymCWulIkoPLjy6GFKjYbF17pH+f9xMQiz8sXShAJ
	 WAZQFRrgcMcM3416PtJdE3MQ0S9Tm+AEtmZVkq6L3wqe+DqoKK6WTw0RI06eawiHic
	 nWELVh6lKzu5gDBrMuFfm1N6KrnEcKUzRYiBw1vAPLSDS21IWSFV0nLTYnq8bkEl5g
	 lzcvHI1oRNBS7OTd/4UZYHvT1pxsIBR4w7KKh5bTb4QirVFkilvCJj0t95i2HTAY4K
	 xlpmuIvtj7Low==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 05/22] rust: pin-init: change examples to the user-space
 version
In-Reply-To: <20250304225245.2033120-6-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:46 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<L9IwEZhI4XYoYJD5FGNbUTkzgDpl7e5-GkR51eXkQUTbZoFK2EChCLlXUqhLphiO3SQ5m1nV75b4Qp8TS8kYIw==@protonmail.internalid>
	<20250304225245.2033120-6-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 11:06:49 +0100
Message-ID: <8734frg5ae.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Replace the examples in the documentation by the ones from the
> user-space version and introduce the standalone examples from the
> user-space version such as the `CMutex<T>` type.
>
> The `CMutex<T>` example from the pinned-init repository [1] is used in
> several documentation examples in the user-space version instead of the
> kernel `Mutex<T>` type (as it's not available). In order to split off
> the pin-init crate, all examples need to be free of kernel-specific
> types.
>
> Link: https://github.com/rust-for-Linux/pinned-init [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/pin-init/examples/big_struct_in_place.rs |  39 ++
>  rust/pin-init/examples/error.rs               |  27 ++
>  rust/pin-init/examples/linked_list.rs         | 161 ++++++++
>  rust/pin-init/examples/mutex.rs               | 209 ++++++++++
>  rust/pin-init/examples/pthread_mutex.rs       | 178 +++++++++
>  rust/pin-init/examples/static_init.rs         | 122 ++++++

Do I need to review all these data structures and algorithms?

[...]

> @@ -76,28 +84,34 @@
>  //! above method only works for types where you can access the fields.
>  //!
>  //! ```rust,ignore
> -//! # use kernel::sync::{new_mutex, Arc, Mutex};
> -//! let mtx: Result<Arc<Mutex<usize>>> =
> -//!     Arc::pin_init(new_mutex!(42, "example::mtx"), GFP_KERNEL);
> +//! # #![feature(allocator_api)]
> +//! # #[path = "../examples/mutex.rs"] mod mutex; use mutex::*;
> +//! # use pin_init::*;
> +//! # use std::sync::Arc;
> +//! # use core::pin::Pin;
> +//! let mtx: Result<Pin<Arc<Mutex<usize>>>, _> = Arc::pin_init(CMutex::new(42));
>  //! ```

Should this be `CMutex<_>` on the lhs?


Best regards,
Andreas Hindborg




