Return-Path: <linux-kernel+bounces-229562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B79170E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459341C235D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812B17C7CD;
	Tue, 25 Jun 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Wpnm0PFx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5C17C7AE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342530; cv=none; b=pYkVyjMym2lkBFk/pLzlubA3rYXntPzEfpjolHoL9tAqSyzqGs3lBs9ysYZEK9DeLZW50yrSSvK8D7tUUv1QBSpHqnGV7ZiSkczj4hu5AEu9wtYNYbIrFCHjsgmsYRmbUih1c15gwH1lT0ThiDFzWqdytx0uZUuGnzej3nd8bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342530; c=relaxed/simple;
	bh=iCXSqH+6UU4SulLsAIswpvWVe9yxkOACz3WYkB9p7XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qb8D5KhoPjbVMS7xRn6X8ugIcJVZl8DTq8ZUhMr8+ahGhJ3UOnrEwZn1Ml2Pr2HR6rseq4EqFDRrFpsMSJfayFycgUFEHIu7LKTE6B0epC+dgAH3mE0suhE/uL3AGJPIXIlf+JvmC62lUeY13qC4cZ4zF2MI5mYBzpoD59uzwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Wpnm0PFx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a727d9dd367so103483966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719342526; x=1719947326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL4EzYq6ilmDvWnIZB/4gWNot3CMWNGIIwPHhO9IRMw=;
        b=Wpnm0PFxveZgvn24LtQia5WG1uGB+PXXmun2NmshpQORbBkAoX8yLfhRowLak7rWip
         YKdbZY1DA2JUnZYQcFMRegE1DwvOcDWO79MuQoTYoiENPJumfwSOJ5LkIXWSVaqgfM3a
         f/53OsYTpepQ7BqV8KE1QDWmLVZtRBP4YupLiJ75R7gDkmdYh3pwSdfjfY+4kWwnajYe
         LMgoaYu40G6pI2y3rBjZ1eWmkyCBxcmjAB/DHWfCBBFWKrsHQQsVMelh/MZuN+waAF+O
         mDVK0KWei+cK7l3WklaDBuWlRhZpFiAg8Ma6lQe8eY0lK9KliC/eFMXparqLGsKHNwku
         lISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719342526; x=1719947326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tL4EzYq6ilmDvWnIZB/4gWNot3CMWNGIIwPHhO9IRMw=;
        b=q6mTJsZkh1q4BHi4/+mxigz6jnpEy7FCJoHTgdtgkQaevo+NQKa0ulqXb28TXqE3s9
         HhaDKBOb2dSVSYUY70ixKv0RUkEe7HYhWINLh9pzuOxn8lNvEM1vo8kq77NY+N+Z/JuF
         eKuJPu932M/RvkjHUEmv3KFeZWGkp4tUQQPo03R7FfMeSWGCC/HgDLVDZrRaFcmmXGYa
         7p4oH7a62tZLxkPw3otj0Q+HKJFBAqTmU3EfmOlAUPWCy2hCUdKRqPM52hoK+/XdQqYa
         Vfa3c7vr8GTOpO0IlL4dv2LwkxfteZhKVpp9+xUsjERAKE2lEGDJEJeNj5zG66s9MwVG
         jf+g==
X-Forwarded-Encrypted: i=1; AJvYcCUMo4XJdHlbriE9ajZLsBs1Jv2B7fDScny6d5pVFtbWv7iOXyHDb6KJDzqucuS+DuZydt5WdUDWxRPno2gx1aTO2EMCdirrwGsXFuJt
X-Gm-Message-State: AOJu0YxTAnoU7KU6LrfNDR0c6UX5qaPgq8PHjWIxjRaB4XMfEQ+6HwPL
	m9jule4eMyDdcPMZrjqXDbcH9Jveag1GM7PixK1Ta8zlFrIRTHXZUf73LDnb1xR4dLy1sr1ogPe
	En8HydCxuRuyR2GgqFvUJSqvvr0l5q6k8VI0msQ==
X-Google-Smtp-Source: AGHT+IFgoo2KQUyFKVYcNQsMHt+AG7QRnWDFexuYnSapnWtKPDeO3CINuVI7rn/8LCncVw+v2sU3PjVVf3mqW28I6Oc=
X-Received: by 2002:a17:906:e52:b0:a6f:33d6:2d49 with SMTP id
 a640c23a62f3a-a7242cdb3ffmr713502166b.52.1719342526431; Tue, 25 Jun 2024
 12:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625165121.2160354-1-evan@rivosinc.com> <20240625165121.2160354-3-evan@rivosinc.com>
 <20240625-kindle-sanitizer-c52b48ed9b86@spud>
In-Reply-To: <20240625-kindle-sanitizer-c52b48ed9b86@spud>
From: Evan Green <evan@rivosinc.com>
Date: Tue, 25 Jun 2024 12:08:09 -0700
Message-ID: <CALs-HsuEc9ympGsQP3bvXaowiAj0bq3nvD=9CcX0NNMza+79OA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf defines
To: Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Ben Dooks <ben.dooks@codethink.co.uk>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Erick Archer <erick.archer@gmx.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 11:35=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Jun 25, 2024 at 09:51:21AM -0700, Evan Green wrote:
> > In preparation for misaligned vector performance hwprobe keys, rename
> > the hwprobe key values associated with misaligned scalar accesses to
> > include the term SCALAR.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> >
> > ---
> >
> > Changes in v2:
> >  - Added patch to rename misaligned perf key values (Palmer)
> >
> >  Documentation/arch/riscv/hwprobe.rst       | 20 ++++++++++----------
> >  arch/riscv/include/uapi/asm/hwprobe.h      | 10 +++++-----
> >  arch/riscv/kernel/sys_hwprobe.c            | 10 +++++-----
> >  arch/riscv/kernel/traps_misaligned.c       |  6 +++---
> >  arch/riscv/kernel/unaligned_access_speed.c | 12 ++++++------
> >  5 files changed, 29 insertions(+), 29 deletions(-)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index c9f570b1ab60..83f7f3c1347f 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -215,22 +215,22 @@ The following keys are defined:
> >    the performance of misaligned scalar word accesses on the selected s=
et of
> >    processors.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of mi=
saligned
> > -    accesses is unknown.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performanc=
e of
> > +    misaligned accesses is unknown.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses =
are
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED`: Misaligned ac=
cesses are
> >      emulated via software, either in or below the kernel.  These acces=
ses are
> >      always extremely slow.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned word accesses=
 are
> > -    slower than equivalent byte accesses.  Misaligned accesses may be =
supported
> > -    directly in hardware, or trapped and emulated by software.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW`: Misaligned word a=
ccesses
> > +    are slower than equivalent byte accesses.  Misaligned accesses may=
 be
> > +    supported directly in hardware, or trapped and emulated by softwar=
e.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned word accesses=
 are
> > -    faster than equivalent byte accesses.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_FAST`: Misaligned word a=
ccesses
> > +    are faster than equivalent byte accesses.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned access=
es are
> > -    not supported at all and will generate a misaligned address fault.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED`: Misaligned=
 accesses
> > +    are not supported at all and will generate a misaligned address fa=
ult.
> >
> >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int whic=
h
> >    represents the size of the Zicboz block in bytes.
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index 22073533cea8..e11684d8ae1c 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -66,11 +66,11 @@ struct riscv_hwprobe {
> >  #define              RISCV_HWPROBE_EXT_ZVE64F        (1ULL << 40)
> >  #define              RISCV_HWPROBE_EXT_ZVE64D        (1ULL << 41)
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0  5
> > -#define              RISCV_HWPROBE_MISALIGNED_UNKNOWN        0
> > -#define              RISCV_HWPROBE_MISALIGNED_EMULATED       1
> > -#define              RISCV_HWPROBE_MISALIGNED_SLOW           2
> > -#define              RISCV_HWPROBE_MISALIGNED_FAST           3
> > -#define              RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    4
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN         0
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED        1
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW            2
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_FAST            3
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED     4
> >  #define              RISCV_HWPROBE_MISALIGNED_MASK           7
>
> How come the "old" names do not need to be preserved for userspace?

It depends on what exactly the big userspace compatibility rule is.
This preserves binary compatibility, which I think is the big one, but
breaks source compatibility, though with an easy translation to fix.
We could keep the old names around, but then it seems sort of silly to
introduce the new names. I introduced this patch upon request, so I
don't personally have a horse in the race on this one.

-Evan

