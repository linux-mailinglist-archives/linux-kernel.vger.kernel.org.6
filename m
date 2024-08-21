Return-Path: <linux-kernel+bounces-296209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D361695A7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121231C20A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB717BB12;
	Wed, 21 Aug 2024 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7orBg3W"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7217B4E2;
	Wed, 21 Aug 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278428; cv=none; b=e+PgRYAkOEtU6IbVnmQ/ovMrXWiS27vRYlu7jGVz/zfd1Ne61Ss0kw2EjEprIRNz3MGF+H+ciWVrKcd5zLePg7pG/m5Nr0ZWAKlPlatv/lje7JlnoVf9QLLAX5aPdXWrqNmuQGoANC3iRdBFR3yhsmxpaQG6huyJ8gwpJuN+N30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278428; c=relaxed/simple;
	bh=QhXejlXvAomkFd8EP61NJGFSBPRUcQ/txFYLGv+s3pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4BeiveP222nTal3T9Hn+q7XCLilWndiofjBrNv77NNV4wjXjyybLF+AJCeJUGX+Y13apw3bp8MRj8qs02+409PVQJ84nwquV8itEunjj55LQ+ac+zbqZF9RFa7n7vuwm0Step40heXr3MDaJoDHeV7NScwcOJ8Jxqjh7Jpn08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7orBg3W; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-714269f312fso25304b3a.3;
        Wed, 21 Aug 2024 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724278427; x=1724883227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgTqsnBM9O5JTCZtnF9wRMYwA4akEnvManPLStJFabI=;
        b=B7orBg3WsC1vhGcusTTV2Mn3clOeYwKE8FxDdnR7NcSC2UdJi658T5eqxPF+KciAPw
         vJsbEQgDFIN/Gu7v0NMXan5O0z1QllcvaeeoeRyKSY1UZOMkIqyEZQQzxPOMfwZyk+28
         ePWJjeRQvV9TmekgnG0PkTOCCz9DJMOncq/6ve9QL27Pa32nJcoSJYHE+Ua8vZ4004pv
         +9vDMJt87ntPU8t8USxVQ1/7FRPzAWSu6PaPr7DoRnbbjts3vih52jXL0OZOzRcRAlAl
         U4ma9K6I4LeloYfNYttXocBuH2QXmhukCPTHvcn5gL/OHwhTv8Hgxz7B7bdLlSgpQZCU
         LjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724278427; x=1724883227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgTqsnBM9O5JTCZtnF9wRMYwA4akEnvManPLStJFabI=;
        b=rrObJHEvXbqXi4gRF8tPzzIjioC82JlVM4uoxIcoG6U1cGhKw86XdHzBCUu6Y4dI/0
         Oa5rzkrKLrLhz2I1AH+c6E+OoOn2yhEoVDpf21jAFHPeg+nZe03eva6VN+z/psNfy3g/
         IppO8tZn7AQ9ir5yj94TDLqiIfpluCCcgJEBqDR9JCC9Xr71QvocKkTLDEqr3LrASCmi
         w8RGQ61RkqZhE2esQeD9HsJrO7g2O4Hd4AWtNE5wQnInBUYrIz80Xz9Xi9JdyQi2tRr9
         okWl7HDFo4Fmmgx51c/blRsQ+HQxljOD/ph5DKnqAYYur0MMBwTkmbAMZlxjhdjI0rdX
         zlvg==
X-Forwarded-Encrypted: i=1; AJvYcCXPlT3iL45s+SqmCvKq39eWB1iTOJWdrEidyXxRv/vqlLx9dzo5YAsAnDwgKPHQZkw5CxtEMLRWxaXo1E0=@vger.kernel.org, AJvYcCXlo0hRXSL5uZ71+gD5XIb8/KzHQda6jBV5TIxDyi9dqRo7o7H4zDMeBp8jP2gR1gLxVgJExZUNvIt790if3Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7JxklOiEA6z/7noLCEqwUyne9CPQz/mtpMdnW2izXQHSACiG
	GA+SBNI8CeDAiOb+s02KdCy6FcSQGAay6Hg+vY7b+2bUR4Vin0VhSbhkfeZAP61kTsw68iQBuC1
	CqOOCzWrBz9uewKQwoXEDeQRZ13Y=
X-Google-Smtp-Source: AGHT+IFt49kL1Ixsc3kRci9+nRnfWm7P1N0g0CNp61ltVH4fSelwuKgrdRmJAH6JtYIjIvS6h/bvJPl/72+LTfQImeI=
X-Received: by 2002:a05:6a20:2588:b0:1c3:b106:d293 with SMTP id
 adf61e73a8af0-1cada0422f6mr2590110637.3.1724278426631; Wed, 21 Aug 2024
 15:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814163722.1550064-1-ojeda@kernel.org>
In-Reply-To: <20240814163722.1550064-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 Aug 2024 00:13:33 +0200
Message-ID: <CANiq72k435QRB1ZGLTaf-yPgGZ4br5UZCrCDx3TWZxDavAbJgA@mail.gmail.com>
Subject: Re: [PATCH] rust: enable bindgen's `--enable-function-attribute-detection`
 flag
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `bindgen` is able to detect certain function attributes and annotate
> functions correspondingly in its output for the Rust side, when the
> `--enable-function-attribute-detection` is passed.
>
> In particular, it is currently able to use `__must_check` in C
> (`#[must_use]` in Rust), which give us a bunch of annotations that are
> nice to have to prevent possible issues in Rust abstractions, e.g.:
>
>      extern "C" {
>     +    #[must_use]
>          pub fn kobject_add(
>              kobj: *mut kobject,
>              parent: *mut kobject,
>              fmt: *const core::ffi::c_char,
>              ...
>          ) -> core::ffi::c_int;
>      }
>
> Apparently, there are edge cases where this can make generation very slow=
,
> which is why it is behind a flag [1], but it does not seem to affect us
> in any major way at the moment.
>
> Link: https://github.com/rust-lang/rust-bindgen/issues/1465 [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3Du5Nrz_NW3U3_VqywJk=
D8pECA07q2pFDd1wjtXOWdkAQ@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

