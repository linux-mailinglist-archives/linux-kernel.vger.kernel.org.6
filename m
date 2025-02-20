Return-Path: <linux-kernel+bounces-524873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F047A3E841
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AB7188DEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2716C2673AB;
	Thu, 20 Feb 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I5XwWEB9"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280E265CBA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093614; cv=none; b=m0ONSKDNHTw1ibKO50QVSvCVm+70fraFzxgH+F6anA5xhaWz+QuJ8bmVD0szush3Gs7KH8+SK2v6vwKudd41WAA8aJrPpm6x5CDjeDvsHzwG0eoNkDmyhqpO2WCpV3s35tUMlZqnLK677Ij4DprkAJHmjtJqISTFi9w2tREQnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093614; c=relaxed/simple;
	bh=2ei6Xr8KtKfCuxF3biIuGcx1xmTWqeXDWTditoITIUs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSi60hdBQ1JUb3E6G9Z1hvokEEO39M8kbJ/tEEm/mX99HjXyGqWNv4Rjo30XvhCYIK7VD5JUbnP2JR9k8LLMOxBbWUuxiUDkRvbCipMcQcu+nrYPnJgTd5QDve/lHGZh2dBUML5Q7nwDKhxZ5GmTedeG+951+1f9vfv8TiA4Kvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I5XwWEB9; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hf4scjpobzbqbotakuxbbsmlbu.protonmail; t=1740093610; x=1740352810;
	bh=R0xXNryglluujxdF1vg6HlVzkuQzuuyku/Gv+SN/ma4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=I5XwWEB9oCiZSQLGZThpNvKa1tZx+ebcEoQ5JD1bBpqke73RCtzaoluhYftci4m/p
	 6doCLvRIjgqnTXtHKMYOo/efw8vCdQu6e/Fwi/hRL0Z2sZvwjiV43RcJ1oCu3sbGbw
	 cXORL99EwF75W72rWrByZGzIoFTDsOkSxZ2ShipUeNuLylnO8tLfyA9FGxFx+lyAS7
	 K6xH1E8quXz8oqpSNr2Nq9e4NXzZfySevh4GBAx0vRu126/mkymOitN5af/86dF6OP
	 QUo85TeYWjhzFqSftXHgYx7bn+EfnqZu8uUKxy04gBNyOvhW4VAtHo4NL5G6ka7Wcr
	 zMBDo59DJ/zVQ==
Date: Thu, 20 Feb 2025 23:20:03 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/14] rust: alloc: add `Box::into_pin`
Message-ID: <2a7283fb-4c93-42c4-a895-36a6e3d1935d@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-10-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-10-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 542a649b1cda4b467438e54e139b96c08afc3fe5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

Why don't you use `into()` directly where you need it? Do you want the
function call to be more descriptive?
(To be clear, I'm not against the addition, just wanting to check if our
motivation is the same)

> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/alloc/kbox.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index cb4ebea3b0742..9da4a32e60bc3 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -245,6 +245,12 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, =
A>>, AllocError>
>          Ok(Self::new(x, flags)?.into())
>      }
>=20
> +    /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not i=
mplement
> +    /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
> +    pub fn into_pin(this: Self) -> Pin<Self> {
> +        this.into()
> +    }
> +
>      /// Forgets the contents (does not run the destructor), but keeps th=
e allocation.
>      fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
>          let ptr =3D Self::into_raw(this);
>=20
> --
> 2.47.0
>=20
>=20


