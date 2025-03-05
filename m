Return-Path: <linux-kernel+bounces-546678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E8A4FD96
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA27A7AA155
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADDC2343C6;
	Wed,  5 Mar 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyhjVzSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF1230BD9;
	Wed,  5 Mar 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174019; cv=none; b=DSPQS/liJFbDG5ojn5pmpw+p+DnQLhe9WwaVr8cdc/GglHMz3HL1ZCiLQ2H3ccAF/N3NvT1V8mrGaBfKn+SCyg+NDi7pMQYrZaWemruNRd5gLvMjOoPPaqH1/gK9h1zVTi0DMgMc6HZAkI4LXlhKCAiMkX1PG+mJn0jumEB0Hk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174019; c=relaxed/simple;
	bh=FLt3n2UnwaL8j5dWbJnGnF4+8gws9xOWp3kSckS9sEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnvLv5/COJGR+0HnRm8ndEr0w4q6BN0ynJeiukB9NJwN9oIwwtIATnaAVKxBwsMU9YKxlmUxCchzc3kWDIVxUiU339/RdWwXm86wUDPri5Og0PQqdHohyh6b4fEnX7/rRCQNY0RTpDOJkuqtr1veJ5/5jtg87mWPjSg40VfIGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyhjVzSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B55AC4CEE2;
	Wed,  5 Mar 2025 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741174019;
	bh=FLt3n2UnwaL8j5dWbJnGnF4+8gws9xOWp3kSckS9sEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hyhjVzSBZjkLVFiqc12SCL9U3/ffzq0tcmH9B+5S/eUW7QgFlWvDMWzCB/Dwgyuua
	 BfLr8NnDdXeUKQTcMRFWQJi96myN1Acj4Bur+CqE1trXwzlGEp3fElZkXU6IzqpGqG
	 zRr42KR5zKdIsdB+JMCFfP2n4DDB2Y0qtOi6rlosM2tdQNMD4RmOfUhEbxbhh4dIKU
	 7E4JABicDbKngUOywVG6PA6u5Nj/NjKlFzF8FhDXRK5FiypEVeRg5ydqrrIRIscylC
	 VZzgrZUnKL6bUv9UNdSag0BPmi1CO6BWW1HH8hbik+SX2QtS9ithzneL9uE6rSQROu
	 4AglAV92D6FKA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque`
 and `Option<KBox<T>>` into the kernel crate
In-Reply-To: <20250304225245.2033120-10-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:23 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<msi970CObD4bpxAIjK__fZnRG2q-BXd4FHuA1U1NR80D_dTqSXuQ-0-4R1TS7-7CglN6StcS3Os-IumgWcVLqw==@protonmail.internalid>
	<20250304225245.2033120-10-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 12:26:50 +0100
Message-ID: <87a59zen0l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> In order to make pin-init a standalone crate, move kernel-specific code
> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are part
> of the kernel, move their `Zeroable` implementation into the kernel
> crate.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/alloc/kbox.rs | 8 +++++++-
>  rust/kernel/types.rs      | 5 ++++-
>  rust/pin-init/src/lib.rs  | 8 +-------
>  3 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 39a3ea7542da..9861433559dc 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -15,7 +15,7 @@
>  use core::ptr::NonNull;
>  use core::result::Result;
>
> -use crate::init::{InPlaceWrite, Init, PinInit};
> +use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
>  use crate::init_ext::InPlaceInit;
>  use crate::types::ForeignOwnable;
>
> @@ -100,6 +100,12 @@
>  /// ```
>  pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
>
> +// SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> +//
> +// In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant and there
> +// is no problem with a VTABLE pointer being null.
> +unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> {}

Could you elaborate the statement related to vtable pointers? How does
that come into play for `Option<Box<_>>`? Is it for fat pointers to
trait objects?

Otherwise LGTM.


Best regards,
Andreas Hindborg




