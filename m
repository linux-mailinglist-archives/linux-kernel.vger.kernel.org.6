Return-Path: <linux-kernel+bounces-399753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96A9C03C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E431F21E43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491D1F5820;
	Thu,  7 Nov 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4tnokIW"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7851F1303
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978458; cv=none; b=NjbVu1pKFdAdYCgEJvMGREfNatwO28fwxwNVdciYUjRiuEgpMNh7RYx1hWRgQTcYaoX5381NUUogLwC+deuqRu8N3H96dZ2ip9mD35x4/CCU5AOVUtgAQljj7rkLkSnsIaFB0OFxX0hkSFKcRtYOmzsW+knmtMCp9kgDJyMxvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978458; c=relaxed/simple;
	bh=92JvbYXS43ziuksMmLoy3p90KRD5zpG7v6wF1/+S9Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvn/+jDahe1At2MT1BwThGGI5PtFWOK6PxqAI4/9qjQUbhQvByrna5oyK+sjePTozeL0h0308wTZHjpXLizA4QzPfBSGBPGEUBz80BrOmWrBcgM12d6hHCZ63RPqnPdyPqFgHu6hk17DTy7XHdEbnc5+cWNZQ/kSeanqMsRVUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4tnokIW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso7821941fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730978455; x=1731583255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMQuG+gv/bCMQPE5TTdrdRCToXNDQpmIiwozDBgG3Mk=;
        b=Z4tnokIWh8kzKKOjRd40F2qWtlpPLQcV3ENx+S6lrwEQlUNmsKNWfCdjyOe/BMccOm
         +3UjZ6sdA4zyc75cqml0w619J2kPo+DE30v1yvAAcQ/e8tU8oSXbvm+F1Sb/L15cMTir
         frtvIm8WXlGFHUi4xNdYW6yyOop8xs+AfAWZ8k/uq1jB8+onE/2y7M8gG0WWcrehiuno
         WRI/TJyl4mS5hiw4wFNBmHbMjKNhAdsl+hC1881wINVBYUXX1MwYZ0HwuQcXb6r5Jb4l
         RT2HaeTTd9JeGsSYEj0LcUcow8qx8oaO88HmQCXvnGLwjecXHpTPZd9/D4HcKE4ltUNG
         CpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978455; x=1731583255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMQuG+gv/bCMQPE5TTdrdRCToXNDQpmIiwozDBgG3Mk=;
        b=X+ZDVS4vRp59DS+YIlGLxsGrQEhgM72/k/5R/48uEtitGyfhdotgengc9qiU/cU0aa
         ShGI4Bx5aGVo+U4ikydBMvATHfCUu7w9E+lRi7DdRdEIfD/RNWj49EsBxN7pt54Si/HL
         Hc4ouN5l3i2seIsFlNkCs4x1Zl3zs1aCTGZ/rPgMAvjegH7LJyF3yYlfe1dM4lHu3Ew2
         POYQ2VvauSKpjkB4E5j1UrWX82E/78KAKut83203L068AC2XD3PcyxQpdS54kpdofbJJ
         CBb2yTnBN+KMpx2qZ6b0oX5ijfe3z69wMN9YljRXlVBI2SxC8dY3vhF6khCwgQh/HC//
         KDvQ==
X-Gm-Message-State: AOJu0YzhuasdEDpjPxR9ycuRWq2N3YTyLl+fS/BRXU25cmFnBvTmKKLJ
	4J0ulB9d5lHQUvZgF1KwJN0z+S4SwnGbFtGI34yjphx7dgi5FrTAnCL4OiWR3GpRgsam7jSzTo1
	4EQDaSHX1j5xMhz05+2gybQH9DZfsuM3MJEw=
X-Google-Smtp-Source: AGHT+IFRUwAYPMwNcogpWfAJRdM7aiS/DsPiSrIa91as6QTUqdQTwFy0U6vv9Sp5y+ka7BcLe31/aaDmxYYX6L5YGMg=
X-Received: by 2002:a2e:a586:0:b0:2fb:5ebe:ed40 with SMTP id
 38308e7fff4ca-2fedb781c43mr121935651fa.15.1730978454632; Thu, 07 Nov 2024
 03:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-7-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-7-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 12:20:43 +0100
Message-ID: <CAFULd4b9RqWD5uaZEzejQfzJ4cH85sCgbTaHJdg-qJ-OaLJiWA@mail.gmail.com>
Subject: Re: [PATCH v5 06/16] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
> stack protector location.  Treat them as another type of PC-relative
> relocation.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/tools/relocs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 6afe2e5e9102..7d7fc7f0a250 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -32,6 +32,11 @@ static struct relocs         relocs32;
>  static struct relocs           relocs32neg;
>  static struct relocs           relocs64;
>  # define FMT PRIu64
> +
> +#ifndef R_X86_64_REX_GOTPCRELX
> +#define R_X86_64_REX_GOTPCRELX 42
> +#endif

The next patch (7/16) introduces the above definition to
arch/x86/include/asm/elf.h. If you swap patches 6 and 7 in the series,
you won't have to introduce the above conditional definition.

Uros.

> +
>  #else
>  # define FMT PRIu32
>  #endif
> @@ -226,6 +231,7 @@ static const char *rel_type(unsigned type)
>                 REL_TYPE(R_X86_64_PC16),
>                 REL_TYPE(R_X86_64_8),
>                 REL_TYPE(R_X86_64_PC8),
> +               REL_TYPE(R_X86_64_REX_GOTPCRELX),
>  #else
>                 REL_TYPE(R_386_NONE),
>                 REL_TYPE(R_386_32),
> @@ -860,6 +866,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *r=
el, ElfW(Sym) *sym,
>
>         case R_X86_64_PC32:
>         case R_X86_64_PLT32:
> +       case R_X86_64_REX_GOTPCRELX:
>                 /*
>                  * PC relative relocations don't need to be adjusted unle=
ss
>                  * referencing a percpu symbol.
> --
> 2.47.0
>

