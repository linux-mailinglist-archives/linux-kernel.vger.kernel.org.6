Return-Path: <linux-kernel+bounces-230214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0E9179E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A265B249DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8815F33A;
	Wed, 26 Jun 2024 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO8UZnmn"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E615F318
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387595; cv=none; b=ohGWzjIQdzKTHhX1KCfzk5E604P6bPS0zt7HOmTdn2ssuY48IiuQBNr6hHRZqlGXBYWbXcT5deyMKbR3qPiTMXxTE2MjSlgifpYSkATIiKIVQrJGBo02gOYdf6etaGfCvCTa2NP5UiakkoULKgPvoVZrbIX4dampc8U3sycSgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387595; c=relaxed/simple;
	bh=tyZL7cBk6TW3O3oZYTWSxq5+18unKtEWC+clCgU+OrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaIqgx+FWcxw4P9070rwGZFFD1/zSz3B4JqPIU/mGa2fkjP0ZdlZKh05vRHKB7USi4FxDlsJvB5kcR05PNdy876LJO4WKaiVLxh7xsVJP8OjkvrUJ01eM42/Rk6X18tUL3Kw7emhQ7fDuZRzd12MSaiFJui+ujr4g6ULxPvNdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO8UZnmn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso66139131fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719387592; x=1719992392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKdnPCYKoD2YYDFXov9+6a1aaRnPMJBqVZerixU1aSo=;
        b=SO8UZnmnBy8lZjV4Cq45UdNrOaXBAvbCZNfyXZEyu60F3yRSA1ke/JrwW2wPH8LtjG
         39Ii+0GqzQGLb1U5e9CITjuz0C/Xee+BXrL/8Za6LMpvZKquQgrmUFVyemQxTm5CuO59
         Sq9VPhjqMJTl9ezgdiwVZrMC6sE6sLPEDBO+PH9F7oqzzRqkf2aF41bGXID9elkJNLBW
         BSdBGphRH8IstMow+UxgvLz71LqN/MWI7Y58IwF5bnQBRn+OdRwIk9pamaavfVIhxM65
         a566GfYWgoRGBdJfy02JpGpw9A505uQMV1BXrPUw3vGvmUe02TOumg/a50c02hBznfkV
         T0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387592; x=1719992392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKdnPCYKoD2YYDFXov9+6a1aaRnPMJBqVZerixU1aSo=;
        b=nfG/J8Fk1GqRWZ8Gr16CqpBIJI1JgQ92HmUrtotUxB9h6elvJje6K7Cgs6z+ntwf+f
         fDOPtugw175DrlcjMpIB8e/gpl/EOnCanguphYyhUhyWQKAA54fx5Dey4aeuhdU+nGMq
         LskE79UUow3dNyRSDiAPnevwcphOFsMLosJtEWrd5/OTuEf7u2FilcXRwN55eWG7Lax9
         3dh5fwL3L4mmFnrG28E6RtCEu1IHZadv7T7zJ2MvsDVYXOZsH/JTg5wIueUNKkHXqTK+
         5/pNvdvCc4h3qzZwurXOscJ9+MUgtmFnkCplgbDcVMY5tTbukL9yUWQYspJkgcCTJq+v
         WQZw==
X-Forwarded-Encrypted: i=1; AJvYcCXbNxCdovtwmWUZmZgD7WZcE0d58uaIgGLDqDrT9vyGFpkgbVf3TKpdP3doNQOpeDaq1VJYomKbFI1+r5L8q0iPNvfm05b741OmW61z
X-Gm-Message-State: AOJu0Yx9Ffo6CkeYOKpQ63vGJMQR3ZcfqZg2wMYfU9dVHI1EUpjEZc17
	U8m44DBHKW05PFIN++dJyZlp7IqCv9MSHNjtWZuBhgyVL55aKMXiZiDpmL+/3ygBZlsRAig7i6C
	THt8y6PKYMtaKPq7vJpH14EkQvRZj0VKls3A=
X-Google-Smtp-Source: AGHT+IEGbnumEm8SgVNZR81G/FJDJ0/yGZJ2mMZeFixnZBCROpwcElRe0r7uPvKzDyqaS2KgtaW9x7Hbk2/+gsiSLbY=
X-Received: by 2002:a2e:86cb:0:b0:2ec:4de9:7332 with SMTP id
 38308e7fff4ca-2ec593c296bmr55860731fa.2.1719387591744; Wed, 26 Jun 2024
 00:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
 <20240626010924.478611-2-torvalds@linux-foundation.org>
In-Reply-To: <20240626010924.478611-2-torvalds@linux-foundation.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Jun 2024 09:39:39 +0200
Message-ID: <CAFULd4YUBGO1wmsacsxm5ZdbKu++evNC0NbLpGjZVQFTeJze7A@mail.gmail.com>
Subject: Re: [PATCH] x86-32: fix cmpxchg8b_emu build error with clang
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:13=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The kernel test robot reported that clang no longer compiles the 32-bit
> x86 kernel in some configurations due to commit 95ece48165c1
> ("locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}(=
)
> functions").
>
> The build fails with
>
>   arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly require=
s more registers than available
>
> and the reason seems to be that not only does the cmpxchg8b instruction
> need four fixed registers (EDX:EAX and ECX:EBX), with the emulation
> fallback the inline asm also wants a fifth fixed register for the
> address (it uses %esi for that, but that's just a software convention
> with cmpxchg8b_emu).
>
> Avoiding using another pointer input to the asm (and just forcing it to
> use the "0(%esi)" addressing that we end up requiring for the sw
> fallback) seems to fix the issue.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406230912.F6XFIyA6-lkp@i=
ntel.com/
> Fixes: 95ece48165c1 ("locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,=
fetch}_{and,or,xor}() functions")
> Link: https://lore.kernel.org/all/202406230912.F6XFIyA6-lkp@intel.com/
> Suggested-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> Added commit message, and updated the asm to use '%a[ptr]' instead of
> writing out the addressing by hand.
>
> Still doing the 'oldp' writeback unconmditionally.  The code generation
> for the case I checked were the same for both clang and gcc, but until
> Uros hits me with the big clue-hammer, I think it's the simpler code
> that leaves room for potentially better optimizations too.

You probably want to look at 44fe84459faf1 ("locking/atomic: Fix
atomic_try_cmpxchg() semantics") [1] and the long LKML discussion at
[2].

--quote--
This code is broken with the current implementation, the problem is
with unconditional update of *__po.

In case of success it writes the same value back into *__po, but in
case of cmpxchg success we might have lose ownership of some memory
locations and potentially over what __po has pointed to. The same
holds for the re-read of *__po. "
--/quote--

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3D44fe84459faf1a7781595b7c64cd36daf2f2827d
[2] https://lore.kernel.org/lkml/CACT4Y+bG+a0w6j6v1AmBE7fqqMSPyPEm4QimCzCou=
icmHT8FqA@mail.gmail.com/

Uros.

>
> This falls solidly in the "looks ok to me, but still untested" category
> for me.  It fixes the clang build issue in my build testing, but I no
> longer have a 32-bit test environment, so no actual runtime testing.
>
>  arch/x86/include/asm/cmpxchg_32.h | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmp=
xchg_32.h
> index ed2797f132ce..4444a8292c7a 100644
> --- a/arch/x86/include/asm/cmpxchg_32.h
> +++ b/arch/x86/include/asm/cmpxchg_32.h
> @@ -88,18 +88,17 @@ static __always_inline bool __try_cmpxchg64_local(vol=
atile u64 *ptr, u64 *oldp,
>
>  #define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock)       \
>  ({                                                                     \
> -       union __u64_halves o =3D { .full =3D (_old), },                  =
   \
> -                          n =3D { .full =3D (_new), };                  =
   \
> +       __u64 o =3D (_old);                                              =
 \
> +       union __u64_halves n =3D { .full =3D (_new), };                  =
   \
>                                                                         \
>         asm volatile(ALTERNATIVE(_lock_loc                              \
>                                  "call cmpxchg8b_emu",                  \
> -                                _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX=
8) \
> -                    : [ptr] "+m" (*(_ptr)),                            \
> -                      "+a" (o.low), "+d" (o.high)                      \
> -                    : "b" (n.low), "c" (n.high), "S" (_ptr)            \
> +                                _lock "cmpxchg8b %a[ptr]", X86_FEATURE_C=
X8) \
> +                    : "+A" (o)                                         \
> +                    : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)      \
>                      : "memory");                                       \
>                                                                         \
> -       o.full;                                                         \
> +       o;                                                              \
>  })
>
>  static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u6=
4 new)
> @@ -116,22 +115,19 @@ static __always_inline u64 arch_cmpxchg64_local(vol=
atile u64 *ptr, u64 old, u64
>
>  #define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new, _lock_loc, _lock)  \
>  ({                                                                     \
> -       union __u64_halves o =3D { .full =3D *(_oldp), },                =
   \
> -                          n =3D { .full =3D (_new), };                  =
   \
> +       __u64 o =3D *(_oldp);                                            =
 \
> +       union __u64_halves n =3D { .full =3D (_new), };                  =
   \
>         bool ret;                                                       \
>                                                                         \
>         asm volatile(ALTERNATIVE(_lock_loc                              \
>                                  "call cmpxchg8b_emu",                  \
> -                                _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX=
8) \
> +                                _lock "cmpxchg8b %a[ptr]", X86_FEATURE_C=
X8) \
>                      CC_SET(e)                                          \
> -                    : CC_OUT(e) (ret),                                 \
> -                      [ptr] "+m" (*(_ptr)),                            \
> -                      "+a" (o.low), "+d" (o.high)                      \
> -                    : "b" (n.low), "c" (n.high), "S" (_ptr)            \
> +                    : CC_OUT(e) (ret), "+A" (o)                        \
> +                    : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)      \
>                      : "memory");                                       \
>                                                                         \
> -       if (unlikely(!ret))                                             \
> -               *(_oldp) =3D o.full;                                     =
 \
> +       *(_oldp) =3D o;                                                  =
 \
>                                                                         \
>         likely(ret);                                                    \
>  })
> --
> 2.45.1.209.gc6f12300df
>

