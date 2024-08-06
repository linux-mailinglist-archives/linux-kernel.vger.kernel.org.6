Return-Path: <linux-kernel+bounces-276725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF1949795
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FA5284E79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D9812C49B;
	Tue,  6 Aug 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="qH0UmKmr"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92874C1B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969049; cv=none; b=gQtvwpr1jX+9dx8/M2P6O/O8M4Ms/ndyEtU4J8RID15/Mian5vuQtsI7tTl0IolRA1z1yvlBCjivQsaCoteWfxCYVGOnzfWUZ+MHs2AAtCIyrtDXFKIdGjWxJuOJxzp6cQ+/uqVv9RUGT8oBQeofm/RoU8fu98g9DLjOOMlP52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969049; c=relaxed/simple;
	bh=oe38/BA3I3GPzGRZcA4tK3QobjJz3lxhxxE69sqobgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxtrWtmSCAKm3URQlTop17+F4D3P/f5qd+m9KQKAQf6m4/cZQzVIEkk/N6OE6jvCT4s8ANTN3ZLktlcNPZ1ZdZGhTp9EAcNep627xWQwDirglJqL+orxqBaDPUMiqtB6RbXymfXim0OntDJ6CmrQJdnJySLfMU0cexyLNRap+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=qH0UmKmr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-682ff2f0e67so10834887b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1722969045; x=1723573845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJcjEsELElj17ftf1H3NNxeE2XuKAN8uQ1oS0Kp4OuE=;
        b=qH0UmKmrO5pSotYBPE0TwmSSmkwcMGNZskTXkb9M3FQUgEbjfdOBzyIYU7tkLkSFSl
         YEu/LhvO+ZMTJ1BvJw/yXVa51+oBUWC6Xjx+kSnCWbJGEuG+Amde+MAmQ6NCNMua6vVF
         bkeDK48LgmrEjo6HOiXg1Q2cVM7H8sWWLDitdAqdUXyMBt/hY7K0gY6VXhSGFLPZP1Sy
         i1b5u1TPYUp6tro/yDQ8McWPObz9DHtd8jLnLmbsUdqsSrTTg08GhryfDQDep9kOONwo
         hk2mzyd24++j52RFlHUEsK65VKNUZ8pXyTebG1HjGfaGdNcceCy0qwEgs4AzvqVyUOQt
         EHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969045; x=1723573845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJcjEsELElj17ftf1H3NNxeE2XuKAN8uQ1oS0Kp4OuE=;
        b=qpiVtDmidnEAfeyF1tNRbBAI2+Svfli2BpmVSdBGJSlu0lCxqANNrhfUfFmUy3S4wH
         UyUKeb/RWpvWRrUlr3TNBqAINfkT3l7xKVg3uBim/1qttwMoyJ9srd731Y00Gf83s0hd
         8ZF0Ha8JEuRFA3dK2LIWydAALBc5jZOxtf1h4zvC0RiSNit874XTfRUpM0gyemals5eN
         fL6fhJsvg6CBTZ0QQ2Lh/SVYK+ROgcjJzuVoq5PwUiT3SNsTRoMD0oJ64NrYWu52BtfC
         TCcQHSFYm19SG7i1yLV2EW9RY3z/JYcVvXQQs7zzEeXIYCu3Mie45vRkkGB3tOhAI1WF
         gjBw==
X-Forwarded-Encrypted: i=1; AJvYcCUe37+t4qXhNVJMWX8ZAXjpGIT2VnAKObzz54KlBLuR7GBaNrRZhbfrlcRhI9UXxXn0MWytebK54vpsd2lAOMk6IZo8dKP+K4ExRFtV
X-Gm-Message-State: AOJu0YyHF3bh67QzIUvACq5dLpoIBXlmdqdMQcFdr/6FGjKG8zyPjz5d
	pUX6IParTYE0X6qMWRM+RHGDIb3/1yfJIwWFr1Aqa+gA9rbHZEgQYVKa344fvBLD1/vT7QhSSDv
	+jN8tPMG5JIdw5UYf11OVvCP64Me+UZh140GKZQ==
X-Google-Smtp-Source: AGHT+IEi5wEKcxYijrCG9lZ62HVarFC1N/dov62z2Vvk1px7mbW2C3yfR+rXHXlo0cHub/OfafmZkMejgkYcoEw+XE8=
X-Received: by 2002:a81:5b06:0:b0:65f:9e35:af1a with SMTP id
 00721157ae682-68964590c97mr153755347b3.41.1722969045434; Tue, 06 Aug 2024
 11:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806150619.192882-1-ojeda@kernel.org>
In-Reply-To: <20240806150619.192882-1-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 6 Aug 2024 14:30:33 -0400
Message-ID: <CALNs47swnK6je1o+LOLUFCDEZJmQmZx8vZ+7MPvUbNKdFr_Q_Q@mail.gmail.com>
Subject: Re: [PATCH] rust: add intrinsics to fix `-Os` builds
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:06=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Alice reported [1] that an arm64 build failed with:
>
>     ld.lld: error: undefined symbol: __extendsfdf2
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
>
>     ld.lld: error: undefined symbol: __truncdfsf2
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
>
> Rust 1.80.0 or later together with `CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy`
> is what triggers it.
>
> In addition, x86_64 builds also fail the same way.
>
> Similarly, compiling with Rust 1.82.0 (currently in nightly) makes
> another one appear, possibly due to the LLVM 19 upgrade there:
>
>     ld.lld: error: undefined symbol: __eqdf2
>     >>> referenced by core.20495ea57a9f069d-cgu.0
>     >>>               rust/core.o:(<f64>::next_up) in archive vmlinux.a
>     >>> referenced by core.20495ea57a9f069d-cgu.0
>     >>>               rust/core.o:(<f64>::next_down) in archive vmlinux.a
>
> Gary adds [1]:
>
> > Usually the fix on rustc side is to mark those functions as `#[inline]`
> >
> > All of {midpoint,next_up,next_down} are indeed unstable functions not
> > marked as inline...
>
> Fix all those by adding those intrinsics to our usual workaround.
>
> Cc: Gary Guo <gary@garyguo.net>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Genera=
l/topic/v6.2E11-rc1.20doesn't.20build.20for.20arm64/near/455637364

Should this link have the `[1]`?

> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/Makefile             | 4 ++--
>  rust/compiler_builtins.rs | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Trevor Gross <tmgross@umich.edu>

Also submitted a fix upstream https://github.com/rust-lang/rust/pull/128749=
.

- Trevor

