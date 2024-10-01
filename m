Return-Path: <linux-kernel+bounces-345831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEF98BB9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D3C1C237A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B81C0DC5;
	Tue,  1 Oct 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="O1Thcyps"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBA1C2327
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783683; cv=none; b=EXG8Dt41dwZEYnKd9PQ5kHPmv71PGWuuKexVvVzIRvJVSlUrjBhdqlvDxb5hx4nOl9T/2DWK8ph6566ZSfVQYfjG7VrDF6/3LwPBdv/q9kjFWKRFZ42Q5KuoCHqNq8dryBD33U05R7EvSeT83MEkfhOS8heJNt97GQZ6gC6VI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783683; c=relaxed/simple;
	bh=xhcUpSmeGMSfv8idGQEVcM3Gl8ZRkxLQsz09LKwobXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyCJnFsUZzKCzPemXBo2zK4k15b73OBi+5Rl7y0htXY7BAT5834dc2khMVpB1Hz3zg+cbfM6Fq8KcV0yVdKbrnOm+dff4LjRNhe4Y6bGxlYbSJcgDwPpn7LR05S+hoGnb69ARu4AEQpCv5vCD9xQlRlUMi6o5c3LC5lHJisjCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=O1Thcyps; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a340f9dd8aso30181775ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1727783681; x=1728388481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQP2eZATwaIQBSh4BYLJSNDYNoTYQ7d10X28PMhH36I=;
        b=O1ThcypsDWcaWqm9rYEXMo3pX0Imd/+3Qw10xy014HCUMNOu4Y2bNPFy3ZNIOnFkH/
         gw9irIDe/QbJ/NYr+vIILpsYxU6+K+osnrekJCMds6JUTDBUnl0fVKxzQZAHvZxFjm0a
         3vbFGH3PZdyYVGy+DYUlM6F6kAan1ZgpqJxRxqkKlbAYjcAVl24gJS4E/3ikn2WaWiLr
         R7wiLk0frZsTTNUeRUS8HQV3Jdx2MZo+C9utHxfUbFyrcMOk9xOS8GN/xdc0oQmerdxm
         kWSmebre4HgW9VZyUJoc6ZznCr+ay3EAxwVGe+D/OrfhwoTKal9CH0KIFKGRFL0KRXDJ
         7Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727783681; x=1728388481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQP2eZATwaIQBSh4BYLJSNDYNoTYQ7d10X28PMhH36I=;
        b=halZd5+QylTQc6fDLJdHhwoX3MEiZz1B2YLgmg8e/NIeXtrqRTcnk6Q4JCNVtfX4EO
         aU9uD7M19X9Dc2MCpa8LQXgGWFybUivOpNbC8wWHKDibvbbY0Sm6qcTepmeoLN+/Zzab
         hcTmSvNJkLSwtK9q1QN9S1+PrehcG8BnU9Fny/eIqCgzWLiqWTDJXfN4pbgCn/vj2nW4
         KtTbS3lV7hvotLhYsKIjjsLfPTyse1bhIh4EnnixurREvyT8kSSXGYSKd4ZuoiDGB9O/
         CLvAc1EJV7mkTUl2uwEYojECrC1O5v8ZbrlNzYvLtjcq7v+mx0IWwn9itVeijbe62gkA
         1XPg==
X-Forwarded-Encrypted: i=1; AJvYcCWd83/+sOa8BflGslKhrP3PaFoGy5fa/4zIjwyoU4vARjkzRG2Y501is9HbjYb92Gv8Lp3Lezmu4xFVPTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRs5/VtxsOH7Q7sXbj5t3r12GaA5eCuHOnCzX+7vymiuaFyxKo
	Pes0VNTTnQ9tK6Bsd2QPchqHyDnqx8X56O7VUiAr6h1WQfJ5lybXmHYU8CMEoXJtIBEDB5Tmu9E
	/tT/IKkOxez1ygA5glM4LExOH4znUiqaKGjlWXQ==
X-Google-Smtp-Source: AGHT+IHO9w1tNfJws5dAu3OtUP0xCbtsEcfYHhj3flsEJDRvG0kU3OBkokYTY3BvOuYT9zYQT3ITjpbWIIBh684lZtA=
X-Received: by 2002:a05:6e02:17c7:b0:3a3:4164:eec9 with SMTP id
 e9e14a558f8ab-3a34517ab5dmr148340195ab.14.1727783681191; Tue, 01 Oct 2024
 04:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
In-Reply-To: <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 1 Oct 2024 17:24:29 +0530
Message-ID: <CAAhSdy2OXsFx973MnE0LBEzKK0r4OWYWXbKrNnuW6Gbanfo-bQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix error codes
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:11=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> Set error to -ENOMEM if kcalloc() fails or if irq_domain_add_linear()
> fails inside of plic_probe().
>

Like Alex mentioned, please include a Fixes tag.

> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202409031122.yBh8HrxA-lkp@intel.com/

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-sifive-plic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 2f6ef5c495bd..0b730e305748 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -626,8 +626,10 @@ static int plic_probe(struct fwnode_handle *fwnode)
>
>                 handler->enable_save =3D kcalloc(DIV_ROUND_UP(nr_irqs, 32=
),
>                                                sizeof(*handler->enable_sa=
ve), GFP_KERNEL);
> -               if (!handler->enable_save)
> +               if (!handler->enable_save) {
> +                       error =3D -ENOMEM;
>                         goto fail_cleanup_contexts;
> +               }
>  done:
>                 for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++) {
>                         plic_toggle(handler, hwirq, 0);
> @@ -639,8 +641,10 @@ static int plic_probe(struct fwnode_handle *fwnode)
>
>         priv->irqdomain =3D irq_domain_create_linear(fwnode, nr_irqs + 1,
>                                                    &plic_irqdomain_ops, p=
riv);
> -       if (WARN_ON(!priv->irqdomain))
> +       if (WARN_ON(!priv->irqdomain)) {
> +               error =3D -ENOMEM;
>                 goto fail_cleanup_contexts;
> +       }
>
>         /*
>          * We can have multiple PLIC instances so setup global state
>
> ---
> base-commit: 6804f0edbe7747774e6ae60f20cec4ee3ad7c187
> change-id: 20240903-correct_error_codes_sifive_plic-4611f59291df
> --
> - Charlie
>
>

