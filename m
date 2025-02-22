Return-Path: <linux-kernel+bounces-527069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB3A406FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2084F19C6EED
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6420765F;
	Sat, 22 Feb 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTAvTJwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4A2066ED;
	Sat, 22 Feb 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216973; cv=none; b=bxIK2OxoBSEnjU2qwQBgRxPTVZB7UTQui1wCtVcG1GnawO9KVFphZnQg8RvVNrE+QLLUvqiea7swHIV+SCB+HU5GIrmyFKnodkIbZzp7eP0m/rDYWfPHrGtKKr/40i9Ab7Cai+woR2bTT3agqSlPLJQ5bxZSxTETCgOKoE0A4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216973; c=relaxed/simple;
	bh=p5e/j6u/BbXJrB7ethy2lnf/FAY6c0UCQhBezXuzcrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijWrqwEpjeH36RlzSWyCup4JO8t3/G16QbjLQjkqDX86+iASWBv58cWqh0syhMISqldbOaNtqky8UWszIjW6Z7EUsW9CPhDkr/caumwL4arRgnyZmIDkbRloY2/ZrrkXsgGU/GOf1S6jve0/6y8EMvij+EpBKbtYIalVEZ5/WfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTAvTJwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C602C4CED1;
	Sat, 22 Feb 2025 09:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740216973;
	bh=p5e/j6u/BbXJrB7ethy2lnf/FAY6c0UCQhBezXuzcrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fTAvTJwVfHY5PaULtqW96kIfnHSr3glebzUp3/0iBp6mOWs0V3TLJXXDPGBdhMgcJ
	 4/ivd9RI/J5Dsbl7pmS9ZnY1b29hdi629jJb8qKOUkBS86fIMqjO1cJJ231mN3WGQP
	 xaPUYMd15WXZ4oLyF7wrCKGie4DPNsfApmkfz1bRzP7Y15A4Sj8kz8GVM46i87PnDe
	 l0SJNB7pjWOwOVqtsN6HNeS66Oq/7yJKPDRUAiBcPlIaWb0aKcJO/EImH7+HV9M1Wi
	 /M3zaEsXIBjnqbfseHpjgrIGQSpBl8luhEOXfG64nBzMXwGT11VqgKhiq5jvo15Ul3
	 M7BfgbovutROA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Ingo Molnar" <mingo@redhat.com>,  "Will Deacon"
 <will@kernel.org>,  "Waiman Long" <longman@redhat.com>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Joel Becker" <jlbec@evilplan.org>,
  "Christoph Hellwig" <hch@lst.de>,  "Fiona Behrens" <me@kloenk.dev>,
  "Charalampos Mitrodimas" <charmitro@posteo.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] rust: configfs abstractions
In-Reply-To: <50E0963F-2CFA-462E-9767-626F0D18C77F@collabora.com> (Daniel
	Almeida's message of "Fri, 21 Feb 2025 12:18:24 -0300")
References: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
	<YvvODTELgzFba5yz9qV-d4kS5Q121lVk6WoCpoHdWde5un9OwNI3k_BDPE5GZkSfG-4s9csjG0h7Oy9VTsI0Ww==@protonmail.internalid>
	<50E0963F-2CFA-462E-9767-626F0D18C77F@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Feb 2025 10:36:01 +0100
Message-ID: <87seo6coe6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Andreas,
>
>> On 18 Feb 2025, at 09:57, Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> This series adds a safe Rust API that allows Rust modules to interface
>> the `configfs` machinery.
>>
>> The series contains an example for the samples folder to demonstrate
>> usage of the API. As such, there is no inline example in the
>> documentation.
>>
>> The last patch adds a maintainer entry for the Rust configfs
>> abstractions, to make it absolutely clear that I will commit to maintain
>> these abstractions, if required. Feel free to drop this patch if this is
>> not required.
>>
>> The series is a dependency of `rnull`, the Rust null block driver.
>> Please see [1] for initial `configfs` support in `rnull`.
>>
>> [1] https://github.com/metaspace/linux/tree/9ac53130f5fb05b9b3074fa261b445b8fde547dd/drivers/block/rnull
>>
>
> I am trying to test this before reviewing, but I get this error:
>
>
> ```
> error[E0308]: mismatched types
>    --> linux/rust/kernel/miscdevice.rs:300:62
>     |
> 300 |     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
>     |                           ---------------------------------- ^^^^^^^ expected `*mut <... as ForeignOwnable>::PointedTo`, found `*mut c_void`
>     |                           |
>     |                           arguments to this function are incorrect
>     |
>     = note: expected raw pointer `*mut <<T as miscdevice::MiscDevice>::Ptr as types::ForeignOwnable>::PointedTo`
>                found raw pointer `*mut ffi::c_void`
>     = help: consider constraining the associated type `<<T as miscdevice::MiscDevice>::Ptr as types::ForeignOwnable>::PointedTo` to `ffi::c_void` or calling a method that returns `<<T as miscdevice::MiscDevice>::Ptr as types::ForeignOwnable>::PointedTo`
>     = note: for more information, visit https://doc.rust-lang.org/book/ch19-03-advanced-traits.html
> note: associated function defined here
>    --> /home/dwls/dev/linux/rust/kernel/types.rs:98:15
>     |
> 98  |     unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Borrowed<'a>;
>     |               ^^^^^^
>
> error: aborting due to 1 previous error
> ```

Thanks for testing! It seems there is a bug in the patch "rust: sync:
change `<Arc<T> as ForeignOwnable>::PointedTo` to `T`". If you would
like to test now, could you either:

- add `.cast()` on `private` in miscdevice.rs:300
- or drop patch 1/4 and pick [1] as a dependency instead
- or build with `CONFIG_COMPAT=n`

Or wait for me to send a new version where I add a dependency on the
fixed patch.


Best regards,
Andreas Hindborg



[1] https://lore.kernel.org/all/20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com/


