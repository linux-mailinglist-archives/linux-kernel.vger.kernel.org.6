Return-Path: <linux-kernel+bounces-359359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD70998BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0032FB2CD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CDA1F12E6;
	Thu, 10 Oct 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqskIF1c"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED721CB324;
	Thu, 10 Oct 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571735; cv=none; b=XLeDCerFDiASXOpeyeqCtB8Gwh7xSxYPWe+Ej8oLNFjV3Vb/mViT2riVB1uXzCOrwodhrcGAKey74zj7jwOFMSiBeuU9ZujFU+AGdm2gkG9PslTP67yUolD73UCoi6CclSp3HemyJE1jeFhYvelpxaud8WqI51zqtNCGSJhPG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571735; c=relaxed/simple;
	bh=MD5Y1JFSub7m+UPd21beBuvfhWy8eN9Icl2C2agrsAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UV+4PJaC+QH4vDL8QTu1soNwChT0MgEHgzTlZl3htXOw3Gt5z1ASk/MtUWmyftvWCp2j7/Tj0EVCnEEtbOBrvJUb8d1TUIIHz3k24JSzpGsfi+lz4/SqUEqqLC1Ohl69Gyy9p5J9hZaSQe2kRtj34OmNJ0rSb+ifIBPVZtSwTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqskIF1c; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71de91427d5so122663b3a.2;
        Thu, 10 Oct 2024 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728571734; x=1729176534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk8mOEtaS0st9RtIbPiyvPicjXJuaraec7PuPjhsQZk=;
        b=CqskIF1cJJ1CGgn4jqDMWhwLFKU/NVR1zjupGPbnSqVkmLtNsJ2ZSmJkuT+Yrc/8Wz
         d+1JzyDhybWhv+MXZEcYdzVXWLmgZ7EeLUeDfhnyNhQgUWy7MeD0lRjiL84bAwUR2jEh
         H9nnpbVsAXJDTa+BQ2XiZjc7dI8bR3bOADPArXICNgHMDbRJ3yl09g+O2UnJic/e4IBk
         7Ito5XyL0vNvd7FM8G9v7ClpYCHw77hjRgBecSebCC7qeMzFnblRPYCWByR61CcfzNQh
         5iyxWZ9g1n/kgNDPruobWXyfkKg/Ac1dG+GS4TzIJ/+BwumYt0B0RTS5FRkWpunfo+yV
         x+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728571734; x=1729176534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk8mOEtaS0st9RtIbPiyvPicjXJuaraec7PuPjhsQZk=;
        b=tfLFWBNjLFXnkzW1Yi6RO5F6+C+740Vpj7v4512+cNfYhQtT5h+fkP9kNp8Gby2JM8
         bOTWGYDj/hJMXmpmGotpH0tKgpkD7ndxGjmRuipzba+0P0bo7A3P6hsxI5GxvqqdPJRA
         ihBEs4/8ZxKUgIWEmqEIVeMhDkiwFovqmZKpS5e+yQNnf+UUMpP/UeTIrQyXQr8Yd8Y6
         chIe4pZZhOas7c2buyQQq3Zx6IfirGpUWEPchO4pcowyBaiuEaPuteaIB9xwbFuKpKcr
         QzB3RmIwZXqa77U66aUd44U8iIHva/xxfNsaDGabHH1p4CCkTDJbl5WAHzVSGsoC1aQw
         gSoA==
X-Forwarded-Encrypted: i=1; AJvYcCW3IxTs0uF7IuKpcXdaSsj7KEiUZmt8mrgbbLFOvgLT2pt6oEhSdda40uNLiLywRFy+S8hYP/JcI0MmAZYdIn8=@vger.kernel.org, AJvYcCXfQbr3CF/gWLtv8wOzrbdjLm4xySDhyyfpDL/KEmLMDHsith0J61XKnE3p+R5bdOs+ZiPBn4/HHQwsq14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIbygOvl5N0Fbs62SuEbJAqHpneHT4kRlteoqdZi+OYOWz/hN
	Wh5PvME82zWE2iaYTmbRoGuD5MhnBTOvW+CkFnLfJNlu2MUXSjoPk3TaNuhf5jPXK8lBZjIcHAs
	ZIQUER1vk6RyYlI4UabLtToQ4z4Y=
X-Google-Smtp-Source: AGHT+IEljzpMu1ACQ6sQRA8RzgwL3HdCJr8K4MQxtTnAtECkzV3J/8bQwyLAxm6Zuns2qv11cRQg+5TXDKwx0rMQsBI=
X-Received: by 2002:a05:6a21:3397:b0:1cf:2be2:5e5b with SMTP id
 adf61e73a8af0-1d8a3c59cb2mr3823983637.11.1728571733800; Thu, 10 Oct 2024
 07:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3> <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3> <20241010110344.GL14587@noisy.programming.kicks-ass.net>
 <20241010113748.GL33184@noisy.programming.kicks-ass.net> <CANiq72=kT9RFcQ3h5U+wAY0pDQQqGU7BTtiPJ-oiHNUG00z3=w@mail.gmail.com>
 <20241010130421.GG17263@noisy.programming.kicks-ass.net>
In-Reply-To: <20241010130421.GG17263@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Oct 2024 16:48:41 +0200
Message-ID: <CANiq72kbApTtdLeow5L6G6t4Q_L-0zkDwfwyWcSb_e6P=kO06g@mail.gmail.com>
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matthew Maurer <mmaurer@google.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:04=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Also not rust-src, because for some reason you're not actually
> freestanding :/

It is there, but it is a suggested package, so I think you would need
e.g. `--install-suggests`:

    https://packages.debian.org/trixie/rust-all

Regarding freestanding, we use `no_std`, which one could argue is
similar to C's freestanding. That is, we use `core`, which is a subset
of the full (hosted) standard library, just like C requires some
headers even in freestanding.

However, I think you mean not even using those
headers/sources/libraries, which is fair. Rust calls that `no_core`,
but it is currently impractical to use/maintain and there are a lot of
useful things in `core` we want to use anyway, such as the `Result`
type:

    https://doc.rust-lang.org/core/

There are some things that we could remove, though, which is why I
asked long ago for ways to remove unneeded things for the kernel
("modularization of `core`"). We got `no_fp_fmt_parse`, implemented by
Gary back in 2021, and we could perhaps get more in the future if
really needed.

> Yeah, but then you have to first know that we have this file to begin
> with.

That is fair, but hard to fix. We try our best though: the "Rust"
entry is in the front page of the kernel docs already, and the first
paragraph of that page links to the "Quick Start" guide.

Cheers,
Miguel

