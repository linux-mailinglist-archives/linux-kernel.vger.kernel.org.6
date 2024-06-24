Return-Path: <linux-kernel+bounces-227156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90723914927
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE60280F06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E3132130;
	Mon, 24 Jun 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LJICEpEk"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1F137904
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229794; cv=none; b=TBoa+lOncbEFyq7lzpPf/4ecLaydpDFgzOtUkVRlVpKvRLy080BJDiu+wr9PTSXC73cSn2iiXYgfOfJ/1lzynkOrd10cj/qMdkmAHIS8nsbzSt4bz7b2dno+61qZ9TDlz8jovPoZZCaccV0sX8kGCi3Nu5a5QIFfKTHtOmXb+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229794; c=relaxed/simple;
	bh=RlYVDlZja+6rZP5BTG6snFkXYSrb+JuGGHvj19by53o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0pMSaw4cVLW+do/e7/zBSeyNcHVDupkRqzre5tXInWJCFqYcdJBfPbafT8354HZCB+cf6n7y/GJZ0Eon1LvgWCN4vbChOVr42ayJr7+xEHW7DVazuOFPzqejuSf8CDXYs/dSScuOZ33e/jJFwjeG+yFjBEpEwndGLsI7mqQCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LJICEpEk; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64546605546so6509617b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719229792; x=1719834592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd5I5Sm5SEEI9bJESKa04ZiDJHwtLURV9qvtnPEr1Cw=;
        b=LJICEpEklun5dGEHwjyIq0HG52//n6h6gch4F3uqI5vkDjfF8r1zNMCcuodHCwDqyQ
         bb2p4pFBo18KjahmegoAo/K2KM9VlQUp96CYnYvlEYf2Wz/a/WOtteATsvzgbgMSWwzz
         8jgWK5wrwA5RTk2Uu74dnD6RL9+nrPcr7CLV1MPa2Pc5d2xhIO1VdQgYcRAICUNw1X04
         JxWnkBk35rVmE9UGJ7/uGlvo6PeWE3ySGsRY/frvNOsEw34JKT7V+5fSQcpkJ7/VVcnd
         UtUV6y2ulYXEtPkoLR7jfqdn7ug7aWjMCdCXz9Z2hME7hD4aV507dUAxeVFfDlHs2HT5
         eQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229792; x=1719834592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd5I5Sm5SEEI9bJESKa04ZiDJHwtLURV9qvtnPEr1Cw=;
        b=saZWNAxiMC5bUvoEZTDRXaLDVuhwp+JJLXDu4Cg3SxaSOQvNVNnOJRVF2uSFT/vSn9
         iXapQmxKPmy5YRCs7BRX/aXLG8UKshFhh38+YyHFz63GVNn8lfo4P+oAUgIP/vwwBMOB
         2c6je9kFZEimKFWwMR6LqUNNyV0m1jdw7SrzzTeiU+8yfMZpXD/9HZvq0awdsBN0dY10
         yjL5zxVpIPJRZZt3xfNlsSXsQiLRO0MAEDlbgisT/t/9pWP666hM6LiIolF73vdDYbA2
         Nj8+BmwpCNMDArZAJaiRHSN8PPOSVn41v+FqmmQbB1FT63bllmvjKmsymToUQ9x57bPT
         xK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjmdzodQ7DIbZOfm5x/GE3LsdOsCTobEVHMU1g+YjdR2a+wyplT15OpZto34jcHWu0h5RmxbV80UsVVaqT7LojIkWpim86+o/CB2Pu
X-Gm-Message-State: AOJu0YxCB6BgT2Cp+MdeeJnMX2MWtWHTwM/fOBzRjZpGpSRBSCUD0O5f
	vj9b869M0w5+KdpoJ4s9VFZcV+0Cm1Fu8yXEg/RTyUZbxVBh3Ukyp/hQuWbm4n0A79aPuAuLae0
	MjgujMCILRWgERepevjqTyZYAVTI5yv4HC48M8g==
X-Google-Smtp-Source: AGHT+IGJjTrlmcRbQh6/kbNdxg9y/Oeu+nWF3lYXzODXDhrNFp8r1QHIEdwFpED/HofduNZ7d6h1p7TJUAIO6YF8oeQ=
X-Received: by 2002:a81:9288:0:b0:62c:efa2:a091 with SMTP id
 00721157ae682-643aaa88c36mr39059547b3.14.1719229792054; Mon, 24 Jun 2024
 04:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082141.153871-1-alexghiti@rivosinc.com>
In-Reply-To: <20240624082141.153871-1-alexghiti@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 24 Jun 2024 19:49:41 +0800
Message-ID: <CABgGipXR6ETkH0w-8GG8uBtKbG5jvD0VHz-A-VnXFPgvqrd6Lw@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: patch: Flush the icache right after
 patching to avoid illegal insns
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Mon, Jun 24, 2024 at 4:21=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> We cannot delay the icache flush after patching some functions as we may
> have patched a function that will get called before the icache flush.
>
> The only way to completely avoid such scenario is by flushing the icache
> as soon as we patch a function. This will probably be costly as we don't
> batch the icache maintenance anymore.
>
> Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-061=
192a9489a@wendy/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/ftrace.c |  7 ++-----
>  arch/riscv/kernel/patch.c  | 26 ++++++++++++++++++--------
>  2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 87cbd86576b2..4b95c574fd04 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct dyn_ft=
race *rec)
>         out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>         mutex_unlock(&text_mutex);
>
> -       if (!mod)
> -               local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_S=
IZE);
> -
>         return out;
>  }
>
> @@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
>         } else {
>                 while (atomic_read(&param->cpu_count) <=3D num_online_cpu=
s())
>                         cpu_relax();
> -       }
>
> -       local_flush_icache_all();
> +               local_flush_icache_all();
> +       }

Sorry, maybe I should point it out directly earlier. But I don't think
this diff chunk is required. Threads running in the else clause from
stop_machine must not run into any patchable entry. If it runs into a
patchable entry, running the local fence.i is not going to fix the
problem.

>
>         return 0;
>  }
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 4007563fb607..ab03732d06c4 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t l=
en)
>
>         memset(waddr, c, len);
>
> +       /*
> +        * We could have just patched a function that is about to be
> +        * called so make sure we don't execute partially patched
> +        * instructions by flushing the icache as soon as possible.
> +        */
> +       local_flush_icache_range((unsigned long)waddr,
> +                                (unsigned long)waddr + len);
> +
>         patch_unmap(FIX_TEXT_POKE0);
>
>         if (across_pages)
> @@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const void=
 *insn, size_t len)
>
>         ret =3D copy_to_kernel_nofault(waddr, insn, len);
>
> +       /*
> +        * We could have just patched a function that is about to be
> +        * called so make sure we don't execute partially patched
> +        * instructions by flushing the icache as soon as possible.
> +        */
> +       local_flush_icache_range((unsigned long)waddr,
> +                                (unsigned long)waddr + len);
> +
>         patch_unmap(FIX_TEXT_POKE0);
>
>         if (across_pages)
> @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t le=
n)
>
>         ret =3D patch_insn_set(tp, c, len);
>
> -       if (!ret)
> -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> -
>         return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_set_nosync);
> @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns, =
size_t len)
>
>         ret =3D patch_insn_write(tp, insns, len);
>
> -       if (!ret)
> -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> -
>         return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_nosync);
> @@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
>         } else {
>                 while (atomic_read(&patch->cpu_count) <=3D num_online_cpu=
s())
>                         cpu_relax();
> -       }
>
> -       local_flush_icache_all();
> +               local_flush_icache_all();
> +       }
>
>         return ret;
>  }
> --
> 2.39.2
>

Thanks,
Andy

