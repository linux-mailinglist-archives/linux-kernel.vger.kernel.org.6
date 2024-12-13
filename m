Return-Path: <linux-kernel+bounces-444885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B79F0E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E69162152
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1891E0DE8;
	Fri, 13 Dec 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zjE8yaN/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17147186607
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097930; cv=none; b=GH+9kZyoXs3l8ZkqAP9FJh0Ajks0d/SI2RSe3B9Fxs08sqbwFhhwYNyvedSdPY3f4RTVJJMEvo03iFA2E6l1U6Gz7S3buwBMnz/vt2XyKBboYTs3VgsXOWF95z2zBAK7XaaJC5rS9gjfyqp99Oru0bFNM3+ey9gQNEozXxQEm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097930; c=relaxed/simple;
	bh=PrMNRDWV+EfKGb1B+Wbd2gu/doynSpcPbc2Q8qTdRmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWXzmIghMnS4AqMOJWaNZFq1fFkoc5bCTR8jW0fF44+syMfK4T6Jo6sWEK2V/IIHsB+JkQMNFHyzx84T61+y0YxC0iclkOuavN7aoS7uGZt+cdzSREmtwZPVQDfBhXXDJNHguNjmSQPg5bWL7MDV9xGlBt9mmjBPHWmUo09gR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zjE8yaN/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so2478905a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734097926; x=1734702726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFxRqoUDcxRTLhzcB0bq/QXLdWIm6pyY40R4SG8HtGg=;
        b=zjE8yaN/GTcTrqm4SQZuc92ylSfFWQbeZVhnLc9dvDXkqSwUYDaVtadwigTevydeO2
         e1FiR9WJQ17887mR56+vKxC/aNHXbZDlb4333Qu6eRlLtmya75EJD959WVoSsCumnKsF
         IGvFg8ew4XPicCxOK7kaBUb2ho7ia4fa6feGG2yaw6RwzTco4N9tL66xR1eRsKZpDfm5
         Tyw+510utuD4Nhnyuug6Yg5Gx7Mss6bPNM/oudeR5ZUaOGeMMWjZGXUYVNAHnsGTvKLU
         b7JNvbgN1/9dsTDsuJQcGuBY6Qz8cT0vzURZA/WMrq+h7hYjbSOCRmnt2ZhMP0QHC4cp
         58zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734097926; x=1734702726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFxRqoUDcxRTLhzcB0bq/QXLdWIm6pyY40R4SG8HtGg=;
        b=naOR4tAr0UtY6p8SE4mLIq6SxEvavFhQzTB1BuhKd9Jdg6NjeAqQzr/33O4FNyxPOu
         vHZNlYS4hDrgF8VBwfGZrLQoG0OLQBeD4QS+TEm/jKJyby42MCuu3GUdOYujmp1R8y0j
         BvnVaFbQ6C42kGxqPh9csCr9+RsqxlYRMbi5CYSYgDfhue0MNEyrf80+PUcnhvZgfu0L
         tKQSKHzDH6wX5Gxtc3eSjPztt6MCjaQt8OV6H/TIlGMJOaT+Vm1miPDUfp+dZZx0FnuS
         UMXQcB08Lre9uLDH3vy6Y88gfJbTRW3dQtX9iRugr08FyLjT5BVBpHGor87IzNIHdl1z
         QguA==
X-Forwarded-Encrypted: i=1; AJvYcCXaftnmrhZnnn/GKonBfPux7vFGlzg8ryslvsusGT1MD+ey/7Yb4Jq20yFIealSAkPOGpqaieTLIBnrpuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYoPoap27Tg2e6Juve+k9y+E0ovng1quHgAk25jyEr9NDiqBl1
	BHHxCUgvLc8R1Zgmzjn0CZdRZcBvCvAJGCAlRMSPQ9N47fZw6mIkjnTin84PGwhKoFBcALsyTXF
	cXyL0Vm3e7GmSAlM2ol1y1TW7yCpyHCfr56PnOQ==
X-Gm-Gg: ASbGncteG3AYGjkQeIzKlgxCifvmJLgFflGYZzkf6SEmxIMz141Vj7KUAHk1wocwvAl
	IJAL/B71K6dFdH8zdDKgxw9hC2hGqLHTy
X-Google-Smtp-Source: AGHT+IHWrpVtcx/k1VJWXnEECzEmYBxI/vWGNlZpsxqk0hQ9aDH2QOA2X4nisy8++11duJ4WnH/4HhQyJaIOmtD6qKg=
X-Received: by 2002:a05:6402:528f:b0:5d2:7456:9812 with SMTP id
 4fb4d7f45d1cf-5d63c39fba0mr2316225a12.22.1734097926046; Fri, 13 Dec 2024
 05:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213115704.353665-1-alexghiti@rivosinc.com> <87v7vn917f.ffs@tglx>
In-Reply-To: <87v7vn917f.ffs@tglx>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 13 Dec 2024 14:51:55 +0100
Message-ID: <CAHVXubiNMp9chdUdvYjiQC2LMhNMMaGEiLMWZ-4RSV54jakP3g@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Fix PCI warning by enabling PCI_MSI_ARCH_FALLBACKS
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Anup Patel <anup@brainfault.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, Dec 13, 2024 at 2:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Dec 13 2024 at 12:57, Alexandre Ghiti wrote:
> > When the interrupt controller is not using the IMSIC and ACPI is enable=
d,
> > the following warning appears:
> >
> > [    0.866401] WARNING: CPU: 1 PID: 1 at drivers/pci/msi/msi.h:121 pci_=
msi_setup_msi_irqs+0x2c/0x32
> > [    0.867071] Modules linked in:
> > [    0.867389] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-=
rc2-00001-g795582ce7e24-dirty #44
> > [    0.867538] Hardware name: QEMU QEMU Virtual Machine, BIOS
> > [    0.867672] epc : pci_msi_setup_msi_irqs+0x2c/0x32
> > [    0.867738]  ra : __pci_enable_msix_range+0x30c/0x596
>
> Removing a ton of badly formatted stack trace:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#ba=
cktraces-in-commit-messages

Thanks for the pointer.

>
> >
> > So enable PCI_MSI_ARCH_FALLBACKS to get rid of this.
>
> No. PCI_MSI_ARCH_FALLBACKS is really only meant for architectures which
> implement the legacy fallbacks and not to paper over the underlying
> logic bug in the pci/msi code. Of course the loongson folks ran into the
> same problem two years ago and went for the sloppy fix without talking
> to anyone...
>
> Thanks for bringing it up instead of silently slapping it into the RISCV
> tree !
>
> The uncompiled patch below should fix this for real.

It does, when applied the warning disappears (on riscv at least). You can a=
dd:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks for your quick answer!

Alex

>
> Thanks,
>
>         tglx
> ---
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -185,7 +185,6 @@ config LOONGARCH
>         select PCI_DOMAINS_GENERIC
>         select PCI_ECAM if ACPI
>         select PCI_LOONGSON
> -       select PCI_MSI_ARCH_FALLBACKS
>         select PCI_QUIRKS
>         select PERF_USE_VMALLOC
>         select RTC_LIB
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -350,8 +350,11 @@ bool pci_msi_domain_supports(struct pci_
>
>         domain =3D dev_get_msi_domain(&pdev->dev);
>
> -       if (!domain || !irq_domain_is_hierarchy(domain))
> -               return mode =3D=3D ALLOW_LEGACY;
> +       if (!domain || !irq_domain_is_hierarchy(domain)) {
> +               if (IS_ENABLED(CONFIG_PCI_MSI_ARCH_FALLBACKS))
> +                       return mode =3D=3D ALLOW_LEGACY;
> +               return false;
> +       }
>
>         if (!irq_domain_is_msi_parent(domain)) {
>                 /*
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -442,6 +442,10 @@ int __pci_enable_msi_range(struct pci_de
>         if (nvec > maxvec)
>                 nvec =3D maxvec;
>
> +       /* Test for the availability of MSI support */
> +       if (!pci_msi_domain_supports(dev, 0, ALLOW_LEGACY))
> +               return -ENOTSUPP;
> +
>         rc =3D pci_setup_msi_context(dev);
>         if (rc)
>                 return rc;

