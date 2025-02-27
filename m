Return-Path: <linux-kernel+bounces-536266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66835A47D85
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8BF1765C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A7622F39C;
	Thu, 27 Feb 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="He49sx0v"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670222D4E3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658664; cv=none; b=nD8KRXhn88sDH0QF0EH1TZRQWpKMIu6Qzpx6umMPT9FnaWbGAO+I4zDNpr0vM6o7Xdj9lYJDfSWY0MEN3B/6GKwo7YjepUVMYlOY0FsorO953toIAI/qOzNODYMkT5+QLi16GoXzaczGmg6tsGVbpNQytdQQO3CaNL+vIINGP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658664; c=relaxed/simple;
	bh=t2NEDTueBdrSzpgnFv04f30wmQJOXvi/XawvOOxHn+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE46Q7gJ7aiYlXbR5sPs6cqxd8GFW3YyVzETu+I9Is1duUH1cIcTz3tSK6lW1i3bvMEF5xQpmQqEjrcg4RmcPVZDAckeOYsc/z1ARxlWwuzIkR8CewhsIXhFponwFTZeMj6VmDnQdHJ/pMsa2mwyVt7I1AINbNOU3HzHQlFoGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=He49sx0v; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf06950db5so123859966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740658661; x=1741263461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRXThQoOhwcNnfMppD5vGBwZ9FKwKkKrXbvSv/+frAI=;
        b=He49sx0vEapmkUt1z3yGaOX1ltKdhey+ncCLb8smPK6USqhJwq6NcK7WeIJY0EjzAI
         4Hu9Q3rF0qfiMuaPLH/y7YtvbLvdBVDkKwfYV+wU+9tAvOihXj+ZlCbG53WdyTDMDdTE
         JYcqCuRlDrlBc0dSdzYgndXDjDEBhN8CsNv+2CbKSC6XcSKSn6FaTjJ/BYJFp3w0TVn3
         XJPH8CM+ADA2Z3LK49fhG9b/R7AYSOEByh68057hRYTG03AWFRRUNhGVtSfvFby8urD0
         pWKKNckHarYVdcEk9upm8CBREaTUccAjm4hYPIkEa/2uavHgbp/Lr6UVIvJFmGJq00BV
         staQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658661; x=1741263461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRXThQoOhwcNnfMppD5vGBwZ9FKwKkKrXbvSv/+frAI=;
        b=PohWtTKExoKqByDh1i1YBRICD8atLnOdb3q5HxrhJiOlkY2f1YQ/nFPaC3fm4C2OlE
         ZNeCHjRj38zoIHdhmjH/TQKVcSLsGmi5UQw1CtDVkrx4s76jBjkR+bsKHZt3sse6zPPh
         pggnwyj80mWzGPVmZ2TcMeONK2WyykT5bkI6lOnjVOHaFCcx20BJLfuFmTwISR8CAI1+
         JixvYpGKgwjjoWtfleEin9MSRPNMvzKHoWshHrCAAVWXkrX2XUHYUTAirp1rN1+hkGxw
         ArCSenMVEdMpwisvZMgHbu2i5GN/Rs8eAaBPta2jzS4CYGGwbDgfQGnEir8xsbUDC2+h
         Wsmw==
X-Forwarded-Encrypted: i=1; AJvYcCVzOjy+GiK8rww2/7OOWRDz4PJzRtBhjNlvsAF/4QXEzkwhELGf1ktcVH25kiMLFor28rTtOf9iJVcavr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCN2RMO5hK1ftuqN1rBcHCyjTFdiyGyloq8FCF94zLV682Ht7
	DmWO80gKxzApd05Ynq1HFKmj5LhX7vng19DnKTUpAGTn8t7XxZgYBFH45qsPjxl+GYOeyUyPP46
	mQL3WR/FBdwKFZnJSChJE5udj+potm+x4CKY=
X-Gm-Gg: ASbGnct3i47l16Mp5FVxvCSGE95SkbBCg4zDugexNVJrxd5riFZeXxGfpnJ2dNQxCej
	Vx0FKsN5rwMDPE83eT5UhpLC9cqroGYKRpupujdZnbZ56djFS1H5gpBYBVFP5UjqVHhxqwEUJl4
	fasGj5
X-Google-Smtp-Source: AGHT+IHRc8urmMJEzZbReC8M5BOsivBbw5OeEiAmZaCJJN/28VM+niwg7HDoTK9wNm4K4ubtXD5ztJ3KeACr16PHRt8=
X-Received: by 2002:a17:906:308e:b0:ab6:511d:8908 with SMTP id
 a640c23a62f3a-abc0de19516mr2303876566b.40.1740658660615; Thu, 27 Feb 2025
 04:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGG=3QVi27WRYVxmsk9+HLpJw9ZJrpfLjU8G4exuXm-vUA-KqQ@mail.gmail.com>
 <20250227062859.GA2506@sol.localdomain> <68F134A3-5371-4E74-9942-2BC66984C18A@zytor.com>
In-Reply-To: <68F134A3-5371-4E74-9942-2BC66984C18A@zytor.com>
From: Bill Wendling <morbo@google.com>
Date: Thu, 27 Feb 2025 04:17:24 -0800
X-Gm-Features: AQ5f1JqSG0FexJpU0L8y0F9hIyeax1Uhs_LQEGtbtQBFiT71P2KI1fCoyo9pC64
Message-ID: <CAGG=3QX2WX5U-uNp3VWSbQCN9fPVAirOBn5KcaWn8m-87RhWfg@mail.gmail.com>
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

On Thu, Feb 27, 2025 at 2:53=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
> On February 26, 2025 10:28:59 PM PST, Eric Biggers <ebiggers@kernel.org> =
wrote:
> >On Wed, Feb 26, 2025 at 10:12:47PM -0800, Bill Wendling wrote:
> >> For both gcc and clang, crc32 builtins generate better code than the
> >> inline asm. GCC improves, removing unneeded "mov" instructions. Clang
> >> does the same and unrolls the loops. GCC has no changes on i386, but
> >> Clang's code generation is vastly improved, due to Clang's "rm"
> >> constraint issue.
> >>
> >> The number of cycles improved by ~0.1% for GCC and ~1% for Clang, whic=
h
> >> is expected because of the "rm" issue. However, Clang's performance is
> >> better than GCC's by ~1.5%, most likely due to loop unrolling.
> >>
> >> Link: https://github.com/llvm/llvm-project/issues/20571#issuecomment-2=
649330009
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Borislav Petkov <bp@alien8.de>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: x86@kernel.org
> >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> Cc: Eric Biggers <ebiggers@kernel.org>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: Nathan Chancellor <nathan@kernel.org>
> >> Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> >> Cc: Justin Stitt <justinstitt@google.com>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-crypto@vger.kernel.org
> >> Cc: llvm@lists.linux.dev
> >> Signed-off-by: Bill Wendling <morbo@google.com>
> >> ---
> >>  arch/x86/Makefile         | 3 +++
> >>  arch/x86/lib/crc32-glue.c | 8 ++++----
> >>  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> >Thanks!  A couple concerns, though:
> >
> >> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> >> index 5b773b34768d..241436da1473 100644
> >> --- a/arch/x86/Makefile
> >> +++ b/arch/x86/Makefile
> >> @@ -114,6 +114,9 @@ else
> >>  KBUILD_CFLAGS +=3D $(call cc-option,-fcf-protection=3Dnone)
> >>  endif
> >>
> >> +# Enables the use of CRC32 builtins.
> >> +KBUILD_CFLAGS +=3D -mcrc32
> >
> >Doesn't this technically allow the compiler to insert CRC32 instructions
> >anywhere in arch/x86/ without the needed runtime CPU feature check?  Nor=
mally
> >when using intrinsics it's necessary to limit the scope of the feature
> >enablement to match the runtime CPU feature check that is done, e.g. by =
using
> >the target function attribute.
> >
> >> diff --git a/arch/x86/lib/crc32-glue.c b/arch/x86/lib/crc32-glue.c
> >> index 2dd18a886ded..fdb94bff25f4 100644
> >> --- a/arch/x86/lib/crc32-glue.c
> >> +++ b/arch/x86/lib/crc32-glue.c
> >> @@ -48,9 +48,9 @@ u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
> >>  EXPORT_SYMBOL(crc32_le_arch);
> >>
> >>  #ifdef CONFIG_X86_64
> >> -#define CRC32_INST "crc32q %1, %q0"
> >> +#define CRC32_INST __builtin_ia32_crc32di
> >>  #else
> >> -#define CRC32_INST "crc32l %1, %0"
> >> +#define CRC32_INST __builtin_ia32_crc32si
> >>  #endif
> >
> >Do both gcc and clang consider these builtins to be a stable API, or do =
they
> >only guarantee the stability of _mm_crc32_*() from immintrin.h?  At leas=
t for
> >the rest of the SSE and AVX stuff, I thought that only the immintrin.h f=
unctions
> >are actually considered stable.
> >
> >- Eric
>
> There is that... also are there compiler versions that we support that do=
 not have -mcrc32 support?
>
Checking GCC 5.1.0 and Clang 13.0.1, it seems that both support '-mcrc32'.

-bw

