Return-Path: <linux-kernel+bounces-237331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63A091EF54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065381C21F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074784DE9;
	Tue,  2 Jul 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0kG86abl"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F515C5F3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902841; cv=none; b=ApSkcfTZyeFjoTVvBrVXR8zSd1LBEMIqjqNRUqRFmvz5QRsTFioUlJTlCzXJxSznV0d7swSEH+WZmoBaDFow5BJYkbF17aJgEYrsN/md90hN5zrbx161oPvsJWRgSWC5tVxVOCrAV1Gb9QsZsZ1L7YF0gQ6a0MikHxuII2qNRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902841; c=relaxed/simple;
	bh=7AmjA8HOsW3iQB5UhMeCZcUo6g4JrgL8A//vwXj+N/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFkMX+VujcFi4YDjipEsdawz1yx8vXLTriKWFnLSnkEXvEdMrIwmWfUExJozX1j3UwbWlcFNuft0CQS1AeJLuNNrH5VTVgmOe9BsnoZzU6l+/uT1Z404l6fCr2AO2p3CshX3nLnR9MrNwszmxn8WxS/024AcXhqxP7RSrqw3ZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0kG86abl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a72510ebc3fso560234366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719902839; x=1720507639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sWHf/BPCxqcOmPmDzQLfmK1gpdpTOLdypHsiZNysuI=;
        b=0kG86ablrBgX218O8qhKwHmbKuF6RwGpnH6Fr9bQhDHEmNBUPfkm5TCshWuHP/2+1j
         GJz6dggUpIvjzV0yqlZzWUk/uDpl0pMfkef3So4kzI7dBJSqPZKwfo9rKL+nEXLkMlk5
         RbOt7sOaTxC3w47dPnZ4+FzSEjyvwawhQxetGF8rII6ui1TtnadGI4yjAlwgLMVVd5lQ
         qEup8TBRXv2y069PGcmrnjuBGVqY1oFcUrOtptnPjkmEl9jpZggCb9ZYBhpXC6Fo+gFP
         X1IiMjWGv7WbKSnYHZfdvFijzQ6uND7EYVVMPVVca2Wv6NSJH5/u078Ips/VoT8NdOck
         vW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719902839; x=1720507639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sWHf/BPCxqcOmPmDzQLfmK1gpdpTOLdypHsiZNysuI=;
        b=HfOjvXuw0o1swOR7AqrfYYRTt9/jtjP8sb6+jquKoXk6TT32SlwQAtS4hdJaOREFr4
         J+8McltlZN7fnRIZHacA8lC/nF6d57TvLdaaQw6Cm4iJ+LJD5cQ0NwJQCH7NG1jyODeF
         RQkoOd901JTl6wW/jle18RsuTnzN4tBJ8vuP8a/Us68AvLHqw9KYDfMyTnKLhyta7iQ1
         gzqssTXOBjnCaTgLAlamYh9o/1vAGUg4Dh/YSrDqcgn0WUZVKepicNZ0V4xr66U2V8+y
         b+9RqPIQSuJasMd8LojU7vzEJVoBh0iuX66MgCJxhhYTgEXS1WpvMihB7i9qik0E33S1
         vX0A==
X-Forwarded-Encrypted: i=1; AJvYcCU5rFUN9wYqtr2Y4I2g+rkhcbxVYB7c1wNFeCNyJOFX3SYIQuLAClhCSVy+8h4TRp/Hg6HrepSl2+0yb63M1+fcsr3vkj+AKVy8YpCD
X-Gm-Message-State: AOJu0YyFN7CFuPpVzsUJANCaNkw15W18ADogumnpL90U3l1Vm9k0WanS
	anitLxJdP7s6bKSzVaPDLZ75Vxh3yDodThAG9tcJDFgWKBitkcCZQuzINlRkxpaiZyOKDQqhtu7
	IV2nTbeszICq1etLJZKcLchm1z4gg8JrlN3pMjg==
X-Google-Smtp-Source: AGHT+IE7C7ietJ4Y/0+uH2m6mHvh2YOlBatLgbz6q8AofuEHMi7jepOQs6Xhd/J9ZNKB8Vfix6LAyfaQ9R7VRjkSy+0=
X-Received: by 2002:a17:907:980a:b0:a6f:501d:c224 with SMTP id
 a640c23a62f3a-a75144ba407mr634036266b.57.1719902838709; Mon, 01 Jul 2024
 23:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701185132.319995-1-jesse@rivosinc.com> <20240701185132.319995-3-jesse@rivosinc.com>
 <ZoNtrXawP8nvXUds@ghost>
In-Reply-To: <ZoNtrXawP8nvXUds@ghost>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 2 Jul 2024 08:47:07 +0200
Message-ID: <CAHVXubgq8YRTmp5ah2RmfQ6BoPRZDbkrYOuNvGX5yScUcNM7cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] RISC-V: lib: Add pi aliases for string functions
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Wende Tan <twd2.me@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Sami Tolvanen <samitolvanen@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:02=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Mon, Jul 01, 2024 at 02:51:30PM -0400, Jesse Taube wrote:
> > memset, strcmp, and strncmp are all used in the the __pi_ section.
> > add SYM_FUNC_ALIAS for them.
> >
> > When KASAN is enabled in <asm/string.h> __pi___memset is also needed.
> >
> > Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > V2 -> V3:
> >  - New patch
> > ---
> >  arch/riscv/lib/memset.S  | 2 ++
> >  arch/riscv/lib/strcmp.S  | 1 +
> >  arch/riscv/lib/strncmp.S | 1 +
> >  3 files changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> > index 35f358e70bdb..da23b8347e2d 100644
> > --- a/arch/riscv/lib/memset.S
> > +++ b/arch/riscv/lib/memset.S
> > @@ -111,3 +111,5 @@ SYM_FUNC_START(__memset)
> >       ret
> >  SYM_FUNC_END(__memset)
> >  SYM_FUNC_ALIAS_WEAK(memset, __memset)
> > +SYM_FUNC_ALIAS(__pi_memset, __memset)
> > +SYM_FUNC_ALIAS(__pi___memset, __memset)
> > diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> > index 687b2bea5c43..bc73325b2fd1 100644
> > --- a/arch/riscv/lib/strcmp.S
> > +++ b/arch/riscv/lib/strcmp.S
> > @@ -120,3 +120,4 @@ strcmp_zbb:
> >  .option pop
> >  #endif
> >  SYM_FUNC_END(strcmp)
> > +SYM_FUNC_ALIAS(__pi_strcmp, strcmp)
> > diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> > index aba5b3148621..b36325a57f6a 100644
> > --- a/arch/riscv/lib/strncmp.S
> > +++ b/arch/riscv/lib/strncmp.S
> > @@ -136,3 +136,4 @@ strncmp_zbb:
> >  .option pop
> >  #endif
> >  SYM_FUNC_END(strncmp)
> > +SYM_FUNC_ALIAS(__pi_strncmp, strncmp)
> > --
> > 2.45.2
> >
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

