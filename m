Return-Path: <linux-kernel+bounces-219495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A890D36C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0571C25193
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A728176AC4;
	Tue, 18 Jun 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AtMdRLPc"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9601581EF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718007; cv=none; b=dBb6u+xfi5wgmhLO345ToHvcfo6ufLbSzYXEa3SzLO8SFEj/wolHoadmjsWNWMYtWfKXQmsUOc4wJ3xtkmn7vp+YS3OiXeHwWYZHxhxmSkGSw/Q6VHpBZf9K9roRQCE2BHLal6LhWdG1tMnLjI8ky34QW2IIEMOVJai/GNtQs+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718007; c=relaxed/simple;
	bh=H82z32O2yHdm8vqwDNU7pe4dacQBdHLnGv4gD2NVoVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZpNNpbVNKAuscD5eSi/FjUCVyGJsKPB/Ni5FCg6dRy13ZlnGoypjfUTMf2dJg1XXE81XStOKI/MxbAtk/Kvps4rS55FCABTSy/Fbzyf7TVqTmOjXfi0eWn5ikroiEhtwDxRSDZEdpG5AGZz2/w+SVfKFb5xe4uA/QDCdbq71Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AtMdRLPc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso7317233a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718718001; x=1719322801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OybYax2XUKD8sZSAM1v28ZzgWRpTdVnQBHwmcaOm7a0=;
        b=AtMdRLPcgL3MnbILgfG4ebRRNCQdOsHRgdC7P1kMN8MpnY/8fSnQxw54fUxzeWWTSL
         nHO7PHMZOwZ0yDZxxBr9RrszOMbDfrHDq37/tR5/z3oR8LGdTSA1+C2LHtvvN2VcHYxD
         /bN9wFv8htEEPa9rIqF4ZjAy+gDNked0Z2DnODQexTcukdtdSgijEaGgQGwggcpjexEd
         maXwuXoPW2lEdcB4tfWrd1Nnz5xbgX0gjBhwi74Rz5sI181NMrnbLJb2q/1LZPj4V76w
         4PUW1zu4fYSUsk/dhCBiYXS0PPB2gjZ7M4nWaG9SoM+qFxCj72NLcmK+jUrntza/8Y6m
         oFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718001; x=1719322801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OybYax2XUKD8sZSAM1v28ZzgWRpTdVnQBHwmcaOm7a0=;
        b=VD16TC/Be5H86HzGEGqaHtImem5+kEH9kZY2nt636pcC8Nn3kbs4ZwTvTLSRTsNezr
         YAcBc4nZyYMUxUsD2ucDKIrh23t1TT5K4Mf9cRIqBJoz2wQHgivFsR/fpIAR8o10yw6t
         vXrAP9DTioe4Kg5tJtuk2v95+5R7pQCcTWSdjIQFPB2D3xmqtqbDq2FcuLwxhQcXqLoX
         orH6fhfp756fT7gm7XEezzaMahR563adfQIummbJPEgKc5Yq7RlKYE15ribafL1OtM3k
         6+kCBQmKh1vQx5R88ncGLRXJqJRDKLS+NceeF8UeFMToNbfiBaAD8CVwmB1H10EetQtK
         /Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCVkDC1TQNQILL19+S53Y6cL/DNlyQwHt1L8z8qoG/xuZ+jWOcTzdfBc5P2lhoJnfAJXnbwdXR9B5+bllsQONoTvDPPKuLhipYqZdwAs
X-Gm-Message-State: AOJu0Yway216wKU+r/qdvtlYP/FCcEQnTpjb6TSAwU8rdVtjlxCmncA3
	auVVB/jh5iI7yU8w/zEKm7NRfVuTFfvlZLqTHsawxgpMDNjayJmO0xEN9El8joFJ1wPMIEo8Hlf
	STzEo2rKJu+TykBCyyTeOAOeDDRmCYqFrYZHm4w==
X-Google-Smtp-Source: AGHT+IFY862EhWx7LFAElilFYsa6wCTSoz2pWPLSrwmdwpjNwAgWcRugQCGO0gfO7+X+maTu0dEBU+hI25zCn0Guh6I=
X-Received: by 2002:a50:99d2:0:b0:57c:5637:b2ae with SMTP id
 4fb4d7f45d1cf-57cbd69dc7emr7442272a12.12.1718718001368; Tue, 18 Jun 2024
 06:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
 <20240613-lubricant-breath-061192a9489a@wendy> <a396c024-f1a8-4636-85ee-e36950a2dca0@ghiti.fr>
 <b603c8b5-3100-4ccf-b014-9274f980358d@ghiti.fr> <CABgGipU1tjFAJ+KD7fFabVmLoqNtmQagn2sREHVzZCZ3OxozzQ@mail.gmail.com>
In-Reply-To: <CABgGipU1tjFAJ+KD7fFabVmLoqNtmQagn2sREHVzZCZ3OxozzQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 18 Jun 2024 15:39:50 +0200
Message-ID: <CAHVXubiubf9oCHnFco19SReZRPELYJSRtZmwEnGQLR++N+aH-g@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor.dooley@microchip.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrea Parri <parri.andrea@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, Jun 18, 2024 at 2:48=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> On Tue, Jun 18, 2024 at 8:02=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > Hi Conor,
> >
> > On 17/06/2024 15:23, Alexandre Ghiti wrote:
> > > Hi Conor,
> > >
> > > Sorry for the delay here.
> > >
> > > On 13/06/2024 09:48, Conor Dooley wrote:
> > >> On Thu, May 23, 2024 at 01:51:34PM +0200, Alexandre Ghiti wrote:
> > >>> Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
> > >>> converted ftrace_make_nop() to use patch_insn_write() which does no=
t
> > >>> emit any icache flush relying entirely on __ftrace_modify_code() to=
 do
> > >>> that.
> > >>>
> > >>> But we missed that ftrace_make_nop() was called very early directly
> > >>> when
> > >>> converting mcount calls into nops (actually on riscv it converts 2B
> > >>> nops
> > >>> emitted by the compiler into 4B nops).
> > >>>
> > >>> This caused crashes on multiple HW as reported by Conor and Bj=C3=
=B6rn since
> > >>> the booting core could have half-patched instructions in its icache
> > >>> which would trigger an illegal instruction trap: fix this by emitti=
ng a
> > >>> local flush icache when early patching nops.
> > >>>
> > >>> Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used")
> > >>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > >>> ---
> > >>>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
> > >>>   arch/riscv/kernel/ftrace.c          | 3 +++
> > >>>   2 files changed, 9 insertions(+)
> > >>>
> > >>> diff --git a/arch/riscv/include/asm/cacheflush.h
> > >>> b/arch/riscv/include/asm/cacheflush.h
> > >>> index dd8d07146116..ce79c558a4c8 100644
> > >>> --- a/arch/riscv/include/asm/cacheflush.h
> > >>> +++ b/arch/riscv/include/asm/cacheflush.h
> > >>> @@ -13,6 +13,12 @@ static inline void local_flush_icache_all(void)
> > >>>       asm volatile ("fence.i" ::: "memory");
> > >>>   }
> > >>>   +static inline void local_flush_icache_range(unsigned long start,
> > >>> +                        unsigned long end)
> > >>> +{
> > >>> +    local_flush_icache_all();
> > >>> +}
> > >>> +
> > >>>   #define PG_dcache_clean PG_arch_1
> > >>>     static inline void flush_dcache_folio(struct folio *folio)
> > >>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.=
c
> > >>> index 4f4987a6d83d..32e7c401dfb4 100644
> > >>> --- a/arch/riscv/kernel/ftrace.c
> > >>> +++ b/arch/riscv/kernel/ftrace.c
> > >>> @@ -120,6 +120,9 @@ int ftrace_init_nop(struct module *mod, struct
> > >>> dyn_ftrace *rec)
> > >>>       out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> > >>>       mutex_unlock(&text_mutex);
> > >> So, turns out that this patch is not sufficient. I've seen some more
> > >> crashes, seemingly due to initialising nops on this mutex_unlock().
> > >> Palmer suggested moving the if (!mod) ... into the lock, which fixed
> > >> the problem for me.
> > >
> > >
> > > Ok, it makes sense, I completely missed that. I'll send a fix for tha=
t
> > > shortly so that it can be merged in rc5.
> > >
> > > Thanks,
> > >
> > > Alex
> >
> >
> > So I digged a bit more and I'm afraid that the only way to make sure
> > this issue does not happen elsewhere is to flush the icache right after
> > the patching. We actually can't wait to batch the icache flush since
> > along the way, we may call a function that has just been patched (the
> > issue that you encountered here).
>
> Trying to provide my thoughts, please let me know if I missed
> anything. I think what Conor suggested is safe for init_nop, as it
> would be called only when there is only one core (booting) and at the
> loading stage of kernel modules. In the first case we just have to
> make sure there is no patchable entry before the core executes
> fence.i. The second case is unconditionally safe because there is no
> read-side of the race.
>
> It is a bit tricky for the generic (runtime) case of ftrace code
> patching, but that is not because of the batch fence.i maintenance. As
> long as there exists a patchable entry for the stopping thread, it is
> possible for them to execute on a partially patched instruction. A
> solution for this is again to prevent any patchable entry in the
> stop_machine's stopping thread. Another solution is to apply the
> atomic ftrace patching series which aims to get rid of the race.

Yeah but my worry is that we can't make sure that functions called
between the patching and the fence.i are not the ones that just get
patched. At least today, patch_insn_write() etc should be marked as
noinstr. But even then, we call core functions that could be patchable
(I went through all and it *seems* we are safe *for now*, but this is
very fragile).

Then what do you think we should do to fix Conor's issue right now:
should we mark the riscv specific functions as noinstr, cross fingers
that the core functions are not (and don't become) patchable and wait
for your atomic patching? Or should we flush as soon as possible as I
proposed above (which to me fixes the issue but hurts performance)?

Thanks,

Alex

>
> >
> > I don't know how much it will impact the performance but I guess it wil=
l.
> >
> > Unless someone has a better idea (I added Andy and Puranjay in cc), her=
e
> > is the patch that implements this, can you give it a try? Thanks
> >
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index 87cbd86576b2..4b95c574fd04 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct
> > dyn_ftrace *rec)
> >          out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> >          mutex_unlock(&text_mutex);
> >
> > -       if (!mod)
> > -               local_flush_icache_range(rec->ip, rec->ip +
> > MCOUNT_INSN_SIZE);
> > -
> >          return out;
> >   }
> >
> > @@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
> >          } else {
> >                  while (atomic_read(&param->cpu_count) <=3D num_online_=
cpus())
> >                          cpu_relax();
> > -       }
> >
> > -       local_flush_icache_all();
> > +               local_flush_icache_all();
> > +       }
> >
> >          return 0;
> >   }
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 4007563fb607..ab03732d06c4 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t=
 len)
> >
> >          memset(waddr, c, len);
> >
> > +       /*
> > +        * We could have just patched a function that is about to be
> > +        * called so make sure we don't execute partially patched
> > +        * instructions by flushing the icache as soon as possible.
> > +        */
> > +       local_flush_icache_range((unsigned long)waddr,
> > +                                (unsigned long)waddr + len);
> > +
> >          patch_unmap(FIX_TEXT_POKE0);
> >
> >          if (across_pages)
> > @@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const
> > void *insn, size_t len)
> >
> >          ret =3D copy_to_kernel_nofault(waddr, insn, len);
> >
> > +       /*
> > +        * We could have just patched a function that is about to be
> > +        * called so make sure we don't execute partially patched
> > +        * instructions by flushing the icache as soon as possible.
> > +        */
> > +       local_flush_icache_range((unsigned long)waddr,
> > +                                (unsigned long)waddr + len);
> > +
> >          patch_unmap(FIX_TEXT_POKE0);
> >
> >          if (across_pages)
> > @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t =
len)
> >
> >          ret =3D patch_insn_set(tp, c, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> > -
> >          return ret;
> >   }
> >   NOKPROBE_SYMBOL(patch_text_set_nosync);
> > @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns=
,
> > size_t len)
> >
> >          ret =3D patch_insn_write(tp, insns, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len=
);
> > -
> >          return ret;
> >   }
> >   NOKPROBE_SYMBOL(patch_text_nosync);
> > @@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
> >          } else {
> >                  while (atomic_read(&patch->cpu_count) <=3D num_online_=
cpus())
> >                          cpu_relax();
> > -       }
> >
> > -       local_flush_icache_all();
> > +               local_flush_icache_all();
> > +       }
> >
> >          return ret;
> >   }
> >
> >
> > >
> > >
> > >>
> > >>>   +    if (!mod)
> > >>> +        local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SI=
ZE);
> > >>> +
> > >>>       return out;
> > >>>   }
> > >>>   --
> > >>> 2.39.2
> > >>>
> > >>>
> > >>> _______________________________________________
> > >>> linux-riscv mailing list
> > >>> linux-riscv@lists.infradead.org
> > >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Cheers,
> Andy

