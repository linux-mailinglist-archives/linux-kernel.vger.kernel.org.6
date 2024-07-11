Return-Path: <linux-kernel+bounces-248624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4EF92DFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C746282679
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4482C67;
	Thu, 11 Jul 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V54KARxK"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7320E3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678197; cv=none; b=lel/pjJakPKg2OvxrFaHbtx5OaEfvqiy4YpCMP5HEHdx/j6M7sGLsfT9U7tbktr9u7pO8kXEOl/ipdWeJSy04tftTYLEizhzqV8islt+5tniV+l105XpxQ450aUvSxfWbbtxoPVj9rJp9QwrBgUTsxiKNQPfOtBlXnCgwpLjhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678197; c=relaxed/simple;
	bh=Uug0Qmp2eZWpiJ2VcKydECZ4C/6tV1D7yoG/UxTCcpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uUCBrkp8lEwcdqPjkMlvvnrIjZUeOeo10Tb8zeTUt06XE8DW2UebeC2whgSnJSUsUdsHXxPW67I8R5+PLbo/E9rrDam924+zVfpJPP5GmrrhfxE2NAILjWMSFY/9vDH/LTBA7d9IvHSdo9Yc0LY4mcIhtU+lBMxeAyyBwLmGF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V54KARxK; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25d6dd59170so279971fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720678195; x=1721282995; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3M3PfsAx3vPU+NiI8uq0uabDA7M3koOLeB2Wv0JEvM=;
        b=V54KARxKNbP6vuwtC6g5nsLBhU3pfRrYRgOttkOedNvEQK2aeasLaeb5snwVx7Hoca
         KuOWm0q4NWvpEaU9EMGSry499nYICnTz7Sui2bdLklevU8BwVFhPPA5PdeHsyg13Pz+3
         dg0GpvTvS1IlG47A246fYn1WOIcSfFEInHYznFmVHe7faQwwRO54j3cV59FMjuX+MGlA
         VySlW5muhjYw8Y3/8x2hT9z0l8E8rTVU2rLDhB0iPzclHsiraAppC4Nc+idXIe4ri3Ew
         p8rlEtAae7XXx0/GRvNFtIyWaeGmoOaIxFCGflnk+O9KN5PyKI4GAVei6QN4nL1orMie
         xtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678195; x=1721282995;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3M3PfsAx3vPU+NiI8uq0uabDA7M3koOLeB2Wv0JEvM=;
        b=ZVs4ZQke/TtOP2kE/ZPUhlDPRr+obZlIxoJQ/agiHrR8zvleJSyi/8T7GE0EaPJVaC
         pmZIwWiaMduNRDHy1sqy5NKVnd1SUsD6VUq6XUFD9t701i5LMUbZ3nf9kz4Q0cmyjLhv
         mi6KsMvcg2wFOR/NdAG77mdstle27VCc+aEkmdJOPBKIGMwCGpCrKDPiPe8qHqzv5LUH
         X3H0Ab+N4ASjlJB39B099IicW7l297sohacvTSmljgqJchH3rXaffpHQl4q1FoG/CyaA
         QXIRWBoos3q8k68tAE5V5o1WMF8sE317lEZH8K0OGyHkL6JQLKMcHvpbAkj4bVDXh6rv
         GQmw==
X-Forwarded-Encrypted: i=1; AJvYcCVk/DyCURXBe12iL/WYrnCf0BaSU+cWt6T+5moK1DZ/79awxrP6kqOapP1BuT2kZf8xBnSBY+1XBrGojxxTmdMmefZuKRdKVFsqhMnj
X-Gm-Message-State: AOJu0YwvhE2c8m1H4Qq0fclS8fpTciFHH/pafDsZI712R0Da0prIcyCZ
	3IwDxobt57kmMPq7lb9KzAuKr5foWh1dTqhXZXHuOiuaeibmY6lADDnxMMPMi/ehGvBMD03zctM
	E+szf0B1QexlDAtGsAiDvIECwIj8n0zbW2D1y832cZA7CqwFutyUf7Fz4
X-Google-Smtp-Source: AGHT+IHcN2m9lFqoH4GP+4D/ntqMBI1+rK9QIx5yDML85z8OJGfON1bRuawj96Ajf6+pi5K2TF5PNmy5hlvmlangqPw=
X-Received: by 2002:a05:6870:658f:b0:25e:2956:4b8b with SMTP id
 586e51a60fabf-25eaec074damr5991249fac.39.1720678194836; Wed, 10 Jul 2024
 23:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625030502.68988-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240625030502.68988-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 11 Jul 2024 14:09:43 +0800
Message-ID: <CAEEQ3wnrdRcBdevQDGQ-5dr3aO1ura13_VskMYm8ySTZJTiYhw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Randomize lower bits of stack address
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, andy.chiu@sifive.com, alexghiti@rivosinc.com, 
	conor.dooley@microchip.com, bjorn@rivosinc.com, sorear@fastmail.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, punit.agrawal@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add punit in the loop.


On Tue, Jun 25, 2024 at 11:05=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
>
> Implement arch_align_stack() to randomize the lower bits
> of the stack address.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/exec.h | 8 ++++++++
>  arch/riscv/kernel/process.c   | 9 +++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 arch/riscv/include/asm/exec.h
>
> diff --git a/arch/riscv/include/asm/exec.h b/arch/riscv/include/asm/exec.=
h
> new file mode 100644
> index 000000000000..07d9942682e0
> --- /dev/null
> +++ b/arch/riscv/include/asm/exec.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_EXEC_H
> +#define __ASM_EXEC_H
> +
> +extern unsigned long arch_align_stack(unsigned long sp);
> +
> +#endif /* __ASM_EXEC_H */
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index e4bc61c4e58a..e3142d8a6e28 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -15,6 +15,7 @@
>  #include <linux/tick.h>
>  #include <linux/ptrace.h>
>  #include <linux/uaccess.h>
> +#include <linux/personality.h>
>
>  #include <asm/unistd.h>
>  #include <asm/processor.h>
> @@ -26,6 +27,7 @@
>  #include <asm/cpuidle.h>
>  #include <asm/vector.h>
>  #include <asm/cpufeature.h>
> +#include <asm/exec.h>
>
>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER=
_TASK)
>  #include <linux/stackprotector.h>
> @@ -99,6 +101,13 @@ void show_regs(struct pt_regs *regs)
>                 dump_backtrace(regs, NULL, KERN_DEFAULT);
>  }
>
> +unsigned long arch_align_stack(unsigned long sp)
> +{
> +       if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_s=
pace)
> +               sp -=3D get_random_u32_below(PAGE_SIZE);
> +       return sp & ~0xf;
> +}
> +
>  #ifdef CONFIG_COMPAT
>  static bool compat_mode_supported __read_mostly;
>
> --
> 2.20.1
>

Thanks,
Yunhui

