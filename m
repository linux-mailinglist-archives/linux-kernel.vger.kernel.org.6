Return-Path: <linux-kernel+bounces-293822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A339958561
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2071F21D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E15718E026;
	Tue, 20 Aug 2024 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="bnAoYp8J"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFE18DF87
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151880; cv=none; b=VW40Aq+8nhaB9P//IZjpv2duwkTUxOvgbAQfMplTKeYg5dfv0MfQn/1edCa9/oqyAaIN1Af8SyyyDYzarfkAneBwYQ/vj18vS0AaopK2VwKQ+3nt8+4i6ntffmSlq95mwJ2eywLsWIT5ZP6Z2yPbYrQclzIBO1eJK11FjJ4epfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151880; c=relaxed/simple;
	bh=ISFNRxnDuciF2QBQyi8Gf6LI4JhTSlxsFyBol1e4efw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWrBch3LAMHjqFio0OYJRT+caBGsESzCtA99j8tY2niiBRUbUfxI5CYiJxg25m9Y4PGhSrJ1Z433nG14g4XOYtV0gpp3dXY2Xs2ki+ZjlFZ8lZpG88xpD8gYm5/z5fs5cp30rBZzWXN7sUzdU5J1fZGDfpZLHAO7hnya9mTn2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=bnAoYp8J; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d34be8b6dso12177955ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724151878; x=1724756678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5ENCAJFA6GCGJ4Z5ac9HAe2HQjqebIqvvSZm6oncHk=;
        b=bnAoYp8JV+vKCpp98FyuqaxRRddWxInMPwckXcP+N7E11tgSLuBtQezbZq8wR63y73
         /6isBDHUyu5zZyrH7AIL8wOAcSTs2T0D8w3PVT7GInAvMeAWPxThXVmeeSGPLvInYsrZ
         L/XzAVVpENxS1HsdAoJW0rXMLE4Yt50kVfxSAUWiFme8XsyXP0STS7zaRA2+FbCqSy7R
         gug0EhUB+wnM6flsgp9g/1JZ51orquy6lgBmDUi1EAk+ijFMisAfjPFLw2QtjKPspRbV
         oMkW8IlTkkqj/C8+dNWEjIyblXC9MR+Mx/WE7NVY5wJPeGb/ny3v+Q69TdLxhvdDoVld
         gJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151878; x=1724756678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5ENCAJFA6GCGJ4Z5ac9HAe2HQjqebIqvvSZm6oncHk=;
        b=DWW69L5y1Pzd5MQG8bmF8MNvuRraV14qlX6ngwAYP6Pcl6u0pMNlC6iHTHxMcki2gE
         J6BdA4OWcD4Ojc3FDCH9YGa62k5kZscyX7EnGSx2vaJwfGjk0VEt0i/Dxa2N+uQxzPJ4
         7JZiO4mrLtkHtKrvm4PqSuT9tGXf2g0VKw4WXWqx9Twu2ZeYZiRJit87QkBeAyznKcq3
         QmEaC+1m6FzgIPR53605v0J00fVkuE7Ous7obZTqzhCc52+qnT8ejGPMeTMhdGVXlTu5
         9ZRDRespQhZQVq4FLbreqtsskDTxmUcrbVEuPV6JL+RapXKR4m4f9U9/t4KXnN1Ubw8y
         DxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJyAbgoE6NqZEAPYlS9v2tne4juIR8GjD54fchhACoF3RG11am3Y/yvvNKGdPY3z8jqhrjt8VJmzTyLFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwteNgaZq+uDIPG76ipY5nnlDyAXYDXfcVRs/25skUEFurNVEcH
	aL0EfjefaSSpzc85xdKLFozAqd2RdJ47PVPcTucCo4XcZbU2rB3fabBrA8tYcA94FXm9lzYN+bu
	C5RSY1XhoPxXFTCAcvS0p15ToSKi4gRcqgvZ1dXCUAMiT71o8
X-Google-Smtp-Source: AGHT+IGXOzRUY68xdnDacWlCjZGggODFihqXqN7thtCn6+Cfy4tu5ddknyhFDAkOod3zmubTNLL56Afi/Zk5FmYsKp4=
X-Received: by 2002:a05:6e02:1fcf:b0:39b:1ed5:4a55 with SMTP id
 e9e14a558f8ab-39d26d64ac5mr165863115ab.24.1724151878424; Tue, 20 Aug 2024
 04:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820094542.1576537-1-ruanjinjie@huawei.com>
In-Reply-To: <20240820094542.1576537-1-ruanjinjie@huawei.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 20 Aug 2024 16:34:26 +0530
Message-ID: <CAAhSdy2Xdh+jYgQ8pz9XewZSUVty0t=XUx8J8ecmHm_joCTOGw@mail.gmail.com>
Subject: Re: [PATCH -next] irqchip/sifive-plic: Fix IS_ERR() vs NULL bug in plic_probe()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tglx@linutronix.de, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	apatel@ventanamicro.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:09=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> The devm_platform_ioremap_resource() function returns error pointers.
> It never returns NULL. Update the check accordingly.
>
> Fixes: b68d0ff529a9 ("irqchip/sifive-plic: Use devm_xyz() for managed all=
ocation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-sifive-plic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 9e22f7e378f5..cea8dca89c50 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -511,8 +511,8 @@ static int plic_probe(struct platform_device *pdev)
>         priv->nr_irqs =3D nr_irqs;
>
>         priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (WARN_ON(!priv->regs))
> -               return -EIO;
> +       if (WARN_ON(IS_ERR(priv->regs)))
> +               return PTR_ERR(priv->regs);
>
>         priv->prio_save =3D devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
>         if (!priv->prio_save)
> --
> 2.34.1
>
>

