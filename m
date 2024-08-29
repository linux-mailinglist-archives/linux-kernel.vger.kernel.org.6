Return-Path: <linux-kernel+bounces-306139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757B59639D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE3D1F25EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901007E796;
	Thu, 29 Aug 2024 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mH7901zs"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E747A76
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908703; cv=none; b=LmJMC1gHoe3Eo4ZvX6x2y7WCF3Cz8gf21Yy6ZPuOziGevnETE2CXZ3i/egbuBACgg8heFyxdZlZJU2A6+ACKJNjcuxeT89YgkhSajVqKUMtreJObw46u4LsmFbWDTy6kDqYwnWBFAIvnDqpiFq5nqq9pgLauYQnZbm45QFvFDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908703; c=relaxed/simple;
	bh=ELYjjQ+mJUOkuJUvz8UtgGVXCzr7Wuicbv+a1pSuFKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws5459mT1sMOphIp3l380WUTkYYg4pPU10VzZGae6jpAQXUtN82wgYVruoGYuGZZcO/uaZKZF0O6HvSdMofe+OYnotfiqMrZj5z1JpoCcY3Dx2nrD7Z2okqhEZd5nxUHgFuj+clJw2lT/lStoJiaZYPWLAGFc3WwhA/QGLfENVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mH7901zs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so273211e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724908700; x=1725513500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3IB0lNCEhV9enuNzk+VnTluaGKoDtr4uKJKrcnidUw=;
        b=mH7901zsZfHwyW9MPb+2brItPfYbrb0b5ZSw/i2MnOwDv792675/vhpwJa6ocohvCI
         TdrkyMrPWz/aVNUC5L5FMROlODXA4727EusJLI86BiNKPj+fvgkcZ9BzlfXnbv/KC7B8
         8/LADwqTZdmAnpZxx3FUxT0JoDIdTuMlvDvcwdAOLRPm4XDSjuGZNxue1gpCVHcdmBwe
         Qsl4XX5XNfKRd1G2cfYvTEZHAtU3jwJ+fgdD3KPMp/+iIh+pifLCbNm0OXJ4KLJ6jewm
         Os0jStPIIw4G4tRMAdZ1Y8BNM80n+TdndRxcdx7fV1bONVejuYLEnIUOD9yJp/7w6Mwl
         Dn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908700; x=1725513500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3IB0lNCEhV9enuNzk+VnTluaGKoDtr4uKJKrcnidUw=;
        b=VLsbDl+hWZ9MIZw6QCNC7kB5xKReWorlXOU8rt1RXHxqqzof96Vc8l6BrE38incQqo
         BFRtl2Y57aRO+XCTM2LFpU8M67jFYKdH53VkiQHcVQAuwaxQUU5WXv79Q0Qp3miQMNNd
         hkvlMOJq7DvLXHEHXYfmuYtqNPX7C0d8SzdrrGriZiSmKNoYMoUnOQQOCwhLanWxxaF2
         ZNKMxu3mwtikKh5NK9fwxn+17rUFhwfA0fVsUiEvMiFexoI7Uds0gT36pQJbUJ5CP/dH
         uo78MsFH+q0scqcHP2cSqCaLQPh5SriVnqJXxkoqlXDl8pRqusxdkjXEFmVlCRaGd+cQ
         3GzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+CcWOUi00yZgFTms0nNt03qkz22VXTBOJSid3EIlVJq1TdwvlPZ8mv5l3XtiTEdkkfNnFwKNHVkvOMfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBL7WiIffgrkW0hS4ADvAvEF1Q6rjQIycvq4tyeNUkGSLNvQK7
	ENosQoupiEP7tRbe2lKjiBneNph2dEpLPm8YdRQ2bikfahJ8nJ1TeNEDLQvpLdDbA/F0EQdAw12
	zScB1+z1mYW1J4oBjWfa1iGDmIvPWp/bK2LzMIA==
X-Google-Smtp-Source: AGHT+IF5qM5Tv33jrhTxPQuB7QcGegW/B0kYwW+2dXW1R9ibKz60sWm56wn4RINz3pCrSIub6yb7ue9n11Ee4xuIvkE=
X-Received: by 2002:a05:6512:2245:b0:52b:8ef7:bf1f with SMTP id
 2adb3069b0e04-5353e56680fmr723799e87.17.1724908699186; Wed, 28 Aug 2024
 22:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-2-nick.hu@sifive.com>
In-Reply-To: <20240829033904.477200-2-nick.hu@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 29 Aug 2024 10:48:07 +0530
Message-ID: <CAK9=C2XSrxXGB-PKKi0sLQq7L1Ovucb73Bc9tOnxwWTxux_D7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Add stimecmp save and restore
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:09=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> If the HW support the SSTC extension, we should save and restore the
> stimecmp register while cpu non retention suspend.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  arch/riscv/include/asm/suspend.h |  4 ++++
>  arch/riscv/kernel/suspend.c      | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/su=
spend.h
> index 4ffb022b097f..ffaac2efabb5 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -16,6 +16,10 @@ struct suspend_context {
>         unsigned long envcfg;
>         unsigned long tvec;
>         unsigned long ie;
> +#if __riscv_xlen < 64
> +       unsigned long stimecmph;
> +#endif
> +       unsigned long stimecmp;
>  #ifdef CONFIG_MMU
>         unsigned long satp;
>  #endif
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index c8cec0cc5833..3afd86e1abf7 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *context=
)
>         context->tvec =3D csr_read(CSR_TVEC);
>         context->ie =3D csr_read(CSR_IE);
>
> +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +               context->stimecmp =3D csr_read(CSR_STIMECMP);
> +#if __riscv_xlen < 64
> +               context->stimecmph =3D csr_read(CSR_STIMECMPH);
> +#endif
> +       }

The suspend save/restore is enabled for the NoMMU kernel as well
(which runs in M-mode) so it is better to save/restore stimecmp CSR
only for MMU enabled kernels (just like satp CSR).

>         /*
>          * No need to save/restore IP CSR (i.e. MIP or SIP) because:
>          *
> @@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *cont=
ext)
>         csr_write(CSR_TVEC, context->tvec);
>         csr_write(CSR_IE, context->ie);
>
> +       if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
> +               csr_write(CSR_STIMECMP, context->stimecmp);
> +#if __riscv_xlen < 64
> +               csr_write(CSR_STIMECMPH, context->stimecmph);
> +#endif
> +       }
> +
>  #ifdef CONFIG_MMU
>         csr_write(CSR_SATP, context->satp);
>  #endif
> --
> 2.34.1
>
>

Regards,
Anup

