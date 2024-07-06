Return-Path: <linux-kernel+bounces-243254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63E92939D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5091F21E7A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D4763F8;
	Sat,  6 Jul 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgNUMCLo"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFC17FE;
	Sat,  6 Jul 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720269634; cv=none; b=cMqicoHBNXT6SlbBipOPVuE8fnRID87V55xwDHQtHcf06gOiQIT1QbAWRrxS/Ckb8nT2ekOoZl4IgXb5gU/OMCu3U7fg/2Iij2h0JB70De1UHudsyNs3zRLcy3JgZQUVKoDXmUV2lOtJ5iM2whW0RwkKMIL+zJ2hbXRd8GoQx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720269634; c=relaxed/simple;
	bh=j3UTqJfzsjIWbMszseeWkbC4a6y7kzVbRtpw0k1TAaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYMvNoFyvuPrD7oslpUyCHS/kroljaSZl+wMB/l3Mee4dkj03T/XFYpYSXt+oqBfHmF6KveFa5R8OEoazOiNt7tALGjrCsrb8l+MI20EcEiEw4gtEIc6u0tVsqXoFXB0NbKnpcNAM0tMTpI1BjDZGWSgpnmmqxTOA8OB4bxYRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgNUMCLo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c980b55741so1601165a91.2;
        Sat, 06 Jul 2024 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720269633; x=1720874433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3UTqJfzsjIWbMszseeWkbC4a6y7kzVbRtpw0k1TAaw=;
        b=IgNUMCLolStdz5tvGRtzkq7p/sfTJ+VvuIBKzhZxRTUGo8CBwlxx3CDS+Zi3LJqp2R
         SfdAEP0borCE6DfFOb/TG2I6qtyso1zM6+0dAeZ505b2/a5Zmuc0LoolTHRrPaChwwjF
         FWJ9ByZZFP0dK2TB51r++q5A1X4GtAJSQ9v2OPxWWIWdZ7AtZ3R75awVD6KBeVxZKwun
         nsS4N4Zg34UoTYuNFBSXkeKrA05kvmdcZYBMQ/GuHk/NhYhERHzOd6q/0DhAfIXdCJGS
         10j7mi60X5ZygrNm4wwlJgRxWUqr0oksVOz5Lccxf2w7Sh76YS7tNTCcnvoqyLRVpGWf
         w6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720269633; x=1720874433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3UTqJfzsjIWbMszseeWkbC4a6y7kzVbRtpw0k1TAaw=;
        b=G01n3oYl9cE4FFffTEm+Y/Q2WqBNoOlvXfxwrNOKxds6usDW4vGV1Y55a8/902Znsa
         S5d6Hk32VEVrbDWKQ0PhydVcAKfNPPZbSodXepLkSANAVrxH1CAjNo+HmsWH+4bGeMYi
         wAZAbnjBp6yeEw6SB1sFK5cmBtkW+3yl+y4S4o+lHO1fSaRXhBtst6O8SPiUEVLdkDFq
         YG23bk8tR/N1aAGM7q6TM2Go2EvZY5YYgF3yNq8gmjsSfj/BZ0la5P/8Oe1TpNVC+9f0
         sv8qExqQL2IMe/4NI3OBANBsIj22RD0LlmtY5WA7DHqsh0KrzeK6uZAfpgmgihT0DgmA
         wf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1qIv/30b+nM5bS+Bp5M9pN87UtAZ7Qi1Xl964a7p8rjnMRXoI3GZ+Vh3nHV6wABM7WU7b0GIsYvIBACHaw6Q+rgb4iHcSwFvym1fqDyklkFULCFcw1E/GzqSDok4AQOuKwNPRgQJEMkGJaT0=
X-Gm-Message-State: AOJu0Yxu6GZaDUMp2Bo03KJsDX0eEOiiEKval/C6QdrGSCAKT3JS1MWC
	SnuxKOi57eSah4DzTJXFOTjlaQIUCuPi3qcSqfRsdmLu83Ntw9PU3ZivYwQBqHnJvGVyg6y4foR
	l5DwjYMov9MXOfS85xbNi1MHtt0Y=
X-Google-Smtp-Source: AGHT+IGscmRNCPQPnGzlGQ4cn3OcoVG7q9GXhLRUHvJ7+NtJpAaDf3rsefSkGv35h79b1xfdIsoV/Lo+y6Z8Q5uipyw=
X-Received: by 2002:a17:90a:d811:b0:2c9:887e:46de with SMTP id
 98e67ed59e1d1-2c99c6aeff0mr4370632a91.12.1720269632639; Sat, 06 Jul 2024
 05:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-10-dakr@redhat.com>
 <fa6d6c0a-17eb-4280-baa3-df5f97e58497@proton.me>
In-Reply-To: <fa6d6c0a-17eb-4280-baa3-df5f97e58497@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 6 Jul 2024 14:40:20 +0200
Message-ID: <CANiq72kmppYpNNjP=0eqHx60ixjgoL4oW_ux1HVwM6vrCRFztw@mail.gmail.com>
Subject: Re: [PATCH 09/20] rust: types: implement `Unique<T>`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 12:59=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> The `Unique` from std is special, in the sense that the Rust compiler
> will emit the `noalias` LLVM attribute.
>
> This gives std's `Box` type a possible performance advantage (IIRC Gary
> had a compiler explorer example that showed different instruction
> count).

The example in question: https://godbolt.org/z/n93vePqMj -- there is
one less memory load.

One can also easily craft examples where the compiler e.g. removes an
entire loop: https://godbolt.org/z/c8ncbdKMe

But, of course, it depends on whether we will actually encounter these
situations in real code, as you say. It could also be that today we
don't find any relevant benefit, but there may exist situations later
(perhaps because we have more code, or perhaps because codegen
backends change).

From a quick look, there are still quite a few open issues about the
exact properties of `Box` and `Unique`, including whether `Box` has a
derefencability requirement
(https://github.com/rust-lang/unsafe-code-guidelines/issues/145).

What properties would we want, today, from our `Box` types, if we
could pick any? Should we have several kinds of `Box`es if there is no
unique answer? Is it worth diverging from the standard one(s) in
either direction (i.e. more invariants or less)?

Cheers,
Miguel

