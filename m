Return-Path: <linux-kernel+bounces-219410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A390CF72
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5621F226A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DAC146D6D;
	Tue, 18 Jun 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FcOmgANj"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D081482E0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714902; cv=none; b=iWeb0r/DVJj11XAmmB/tjczk3b9nFEK9Do+QrP1PQZM1W/RPLQJs/wiw9LQR9mie4GoSPBVVHLP5RNZlgzsEAQJ2QAe2EtCYvuIZHjTDS7trOLxOxW+LbuqgSVVHkrrzfAq4nQM5xnCv08lJaIyCMVOeMwZ09p754VxIJY+upqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714902; c=relaxed/simple;
	bh=ksera+MvCGLkmZsGgcf7HOutrMKMptffJlWOBKKx0mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNfAmINSyI5cgK1WEg645ddWD9tW7KdJWuwq30qpMLUsU+w/2YTmTh4azSYcgfosm5700DPnWa5Ee6+ZXznqhVz9PDBDTaLvKfHeC4kCUH256JQjXUY0h5NEDTp6gLcfcGs1BeEFbSwkb97Wk7+hYId4nNvRj6R3G/Ie7X+fxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FcOmgANj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-627efad69b4so51564537b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718714898; x=1719319698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIcPrOxUoAan6dIUBXvWcyPskrBywmsY3GEPQkUXEAw=;
        b=FcOmgANjq37NLK49+L4tEbcCLawDEd16iyM1DXw6kUNixtoEbBONZh33jdOQKYe0Y9
         wGOprkPZcHakH5FBlUJrigq8e8cq9GEAmSbWSrFn4Vi6jzdFuzZQOAIFCA6vbtpfTSuA
         P+bWj9E3U+Ca3xCyslS4kXWKo3anhHvuG3hNNXCH5/XpUjEtQBAFBGWUz/Xr7RoyRRDB
         e1U8cIuAbZHBaBURsukWGqjECdIxJkBEQ49tS519BXXVYXZsFQ9bMN7NYUzC4WDBmXFo
         NF/0VqPYGRBzHhd2kyhWo4ssV6cghnEuKosugPly2ib3b+4Cppm8ltkWRkIuFKn/qoev
         Roxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714898; x=1719319698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIcPrOxUoAan6dIUBXvWcyPskrBywmsY3GEPQkUXEAw=;
        b=o27fDOFsAwx1qRuGggdEzgtERwI53cMkRV2Yt72dlCtqa1TuEKv5YNbwnvw1+0vBsn
         qALBA6IJ7oDnAn1MTMcv65hoama+tOFD6XVMGtsGiNM8xXU56yhk9Sm3TgNkzEQZPxfl
         3Y23qz39loMVyYeycEYhv57FenblkiDw48ItVCOvlqOVIJdydwajFFRU2YU5am8S5173
         NdCq1ePBa8KuNpTrjdKC/JfYbeW0/oDAlKsx7v+Tbk1Fl+TIeyr968w8+uyv8Q/QK8M6
         Kmrzvxkv1NrvVlWdWJeQiA6BlwFma/OAGXJx9tku65bZnrZWaxRzh2LsHdKGnjtlzL2p
         gIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnOd2wkO50vP1tTFrmGR8TMT4aIWXLI9hxEHTkRZjpqAjtjM8xJSHP41mQSw8qrfDBdxQOrsfT5F4wCC7QR68at5RCCQ7vAuEhgCLL
X-Gm-Message-State: AOJu0YwtEf+JSc45wQDw80DxTlhsNuIO4u2oe8WlREtP7sJWN9gIjDGj
	qDSZRpniXLI/HgBJXBca0rDFx1osQ3VCUF+wwA4Mjo31IiIqJbeD64JV1IfAJeFX7zd8ECngWA7
	SC2Wv6MhyBYvsnW0TMU57Vr9uDSvnnAJ8xrzo0A==
X-Google-Smtp-Source: AGHT+IHh3PqfVGQrdjC08Nz0RGr+juvQA7r7ImVHIo98bpQtOjT0tMi393AsVW5nWfrmxjyddCWSARYSQ5l6cSjDfcc=
X-Received: by 2002:a0d:ce84:0:b0:61a:cea1:3c63 with SMTP id
 00721157ae682-63224cfd73emr101234817b3.47.1718714898553; Tue, 18 Jun 2024
 05:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
 <20240613-lubricant-breath-061192a9489a@wendy> <a396c024-f1a8-4636-85ee-e36950a2dca0@ghiti.fr>
 <b603c8b5-3100-4ccf-b014-9274f980358d@ghiti.fr>
In-Reply-To: <b603c8b5-3100-4ccf-b014-9274f980358d@ghiti.fr>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Tue, 18 Jun 2024 20:48:06 +0800
Message-ID: <CABgGipU1tjFAJ+KD7fFabVmLoqNtmQagn2sREHVzZCZ3OxozzQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Conor Dooley <conor.dooley@microchip.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrea Parri <parri.andrea@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:02=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Conor,
>
> On 17/06/2024 15:23, Alexandre Ghiti wrote:
> > Hi Conor,
> >
> > Sorry for the delay here.
> >
> > On 13/06/2024 09:48, Conor Dooley wrote:
> >> On Thu, May 23, 2024 at 01:51:34PM +0200, Alexandre Ghiti wrote:
> >>> Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
> >>> converted ftrace_make_nop() to use patch_insn_write() which does not
> >>> emit any icache flush relying entirely on __ftrace_modify_code() to d=
o
> >>> that.
> >>>
> >>> But we missed that ftrace_make_nop() was called very early directly
> >>> when
> >>> converting mcount calls into nops (actually on riscv it converts 2B
> >>> nops
> >>> emitted by the compiler into 4B nops).
> >>>
> >>> This caused crashes on multiple HW as reported by Conor and Bj=C3=B6r=
n since
> >>> the booting core could have half-patched instructions in its icache
> >>> which would trigger an illegal instruction trap: fix this by emitting=
 a
> >>> local flush icache when early patching nops.
> >>>
> >>> Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used")
> >>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>> ---
> >>>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
> >>>   arch/riscv/kernel/ftrace.c          | 3 +++
> >>>   2 files changed, 9 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/include/asm/cacheflush.h
> >>> b/arch/riscv/include/asm/cacheflush.h
> >>> index dd8d07146116..ce79c558a4c8 100644
> >>> --- a/arch/riscv/include/asm/cacheflush.h
> >>> +++ b/arch/riscv/include/asm/cacheflush.h
> >>> @@ -13,6 +13,12 @@ static inline void local_flush_icache_all(void)
> >>>       asm volatile ("fence.i" ::: "memory");
> >>>   }
> >>>   +static inline void local_flush_icache_range(unsigned long start,
> >>> +                        unsigned long end)
> >>> +{
> >>> +    local_flush_icache_all();
> >>> +}
> >>> +
> >>>   #define PG_dcache_clean PG_arch_1
> >>>     static inline void flush_dcache_folio(struct folio *folio)
> >>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> >>> index 4f4987a6d83d..32e7c401dfb4 100644
> >>> --- a/arch/riscv/kernel/ftrace.c
> >>> +++ b/arch/riscv/kernel/ftrace.c
> >>> @@ -120,6 +120,9 @@ int ftrace_init_nop(struct module *mod, struct
> >>> dyn_ftrace *rec)
> >>>       out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> >>>       mutex_unlock(&text_mutex);
> >> So, turns out that this patch is not sufficient. I've seen some more
> >> crashes, seemingly due to initialising nops on this mutex_unlock().
> >> Palmer suggested moving the if (!mod) ... into the lock, which fixed
> >> the problem for me.
> >
> >
> > Ok, it makes sense, I completely missed that. I'll send a fix for that
> > shortly so that it can be merged in rc5.
> >
> > Thanks,
> >
> > Alex
>
>
> So I digged a bit more and I'm afraid that the only way to make sure
> this issue does not happen elsewhere is to flush the icache right after
> the patching. We actually can't wait to batch the icache flush since
> along the way, we may call a function that has just been patched (the
> issue that you encountered here).

Trying to provide my thoughts, please let me know if I missed
anything. I think what Conor suggested is safe for init_nop, as it
would be called only when there is only one core (booting) and at the
loading stage of kernel modules. In the first case we just have to
make sure there is no patchable entry before the core executes
fence.i. The second case is unconditionally safe because there is no
read-side of the race.

It is a bit tricky for the generic (runtime) case of ftrace code
patching, but that is not because of the batch fence.i maintenance. As
long as there exists a patchable entry for the stopping thread, it is
possible for them to execute on a partially patched instruction. A
solution for this is again to prevent any patchable entry in the
stop_machine's stopping thread. Another solution is to apply the
atomic ftrace patching series which aims to get rid of the race.

>
> I don't know how much it will impact the performance but I guess it will.
>
> Unless someone has a better idea (I added Andy and Puranjay in cc), here
> is the patch that implements this, can you give it a try? Thanks
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 87cbd86576b2..4b95c574fd04 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct
> dyn_ftrace *rec)
>          out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>          mutex_unlock(&text_mutex);
>
> -       if (!mod)
> -               local_flush_icache_range(rec->ip, rec->ip +
> MCOUNT_INSN_SIZE);
> -
>          return out;
>   }
>
> @@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
>          } else {
>                  while (atomic_read(&param->cpu_count) <=3D num_online_cp=
us())
>                          cpu_relax();
> -       }
>
> -       local_flush_icache_all();
> +               local_flush_icache_all();
> +       }
>
>          return 0;
>   }
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 4007563fb607..ab03732d06c4 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t l=
en)
>
>          memset(waddr, c, len);
>
> +       /*
> +        * We could have just patched a function that is about to be
> +        * called so make sure we don't execute partially patched
> +        * instructions by flushing the icache as soon as possible.
> +        */
> +       local_flush_icache_range((unsigned long)waddr,
> +                                (unsigned long)waddr + len);
> +
>          patch_unmap(FIX_TEXT_POKE0);
>
>          if (across_pages)
> @@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const
> void *insn, size_t len)
>
>          ret =3D copy_to_kernel_nofault(waddr, insn, len);
>
> +       /*
> +        * We could have just patched a function that is about to be
> +        * called so make sure we don't execute partially patched
> +        * instructions by flushing the icache as soon as possible.
> +        */
> +       local_flush_icache_range((unsigned long)waddr,
> +                                (unsigned long)waddr + len);
> +
>          patch_unmap(FIX_TEXT_POKE0);
>
>          if (across_pages)
> @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t le=
n)
>
>          ret =3D patch_insn_set(tp, c, len);
>
> -       if (!ret)
> -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> -
>          return ret;
>   }
>   NOKPROBE_SYMBOL(patch_text_set_nosync);
> @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns,
> size_t len)
>
>          ret =3D patch_insn_write(tp, insns, len);
>
> -       if (!ret)
> -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> -
>          return ret;
>   }
>   NOKPROBE_SYMBOL(patch_text_nosync);
> @@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
>          } else {
>                  while (atomic_read(&patch->cpu_count) <=3D num_online_cp=
us())
>                          cpu_relax();
> -       }
>
> -       local_flush_icache_all();
> +               local_flush_icache_all();
> +       }
>
>          return ret;
>   }
>
>
> >
> >
> >>
> >>>   +    if (!mod)
> >>> +        local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE=
);
> >>> +
> >>>       return out;
> >>>   }
> >>>   --
> >>> 2.39.2
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Cheers,
Andy

