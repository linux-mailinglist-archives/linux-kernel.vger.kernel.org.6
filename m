Return-Path: <linux-kernel+bounces-421306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04249D8968
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A9F287ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02761B394B;
	Mon, 25 Nov 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofJO+hrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D217C61;
	Mon, 25 Nov 2024 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548848; cv=none; b=UQ8TOulkfrIKpXU5a+6JmSbBR+GGohQMcex81wdgE+uIJ9ed/AkvMM9raoTnmusFcGTbBerM2Di8faScGlkCmLlxgAheoK56T8RwZ7KkI2gs4v/xgMDDtl9zNo1eemeWdGydqorMbwPofj1Uf6XgN7oBNbAcOjKA5+Rlz9Yxmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548848; c=relaxed/simple;
	bh=igS0/ONi51VenKAkv1fhCqMZkIVMLaoafcrkcbwMaDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rv28tz/xr35vM1+GGI1QJT4xJKCmrjTWaMKaUcYXaI9LdWkWFdD0KHh5wrGWatzEbVjbu86QbDppHuUJgKUjlRZrXKjWdRxG6Q1IuOHczi4nxymaE3dSGPoKHTRis2p3kCCIydhUO7Yc2dm/w94VBwl2YHhBHOWjadeHerrdvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofJO+hrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB4C4CECE;
	Mon, 25 Nov 2024 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548847;
	bh=igS0/ONi51VenKAkv1fhCqMZkIVMLaoafcrkcbwMaDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ofJO+hrzcyMqbS1QWo11FKEDtGpf6fRk5mDbRtpGc656t84rgiYwrRrr+sHKhTo/r
	 wsKneqwb11kB2/gJR4kEDeyOEEjCUwzLro2ZyH/fvPLiW+U4eOna58erRYobe5Jr97
	 8Yuxud4o8eHqMv7shOjrqEmyEgm15jACBLa8Bk/OCZecv3cWuelZcnvkJvdb8h1j+S
	 yz+/KvALmPTGA2SNybhvZw3ef/4CTJehjhUDs8P5FBDnRd+YH7q0D4sVVJmWaLf2pP
	 qS8Z3hfoyVYmu/TdMRjo3qb4fCbvGBEfCHfewjlde4G4Sh3pRi7u1qQFqaqDpG4A0z
	 /8AKXu7O80USA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Tamir Duberstein" <tamird@gmail.com>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/2] rust: types: add `ForeignOwnable::PointedTo`
In-Reply-To: <CAH5fLgjpE7a1jy+W-ZdscrR3D3FrO21iVNd1L-7WY0jGcwQ9mA@mail.gmail.com>
 (Alice
	Ryhl's message of "Mon, 25 Nov 2024 15:49:40 +0100")
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
	<20241120-rust-xarray-bindings-v10-1-a25b2b0bf582@gmail.com>
	<splGe-nP1jmBl7t2093_BX77t3c4JbyUUDhpfL58wESLGvnMUAlWLH2NbbkmVFyzn4mi-j0h5jaxbQikebvoCA==@protonmail.internalid>
	<CAH5fLgjpE7a1jy+W-ZdscrR3D3FrO21iVNd1L-7WY0jGcwQ9mA@mail.gmail.com>
Date: Mon, 25 Nov 2024 16:33:48 +0100
Message-ID: <87ed2z2uqr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Nov 20, 2024 at 12:48=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
>>
>> Allow implementors to specify the foreign pointer type; this exposes
>> information about the pointed-to type such as its alignment.
>>
>> This requires the trait to be `unsafe` since it is now possible for
>> implementors to break soundness by returning a misaligned pointer.
>>
>> Encoding the pointer type in the trait (and avoiding pointer casts)
>> allows the compiler to check that implementors return the correct
>> pointer type. This is preferable to directly encoding the alignment in
>> the trait using a constant as the compiler would be unable to check it.
>>
>> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> I'm not super convinced by this way forward. It introduces more casts
> to/from c_void in code using it, and forces us to expose internal
> types such as ArcInner. Does anyone else have thoughts on this?

Erasing the type later rather than sooner seems like the right thing to
do, giving the compiler more options to check things over.

It was not really any significant work to add/remove casts where needed for
`rnull`. Granted, even the downstream driver is quite small, you are
going to spend a bit more time in binder.


Best regards,
Andreas Hindborg




