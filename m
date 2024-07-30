Return-Path: <linux-kernel+bounces-267986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0966941F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA55282334
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE7189916;
	Tue, 30 Jul 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLKOUrwq"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698071A76C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362117; cv=none; b=G892tti6qjeNZZRIQkUWwq8wpYEMJmxM8ZVd2w2h7FP5v7DG/BFGSXFkD1v3Pcl6m3rjtQ1Of6SIpa4pWND8m4nxH/dVIcrOvAuGV+4DLTHgwixoROK4I5MjSMuN8+Qop++hY+4SSCSoSU4vz7Ap1k7xTWNGHz/410bM0X8B+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362117; c=relaxed/simple;
	bh=JH2Cd2lN6IoitPNPrBTESvV7VWxwDFLNLbMvOE9YGkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5hg2hFEDfe/yaTn7RZ5czj10q2cFfM3eCd9Ki5mtXgOo9FTupSRzOY0lfnOAhF4Jy83FoD9fykD9Adf/57P4Emr5QdjZvqP7K54vGiA6IZwHADbGHOhWzfoEXeO7K0d+aPUaOd5rx5RziKU8JPLA14/7c5c4H8GmrotPABNrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLKOUrwq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso30596535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722362113; x=1722966913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZVb9b6idPdGqOLlS0LbFKJPOJQMfcfymuIDhlC2e8U=;
        b=mLKOUrwqFZa6T0nnjfgtPp8pimtVksOVpOXOzcRYNRT5ZdEG9a32SjEdk4+fAQ1461
         58PZ47xygOZlAeF7LfN22d4zV61MHqFa2+5MfMJstwCK8ueHEmqpuRVzI9fdS4BCYstI
         eZteu/3S1qSbNPfCFNvFccnxkQCli98UsNCUAg3hM8TzLDTZ2BjSjxV4IT7dmOA5JmmC
         qKJNWutEPguWqxkYm3jtsJaBwbq6jwY4tjvSccOajT80Wnmm3vY3x8Inr1FGMAl+Htl7
         IZ4khNBSq9N5FWQxpglf8Nj8xZEbRi1hbXzj/zC17zGIaiRoBRj/BXRhbQzzrTNswpfd
         nAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362113; x=1722966913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZVb9b6idPdGqOLlS0LbFKJPOJQMfcfymuIDhlC2e8U=;
        b=R7LLvke9FTcyitDJf3fHp4L324cgNDpYRQSRCxvPZSpWwVSHzYW41E9DQA4CNxLn9E
         JbTHIT9Ui8T8fKmIE5H5Whg1oUEiQUKRpvO2tHqV3jonChSpPAqH1UtQX53kXZQJ1xev
         /9JqcXIqfWKRcRUx4XIofJlCoBt+pOT3vnku37aovW3N7GSAd0WFseocLJYU35bqcCjS
         PocHqY5topoRO6aVi6u1Y5nuRe/rMlY4BlSpCaCfwgtoudAgFqmHR2UjlarSUslGN+JX
         07RuaPOZcL8scUvMtl//3PzMwK/1rU8KITOBT8ZyUraodIAuCcOWwsKJKeK5wNF4IFTQ
         UAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYFstLEY1lA63yWEArZXzbS4ZsipnueduWAPUN5HaGzR75NeeBAsNZX3ZBE/z1R0rUXY8IoJGEXxYDkx9Hh4dRSjJX8DWrcXUn+6Qx
X-Gm-Message-State: AOJu0YxK/eoiXiLVcGr7RmIpsUYCN+CFvkr3WB43AofO+Au8Zov4zvx2
	5cg4hgOunGD1Z1Znr2mZjruEt1Up3DtMX5m3T/1lsdNPSTCjz4qdj7yX5pMvu/kyI1U2uV0Akq4
	O+0w8LCYyPg048Uw6/LB9dxb7WNWHRibyj54d
X-Google-Smtp-Source: AGHT+IGmM1tNNed7IrynwbRJCkV3w6w+USTXC/B0W7HVIfMnsxonH0cqX1VcweXyc+Pt8fczaIJn3PMNd+t6XksY8VY=
X-Received: by 2002:a05:6000:1e47:b0:367:f0f2:66c1 with SMTP id
 ffacd0b85a97d-36b5cee9ddcmr6956783f8f.12.1722362112425; Tue, 30 Jul 2024
 10:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730155702.1110144-1-ojeda@kernel.org>
In-Reply-To: <20240730155702.1110144-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 30 Jul 2024 19:55:00 +0200
Message-ID: <CAH5fLgj-0EsVjh8xdV1mXZBXPxKGnwUa8-R+Bg1eyjh0Gh_BWg@mail.gmail.com>
Subject: Re: [PATCH] rust: error: allow `useless_conversion` for 32-bit builds
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Sven Van Asbroeck <thesven73@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:57=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> For the new Rust support for 32-bit arm [1], Clippy warns:
>
>     error: useless conversion to the same type: `i32`
>        --> rust/kernel/error.rs:139:36
>         |
>     139 |         unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
>         |                                    ^^^^^^^^^^^^^ help: consider=
 removing `.into()`: `self.0`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#useless_conversion
>         =3D note: `-D clippy::useless-conversion` implied by `-D warnings=
`
>         =3D help: to override `-D warnings` add `#[allow(clippy::useless_=
conversion)]`
>
> The `self.0.into()` converts an `c_int` into `ERR_PTR`'s parameter
> which is a `c_long`. Thus, both types are `i32` in 32-bit. Therefore,
> allow it for those architectures.
>
> Link: https://lore.kernel.org/rust-for-linux/2dbd1491-149d-443c-9802-7578=
6a6a3b73@gmail.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/error.rs | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 145f5c397009..6f1587a2524e 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -135,8 +135,11 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_s=
tatus_t {
>      /// Returns the error encoded as a pointer.
>      #[allow(dead_code)]
>      pub(crate) fn to_ptr<T>(self) -> *mut T {
> +        #[cfg_attr(target_pointer_width =3D "32", allow(clippy::useless_=
conversion))]
>          // SAFETY: `self.0` is a valid error due to its invariant.
> -        unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
> +        unsafe {
> +            bindings::ERR_PTR(self.0.into()) as *mut _
> +        }
>      }

The formatting here is a bit weird. Perhaps we should swap the cfg and
the comment?

Either way, it looks good to me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

