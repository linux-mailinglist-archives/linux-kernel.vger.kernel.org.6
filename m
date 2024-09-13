Return-Path: <linux-kernel+bounces-328354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1F97825D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6161F2508E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901381DC054;
	Fri, 13 Sep 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SvUs1FdG"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D481D86D1;
	Fri, 13 Sep 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236882; cv=none; b=Ap61gUAKpNt+/PQ/zslqMUtvw2RFtlYozsaVtncYnlV4sq8Eqs7op193sbqUDzDGNaW8Olmvp+p+EHdkF23kkceDGSCZcQpN5//l/1ZnuGaJZXrauF/HWxLaLs0nF0aSTWdL11GqF5VHw4ucpHVtrRNpLsagAIkDZhmi1STXYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236882; c=relaxed/simple;
	bh=JGJr3hZsfcYd0hp9+8waZWWoezY4Y5ENA/y/vEDUmIk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWRuti7N2t5FwfxOs4hCcSyDTgrERLYXpJdVXzrmeLSX8/4ItvV98vg2ErJec1CyB2FpRMBSEgvwruhSZ4iFQzb37JSF07MBmTzw2n9s+2Lgn70htmjplv+BZ0OLovPun9dRwevkjp/0mIQyYV/oaLjx9/dFCnt4z1unoIyPnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SvUs1FdG; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726236878; x=1726496078;
	bh=Er4z/TlLjMShQEFQyDcXytiAA2ZIFl92Wj8NPFuIWds=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SvUs1FdG2LMmroV5i4IlyW3vnUHGLqWnjtzFbo1YjvTgS3ucNuyIP8D6s6cfmQSPY
	 tt9HC6UPe8v5R8OTafzpE4cR3PWLfOtxyCv52ZiLE5Miub3sscFpblQksre1zhtH9T
	 KWl/wiTyopye5H4iTRZGarTMt8F3gqylyKTfUhOc+/insjwTyerhOiyoCeSC5sApoc
	 1i+093U/dZahXj5uj+lTfaWhs8LHTfud9hBP67LhrRNhMthRXKolSEj8SP9FwU0yU+
	 5tZR553AF0AuUU1dLldQjppxjbwZGGvi4321DACrOyBsCcdiY1Ap8t1OgZYUEPmFDS
	 RdnkN1+MhN7og==
Date: Fri, 13 Sep 2024 14:14:29 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v5 2/3] rust: sync: Introduce lock::Backend::Context
Message-ID: <61f87861-db95-4524-99e9-b552c4cefd3e@proton.me>
In-Reply-To: <20240912190540.53221-3-lyude@redhat.com>
References: <20240912190540.53221-1-lyude@redhat.com> <20240912190540.53221-3-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 824055d6ec1214d8800ff2fe4fe19bad3e748fbe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 21:04, Lyude Paul wrote:
> Now that we've introduced an `IrqDisabled` token for marking contexts in
> which IRQs are disabled, we need a way to be able to pass it to locks tha=
t
> require that IRQs are disabled. In order to continue using the
> `lock::Backend` type instead of inventing our own thing, we accomplish th=
is
> by adding the associated Context type, along with a `lock_with()` functio=
n
> that can accept a Context when acquiring a lock. To allow current users o=
f
> context-less locks to keep using the normal `lock()` method, we take an
> example from Wedson Almeida Filho's work and add a `where T<'a>: Default`
> bound to `lock()` so that it can only be called on lock types where the
> context is simply a placeholder value, then re-implement it through the n=
ew
> `lock_with()` function.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
>=20
> V3:
> * Use explicit lifetimes in lock_with() to ensure self and _context have
>   the same lifetime (Benno)
> * Use () for locks that don't need a Context instead of PhantomData (Benn=
o)
> V4:
> * Fix typo (Dirk)
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>

I don't think that you need your SOB twice.

> ---
>  rust/kernel/sync/lock.rs          | 17 +++++++++++++++--
>  rust/kernel/sync/lock/mutex.rs    |  1 +
>  rust/kernel/sync/lock/spinlock.rs |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)

This looks good:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


