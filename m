Return-Path: <linux-kernel+bounces-385253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C69B3499
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1591C21CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D511DE3C5;
	Mon, 28 Oct 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ogg5Krat"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDF1DE2CF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128691; cv=none; b=mKnxq3QOX9bE/Vsergat9DfQ+azj4YPcsjfGHkCAizaLdZ19iVHpEdUVAv9EAyLBZvvHErUN95g/nhN3zIXH1YGBQnlLBhhJ+8g2ewDgT39WVZqLqh6+dekloe5N8rseYjqQCQG2xpcYv7tP4JRGZ/8ttO2UtsWpcV5g7LXQ91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128691; c=relaxed/simple;
	bh=q/0+tkYI5bNjwo8HanO/z9VdvEfdgc33WYasp4apUs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uds13tUyidteuhDFIl4O8qhLdTwP3Ah4YbhQ6XEoxazlzk7Wm+2U127ZnP3u+oKnz/e0akmWSdjLI6cjQf4ZYT6PZobsdxLlBWzCiuBvErYxWfJet8w8XmdeANpjYtAcdGbgGOTXNEprz+Q3Katy579qng8p5g/hYkzx58E7qHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ogg5Krat; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43193678216so31746725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730128687; x=1730733487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9UYqjv3kpCsvVaf+yhQYbY8eaOWe7oMd7SNEJNj1Mo=;
        b=Ogg5KratyIH4B74dHxB0cctGWcx+XS44D5880cMuEfVcAqGr16q/63SWetqqOyTnDW
         /kSXH2Q2uZz2nyYZ3fZckaDqfSnOtyLxtJnHBXlabh8vQVI/UcQOhiwLEMg56uFe8Lhf
         EMmN9PHQ5tbUihjsdFFwg5VzA9/YLS+qu/kMG9J+/A1L4LAF0ft35D1jO8KUglsreRsX
         zBqnZAxwqkLWhMjPZ671kbCEW/u8eQn5TAk9FNKnZHYUosEZBWtxO75Hv5YWvn4ny40A
         xB1fmfdronOC/L5XWXVGoT+hYzjyeYQPY3i6i/IFuej/nkbj+gNH2/ykpRFdVOWSnVRj
         x+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128687; x=1730733487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9UYqjv3kpCsvVaf+yhQYbY8eaOWe7oMd7SNEJNj1Mo=;
        b=C7C4kQyZnURUj5wMUVOx/zx4pirQv4lv05ZNuL1fT+RJW8o2rHbw1C4YcScGVUWHWC
         bk4qKXxJNzOJ2+w4ibyRAsOu5Ci5NDGUBjKIE5BWSSKAe+kWU6dIAF739p/RFJ9T+FVC
         va0hdi2qq1S5EF/EBNKS8JC2sVFd6BlrICB00VgYYxgD3Zy8snE5uWbhrLN0dVmQ+Fmu
         C9qPDGa+F8fTqNxz8ynV5U0ZhuUIwclzHfC19Xlcq4AQbPfPjVb61LcARtH/YL1NvcpZ
         qCPgF7uwLOIjAQ5A0d4hyVjzHnkexUuI2mYv0vfUbZGonHe68Y3i9AAFt+EECODrXRBB
         vzxw==
X-Forwarded-Encrypted: i=1; AJvYcCUq1a6hbfjEoHykkRhw18xG6pqtNoVKM7L1xU5WvGb1G8PdQaXr3ZNm6YKF7JOJHoWzjO9+NfSEQdIdh60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fqfib12KieVxTPGvOjL6a08+GdNNzPd6vw693ol+Elz47QCh
	76J91nCDuHGtv5QbVHjYc3a9R/6PpBQhT19LDR89Mjq2047AsVX85wDtSELxE9rLeqrT22Fcjmp
	z/siss4L8WThJEmv+tI26g1fGs1qxXa+TS4Ww
X-Google-Smtp-Source: AGHT+IG8IlRulUeU8MVBvRA5xQ95yrZVFmxS8Of+zdiWkSTJFGX3IxuumGa4sA7FEuCwTbT/e6K/Nvse82eAIrlfIfI=
X-Received: by 2002:a05:600c:4694:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-4319ad0aefbmr85861345e9.26.1730128686556; Mon, 28 Oct 2024
 08:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>
In-Reply-To: <20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 28 Oct 2024 16:17:53 +0100
Message-ID: <CAH5fLgjOKQdKViAGArMjvXjVmYpbo_sA8xoQGwu+DCW1FDFRXA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kernel: add support for bits/genmask macros
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:18=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> These macros are converted from their kernel equivalent.
>
> ---
> - Added ticks around `BIT`, and `h >=3Dl` (Thanks, Benno).
> - Decided to keep the arguments as `expr`, as I see no issues with that
> - Added a proper example, with an assert_eq!() (Thanks, Benno)
> - Fixed the condition h <=3D l, which should be h >=3D l.
> - Checked that the assert for the condition above is described in the
>   docs.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

My main question here is whether this should be a macro_rules! or const fn.

One factor in favor of a macro is that if you need it to work in const
context, then you can't use generics, which means that you must
restrict it so it only works with a single integer type. On the other
hand, genmask! already only works for the u64 type, so that argument
doesn't work for genmask!.

Either way, I'd like to see the reason for your choice in the commit messag=
e.

>  rust/kernel/bits.rs | 36 ++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs  |  1 +
>  2 files changed, 37 insertions(+)
>
> diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..479883984f995f6b44272fa45=
66a08f1c1e6b143
> --- /dev/null
> +++ b/rust/kernel/bits.rs
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Bit manipulation macros.
> +//!
> +//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
> +
> +/// Produces a literal where bit `n` is set.
> +///
> +/// Equivalent to the kernel's `BIT` macro.
> +///
> +#[macro_export]
> +macro_rules! bit {
> +    ($n:expr) =3D> {
> +        (1 << $n)
> +    };
> +}
> +
> +/// Create a contiguous bitmask starting at bit position `l` and ending =
at
> +/// position `h`, where `h >=3D l`.
> +///
> +/// # Examples
> +/// ```
> +///     use kernel::genmask;
> +///     let mask =3D genmask!(39, 21);
> +///     assert_eq!(mask, 0x000000ffffe00000);
> +/// ```
> +///
> +#[macro_export]
> +macro_rules! genmask {
> +    ($h:expr, $l:expr) =3D> {{
> +        const _: () =3D {
> +            assert!($h >=3D $l);
> +        };

Based on the error reported by the bot, you probably need to use
`$crate::build_assert!` here instead of the stdlib `assert!` macro. I
don't think the stdlib macro works in const context.

> +        ((!0u64 - (1u64 << $l) + 1) & (!0u64 >> (64 - 1 - $h)))

The implementation looks okay. I tried it:
fn main() {
    println!("{:03b}", genmask!(0,0));
    println!("{:03b}", genmask!(1,0));
    println!("{:03b}", genmask!(2,0));
    println!("{:03b}", genmask!(2,1));
}
prints:
001
011
111
110

Alice

