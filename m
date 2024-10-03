Return-Path: <linux-kernel+bounces-349030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B398EFBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32763283483
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E20199934;
	Thu,  3 Oct 2024 12:52:52 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA7194C89
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959971; cv=none; b=jj3NZyAsIwz1U786PxAs3QdlWUktUrC9OEsiTCXIKg0XYpowc6kPhhe+vBr7rWfw+m9IyGt1HOsrOW02qmr9SqnQ6w+96a1KE5CtECnZB3HbwwfEgnj71y0TtSqx47ERS/3xAw1MhN1aeGSSk9FRWceC/K6qsyrNe02DRaHoLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959971; c=relaxed/simple;
	bh=yS6IJU+GBe8K987oWSk1i8+zkeKATsul6ZaK90D/VdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BX9RgDL92DjjTszGj1E3IfH9Kt8KwWCh4IbfevF/+znsgH92e3D5JqhscRcR6KE4/6dal5tQqQUV8rMN9KuBERvJjwEheiCluY0OZ1ajCbZ5upnxzbIHFnWCelaL+Th7+ddmu3rVcNsfTB+MtOf1NXlQz4gQgCzwXGKvTPkApdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e04196b7603so749874276.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727959968; x=1728564768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2iGlYqAVkHqCyJOFhjC1gLFc3ar4xvTgTCzhjzM6yI=;
        b=Qrz79G0Xnykf/dySWz0jAZAJEWOYweyIKeVOPkAlPiirhBJuf8WyL8CQRrvMn6Iond
         VoSmpWfCLLuFuYQhqpxqGXPPzPOuTb1AOrXYjD27xm1WVLo/FNO3NKuzK1u5bZfbFIZ+
         R2w9VUyWOtXavl/8crxjJHZjr/JbR8ubKJ8ZRslzVlvtkBISMlm6hvOfMfKfnVhQspP/
         ft5vUb+XVs4bsIV/qSTdFOYfol22deZ2MO23ZNh+xgjLc+2fumPHUrMJai4X54UvTejW
         B1D3Ld7GpME9P4YLW4wKFKBwqrEMqTGgCLRNjydho+ve1eYas8qEP8zUL8oK/qJEEv+p
         uBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSrY4QkLoHNidgtfXBZcU4vW8JcOZLJHWZYS1XsEMtxrLYwif5cVX268CcZFfduNXoHVGvIPq89K8C+qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KMlZe+AObxjHcKaabe3F5aArZiY0Yf8a3XItiWQivvb2Dj2I
	owsxBULRxMMeIaC4L5+D9maavT0xJuZwSmm32mp74AVRKwj0IMv1Sz6hVVu8J1M=
X-Google-Smtp-Source: AGHT+IG/kcjKhtXKe4WNwN0Elquo+SZCps49TIJpfKRAR4VXhn5wbePsnwolyoXtxPeW+ekC77OLDg==
X-Received: by 2002:a05:690c:6592:b0:6dc:d556:aef7 with SMTP id 00721157ae682-6e2a2e40c14mr51561777b3.41.1727959968633;
        Thu, 03 Oct 2024 05:52:48 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bcf962casm1846977b3.82.2024.10.03.05.52.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:52:48 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e1f48e7c18so6458387b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:52:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTt2fiWDiACxFJ82mfbS6jkuvyNwvbrIdmB3FvjLAJKKsnSXYEElgcOntt24gqh2sIVMrihNxKKSSzyHU=@vger.kernel.org
X-Received: by 2002:a05:690c:3409:b0:6ac:8cfc:1cbc with SMTP id
 00721157ae682-6e2a2e4a10emr34833787b3.45.1727959968166; Thu, 03 Oct 2024
 05:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
 <87zfnmbfu7.fsf@igel.home> <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
 <87iku9r300.fsf@linux-m68k.org> <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
 <87ed4xr22r.fsf@linux-m68k.org> <CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
 <87h69t75do.fsf@igel.home> <CAMuHMdVkw+G6-YjDO_7F6xtgJCBfjKF8T=HuHzQuHbcJK6sp4g@mail.gmail.com>
 <87cykh74bw.fsf@igel.home>
In-Reply-To: <87cykh74bw.fsf@igel.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Oct 2024 14:52:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVN9UyuUMFJUFb9hsKZ8=Uw=L0NEgS-kcoPDGbCk8XJnQ@mail.gmail.com>
Message-ID: <CAMuHMdVN9UyuUMFJUFb9hsKZ8=Uw=L0NEgS-kcoPDGbCk8XJnQ@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Thu, Oct 3, 2024 at 2:34=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
> On Okt 03 2024, Geert Uytterhoeven wrote:
> > On Thu, Oct 3, 2024 at 2:11=E2=80=AFPM Andreas Schwab <schwab@linux-m68=
k.org> wrote:
> >> On Okt 03 2024, Miguel Ojeda wrote:
> >> > Otherwise, does it mean we need a build-time test?
> >>
> >> A simple gcc version test definitely does not suffice.
> >>
> >> The suport for retain also depends on HAVE_INITFINI_ARRAY_SUPPORT, whi=
ch
> >> is usually enabled by default (depends on glibc support, but that is
> >> much older), but can be disabled with --disable-initfini-array.
> >
> > FTR, no --disable-initfini-array seen here:
>
> --disable-initfini-array is the default for cross compilers.

Apparently not for cross compilers targeting riscv64?
I.e. no --enable-initfini-array seen here:

$ riscv64-linux-gnu-gcc-11 -v
Using built-in specs.
COLLECT_GCC=3D/usr/bin/riscv64-linux-gnu-gcc-11
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc-cross/riscv64-linux-gnu/11/lto-wrapper
Target: riscv64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu
11.4.0-1ubuntu1~22.04'
--with-bugurl=3Dfile:///usr/share/doc/gcc-11/README.Bugs
--enable-languages=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2
--prefix=3D/usr --with-gcc-major-version-only --program-suffix=3D-11
--enable-shared --enable-linker-build-id --libexecdir=3D/usr/lib
--without-included-gettext --enable-threads=3Dposix --libdir=3D/usr/lib
--enable-nls --with-sysroot=3D/ --enable-clocale=3Dgnu
--enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes
--with-default-libstdcxx-abi=3Dnew --enable-gnu-unique-object
--disable-libitm --disable-libquadmath --disable-libquadmath-support
--enable-plugin --enable-default-pie --with-system-zlib
--enable-libphobos-checking=3Drelease --without-target-system-zlib
--enable-multiarch --disable-werror --disable-multilib
--with-arch=3Drv64gc --with-abi=3Dlp64d --enable-checking=3Drelease
--build=3Dx86_64-linux-gnu --host=3Dx86_64-linux-gnu
--target=3Driscv64-linux-gnu --program-prefix=3Driscv64-linux-gnu-
--includedir=3D/usr/riscv64-linux-gnu/include
--with-build-config=3Dbootstrap-lto-lean --enable-link-serialization=3D2
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

