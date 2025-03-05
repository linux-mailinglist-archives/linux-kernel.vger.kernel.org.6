Return-Path: <linux-kernel+bounces-546782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B4A4FEB3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C342188F93B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF0245036;
	Wed,  5 Mar 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt/LR+7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C88244EAB;
	Wed,  5 Mar 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178058; cv=none; b=jN4sRw3kOu4OpAheNIuXjBG2f4eBHo19D8Hp5C/KcYSN92l+sahMnRhJylU6zv0E5hqIl7kwovW0/Rkzoo+eKFaOSsrVrAVcm/CWg0QJJ6+w+qbUZONzYl4awfTzKD/Z+JG9039jNOTQn/euI+N3Fd0dHfnMg4L3riNOl0Dh7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178058; c=relaxed/simple;
	bh=16uSByWLg025WnpH3q9e76OHGQdq4UuQLT0RSk+r/Jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ul99ZH5rfAXaqqzkKtA2K40NgVz8co1ibSmH1xwGJQ62FzZEMkqMSdoCe8uqVr2pUQlA3Bp83DQywJVeVUWt19gFJg2LLs2XQk7sf5UDluBVVRkIyIn4C74rWju/VOQ47/e0kcR9Z7pXdCanOUWGKLHHAA96hIbcGCMhiGDOE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt/LR+7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D629C4CEE7;
	Wed,  5 Mar 2025 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741178056;
	bh=16uSByWLg025WnpH3q9e76OHGQdq4UuQLT0RSk+r/Jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mt/LR+7KvlmKcLWsX3w9K1Yt1tDVvjNTkBldwk8//XjC4uMiFiyhJVAOuxDJ16TJ4
	 W986iNTkUkyZld2DmjdTqrX8FpMiOd99/8h3Y41WOKX2LFMPYzuldykffDiJ2BlVUF
	 uLxba1uuv+f0sH6yDwNFRvfwbLvzrSyugsyb5NqdYGedwhYHdafl/Us4WsFumfL8mu
	 Ph7XUuetARr6366eqR1BNaVfhA7uMWYUJi0Ez3w5QP/4THlhzxnAEhTlZhtbpjTpxn
	 3nFwkGPifyL6h7aaGIVispo9EWz2rCsRbodVGljVppxPP8xgU1GhAw+N7Q/e41YX4X
	 iD3Zvhbh64sqQ==
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
In-Reply-To: <D88BIUUNXQK5.3BFLFUBWAS0H2@proton.me> (Benno Lossin's message of
	"Wed, 05 Mar 2025 12:06:52 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<iamkKusKoPQ37SKTEy2SbZjH0szdD4f3Zss6AcRF5jAkltpuR9blYqQ3Qc0Vd_gJBwPbefblnClu4okTA-TLLg==@protonmail.internalid>
	<20250304225245.2033120-9-benno.lossin@proton.me>
	<87frjrene8.fsf@kernel.org>
	<yOvQB5qHfHQi6IYDiDOUtboOxQ-0xzUQZNt63_wDaqGcBbQeUy87JtAW-euoLQvXgZYu9JbaqpsDGyGaZXRJCw==@protonmail.internalid>
	<D88BIUUNXQK5.3BFLFUBWAS0H2@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 13:28:31 +0100
Message-ID: <87r03bbr0w.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 5, 2025 at 12:18 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> In order to make pin-init a standalone crate, move kernel-specific code
>>> directly into the kernel crate. This includes the `InPlaceInit<T>`
>>> trait, its implementations and the implementations of `InPlaceWrite` for
>>> `Arc` and `UniqueArc`. All of these use the kernel's error type which
>>> will become unavailable in pin-init.
>>>
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>> ---
>>>  rust/kernel/alloc/kbox.rs |   3 +-
>>>  rust/kernel/init.rs       |  55 +++++++++++++++++
>>>  rust/kernel/prelude.rs    |   3 +-
>>>  rust/kernel/sync/arc.rs   |  65 +++++++++++++++++++-
>>>  rust/pin-init/src/lib.rs  | 125 ++------------------------------------
>>>  5 files changed, 127 insertions(+), 124 deletions(-)
>>>
>>
>> [...]
>>
>>> --- a/rust/pin-init/src/lib.rs
>>> +++ b/rust/pin-init/src/lib.rs
>>> @@ -10,7 +10,7 @@
>>>  //! To initialize a `struct` with an in-place constructor you will need two things:
>>>  //! - an in-place constructor,
>>>  //! - a memory location that can hold your `struct` (this can be the [stack], an [`Arc<T>`],
>>> -//!   [`UniqueArc<T>`], [`KBox<T>`] or any other smart pointer that implements [`InPlaceInit`]).
>>> +//!   [`KBox<T>`] or any other smart pointer that supports this library).
>>
>> Would you not want to remove references to `KBox` here as well? Even
>> though you don't have to move the impl, I don't imagine `KBox` exist in
>> user space?
>
> Yes, this is done in "rust: pin-init: fix documentation links".

Yea, maybe I should have read the entire thing before firing off emails.


Best regards,
Andreas Hindborg




