Return-Path: <linux-kernel+bounces-573077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0009A6D2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEAE16B3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE58946C;
	Mon, 24 Mar 2025 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LrfAmj91"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9108B2E3385
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742779837; cv=none; b=bqhzB/qOCnvXrLu9YyOn2m49TAr65VZwOppLzhhxi6LiLvbeUC2dhHh7fTZcHvvTHANaFVbxtCvFftSm7GE3WJURpsfHimcYEtxq4kQdmLZdZV7djjG6dlbPC0PFFwSjS0MM6RM1xyFXnPIwpCFUzMhUH37jJPEQEXnINqHlDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742779837; c=relaxed/simple;
	bh=AEwKglt74XZYxNCWmoW2g5Afhyuvf0b3MFRpJ7W0gLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qi2vUJIMGm5jjaXTONZmSCRbF4cOW+6oZbwJWmYHNaL6g2vKECmSD5qA0LqsPYuujOPGsrI11cxq6B2Zofu7Jhttd9ON7i9j+vNzu798K5CIVP4OSxmRQaNdX/3rWxOtbnChDwPStgRDsCz5lX6lhqpx1iBNSpIqqn1Yjn/7Aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LrfAmj91; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fa58dc37c5so2454958b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742779833; x=1743384633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHaMaSyKiahGNcCRdsRhprtY7QyJpJpkUE40EirSGDI=;
        b=LrfAmj91PtBqhRt3aGjM4mAua37DAULZLb/67wqbcipkUN5wjvczQSO2hcUBQ6kQ2w
         9uOtZ9+tCFvC0T+b49We5vt4661kocD7KLou1ODW+oaZtU6TiVffgsPaeIsBLCyQikto
         rbvCxqJDDKdomaBUvy4UuPDoV+qSeklSMOnd1NGqnXBUIKwZNPJwr6SzZed/7CakDllN
         88/bPbjbWv4n9E+8r4CoX5vOHuuOdBrBYQ9z+IZwy3e3y4AWmWHNlEsk1YqL4dGfhIww
         VurM5L0ZoSnTJT6gFSIMQa/UyYh9PqdzlaajX9WztNTkRP86eT7q03ma+az+K07jj1L7
         7M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742779833; x=1743384633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHaMaSyKiahGNcCRdsRhprtY7QyJpJpkUE40EirSGDI=;
        b=p1ujXau5f9sUvwdrynsxmpFnO/9oSLG0ffg3qt7V+/+IhghnDRJCwERVfZ2PKI4yJ6
         jt+HTsItOJMDTMs6WUA214cJiNG5qt3pdNCjaXHW1cfpZuxpMA1COssvL4h5k8bUluBB
         9a3mu7O3+y6xF3m0+I++5vISEC/ACZMaqBW7s+neX/hU2HTvuXZQ2nbAryK/V+wIR/ZL
         rEB9+ZocLmdzSTZHpmUeIpopYMHD+E5Abqv2ucOYGzs4MO9b5FQNM4rbZCOOIsa8JPiP
         uNshs+pm1VJhRU2IRbF/i53sKNOd86kS8lEVvgSU/riZo4EnklnVE+APt078fsCqJSX/
         VXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3YTs98BRpvcoGByRuTWEuYzpGletpd46NAuew3+q4cXJoejuvJQgvk1WoGgeBgHk7A8UqxFc+UWltkFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+/MuLGauQyKMhzxLlo9KMagjn92GoqryZ+0aFvCY3ln6BrOh
	X7nODLRjv4AsUmJ63Z3wneFllNhB9P/L2WMG/u9PFh/AqNpwtEmDIVYQ7K4Eu55pF+nv13wCJYw
	JEJ9LWcq1dO749hJ6yUGEMzvFiJB7kUMM+nmsPw==
X-Gm-Gg: ASbGnctdNssLy3HuiU0W2Bq2ytmTkdaVj0EEsCwh7/SI3LuvItD0EbCRbBOYv7tuY5K
	GIIZR9h4OvmOrNPPpY9mKPC8kQ1YNmxPmvnExtUUNqg+JIT1fs4yO89wWjyaLt1MpsB4jX3yO/a
	1s8ux1MgOrZ5NMCXJuWI56/Wl4Bj2+
X-Google-Smtp-Source: AGHT+IFCGxrTJrhT5MB5IOTghrbVeSGsI5XQoqx6jtpjztRs6A8CS68jdaM9ZFZEnhypc3g0B8SAFNDAdFEbCLeVMjs=
X-Received: by 2002:a05:6808:6b48:b0:3f4:bc5:d47a with SMTP id
 5614622812f47-3febee94fbemr7494467b6e.13.1742779833340; Sun, 23 Mar 2025
 18:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320084428.51151-1-cuiyunhui@bytedance.com> <9256ca10-323d-41b4-b935-5281f925d50c@app.fastmail.com>
In-Reply-To: <9256ca10-323d-41b4-b935-5281f925d50c@app.fastmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 24 Mar 2025 09:30:22 +0800
X-Gm-Features: AQ5f1JqdDkB23zUxFSv44PCGpKGeQD7bhYahZkOrkx_S49DgGP7FcuHlvQMshis
Message-ID: <CAEEQ3wk95SMxbKQqD08ACaErG9bvUNQ9QOK6KsZSc5xGHRj+pQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: introduce the ioremap_prot() function
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Nam Cao <namcao@linutronix.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Stuart Menefy <stuart.menefy@codasip.com>, Xu Lu <luxu.kernel@bytedance.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dawei Li <dawei.li@shingroup.cn>, 
	Mike Rapoport <rppt@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,


On Thu, Mar 20, 2025 at 5:22=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Mar 20, 2025, at 09:44, Yunhui Cui wrote:
> > It's advisable to avoid mapping memory with the non-cache attribute.
> > This is because issues may arise when the same physical address is
> > mapped as both cacheable and non-cacheable simultaneously, such as
> > in the case of hardware prefetching.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> Makes sense to me. Ideally we'd have the check in generic_ioremap_prot(),
> but I believe this would break on (at least) x86 because of
> legacy callers of ioremap() on memory.
>
> > diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> > index a0e51840b9db..736c5557bd06 100644
> > --- a/arch/riscv/include/asm/io.h
> > +++ b/arch/riscv/include/asm/io.h
> > @@ -133,6 +133,8 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw=
())
> >  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer=
, count)
> >  #endif
> >
> > +#define ioremap_prot ioremap_prot
> > +
> >  #include <asm-generic/io.h>
> >
> >  #ifdef CONFIG_MMU
>
> This feels slightly wrong to me, the "#define foo foo" method
> is normally used to override a declaration or inline function with
> another one, but this one only overrides the implementation, not
> the declaration.
>
> I see the same is done on arc, arm64, parisc, powerpc, s390,
> sh and xtensa, so we can keep this one as well, but it would be
> nice to change all of these to a less surprising approach.
>
> Maybe we should just remove these macros from asm/io.h and
> the trivial wrapper from mm/ioremap.c, and instead change the
> other architectures that have GENERIC_IOREMAP to use
>
> #define ioremap_prot generic_ioremap_prot
>
> It seems this would be only csky, hexagon, (some) loongarch
> and openrisc.
>
>      Arnd

It seems that we can't simply use #define ioremap_prot
generic_ioremap_prot because some architectures have certain special
behaviors before calling generic_ioremap_prot(). For example, there's
the ioremap_prot_hook() logic on ARM64 and the CONFIG_EISA logic on
PA-RISC, among others.

Regarding the check of whether the address is a memory address, I
think we can directly incorporate pfn_valid() into
generic_ioremap_prot. This probably won't affect architectures that
directly use generic_ioremap_prot(), such as C-SKY, Hexagon, and
LoongArch.

So, my next plan is to add pfn_valid() to generic_ioremap_prot().

What's your opinion?

Thanks=EF=BC=8C
Yunhui

