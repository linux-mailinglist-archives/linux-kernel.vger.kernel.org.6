Return-Path: <linux-kernel+bounces-348204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5346898E40F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BE61F21C94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29F7216A3C;
	Wed,  2 Oct 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iB4WdSdM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wlms/HDh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6D194A60;
	Wed,  2 Oct 2024 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900429; cv=none; b=HU7QeECha53/+03rNcNtXLk7nSuKSrKE9Me7gFIrNIvLSjCK2Bg12yBu3CvRoSAbYJRI1w96I3KelGSXgZeP93aWoRM0qhtPDDI9b2lAWJY7D+0Nq4t8OoQ34mlFQLf+ZS7N3LPElSecr3Aj+JgaGs0D66F+zteNQJKkTyFE6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900429; c=relaxed/simple;
	bh=C2i/D64fWOkruAj4yJBGkLmI5v3XIpxNMsBIrEWko/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rz+aQKOdKAYNMsShdPJJG85ZlahPYtb+OdSc9ClrvDacc1YPTy1eT92/E3Bx6/flqEq7EWmqIuxXojv78N01QYMij42PFgqDPWU05W9PYXC2jcJ87aTUufLJN102o82CKI56pQOKp/Z2HuuF/34pKT+GxoWBLH4Hhi74NryeHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iB4WdSdM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wlms/HDh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727900425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFCnCd3kndfD7k2L6NnI3pG0U/NAUuecBaGF859Crl0=;
	b=iB4WdSdMZ3R+wye+5ewreiK01E9amhq8ZfDYJ+B/Zgfhdidy6bxPlbmO+wWHm6CUmM+CLQ
	m6xOJREvzNv9+u0Gh9u22DXQ7QY0UcfeXuwrBFe1xL1OGwpSji5/M0VMbQvhQVlfc/tIVf
	xMcKxDxlZff4uRrG9E+wkUXz+YmWibnArSiDaA8iqV6B6jsqdRDwjFCVXxRBYds6KAhWYE
	vxpmlYc2aYF7kls8cdwHV0S26OtxBhKVWxKQYBy33ByveeKfVQ4mhkLUHaZkqHxATf5NLx
	P7m/H2Z0o4q0dvCx3RszWuWi+IEjTpKOWKYXfKtvMVf52zEgjU2rQbd4JqB4NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727900425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFCnCd3kndfD7k2L6NnI3pG0U/NAUuecBaGF859Crl0=;
	b=Wlms/HDhxXOc8elfkxAjYRwzwF5pcWf9GfEKKz040EuC8bXUtlVhUFHqNDaw9BDHfbP+nM
	GGnHBo5Vj5kVVQCQ==
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Benno Lossin <benno.lossin@proton.me>,
 Daniel Almeida <daniel.almeida@collabora.com>, Gary Guo
 <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 1/3] rust: Introduce irq module
In-Reply-To: <20240916213025.477225-2-lyude@redhat.com>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-2-lyude@redhat.com>
Date: Wed, 02 Oct 2024 22:20:25 +0200
Message-ID: <875xqaw92u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 16 2024 at 17:28, Lyude Paul wrote:
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/irq.c     | 22 ++++++++++
>  rust/kernel/irq.rs     | 96 ++++++++++++++++++++++++++++++++++++++++++

irq is a patently bad name for this as it might get confused or conflict
with actual interrupt related functions irq_.....

The C naming is not ideal either but it's all about the CPU local
interrupt enable/disable, while irq_*() is related to actual interrupt
handling and chips.

So can we please have some halfways sensible mapping to the C namings?

> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This disables interrupts, creates an [`IrqDisabled`] token and passes it to `cb`. The previous
> +/// interrupt state will be restored once the closure completes. Note that interrupts must be
> +/// disabled for the entire duration of `cb`, they cannot be re-enabled. In the future, this may be
> +/// expanded on [as documented here](https://github.com/Rust-for-Linux/linux/issues/1115).
> +///
> +/// # Examples
> +///
> +/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
> +/// disabled:
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> +///     // When this token is available, IRQs are known to be disabled. Actions that rely on this
> +///     // can be safely performed
> +/// }
> +///
> +/// // Disables interrupts, their previous state will be restored once the closure completes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
> +    // SAFETY: FFI call with no special requirements
> +    let flags = unsafe { bindings::local_irq_save() };
> +
> +    // SAFETY: We just disabled IRQs using `local_irq_save()`
> +    let ret = cb(unsafe { IrqDisabled::new() });

What's the point of the IrqDisabled::new() here? The above just disabled
them, no?

> +    // Confirm that IRQs are still disabled now that the callback has finished
> +    // SAFETY: FFI call with no special requirements
> +    debug_assert!(unsafe { bindings::irqs_disabled() });

And here you open code the check which is in IrqDisabled::new()

So I'd rather see this as:

   token = unsafe { IrqDisabled::new() };
   let ret = cb(token);
   assert_valid(token);

I might misunderstand rust here, but the provided code does not make
sense to me.

Thanks,

        tglx


