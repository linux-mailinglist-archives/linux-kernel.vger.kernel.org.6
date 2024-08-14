Return-Path: <linux-kernel+bounces-286120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9639516D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEF11C22712
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DCD1428E4;
	Wed, 14 Aug 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmEM7s4b"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337713E02C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624964; cv=none; b=lPMZPaq5QLEWq9bBNO2YzXZKGLJhk9dyIqgq1OcZawF7oOqJDPicu1peIP3q3dFbT4cybamih+WaQJeE1BjVx0ioowRgtk/ab6B2wy10+1mFtBPwc1EyXcQjPIBGjH5jCwisohr426IoV6Li1Z5jpZzlxJgSM+zwgQ7mHsWvGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624964; c=relaxed/simple;
	bh=Yz3FvUcSxm+sPTrIaF3ceIVk5DSTE0gKUp7+I6EngE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4av3rMRvkUWO34Xb2w7X68i3PcQrMvf+sURY3xiNjM5UpSMHWhrPZ9y+GqSHPgl/w9DRoP7DjJU3EW4yLUGmTLPXMablS0BY9fboD6tLKYL5VB85hAMWeESchCgeH7cmjQ2nzQSDljnokWRa28vRJmDc/FRGE/GAFOp0sQUvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmEM7s4b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42803bbf842so62752275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723624961; x=1724229761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GtZhrT/mm/AxwGAt7UwiNX0lEue7r3nHz8XAGJUFqg=;
        b=KmEM7s4bCf4SHKlU+KNEbCglwEjFzxSALDuvwpqXzAYFKJm7aJx/pvP4JptoIEnBmp
         nGmZYaq7MGpGyxosy1gsZHB8Z0LQGc6lfMrPvV9opOFoXkGRzhCRMHKgbYc6i24ENs+I
         6gTWNHaYCcFvZhn1ECDw+YPiRmRM/1xTm9OQWfK35w6JA91PEEea6vQOrt+ajKFeAOWM
         K/EhTBggqGpc1+d9maw7jsb3agyk5GryUN7ehMH94Qia0yS59DzcuiqmqcRnVMXXC68N
         5XB8lJfOxgJMNOt6AGsdV9t1TvFeBOLeYW3pMM49jwOROvyiwRNrbH2Uw2+/o3FJtYA+
         R15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723624961; x=1724229761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GtZhrT/mm/AxwGAt7UwiNX0lEue7r3nHz8XAGJUFqg=;
        b=ePGAHf/XaozobyUhQfJi5WIOqckY4KP1yZx+4At+ETyWRtUVRcNDk8TsdtOnQhO2XX
         4TOlbS4iNIRP8PZA7JVAUPjDzhrzkt7jt/CoB2ylR9Ps2/O5S6KcTz/nezoz3ILyKFaS
         3vLXq+ytdpPPVF2uitNpXmWZUOuouLRy+KrK0eEDhTkHaCaYAtCdwB8tsT7itCZ6vsS2
         FDIQmTou5Lx7SDrnJEH/Hns4xmbNL48SAIEJbnB9xZGvWQ1FfbcGDX9AM/1n1Q0+0wmt
         xhvjf3QqaFfUjqEGfxddfD1WEidLdOMb6wnaTUoRLqMUFfbHaepmj0JV9futwX+VTNrF
         +fJw==
X-Forwarded-Encrypted: i=1; AJvYcCVNt//V0lEX4IF1os+pyaJBSH4p8zw1OXnrC1GVn6IBGefNIxrIfeW2qsxdLhhIu2sLT1fGhG3HaUpo9cN+nuSENdQakKVrmN5cxJ79
X-Gm-Message-State: AOJu0YzX/cKGeoF6zdEtYBN1toY3HpMaugkwvnrHMbb/m51fECy1bsFa
	sbczR92oGYNSnMNZmNd6eFcjKr/RfztLT7JcQEp/jKFiITHsXiW2wnV/f2sBGhQGFjqUl7iLq8d
	vQP8V3YA/pH5D+q9vzT8PMLzAAJzCZw6hNAab
X-Google-Smtp-Source: AGHT+IFrmL3U1S+rpzBOdS5HfRHkuyTVNTg4EqoC10UJXSwLurGP5QVOWdVYxkQVIjwptFuwedEGKyhyn45M8GLcKU0=
X-Received: by 2002:a5d:59a5:0:b0:367:9903:a91 with SMTP id
 ffacd0b85a97d-37177744793mr1608078f8f.11.1723624960494; Wed, 14 Aug 2024
 01:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-14-dakr@kernel.org>
In-Reply-To: <20240812182355.11641-14-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Aug 2024 10:42:28 +0200
Message-ID: <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/26] rust: alloc: implement kernel `Vec` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> `Vec` provides a contiguous growable array type (such as `Vec`) with
> contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> `Vmalloc` or `KVmalloc`).
>
> In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> [...]
> +impl<T, A, const N: usize> Box<[T; N], A>
> +where
> +    A: Allocator,
> +{
> +    /// Convert a `Box<[T, N], A>` to a `Vec<T, A>`.
> +    pub fn into_vec(b: Self) -> Vec<T, A> {

Nit: I would probably make this a From impl.

> +#[macro_export]
> +macro_rules! kvec {
> +    () =3D> (
> +        {
> +            $crate::alloc::KVec::new()
> +        }
> +    );
> +    ($elem:expr; $n:expr) =3D> (
> +        {
> +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> +        }
> +    );
> +    ($($x:expr),+ $(,)?) =3D> (
> +        {
> +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
> +                Ok(b) =3D> Ok($crate::alloc::KBox::into_vec(b)),
> +                Err(e) =3D> Err(e),

Hmm. This currently generates code that:

1. Creates the array.
2. Allocates the memory.
3. Moves the array into the box.

Whereas the stdlib macro swaps step 1 and 2. You can do the same by
utilizing new_uninit. A sketch:

match KBox::<[_; _]>::new_uninit(GFP_KERNEL) {
    Ok(b) =3D> Ok(KVec::from(KBox::write(b, [$($x),+]))),
    Err(e) =3D> Err(e),
}

> +// SAFETY: `Vec` is `Send` if `T` is `Send` because the data referenced =
by `self.ptr` is unaliased.
> +unsafe impl<T, A> Send for Vec<T, A>
> +where
> +    T: Send,
> +    A: Allocator,
> +{
> +}
> +
> +// SAFETY: `Vec` is `Sync` if `T` is `Sync` because the data referenced =
by `self.ptr` is unaliased.
> +unsafe impl<T, A> Sync for Vec<T, A>
> +where
> +    T: Send,
> +    A: Allocator,

Same comment as Box. Ditto about "unaliased". Needs `T: Sync` instead.

> +impl<T: Clone, A: Allocator> Vec<T, A> {
> +    /// Extend the vector by `n` clones of value.
> +    pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> R=
esult<(), AllocError> {
> +        self.reserve(n, flags)?;
> +
> +        let spare =3D self.spare_capacity_mut();
> +
> +        for item in spare.iter_mut().take(n - 1) {

You need to handle `n =3D=3D 0` here.

Alice

