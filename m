Return-Path: <linux-kernel+bounces-342797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54AB989313
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F225285930
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51D40862;
	Sun, 29 Sep 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="IZIZtvJt"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0EAD51
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585788; cv=none; b=JoBYaA9jPiGvtuIn2CCTu0KewAAxN2A0yCLBXWPYCFMsbxVVjKKuvfst+nO3EZ+dez7HAMpktyjzP4eiEhdLP5Olo+4u43FRhDV/bT8LopPHfANgF7RV4k2kRxMor3FlME9lo3ccqKwsA7pzvpmpnlqMgaZ7lAg9uVBn3rWnI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585788; c=relaxed/simple;
	bh=YkNxXWjpqjYtCMtoRe3WVpFUJbFDdsQaD/T/kG7nl/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXQfaRzPx9O4ODcr9Y8G0ezP3Gj3ykjlchWqNwV0GyrPk7eTMg4Fh4l8rQVSFUFj5Ni6xUHkrfkmmy2JTtGaiQpjIiECRvGYw850FH/MB1deWRKmi09uS8Kh6r16+iOq7G6S26z/e9ryVxUB8q2jGhQo+HeqU3XPbQPMXPzXJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=IZIZtvJt; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e25d405f238so2666001276.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727585786; x=1728190586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOYsLISsVfhDxhjLXV7hyv9Fxzlka9wAvMifvGXxyVI=;
        b=IZIZtvJt5tdFYez4u3trirCWSR8hZ2I2Dk5YMu/sI4Q6bgxADpye8dbvLlbXBnGJkx
         5pGU/OMCgE29MMKJtisdos7Hd5BhwD6R9AYbW/7ldH7yxB26D5ilmeddBXx8LNoykutl
         tpzigfPioTOaRnWfJzx4d0q921QnmwB8AexENP2ib8GgnrVKr43K10HDqGOU2AgRUFO6
         iQoMBB2eDvYG8ksUlstLCUxilO2k2sQvowtbokGJP6lK44t3oVnjwvwYKarCt+dU7IRr
         u5Ztsw5puNebDfPyFOBBQIJYUpPOhz6bh+XiYF9+R6UMlc8BBaDTyZ6NmA/2kKRRTbFZ
         Irqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727585786; x=1728190586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOYsLISsVfhDxhjLXV7hyv9Fxzlka9wAvMifvGXxyVI=;
        b=C2C+T/DjFn5XrZYwGrJUmRsdVkWwNDfr3g6P4Z4KBhQS17iJGqDF5M1WN0Evq14jSH
         teYhqZmetZM+Y0q6Rqfxr1pPDVdq7U/unVwrsfUnzy2P1Bj2wf8LfJgVev8Lwum+EUPA
         9eqiHQsUMjGU7XHrfLhA2UHoEJuqlYr9iCcktH1MfyosTYYKFtF/NGAHIt66H1K14ni3
         Ib2oOllaKlqkX9/L2kqjzG6Q34NbyRr8P7J2Yby0IXvllpWFi8UgJlibYU/cH5HxrxIB
         /Sd4Y8Tv9PfqA6OQ3X7Z+ZQ+AqBYcooGwAiHTxDXSKYSE9J5zZ1maWZOM4t+OCjmBQu/
         INpw==
X-Forwarded-Encrypted: i=1; AJvYcCXbkAdh0XZiej6jd5LFkmYSNUxPc32GGBkcjgIkwKd1MJUhbB2D8tKTkUHN/WvbhNH5k96v4DKVwroD1o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VzoohKqJZihg+RRwShXVxfLPTiqTEGB/sQSAgcnqM9tLGYIE
	YGnWHnRj/NXQZG6OpyNc59lSjGGSt1Nzv5oez82CQnocI3TyUhle8A/H354ToVM2G65g6wbjRKD
	3fSr01ab9SqARm3q5TvZkn4gcRU17LecyDWvqQw==
X-Google-Smtp-Source: AGHT+IES+mS3dwA7x3mj4/IZRVIw+FMcwmqXUyBn9jFMyuY82OeecDI+pqzm14EDy7gj7TkzRp0qLVGuvnyig5ATprI=
X-Received: by 2002:a05:690c:2b92:b0:6e2:1bba:ed4c with SMTP id
 00721157ae682-6e2475470bdmr36609157b3.17.1727585785734; Sat, 28 Sep 2024
 21:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-15-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-15-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:56:15 -0400
Message-ID: <CALNs47u+vEO5+v7dS3Zm2QbeOQfp9OdNv_y7G5c_AxqxjppFHg@mail.gmail.com>
Subject: Re: [PATCH 14/19] rust: provide proper code documentation titles
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Rust 1.82.0's Clippy is introducing [1][2] a new warn-by-default lint,
> `too_long_first_doc_paragraph` [3], which is intended to catch titles
> of code documentation items that are too long (likely because no title
> was provided and the item documentation starts with a paragraph).
>
> This lint does not currently trigger anywhere, but it does detect a coupl=
e
> cases we had in private cases if checking for private items gets enabled
> (which we will do in the next commit):

I think some words got flipped around, should this say something like
"...a couple private cases we had in case checking..."?

>     error: first doc comment paragraph is too long
>       --> rust/kernel/init/__internal.rs:18:1
>        |
>     18 | / /// This is the module-internal type implementing `PinInit` an=
d `Init`. It is unsafe to create this
>     19 | | /// type, since the closure needs to fulfill the same safety r=
equirement as the
>     20 | | /// `__pinned_init`/`__init` functions.
>        | |_
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/master/index.html#too_long_first_doc_paragraph
>        =3D note: `-D clippy::too-long-first-doc-paragraph` implied by `-D=
 warnings`
>        =3D help: to override `-D warnings` add `#[allow(clippy::too_long_=
first_doc_paragraph)]`
>
>     error: first doc comment paragraph is too long
>      --> rust/kernel/sync/arc/std_vendor.rs:3:1
>       |
>     3 | / //! The contents of this file come from the Rust standard libra=
ry, hosted in
>     4 | | //! the <https://github.com/rust-lang/rust> repository, license=
d under
>     5 | | //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyrig=
ht details,
>     6 | | //! see <https://github.com/rust-lang/rust/blob/master/COPYRIGH=
T>.
>       | |_
>       |
>       =3D help: for further information visit https://rust-lang.github.io=
/rust-clippy/master/index.html#too_long_first_doc_paragraph
>
> Thus clean the two instances we hit and enable the lint.
>
> In addition, since we have a second `std_vendor.rs` file with a similar
> header, do the same there too (even if that one does not trigger the lint=
,
> because it is `doc(hidden)`).
>
> Link: https://github.com/rust-lang/rust/pull/129531 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/12993 [2]
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/too_long=
_first_doc_paragraph [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

