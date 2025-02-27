Return-Path: <linux-kernel+bounces-537299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938AA48A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2567A165CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DC270ECF;
	Thu, 27 Feb 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GN6JtJsd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5626E948
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689785; cv=none; b=WLas8y+bzjB5VA7FGRxOZ1qD9QRtpVUnxjKsTiMa1ZQ6xZeImU9ZOOexOX8Av0Fb35/Sly9wBwqS9dIT9aQaFhOUgr9cnO+VqswhcKC9cMP+qTsJIpqEad6g4tHeGtxDk326DNMnO4sSiYd+PUg/Wz6xsXGxBHrT5yXTyosh5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689785; c=relaxed/simple;
	bh=jBzl2J3X4B4GartkmlPP24UWJcRsK01w6K+luSD1Gj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTva+ATuL7KtblmJjaAh5P0xlWN2bQtXiuIZ+qPIKmZVHIqjQwjFU7egJF5/GCPN9wp4SEisnZZ4Y6izvg1rY9/Avh7y3aqGBavx71WTBOBtHIISOIb16grTvk5FYpqyl7juowgUnKlPAk1j0AlbsnAo/AeK2ZDBF3QsjgqGPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GN6JtJsd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf178f4cf1so127699966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740689782; x=1741294582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNfLsJ5M5Y46Pe7a1sd55cuuZyArFmPaDQMk3VExmOc=;
        b=GN6JtJsd7bebkrKT2R1y8iMdYQhlc3mQ1NH6dM+dCbLq0WQ2n9j2osE9FO3S7G1A26
         g3iJYZ3Sl7pkEersURBid7Aj+4YdKl1ejfanlYrVb3LyWhlbA6me5kTbUAdI6ZnrnPX5
         iPWLbMG6+de9QkG8uItE1hiu7jQaRmxrhWEM2eIBNTFOjXMJTLOqDY7YI5MvZioN1eQ8
         VaaZj4ZkRN+Bd/+ESTVp2r7fpPAWmJf0VvH5y1TBG8Gg+qRuac3enz3LmPyZZ7YRqA+H
         6M5g44eNYtJr7xrFZg84l1OnWSVBz7ywuhYAAf/E56YVyEAUyIFHp8rtM0TtkRTLYR2R
         aKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740689782; x=1741294582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNfLsJ5M5Y46Pe7a1sd55cuuZyArFmPaDQMk3VExmOc=;
        b=sbjK6fnGkPmZd3YQ/P3k+EVyguGWSsEa7RjUMoGfNvT9qpT807YU7mMXVKGB51hTFI
         dHfHmUtHnv3Lyz2jerh81dhAGCjw9nPBy3qc1OPEq3HsKftuPTPCER78t/kE4Lui9/P0
         lJZWz0l2lwCmTeS0goAel54vQHVAYUG6WuT0PCiC/o1qiYr8NjOH3WObHYDl4SkLlmIE
         bo6CNQKz0ETQBmxmW0XYCCH3xNNqU2I2L5uwnAYz1hDfOVh/xZ1Ea8PZsOToKSCnQAFI
         MWIoiIbfStZanp4gLBKPT517o2Pk0JNNOuPuMegrqR6yWpeqEWss+cz6TN6U4e8Cxx/z
         q4kg==
X-Forwarded-Encrypted: i=1; AJvYcCU9RBEt9crcZOGlP1weEdJWCh3ej793xBtFVArlojkqhosDBdVyuCLoCiGAMn1Cyr2o3+z0T6me2ykVX2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzXttZjGcfLKUBM3DUM0DDBB8nmuHWWa/Li+A9nqrsPPYD/Ha
	kmTkPg8hACRvRYMDX0Y19cdvkRw1bbZLvkuDKalFu6IVnTXaZJPKN11+ZHeEM8A4S17rv8R6wYD
	JbAXE9wHKl6FKCI9B01iwTkZ+MHT73uMyDkE=
X-Gm-Gg: ASbGnct39wg9ilUACWGPYJCW7+1bwoqV2S0ncQVSHiALX4SlE3bCdYn96RJkRtK2r7z
	mBSJiYrfzl+g0CWuKSQDMqtZQvrslvB+TDH8vjnYXg+h8qtcDx+xgoqFKjHty9TtGYQSfFrkNzv
	mPaqWo
X-Google-Smtp-Source: AGHT+IHk5c57x/1P/u8YmnoLziTvu7e5VlZk0I6I5E3FRkSAuORsqywFgx8cMDueTEhgLiA7uQm4XpQbmgxjR0DQ3f4=
X-Received: by 2002:a17:906:d542:b0:abb:e7b0:5442 with SMTP id
 a640c23a62f3a-abf2656040dmr96674466b.26.1740689781707; Thu, 27 Feb 2025
 12:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGG=3QVi27WRYVxmsk9+HLpJw9ZJrpfLjU8G4exuXm-vUA-KqQ@mail.gmail.com>
 <20250227062859.GA2506@sol.localdomain> <68F134A3-5371-4E74-9942-2BC66984C18A@zytor.com>
 <CAGG=3QX2WX5U-uNp3VWSbQCN9fPVAirOBn5KcaWn8m-87RhWfg@mail.gmail.com>
In-Reply-To: <CAGG=3QX2WX5U-uNp3VWSbQCN9fPVAirOBn5KcaWn8m-87RhWfg@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Thu, 27 Feb 2025 12:56:05 -0800
X-Gm-Features: AQ5f1JoI25GyQvAEVKfSMmNTlt_ej9Rh4DM5IVbp89PFTHlpQT8k9zCeJA-W2l4
Message-ID: <CAGG=3QW4jo9RKtVxD2b3ZBjPhnAUYeUf_GPVh13e7gZkLFtuUQ@mail.gmail.com>
Subject: Re: [PATCH] x86/crc32: use builtins to improve code generation
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:17=E2=80=AFAM Bill Wendling <morbo@google.com> wr=
ote:
> On Thu, Feb 27, 2025 at 2:53=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wr=
ote:
> > On February 26, 2025 10:28:59 PM PST, Eric Biggers <ebiggers@kernel.org=
> wrote:
> > >On Wed, Feb 26, 2025 at 10:12:47PM -0800, Bill Wendling wrote:
> > >> For both gcc and clang, crc32 builtins generate better code than the
> > >> inline asm. GCC improves, removing unneeded "mov" instructions. Clan=
g
> > >> does the same and unrolls the loops. GCC has no changes on i386, but
> > >> Clang's code generation is vastly improved, due to Clang's "rm"
> > >> constraint issue.
> > >>
> > >> The number of cycles improved by ~0.1% for GCC and ~1% for Clang, wh=
ich
> > >> is expected because of the "rm" issue. However, Clang's performance =
is
> > >> better than GCC's by ~1.5%, most likely due to loop unrolling.
> > >>
> > >> Link: https://github.com/llvm/llvm-project/issues/20571#issuecomment=
-2649330009
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Ingo Molnar <mingo@redhat.com>
> > >> Cc: Borislav Petkov <bp@alien8.de>
> > >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > >> Cc: x86@kernel.org
> > >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> > >> Cc: Eric Biggers <ebiggers@kernel.org>
> > >> Cc: Ard Biesheuvel <ardb@kernel.org>
> > >> Cc: Nathan Chancellor <nathan@kernel.org>
> > >> Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> > >> Cc: Justin Stitt <justinstitt@google.com>
> > >> Cc: linux-kernel@vger.kernel.org
> > >> Cc: linux-crypto@vger.kernel.org
> > >> Cc: llvm@lists.linux.dev
> > >> Signed-off-by: Bill Wendling <morbo@google.com>
> > >> ---
> > >>  arch/x86/Makefile         | 3 +++
> > >>  arch/x86/lib/crc32-glue.c | 8 ++++----
> > >>  2 files changed, 7 insertions(+), 4 deletions(-)
> > >
> > >Thanks!  A couple concerns, though:
> > >
> > >> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > >> index 5b773b34768d..241436da1473 100644
> > >> --- a/arch/x86/Makefile
> > >> +++ b/arch/x86/Makefile
> > >> @@ -114,6 +114,9 @@ else
> > >>  KBUILD_CFLAGS +=3D $(call cc-option,-fcf-protection=3Dnone)
> > >>  endif
> > >>
> > >> +# Enables the use of CRC32 builtins.
> > >> +KBUILD_CFLAGS +=3D -mcrc32
> > >
> > >Doesn't this technically allow the compiler to insert CRC32 instructio=
ns
> > >anywhere in arch/x86/ without the needed runtime CPU feature check?  N=
ormally
> > >when using intrinsics it's necessary to limit the scope of the feature
> > >enablement to match the runtime CPU feature check that is done, e.g. b=
y using
> > >the target function attribute.
> > >
> > >> diff --git a/arch/x86/lib/crc32-glue.c b/arch/x86/lib/crc32-glue.c
> > >> index 2dd18a886ded..fdb94bff25f4 100644
> > >> --- a/arch/x86/lib/crc32-glue.c
> > >> +++ b/arch/x86/lib/crc32-glue.c
> > >> @@ -48,9 +48,9 @@ u32 crc32_le_arch(u32 crc, const u8 *p, size_t len=
)
> > >>  EXPORT_SYMBOL(crc32_le_arch);
> > >>
> > >>  #ifdef CONFIG_X86_64
> > >> -#define CRC32_INST "crc32q %1, %q0"
> > >> +#define CRC32_INST __builtin_ia32_crc32di
> > >>  #else
> > >> -#define CRC32_INST "crc32l %1, %0"
> > >> +#define CRC32_INST __builtin_ia32_crc32si
> > >>  #endif
> > >
> > >Do both gcc and clang consider these builtins to be a stable API, or d=
o they
> > >only guarantee the stability of _mm_crc32_*() from immintrin.h?  At le=
ast for
> > >the rest of the SSE and AVX stuff, I thought that only the immintrin.h=
 functions
> > >are actually considered stable.
> > >
> > >- Eric
> >
> > There is that... also are there compiler versions that we support that =
do not have -mcrc32 support?
> >
> Checking GCC 5.1.0 and Clang 13.0.1, it seems that both support '-mcrc32'=
.
>
I just checked and GCC 5.1.0 doesn't appear to be able to compile the
kernel anymore, at least not with "defconfig". It doesn't have
retpoline support for one and then can't compile lib/zstd:

lib/zstd/decompress/zstd_decompress_block.c: In function
=E2=80=98ZSTD_decompressSequences_default=E2=80=99:
lib/zstd/decompress/zstd_decompress_block.c:1539:1: error: inlining
failed in call to always_inline =E2=80=98ZSTD_decompressSequences_body=E2=
=80=99:
optimization level attribute mismatch
 ZSTD_decompressSequences_body(ZSTD_DCtx* dctx,
 ^
lib/zstd/decompress/zstd_decompress_block.c:1633:12: error: called from her=
e
     return ZSTD_decompressSequences_body(dctx, dst, maxDstSize,
seqStart, seqSize, nbSeq, isLongOffset, frame);
            ^

GCC 6.1.0 gets further, but also doesn't have retpoline support. Maybe
the minimal version should be changed?

Anyway, GCC 5.1.0 doesn't support
__attribute__((__target__("crc32"))), so I'd have to use the flag. I
know I can conditionally add the flag with:

CFLAGS_crc32-glue.o :=3D -mcrc32

But like I said, the file is compiled twice (why?), but only once with
the arch/x86/lib/Makefile. If anyone has any suggestions on how to
solve this, please let me know.

-bw

