Return-Path: <linux-kernel+bounces-231368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B892691948E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB92282549
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B7114EC65;
	Wed, 26 Jun 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkDh3JGn"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34841332A1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428413; cv=none; b=Mc2aRG764ZTJBAF17ABwEp+7uRmu90gjEBLMOLY4cbce/r7ERcHy7qf+JuMlz8soiADBk2b17KZVhXwAZva1rwFLJs4ZGEZOVZb0vIBKVM82RGH1VyR1AjnGh+qa1ZLW3Lmdom4K8e1NX1w0GF/rsW5Nd5Pm5YxnisBjGlpMZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428413; c=relaxed/simple;
	bh=GfLi7LYFulbSi5V+HGbjWEwBuVAmV3kLMOYOWNDQkRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0y/zFB73ZD/KPzCqcL3kgD1vQezzU2Pdms153AY8ECyT5N0s75jlBM5m+P05ekcUzmOn50ZSClzu8eXMRux20F0gQMPbc0UflSGvkTgQ+Y53VgAOwzi+FoimPYEi1YBsKMJT2JXnd6HINeiFdilVroxiZSOtWt1cKmPPfk1K3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkDh3JGn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so55149441fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719428410; x=1720033210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejN16YrWL6vTSaVT5GSNha35StEWbW7LQ2tSdIHVLpE=;
        b=VkDh3JGnxd8XtrfOMRFj6EBWqA5MbJ2MQEyZFKlkNYCyc12uwQ7R+XRAquX7lRDsN/
         pkq3mY7O12hMyyOhUbbLKMc4Dpt2GPueyIA7f6UNaFedGU8A6cRVtl6t9BVih4MRJWb1
         PNVQNlvCSQJsFboosi7OG2inPTYAMv/dmZW+qdeoA/37mokibARPWEO4+hSaQkw1nth9
         1M7rJlHSJXQRApO7gwQR43ALDjcm8kgTWn/xJyhftq7rf2qmkxjBKAfJkdJXlJTbwD1S
         oU40PkozsTlhTyAK+o0gj/IGdCmvVkHznemH5/pHm4MsjbJIII9FN4i3Vu4ybQPjeAqT
         XYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719428410; x=1720033210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejN16YrWL6vTSaVT5GSNha35StEWbW7LQ2tSdIHVLpE=;
        b=CYfmYkfIKIWDxQrvnN+jV9/omDa4WXoMEhT6GLAV+8ErlTbF35R4WIAqO4MNs3LZ3S
         pxuR/jmXn6W1EOzzzHAV9jk1dw5pCCDnUxlo5m2y8C4KXBmNRXUavxMl2+uZs7HXFd+1
         ic1wQt4LeAq1mqVNJbCTwmd3mSQr7hVcZGSCC/XmN+3JHzUmbIRE922FjbBnro0IY8Ge
         oQJFXs0nmA62Hf/laTt2FoSVAoUwdGYP3l54Q7077/gFgCkE+/hzlVDrWdhMFSOs1x1l
         JeUN/k5764iWX/TRxOF39HrJDsFObuA3P4RUnXSaqTsVFg7L+2lX/LBJIr9Ss2qE5ngp
         yaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIl9XovTIwT+zK0dvs/3X2I72GALAxgoKR7hLH6aelrqo/6P03+PyNUwaBW1wD/CtyuF2pKH3KUU0xqD7I5cUWj5sEX9yyhdpLpoBE
X-Gm-Message-State: AOJu0YwYSCKB/Ciz7ugfE5bq8GE1f30IjheIBN7gGCVWzzJqsujvL6rT
	9XS10saIdaZqdh5kXHXC+F8M6LsJKnB3u+uFRy2auBuVJwo8JQAFxbFPnSDas3HtsiMxaLcD1iG
	5fbkPCM9w5grt8U+rpZNzUussZKr2Q/gedf0=
X-Google-Smtp-Source: AGHT+IHdTxyAOg082l0qOlmKxPTi37SNPPh9bLaDR9elUWINPRp6JONY42nK76EY6XVisDdPx2gBLzNlljMFJ44PHB8=
X-Received: by 2002:a2e:83d0:0:b0:2eb:d9b3:634b with SMTP id
 38308e7fff4ca-2ec5b36af6emr84293061fa.46.1719428409868; Wed, 26 Jun 2024
 12:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
 <20240626151131.550535-2-torvalds@linux-foundation.org>
In-Reply-To: <20240626151131.550535-2-torvalds@linux-foundation.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Jun 2024 20:59:57 +0200
Message-ID: <CAFULd4bpH7-epdnh4CGwUHhLua2GLMeLiLJok3aJ3k+fA4TPfw@mail.gmail.com>
Subject: Re: [PATCH v2] x86-32: fix cmpxchg8b_emu build error with clang
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 5:14=E2=80=AFPM Linus Torvalds
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

Reviewed-and-Tested-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>
> This is the minimal patch, with the other simplifications removed.
>
> I still think that the case where somebody passes in a "oldp" that can
> change during the cmpxchg is entirely broken, and is not actually valid.
>
> If it was valid, we'd have to use READ_ONCE() and WRITE_ONCE() in the
> "oldp" updates anyway just to make verification tools happy. We don't.
>
> But hey, that simplification doesn't matter for fixing this build issue,
> so let's keep the change minimal.
>
>  arch/x86/include/asm/cmpxchg_32.h | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmp=
xchg_32.h
> index ed2797f132ce..62cef2113ca7 100644
> --- a/arch/x86/include/asm/cmpxchg_32.h
> +++ b/arch/x86/include/asm/cmpxchg_32.h
> @@ -93,10 +93,9 @@ static __always_inline bool __try_cmpxchg64_local(vola=
tile u64 *ptr, u64 *oldp,
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
> +                    : "+a" (o.low), "+d" (o.high)                      \
> +                    : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)      \
>                      : "memory");                                       \
>                                                                         \
>         o.full;                                                         \
> @@ -122,12 +121,11 @@ static __always_inline u64 arch_cmpxchg64_local(vol=
atile u64 *ptr, u64 old, u64
>                                                                         \
>         asm volatile(ALTERNATIVE(_lock_loc                              \
>                                  "call cmpxchg8b_emu",                  \
> -                                _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX=
8) \
> +                                _lock "cmpxchg8b %a[ptr]", X86_FEATURE_C=
X8) \
>                      CC_SET(e)                                          \
>                      : CC_OUT(e) (ret),                                 \
> -                      [ptr] "+m" (*(_ptr)),                            \
>                        "+a" (o.low), "+d" (o.high)                      \
> -                    : "b" (n.low), "c" (n.high), "S" (_ptr)            \
> +                    : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)      \
>                      : "memory");                                       \
>                                                                         \
>         if (unlikely(!ret))                                             \
> --
> 2.45.1.209.gc6f12300df
>

