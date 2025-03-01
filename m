Return-Path: <linux-kernel+bounces-539771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F9A4A863
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 04:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910A8189BF08
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7A1BD00C;
	Sat,  1 Mar 2025 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0WLb7C9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949251B87D1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 03:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740801475; cv=none; b=UWRj4s90fyOb3lqgawUp0DfdBChP6IjbkRdMoPFHyjadXh0awhtSA/bqO/xt9QJICMlwCKzIdEF/H8q9tTEYS1tbc57wGolMOSWPl8vR36uxN1MDcD1Ca6l2rYMMsBJ/HeejVHEGKgGZPNcj2knrhjCJ56SX/xRJCHB9jXGB79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740801475; c=relaxed/simple;
	bh=30CaJDZlEDQtLSL94YEwD5Gz+13JaSvJOhLCtLPBXKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGWtMIw8VuWdphYg/cQZYKlfIKjDqsgR0YZo9A1mEe0zSJh5OQ98GSsI+UyJFZ82BG2lxebUC0TBANGIC8TMoF7WvxtPYkfj+gZSLIITbE2X/9jf5x+Fd+R5pjmeY72qJNRJq9OiUITfcv9ttpSGfX6XijbAxr+OuLf+k10bdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0WLb7C9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab744d5e567so472076266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740801472; x=1741406272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzBuQTL7rvWDA/0NQ8Mh3xPzC01ym1TE0UV7JlOA02M=;
        b=n0WLb7C9KgX4HkXpwiYuIYHOw/jV1k37PlOH+5W3IJosgwlujVOX5jFJIKLIsQbKhR
         Lkf/dxKOa6oIqdvJIouCSHoE8onxMPw0BF7PCfwcdz+q78vP/BYPzuIy0p0PjGoaHgZS
         NCnAgKxnmjvhHSFqGtkFQKoSDpUR+7RcRWPHFn53pardPe+cWmokxNGK3XjDuRV7BTEI
         WSu9GSSohQYCCZgH+CQqTACdQ6Bog7/K1HR41Ybp6fL80L96hfGa3nSbRW9QQVTDOQzP
         lvBPgWGDp8faihmaCdaCtuM+FI3Fw4cxoQCgbP0GCvZwsQ8oDC96p+JCL7tAndjY60E9
         HhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740801472; x=1741406272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzBuQTL7rvWDA/0NQ8Mh3xPzC01ym1TE0UV7JlOA02M=;
        b=AFLcggYpYnk3ln/xbHFyQwxA3dM1UJcppGg3Di4MVIvEEjgZ2aWXczjwp0xmPkbfvQ
         C9aAzSrryVBDhQlPnkoL61999aa3GO1WstMhG1ArgTak6Po4iiNNBayQvZjktUOBw7dc
         6LERcS9LM/pdtrFgkbAfTdbJiKdcRKeky0Lq0CItB6u+dKAAG+NqQsxYFqZ4h0b2Ic0Y
         GYNWwR9C5mAH8UPC40VnARDBZlFnvhdm70I77Gm2ICgH6Vxo9fkyPJDcKbBd79Vs/DKb
         3mCuryShtnb1J26cVSfueuMO+c4dUq5Hs/cvjiBIrkjFuthdHzwKDWlq0q1bFlYPzFQv
         xXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOGRZ2I0bzhWbEl8a1b1J6des/yvXvyOny+GkKJMquyHZFpEFf1hakqh4zklt2+R43G+yJXJ3MXhF4wNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYKD0P+GTzeJT0b7MqDSdQ7cFmpp4jayjHPkIfPXF1EB37tdU
	dx3HX5zEhzdx8Ac8ZGoggF6w3NZ6jH07WQmdaZGH1XGoQ09j393lDn6+TqtnN9XfK+AzSPXPwoh
	W4N2dXAcrzJKSsceH1GhzANfSN/xwX68zKHVP
X-Gm-Gg: ASbGnct0dhU1t+4KX31GpakNI1T31FtSw3GK/zdevlKWCjdsOVFl/yrOijF0UjUbSkc
	S+h6bAAg8Msw0tGaVZMkeaUC0jfwlwLSwkZPoaom8a+LyekfUVOAE/CX9qaY+tX82t1ljynkna2
	bWgd5CSX3AEA1HeOOsqE5XPbyczw==
X-Google-Smtp-Source: AGHT+IGWLkCWgDFHODHJlsbWwTJyQIh8E1Xyr5nB71LBUq0uYDy96wWAwc67sc0nGBEwqrEkJE92OZie5BiOZXaLY2o=
X-Received: by 2002:a17:907:c247:b0:abb:b154:c064 with SMTP id
 a640c23a62f3a-abf062869c8mr1108901466b.18.1740801471755; Fri, 28 Feb 2025
 19:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170720.144739-1-sgarzare@redhat.com> <20250228170720.144739-6-sgarzare@redhat.com>
 <Z8JoMrUm9Dnoqgoi@kernel.org>
In-Reply-To: <Z8JoMrUm9Dnoqgoi@kernel.org>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 28 Feb 2025 19:57:40 -0800
X-Gm-Features: AQ5f1Jqko1N4oIcfRfm7F_nVUDkJnzQ_SnqW5xCCgfgJrG6mFjCxwMbChUujVE0
Message-ID: <CAAH4kHYqQOm8JrKDDDBgWqOY4QFX3zksfdDGr2nWQBFUEbh8OQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, 
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:51=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
> > Add driver for the vTPM defined by the AMD SVSM spec [1].
> >
> > The specification defines a protocol that a SEV-SNP guest OS can use to
> > discover and talk to a vTPM emulated by the Secure VM Service Module (S=
VSM)
> > in the guest context, but at a more privileged level (VMPL0).
> >
> > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > to verify that the device is actually emulated by the platform and to
> > send commands and receive responses.
> >
> > The vTPM is emulated through the TCG reference implementation, so this
> > driver leverages tpm_tcgsim.h to fill commands and parse responses.
>
> Why? Please don't.
>
> >
> > The device cannot be hot-plugged/unplugged as it is emulated by the
> > platform, so we can use module_platform_driver_probe(). The probe
> > function will only check whether in the current runtime configuration,
> > SVSM is present and provides a vTPM.
> >
> > [1] "Secure VM Service Module for SEV-SNP Guests"
> >     Publication # 58019 Revision: 1.00
> >     https://www.amd.com/content/dam/amd/en/documents/epyc-technical-doc=
s/specifications/58019.pdf
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  drivers/char/tpm/tpm_svsm.c | 120 ++++++++++++++++++++++++++++++++++++
> >  drivers/char/tpm/Kconfig    |  10 +++
> >  drivers/char/tpm/Makefile   |   1 +
> >  3 files changed, 131 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> >
> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > new file mode 100644
> > index 000000000000..1c34133990c5
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_svsm.c
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > + *
> > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > + *
> > + * The specification defines a protocol that a SEV-SNP guest OS can us=
e to
> > + * discover and talk to a vTPM emulated by the Secure VM Service Modul=
e (SVSM)
> > + * in the guest context, but at a more privileged level (usually VMPL0=
).
> > + *
> > + * The vTPM is emulated through the TCG reference implementation, so t=
his
> > + * driver leverages tpm_tcgsim.h to fill commands and parse responses.
> > + *
> > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > + *     Publication # 58019 Revision: 1.00
> > + *     https://www.amd.com/content/dam/amd/en/documents/epyc-technical=
-docs/specifications/58019.pdf
> > + */
> > +
> > +#include <asm/sev.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/tpm_tcgsim.h>
> > +
> > +#include "tpm.h"
> > +
> > +struct tpm_svsm_priv {
> > +     u8 buffer[TPM_TCGSIM_MAX_BUFFER];
> > +     u8 locality;
> > +};
> > +
> > +static int tpm_svsm_send_recv(struct tpm_chip *chip, u8 *buf, size_t b=
uf_len,
> > +                           size_t to_send)
> > +{
> > +     struct tpm_svsm_priv *priv =3D dev_get_drvdata(&chip->dev);
> > +     int ret;
> > +
> > +     ret =3D tpm_tcgsim_fill_send_cmd((struct tpm_send_cmd_req *)priv-=
>buffer,
> > +                                    priv->locality, buf, to_send);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D snp_svsm_vtpm_send_command(priv->buffer);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return tpm_tcgsim_parse_send_cmd((struct tpm_send_cmd_resp *)priv=
->buffer,
> > +                                      buf, buf_len);
> > +}
> > +
> > +static struct tpm_class_ops tpm_chip_ops =3D {
> > +     .flags =3D TPM_OPS_AUTO_STARTUP,
> > +     .send_recv =3D tpm_svsm_send_recv,
> > +};
> > +
> > +static int __init tpm_svsm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct tpm_svsm_priv *priv;
> > +     struct tpm_chip *chip;
> > +     int err;
> > +
> > +     if (!snp_svsm_vtpm_probe())
> > +             return -ENODEV;
> > +
> > +     priv =3D devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * FIXME: before implementing locality we need to agree what it m=
eans
> > +      * for the SNP SVSM vTPM
> > +      */
> > +     priv->locality =3D 0;
> > +
> > +     chip =3D tpmm_chip_alloc(dev, &tpm_chip_ops);
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +
> > +     dev_set_drvdata(&chip->dev, priv);
> > +
> > +     err =3D tpm2_probe(chip);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D tpm_chip_register(chip);
> > +     if (err)
> > +             return err;
> > +
> > +     dev_info(dev, "SNP SVSM vTPM %s device\n",
> > +              (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit tpm_svsm_remove(struct platform_device *pdev)
> > +{
> > +     struct tpm_chip *chip =3D platform_get_drvdata(pdev);
> > +
> > +     tpm_chip_unregister(chip);
> > +}
> > +
> > +/*
> > + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> > + * module_platform_driver_probe() this is ok because they cannot get u=
nbound
> > + * at runtime. So mark the driver struct with __refdata to prevent mod=
post
> > + * triggering a section mismatch warning.
> > + */
> > +static struct platform_driver tpm_svsm_driver __refdata =3D {
> > +     .remove =3D __exit_p(tpm_svsm_remove),
> > +     .driver =3D {
> > +             .name =3D "tpm-svsm",
> > +     },
> > +};
> > +
> > +module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
> > +
> > +MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:tpm-svsm");
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 0fc9a510e059..fc3f1d10d31d 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -225,5 +225,15 @@ config TCG_FTPM_TEE
> >       help
> >         This driver proxies for firmware TPM running in TEE.
> >
> > +config TCG_SVSM
> > +     tristate "SNP SVSM vTPM interface"
> > +     depends on AMD_MEM_ENCRYPT
> > +     help
> > +       This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP =
guest
> > +       OS can use to discover and talk to a vTPM emulated by the Secur=
e VM
> > +       Service Module (SVSM) in the guest context, but at a more privi=
leged
> > +       level (usually VMPL0).  To compile this driver as a module, cho=
ose M
> > +       here; the module will be called tpm_svsm.
> > +
> >  source "drivers/char/tpm/st33zp24/Kconfig"
> >  endif # TCG_TPM
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 9bb142c75243..52d9d80a0f56 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) +=3D xen-tpmfront.o
> >  obj-$(CONFIG_TCG_CRB) +=3D tpm_crb.o
> >  obj-$(CONFIG_TCG_VTPM_PROXY) +=3D tpm_vtpm_proxy.o
> >  obj-$(CONFIG_TCG_FTPM_TEE) +=3D tpm_ftpm_tee.o
> > +obj-$(CONFIG_TCG_SVSM) +=3D tpm_svsm.o
> > --
> > 2.48.1
> >
>
> OK, so this is like ARM's driver architecture using SMC, and I think
> tpm_ftpm_tee is probably one great reflection for this overall. Is this
> correct analysis, or not?

Using ftpm is really obtuse, at least with my attempt
https://github.com/deeglaze/amdese-linux/tree/svsmftpm
I don't really know how to cleanly bind the platform_driver to the one devi=
ce.
I don't think that this is any way better than what this patch series propo=
ses.

>
> BR, Jarkko



--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

