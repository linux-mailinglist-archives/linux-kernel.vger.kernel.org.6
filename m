Return-Path: <linux-kernel+bounces-564372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B0A653B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11710188A185
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C0241109;
	Mon, 17 Mar 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FXQyKEmj"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839C23BCE9;
	Mon, 17 Mar 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222063; cv=none; b=OyJoh/stuybktBHbGR1rECOeGHUSyat010EY3g9HFuFgID9n2Ox/TH1kUdQRUBMMiuBxy6bj+GsR6V8ImGdPPNIHWNbwTB64hsM1l6yxh+JAcZhuBBuD0XB0aSXGSr2ZEQykzIfZLM2gHJaGpvTqcpvkrc4CSkFnsOI6lieSVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222063; c=relaxed/simple;
	bh=aqTN5Fb1ifhh0Zr+EBpuw6EjHlzOqFLWifY9xjc5sd0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI4q5oxnsoIvMMrnmG13g0hp86X9s9fo5rkawOzZwKD4zWBs6UlVk61yMONyVVXTQ6JlsdxiKKzxHFnypmf5hV3zLZpOj+lY4vOzOrFZ31CZIIJlEPYciQ0CeMMKylT96k7JwgcWuwFjrPNx6WdHPHghu1HqEWstZfT+oDOD+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FXQyKEmj; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742222058; x=1742481258;
	bh=CGaRfsA4WMnyqgQCKw98ncK+K05nwXJ5g8NBWtozIlg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FXQyKEmj2HAjLRBjEXo7W9EIigwZI1jjHob33C9VJzSMsFKh9tesgVliy11poQLss
	 2tQBwwzNbMS1PmH+EjZGqb7XSC0UKN1el3YGnZV0ValOa/FuMasGvUHA9LKystgMF5
	 T8GLBWCTTyuMMW49AuvlpYaw11oM70Kv9lI3ueKSxFHelvLSSuPXLhnMUOSo4Lcuka
	 fwLQDzDQVbaHB2oP4T1r/Kz0HAvMmiD2+192Bacs9U+8cqjfJG27Y/oR7cPl31OnXt
	 Fg6G/kQX16R0D78ZkuvMBgwAbk6ffv5NP2MGUnY5bRvPm6orYgjjP+NIHphcoDb6E1
	 wSTEOC8MAatZA==
Date: Mon, 17 Mar 2025 14:34:12 +0000
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Message-ID: <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me>
In-Reply-To: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d4db65e73fc46d0c73f8cff36b7bba0db3e413e5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 12:42 PM CET, Tamir Duberstein wrote:
> Use `spare_capacity_mut` in the implementation of `push` to reduce the
> use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
> alloc: implement kernel `Vec` type").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741ce..d2bc3d02179e 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeU=
ninit<T>] {
>      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>=
 {
>          self.reserve(1, flags)?;
> =20
> -        // SAFETY:
> -        // - `self.len` is smaller than `self.capacity` and hence, the r=
esulting pointer is
> -        //   guaranteed to be part of the same allocated object.
> -        // - `self.len` can not overflow `isize`.
> -        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) };
> -
> -        // SAFETY:
> -        // - `ptr` is properly aligned and valid for writes.
> -        unsafe { core::ptr::write(ptr, v) };
> +        // The call to `reserve` was successful so the spare capacity is=
 at least 1.
> +        self.spare_capacity_mut()[0].write(v);

I think the code uses unsafe to avoid a bounds check, but I'm not 100%
sure. Danilo might remember more info.

---
Cheers,
Benno

> =20
>          // SAFETY: We just initialised the first spare entry, so it is s=
afe to increase the length
>          // by 1. We also know that the new length is <=3D capacity becau=
se of the previous call to
>
> ---
> base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
> change-id: 20250317-vec-push-use-spare-27484fd016a9
>
> Best regards,



