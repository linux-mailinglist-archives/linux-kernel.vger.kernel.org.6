Return-Path: <linux-kernel+bounces-428951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FB9E154A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EC716222A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8EF1DDC1A;
	Tue,  3 Dec 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwPCrcPq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB11D279F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213195; cv=none; b=JwDfA3mvPWo9HkeuDd4mqSzU9ImCM81TLkHyFaxJbKZ+iOjbjYvGGzXdqaTr80dXd93hyi6gsN6ywdn4CjZuI3HiOy4FgE+L/FDzAvgLdqii4Szjhn7LhBmVGJBPYSziZ3fw3woYYwY+UwHrDJfyZwW3WxBElvjOPIfmVIGqvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213195; c=relaxed/simple;
	bh=vVdSAEjjF7vnzpDJHSamMgZWZo+QvXJUBwY/WGwFsY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5z12f9q863D4zuLkpRTo20QEeA/FQlSnodvGPiJT0+/220db8T2ML2+xDIlK2uSkRLI7xDPNd+z/8TZg8/droDcWZUiOwXO1rFwwFx5Hira5w7ObrMh+ja8tyaQAuDmlNadW8VXfhjtYbInbIMLujUZaelOunkpEDAwV49HGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwPCrcPq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso45962351fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733213192; x=1733817992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opzO5V2DPUxW/Rc2D9ZvCCFz3JWoSwzWzqi7j3oV4q0=;
        b=WwPCrcPqMRvfH9SdmnmWHpyBFsxL+lQCTRdeDY7eoSMyuBbJbm4HmVyWDfFz+QZnxd
         A9m8MHly96TEdISXZ4IrxGF+YXhmk3EOlKpI36rUl9LD+EJ9wFGMUjH9/5+vNhPupZoq
         vcv8cNv2r/PLhLc0+qgOv9emUvmSgInvJvQIjck2yWaiVxtfvrW192WoKKVbzj+3eCpi
         uU49Y4+/WSw6tOIA2Scx9s/7jVKsGu9pAMpEUmAeeJzWW+nyWsl+2sDOq8+gZgHaR3p1
         WtyTEq9HuiUbPOqk0NUwoBW5cr3OpaQtaSvphe/pbrKzX3AHsF8Xm5dtUkFRIGxroJWp
         PMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733213192; x=1733817992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opzO5V2DPUxW/Rc2D9ZvCCFz3JWoSwzWzqi7j3oV4q0=;
        b=l4LSnq+9y2nPqPXNnvZW2lFDt/G4Wq0dk43Sj6QwSxNHDaNBME1paoH9ZeH00pMvVv
         Cm0iOGxA6mwXpYfDpekySblN4tjRc71u5xo1+35LKOo09mDCyamUJvQx2I2/WgnI2gcb
         FV6ngFA6hkr7oozRaSK1hWMB74r2EwLa0w+Laowuc7tzWJdBJenoagp9tR4QsD1qaall
         xaQJFOnfOg/AbDaG37PXRcWCsVCAhmLWmH7tPh+vmlRnXTDRmWkJ+zvBuMHVlsFjnR0v
         egQ5pRw94gUGdI0uPPV1LVEXDNumLiqh1ykMVw61YUc4X5rtdlJo9yDkmvWtpMZFpIvH
         iUqw==
X-Forwarded-Encrypted: i=1; AJvYcCXI9oENcSTnPhjHnRBKYjsQ3yLZSCfVHp0YwQR2YTTno0RRdTLFqAn1JTV3ZrOZBfAdailLoMk2gwCcRio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/i8Jft35GlfQOin8jHaQ7rb3y+EdOPTrEAJuUcgb3sm8DcqZC
	0xmO72dF5tB+Qu321lOuj6upEelyJCJb/JzrkwJhFnMhObxgB8y+ZFD/VWsVvK8s7c1Kvpme7Qz
	5jH1kooqgMMNTKRKHfrm6ALVuAI6PZSfpNSo=
X-Gm-Gg: ASbGncuLwVaYtn5IAcce2xE7upgs5tqO2GoKJhNJFx+y7Xt9OGBzzPXntDmLs/2cz5z
	uUERlc+KeoojlWmlyVzQN2I/wXIeY7b4=
X-Google-Smtp-Source: AGHT+IEZkrRNfqEsSMOAAQH9zZ2mDiwqcIpswUxDOG6rdnSBzlAHRaz2pHU1Tf+50XhBjy7FOtBeQeKK6vCNOfTpnkA=
X-Received: by 2002:a05:651c:542:b0:2fa:c185:ac4e with SMTP id
 38308e7fff4ca-2ffde23e3dcmr64644741fa.13.1733213191374; Tue, 03 Dec 2024
 00:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203003856.GJ1253388@nvidia.com>
In-Reply-To: <20241203003856.GJ1253388@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 3 Dec 2024 09:06:20 +0100
Message-ID: <CAFULd4ZpFVaKVkuTS=RjtYk=_vU8yuXBQ2mPYP9+mpoLk_-S5A@mail.gmail.com>
Subject: Re: Help with atomic fallback
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:39=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> Hi Mark/Uros,
>
> I hope one of you can help me unravel this, I'm trying to use
> try_cmpxchg64_release() from driver code and 0-day is saying arc
> compiles explode:
>
>    In file included from include/linux/atomic.h:80,
>                     from drivers/iommu/generic_pt/fmt/../pt_defs.h:17,
>                     from drivers/iommu/generic_pt/fmt/iommu_template.h:35=
,
>                     from drivers/iommu/generic_pt/fmt/iommu_armv8_4k.c:13=
:
>    drivers/iommu/generic_pt/fmt/../pt_defs.h: In function 'pt_table_insta=
ll64':
> >> include/linux/atomic/atomic-arch-fallback.h:295:14: error: void value =
not ignored as it ought to be
>      295 |         ___r =3D raw_cmpxchg64_release((_ptr), ___o, (_new)); =
\
>          |              ^
>    include/linux/atomic/atomic-instrumented.h:4937:9: note: in expansion =
of macro 'raw_try_cmpxchg64_release'
>     4937 |         raw_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_AR=
GS__); \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/iommu/generic_pt/fmt/../pt_defs.h:144:16: note: in expansion o=
f macro 'try_cmpxchg64_release'
>      144 |         return try_cmpxchg64_release(entryp, &old_entry, table=
_entry);
>
> Which is immediately because of a typo in atomic-arch-fallback.h code gen=
:
>
> #if defined(arch_cmpxchg64_release)
> #define raw_cmpxchg64_release arch_cmpxchg64_release
> #elif defined(arch_cmpxchg64_relaxed)
> #define raw_cmpxchg64_release(...) \
>         __atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
> #elif defined(arch_cmpxchg64)
> #define raw_cmpxchg64_release arch_cmpxchg64
> #else
> extern void raw_cmpxchg64_release_not_implemented(void);
>      ^^^^^^^^^^^^^^^^^^^^^
>
> That should return int to make the compiler happy, but then it will
> fail to link (I think, my cross compiler ICEs before it gets there)
>
> However, arc defines:
>
> static inline s64
> arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
> {

Please note that arch_atomic64_cmpxchg() and arch_cmpxchg64() are two
different things.

> And I see a:
>
> static __always_inline s64
> raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
> {
> #if defined(arch_atomic64_cmpxchg_release)
>         return arch_atomic64_cmpxchg_release(v, old, new);
> #elif defined(arch_atomic64_cmpxchg_relaxed)
>         __atomic_release_fence();
>         return arch_atomic64_cmpxchg_relaxed(v, old, new);
> #elif defined(arch_atomic64_cmpxchg)
>         return arch_atomic64_cmpxchg(v, old, new);
>
> Which seems to strongly imply that arc can do the cmpxchg64_release
> primitive.

No, this is *atomic64* version. Arc has to define arch_cmpxchg64 in
its cmpxchg.h. An example can be seen in e.g.
arch/m68k/include/asm/cmpxchg.h [1], where we have:

#include <asm-generic/cmpxchg-local.h>

#define arch_cmpxchg64_local(ptr, o, n)
__generic_cmpxchg64_local((ptr), (o), (n))

#define arch_cmpxchg64(ptr, o, n) arch_cmpxchg64_local((ptr), (o), (n))

[1] https://elixir.bootlin.com/linux/v6.12.1/source/arch/m68k/include/asm/c=
mpxchg.h

> But I haven't been able to figure out what is expected here for
> arch_atomic64 vs try_cmpxchg64 to guess what is missing part here :\
>
> Any advice?

Please use system_has_cmpxchg64 define, as is the case in
source/mm/slab.h. Arc does not define arch_cmpxchg64() and should be
excluded from compilation.

Uros.

