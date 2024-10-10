Return-Path: <linux-kernel+bounces-359218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93D9988D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BC8B2BB04
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD231CB31D;
	Thu, 10 Oct 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJorL8op"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AED1BDA99;
	Thu, 10 Oct 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569341; cv=none; b=TrOqF+fmps2k8xNTw6o9Im015K9CF+Y5kKYdJshI3D544JBfqk0QmfP9EalKbaXWih0mg4AgEEnJeE36MuCRNoB6aEIbsJkZrFU7u19FJncmaUWEnvI13w14t20gaPrX7AiCNZjcrmtOyu2RTqTF0tkBUVCJ2TvjPH+xfXpmC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569341; c=relaxed/simple;
	bh=MhY14OUxfKnWjSa6kqd9bLIkjToin0Y4gpVt4tN8O1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Evl4oyr3AMOtKuidsG7f/DUZJn+/pcDUNK/tc8vfFZtoa3oOgHh+606UpdxsuI3GofEt0oXNDQjmaz8ppT1gkuo7hQ4cYWeSQhp5mUErBPRSAul5Xbp6evyKd/YL/uwa5dYPq87JsW5BmGon1hOpFmL/rjqRgiTsXFq4CoVFOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJorL8op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B92C4CEC5;
	Thu, 10 Oct 2024 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728569340;
	bh=MhY14OUxfKnWjSa6kqd9bLIkjToin0Y4gpVt4tN8O1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eJorL8opvrPwUjo0fFXUaPp2GlXrHmKBICGXY4jaEHlNDGxuPp8kNQevnE5JyT+P1
	 2g+AFhZnjcuS2VCELEBainSBf5doEvquVQ7yXiiBm8FncjI7QBjaJy7t6ilsPXjnXO
	 UvsBi1sNK0ybHgGf2EfqOemn2FY8+Lt7dzLcwj/Xy5ycxmt2LdM6/J7+MSeXQxks5/
	 PFRcqSQ8OUX8ShI6NfKIglhmmPOkgA4uPEh1Q44IYlWQacm11Peea0aLjRwAYOwpnt
	 iCZCv6kxVMRSIyIZD4RTgAS5osFedckxHTln4khM+cQ0n+vNiVbdMQOHd63M/rZP4/
	 Z6T3/2t/8f7Fw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Boqun Feng <boqun.feng@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: add global lock support
In-Reply-To: <CAH5fLghvZsU-rF+6hkOoiAOWhpiLJV1WJNPYCRWTq7cEW8UM1w@mail.gmail.com>
 (Alice
	Ryhl's message of "Thu, 10 Oct 2024 16:01:29 +0200")
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
	<87r08okqlp.fsf@kernel.org>
	<CAH5fLghvZsU-rF+6hkOoiAOWhpiLJV1WJNPYCRWTq7cEW8UM1w@mail.gmail.com>
Date: Thu, 10 Oct 2024 16:08:50 +0200
Message-ID: <87frp4kq31.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alice Ryhl <aliceryhl@google.com> writes:

> On Thu, Oct 10, 2024 at 3:57=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Hi Alice,
>>
>> Alice Ryhl <aliceryhl@google.com> writes:
>>
>> > Add support for creating global variables that are wrapped in a mutex =
or
>> > spinlock. Optionally, the macro can generate a special LockedBy type
>> > that does not require a runtime check.
>> >
>> > The implementation here is intended to replace the global mutex
>> > workaround found in the Rust Binder RFC [1]. In both cases, the global
>> > lock must be initialized before first use. The macro is unsafe to use
>> > for the same reason.
>> >
>> > The separate initialization step is required because it is tricky to
>> > access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
>> > require changes to the C side. That change will happen as a follow-up =
to
>> > this patch.
>>
>> Why is this a challenge? It seems to work with locks that are not
>> global.
>
> Because normal locks are not initialized in a const expression.
>
>> > diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/g=
lobal.rs
>> > new file mode 100644
>> > index 000000000000..fc02fac864f6
>> > --- /dev/null
>> > +++ b/rust/kernel/sync/lock/global.rs
>> > @@ -0,0 +1,260 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +// Copyright (C) 2024 Google LLC.
>> > +
>> > +//! Support for defining statics containing locks.
>> > +
>> > +/// Defines a global lock.
>> > +///
>> > +/// Supports the following options:
>> > +///
>> > +/// * `value` specifies the initial value in the global lock.
>> > +/// * `wrapper` specifies the name of the wrapper struct.
>>
>> Could you add an example to demonstrate when using `wrapper` option
>> would be useful?
>
> Probably only guard and locked_by are useful, but I think you need to
> give the wrapper a name to reasonably use guard/locked_by.

Could you expand the example to show this, or would it become too
long?

BR Andreas


