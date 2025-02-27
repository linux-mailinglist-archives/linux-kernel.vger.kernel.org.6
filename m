Return-Path: <linux-kernel+bounces-536468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844BEA47FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC84E18946E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C00231CB9;
	Thu, 27 Feb 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/tduRXi"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FF231A4D;
	Thu, 27 Feb 2025 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664148; cv=none; b=hx/sYoWhFOsvsLITHLGebEFRXsJvrQcATStADPCdMtRd9dPyxdL+i3+FM0Z7fTaTWNvnGq+3KrUzxnvlh6Ghd9onBJsgqtNBJVHw/QthfVRUIw2g9jn7yHCZqn6QwP0HytgEhwLwHi+uuhkEe8GRTkhL0viP6arc6bTRhsp9O2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664148; c=relaxed/simple;
	bh=P8IJYd8FR/Icvn1RJCn9y4YI8x1haSgI21fF0CZ+RPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iidFnsmtpfFsd4Tyr8UcpdFiVyLTA6IAYgOeE+AokAVJBv4geludks1tIQCXtNHfvzbtmWY3+q0IqS5JtOnZ4PtEQO/xuwRI/MOFDSzZGUxIAe+hwdc33utysj96BsEsznH0y7nDIVDC0rA0C0FfhW7ebeA4/2N7uH0XxAGZIG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/tduRXi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so1622589a12.3;
        Thu, 27 Feb 2025 05:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740664145; x=1741268945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14WfYF+JxUtInqVcnDAf3w6mUXX5Xz6J1f5cc1Inytw=;
        b=X/tduRXi5aKihQkQojTV13zdzA8NC1ZLtPLFtvHjNPe0qDZsJ3CeF7DxxDxhkjVSZV
         HiKzp5MVxs+WEsyAVPKfhCOIi7oY0ZgeB4J8cFCGqICD/gEo2bLyjdCwo0LlE/uXFquf
         dgHmL2rrIQSeQu+JibKane+vBqAYwdpuwczuH3zqcv2znGcy30lXywgkqyn9RlNYZj7v
         UR4WhRwYBAuGyJFfBh9e6EEbMhYF5N5ZpD+TDVrHdd77vxBB9pk9Uf6896b61PuIMW1a
         OLLBNdiBF+r5FEMIkdCUy7sUDQsyEBueu0fcQC9RrHZv1wEA/xWnzqicGw/yL7n3w6nS
         wbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740664145; x=1741268945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14WfYF+JxUtInqVcnDAf3w6mUXX5Xz6J1f5cc1Inytw=;
        b=GSXNyMos88Xfh2DxQDhUeheAzreEZZCW0hOB4LcpnwfeX82gZucGcx3OyXqrqnE1jz
         ZLugNEah0D9+XOQwJR0swqqHSfgURoXD+Pe+vtApmLfATgrBL8MLq7hlXE8j+GH2Xblz
         OKLAbjtd2s0oJabzYSccz0dP2kJHeX6x1znKcA4rfrMlZjx1UYQD9sBFCjTAkietZUbx
         OJZEn3+xEZN3yvTXpxKjMh/Tmr74qTf/6XaQC/XzH+o/YKSyfmggDUhd7KbJz7cx/Hce
         Gn9zjuvs+XTiwZn+a8p29cOiN9TF5fLYY3D1mqchKN07rxc+eg87LP54UFLoaR8+EEJn
         T0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWSyFJYZcYf3tQWFdvS9Hxu2NMNXMZ/iBTdeWnzanvVvrkFwFgmTHErVsAeiuAXJkHwedmT5OkET/AOTw=@vger.kernel.org, AJvYcCXpqjtZ+/ZQW0of5ANTVUscOEDqRU9tDUpuOzKU3RrkiaLeEkIqymvBNAcZoY23kfGQtdIdi2uAXEPYqm3g3g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI7AHkRtbmL3oEquqXgEMqEswn7htR7XjMdB8Fxycs6VOflNyF
	ZMXoUid1d25z8+U8lifs3KOvIn25Uw3Psl6ZZTSXXZaag2S/sFpQVoWLc3/yrBKYJMk8uZhodt2
	TviYpxwJEltIrIl2J5+rSlmYqNMU=
X-Gm-Gg: ASbGncvUpy5UpwqNs5QrTgYtURto1KQN3djwgSc4rpDlJP1vLBfOkE98/Kp5++kA8FP
	IR7wJXcUNKdWxjWMWzQoBPU77XD0wLXg+WFPYGZve7vxNLi5mRuaFY4teM79mkUbpO5VCppEch4
	psMR/63PhJ+ikYANudrSgi1N1bmafg79/vRtiGXHPd
X-Google-Smtp-Source: AGHT+IFrqmFPhnupTYYjxWUe3DTusMoVDTpQWWdo2IJDFGKcTSDAIGd3WmoPoKQWNXBjAvow9yTPQbKK60HJOeI6bq0=
X-Received: by 2002:a05:6402:2787:b0:5dc:7f96:6263 with SMTP id
 4fb4d7f45d1cf-5e4469daa04mr14622035a12.15.1740664144559; Thu, 27 Feb 2025
 05:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org> <20250227-configfs-v5-1-c40e8dc3b9cd@kernel.org>
In-Reply-To: <20250227-configfs-v5-1-c40e8dc3b9cd@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 27 Feb 2025 08:48:27 -0500
X-Gm-Features: AQ5f1JqqdLUSn16lxx8sMpg0_xRZhMsea0cF-Qy8ejK9uaChfCARGhlD-gE3w6w
Message-ID: <CAJ-ks9=B=ceCN0VO3JH37LJbuVbQ5Y2sqfOgFCyJ0BfFGSEmkA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: sync: change `<Arc<T> as ForeignOwnable>::PointedTo`
 to `T`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 7:37=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation for
> `Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
> functionality, but allows `ArcInner` to be private. Further, it allows
> downstream users to write code that is generic over `Box` and `Arc`, when
> downstream users need access to `T` after calling `into_foreign`.
>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>
> This patch is a dependency for Rust `configfs` abstractions. It allows bo=
th
> `Box` and `Arc` to be used as pointer types in the `configfs` hierarchy.
> ---
>  rust/kernel/sync/arc.rs | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index dfe4abf82c25..3d77a31e116f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
>  #[doc(hidden)]
>  #[pin_data]
>  #[repr(C)]
> -pub struct ArcInner<T: ?Sized> {
> +struct ArcInner<T: ?Sized> {
>      refcount: Opaque<bindings::refcount_t>,
>      data: T,
>  }
> @@ -345,18 +345,25 @@ pub fn into_unique_or_drop(self) -> Option<Pin<Uniq=
ueArc<T>>> {
>
>  // SAFETY: The `into_foreign` function returns a pointer that is well-al=
igned.
>  unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
> -    type PointedTo =3D ArcInner<T>;
> +    type PointedTo =3D T;
>      type Borrowed<'a> =3D ArcBorrow<'a, T>;
>      type BorrowedMut<'a> =3D Self::Borrowed<'a>;
>
>      fn into_foreign(self) -> *mut Self::PointedTo {
> -        ManuallyDrop::new(self).ptr.as_ptr()
> +        let this =3D ManuallyDrop::new(self).ptr.as_ptr();
> +        // SAFETY: `x` is a valid pointer to `Self` so the projection be=
low is
> +        // in bounds of the allocation.

Isn't the unsafe bit `*this`, which is what this comment should
justify? In Rust 1.82+ `addr_of_mut!` isn't unsafe I believe. Also `x`
is likely meant to be `this`.

> +        unsafe { core::ptr::addr_of_mut!((*this).data) }
>      }
>
>      unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
> +        // SAFETY: We did the reverse offset calculation in `into_foreig=
n`, so
> +        // the offset calculation below is in bounds of the allocation.
> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, ArcInner<T=
>, data).cast_mut() };
> +
>          // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
>          // call to `Self::into_foreign`.
> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>
>          // SAFETY: By the safety requirement of this function, we know t=
hat `ptr` came from
>          // a previous call to `Arc::into_foreign`, which guarantees that=
 `ptr` is valid and
> @@ -365,9 +372,13 @@ unsafe fn from_foreign(ptr: *mut Self::PointedTo) ->=
 Self {
>      }
>
>      unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> =
{
> +        // SAFETY: We did the reverse offset calculation in `into_foreig=
n`, so
> +        // the offset calculation below is in bounds of the allocation.
> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, ArcInner<T=
>, data).cast_mut() };
> +
>          // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
>          // call to `Self::into_foreign`.
> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>
>          // SAFETY: The safety requirements of `from_foreign` ensure that=
 the object remains alive
>          // for the lifetime of the returned value.

It might be good to extract a shared helper from `from_foreign` and
`borrow`, though the duplication isn't new in this patch. Either way:

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

