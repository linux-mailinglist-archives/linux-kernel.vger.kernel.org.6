Return-Path: <linux-kernel+bounces-293614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D502B9581F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928BC282EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6818B482;
	Tue, 20 Aug 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="SWZhXGNK"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D1189F4B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145585; cv=none; b=OCmSxmYr5k+AunCvO7FLM2u8xsaAeHBhmmc7JFhGUNbDsx+sPO8ztig1+P0W1zdNqvfwDXgyNbsP8RZQBPvuW8CWL5LG+99C2yUi+XrF2C94ViU/cXOoDFLHjdpGgNQrrv3w2rh7jSyt0IP73bHpQWC1ViujSkuRMICawaEIwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145585; c=relaxed/simple;
	bh=0MV9FrI9hg0tXVB/R3eu45u9Q78QI3UyLxdQGYcO0ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5MnHe3W9flRrH2Z+hdRmveRV0so5cO3rvlrEq4nTwkPdU3OJ8q3ZucRbeAcO/SBkoZe10JeIuzPdK+wCFz+c+/FR5vvt3YqvuZ/8nj0TaNH3V356UYrXiZvTEz6d7atXWTVVi27kUGNPm9tgdNZyMCkR9zwiNhD6SMP8w+Updo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=SWZhXGNK; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8252abac5bcso4908239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724145583; x=1724750383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwPbfctzRfZa2/zhqSrtwrO42MOMX85GRmKfc11Yv8c=;
        b=SWZhXGNKuSYcSUEuFcqmbXccpN09Xc3E0ToiQ9K0AkH+p8uevuD0F3fRqbhSHiwpMi
         WZJkjYUjw9f4y01WszDLEM6HNqQNHSMrxOe5RRmcCQV32VE1IoqTEIMbesr6cGqJrozM
         T8ZQbDtUvltTFQfRY9K6mKtNkY3bnv7UnRxS0MTP069ac/9mIIcaEgfZanuLOzFFWfv2
         hk7wEZf5zmeC55wm7WV+BUdkNpuIxBF10HAQB4R+XFMIB9Doi30sNYCOp3i7rDql1jbu
         vhsEBCef65PRuISh2DyPAngLt8RVem8KFRsOYJL6Sy9dQaInmhDMQ5ZSCnLhjILShQiK
         UuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145583; x=1724750383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwPbfctzRfZa2/zhqSrtwrO42MOMX85GRmKfc11Yv8c=;
        b=QenNkScf9ZKO6qG0cbiIwwffzTZbNj2Okp3hmDInejS5yB+Cgmq7ZmM8qSyIsWV22c
         VXmj2qEnY4iK0R9ctMciIkp9izoe2ERVEwg3ssG2XresUxOty5XCKRnO2TfsP4lx9bqb
         5g573INxUSxE9Y7E2xWSfYYwIWl9Y+PK/kbBWwYk9rfKlzpH2j+p9PHuySCEv2pvvDsW
         2bo3WHyj0RcpUIu/FzMmJWckwX/2ISOhXvXJLr2xpZ05NlpU3hAsQYHshDrKR4hxG1Fb
         SEL/PJ/V2mxciOu1sx7pKXgkC99IV7Ek6AfaZ50a84r5EgUDIEyLZ5hQ28Ft4HLim3dU
         LxPA==
X-Forwarded-Encrypted: i=1; AJvYcCVf/hKRJiOC8GHjFk3KEaTt84PtrdjtFuyQM83ziIx9e63LohYdpo013odjQE0Rjy+e2ZSaPG03z5UbXkv8HXeseG6F0ue7a7uVFjFE
X-Gm-Message-State: AOJu0YzagSN5q5lC33/WladDkqCUSypaBNtFK7L8+YUrBexQ/QrWZxdH
	5ugmtP2FEHuDZV7x0HFRDhRoqurPBEEAn3WJFgbi40o0fJvcIWqOWerIk9inbQd4jzqhn7O5KxC
	Z6PnUsOG6SHcIVM7UxSuzzuuPojO6kpUPM9RtIg==
X-Google-Smtp-Source: AGHT+IExX7dzgemFOY+5Vhm6vcIRzonwTa1j3n/gS7/d7T+aopXOQDlPfujd3coFGkXkPVCcQNAlbebtpfJSDbgjJjI=
X-Received: by 2002:a05:6e02:1fcf:b0:39b:1ed5:4a55 with SMTP id
 e9e14a558f8ab-39d26d64ac5mr163368045ab.24.1724145583225; Tue, 20 Aug 2024
 02:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain>
In-Reply-To: <a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 20 Aug 2024 14:49:31 +0530
Message-ID: <CAAhSdy1n54TxAiPHwrRBmvNZrijoFGXbgq3xb8LXVtPCD8udow@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:12=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The devm_platform_ioremap_resource() function doesn't return NULL, it
> returns error pointers.  Fix the error handling to match.
>
> Fixes: 2333df5ae51e ("irqchip: Add RISC-V advanced PLIC driver for direct=
-mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-riscv-aplic-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index 28dd175b5764..981fad6fb8f7 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -175,9 +175,9 @@ static int aplic_probe(struct platform_device *pdev)
>
>         /* Map the MMIO registers */
>         regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (!regs) {
> +       if (IS_ERR(regs)) {
>                 dev_err(dev, "failed map MMIO registers\n");
> -               return -ENOMEM;
> +               return PTR_ERR(regs);
>         }
>
>         /*
> --
> 2.43.0
>

