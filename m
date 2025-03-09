Return-Path: <linux-kernel+bounces-553198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62798A5856A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25EE18898E8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C51DE4D9;
	Sun,  9 Mar 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHip8b2/"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7E1B0411;
	Sun,  9 Mar 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741534670; cv=none; b=pPKmy/5Y1nqUPR94gmmW3H5OCP6tu/Ih5nm0x5S8aQ4luXzehl6IfDrROXXxnpcXyYV6Ivvgk5Pb9Cec3pzvyC2ps2t1iFXAadfOx6zMTDr3zFoRpvqslQidI+hcXqRbweXuAAxtRBPtQdl4eCCVcbFjnFyB0hkhZXT1H8pvXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741534670; c=relaxed/simple;
	bh=cvQQpqY/vzRe+5UW3vLLwfo6uES1z5/hTjrAwRCdInA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdJhbhoLcIKTi/MXHVe3TKvsYN+P443kYOC4G6LyR3oRuogwqiTxZE6Ti2DeGKdGbOCeI1jky2gE1N3Mu466ee99C88HHcor9jcPBV+S343y7XxNEnIyX5XbdFxPX5jKHUGXd7UgM5BgMDXAd0rOIjAf5m1An7f2xM0/5LO3MlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHip8b2/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fa8so37068521fa.2;
        Sun, 09 Mar 2025 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741534667; x=1742139467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCcWhgqGKjjLzZiqRWLOTkw7UWhAnSp3FUfznOmcPMA=;
        b=AHip8b2/WgwSJLb6+TF5J6qfoM9OqXJje8mSArQubi8HQfiRjlB8eMPNO8etkOWqrS
         CPoDmGMZYedlh+9fylCFA78PMrfhzsngAg/fh3q+CXW0CEEiVjdi37g/ZAmIgV1l4AUf
         yNDhNX5ndyxZJ0YZHoYfQf/wKgdMMd4flJkXWrHI/2vq84v6nODiYhqEDAWFiH5QHJtZ
         itF3N4AUfVVZb6zkzZkIATKFnS+Thz1cDMIMtKa8odJ6/K37Y/+t+pT6VaQB0nYRBP42
         ksDePjpty7UXpsW5AexBjAsAaUY4+RFOLsbCwVJumyg9KXFXD06jQH1718AWTlMkIYtg
         Gg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741534667; x=1742139467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCcWhgqGKjjLzZiqRWLOTkw7UWhAnSp3FUfznOmcPMA=;
        b=NQarhC+eYhnArfvEmJ18bs5Lucmf/iJIoiw0si1CuCfZhNeC/6xDFGNAzPKvkpDWTb
         JyawL2gXO14/C4pN8yJNtzPMGFTQ6qhc8IuIuwysfI+8mmYwhvF6c3sIX+lqHyizX09Z
         QVy1tZ/nMmgqMkQi9BYVXVPcxG2pG/NFtc10+u5DomTzboPx1/aeCXgXBQ/k5ALJCMnJ
         nfGMf/0VQJt0o0hjWIHGkzTNbk+nqznqq2qb7ooyHOdnLB3B+a6QWsweYIo152H8TNxX
         rvQEvcvVID386+qq0+v8Uq2EoqNuPT6QKx5EsVSxV7TJYnVTr5Kz2HukMZi1T5IIA9oJ
         aBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW6Jki2dgvtyf0oY2iMXVSUeaHQEKpBtgXjp2qmxvxfyKqJZigJXjdUifJcWR8IsLCU2F+rEsKBN/BsQvyJpA=@vger.kernel.org, AJvYcCVrXrwX7QVRSjE1aINHSqWMlTKrmGEA+taZNp3u/6o5fO+28mxZh5aQzSCPJFdEcYVHgVbLE7kK7wBo9m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVMcFyGZCzo84HjJUv3TYsEJ6QwdKChWBXxMlxtM1AFtVykPC
	cNK0bIqpKJ8QAXtac97up1K9/KlPt1b7pL51Ae8X4ycgBxxYOjcGb6u4gfsuecrDemvvHZlx94O
	IuOP8E/OTiUcFj7qcfIHVLJNlZm8=
X-Gm-Gg: ASbGnctiyRb+7en+ohAB52gi4ITCNOuswWlJHabVlDtsTkkvZPji0mGs5AEky+5NkrV
	+f6oWR2O7GeTDNp4yOJeOxIE7e2yx4ML3Eo8JKdEr0FDu/muguY0z7xXo3lxqgqEMtHDUmx9Zzq
	IpVfw+JiopBSFs2WLYuPpx4WNgCgAlhCF/5haDo99GKuI+cB7hBMJ3PWs8Nw5I
X-Google-Smtp-Source: AGHT+IFb6lG86m4/uPfqK5YvjlKkFeRxGWfawgYH5KwGwah2p0oo6kviBujMPalb1a7aLWeKXOgVPleYAG8jXJrJbeA=
X-Received: by 2002:a05:651c:b0b:b0:30c:b2c:edb6 with SMTP id
 38308e7fff4ca-30c0b2cfe02mr8972331fa.18.1741534666589; Sun, 09 Mar 2025
 08:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org> <20250309-hrtimer-v3-v6-12-rc2-v12-4-73586e2bd5f1@kernel.org>
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-4-73586e2bd5f1@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 9 Mar 2025 11:37:10 -0400
X-Gm-Features: AQ5f1JpQyCUgIB5D7ZUsSoVRS8Q2SNvbwOTB4BwEhTpNaLLF3xcI_4ybE9QaqIU
Message-ID: <CAJ-ks9mykUNSVX=_OFFEV6RokVsRe5zXharG68j1Ag=CeW-77w@mail.gmail.com>
Subject: Re: [PATCH v12 04/13] rust: hrtimer: allow timer restart from timer handler
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 11:22=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Allow timer handlers to report that they want a timer to be restarted aft=
er
> the timer handler has finished executing.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs     | 18 +++++++++++++++++-
>  rust/kernel/time/hrtimer/arc.rs |  4 +---
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index c6d6eaed31aa..78afb093aee8 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -212,7 +212,7 @@ pub trait HrTimerCallback {
>      type Pointer<'a>: RawHrTimerCallback;
>
>      /// Called by the timer logic when the timer fires.
> -    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarg=
et<'_>)
> +    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarg=
et<'_>) -> HrTimerRestart
>      where
>          Self: Sized;
>  }
> @@ -312,6 +312,22 @@ unsafe fn start(this: *const Self, expires: Ktime) {
>      }
>  }
>
> +/// Restart policy for timers.
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +#[repr(u32)]
> +pub enum HrTimerRestart {
> +    /// Timer should not be restarted.
> +    NoRestart =3D bindings::hrtimer_restart_HRTIMER_NORESTART,
> +    /// Timer should be restarted.
> +    Restart =3D bindings::hrtimer_restart_HRTIMER_RESTART,
> +}

Instead of writing this enum by hand, could we use the
`--rustified-enum` option to bindgen? I added `--rustified-enum
hrtimer_restart` in `rust/bindgen_parameters` and the result was

#[repr(u32)]
#[derive(Copy, Clone, Hash, PartialEq, Eq)]
pub enum hrtimer_restart {
    HRTIMER_NORESTART =3D 0,
    HRTIMER_RESTART =3D 1,
}

what do you think? This can be revisited, so either way:

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

