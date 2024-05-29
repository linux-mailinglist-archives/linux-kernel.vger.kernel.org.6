Return-Path: <linux-kernel+bounces-193577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118478D2E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863A428AC91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363A167DA8;
	Wed, 29 May 2024 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuB82S6W"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AA167D8C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967562; cv=none; b=BCwVfy5ILGWTSjJTUxnfLAfgejSv9IBD39RmA2BFTIo9LjHgPX5iAO23EG3tNIk0UnBzj6u9N2myekjZRp1slFB+Njvbc/MaaI94bm4mNdmsrjIXhsctxHdLgXmvbfIIqt66Ep8OJA+Jm4T1PY65TL/NHajvUVbkmrz3roWL9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967562; c=relaxed/simple;
	bh=ZEVr1l/zLyARsxNs4P1butY5hWf3rmFo/maylE+sV1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgugjIHpaqCKDzO65MEcIBcfdhCGeM/lC1wDvWWya5myTIPlYw8Rqj1uJ+FauSnDjjIOqpbjUUbySXQ5ffXtroys3aZpxx6KiQVmZAsHfrEtYABnNkSvu3Q3X+GkE3UKWouD4sZ1yA2YeArEKZuvcSFwYnlHbPeLFg5zf6MUZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuB82S6W; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-804e3292412so517162241.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716967560; x=1717572360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nWzvmzN7ijIbCBaVTu7XEGtPfeKO3l3ACHDt/WVaHXI=;
        b=LuB82S6WQmX44POw5vy077+mYh3OFYpuPrUd48BRtutR+Fv41w1B1iTjjWm9ifBLGE
         BkNWDaRBxaRY9uvPcMACM7CB8wvcmenkrHVkP+PB/UrfvfvcGynn43/w3IEqLYV4ZTPE
         GFpnPRcjiddqBbZtS01emkha/YOZUK6IkdxWwcxwMR39sRqNILsndHEjqyzyYvYmfvxA
         XqD3+mZzQGUAdt3ezRk9IOsQbYIc0eStARi2FOGIARCsWlhT8yqbDz+7V6hyLPFmMY3I
         F7SE0FTzjEqmum0pL9TYnTw0nU8LE7sl0IgStUgHmzdaXSlxpuow4ZxIHIjdSigsE3UJ
         NJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716967560; x=1717572360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWzvmzN7ijIbCBaVTu7XEGtPfeKO3l3ACHDt/WVaHXI=;
        b=o21K/gjLmVLYJs1Lo8PSM3PM2OmsV2J2dai/y1y+xeqigMeL4E3qQli0s0Y6msOpjW
         WrD0mSWIH9SIiq/3Zs21gyh0Cy/EwlNFK6LV64EYNGrEt7ydjG4Uhfy6c9rtt3qCC/NL
         hh1ImSGtNGtUbhVGVfOI2JJdkeciszY0P7eGJ5jJYwtk3ivrkl4uHOv28jig5RH6K96T
         zeLQbKyluE3kQGup6BHx3l/hNeEpeMyNCOwYIfoki6ppBXaHfiQiqz47uGfN1tlwcSx0
         +HFgXjK9+0YsYM4dPuy/GTVF/VaiXTJofK+tPhFGXAZg3+Sr2lWLj0GuXPDpvrjfm8Y1
         /anA==
X-Forwarded-Encrypted: i=1; AJvYcCUPCiMx15q1d2vRYkUpVMJBfIqhS5NAxSUzPnwnrkETCwW4NlXZGTwR8s15TYJMHoUxavbyG6ih4xkeaE5d+A9NaB4rhj0vy1E4mOio
X-Gm-Message-State: AOJu0Yy9tuUNekrjj8izsYFBlXhcxjYbiclJ4jx9YfZn0C7WnoN7xNHm
	L3OnnZ/7q3TPcGt3mUEibG+IDOWgYZ8FURVxCKfT6fe1RRPatO3JN5CoS9FtUKD0lTgZCeVwBjw
	PgMZOuTRJ0kaUWSziqVtTC6FrQ7oaBZwTC/67
X-Google-Smtp-Source: AGHT+IFkhX+U8E/UmnrduSNww5O5l+Jhyabcq43rO3oLokyOCkCQOrAis9BA94QiL3EC3pI8usLyYmJe1k/GKdnaMP4=
X-Received: by 2002:a67:f4c7:0:b0:47c:2c84:4321 with SMTP id
 ada2fe7eead31-48a38575d3cmr13715697137.16.1716967560033; Wed, 29 May 2024
 00:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
In-Reply-To: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 29 May 2024 09:25:21 +0200
Message-ID: <CANpmjNM2S2whk31nfNGSBO5MFPPUHX7FPuHBJn1nN9zdP63xTw@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: Enable UBSAN traps on x86
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 04:20, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
[...]
>         if (regs->flags & X86_EFLAGS_IF)
>                 raw_local_irq_enable();
> -       if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> -           handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> -               regs->ip += LEN_UD2;
> -               handled = true;
> +
> +       if (insn == INSN_UD2) {
> +               if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> +               handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> +                       regs->ip += LEN_UD2;
> +                       handled = true;
> +               }
> +       } else {
> +               if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {

handle_ubsan_failure currently only returns BUG_TRAP_TYPE_NONE?

> +                       if (insn == INSN_REX)
> +                               regs->ip += LEN_REX;
> +                       regs->ip += LEN_UD1;
> +                       handled = true;
> +               }
>         }
>         if (regs->flags & X86_EFLAGS_IF)
>                 raw_local_irq_disable();
> diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> new file mode 100644
> index 000000000000..6cae11f4fe23
> --- /dev/null
> +++ b/arch/x86/kernel/ubsan.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clang Undefined Behavior Sanitizer trap mode support.
> + */
> +#include <linux/bug.h>
> +#include <linux/string.h>
> +#include <linux/printk.h>
> +#include <linux/ubsan.h>
> +#include <asm/ptrace.h>
> +#include <asm/ubsan.h>
> +
> +/*
> + * Checks for the information embedded in the UD1 trap instruction
> + * for the UB Sanitizer in order to pass along debugging output.
> + */
> +enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
> +{
> +       u32 type = 0;
> +
> +       if (insn == INSN_REX) {
> +               type = (*(u16 *)(regs->ip + LEN_REX + LEN_UD1));
> +               if ((type & 0xFF) == 0x40)
> +                       type = (type >> 8) & 0xFF;
> +       } else {
> +               type = (*(u16 *)(regs->ip + LEN_UD1));
> +               if ((type & 0xFF) == 0x40)
> +                       type = (type >> 8) & 0xFF;
> +       }
> +       pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> +
> +       return BUG_TRAP_TYPE_NONE;
> +}

Shouldn't this return BUG_TRAP_TYPE_WARN?

