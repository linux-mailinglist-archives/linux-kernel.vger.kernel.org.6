Return-Path: <linux-kernel+bounces-294092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D69588C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F7281989
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01E46B91;
	Tue, 20 Aug 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DgTY/0l5"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947638F9C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163331; cv=none; b=IBnzjxL4VZg7uOeZ3ApsczZ4tBHud4zAzKngngj0PBwlFRPUQiRsMV5ZHeKB755esdC+OWvmubVFhGJfWDWhOukS9kp2BIYkt3EC+CAf/egaI7OjT8yBsBNV+hPttX4YP8J+vZn6/Vq4p3IydnjrLmjG+XFx3sWQIHYGpcwXhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163331; c=relaxed/simple;
	bh=tQvpAUnW/HjWvlzBrL3V7SMCGdNMVn8UaNmq5vKYfMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jea3gH2rS/tl6IEC19ctLLqSFD0qRFRqcz8Ch8ojvM/RQ9QkGiF6p8523tAQ+SwMDoCSk06rjROmwVCk9hLrTAXCm97NCNpTnccJhOkCQ/1NIpYQXQjZyRjSVyom3dSzgvnnuP/AUlaax294I/6rA7wVoK2Zluk/2l5jO++z7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DgTY/0l5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so61955961fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724163327; x=1724768127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06G4FyezZgfDrsrpdflEgDGPZdrxliGs+D3AnzUYadA=;
        b=DgTY/0l59eAllgSuZD1W6w8i82vU5+xlR7Og8i29CelMnc37EayWGXDwQFe1BjOXaZ
         NJYUG7wst9zSWizjLFkoY6x0oy5L+dDyuv5V8Tzst0ufJCcNvn/r7JEBBlxWgBTdTFEW
         P2pxhbs//UyHkLd4e9f7D8eB8ls5a3zl1CVcZyyEhCk6LrFjh14Oe4LQxeonjiOaXu1H
         m0pINUU4gESlQHHy2AxqQjxi3L+zk+GYyfDbvzlwBbfFcVpjHoIrWAHE9vbp3i6pwsfT
         KYs3nM3itQY1oCLPC9N53Or5Z24XYhm0M7OdO/0kjQ9+8O6tnmEmCvAiQWWMaKc3wKIe
         JWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163327; x=1724768127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06G4FyezZgfDrsrpdflEgDGPZdrxliGs+D3AnzUYadA=;
        b=HVffURzt09WkiBUFz4zvGDGlhU6XSlfiI+INnKfwBtBX0h16I20IQt3joHlbwbrntz
         mjoS0xsCDp0G8xL1bKViZ5l3vq2sbVGDo1+gvGzc7/D9jye7teZ0RHs3a85spXlwjXCk
         bbXj4p2Xj7pupZ0FnMQvvzAHnT6556xKA+VIgIcszLR9NyP+qhzcQPiBV8FT8W7yXDIm
         nXD/+PW5DYTszkUYAxUTMf5tGVl4vIvJgI79K+Dya6VVh4gCCuVmRtzinTCDSNd0aZ3+
         gEOTgnDcSs2iKtllClxl6UnXXTlRFewhTNzd5AtDfoQQocd5IyuvZviIOfHkq74G9fwe
         xgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHlVh7nbkizMyM0wkOz5RyZtjJ/8IbatL1VmGVxfH4dhQ0VGahIk/VYjdQQJWsiGPFgCfANpp4mRE5wnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fc922ynwFsDDROPhNeBgY0cGj+Rm/pe8x8lDCdER2+kNyGVA
	4xRjFYlTYMj9kVZKtMP1KyGLo2mL5ODHi18+MIbe48VAiFS1oaw9aa71r+YJ+HXgMal2Go9Lopj
	QeI4GJyF/wwOOlGRVIU4vD6+WE0z2UiAwyZmY7Q==
X-Google-Smtp-Source: AGHT+IGKiThAN0GuC44MFttdMjzCeTZn0kU8ugyaZbQcInGnnepS6RNuiFyj+ZZXcbedpVwVkDYHDnMsJPfbHLCUf2o=
X-Received: by 2002:a05:651c:890:b0:2f3:f170:8ec2 with SMTP id
 38308e7fff4ca-2f3f1708f2emr5847911fa.21.1724163326587; Tue, 20 Aug 2024
 07:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820132857.247679-1-yuehaibing@huawei.com>
In-Reply-To: <20240820132857.247679-1-yuehaibing@huawei.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 20 Aug 2024 19:45:14 +0530
Message-ID: <CAK9=C2UMsvb=mZHks+c-YBsWO23=WSrKj3=GgFiO9wzQwc_XLw@mail.gmail.com>
Subject: Re: [PATCH -next] irqchip/riscv-aplic: Fix NULL vs IS_ERR() bug
To: Yue Haibing <yuehaibing@huawei.com>
Cc: anup@brainfault.org, tglx@linutronix.de, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, ruanjinjie@huawei.com, 
	bjorn@rivosinc.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 7:04=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> devm_platform_ioremap_resource() never returns NULL pointer, it will
> return ERR_PTR() when it fails, so check it with IS_ERR().
>
> Fixes: 2333df5ae51e ("irqchip: Add RISC-V advanced PLIC driver for direct=
-mode")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Dan (CC'ed) already posted a very similar patch.

Regards,
Anup

> ---
>  drivers/irqchip/irq-riscv-aplic-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index 28dd175b5764..6d93a85f1fc6 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -175,9 +175,9 @@ static int aplic_probe(struct platform_device *pdev)
>
>         /* Map the MMIO registers */
>         regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (!regs) {
> +       if (IS_ERR(regs))
>                 dev_err(dev, "failed map MMIO registers\n");
> -               return -ENOMEM;
> +               return PTR_ERR(regs);
>         }
>
>         /*
> --
> 2.34.1
>
>

