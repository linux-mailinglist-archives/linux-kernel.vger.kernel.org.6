Return-Path: <linux-kernel+bounces-328356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71783978261
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3376D285CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A48F47;
	Fri, 13 Sep 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H70LYXQU"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C4DF60
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236954; cv=none; b=j79iB3yGhx8RMqGkHFWuNDnhotngajyo0oCv78KgVz2vu21rDDomLl+3ZkiHnTodsh8n7fxRejAN+1u2Iv44Lmin2k6lXGybE8iYaTaJRYqmsKuuk9uiq6b4iwy/ZN8SCmIDrIfnqA++Ez69rGpYdscMGBYfioVVDJjfKDPwgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236954; c=relaxed/simple;
	bh=XPN8oqe/Nd2VGNTD5lsFfcllQTrbIOku5dzm8/IrMoo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJN66JWOBPr0eteobJxa9FuVhg9H1shoioLe3infudMP2xmIH2xyChWrJAnP6UUa1yruTQGYtOwjE8JXQXGbFtiVJvEBZ1sy31P4lkUkaIwmSUHj+CKgVeVnKqDfLsjrUC0/ceMeTgYf4dy5wBt5Jq4n36jzvvW5sISnZ2xoD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H70LYXQU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726236951; x=1726496151;
	bh=pgg37Csd/pbMYJpE4NPiNE3WqHfYEli7aN12vFgrzHU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H70LYXQUqs62wFgmwOmk5FP6y9NruiCPCTQjz2+rCR0Vt3aUyjuNikg1JuoaZgm/p
	 C3nVI0JRcukF98ge0kOr4bnrN6KffnH2hIkb19/rLZlRTgh00B5nGxOe82VqLj0rt7
	 DlF587ViZRMjeoewnWuRUkBogH0kq3SX1lIYW9QHa0rdDOvGw/+2W2tANPVQv5UcLq
	 zlije3UGkiNHjvMqvAgX6wUT5l1WkJ4a7lI2C58zTe68oAyceV8mGOGzOqEtWyNGRG
	 ikGVNnetno0JBYAnjXreM65Z0SwIfPub3lgh5Ch2WIkTU+3ZX9URfIyIs1sHJJqHSE
	 Em5s0D2Gibo6w==
Date: Fri, 13 Sep 2024 14:15:45 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v5 3/3] rust: sync: Add SpinLockIrq
Message-ID: <30da83b3-5be0-431b-b57c-c9d371747e7d@proton.me>
In-Reply-To: <20240912190540.53221-4-lyude@redhat.com>
References: <20240912190540.53221-1-lyude@redhat.com> <20240912190540.53221-4-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1391b8127f473441273a0e6410657bbe61568de2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 21:04, Lyude Paul wrote:
> A variant of SpinLock that is expected to be used in noirq contexts, and
> thus requires that the user provide an kernel::irq::IrqDisabled to prove
> they are in such a context upon lock acquisition. This is the rust
> equivalent of spin_lock_irqsave()/spin_lock_irqrestore().
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
>=20
> V2:
> * s/IrqSpinLock/SpinLockIrq/
> * Implement `lock::Backend` now that we have `Context`
> * Add missing periods
> * Make sure rustdoc examples compile correctly
> * Add documentation suggestions
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync.rs               |   2 +-
>  rust/kernel/sync/lock/spinlock.rs | 104 ++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+), 1 deletion(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


