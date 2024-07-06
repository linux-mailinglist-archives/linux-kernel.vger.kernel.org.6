Return-Path: <linux-kernel+bounces-243268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15999293CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA81C211CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998F131E38;
	Sat,  6 Jul 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UV2BfYOw"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910650285
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273032; cv=none; b=GALvFYnaSBTxL6QzbZIKU4xZ5DWstZxZs/wbT6jCAtcxEC2XX5zrSM63DQIeFAc/CCFFIKKtG698WWPPuruFd1uuRs1fpmr1RCS4zTAKvfwvD/wmPtoRo4Axl0Ib1xiJCFRvEoBUYkLbmSFCjyBqyaGLD1E+f2Cf8DVSL/BIPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273032; c=relaxed/simple;
	bh=8bbFZu23/5jdizCrZRROK4kbwKE6vi88QMD+ov8p68k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnK9R+p84QCx0VlhZfsmdw25GLNQ5vNj7JSCUo1v9vzAOb9RMGtdech2wV1J9E6w/AJBT39KNOREb/o8w6C9hCA9CpNxziUMAgUVgYIzK1Ogr7Z1saFoQ5I717Lv9djJok1dfb4dCDJlxm7Bd0Qg5xqwuWkpWHGV7kmMB3rt5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UV2BfYOw; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720273027; x=1720532227;
	bh=8bbFZu23/5jdizCrZRROK4kbwKE6vi88QMD+ov8p68k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UV2BfYOwIUWgDaGkt7M/cQTDyMC6sxX/AaIi/yaSCrTAbmXH/ORFJWB2pVIclIifa
	 qiwAmPOm7H4vbfXh3xpSfyNufUotu82ePOEcGCHYKaCfrBLvBxJa23d312cKetLHMj
	 bjGJsd2Y2vNt7P5SWTOF8G+nxyy6AQy7V00dI6385EJhiMHsWxSMyaa1ovgrrZVhyq
	 dz/+r6/8I7YzewGjwVtJITEiDKjqEN/DQjJxc/8t/IrSl4rBrED9Y9EYlMcT/denF/
	 6YL49lgUBgx2gqtvUd3zi1Eyu7BPAAd678dOXLMFWPGZYhma83FAJGkSSHBL4h4bre
	 +U8DTRm9h9UPw==
Date: Sat, 06 Jul 2024 13:37:02 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 09/20] rust: types: implement `Unique<T>`
Message-ID: <8bfd9934-6227-4584-a11c-3f3c881b7fac@proton.me>
In-Reply-To: <CANiq72kmppYpNNjP=0eqHx60ixjgoL4oW_ux1HVwM6vrCRFztw@mail.gmail.com>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-10-dakr@redhat.com> <fa6d6c0a-17eb-4280-baa3-df5f97e58497@proton.me> <CANiq72kmppYpNNjP=0eqHx60ixjgoL4oW_ux1HVwM6vrCRFztw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 841b547db5830159ab57150eda5cc997ce745fc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.07.24 14:40, Miguel Ojeda wrote:
> On Sat, Jul 6, 2024 at 12:59=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> The `Unique` from std is special, in the sense that the Rust compiler
>> will emit the `noalias` LLVM attribute.
>>
>> This gives std's `Box` type a possible performance advantage (IIRC Gary
>> had a compiler explorer example that showed different instruction
>> count).
>=20
> The example in question: https://godbolt.org/z/n93vePqMj -- there is
> one less memory load.
>=20
> One can also easily craft examples where the compiler e.g. removes an
> entire loop: https://godbolt.org/z/c8ncbdKMe
>=20
> But, of course, it depends on whether we will actually encounter these
> situations in real code, as you say. It could also be that today we
> don't find any relevant benefit, but there may exist situations later
> (perhaps because we have more code, or perhaps because codegen
> backends change).

It would be a good idea to ask the Rust folks if they could give us a
unique type that does what we need.

> From a quick look, there are still quite a few open issues about the
> exact properties of `Box` and `Unique`, including whether `Box` has a
> derefencability requirement
> (https://github.com/rust-lang/unsafe-code-guidelines/issues/145).

Yes, this is why I wasn't sure if we could do the workaround I
mentioned. My guess is that it doesn't work or that at least it isn't
supported (i.e. could change at any point).

> What properties would we want, today, from our `Box` types, if we
> could pick any? Should we have several kinds of `Box`es if there is no
> unique answer? Is it worth diverging from the standard one(s) in
> either direction (i.e. more invariants or less)?

I would expect that `Box<T>` behaves like `&mut T` except that it owns
the memory.

For starters we probably want this "normal" Box. If we get a unique
pointer type, then we can introduce more, but I don't think we need that
at the moment.

---
Cheers,
Benno


