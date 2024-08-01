Return-Path: <linux-kernel+bounces-271085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6584994494F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E55281C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C706446A1;
	Thu,  1 Aug 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WqZrOrLM"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409216DC35
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508193; cv=none; b=hWc62wSJYlfA5Kw4Ba99ANHt8A29VCX6wseN3ATzGNdzSzOe4TAw56JxtJfULfnhYDhZH69cJQMWANIMM0ItoMlMvuPmux7dmxf3tx3dqeNtafVpmx2RHGf9iNfV9nmOL83xAEyEKIEB9Tf3Nk3fogguC3modUNiTT02UxVsdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508193; c=relaxed/simple;
	bh=Yz4CT+Y4M+QgVTW9rq1BOcdP6f25ODI9hfH7YAIXrg0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lA7JTjZ+Q4gsIDeG7WZ1eLmJejDGjHtulBvBOgXG4LIj2ble6tB1WB0/tQ/36+u+CGMLzistrybjoCm0uyJLanvo78nFmjBCKDUlAzLkciFSCfUBBWV+wzM/iJ4XXYpYZ+k0ALdV+FMAImGFGqlanSj61aHFiyygDN6O2cGIYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WqZrOrLM; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722508189; x=1722767389;
	bh=wg4LArs8pICntUnd1eHXNgaNeoOPUhTPuVWTLIAVCpQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WqZrOrLMSgnjwPs9tZIeuui4/M7zCj7H0az45jmY8BbdXWkwxmQ9ljZ93tGqxjaSQ
	 DN5qbnjUM6H+/qw3bNQByQMhNS3lqyXiI++WyVQF2UbTWHDoHMxlr5QKjViiUo4A3F
	 OLqEaIxMEkJGOCvZILFvqptGBwuivh1mspc5xO6S3YhdbD3TV+aCfcwy1GMnNU+ko/
	 TvDP49YVdrelRuhqCqPlW67HX1wy3/e5eaZAEBVKmBcZ04b2S2OXygcoDMfAC6kZZW
	 2h0ahjFi2Bs/H5L97S8EybqkpogIHhWEZlGKOVrwsroW1H6xHMEVYgK/nSu0y0dNFY
	 iS/28pCbbVsMw==
Date: Thu, 01 Aug 2024 10:29:43 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rust: sync: Add SpinLockIrq
Message-ID: <991a7dd2-f8a8-402d-a651-eafd857c540d@proton.me>
In-Reply-To: <20240731224027.232642-4-lyude@redhat.com>
References: <20240731224027.232642-1-lyude@redhat.com> <20240731224027.232642-4-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2a4be2ade01db569fe46a86f7705cb203f8e1730
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 00:35, Lyude Paul wrote:
> +unsafe impl super::Backend for SpinLockIrqBackend {
> +    type State =3D bindings::spinlock_t;
> +    type GuardState =3D ();
> +    type Context<'a> =3D IrqDisabled<'a>;
> +
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    ) {
> +        // SAFETY: The safety requirements ensure that `ptr` is valid fo=
r writes, and `name` and
> +        // `key` are valid for read indefinitely.
> +        unsafe { bindings::__spin_lock_init(ptr, name, key) }
> +    }
> +
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` points to valid
> +        // memory, and that it has been initialised before.
> +        unsafe { bindings::spin_lock(ptr) }

Should this really be the same function as `SpinLock`? (ie is there not
a special version that expects IRQ to already be disabled? eg this could
add additional debug calls)

If there is such a function and you decide to use it, you need to adjust
the safety comment, since you need to justify that IRQs are disabled.
For that you need additional safety requirements on `lock` namely that
when `lock` is called there exists a object of type `Context<'a>` and
that object is alive at least until `unlock` is called.

---
Cheers,
Benno

> +    }
> +
> +    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardSt=
ate) {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` is valid and that the
> +        // caller is the owner of the spinlock.
> +        unsafe { bindings::spin_unlock(ptr) }
> +    }
> +}
> --
> 2.45.2
>=20


