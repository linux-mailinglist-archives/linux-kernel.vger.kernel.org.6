Return-Path: <linux-kernel+bounces-194783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41DF8D41FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837C1286741
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456201CB32A;
	Wed, 29 May 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a58uEDwL"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094666AB8
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717025560; cv=none; b=jCgV5iioIQDFO4Teg73B9Yib6v736kmQ+aH5GYuqJURK9ce5Dbb3OJ2Ng477yBVereEZu+t5OqVMX9JuID5HFS5bT35jT2FvNfXTG4qWJepsOpV8+tDbxSoU7hHwpJn152lbUnGEtlW390Utd9CL+9UrADj49YxTtfWS00/L+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717025560; c=relaxed/simple;
	bh=/0SdF5uqE6gzTTXQWDfWuqijnmeHpXTwYnsb4nK5NfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJJjU+5H3IS3f+JaaCgGmSeOwSHYyArl3AYDVjV2OvgjItVShjvnpHYzoLcLZ/Xmj31BSfB2P+gNKiYNNcv0kbL67xFdki7lOmOdAW+eDnVPuHpBvJ1rsgAEvpDY+ueE3sky8I88aHwiC/LYq+r8fbFbF+a/8FLazqzjkgMz/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a58uEDwL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f44b5b9de6so2593295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717025558; x=1717630358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cucV7qOoOPIUrj3G8eYL6EQD/QmFAva7FNUzBgHa+iQ=;
        b=a58uEDwLj6REAZQa20YQi97Tz1B2GRbcFDP/P7su90S4EqShgZUSsGnDpWXuvxVelJ
         0uNpL+p1Fjb33y70olYS5Ia/pJfDGUGVOzjAnTSK25hQHQZ08j4oqyn4guNk0hpJNLCd
         Vyt6vuUxoMwKoJH0WuQxPPoE6FOt4X13ARtsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717025558; x=1717630358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cucV7qOoOPIUrj3G8eYL6EQD/QmFAva7FNUzBgHa+iQ=;
        b=v1hcmgdmNGvbeqdTvsMXvaSdtjN3iRqbrQugt3/dk3wWL33yPqkrk4tHMyvmewoTFg
         xIz9lciMf+kqBoKsw+qGtN21Sw/Dyd2hQmcf6JdWS4QdBujRmOpSWK1/6v2y7ayAFUhT
         1HxhxQBL+QGkeEQ9Gmbo5ZwiXscZABu7OAP0yQNr9z5jEhZo9WM/dLgCjDD/MrkseG3c
         ZpzYGqNlrnB2XNJPpVvHeuLbCtDjuj2Yw9aHiMg2f+nfygRWgrt4rzZ8WF+J52T+W5yX
         5rQR0F+DrrhvrVHyjDeIERFQJI83Lq/XkrARLpGjmLMnZ8RLNKMl/K+1d2rBOybl3Zxm
         XoiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCOlSqwtsSGu7V8YOXFKgPY07QFpxiGYKwmhUc5VRanv2AQVrFlwsbPPC/9vRoeoPMG1loZG1nGa9geQqNTQ+EO17u6r//nKjeIdZJ
X-Gm-Message-State: AOJu0YxvMw5oOvjcHKxdrgDF3/OvnlWIAFqAM5UMUH59DOXEfqfts5i0
	Ptx57MgFLlvZgemghau955x6o9lT87uTcw8/RYC2c+P3hJQCwNpSMwN58X3dbA==
X-Google-Smtp-Source: AGHT+IGrZufDO7aDrD5XQN2/A2YMhT+Y9cL7VGKbNsy++FzDVwe+PKFjUp+fb94aTS54ZMP8pq2noA==
X-Received: by 2002:a17:902:d2c1:b0:1f3:903:5c9a with SMTP id d9443c01a7336-1f619936a85mr5241125ad.58.1717025558317;
        Wed, 29 May 2024 16:32:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c99d23asm108088905ad.208.2024.05.29.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:32:37 -0700 (PDT)
Date: Wed, 29 May 2024 16:32:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Marco Elver <elver@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/traps: Enable UBSAN traps on x86
Message-ID: <202405291631.79BB8BF@keescook>
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
 <CANpmjNM2S2whk31nfNGSBO5MFPPUHX7FPuHBJn1nN9zdP63xTw@mail.gmail.com>
 <2j6nkzn2tfdwdqhoal5o56ds2hqg2sqk5diolv23l5nzteypzh@fi53ovwjjl3w>
 <CANpmjNM4pFHYRqmBLi0qUm8K2SroYWg7NFjreHffHvk0WW95kA@mail.gmail.com>
 <57vgoje4bmrckwqtwnletukcnlvjpj2yp3cjlkym4bfw66a57a@w35yjzcurcis>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57vgoje4bmrckwqtwnletukcnlvjpj2yp3cjlkym4bfw66a57a@w35yjzcurcis>

On Wed, May 29, 2024 at 01:36:39PM -0700, Gatlin Newhouse wrote:
> On Wed, May 29, 2024 at 08:30:20PM UTC, Marco Elver wrote:
> > On Wed, 29 May 2024 at 20:17, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
> > >
> > > On Wed, May 29, 2024 at 09:25:21AM UTC, Marco Elver wrote:
> > > > On Wed, 29 May 2024 at 04:20, Gatlin Newhouse <gatlin.newhouse@gmail.com> wrote:
> > > > [...]
> > > > >         if (regs->flags & X86_EFLAGS_IF)
> > > > >                 raw_local_irq_enable();
> > > > > -       if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > > > -           handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > > > -               regs->ip += LEN_UD2;
> > > > > -               handled = true;
> > > > > +
> > > > > +       if (insn == INSN_UD2) {
> > > > > +               if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > > > > +               handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> > > > > +                       regs->ip += LEN_UD2;
> > > > > +                       handled = true;
> > > > > +               }
> > > > > +       } else {
> > > > > +               if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
> > > >
> > > > handle_ubsan_failure currently only returns BUG_TRAP_TYPE_NONE?
> > > >
> > > > > +                       if (insn == INSN_REX)
> > > > > +                               regs->ip += LEN_REX;
> > > > > +                       regs->ip += LEN_UD1;
> > > > > +                       handled = true;
> > > > > +               }
> > > > >         }
> > > > >         if (regs->flags & X86_EFLAGS_IF)
> > > > >                 raw_local_irq_disable();
> > > > > diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> > > > > new file mode 100644
> > > > > index 000000000000..6cae11f4fe23
> > > > > --- /dev/null
> > > > > +++ b/arch/x86/kernel/ubsan.c
> > > > > @@ -0,0 +1,32 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Clang Undefined Behavior Sanitizer trap mode support.
> > > > > + */
> > > > > +#include <linux/bug.h>
> > > > > +#include <linux/string.h>
> > > > > +#include <linux/printk.h>
> > > > > +#include <linux/ubsan.h>
> > > > > +#include <asm/ptrace.h>
> > > > > +#include <asm/ubsan.h>
> > > > > +
> > > > > +/*
> > > > > + * Checks for the information embedded in the UD1 trap instruction
> > > > > + * for the UB Sanitizer in order to pass along debugging output.
> > > > > + */
> > > > > +enum bug_trap_type handle_ubsan_failure(struct pt_regs *regs, int insn)
> > > > > +{
> > > > > +       u32 type = 0;
> > > > > +
> > > > > +       if (insn == INSN_REX) {
> > > > > +               type = (*(u16 *)(regs->ip + LEN_REX + LEN_UD1));
> > > > > +               if ((type & 0xFF) == 0x40)
> > > > > +                       type = (type >> 8) & 0xFF;
> > > > > +       } else {
> > > > > +               type = (*(u16 *)(regs->ip + LEN_UD1));
> > > > > +               if ((type & 0xFF) == 0x40)
> > > > > +                       type = (type >> 8) & 0xFF;
> > > > > +       }
> > > > > +       pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> > > > > +
> > > > > +       return BUG_TRAP_TYPE_NONE;
> > > > > +}
> > > >
> > > > Shouldn't this return BUG_TRAP_TYPE_WARN?
> > >
> > > So as far as I understand, UBSAN trap mode never warns. Perhaps it does on
> > > arm64, although it calls die() so I am unsure. Maybe the condition in
> > > handle_bug() should be rewritten in the case of UBSAN ud1s? Do you have any
> > > suggestions?
> > 
> > AFAIK on arm64 it's basically a kernel OOPS.
> > 
> > The main thing I just wanted to point out though is that your newly added branch
> > 
> > > if (handle_ubsan_failure(regs, insn) == BUG_TRAP_TYPE_WARN) {
> > 
> > will never be taken, because I don't see where handle_ubsan_failure()
> > returns BUG_TRAP_TYPE_WARN.
> >
> 
> Initially I wrote this with some symmetry to the KCFI checks nearby, but I
> was unsure if this would be considered handled or not.

Yeah, that seemed like the right "style" to me too. Perhaps, since it
can never warn, we could just rewrite it so it's a void function avoid
the checking, etc.

-- 
Kees Cook

