Return-Path: <linux-kernel+bounces-568812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329A3A69AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42286189C12A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AB214A94;
	Wed, 19 Mar 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOizcdl0"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C6801;
	Wed, 19 Mar 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418833; cv=none; b=VOV59uquFa+7JAC8L5sQYYfcMubGDitJjgIIylOb4lWU+ml3n3K9elvtfISprE2OPVcRRM+tVgc6+Ry+sHmUnH90P90qkaTYcesr37ltfiSm2uUrf06+OExXJJD6GyQhAXhhPkBh27OP4GRlZr7TYgpOnvJZiVvGuZ2SQ0kCnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418833; c=relaxed/simple;
	bh=u22YrI3wDIN67H8Rc1sY/RyRCBmr/rxXDx1R10cNsb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEO2cOnlHhkd4dIFw+yivhYl0dYLohBZ9tSTfDjLg5KPUVvvdHo8KzA+hMAll6YHVGSpnQ0V1sLSGSextyP8UKOJ2/mS+ZhdBQpcTlTjcwDnEK038c90R4OA7WUGAlN6l8xJlcbFk1X1HXaBreisQwhbBGpBE5SRfvTR7dwH3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOizcdl0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bee278c2aso13668951fa.0;
        Wed, 19 Mar 2025 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742418830; x=1743023630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwre+p1Cuz7MakhAwW9QXu4qCw/Dvm9xIblX0IITzkI=;
        b=bOizcdl0cDKkX7Kc6+Dyv7RgLoqQU9mwUt6F2YcOu0jHUFft7t5XrINFGcmUA1EEwK
         IArA+QjboaB1vlTJroF4biF7bXD47xmaE7iGqftLehaQ5QD+xnxjVprJZTWWvZUOPC7m
         ypWPkg4IHQBHUw14cp+7wQcQsLNTgoNNa0H7TD3p2NKlr6+sKVCEx2NEp17fQyYmqVrT
         iO4hho3pQaDh4ksgOE5LEKJE7rOSw4kXk/Sb5W9rCQtafRQPI5enaMLpo1fBJ1cUO9oa
         0r/jtFonuz9rMYLHNfCNndVlePhVQRrHnju6xsqjhiDXfKFpviA2TGkQcy6RcWf2KdQL
         x8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418830; x=1743023630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwre+p1Cuz7MakhAwW9QXu4qCw/Dvm9xIblX0IITzkI=;
        b=tjzN3OI+2gVZrH0b4M4xWNRU6LmFT6+FAvvQ/RvcwzodjqdIX6zzm1QRQ/Eq2MsjIP
         mBeiRTdpF3YxCbBhKbTd6IX4JTfUeENk6pMJ53RDBcpnkA48tEscwyWd+XJUlREcZu6J
         1DZ/fSNLRkH9Qk0LVe090Qtqw8chNkpB2ddrkupIad20+MyoAwKevPMBb86SLDFsHwE1
         Vfnu4Y8c9zNhL67L3S/8d+n+8+wb/WH5XlknaWXNqiub+9j3eG2KhEn8JPcv9rVAOM9I
         SqMMQJ+l7wf/VoWTXVzNph7xcpelrDx65sSSGIg0tx9KNzFlv+opFXH3Pq/6yRMYQnda
         opDA==
X-Forwarded-Encrypted: i=1; AJvYcCVERC86UBHuTo4cMkekRlUV65K6cMfT2ZFn8RflvNakaeh+J5kIbjuj12f+xZ3ugP/QkC5hw5YE0D6QTmU=@vger.kernel.org, AJvYcCXi/Pzx2tJuWwdR1rJe4wkq7uwQymzFCIxED8K2rFB2il07BmGR43y90ALKtvrxxjqhCaePuOr+t6Kjr3lWTdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvLePvyrd6eNB1CPBx7Yk8dNgia3tkc2AmhAhP8/Z5xTTfRub
	d5NNN3egMvdra42YAi7FjPa6BwMO++phHt2NoEJX1L4ZGKGhWb7uj37SumHMQVi8LKvDdaX1G/c
	cmXV/lW9yCFjm9j0fbwqTDscv3sg=
X-Gm-Gg: ASbGncsfbCFtnedWjWNSbx15Dyp7xuFO6LXbQETHA+xhN2ni10s6/jvSSzSHDndyBki
	dKUMqfnwjwUHSgEPw3+wvJIR9aeu6SrXipJFQHDhnZaEY0jqfP/9hiV6/kiG/vco432jMKDCAyE
	DJFMKTGwp23RSqATIpw4s0eW7r2npuW3DAH5DOeUDNCg==
X-Google-Smtp-Source: AGHT+IEIpHhcTfgCnXntBU5dI1dSLip4dqnBCw4wFxOsxAIS0T1WCzaUvi+xRNri6ZHovmrbeT/y26fI2YnAMji3BKI=
X-Received: by 2002:a2e:890d:0:b0:30b:c9cb:47eb with SMTP id
 38308e7fff4ca-30d727a8910mr2737671fa.13.1742418829905; Wed, 19 Mar 2025
 14:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319205141.3528424-1-gary@garyguo.net> <20250319205141.3528424-2-gary@garyguo.net>
In-Reply-To: <20250319205141.3528424-2-gary@garyguo.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 17:13:13 -0400
X-Gm-Features: AQ5f1JodwFL8t8zD_cENaeprUkF6zEI3cefWQGRoAC8X8IN1resnADU3ZvX9Fvw
Message-ID: <CAJ-ks9kCTZZ-kq+VL3-4hxxz-q07vc4k6A6L9c6b6UYc5b5f3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kbuild: rust: add `CONFIG_RUSTC_CLANG_LLVM_COMPATIBLE`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yoann Congal <yoann.congal@smile.fr>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Chen Ridong <chenridong@huawei.com>, Jann Horn <jannh@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 4:57=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This config detects if Rust and Clang have matching LLVM major version.
> All IR or bitcode operations (e.g. LTO) rely on LLVM major version to be
> matching, otherwise it may generate errors, or worse, miscompile silently
> due to change of IR semantics.
>
> It's usually suggested to use the exact same LLVM version, but this can
> be difficult to guarantee. Rust's suggestion [1] is also major-version on=
ly,
> so I think this check is sufficient for the kernel.
>
> Link: https://doc.rust-lang.org/rustc/linker-plugin-lto.html [1]
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  init/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..e76e4ad7d4b9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -82,6 +82,21 @@ config RUSTC_LLVM_VERSION
>         int
>         default $(rustc-llvm-version)
>
> +config RUSTC_LLVM_MAJOR_VERSION
> +       int
> +       default $(shell,expr $(rustc-llvm-version) / 10000)
> +
> +config RUSTC_CLANG_LLVM_COMPATIBLE
> +       bool
> +       default y if CC_IS_CLANG && RUSTC_LLVM_MAJOR_VERSION =3D $(shell,=
expr $(cc-version) / 10000)
> +       help
> +         This indicates whether Rust and Clang use LLVM of the same majo=
r
> +         version.
> +
> +         Operations involving handling LLVM IR or bitcode (e.g. cross-la=
nguage
> +         LTO) requires the same LLVM major version to work properly. For=
 best

s/requires/require/

> +         compatibility it is recommended that the exact same LLVM is use=
d.

nit: s/LLVM/LLVM version/ unless you literally mean the same dylib.

> +
>  config CC_CAN_LINK
>         bool
>         default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG=
_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
> --
> 2.47.2
>
>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

