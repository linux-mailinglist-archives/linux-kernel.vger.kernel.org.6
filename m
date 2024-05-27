Return-Path: <linux-kernel+bounces-190215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6888CFB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E555D1F20F47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F5246453;
	Mon, 27 May 2024 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="kbdidkAR"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF34D59F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798422; cv=none; b=RHhIqKGOb+L3EiRWZO5XnoJgEL+EDS7rFQ6k1qLLvU01Et6W9xjWGXWGoF7WLKPJ4UtJwZbi7A6+iRmlS8o4o7P5RxiFJhvikqtgJpA4ZzZoc6nVAT4dxdo7+QtvCEszELuDK36DeHk0+L1AGGn2qZHKDKijnc4OpaMpE4U6ZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798422; c=relaxed/simple;
	bh=o2Cd7FRHxRKyzXe1nYxRHpuLDvQDRWJ5/IpjiVl+PCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSjedTGLm04MdaGpCt6g8EjxMx3/Rml7ktCjoHAvdIQfNvipJNafJWJ7dGVhJl9kGyOoLxQLdmnabfuwBk/xvmbznxLVque+sn/KHiFCgdpOmqSOIo+DO1tBHIhuqtAZWrMR++PWqzFLkDN4V/kAZ/UxZqc5QWTqKcYaWMw7iBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=kbdidkAR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3737b33270aso13786835ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1716798420; x=1717403220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5SBKZRmfn8ClYY/nEFrKLglh6rD618P8LlNAa3InrU=;
        b=kbdidkARwHSwzlUbu+afTQLfphDeDpCM+PjqCTmDdT9vhrFV1KRWUb6TqDwRbSFs4/
         TuUHa/LHQCKMJheuyMdtp8yp4JoGpmAP5CWNwD2P1FUUW1j+7g4zbGBWczQlE9F44KYg
         ihaLvng52uGIJsV0BSMiUJHA4o6SFt32Nz3rjjej4TkQ0uNyrBPjb/O+TCyjYUKFUsda
         ac/Il97m+7fH4ns3FLGSBDwNpGXuf1Wy5J8+aNtC3SMlBT+NAgv0n2/Bo6qFP53T3Uf8
         W3dDR+H8gSv5PK1x+ZVg+xwEokAhBWfi3nPbbfrP/6wCKXoyXQ4/19aKe/bayqrXd0u6
         mqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716798420; x=1717403220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5SBKZRmfn8ClYY/nEFrKLglh6rD618P8LlNAa3InrU=;
        b=pvf7nJdfDNCqFShvariSWvPCvlpCG97ge8AOauZrD1vkGGQ1R58QQYIxUpwjSuXAlW
         NcEBw1SDMlKoD2pG1DWwYu2re7YFjlQMCAwbzG98xbMMlQpPU+63DVfjPpFI0HmItoFQ
         Oxi5d0WDXbb5Uh9mGpZ/8oaQJe7OWCY7HhTRFySXc7e3KPL/COJ5rpmsdShrw7kX9XNF
         1ypP050TNlmZOKMpn+AgVmauNI8DndeYV4amrv+g/g9PAjbl80Nb/vfqUbj/xpXfdiv2
         hwbPVYy7H4KoKmu9ofbCPydOjVt1NGPWxQTA+y3koeE62C5tUdwxtUceoQmr5PHpRbdr
         peEA==
X-Forwarded-Encrypted: i=1; AJvYcCWvGaCXD7YAazJ93RvKp/B1agTPq1ZjU/P0FZRDZxGWRGn88+48tjashXck2u7fO2GouEtkdnUa8thXJZyal+mi2Fu73wJ589NF3BhI
X-Gm-Message-State: AOJu0YwQZTU0EKzk3VXeQ1zoLojSpCthDj8BMnEXn61a/CERGwGRsOfd
	nr84zY6Lrv6BhxYB0CJb5TooR5FStnJ/H0aBFeDkPrXCeqQHgm+he0RPN1Dp3XBA/+amsNfGabH
	Y4rhx+MuAIa4E0Hflmz8M4O8c//Vq8TvrX0EJ9Q==
X-Google-Smtp-Source: AGHT+IEgDT4pS/mZr+ttNPQ/LXB18npnZnRGGeZXrhjUs0eiWtyBh4xHpLQwJaB4P1cmTNr+R0jrfrct3QLM4SE+COM=
X-Received: by 2002:a92:cf0a:0:b0:373:7f12:bc1a with SMTP id
 e9e14a558f8ab-3737f12c098mr74389655ab.13.1716798419836; Mon, 27 May 2024
 01:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527081113.616189-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240527081113.616189-1-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 27 May 2024 13:56:47 +0530
Message-ID: <CAAhSdy2tDtYPwPPa2o7_JBpVJXynv9+NwRMoOXErjRCcs+xBYg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-intc: Fix memory leak when
 riscv_intc_init_common() fails
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 1:41=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> When riscv_intc_init_common() fails, the firmware node allocated is not
> freed. Fix this memory leak.
>
> Fixes: 7023b9d83f03 ("irqchip/riscv-intc: Add ACPI support")
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-riscv-intc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 9e71c4428814..4f3a12383a1e 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -253,8 +253,9 @@ IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_in=
tc_init);
>  static int __init riscv_intc_acpi_init(union acpi_subtable_headers *head=
er,
>                                        const unsigned long end)
>  {
> -       struct fwnode_handle *fn;
>         struct acpi_madt_rintc *rintc;
> +       struct fwnode_handle *fn;
> +       int rc;
>
>         rintc =3D (struct acpi_madt_rintc *)header;
>
> @@ -273,7 +274,11 @@ static int __init riscv_intc_acpi_init(union acpi_su=
btable_headers *header,
>                 return -ENOMEM;
>         }
>
> -       return riscv_intc_init_common(fn, &riscv_intc_chip);
> +       rc =3D riscv_intc_init_common(fn, &riscv_intc_chip);
> +       if (rc)
> +               irq_domain_free_fwnode(fn);
> +
> +       return rc;
>  }
>
>  IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
> --
> 2.40.1
>

