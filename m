Return-Path: <linux-kernel+bounces-180194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED18C6B54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB43B22F65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099963BBF7;
	Wed, 15 May 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lRLO2TL4"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9E36AF2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793211; cv=none; b=OtCK2BmvuJ4YyKk4OtUnEcKKFgYKwBSG/WIlqpF6DJ2jivYdrVgu8rAERuCbCPGmHWSlhRhnWdlBUG9WDnSN4EMedLgOm/opO13Oy9Y3YoIoUqi5iRAFACdtuLW/xnMjW/USEsCVwtiym37dvN/VrsMhPHo1kH8Ikaip6b4jc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793211; c=relaxed/simple;
	bh=cvIV6f3GkDNs0QXxlEwPSB7F2//s6+TIdkMo1948Phs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZ62y/W3fseDialChrN1f01hKkm8oMSQlNOy6hoGtQHBV9I9T9xvOLGggYpCg2tjUHz55Tu8f26bLXlAdGAtHwXSFkdASO1fD3eVBPsEKYc3B+5FE2Jnp6latX4vl1YTmkgonFun1D8HWI62s/7EXnR/Ur4EtHvf9B8juI+NgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lRLO2TL4; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e576057c2bso74585821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1715793208; x=1716398008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG8JDEZluA+U+D68g8z0TeZdm/BEqT6rREHFgTIhPW4=;
        b=lRLO2TL4neNYn3MR4tadXjLoCHx8YLpBoVc+hSH7+Ha3t4iIMGtaoXE+gHFxk7uPMM
         Bj1gVBe79RzIshkP0Bv0YEeteZyDOVoxENabG2J+L2cPFi8mhmQkzvfVw9kH3+yuRmlr
         LLNzIsMv7kqYhZUIjtJ2BFW2PTRqggKxQrePJbp47r0ryxx1YKSIjGsxN/Q7cUcZjJOX
         3Aa4GJHkMR6EcPnoX0laDBo4Zja6qSyHL7J6TaYHouSU1oqGwNUEngIT/TloPPGZAsF9
         suFTz6/Y1GH1A/GtjLkI5FfohO9DuRP7iNB3NHGPpv0sOzGafFahHnj1pkvUzyg1xxSQ
         /gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793208; x=1716398008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG8JDEZluA+U+D68g8z0TeZdm/BEqT6rREHFgTIhPW4=;
        b=eV7ssAseNK18tJg85rB0n8qwWmIXmgUEmfpSI69XUwWW9NIcWGWAiEuaCx/Khdv0Ha
         6Qu8K3f7KOSUo3ZbDXNjA9m7f/MQlTtlJNmXYCN1rIi2QLFFbWCEEvIN23mhpMkZafUd
         zlOEri7obDoEJL2lwBwpZ1ZAG1xmhc6PEcsbPPRcd+lVsBZhow+Z4ljb4V28RtFVoCpz
         BEnQTGz9bVlU6wd3uqOo9PDLlGOXhfDGUDfGDdU0qeTOU6kBcSfCeXmvbRAV57hXGgco
         +PyTcAWPDm0dUI8cywK31GoZtehfOaogpOvC3JdWId1Pqnlx3YF2jEt/euvww/nrvpvO
         I7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdVCueQEXnk06noJQ4lV12qq0DO4kNj+VndGJMkTzTS25kAs4jwvEXqWkieyg8Gu9/l5A9/iyP2d1+q0TaUgZWmyYPdqIiZCjuRIoA
X-Gm-Message-State: AOJu0YyPG6VEjMGSbyyfhOsN/1Xk0vNoULP1trjSf0FWAkeb2pP8SfKw
	y3hVcbtXxLLUOde/5BX7ru7/uqhJfOsaP2OyhO7FeEVeM/RPZE7eiyG7+9LDDiZojqlFsTLPLWD
	/ABlH+d1Vd8snsJJnDff/9vt1hblzmtkjTQ+p9w==
X-Google-Smtp-Source: AGHT+IHfmskTbYDtGDQ4I7DObIPA2665F5KMdb6W8Wv/V4mAtLm81tAYf7jnYNcndFdsqSurRzjwAe2PkfScQpV143U=
X-Received: by 2002:a2e:7a0e:0:b0:2e2:466b:1a56 with SMTP id
 38308e7fff4ca-2e52039e2c3mr125315251fa.53.1715793207549; Wed, 15 May 2024
 10:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515-zen-calculate-289cfb90cd65@spud> <mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9>
In-Reply-To: <mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 15 May 2024 22:43:14 +0530
Message-ID: <CAK9=C2UkTD0hYymjow-yHHfBDh4CtRv-G2BPt=ncstLRmpYgyg@mail.gmail.com>
Subject: Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments to
 function 'riscv_ipi_set_virq_range'
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, naresh.kamboju@linaro.org, 
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-riscv@lists.infradead.org, 
	tglx@linutronix.de, anders.roxell@linaro.org, dan.carpenter@linaro.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:36=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Wed, 15 May 2024 07:36:33 PDT (-0700), Conor Dooley wrote:
> > Palmer,
> > This is the issue I point out to you on the call earlier:
>
> Ya, thanks, I just hit it.  Looks like it's a semantic conflict between
> 21a8f8a0eb35 ("irqchip: Add RISC-V incoming MSI controller early
> driver") and dc892fb44322 ("riscv: Use IPIs for remote cache/TLB flushes
> by default").  I think all we need is
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/ir=
q-riscv-imsic-early.c
> index 886418ec06cb..4fbb37074d29 100644
> --- a/drivers/irqchip/irq-riscv-imsic-early.c
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
>                 return virq < 0 ? virq : -ENOMEM;
>
>         /* Set vIRQ range */
> -       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
> +       riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);
>
>         /* Announce that IMSIC is providing IPIs */
>         pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwno=
de, IMSIC_IPI_ID);
>
> as a conflict resolution, which IIUC should happen when Linus merges my
> next PR.  So I'll try and remember to call that out.

Yes, your conflict resolution is correct.

Thanks,
Anup

>
> >
> > On Wed, May 15, 2024 at 04:18:58PM +0200, Naresh Kamboju wrote:
> >> The riscv builds failed on Linux next-20240515 tag due to following bu=
ild
> >> warnings / errors with gcc-13 and clang toolchain.
> >>
> >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>
> >> Build Log:
> >> -----
> >> drivers/irqchip/irq-riscv-imsic-early.c: In function 'imsic_ipi_domain=
_init':
> >> drivers/irqchip/irq-riscv-imsic-early.c:52:9: error: too many
> >> arguments to function 'riscv_ipi_set_virq_range'
> >>    52 |         riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
> >>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >> In file included from include/linux/smp.h:119,
> >>                  from include/linux/lockdep.h:14,
> >>                  from include/linux/spinlock.h:63,
> >>                  from include/linux/sched.h:2142,
> >>                  from include/linux/ratelimit.h:6,
> >>                  from include/linux/dev_printk.h:16,
> >>                  from include/linux/device.h:15,
> >>                  from include/linux/node.h:18,
> >>                  from include/linux/cpu.h:17,
> >>                  from drivers/irqchip/irq-riscv-imsic-early.c:8:
> >> arch/riscv/include/asm/smp.h:52:6: note: declared here
> >>    52 | void riscv_ipi_set_virq_range(int virq, int nr);
> >>       |      ^~~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> metadata:
> >>   git_describe: next-20240515
> >>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >>   git_sha: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
> >>   git_short_log: 82d92a9a1b9e ("Add linux-next specific files for 2024=
0515")
> >>
> >> Links:
> >>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202=
40515/testrun/23894295/suite/build/test/gcc-13-lkftconfig/details/
> >>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2gUiKdxX7qM2=
7ritMJT5pRyZhyi/
> >>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202=
40515/testrun/23894295/suite/build/test/gcc-13-lkftconfig/history/
> >>
> >> --
> >> Linaro LKFT
> >> https://lkft.linaro.org
> >>

