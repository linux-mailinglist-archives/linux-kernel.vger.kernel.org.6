Return-Path: <linux-kernel+bounces-554733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBECA59BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1A5188A68F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652F234969;
	Mon, 10 Mar 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgq+b2QE"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66E231A2B;
	Mon, 10 Mar 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625605; cv=none; b=X8DP/XGlKW23kpQikU7CohZ6LfDVN1M0I3GBba/QsaNlcY8V0IS6gwMxYt++9LLlRCqp7UYto1xk1JePcfik4XdSh773Mn6lQ2hvvLCZDiubZh7TlyUqp/EXqckHu1Hy1bOhPfckdlH7or3F37MbrsqprSOxnaB6s1Wk8hy1Uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625605; c=relaxed/simple;
	bh=AyfR641cdKCZy6W0n6TlmM4KyPqA41GREqbdpaC3pjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2bVtH9TC7097ptvdh2QHxqcVOZAwMz6iv26istW+vFpq4dVU2pus7ieMdVmcuv9dVXTePdPuiG+TA/QBQdWQmv+IR6/TwYfPM8utQbnYNh5W+0V5kVYrQJUVGuP70VQulXMKA1qL5BEFpnCV06gG6Em9D7dfBSCFnSKZbDQPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgq+b2QE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff7cf59a8fso972627a91.3;
        Mon, 10 Mar 2025 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741625603; x=1742230403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGWCx+SP2CEwzo/yDt6/toEmCVnke5ZqmE53jF+Pnaw=;
        b=Xgq+b2QEz7XsPyKSWLgfS/XebKnyR5OqAm1O3i/VIPlscetSBaWoV5PPXtk5m+NX95
         KOptRjHaWx+Vz8RYjvy8q2xGRs6tOMgQE5+SGuxDN4vsvIFUI4+UYu1p3zbDRGLDdHdV
         9pxt6UzDTVgR+QF2Oea+UZdYFR/zk5hU4xQVeE/H0kk5LutjuntGFKEZNcWOAbcPLnHw
         HggvO022Wr0hED0LxjbQl5sDtfKuVF1hWjGqZ/pofmmXEFeCmT5nIKNwlKUj0pc7FtAn
         7z+w5ZXMjbKout8ilJ6RlRTnoUIaSPNCOmkvf+hBCTMW/9DLchC/05JqqNKGFjUu4b81
         vtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625603; x=1742230403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGWCx+SP2CEwzo/yDt6/toEmCVnke5ZqmE53jF+Pnaw=;
        b=YyPHCCHaXQK/BU7L03cG3MnON9nO5mEpHVFuHG0BziU6jnYP234f4/fP2bL80qkx5g
         7aK3kcMNFrEn96BkbH2ymK8K784/Cug4mIG50ImrB3iOsGBjaIBctjE5n8JXIIcSf80G
         G3uxwWAFVIRZRg0ku6TDpLjneJt6DKdSdpM2iRTgg/h9VoYENXNS04ZFSq8ahoccK2tf
         FCgk7UuHNqMuFztcCRo6jpLO9V8ATCygmGPEU9fCrDM1egyzWsHaU7nFEthASfRpY316
         TNR63+Hs5d7fV0suDydAkRpqFKH8lZ1VhZUyfTLZ1qRp51L3Sxg9KOP0x56CGX41Ui+o
         t+MA==
X-Forwarded-Encrypted: i=1; AJvYcCWhURlpKF8zw4y+GWPn/52g6oFaw0Rh/mS+bOfQtBFnXpA+tFzp2gEDJql1P+aPugY0VJjt2Dg+zGoRPka/lUk=@vger.kernel.org, AJvYcCXpDZtqC84arwmiqxvHZT+y788w8VWjEv1ywDkMoju+C7RKVFxd75Rm4djzEn7xI8RT9H+ipXUPVBvWPQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPqrbX2yw6kcrSyDmvEz7KyuthjL4fQ9LH0xtfl3x6e/xE+/a
	yGUDIuQgmdANx42RdzXjhPvZ2O1IgVEwcB+iolFRwJ0MB5v1dHZZ1tc/lgwbj6kHuWTJ/PGE4nC
	ZExnPWFsVqoj2oLw4FASqhfjdHbQ=
X-Gm-Gg: ASbGncuFzZIx8vB/7rRZ32As5nf9VI7hDu/RoFv+3i7btxP1Wo6i5AesbtjZ3fHR1gg
	ln4hOx7mFGLqniV4bjB/T+GVyyFAOLFEE/XfOaHVvOn8fmgqe4vy5cPgYRqsOCZ2VKQhyBQNGrd
	MOLOyN36wGVplkTfXNSuKllT+daw==
X-Google-Smtp-Source: AGHT+IEYPLWSokqycAlJYDknETMKQnZPApe3+mtQKMISpbNvpmAarVnfXC69vQZ7iPcoM2dsavEQ/18114ggROUq/0s=
X-Received: by 2002:a17:90b:224d:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-300ff897fd9mr235938a91.4.1741625603212; Mon, 10 Mar 2025
 09:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310161947.1767855-2-bqe@google.com>
In-Reply-To: <20250310161947.1767855-2-bqe@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 17:53:10 +0100
X-Gm-Features: AQ5f1JqSAgmpt3Iw0rHmDnmkw3gQAiO5-r-omP0lH1MAV1e7rN4oiPAdku5NFKY
Message-ID: <CANiq72=uBYDBn2CS9OW-+S0=rCZEJFdrcBAk8yBQdNB+0Yjq=A@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Burak,

Some quick notes...

On Mon, Mar 10, 2025 at 5:20=E2=80=AFPM Burak Emir <bqe@google.com> wrote:
>
> +void rust_helper_bitmap_copy_and_extend(unsigned long *dst, const unsign=
ed long *src, unsigned int count, unsigned int size)
> +{
> +       bitmap_copy_and_extend(dst, src, count, size);
> +}

Please use the same parameter names as the real one, i.e. `to` and `from`.

> +/// Wraps underlying C bitmap structure.

I am not sure I would say it "structure" here, i.e. it seems like it
actually wraps a C `struct bitmap`.

In general, we also try to mention the "wraps ..." (if it actually did
so) in a second paragraph, rather than doing so in the title.

> +/// # Invariants
> +///
> +/// * `ptr` is obtained from a successful call to `bitmap_zalloc` and

Also, you may remove the bullet list -- we currently do not enforce
that it is always a bullet list (though we may in the future).

> +    /// Pointer to an array of unsigned long.

`unsigned long`

> +    ptr: NonNull<usize>,
> +    /// How many bits this bitmap stores. Must be < 2^32.

Should the "Must be" be part of the invariants above?

> +        // SAFETY: `self.ptr` was returned by bitmap_zalloc.

"the C `bitmap_zalloc`"

> +impl Bitmap {
> +    /// Constructs a new [`Bitmap`].
> +    ///
> +    /// Fails with AllocError if `nbits` is greater than or equal to 2^3=
2,

Intra-doc links where possible: [`AllocError`].

> +    /// # Example

We use plurals even if there is a single example (like for the invariants).

> +    /// ```
> +    /// # use kernel::bitmap::Bitmap;
> +    ///
> +    /// fn new_bitmap() -> Bitmap {
> +    ///   Bitmap::new(128, GFP_KERNEL).unwrap()
> +    /// }
> +    /// ```

Is there a reason why this example cannot be run? i.e. to not have it
wrapped in a function.

Also, please use the `?` operator if possible -- we try to write
examples as "real code", so we try to avoid `unwrap()` etc.

> +            Ok(Bitmap { ptr, nbits })

When we have invariants, we use an `// INVARIANT: ...` comment (please
grep for similar cases to see how it is usually done).

> +    /// Returns how many bits this bitmap holds.

We should have examples (which double as tests) for these.

One alternative, that may be simpler to showcase how the type works,
is to write a longer example in the documentation of the type itself.

> +        // SAFETY: nbits =3D=3D 0 is supported and access is within boun=
ds.

Markdown wherever possible, e.g. `nbits =3D=3D 0` (also other instance).

Thanks!

Cheers,
Miguel

