Return-Path: <linux-kernel+bounces-183552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA18C9A88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E992D1C2193C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB949225A2;
	Mon, 20 May 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmpE2Aug"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CB1F94C
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198029; cv=none; b=nTPlwkcAxiibBBwxPfPU1kvFP+q2SbiZiTdOHxB0u8hxRGb6WLafzYFxPGgtNxAHGb6L3JPX6F/egjbhMBMj2uDvvD/zamK/Vuu93/YaFJdnPZWI/8xLTTtetEYWvX0Hscfi0DezU16v3JtXenK4Y41Hf95bBYDLFUy0mGzr+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198029; c=relaxed/simple;
	bh=hlbB+kN75U9YScWnGXlfgm/HK3XeDX7QVEgtfCxUOBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThU33VYMM/lX4BlNi0dtTFrUElYHGuziAgTcGpsOIS2Jlz60XBm2gJyN3mV6+xxZBhhdH1mt+ZJjSTH/Tq3ykLqtR18wJB+gR/WJ7sZGCt2mFD7upqt5KgVdIqluo3ud/PBhGuJM3Yfd5Zkyksyon8CyZJodRUrQH1vWz2W7d/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmpE2Aug; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7f3317ff3c2so869720241.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716198027; x=1716802827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWeEZYLQFowsoh5tWMf37zmjnQP8pREzFJH0TgxKuRc=;
        b=XmpE2AugI/3BFEc2tnmw00bRgcvxtiEKExQI+9wVi66HQBeRM6EZYxWQRXULA2LHNx
         cgeRykmBbYoLGBW2eW5SwiOx8hH9j1TJhMOao0yeU/m3Hi0Fitm6tqYqWnkKo4lXk5Nj
         v169mXgJ38jdSXJR/jhwW2cuLMVyrEKqyLCjAZ2whHvvvodHO9Kkcb+E3rTLEFdLTtjq
         Y4lC4XlvY0vfpDKDtnqOKX3C6lKD839o3X9vPerDyGOd2Ty8qfBRIbrRb7qa9tLETgKH
         BpfEEVAyCgRssg4+wcDeun59hmEx3wAXJICdOy5e7MC25NMtS4cxLbvyNIydCWkTStaG
         oDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716198027; x=1716802827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWeEZYLQFowsoh5tWMf37zmjnQP8pREzFJH0TgxKuRc=;
        b=JYcMkcq4GAvo0jyPNjjDKIrjJv76IiR7pnYpVM1jZ+iyoQD2rNaBd/riQrJQHidn+P
         9ylIXrQu1vklr3XmUKcNdXl8Bew1tjT1I+SQmuGRULO/9J4qZjRVkEwgDoAM/xZNAzXn
         udOCxvPv+tVBab62PdnCglgGxB4tMatd5NR4YWM0U4bJnx08M8VLQAUCzFcSVhMfO2dy
         Alqa8V0Xtc+pYol2md6PKjGIxEvIEr6WC17rpZZFmMLDhMFJPznCtO8P6MvyFTV2ZY9y
         26RfsifNpnDDkAS16hiBnpOkcDY+7cWkiHjM3uK4wNoip28F4KQ+Ef3AnN+uL/p/uS1L
         w0uA==
X-Forwarded-Encrypted: i=1; AJvYcCXiVGamlBF14EARvz9rI/HYcAU3nrXEixFe8kqGyBBdGS/g9xFM9hRiyZD1o8jKn8RCMZH5hyGpl9ClIb8kmSqOi2ELb6g1OAiA4eHx
X-Gm-Message-State: AOJu0YyqOyLbus5EabZXplUmnCon9DJhxj8w9A7M/l/uge9McvI995s8
	i5aYRdmh7o+JyiMugBkC/67bD0MwP7jLzB3y03sHUlOsJqBxpfmpUiVCNrQLFqqZwKAIZPSBp8d
	iQ7R76V7fchvuRIlhoGogz/3my1DtLrmKFs6r
X-Google-Smtp-Source: AGHT+IGRslYvtPZVflT9H/QVdXO5/e6Xw9lf8JCxCi36VGobIaGTO31kcm2q5Iy/MccVAuZ4g5GXjchLPJr6wZYIugk=
X-Received: by 2002:a05:6102:32cb:b0:47e:f5a5:7f79 with SMTP id
 ada2fe7eead31-48077dce359mr29874881137.2.1716198025227; Mon, 20 May 2024
 02:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519210735.587323-1-ojeda@kernel.org>
In-Reply-To: <20240519210735.587323-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 20 May 2024 11:40:12 +0200
Message-ID: <CAH5fLghTdgWyEQFLL8VVSFBNq1hgXPF0gqoM2KETD=Ubj8xV9Q@mail.gmail.com>
Subject: Re: [PATCH] rust: avoid unused import warning in `rusttest`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:07=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> When compiling for the `rusttest` target, the `core::ptr` import is
> unused since its only use happens in the `reserve()` method which is
> not compiled in that target:
>
>     warning: unused import: `core::ptr`
>     --> rust/kernel/alloc/vec_ext.rs:7:5
>       |
>     7 | use core::ptr;
>       |     ^^^^^^^^^
>       |
>       =3D note: `#[warn(unused_imports)]` on by default
>
> Thus clean it.
>
> Fixes: 97ab3e8eec0c ("rust: alloc: fix dangling pointer in VecExt<T>::res=
erve()")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

