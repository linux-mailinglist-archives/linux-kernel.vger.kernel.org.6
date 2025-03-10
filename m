Return-Path: <linux-kernel+bounces-555125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E0A5A5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F673AA83D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5F1E0489;
	Mon, 10 Mar 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCIS94n/"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DCBA3D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641170; cv=none; b=FaRH+dLQ2yVyEIShc/B4Cdsra4cn2ijj7P9m8WoicV5zf/NITqRvQJJQGYi3Gnz9phf1F1iPZciRpl5brQS8DV665xLld4tAqPv93L0qV1+RHm67nq7Yx9VnuZ0R7qVNpPLNeiihrjyb/Ayr+SZgTU91O+peM1eYhM+f09Rozsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641170; c=relaxed/simple;
	bh=/O+GM6rijvP54/lJqSTVGNw4mlcg7oEVx7BqAptm41o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMv9NvNfQqKFXDxiaj44rDPFTI9pdQI9ckqEKPVicoAzUlZPZS8P15tx8W4hB4ye3WZOSLMkyzR7QgCcc0vjc0kVEph3yC9z2v8mMlA8MoVd6tF6VtQSnN9U7AVVAlX4lq3D5Eu2HrHMNDTPQnD9RE9idfQkR4nxTTDYvsvtQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCIS94n/; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f6aa4b3a7fso757319b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741641168; x=1742245968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2wQxTLwmKd3dSVey32FpgbjTSO7rwAFieBoao3Mwcg=;
        b=sCIS94n/Ebir7bvGxW1841tN5tIQCu9jrPj/SOvD58I6vaPA58ONArkcOg2yGLhcLP
         uK2FzANUFMtc+C5BckD3SMs66v0pgqM9hvQwGbUTr0QuavaHvS+y/mvrpuSjmQXPYY3Q
         DzYAFgdj4WiEkAhFIvB7h3GcbcWPwCLSdk1pjeG6vujD+5rHWA+og2bqR71gt2zG5Xxc
         oX72qwkmy/QJAHxa+5VHQyYGC6KZpYqjJxpQENq381zIo0DsnFbfLZ/hOpsVmk02vnbX
         Yqc268vR1nMuWb3MDLAcetrqwOjIZ2ij7UDe5Y08XEkgcNwFegMtT63cbQs0pre2qOyB
         /Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641168; x=1742245968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2wQxTLwmKd3dSVey32FpgbjTSO7rwAFieBoao3Mwcg=;
        b=JSzESD1ivevv+NgIQ30jUwgcyLYruaW3lkCieDzbmdubuWR1N/F+Bsi2z6N5IHy2c9
         vmZ6ZZQaTbaTFf2Kc34XnLa+YpY1HX8qPvMHpebJuHwSzCQghFkdMQWWPuWxycpUZJMX
         v7vCaZIao8QolvIMoG4D+/5L32WQb7j00imgZ9wIrjFcBwwS/1IGa9DzPc5yynA96EXp
         84Yu3pIkG1L02cCf75ggniWlZXJeh4wIu4Mx00xepqQxuE49N1X2Rc8mKdaySX4ClRRZ
         9geA41KDi9jPdK1xtyj/hJvpAKV1geeDzIydLbwU+AWB+uEFKxoMsmcyfuHyy0l2f3NA
         fw0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9UbsoVrZXV0NyzZLwP1Yktg8x9Y5Up5Jdwci4Fs1yxwkAgRpM9nnCjkpu4nDSGhLO88J+l2UTOxCjVU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylMGoaYYUqJX9/TUzRbWJWgPQrCJQggWAQ0tGsQjenYgLzIBaH
	qig4nHFItllem9saghv8xxETfhnRahKa0wBYj7yJrt9MHJZZKP/6I+usMsZGhVatLGXDwqwlXv0
	BBtFJciKggS4Bm8EDcswd8ifcE9yxEWKBLM42
X-Gm-Gg: ASbGncvIenIMC5Ni03j3WtOirWQhbjLJ0vOldBATyGG0kXmYumODpv0+wm1laJRwFXb
	jvXQhjxa1UMbqCzrL5Y+2XE/GNgESIYeilGDpucJi+HiOsypFMVGx5gFueSt/h8zGW2iLrtNkdB
	B5SLABpDVdOg4STafEH7THWJW8VFvw/vlABhxp3lIQXBekTWFJS8/uOvM=
X-Google-Smtp-Source: AGHT+IGUoxWTLAztNiddqS90ONGu3rvQnuDCbCesit2gdlHC+kOKEtqganfqXoIhnkABZRzs8OuZb+ulzkcEQBNab3Y=
X-Received: by 2002:a05:6808:4496:b0:3f5:50f3:4a6b with SMTP id
 5614622812f47-3fa2a3665aamr658959b6e.17.1741641168158; Mon, 10 Mar 2025
 14:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310161947.1767855-2-bqe@google.com> <CANiq72=uBYDBn2CS9OW-+S0=rCZEJFdrcBAk8yBQdNB+0Yjq=A@mail.gmail.com>
In-Reply-To: <CANiq72=uBYDBn2CS9OW-+S0=rCZEJFdrcBAk8yBQdNB+0Yjq=A@mail.gmail.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 10 Mar 2025 22:12:36 +0100
X-Gm-Features: AQ5f1JqgP31grpJaS8lvTpVVfKqXGO-9kUYRnKOUl0C3vG-gJ4omEHD7vCEhTbA
Message-ID: <CACQBu=XQC585EQFcQA9oXWp9iKuSLQW9XXEwhVisvq-vvA-0nA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:53=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Burak,
>
> Some quick notes...
>
> On Mon, Mar 10, 2025 at 5:20=E2=80=AFPM Burak Emir <bqe@google.com> wrote=
:
> >
> > +void rust_helper_bitmap_copy_and_extend(unsigned long *dst, const unsi=
gned long *src, unsigned int count, unsigned int size)
> > +{
> > +       bitmap_copy_and_extend(dst, src, count, size);
> > +}
>
> Please use the same parameter names as the real one, i.e. `to` and `from`=
.
>
> > +/// Wraps underlying C bitmap structure.
>
> I am not sure I would say it "structure" here, i.e. it seems like it
> actually wraps a C `struct bitmap`.
>
> In general, we also try to mention the "wraps ..." (if it actually did
> so) in a second paragraph, rather than doing so in the title.
>
> > +/// # Invariants
> > +///
> > +/// * `ptr` is obtained from a successful call to `bitmap_zalloc` and
>
> Also, you may remove the bullet list -- we currently do not enforce
> that it is always a bullet list (though we may in the future).
>
> > +    /// Pointer to an array of unsigned long.
>
> `unsigned long`
>
> > +    ptr: NonNull<usize>,
> > +    /// How many bits this bitmap stores. Must be < 2^32.
>
> Should the "Must be" be part of the invariants above?
>
> > +        // SAFETY: `self.ptr` was returned by bitmap_zalloc.
>
> "the C `bitmap_zalloc`"
>
> > +impl Bitmap {
> > +    /// Constructs a new [`Bitmap`].
> > +    ///
> > +    /// Fails with AllocError if `nbits` is greater than or equal to 2=
^32,
>
> Intra-doc links where possible: [`AllocError`].
>
> > +    /// # Example
>
> We use plurals even if there is a single example (like for the invariants=
).
>
> > +    /// ```
> > +    /// # use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// fn new_bitmap() -> Bitmap {
> > +    ///   Bitmap::new(128, GFP_KERNEL).unwrap()
> > +    /// }
> > +    /// ```
>
> Is there a reason why this example cannot be run? i.e. to not have it
> wrapped in a function.
>
> Also, please use the `?` operator if possible -- we try to write
> examples as "real code", so we try to avoid `unwrap()` etc.
>
> > +            Ok(Bitmap { ptr, nbits })
>
> When we have invariants, we use an `// INVARIANT: ...` comment (please
> grep for similar cases to see how it is usually done).
>
> > +    /// Returns how many bits this bitmap holds.
>
> We should have examples (which double as tests) for these.
>
> One alternative, that may be simpler to showcase how the type works,
> is to write a longer example in the documentation of the type itself.
>
> > +        // SAFETY: nbits =3D=3D 0 is supported and access is within bo=
unds.
>
> Markdown wherever possible, e.g. `nbits =3D=3D 0` (also other instance).
>
> Thanks!
>

Thanks, all done. Paying more attention to the markdown now and adding
a longer example.

Cheers,
Burak

> Cheers,
> Miguel

