Return-Path: <linux-kernel+bounces-428995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90039E1600
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1C284339
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146121DA636;
	Tue,  3 Dec 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kG+FsS6"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371E1D5AC0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215251; cv=none; b=F/6l61VzJVx+QKJoCSaPnhu8Im0kM3n0Bb1eR3kwjL2qhImsi/Kp4/Pkq+Wnv9uci+zjI0OGi1DNZ9uno+g0KYHHQYCIJIJd7zKdiqw6ypFDTjDTz0OG7iT3KjqshzwGwRP4vxle/w++ZJvqFQV0EIJTxZ/84bPZpUQ/v3GxXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215251; c=relaxed/simple;
	bh=EGkp6ALnrmCcMB4REr8wGZyegO218LZ7b9jNkxkpFoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSNXpPF4MX6qON5ZQPlmQ1qgXTqsXgLyeqM1feIOavGcRmd3CmyHfnHIIql/67O2rdOmM1yaOb+Mu/htC4ey9lGhNPRRf+6Jx3tzx+kvbWFxhqcZgDuE99tzw+Pg3YHXHnnAODVx59VnI6MoJGM53VX4WmhzlBdn7Ti3V/JKMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kG+FsS6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3798869f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733215248; x=1733820048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXvaSXZSQp98JtpvzelnfpGLU19H6GUhEhWGOsSmGaI=;
        b=4kG+FsS6OfUulCqtqEMmZ4n1tL1vlu/VCEC5y+Oul16bq+78SarfFRxL7lO5RZ9dk/
         b0bFJQGQPx0GquOWSMOXIRSwghKVg5HgCkEXTdQpZbKdGDHWA2uZcmTwPKb7nEeCNhbl
         jAf39Y3JNHzRn57cMLk92xB1EMVpNfgbyLtpahiQ7pRJnbRLG904hhT2qws9kAxot8GW
         2k5pl0V+tmzbe/+zaNMS/M+h65xe6sK6pEsj2cePcNRRywX+67YqqdX/wXrGjZkDHATn
         cnuHENwe11+QtLn3ga/4702++tbmA3kdgJDsm+DIXZapf8AEsVJsiMDLJDpYm6GteQfW
         kfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733215248; x=1733820048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXvaSXZSQp98JtpvzelnfpGLU19H6GUhEhWGOsSmGaI=;
        b=iYES77yN7ZWS6Xily1sbAdxqHJ9xcx6h4Wmd+/Mzw69rSB5pNWD97HLkmW5V6lOaIy
         5VUZLwt8OHCUjXHhPRTRasgax/9k3ey7yNXhKM8FLDwxxAAk6I/zX4pUvMPut9/qFtvY
         3x/1V6Ro8Nno/xo5b3QlVBU6grRRw6HvtSizDzu7IPOjg2adC54HBMQ1Lz0+ZejvnFuE
         HX/k/EJORlESKTJLP7WaVtucybUmYOh0wvk+WZS636qiUtSOOYnr2dvL6KmeKzTeXYdc
         aHbgkI1Epz7Gd1GLgFY84zqsxRBB8HB4Fja4eSYOrQDhSMc531exLcWtXDwtuzRmILx/
         nBwg==
X-Forwarded-Encrypted: i=1; AJvYcCVyoVi7BUP93UBxvsLeeLuRxclBgxDK0kPyMKwvf7pzvMBkk68UkNYrjC1Zz399n7zXS2DoEF3mfi007TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05lHYVHwECfnn3W0kgi/l/J7tb7Zv2sUybYuDa+21XOp+G6KN
	TfLUdUQ4PMvS8+vogPcHzo5KY0uJiCBEdDKdOQMgnY/X+Cxo8U/o0keVIB185uDBmzp3Ehh+/9g
	8E9BBFj3QtBykSJe5EuIZpfpm5WZMab5c9hM8sai76kq2vIl05dA3+/Q=
X-Gm-Gg: ASbGncvdeqjDg1SHzhF/xjB80+k+iR4Tb8CgGXisjBbxEvnEYn/gdxRzMWegFGsSS1a
	xx1eqrsTvO0FwDTIVHbjqRLOtRBu3q6c1To6sRAkEJpZdO0uUEOZZSL3+QSigdw==
X-Google-Smtp-Source: AGHT+IHMA7f/VR0jv8Ssx7B2GXePwfB3zHTSeldlWunfhIHgIr2+CLb2zNQSn6Or/z/2Iqsl7lprPWRlzJu+87m5EJM=
X-Received: by 2002:a05:6000:798:b0:385:f44a:a68 with SMTP id
 ffacd0b85a97d-385fd3f29ccmr1628859f8f.35.1733215248064; Tue, 03 Dec 2024
 00:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203051843.291729-1-jtostler1@gmail.com>
In-Reply-To: <20241203051843.291729-1-jtostler1@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Dec 2024 09:40:35 +0100
Message-ID: <CAH5fLgg8PW0P2OKC14Tm_0DTVff9ew+MKajMq4Urecz51Zvc7A@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Add doctest for `ArrayLayout`
To: jtostler1@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:19=E2=80=AFAM <jtostler1@gmail.com> wrote:
>
> From: Jimmy Ostler <jtostler1@gmail.com>
>
> Added a rustdoc example and Kunit test to the `ArrayLayout` struct's
> `ArrayLayout::new()` function.
>
> Kunit tests ran using `./tools/testing/kunit/kunit.py run \
> --make_options LLVM=3D1 \
> --kconfig_add CONFIG_RUST=3Dy` passed.
>
> Generated documentation looked as expected.
>
> Signed-off-by: Jimmy Ostler <jtostler1@gmail.com>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1131
> ---
>  rust/kernel/alloc/layout.rs | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
> index 4b3cd7fdc816..4265f92f8af0 100644
> --- a/rust/kernel/alloc/layout.rs
> +++ b/rust/kernel/alloc/layout.rs
> @@ -7,6 +7,7 @@
>  use core::{alloc::Layout, marker::PhantomData};
>
>  /// Error when constructing an [`ArrayLayout`].
> +#[derive(Debug)]
>  pub struct LayoutError;
>
>  /// A layout for an array `[T; n]`.
> @@ -43,6 +44,19 @@ pub const fn empty() -> Self {
>      /// # Errors
>      ///
>      /// When `len * size_of::<T>()` overflows or when `len * size_of::<T=
>() > isize::MAX`.
> +    ///
> +    ///
> +    /// # Examples

There should only be one empty line before # Examples, not two.

> +    ///
> +    /// ```rust
> +    /// use kernel::alloc::layout::ArrayLayout;
> +    ///
> +    /// let layout =3D ArrayLayout::<i32>::new(15);
> +    /// assert_eq!(layout.len(), 15);

I think it's less confusing to move this expect() to the line before.
let layout =3D ArrayLayout::<i32>::new(15).expect(...);

> +    ///
> +    /// let layout =3D ArrayLayout::<i32>::new(isize::MAX as usize);
> +    /// assert!(layout.is_err());
> +    /// ```
>      pub const fn new(len: usize) -> Result<Self, LayoutError> {
>          match len.checked_mul(core::mem::size_of::<T>()) {
>              Some(size) if size <=3D ISIZE_MAX =3D> {
>
> base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
> --
> 2.47.1
>
>

