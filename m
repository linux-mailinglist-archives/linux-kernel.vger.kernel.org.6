Return-Path: <linux-kernel+bounces-539492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5385A4A50A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2503617298F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEFD1D14FF;
	Fri, 28 Feb 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW8T6qVr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4723F36E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778166; cv=none; b=WqiCZtVQPyz1btFSs+XHNFXtzW+v+VVnxSr7LrWc7AMegIIV/cPsyJQZDtGYERKxu01Dc9h/m8UNaR5aZRo3nYngdokEhqpy3kYeeKCkEhoWOZ3371kjZFvPHns9h4etzKjy5tfgqaaiEAydGzwSqQz/bNp40gQZT+TXYZtcVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778166; c=relaxed/simple;
	bh=kJMrEkhqRpc6VjDVs3fPZ28tdnuiN4UBff7uK9dxTl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgYqfNZDFIJL3efavNAle74Lo1xRiVMqB+9SpY273wx5a15hgJfXzoVJSUHQo9XGjT2h6pLWzpYTeP3wSacVbWxIfekhIevw7KK2z2WiARkHMGd1fnzBSwvlG25ynAtzQsSTHfBwQRSmcsbTh9NrULT/oeYmijDZg2SVdUBk9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LW8T6qVr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso400081766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740778163; x=1741382963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqzqyLpyoLT4MnMSiO5M/cbMqW2N1A2UktCSpw8Wecc=;
        b=LW8T6qVrn32s0lCon3/6zxOgPzHezH2SgpgRmnf9jKP1LhQ/QX6m9CaO1tPGYogrqq
         4sFkyEzqzC4jDo53TOIYHYdviHz4uNRrSbNaqa0EDyWDX3bq8Ggy8uI3MXz3H/9TAmjP
         qEVuykQed4WTuu+i1jJYO3DSKsZKVaq4zMZqZXSAswD7czkREyfWrTerYCdtFM9KHgV3
         sbkcMU6bzhI4xq1wV3fjv7TMby9Ie/hPVmiXyK/ZzMX72T6jsMQTWg5ZL9HiLUXdGPs8
         0QrqGPUJxZbx6w0UopmAdyWNszUkw/FgzuwKZkC55ZKYgn4uQUnPgQxcv/24msAbYAqS
         JmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740778163; x=1741382963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqzqyLpyoLT4MnMSiO5M/cbMqW2N1A2UktCSpw8Wecc=;
        b=WPpDKL6mEZVm5+KXZ8KpVlvbtDiA0fqgc50TlELVJgIW1OcggyOIraLJKq1zeMrd1R
         wtzHtV6S42rtu8oUiG4z3ljUUAPwcn1aiJ/nLvSrI3xLGKwXlEwy65NSDqSZJeqSQ81J
         yesMFmHd0Q6Pb/g466ZuigPESJgd99YW4gTR9l0DCwlUVR0MydErnBUbENY1GRpAG1rB
         CMtRVaZfAry8V86ZPSLi2yqDOoM/Kk2CGEebW9nudK66n+41+famh0zRaFcNfgITnRcp
         6EeKwLytp4GiMAF6EmVNnwr1U4vL85OoxfaUjNsVh1FDCLWohpmg04VJ6H23HTEDtgYk
         JrXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX38eLvcfXOemCG1W75SAd13Xj58vpwyc5XFzv62ttz3DiNOTJ40qm1CI/jGVCKtH160+B4L39wAdkbi10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJmViYU8BUa22LfF1F68FT0n32IheTrBdVqN7e6QwUUdtuNTZ
	CGI5+AkO+QMlySKEIoiifE7mW/rovGj6jQoZVIzGnn0GTGZnlvU1Bw16QaLJ1F51J7yWLKaPmOG
	5UvMOqcWFKT+lwPjelmLb+YPFXBhoDesg4Bo=
X-Gm-Gg: ASbGncsAJJAOE2lAbqmnXhVUtXBoiJ7gIe9v14cA3Bsc5GPJk1eLzJy5kM+kFcdLtlJ
	2SjJ83mMXgJEbHO3QvsUTSAkrRlU8Sv1AKkcQn+iAPO3smfnrMqFVqgCCDLCZT3LvPFZ6xoesY3
	cZkAm+
X-Google-Smtp-Source: AGHT+IHelEGE+Ufz9+A2TmH66Wlq+3MH2jgktN1tokY0omf7FSH344duWOuLActep5LEcffLSDmvVh9lPxUEywsplNI=
X-Received: by 2002:a17:906:3097:b0:abf:489b:5c77 with SMTP id
 a640c23a62f3a-abf489b5ea3mr139416866b.31.1740778162964; Fri, 28 Feb 2025
 13:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGG=3QVi27WRYVxmsk9+HLpJw9ZJrpfLjU8G4exuXm-vUA-KqQ@mail.gmail.com>
 <CAGG=3QVkd9Vb9a=pQ=KwhKzGJXaS+6Mk5K+JtBqamj15MzT9mQ@mail.gmail.com> <20250228212048.GA2812743@google.com>
In-Reply-To: <20250228212048.GA2812743@google.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 28 Feb 2025 13:29:06 -0800
X-Gm-Features: AQ5f1JrI9-xg8yMWBknx8JPMjZcjjoD-wwtXnx_7ejGcNBpiyVaHSJIt4DfOzmM
Message-ID: <CAGG=3QXR8WNZhYTRT_cF76P+NkRNiK7Wd+8rpVc=2JVNrhXZEw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/crc32: use builtins to improve code generation
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-crypto@vger.kernel.org, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:20=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Thu, Feb 27, 2025 at 03:47:03PM -0800, Bill Wendling wrote:
> > For both gcc and clang, crc32 builtins generate better code than the
> > inline asm. GCC improves, removing unneeded "mov" instructions. Clang
> > does the same and unrolls the loops. GCC has no changes on i386, but
> > Clang's code generation is vastly improved, due to Clang's "rm"
> > constraint issue.
> >
> > The number of cycles improved by ~0.1% for GCC and ~1% for Clang, which
> > is expected because of the "rm" issue. However, Clang's performance is
> > better than GCC's by ~1.5%, most likely due to loop unrolling.
>
> Also note that the patch
> https://lore.kernel.org/r/20250210210741.471725-1-ebiggers@kernel.org/ (w=
hich is
> already enqueued in the crc tree for 6.15) changes "rm" to "r" when the c=
ompiler
> is clang, to improve clang's code generation.  The numbers you quote are =
against
> the original version, right?
>
Yeah, they were against top-of-tree.

-bw

