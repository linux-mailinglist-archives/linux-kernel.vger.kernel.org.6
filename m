Return-Path: <linux-kernel+bounces-564810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D89A65B24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A15175801
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182B1B0420;
	Mon, 17 Mar 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VBKp+j35"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31280189F57
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233367; cv=none; b=h+K0x4nBAM7IlX4PI2dug8Hee7qqSfC5gEsXsz13mdZ2RhawyrbohyIOc1uYbYCqtHq0G7qniLs89JGIoJICw0JokwaAzE6O4Mw574V8+7Cmjxj0k/+UbNvzbJRo7SsbwMXgEkcCRJCN4zUthYrcuLFIMVRwZBDDtiBW9XlB0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233367; c=relaxed/simple;
	bh=kmPhOYiTEYf2d5HYMCh2bioPt02LgkhI9RcBvvVIl2I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBmD4RKFRN7jqwu2+43xkjAlBI72zgsIvAZ4icf8M1+jQm6fc12f4zKtevYveBAgg1kC5k/pwXleSL5zz4DYM8NpXoqnfCiT4A52xxIAwgU/3iEVlUB9qQ94spbt3TZAqu9/8VjvKo4WpCfeDArBC69MdDrkaeMjBa8sIC21pkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VBKp+j35; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742233363; x=1742492563;
	bh=rgJGPkLRhxuUbyECT44Eq/415K4uKI+wRr+PUCxFexk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VBKp+j35bL87US54ZZYCzQSLyB6SO89BDi3qS309BCezjFccDH5dF2fTMJqhT1naG
	 dMZJAWovTtLAFgDQtIPgPKtd81kbmhLg2heOO/f2MzUf+smM824aMzqJItcVAvIah9
	 Uak2WKq+epUwxCDjEXDwcyS5q8SNlU0SmqunozMr+fYXeyalTCxMOcOzTQBAJ6uexf
	 /269AruxO4OPkKIsrzCvNpVQ3gXsvfKoqU7MW5xY5w9IArufuH0VLIOZl+NybeYxr+
	 i7WHbQLPqXRERkQenvfMKzaHwniXYDh6gfmyfnkjY7sPXsE708gx0GAy8Poxt9AiV/
	 CIL5tbVdHC3Uw==
Date: Mon, 17 Mar 2025 17:42:37 +0000
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Message-ID: <D8IQ6GO56119.2JBP30MJWUK6Z@proton.me>
In-Reply-To: <20250317-vec-push-use-spare-v2-1-5dc6583f732c@gmail.com>
References: <20250317-vec-push-use-spare-v2-1-5dc6583f732c@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 371e8317735fd8c4d823616652b06ba4fb645361
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 6:23 PM CET, Tamir Duberstein wrote:
> Use `spare_capacity_mut` in the implementation of `push` to reduce the
> use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
> alloc: implement kernel `Vec` type").
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

One nit below, with or without that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> Changes in v2:
> - Use `slice::get_unchecked_mut` to ensure we avoid a bounds check.
>   (Benno Lossin)
> - Link to v1: https://lore.kernel.org/r/20250317-vec-push-use-spare-v1-1-=
7e025ef4ae14@gmail.com
> ---
>  rust/kernel/alloc/kvec.rs | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741ce..b91b287e0d22 100644
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
> +        // SAFETY: The call to `reserve` was successful so the spare cap=
acity is at least 1.
> +        unsafe { self.spare_capacity_mut().get_unchecked_mut(0) }.write(=
v);

IMO it's difficult to tell which operation is the `unsafe` one here, so
how about you factor the `spare_capacity_mut` call out.

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



