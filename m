Return-Path: <linux-kernel+bounces-570458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1DEA6B09A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D6917BAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B9D22A7FC;
	Thu, 20 Mar 2025 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZSTVI8e"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866B22A4E1;
	Thu, 20 Mar 2025 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508810; cv=none; b=ntaY1OOJQjkCfByqlRo+IknrnVDR5gjEq5HFpecajVfjEwz3ZIySFoc3anIaX/5L0RNKA/VrPx/3fFF2xAPbUR4PjrAY5tdyQd0rW9PVob1q7g5QWSLjsbb74161G0FV8/GUU+DA5zzyHxPgvbeUOEQx5N4zMCDm96hLmR7mMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508810; c=relaxed/simple;
	bh=KgiuVskFuqPodQ88jiuald1cK0Yq6BI+rekg6RVxwKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx1ujgKZA50D7Ldwk+ExgrsioDGDUparTfDiTXC2dwr9LaF74heXnn6uuRvxrQ9/wo4IvHsh7du6NGLzU0xIr91S7oo+9YzvxFVFqnVJAsMNPO2P1i4C02bnDH7gQYOfO3h8OAc8bfO56G/hG4mN6zbohyuUY3Ugdp3S5oLYBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZSTVI8e; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so24335101fa.1;
        Thu, 20 Mar 2025 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742508806; x=1743113606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAFxENMZn4QcPzJ1M/33TjyaxDestwUuk1FF0bJ1mGE=;
        b=CZSTVI8euG0YebS6ltK8hDAFffK9qHMstckbVds8rApHyT6EDzDBF572IKJSuhUE9a
         +SLBgU6Zapk61v3u6kGNkrvlg70RUricp8Nw7MkclRHXocJ2IaxiXo/I+H4NpCT+8P8l
         6OcBotdDRo2gFvRKnCOf2Zm9tErkzFnFJw/dfxyg6DMOCDd/1vK0HdaPDt+PWpPP0dTl
         ferQkLfajmnKLpDQVWFq/rrqWy7kzf4qic27I+JCstgq1jnm89zmu75eU1GdbflHWM5E
         IM0QfDlKN9+rdmdHhwtVO/ZQbB9nhoQqKizkqcj165ptquaCUqd5Hfj/NUqwnhKg+CIJ
         3Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508806; x=1743113606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAFxENMZn4QcPzJ1M/33TjyaxDestwUuk1FF0bJ1mGE=;
        b=VcMlZ0qfuMn7MwK0TAUM/N4kNXLSVK6FPB4UptWkiB8H/DExtg2Juoj/V9sKrPwGCN
         6Ju1PvKAH5nzNsVg3A9Aj23xavJtxkeYvtmyoQZ/u/ltLMulHnkMs+6wvgj7bSq2dwUb
         BeVXweGckcYPxFzJnLTR3pA59ItsRfoLXqIhPE50zo3Q2Sz4UiK6MbmdM2pIsq2ACc+Y
         vBwka/kfEcHk/sQ+EChoBMJhxh00r8jVxUzkZPlM4S7frmomlJKyS/EOrQ8QuCN9/9F+
         h0OEIegT5QBaMICDREqTLLZdW3rf+rCOXF+kK8twjLSPWNNJ/yr8NOR7Zxu77IjtyVne
         BWug==
X-Forwarded-Encrypted: i=1; AJvYcCV79AYLQL5JWQrUxW/+E5Ohxi4aix/cvEW58+RYSw6Q952wzU+dXrqUn3vzV/oukPZqooUJqX7pELUEgCU=@vger.kernel.org, AJvYcCXzaUucxkBdO5pUMRUs1cq/lhHaUDMRMyagIdiDOqsekUWvrFDvgIQIKjcNNDnSqfSdmFybsi4cCfvm+/xWq5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32+piIDcnZzR1sE8rAhfEC1IxMFt4LnUQc9aKJ1N6yz1iGlWL
	JDUq0OUCD9x7kkWfTX4xDOabQzO/T55JRC9DcS5uo6zGcJSeU/Vv8GIJaSiVo3vM+oOdnV/ekhC
	LIgwtY4q0JpVA3THlWKZvd2BdRso=
X-Gm-Gg: ASbGnctaZBlCtRG52qj3Kum5D/CZ3jwR5gPBaSd0dGolLCrPwm7hWt7cYI/QAtFCa+v
	8U/ZG947RBNDXTu9O3l4zVP49A2ejvLNpnnH+HxMPlP6nyVY76Bymq9DElcKskj8cFcczL5rZGY
	WtElS/krwaaO3/vgW+Y/3XmfNahhpCHXfPPG2OfXsKPw==
X-Google-Smtp-Source: AGHT+IEfRLZm/iAzfrGhRw3gUEIzjK7pWZsGSEejyzKMWKCzaLSHBcDKlDg9oPvyH1jxAjXznCm+yWylqqY5IPu/dyc=
X-Received: by 2002:a2e:6817:0:b0:30b:f599:d78f with SMTP id
 38308e7fff4ca-30d727317a3mr21754151fa.7.1742508806373; Thu, 20 Mar 2025
 15:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com> <20250320-vec-methods-v1-4-7dff5cf25fe8@google.com>
In-Reply-To: <20250320-vec-methods-v1-4-7dff5cf25fe8@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 20 Mar 2025 18:12:50 -0400
X-Gm-Features: AQ5f1Jr2DYB_Zdwm3HARPJ4W1U2NuURVVPm9kt-h-3RHgSrYd1T_64m_bOS-Fbo
Message-ID: <CAJ-ks9mM6cb_b0G_ZZh+tnijOPo1imWv-bzhgrLpGcNXMsMjBA@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::drain_all
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This is like the stdlib method drain, except that it's hard-coded to use
> the entire vector's range. Rust Binder uses it in the range allocator to
> take ownership of everything in a vector in a case where reusing the
> vector is desirable.
>
> Implementing `DrainAll` in terms of `slice::IterMut` lets us reuse some
> nice optimizations in core for the case where T is a ZST.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/alloc/kvec.rs | 57 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index df930ff0d0b85b8b03c9b7932a2b31dfb62612ed..303198509885f5e24b74da5a9=
2382b518de3e1c0 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -564,6 +564,30 @@ pub fn truncate(&mut self, len: usize) {
>          //   len, therefore we have exclusive access to [`new_len`, `old=
_len`)
>          unsafe { ptr::drop_in_place(ptr) };
>      }
> +
> +    /// Takes ownership of all items in this vector without consuming th=
e allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D kernel::kvec![0, 1, 2, 3]?;
> +    ///
> +    /// for (i, j) in v.drain_all().enumerate() {
> +    ///     assert_eq!(i, j);
> +    /// }
> +    ///
> +    /// assert!(v.capacity() >=3D 4);
> +    /// ```
> +    pub fn drain_all(&mut self) -> DrainAll<'_, T> {
> +        let len =3D self.len();
> +        // INVARIANT: The first 0 elements are valid.
> +        self.len =3D 0;

Could you use `self.dec_len(self.len)` here? Then you'd have a &mut
[T] rather than `MaybeUninit`. Provided you agree `dec_len` is sound,
of course.

Link: https://lore.kernel.org/rust-for-linux/20250318-vec-set-len-v2-2-293d=
55f82d18@gmail.com/

