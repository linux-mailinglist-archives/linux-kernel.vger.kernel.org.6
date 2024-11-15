Return-Path: <linux-kernel+bounces-410935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035649CF097
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6A52918AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BA11D89E4;
	Fri, 15 Nov 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d0XsMaXF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD52F29
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685394; cv=none; b=kwjCF+NBbmIdeVOK0qRKd3mgW7QvG1hFimMMCaeq6ePHjaJ/lV/zS4GIIfICAWAoI8GLIpC4yHUbkKKhKJeOKCnmp5E5QeWBlO+FmfprNLO71gcbRVA570zUEiHPDtmMOHEE40W0izKRKRM+upIpNggvGk9prsnFU6jUtPJ6wB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685394; c=relaxed/simple;
	bh=EXLc0jpq6XnQBAgm3skbwhVbzuai7fYvBIrsjMtEVIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOl0BTMROiHQrsA58PNbOeHMYY2/RQYCkzH6AUCOPEZjaJ9V6jSvSsArEEdZJTywfmqxchDFf5MeFIfIo4m76mPk+VI5UQMAMSTXfw7VQQ7M6QRwb7r76fkAsdcs4o/jFecGpL8/EyCpcqSJavgv+uETPjcmHnvM5a7JRne+VIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d0XsMaXF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53c779ef19cso1037765e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731685390; x=1732290190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puWIlMfcycA4zPDYvHHQRG8tUppNKYPJEXaGKwVLLjk=;
        b=d0XsMaXFX3DQYh8JzRqLkmdQ3CXl4cjwLBdlDCiUY5uubXBA5f6+ZAlGv4I+89xE+o
         l830Hs1vjP0U6QHqwrBF2l1S6Ulums2bhenUA0851Rpaz3ZLkgW0M3DD3eHAh4X6Owk6
         Kjmp2DQgT93UhaB3Pa1JQ5Pa11Rw0x4xTkQ2myOI7LqH5+U73SEcnL7+u3ue3jvmZG3C
         9zK8UVNPR1335Z6KgruFIowH55VUX24gl9WDk2pK4sLF+UfVwYVYR/usEBqDw6v78xx+
         R+gyaR2yltPp/63+8DSUBM9apwW9/sY1sMkUNqKs01vSeWouGqsTBZB9+qx4deK/DpcE
         dp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685390; x=1732290190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puWIlMfcycA4zPDYvHHQRG8tUppNKYPJEXaGKwVLLjk=;
        b=MlPzzJ7xEfhGhVh6ip3w4GTLOLwKpuzLoN1DQH5bMfdcCJ2uK9pRpn6I6iRL324DgZ
         j20ZL/6fi3nqFqJw4w9NKpDzPEnlnKHu/nBqgopjxYt2tmHnBlyzgBq6bMgTFZueSumc
         Lm4s+nfzUNq+RG5vrk58ZtSFUDFltcJOdRYEmByW0/MA1gS1kaFcHzloAyVbFqyi2f40
         1Sq4cmfs+8LH6yXDO7BGtO6ZpnQx8cJEpKiSfsjT2NUR7O5KlFVIcXmSppOajaBWzUAP
         nBU57IX4rvqnrpW0SQT/3z2qB41Y41OJ3d1k7W9jWL4Sz4yCQFoX63kqjO6BtKvdpCLR
         Ys/w==
X-Forwarded-Encrypted: i=1; AJvYcCV99aYHIhjLZ3bSUzXSg1ef7gPQ4pFJH5BQgmc23HoqnSpKMZTOC6D0eKQfrQfjXqh/fv6fIHdupZGmygY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzji9J7kZIhGO1jzbIA5TBU7Nk6YFwmxN11izxiU0/fwVVXw5Gg
	bApCNuclUZfiZ2K4uKSC2/syga2gqF1yDkmV3CO8n5c7rMLhjmBHifHvks98+eVVlZNEXNolfLp
	d0MXxPVeL8PGqfd7g0URQY09Gs2b3zrLdCSzinw==
X-Google-Smtp-Source: AGHT+IGh6mrAa6jyGwF34tEwKQHXYbfcXfXM2tI9rQsPmNWrKq6I6ma5gBd835+q9M2zm5lVI5W52ISSAAlPrvmUzLc=
X-Received: by 2002:a05:6512:128d:b0:53d:a077:1d0b with SMTP id
 2adb3069b0e04-53dab3bc61cmr1714211e87.44.1731685390293; Fri, 15 Nov 2024
 07:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114200133.3069460-1-samuel.holland@sifive.com>
In-Reply-To: <20241114200133.3069460-1-samuel.holland@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 15 Nov 2024 21:12:58 +0530
Message-ID: <CAK9=C2UyfmHqtYYK-WeSRk3=6bjs5nzDmw9ntudbCnPOYxLtXg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-aplic: Fix crash when MSI domain is missing
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:31=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> If the APLIC driver is probed before the IMSIC driver, the parent MSI
> domain will be missing, which causes a NULL pointer dereference in
> msi_create_device_irq_domain(). Avoid this by deferring probe until the
> parent MSI domain is available. Use dev_err_probe() to avoid printing an
> error message when returning -EPROBE_DEFER.

The -EPROBE_DEFER is not needed because we expect that platforms to
use "msi-parent" DT property in APLIC DT node which in-turn allows Linux
DD framework to re-order probing based on fw_devlink dependencies. The
APLIC DT bindings mandates that any of "interrupt-extended" or "msi-parent"
DT properties MUST be present.

Can you elaborate a bit more on how you are hitting this issue ?

Regards,
Anup

>
> Fixes: ca8df97fe679 ("irqchip/riscv-aplic: Add support for MSI-mode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  drivers/irqchip/irq-riscv-aplic-main.c | 3 ++-
>  drivers/irqchip/irq-riscv-aplic-msi.c  | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index 900e72541db9..93e7c51f944a 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -207,7 +207,8 @@ static int aplic_probe(struct platform_device *pdev)
>         else
>                 rc =3D aplic_direct_setup(dev, regs);
>         if (rc)
> -               dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mo=
de ? "MSI" : "direct");
> +               dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\=
n",
> +                             msi_mode ? "MSI" : "direct");
>
>  #ifdef CONFIG_ACPI
>         if (!acpi_disabled)
> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-=
riscv-aplic-msi.c
> index 945bff28265c..fb8d1838609f 100644
> --- a/drivers/irqchip/irq-riscv-aplic-msi.c
> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> @@ -266,6 +266,9 @@ int aplic_msi_setup(struct device *dev, void __iomem =
*regs)
>                         if (msi_domain)
>                                 dev_set_msi_domain(dev, msi_domain);
>                 }
> +
> +               if (!dev_get_msi_domain(dev))
> +                       return -EPROBE_DEFER;
>         }
>
>         if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic=
_msi_template,
> --
> 2.45.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

