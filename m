Return-Path: <linux-kernel+bounces-309096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE322966629
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752BC281479
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E811B6558;
	Fri, 30 Aug 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0pcm0J8j"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375261B6553
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033250; cv=none; b=ViHhmNjBQTrpY5siECZjBp4WD82/junO+CGQbpfFArzoJsyCe3rfcirxCPP97kpinS40Kn+ca7rJ5gtIJC+3Ut7ouWSAyJtbgXW9gpfvQ9paNe5rwM6HBoUZe6B+Y7aNugvywEHclVLDig7La4gvnrhIJ7lGqH5luLEYtJgahrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033250; c=relaxed/simple;
	bh=jbMTfg+uDRYs2k1IxLMPWLaXOBcla/O/urjT8XyOs2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCM3g9TV7sL3ZGDfFrrE4GDwSDzVFL4a673xn1ipH5VH6OA+40huUeKRT/njyxV2N8zfyMikpZ3lpFuZqw9Jkqsdxs5HZGz2INc/0dmJqDruvHsqBRAg+esv/9clAH8DtSq8+n04Xn0mQhvSM017rgdf6r+oZM/eLqx/fuZUhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0pcm0J8j; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so398448a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725033247; x=1725638047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zFrMVsJYl3sotqJz8TrPZcTYV/4zTZNt2ckjtky3/Y=;
        b=0pcm0J8jpxGkpCQGf4/7TPOr4XLOCv795JGDjFtO5waFByMwjR3m5OnTO239HOeKKz
         ZmonAXM1jH+2ZGh+WX0WmHTIQDFiN0wppCka08ALuYcxvQL1fJCWdZCXf/J9V9xSdoBv
         iUsqlCNXud4zksd/NaZxz4ZFv8W+vKlMi1pNisleMLCUJ1IRq6OM9WgJA95jhecVOps8
         g7XMlj134LUqh0Brzz6uPY1rjd3+DQqTI1p1Jvw0bIPyz1V6XPGtDHlLRkCvHwBCtTC3
         6zyC5+txJiN29op9WFF4l66MptnFlNBwW4EPZTPMDJGaFS/U51YLlxgMa7Xv/p0gI3c7
         NrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033247; x=1725638047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zFrMVsJYl3sotqJz8TrPZcTYV/4zTZNt2ckjtky3/Y=;
        b=sFn1PrpV8ikbFVkP4HhVTpW4Irmy1NE9+SK172BHoSL5Kco/GZrPb+gV1wbhYBuXFk
         Vxj6fTur08Gy13pzg0nDXRc0NpW3AZx8JGOoHcvpxMMgQ1UYFAQ4ScuFFnUk+/9jzqQn
         h2Q+xxc6D4a3NF8i894D/Af67lZkn32il1yBVsrvm1Ysd7Zprv0zJBa8EA77AecYFxKq
         DkhrCRITJEs9w3K+xK/DTM4SdXRM/ShxcvhR2pt/pwWZv5Yhhip/5vRL5I+5nC9Qg2No
         3v2h0drQQrtpdyvkUOFQZbOHD6fZ+WemRYS4H/wMQGiX0W/Pe2EbRT7IvUtKDvRGiuK9
         OYmw==
X-Forwarded-Encrypted: i=1; AJvYcCXxehxS+ZWsT0siRS7QHjU77slJ35PMrlixdkBJeCL55jjBMSqoOiRkd58aX5S7Wwpgn814Lgl8iRq10Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NVEN/rpCfygGV+IAfrpO5+LPFja7Bx/+JQEdGu4sjUzxc6qU
	/63SmSnEWFwpORj8eb6H4CyOoNf/kOwRFaOM9JC7LKl4F6asbvqAEfUzgWQwbMw3qkUrZ29hXjv
	n8C9IHfFqLVlHtAItV8kZ6c5L8qJK8MiSAHEGmg==
X-Google-Smtp-Source: AGHT+IHqww2BN0wkQwPYdMhnQTg3TxCGlp9Mk+rODktSERGIPDWIjWzjq9myksdgfoZJdBK+HY3p2Z1cUXjFTbwu1Bo=
X-Received: by 2002:a17:90b:17c5:b0:2c2:d590:808e with SMTP id
 98e67ed59e1d1-2d86b00d06fmr4398660a91.13.1725033247242; Fri, 30 Aug 2024
 08:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718388908.git.tjeznach@rivosinc.com> <e2792d6559f9f3e02b2243538647ef60f14176fd.1718388909.git.tjeznach@rivosinc.com>
 <CALw707q=B4h4CF3CvJOiRMMYqzvO_NG+taMLzZquCP=A9bgu0g@mail.gmail.com>
 <CAH2o1u5qU8y=FHRANQ74WnGfMim24Pho2av17rE5ZObZywjB4g@mail.gmail.com> <f330e50c-677a-4982-8ede-dd1e35cc3954@arm.com>
In-Reply-To: <f330e50c-677a-4982-8ede-dd1e35cc3954@arm.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 30 Aug 2024 08:53:56 -0700
Message-ID: <CAH2o1u7OO5C7+0uhXg_pVWAekT4=EzZe_uMpziLCun769iLDPA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jim Shu <jim.shu@sifive.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Anup Patel <apatel@ventanamicro.com>, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 8:49=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 30/08/2024 4:37 pm, Tomasz Jeznach wrote:
> > On Fri, Aug 30, 2024 at 12:04=E2=80=AFAM Jim Shu <jim.shu@sifive.com> w=
rote:
> >>
> >> Hi Tomasz,
> >>
> >> QEMU RISC-V IOMMU will switch the PCIe vendor/device ID to Red Hat one
> >> [1] in the latest v6 patch.
> >> Will we also support the PCIe ID of Red Hat one in the Linux driver?
> >>
> >
> > Absolutely yes. I've been holding of with adding Red Hat PID/VID to
> > limit number of changes outside iommu subsystem in this patch series,
> > planing to sent single change adding new PCI IDs once this series is
> > accepted.
>
> It shouldn't entail any changes outside this code - per pci_ids.h,
> PCI_VENDOR_ID_REDHAT is already defined, while the individual IOMMU
> device IDs *should* stay local to this driver as the only user of them.
> Similarly, the Rivos vendor ID would only warrant factoring out once
> another driver turns up wanting to share it.
>
> Thanks,
> Robin.
>

Ok, keeping device ID local will make the change simpler. Will add in
next revision.
Thank you for this comment.

Best,
- Tomasz


> > Driver implementation is generic and should correctly
> > interact with QEMU model and other hardware implementations of RISC-V
> > IOMMU specification.
> >
> > Best regards,
> >   - Tomasz
> >
> >> [1] https://patchew.org/QEMU/20240801154334.1009852-1-dbarboza@ventana=
micro.com/20240801154334.1009852-5-dbarboza@ventanamicro.com/
> >>
> >>
> >> Regards,
> >> Jim Shu
> >>
> >>
> >>
> >> On Sat, Jun 15, 2024 at 1:29=E2=80=AFPM Tomasz Jeznach <tjeznach@rivos=
inc.com> wrote:
> >>>
> >>> Introduce device driver for PCIe implementation
> >>> of RISC-V IOMMU architected hardware.
> >>>
> >>> IOMMU hardware and system support for MSI or MSI-X is
> >>> required by this implementation.
> >>>
> >>> Vendor and device identifiers used in this patch
> >>> matches QEMU implementation of the RISC-V IOMMU PCIe
> >>> device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.
> >>>
> >>> MAINTAINERS | added iommu-pci.c already covered by matching pattern.
> >>>
> >>> Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbar=
boza@ventanamicro.com/
> >>> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> >>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> >>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> >>> ---
> >>>   drivers/iommu/riscv/Kconfig     |   5 ++
> >>>   drivers/iommu/riscv/Makefile    |   1 +
> >>>   drivers/iommu/riscv/iommu-pci.c | 119 +++++++++++++++++++++++++++++=
+++
> >>>   3 files changed, 125 insertions(+)
> >>>   create mode 100644 drivers/iommu/riscv/iommu-pci.c
> >>>
> >>> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfi=
g
> >>> index 5dcc5c45aa50..c071816f59a6 100644
> >>> --- a/drivers/iommu/riscv/Kconfig
> >>> +++ b/drivers/iommu/riscv/Kconfig
> >>> @@ -13,3 +13,8 @@ config RISCV_IOMMU
> >>>
> >>>            Say Y here if your SoC includes an IOMMU device implementi=
ng
> >>>            the RISC-V IOMMU architecture.
> >>> +
> >>> +config RISCV_IOMMU_PCI
> >>> +       def_bool y if RISCV_IOMMU && PCI_MSI
> >>> +       help
> >>> +         Support for the PCIe implementation of RISC-V IOMMU archite=
cture.
> >>> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makef=
ile
> >>> index e4c189de58d3..f54c9ed17d41 100644
> >>> --- a/drivers/iommu/riscv/Makefile
> >>> +++ b/drivers/iommu/riscv/Makefile
> >>> @@ -1,2 +1,3 @@
> >>>   # SPDX-License-Identifier: GPL-2.0-only
> >>>   obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o
> >>> +obj-$(CONFIG_RISCV_IOMMU_PCI) +=3D iommu-pci.o
> >>> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/io=
mmu-pci.c
> >>> new file mode 100644
> >>> index 000000000000..e675acceb290
> >>> --- /dev/null
> >>> +++ b/drivers/iommu/riscv/iommu-pci.c
> >>> @@ -0,0 +1,119 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +
> >>> +/*
> >>> + * Copyright =C2=A9 2022-2024 Rivos Inc.
> >>> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> >>> + *
> >>> + * RISCV IOMMU as a PCIe device
> >>> + *
> >>> + * Authors
> >>> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> >>> + *     Nick Kossifidis <mick@ics.forth.gr>
> >>> + */
> >>> +
> >>> +#include <linux/compiler.h>
> >>> +#include <linux/init.h>
> >>> +#include <linux/iommu.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/pci.h>
> >>> +
> >>> +#include "iommu-bits.h"
> >>> +#include "iommu.h"
> >>> +
> >>> +/* Rivos Inc. assigned PCI Vendor and Device IDs */
> >>> +#ifndef PCI_VENDOR_ID_RIVOS
> >>> +#define PCI_VENDOR_ID_RIVOS             0x1efd
> >>> +#endif
> >>> +
> >>> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
> >>> +#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
> >>> +#endif
> >>> +
> >>> +static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct =
pci_device_id *ent)
> >>> +{
> >>> +       struct device *dev =3D &pdev->dev;
> >>> +       struct riscv_iommu_device *iommu;
> >>> +       int rc, vec;
> >>> +
> >>> +       rc =3D pcim_enable_device(pdev);
> >>> +       if (rc)
> >>> +               return rc;
> >>> +
> >>> +       if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
> >>> +               return -ENODEV;
> >>> +
> >>> +       if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
> >>> +               return -ENODEV;
> >>> +
> >>> +       rc =3D pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> >>> +       if (rc)
> >>> +               return dev_err_probe(dev, rc, "pcim_iomap_regions fai=
led\n");
> >>> +
> >>> +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> >>> +       if (!iommu)
> >>> +               return -ENOMEM;
> >>> +
> >>> +       iommu->dev =3D dev;
> >>> +       iommu->reg =3D pcim_iomap_table(pdev)[0];
> >>> +
> >>> +       pci_set_master(pdev);
> >>> +       dev_set_drvdata(dev, iommu);
> >>> +
> >>> +       /* Check device reported capabilities / features. */
> >>> +       iommu->caps =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPA=
BILITIES);
> >>> +       iommu->fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL=
);
> >>> +
> >>> +       /* The PCI driver only uses MSIs, make sure the IOMMU support=
s this */
> >>> +       switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps))=
 {
> >>> +       case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
> >>> +       case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
> >>> +               break;
> >>> +       default:
> >>> +               return dev_err_probe(dev, -ENODEV,
> >>> +                                    "unable to use message-signaled =
interrupts\n");
> >>> +       }
> >>> +
> >>> +       /* Allocate and assign IRQ vectors for the various events */
> >>> +       rc =3D pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
> >>> +                                  PCI_IRQ_MSIX | PCI_IRQ_MSI);
> >>> +       if (rc <=3D 0)
> >>> +               return dev_err_probe(dev, -ENODEV,
> >>> +                                    "unable to allocate irq vectors\=
n");
> >>> +
> >>> +       iommu->irqs_count =3D rc;
> >>> +       for (vec =3D 0; vec < iommu->irqs_count; vec++)
> >>> +               iommu->irqs[vec] =3D msi_get_virq(dev, vec);
> >>> +
> >>> +       /* Enable message-signaled interrupts, fctl.WSI */
> >>> +       if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
> >>> +               iommu->fctl ^=3D RISCV_IOMMU_FCTL_WSI;
> >>> +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu=
->fctl);
> >>> +       }
> >>> +
> >>> +       return riscv_iommu_init(iommu);
> >>> +}
> >>> +
> >>> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> >>> +{
> >>> +       struct riscv_iommu_device *iommu =3D dev_get_drvdata(&pdev->d=
ev);
> >>> +
> >>> +       riscv_iommu_remove(iommu);
> >>> +}
> >>> +
> >>> +static const struct pci_device_id riscv_iommu_pci_tbl[] =3D {
> >>> +       {PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
> >>> +        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> >>> +       {0,}
> >>> +};
> >>> +
> >>> +static struct pci_driver riscv_iommu_pci_driver =3D {
> >>> +       .name =3D KBUILD_MODNAME,
> >>> +       .id_table =3D riscv_iommu_pci_tbl,
> >>> +       .probe =3D riscv_iommu_pci_probe,
> >>> +       .remove =3D riscv_iommu_pci_remove,
> >>> +       .driver =3D {
> >>> +               .suppress_bind_attrs =3D true,
> >>> +       },
> >>> +};
> >>> +
> >>> +builtin_pci_driver(riscv_iommu_pci_driver);
> >>> --
> >>> 2.34.1
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv

