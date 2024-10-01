Return-Path: <linux-kernel+bounces-346387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235998C42B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA98C1F21514
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057F1C9EAA;
	Tue,  1 Oct 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X421+JXo"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7118CC0B;
	Tue,  1 Oct 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802486; cv=none; b=cQDsy7YkinLeycYdZgjMmm1c6ICwI1RHmHB/mBTUB3JaCcjDJjfIBZxpGEVJJ+bccyBBV/EeGmKcEnRUTcYv5Rt/NwE8BlAn+GzuuG8PLdXUHoQCk+r2PWnhrOX3PcwwX/E4juNEzByLMP5t54FPEPhpcHKQUPhPt2pCwtPBFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802486; c=relaxed/simple;
	bh=vwbp+UPz/hdu0MRIIMeSyF1qi+KBmELnI6g4Wa93d9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAobJWCYUyE7nZHntngL8MzHyGPDr/Qdwd2PPl8BY+VJeanroFvzjQiztGR9OuMVWrvnC/nCfYKOSj6yQ2AfjUWp3rCCU8hiPd1yLYY4vLLeAHXeugp4Hlfp5AybwrfKFulODOe75RNu7QquoUkGk0PyeAUaq9BKfTCWtesVJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X421+JXo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71c6ea6d276so97518b3a.3;
        Tue, 01 Oct 2024 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802485; x=1728407285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwbp+UPz/hdu0MRIIMeSyF1qi+KBmELnI6g4Wa93d9Y=;
        b=X421+JXoZqR/yqzoij2AVMYNGnixGVAW2VkbD2TqgMzAKxY/YmN6LEW5siFnDW/Fcx
         z0NnghgDG57rVzuo+OS/C4wwbHPyEbgURlWzSPWmUtq2F6gSxEpBztrUChbrrBuUrzMu
         irybzNZX0otnxUz2ktWnwKLZN56CIVu4T+mXFT7LiNcNwdd66gbZM48CQbRrVp+omAvG
         jiLWiXgXodmODoeDMchPhMjrGzfbrljgvcmfTSZ7KBHFXf25fE3biVtkMQLLdaM7ezFu
         gc0IaMzjKIDhFQaXeCnNaQtTDh4VxQa9RcJgaLRFiXDKhCfbE3PJXLDT7SLO4A1Gc9sc
         nJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802485; x=1728407285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwbp+UPz/hdu0MRIIMeSyF1qi+KBmELnI6g4Wa93d9Y=;
        b=TtH6MYb1Bt8DpQ00BxIN7vRdLUqww0ZW0XfCpYpIom4w0m8r4TCT/hE6gq9oPPbl8G
         ic+P5kbEJHcs3Z9ugWZgZ4HOThdV9q1L2CnUH+A5jBSsSfZdEmPQ6nwFaRvI5EiFjFGE
         bQTEGjhVF46ZI1JVrA7PGlgrvZa5rgj5NoTJXpdEF65ZsySNoAX/wC95Uq8wWkYH5SYo
         7H/FM/b2tUMnKXAQHRN5+oeChrSNLoLalAGY/hK/GVdwmJ+05KEHheoUpgKe3H6Hs7fE
         24Hrw4IB2yZUt2+qAD36pwzgdqAqHNoSbxdfkDx2r9w37qzxiQHmoraVuqRFqRUGS5XO
         6oPw==
X-Forwarded-Encrypted: i=1; AJvYcCUYsJ4I1xoG23L26IO4Z7tUzHK8Agufz1ggmewEKI7dMo9NXup4YYyxNBrKttndu5ENHWLag9Zzo7VCQyJC5Js=@vger.kernel.org, AJvYcCWk1wWZwBodf89iE7dEkbSZKOnV16pMJGsrKSUTcH+0Bm+Hrkh9DzEGNqxBKBP/U1wgVZaiPawC4NMhvTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycGrIL/CK04qSffyUZ1JtnAYdHneB6GPfJfGAhwSx333gUI54K
	EfcS0QK8ndQSfiH+UZFJEgUfgN8U8zkpJvTR3sdUcx+bPik53UTtZRJsxPkpiVKRkmLRYwb5uWJ
	kWUEASSRW87+KEKqw+4k7EZ5hHRw=
X-Google-Smtp-Source: AGHT+IHXiDWrZCIYTtFJIHnFKlVdyYsAIHCO1/HxJUKXpCHOIjUjLzYXJy2WFf/Ckl1G/UBzfmYHkIFgZAMA36G3DXY=
X-Received: by 2002:a05:6a00:2e9f:b0:710:51cd:ed43 with SMTP id
 d2e1a72fcca58-71dc5c49741mr260314b3a.1.1727802484673; Tue, 01 Oct 2024
 10:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-17-ojeda@kernel.org>
 <CAH5fLgg20kDCJfD_6+fTSogOnpqK0x3a6eKaTahgSvdgfFzSEw@mail.gmail.com>
 <CANiq72ktnMSfMfGEhN1kO0F+C5O_KsUY1y_eb7ZL+qzzSkg9bw@mail.gmail.com> <22A86237-4168-4D4A-8782-7A65AFAEC44C@gmail.com>
In-Reply-To: <22A86237-4168-4D4A-8782-7A65AFAEC44C@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 19:07:52 +0200
Message-ID: <CANiq72=MKW-Kt50CsV1DNw3Dj45fXucFzhB0uyNJyNq04_QbfA@mail.gmail.com>
Subject: Re: [PATCH 16/19] Documentation: rust: add coding guidelines on lints
To: comex <comexk@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 12:22=E2=80=AFAM comex <comexk@gmail.com> wrote:
>
> You can always hide the pragmas behind a macro:
>
> https://gcc.godbolt.org/z/WTEaYWW8c
>
> It=E2=80=99s not perfect, because warning names sometimes differ between =
GCC and Clang, among other reasons.

That could be an interesting option for some projects, but yeah, as
you say, I think it is far from ideal. It breaks `clang-format`,
wrapping functions/structs/... would look weird, and generally the
syntax gets on the way of the "normal" code (so even for statements
one would probably want to keep the start and end on their own lines).

Cheers,
Miguel

