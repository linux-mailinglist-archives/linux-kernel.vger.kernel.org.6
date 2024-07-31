Return-Path: <linux-kernel+bounces-269515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90529433B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8471C2838E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038B11BBBFE;
	Wed, 31 Jul 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cUufpmPF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDA1AB52E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441182; cv=none; b=ehj80+J46oyUJrOFo5q9B+rq3983KV5O3KonSwxU13jFv90p+VTuul+n9HUipf9Ig0BogqzkNF1wAA06WqWECOdSkuVJXJ03Moz6pv490RjCamMfQPVvuWXrDx4MoAlugYOFKfb8sHQtJk2S38SIHZ/HzO2knWhqFU/iwAfR9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441182; c=relaxed/simple;
	bh=4QyT19NnM+9/PuwfHfJL7DptcgLgMwNAGrNKNw6o17E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrwT7kSAPc3IFvw9ggUMtE+IilASlVhPKToTD2GKlfELSiQQ1WZNQFP+C0ZvAPOTwiQNhJGHACo1nTIhyDXM0uJ5cIpTN6x2WLO8bsg5sx7TSh2EFAUnBWIav5T9fJrmIMtvx2afHCv/q95GdSc/dCdUn/v66xZz3j82xJbd+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cUufpmPF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9a369055so655761266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722441178; x=1723045978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RZ97hpomLEw/byUwUY0TgBpzkmi9pewqj9GBO3ZeSI=;
        b=cUufpmPFf692AYMa5SKRCJf+T++ugWAxyn8fbLcueVuGLGujYhFfA3EiiKZNw3TAWc
         Pua5Z8mJz9OcMtucqPp8ogMADqFiBkpTei5kYsWkp6ery2/mUmKACU5jworyAaAoSwNK
         IKSiTk6MZCm8Zq/PUynYI1gow/vffgNln2MN59lnEA66SVb1hdmBUmh5GQJkeqDmKCZd
         DA9k3UpODUeeJyNovHPGRhwtBXTNi26Mp6YvJltb9ReptcoJpwV/l4izC96lz4YsQiHn
         Fj3Tl+AO0WnI7fBGHD1kCjtivP9UJpgHlDtGpHTPzUaGjUz/MxqCZ6kEpB4yi+3YGgRM
         jaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441178; x=1723045978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RZ97hpomLEw/byUwUY0TgBpzkmi9pewqj9GBO3ZeSI=;
        b=QF4itorXIl3Mqj4XxbSlssA6llk0ROLEAwL9+B63psE2QZ8xFQAWhWua/c5/ziekCj
         hh+ZDWvzMS/y3yHJsDvrZke+wgwNuJ+FKOjeqnLPY/vws3EuDGbkGDIAdpYKwA1GBvXs
         TevrdxOu2lOwDZTCBXYt3Zk4NVUJruKHfT1+gQq7S+QmWi5Skj6nh2RIGE55ymxTzRJu
         arT1JIo0AJJPJKmaxWQqq0eHA17VDvBB/APXmdP9aJu2yTXqMtdoo/wy4qCFAC/Rtb+a
         k490taRraeBuP8Me8PFExRnCivnKgVxFl3hw5ja2zJPtsTAeh7JfBVEaE1PzVfERfEo9
         wp3g==
X-Forwarded-Encrypted: i=1; AJvYcCWdqwJcdUiVeOOkWlyOgqB6OjVMzkrEPXkuyr3NNTKNDGywxMVXGGxAag2HCgdVDVZvWwnOiWmYGXfvI/cU1B5RmKZrj7gJZWE7B79E
X-Gm-Message-State: AOJu0YySHRnbf6aMgAtPXyIMwlrrc/Co0SwrKRR0pEKuHH/InzG+Fa1e
	F8Z1nb9kTTrdHuv5t6FrxLxi1gUXw8glaCagHPIcfautBFlpklYM2Kzvbw/FwoDdfvvSLWx/KrH
	sEepOnWGp4JsKjl3jRUfCpzMVQsomX0QANsUs0g==
X-Google-Smtp-Source: AGHT+IEXrHnA4utmPx+s/NdEbR222Kpex0GF+qbN3+UuVDfaYGeQQ5BPa+yd+9D4iYRNxVvYTM9lFswX+PBEW9CkWTk=
X-Received: by 2002:a17:906:628c:b0:a72:5598:f03d with SMTP id
 a640c23a62f3a-a7d4014be34mr696899066b.59.1722441177488; Wed, 31 Jul 2024
 08:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-3-alexghiti@rivosinc.com> <20240731-56ba72420d7f745dacb66fd8@orel>
In-Reply-To: <20240731-56ba72420d7f745dacb66fd8@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 31 Jul 2024 17:52:46 +0200
Message-ID: <CAHVXubjrrWVnw1ufXRJh_5N9M5UiOVZseb0C78fjLaYhNKF7eA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword
 operations with Zawrs
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Wed, Jul 31, 2024 at 4:10=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jul 31, 2024 at 09:23:54AM GMT, Alexandre Ghiti wrote:
> > riscv does not have lr instructions on byte and halfword but the
> > qspinlock implementation actually uses such atomics provided by the
> > Zabha extension, so those sizes are legitimate.
>
> We currently always come to __cmpwait() through smp_cond_load_relaxed()
> and queued_spin_lock_slowpath() adds another invocation.

atomic_cond_read_relaxed() and smp_cond_load_acquire() also call
smp_cond_load_relaxed()

And here https://elixir.bootlin.com/linux/v6.11-rc1/source/kernel/locking/q=
spinlock.c#L380,
the size passed is 1.

> However, isn't
> the reason we're hitting the BUILD_BUG() because the switch fails to find
> a case for 16, not because it fails to find cases for 1 or 2? The new
> invocation passes a pointer to a struct mcs_spinlock, which looks like
> it has size 16. We need to ensure that when ptr points to a pointer that
> we pass the size of uintptr_t.

I guess you're refering to this call here
https://elixir.bootlin.com/linux/v6.11-rc1/source/kernel/locking/qspinlock.=
c#L551,
but it's a pointer to a pointer, which will then pass a size 8.

And the build error that I get is the following:

In function '__cmpwait',
    inlined from 'queued_spin_lock_slowpath' at
../kernel/locking/qspinlock.c:380:3:
./../include/linux/compiler_types.h:510:45: error: call to
'__compiletime_assert_2' declared with attribute error: BUILD_BUG
failed
  510 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:491:25: note: in definition of
macro '__compiletime_assert'
  491 |                         prefix ## suffix();
         \
      |                         ^~~~~~
./../include/linux/compiler_types.h:510:9: note: in expansion of macro
'_compiletime_assert'
  510 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro
'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:59:21: note: in expansion of macro
'BUILD_BUG_ON_MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
../arch/riscv/include/asm/cmpxchg.h:376:17: note: in expansion of
macro 'BUILD_BUG'
  376 |                 BUILD_BUG();

which points to the first smp_cond_load_relaxed() I mentioned above.

Thanks,

Alex


>
> >
> > Then instead of failing to build, just fallback to the !Zawrs path.
>
> No matter what sizes we're failing on, if we do this then
> queued_spin_lock_slowpath() won't be able to take advantage of Zawrs.
>
> Thanks,
> drew
>
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index ebbce134917c..9ba497ea18a5 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -268,7 +268,8 @@ static __always_inline void __cmpwait(volatile void=
 *ptr,
> >               break;
> >  #endif
> >       default:
> > -             BUILD_BUG();
> > +             /* RISC-V doesn't have lr instructions on byte and half-w=
ord. */
> > +             goto no_zawrs;
> >       }
> >
> >       return;
> > --
> > 2.39.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

