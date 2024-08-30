Return-Path: <linux-kernel+bounces-308744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50596613B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04021F29520
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148C19994F;
	Fri, 30 Aug 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HR87ffzn"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D81917C8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019275; cv=none; b=lxsfwdqkfDwdzTj/KimJfPXFjQbQYpsmePeQWmTIemrIfCx28OZMj06wdLLpwZUAmEYIC2cCZRaWWjciG6GDt+ET56E2rpqW4qlqYhTHGTdo89Cx7XN6uT0r1raZpiI6Tre0seN8dWC98DmyKYM1hRgd/Qfc/FDnlMEPIxejko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019275; c=relaxed/simple;
	bh=bHtLDn0Wsn5DAZMI5MFUbrKX2XmlMvWqakZmLM6IBYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmGIAhvYCVmDlM6U5a8Ul20taHC8dwjPaAhfw1MiMzx3M1ZJpHZF1aaoB2QYNOPOkGY7K/npV4nse5gJ8tqfXvXR9PnyMh5+JoXzs/ljUjROJMEmMpVzCr2ehyktg0UIVXod9bdQ2c+GRJL4rnDqQtdfwBmOmiW96RuSRhzf0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HR87ffzn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71433cba1b7so1302340b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1725019271; x=1725624071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+J8nDWKmcjiFDnbhyvi48+lL6iNF2GBrnR+36Q3WWM=;
        b=HR87ffznTvXUBVDqLT0Z4TyfiJv/hQJBadGdPOm0cPr1GttjDAUsT+BxpmeoVD7nfq
         AyudgW9pKpsCEb4yI0/zZim6+8TLjZGJ5eI+A3dY+rTyIlJIwdmRJLJ7lEOS2rpXMQXP
         S+Et94PzArmnmHKqtAFollNazm9/1up+tBAg45u8N6zo31PooiofebtH65t9qsa9HAE6
         D98rmmDMrOyPATCqoZjtvhTG4DDJB3WD736dqpi8gCkf9BT+AWYUrdsMLKsoudEGkixk
         csRgKFAj5GF6s84c0H9lGrJg8F3YPHbOle7uDSF7qO+Fkfd0lK3p7NhdO+gCQYZ5Rwz/
         vaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725019271; x=1725624071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+J8nDWKmcjiFDnbhyvi48+lL6iNF2GBrnR+36Q3WWM=;
        b=Bkgib9s8CYAnrla+cNTLfb1c/9e+gp2eldkMNtJrbDYd234WFDDKc4qoeqHHPwxNo5
         UP7t8udYRD4RdRkLtSftQfYOwehe5EzR27rOI3O9l/xc00+aMADVq2CPMCNa7+p2qWe3
         dXd17nuhPnTfmewjRjLXXBhPsY0vGzqD9K0A3Ey9fcxlj1pMmP/96aOZv+d90j4a+mZK
         DDqgmtfPZyg4rE7WCS30AJQevtv6AQ+QyzD/8Zn2eYuBc9Iq/cOFYoURPsDWbzVO/Cb0
         6CMM03JNcdskTUQLtRZuNf8ayG9zwJZVLV9RFdejsFyr4mBaEzPhrvPnzEaa7XOnCUuK
         87tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl0Jwye3qTTz70b50xgPJum0njW+/BtmzxSr/Cc1VGw/LD96QntaVVujDc4uI2IeIquCP6hIkk9vE7drk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyri+wBDj4iQ1Z0P2ZOGYa1Cl1UFmdDPcwiM8btvYjyX3qv7Fk/
	IUCZWwPtU5tP4Jpwf/qOFDhakc+6EFHvQPFHYElYa7Zp6Uez7bC3yiuty7AuTbw=
X-Google-Smtp-Source: AGHT+IGKLvAFAz/eBLXMb30uIZ9vdANBzSIr6ORPbKAbI0x7ooOqoOsCu8d84XfIMHbv7krKGeaTpw==
X-Received: by 2002:a05:6a00:981:b0:706:58ef:613 with SMTP id d2e1a72fcca58-715dfc72cfdmr7188548b3a.27.1725019269804;
        Fri, 30 Aug 2024 05:01:09 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ef15sm2599685b3a.105.2024.08.30.05.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 05:01:09 -0700 (PDT)
Message-ID: <3fdb33d3-16cd-49a6-bad7-81631f99c291@ventanamicro.com>
Date: Fri, 30 Aug 2024 09:01:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
To: Jim Shu <jim.shu@sifive.com>, Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Anup Patel <apatel@ventanamicro.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <e2792d6559f9f3e02b2243538647ef60f14176fd.1718388909.git.tjeznach@rivosinc.com>
 <CALw707q=B4h4CF3CvJOiRMMYqzvO_NG+taMLzZquCP=A9bgu0g@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CALw707q=B4h4CF3CvJOiRMMYqzvO_NG+taMLzZquCP=A9bgu0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/30/24 4:04 AM, Jim Shu wrote:
> Hi Tomasz,
> 
> QEMU RISC-V IOMMU will switch the PCIe vendor/device ID to Red Hat one
> [1] in the latest v6 patch.
> Will we also support the PCIe ID of Red Hat one in the Linux driver?
> 
> [1] https://patchew.org/QEMU/20240801154334.1009852-1-dbarboza@ventanamicro.com/20240801154334.1009852-5-dbarboza@ventanamicro.com/

The QEMU-side background of this change: the original patches from Tomasz was
hardcoding a Rivos PCI ID, i.e. the device was being registered as a Rivos IOMMU
PCI device. The thing is that there isn't anything  Rivos specific in the QEMU
IOMMU emulation, since we're adhering to the riscv-iommu spec entirely (with a
couple of design choices here and there), thus we decided it would be better to
get a generic PCI IOMMU ID.

Red Hat was kind enough to gave us one from their PCI ID space, since RVI didn't
bother getting an ID for this reference device, and we're using the Red Hat ID
in the QEMU emulation. The QEMU IOMMU PCI device is by default reported as
1b36:0014 (PCI_VENDOR_ID_REDHAT : PCI_DEVICE_ID_REDHAT_RISCV_IOMMU).

This change happened in v3, sent in May 2024:

https://lore.kernel.org/qemu-riscv/20240523173955.1940072-1-dbarboza@ventanamicro.com/

This change would make the QEMU IOMMU PCI device incompatible with this kernel
support, so we added a capability to set the PCI ID for the device in the QEMU
command line. To make the IOMMU PCI device work with the current kernel support, that
is being set to a Rivos PCI device, change the vendor/device ID to match what the
kernel driver expects:

(...)  -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1

The ability to set vendor-id/device-id of this device will allow an easier development
of other proprietary IOMMU PCI drivers, i.e. it's not a hack to make the current kernel
support work.

As for this kernel support, I didn't fully review it to see if there is a Rivos specific
behavior being implemented. If this isn't the case perhaps there is a case to be made
to also make the kernel driver more generic - in this case feel free to use the same as
QEMU is going to use (PCI_VENDOR_ID_REDHAT : PCI_DEVICE_ID_REDHAT_RISCV_IOMMU - 1b36:0014).


Thanks,

Daniel


> 
> 
> Regards,
> Jim Shu
> 
> 
> 
> On Sat, Jun 15, 2024 at 1:29 PM Tomasz Jeznach <tjeznach@rivosinc.com> wrote:
>>
>> Introduce device driver for PCIe implementation
>> of RISC-V IOMMU architected hardware.
>>
>> IOMMU hardware and system support for MSI or MSI-X is
>> required by this implementation.
>>
>> Vendor and device identifiers used in this patch
>> matches QEMU implementation of the RISC-V IOMMU PCIe
>> device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.
>>
>> MAINTAINERS | added iommu-pci.c already covered by matching pattern.
>>
>> Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
>> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> ---
>>   drivers/iommu/riscv/Kconfig     |   5 ++
>>   drivers/iommu/riscv/Makefile    |   1 +
>>   drivers/iommu/riscv/iommu-pci.c | 119 ++++++++++++++++++++++++++++++++
>>   3 files changed, 125 insertions(+)
>>   create mode 100644 drivers/iommu/riscv/iommu-pci.c
>>
>> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
>> index 5dcc5c45aa50..c071816f59a6 100644
>> --- a/drivers/iommu/riscv/Kconfig
>> +++ b/drivers/iommu/riscv/Kconfig
>> @@ -13,3 +13,8 @@ config RISCV_IOMMU
>>
>>            Say Y here if your SoC includes an IOMMU device implementing
>>            the RISC-V IOMMU architecture.
>> +
>> +config RISCV_IOMMU_PCI
>> +       def_bool y if RISCV_IOMMU && PCI_MSI
>> +       help
>> +         Support for the PCIe implementation of RISC-V IOMMU architecture.
>> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
>> index e4c189de58d3..f54c9ed17d41 100644
>> --- a/drivers/iommu/riscv/Makefile
>> +++ b/drivers/iommu/riscv/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
>> +obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
>> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
>> new file mode 100644
>> index 000000000000..e675acceb290
>> --- /dev/null
>> +++ b/drivers/iommu/riscv/iommu-pci.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright © 2022-2024 Rivos Inc.
>> + * Copyright © 2023 FORTH-ICS/CARV
>> + *
>> + * RISCV IOMMU as a PCIe device
>> + *
>> + * Authors
>> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
>> + *     Nick Kossifidis <mick@ics.forth.gr>
>> + */
>> +
>> +#include <linux/compiler.h>
>> +#include <linux/init.h>
>> +#include <linux/iommu.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +#include "iommu-bits.h"
>> +#include "iommu.h"
>> +
>> +/* Rivos Inc. assigned PCI Vendor and Device IDs */
>> +#ifndef PCI_VENDOR_ID_RIVOS
>> +#define PCI_VENDOR_ID_RIVOS             0x1efd
>> +#endif
>> +
>> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
>> +#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
>> +#endif
>> +
>> +static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct riscv_iommu_device *iommu;
>> +       int rc, vec;
>> +
>> +       rc = pcim_enable_device(pdev);
>> +       if (rc)
>> +               return rc;
>> +
>> +       if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
>> +               return -ENODEV;
>> +
>> +       if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
>> +               return -ENODEV;
>> +
>> +       rc = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
>> +       if (rc)
>> +               return dev_err_probe(dev, rc, "pcim_iomap_regions failed\n");
>> +
>> +       iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>> +       if (!iommu)
>> +               return -ENOMEM;
>> +
>> +       iommu->dev = dev;
>> +       iommu->reg = pcim_iomap_table(pdev)[0];
>> +
>> +       pci_set_master(pdev);
>> +       dev_set_drvdata(dev, iommu);
>> +
>> +       /* Check device reported capabilities / features. */
>> +       iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
>> +       iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
>> +
>> +       /* The PCI driver only uses MSIs, make sure the IOMMU supports this */
>> +       switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
>> +       case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
>> +       case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
>> +               break;
>> +       default:
>> +               return dev_err_probe(dev, -ENODEV,
>> +                                    "unable to use message-signaled interrupts\n");
>> +       }
>> +
>> +       /* Allocate and assign IRQ vectors for the various events */
>> +       rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
>> +                                  PCI_IRQ_MSIX | PCI_IRQ_MSI);
>> +       if (rc <= 0)
>> +               return dev_err_probe(dev, -ENODEV,
>> +                                    "unable to allocate irq vectors\n");
>> +
>> +       iommu->irqs_count = rc;
>> +       for (vec = 0; vec < iommu->irqs_count; vec++)
>> +               iommu->irqs[vec] = msi_get_virq(dev, vec);
>> +
>> +       /* Enable message-signaled interrupts, fctl.WSI */
>> +       if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
>> +               iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
>> +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
>> +       }
>> +
>> +       return riscv_iommu_init(iommu);
>> +}
>> +
>> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
>> +{
>> +       struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
>> +
>> +       riscv_iommu_remove(iommu);
>> +}
>> +
>> +static const struct pci_device_id riscv_iommu_pci_tbl[] = {
>> +       {PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
>> +        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>> +       {0,}
>> +};
>> +
>> +static struct pci_driver riscv_iommu_pci_driver = {
>> +       .name = KBUILD_MODNAME,
>> +       .id_table = riscv_iommu_pci_tbl,
>> +       .probe = riscv_iommu_pci_probe,
>> +       .remove = riscv_iommu_pci_remove,
>> +       .driver = {
>> +               .suppress_bind_attrs = true,
>> +       },
>> +};
>> +
>> +builtin_pci_driver(riscv_iommu_pci_driver);
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

