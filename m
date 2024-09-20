Return-Path: <linux-kernel+bounces-334679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13597DA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849C21C20F05
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D018A6D1;
	Fri, 20 Sep 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU1HjZFO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72F18A6A8
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726871405; cv=none; b=cyvZtvz6y2ovQDX9iP02MP1RJQoRIxw4HQxuPwUpyhhoORA3SCWCyYAkjMMedTJc4K1Xup9a9mHb2c0CEiV8vwuhkyfCm3dW/dGLk7zoXNjnnjzKewSYX6nrIHJi9EOQlXHmMg08SdLGuFgXskapMYyOMXjJ+S66ERaYnPJ58qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726871405; c=relaxed/simple;
	bh=5rjovaAAbiNgMBuU7M4FLRqHaMzI8V12hLRmG6DgklM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oqy1Uk2o3/8f9+XZe3CmyEAwPunP0sF7YUnQX/TETfxz26iqXAOwYSkOwFkBjgEWSIsfBGEIvYUsJ/dadYV+r6bKSZmBwXNy4dGg/5OJCkYiHS+ZLrcjNDCD5VIqswj+DEpez+VY0RsGfhlmOV4QudY1/MxGbIq1pHXEcOG7iPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU1HjZFO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so3180254a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726871402; x=1727476202; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swS/eAMre3URp5M1Cs94CLh7EUmF/oecqun6+tXxKcs=;
        b=OU1HjZFOPUxBCSxTC/noAih7kJdKanUGlPxOMVZe91uo8Byo9JJV0YE7t6pTBpy6nG
         htVkeo3PJMeen9trNonWTvMtDrz+Sdn37HaA2V60Bsz0L7Ruo1JJ8Fv5msuuFDIUGS1L
         Qmi4eLIdqHi115q1i+9qGvSIxf1BZzc8ZynUqFv8iWXbOW5xWb+J9jAMcq8DmlhOYiYM
         11RXYXJ/o4JJVSSzFDBVScuRvfW6LE2nglaFMjabAAG3FRceHg1aiSAquShCVyhugW0R
         aHjUXNq1XdOWmg+QZryRvwVWWUI+ajnU6NEt3eNw2Cii6OK0YhxDLaS0YCfjwulfevZt
         zs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726871402; x=1727476202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=swS/eAMre3URp5M1Cs94CLh7EUmF/oecqun6+tXxKcs=;
        b=beV5dyAwPsrSo1YZe5dWC0arYSfuZSu05eYR6QP+UI637yntbrKf9YV59RvoIv3wIT
         hGfe+xkGNxmFlLcxzOLlGqEtEm5tPCrHnMjLLX284NnsmiVoDFCI0lY6hDBOibV2Dy/4
         FFtx7NDRicsokbZmWe7iduXCeMX0zdIUQ7RcSmmGxs/yRVGmEqCACWt97G9xtunUId3w
         bt2he/yPv9oSVJQJMa5nNAy38IHoTatqsq/69IbzgnjHwVgFIRVra/E4V13RbYTaNMdR
         QAQ04Erx6cQ8m1icah7HeC4bDsJJJYHTiKW+x3RmGU/igKg/zv/dopQ42ropVFsuk2Om
         0CFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi6Wg+qtaRcXORzvB5eVpk0m67AOOcAVQyuzKq969d8fNa3FD/jF0ligu6kU4HraPFsQBBtJSgoAp1h2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVdbQ1qOja4/YEmc4Py1TCeccaPgryqlMSfQrFPO0vOlLbGZf
	aA6zsWIhF8ySCXhFmaKnkknfBsQNnvlokCxJR126vcihhoJkP2kW
X-Google-Smtp-Source: AGHT+IHY2wNeQFC/zHp9gActEThKEMdUGPFSwqp94LloOTxHO0KcxabgRYXnUcFGy+hjuzPfWnZcpw==
X-Received: by 2002:a17:907:d2c8:b0:a8d:5288:f48d with SMTP id a640c23a62f3a-a90d5033deamr343635966b.32.1726871401350;
        Fri, 20 Sep 2024 15:30:01 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967a5sm910924066b.21.2024.09.20.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 15:30:00 -0700 (PDT)
Message-ID: <8271905d88ecbba4487f260bdfa347decfdfadbc.camel@gmail.com>
Subject: Re: [PATCH 1/4] soc: marvell: Add a general purpose RVU PF driver
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Anshumali Gaur <agaur@marvell.com>, conor.dooley@microchip.com, 
	ulf.hansson@linaro.org, arnd@arndb.de, linus.walleij@linaro.org, 
	nikita.shubin@maquefel.me, vkoul@kernel.org, cyy@cyyself.name, 
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com
Date: Sat, 21 Sep 2024 00:30:29 +0200
In-Reply-To: <20240920112318.2722488-2-agaur@marvell.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-2-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

On Fri, 2024-09-20 at 16:53 +0530, Anshumali Gaur wrote:
> Resource virtualization unit (RVU) on Marvell's Octeon series of
> silicons maps HW resources from the network, crypto and other
> functional blocks into PCI-compatible physical and virtual functions.
> Each functional block again has multiple local functions (LFs) for
> provisioning to PCI devices.
> RVU supports multiple PCIe SRIOV physical functions (PFs) and virtual
> functions (VFs). And RVU admin function (AF) is the one which manages
> all the resources (local functions etc) in the system.
>=20
> Functionality of these PFs and VFs depends on which block LFs are
> attached to them. Depending on usecase some PFs might support IO
> (ie LFs attached) and some may not. For the usecases where PF
> doesn't (need to) support IO, PF's driver will be limited to below
> functionality.
> 1. Creating and destroying of PCIe SRIOV VFs
> 2. Support mailbox communication between VFs and admin function
> =C2=A0=C2=A0 (RVU AF)
> 3. PCIe Function level reset (FLR) for VFs
>=20
> For such PFs this patch series adds a general purpose driver which
> supports above functionality. This will avoid duplicating same
> functionality for different RVU PFs.
>=20
> This patch adds basic stub PF driver with PCI device init logic and
> SRIOV enable/disable support.
>=20
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/soc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> =C2=A0drivers/soc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0drivers/soc/marvell/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +++
> =C2=A0drivers/soc/marvell/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/soc/marvell/rvu_gen_pf/Makefile |=C2=A0=C2=A0 5 +
> =C2=A0drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 159 +++++++++++++++++++++=
+++
> =C2=A0drivers/soc/marvell/rvu_gen_pf/gen_pf.h |=C2=A0 19 +++
> =C2=A07 files changed, 206 insertions(+)
> =C2=A0create mode 100644 drivers/soc/marvell/Kconfig
> =C2=A0create mode 100644 drivers/soc/marvell/Makefile
> =C2=A0create mode 100644 drivers/soc/marvell/rvu_gen_pf/Makefile
> =C2=A0create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.c
> =C2=A0create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.h
>=20
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 6a8daeb8c4b9..a5d3770a6acf 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -15,6 +15,7 @@ source "drivers/soc/imx/Kconfig"
> =C2=A0source "drivers/soc/ixp4xx/Kconfig"
> =C2=A0source "drivers/soc/litex/Kconfig"
> =C2=A0source "drivers/soc/loongson/Kconfig"
> +source "drivers/soc/marvell/Kconfig"
> =C2=A0source "drivers/soc/mediatek/Kconfig"
> =C2=A0source "drivers/soc/microchip/Kconfig"
> =C2=A0source "drivers/soc/nuvoton/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 2037a8695cb2..b20ec6071302 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -20,6 +20,7 @@ obj-y				+=3D ixp4xx/
> =C2=A0obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
> =C2=A0obj-$(CONFIG_LITEX_SOC_CONTROLLER) +=3D litex/
> =C2=A0obj-y				+=3D loongson/
> +obj-y				+=3D marvell/
> =C2=A0obj-y				+=3D mediatek/
> =C2=A0obj-y				+=3D microchip/
> =C2=A0obj-y				+=3D nuvoton/
> diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
> new file mode 100644
> index 000000000000..b55d3bbfaf2a
> --- /dev/null
> +++ b/drivers/soc/marvell/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# MARVELL SoC drivers
> +#
> +
> +menu "Marvell SoC drivers"
> +
> +config MARVELL_OCTEON_RVU_GEN_PF
> +	tristate "Marvell Octeon RVU Generic PF Driver"
> +	depends on ARM64 && PCI && OCTEONTX2_AF
> +	default n
> +	help
> +	This driver is used to create and destroy PCIe SRIOV VFs of the
> +	RVU PFs that doesn't need to support any I/O functionality. It also
> +	enables VFs to communicate with RVU admin function (AF) & handles
> +	PCIe FLR for VFs.
> +
> +	Say =E2=80=98Yes=E2=80=99 to this driver if you have such a RVU PF devi=
ce.
> +endmenu
> diff --git a/drivers/soc/marvell/Makefile b/drivers/soc/marvell/Makefile
> new file mode 100644
> index 000000000000..9a6917393873
> --- /dev/null
> +++ b/drivers/soc/marvell/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_MARVELL_OCTEON_RVU_GEN_PF) +=3D rvu_gen_pf/
> diff --git a/drivers/soc/marvell/rvu_gen_pf/Makefile b/drivers/soc/marvel=
l/rvu_gen_pf/Makefile
> new file mode 100644
> index 000000000000..6c3d2568942b
> --- /dev/null
> +++ b/drivers/soc/marvell/rvu_gen_pf/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for Marvell's Octeon RVU GENERIC PF driver
> +#
> +obj-$(CONFIG_MARVELL_OCTEON_RVU_GEN_PF) +=3D gen_pf.o
> +ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
> diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c b/drivers/soc/marvel=
l/rvu_gen_pf/gen_pf.c
> new file mode 100644
> index 000000000000..b9ddf3746a44
> --- /dev/null
> +++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell Octeon RVU Generic Physical Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/sysfs.h>
> +
> +#include "gen_pf.h"
> +#include <rvu_trace.h>
> +#include <rvu.h>
> +
> +#define DRV_NAME=C2=A0=C2=A0=C2=A0 "rvu_generic_pf"
> +
> +/* Supported devices */
> +static const struct pci_device_id rvu_gen_pf_id_table[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA0F6) },
> +	{ }=C2=A0 /* end of table */
> +};
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Marvell Octeon RVU Generic PF Driver");
> +MODULE_DEVICE_TABLE(pci, rvu_gen_pf_id_table);
> +
> +static int rvu_gen_pf_check_pf_usable(struct gen_pf_dev *pfdev)
> +{
> +	u64 rev;
> +
> +	rev =3D readq(pfdev->reg_base + RVU_PF_BLOCK_ADDRX_DISC(BLKADDR_RVUM));
> +	rev =3D (rev >> 12) & 0xFF;
> +	/* Check if AF has setup revision for RVUM block,
> +	 * otherwise this driver probe should be deferred
> +	 * until AF driver comes up.
> +	 */
> +	if (!rev) {
> +		dev_warn(pfdev->dev,
> +			 "AF is not initialized, deferring probe\n");
> +		return -EPROBE_DEFER;
> +	}
> +	return 0;
> +}
> +
> +static int rvu_gen_pf_sriov_enable(struct pci_dev *pdev, int numvfs)
> +{
> +	int ret;
> +
> +	ret =3D pci_enable_sriov(pdev, numvfs);
> +	if (ret)
> +		return ret;
> +
> +	return numvfs;
> +}
> +
> +static int rvu_gen_pf_sriov_disable(struct pci_dev *pdev)
> +{
> +	int numvfs =3D pci_num_vf(pdev);
> +
> +	if (!numvfs)
> +		return 0;
> +
> +	pci_disable_sriov(pdev);
> +
> +	return 0;
> +}
> +
> +static int rvu_gen_pf_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	if (numvfs =3D=3D 0)
> +		return rvu_gen_pf_sriov_disable(pdev);
> +
> +	return rvu_gen_pf_sriov_enable(pdev, numvfs);
> +}
> +
> +static void rvu_gen_pf_remove(struct pci_dev *pdev)
> +{
> +	struct gen_pf_dev *pfdev =3D pci_get_drvdata(pdev);
> +
> +	rvu_gen_pf_sriov_disable(pfdev->pdev);
> +	pci_set_drvdata(pdev, NULL);
> +
> +	pci_release_regions(pdev);
> +}
> +
> +static int rvu_gen_pf_probe(struct pci_dev *pdev, const struct pci_devic=
e_id *id)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct gen_pf_dev *pfdev;
> +	int err;
> +
> +	err =3D pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "Failed to enable PCI device\n");
> +		return err;
> +	}
> +
> +	err =3D pci_request_regions(pdev, DRV_NAME);
> +	if (err) {
> +		dev_err(dev, "PCI request regions failed %d\n", err);
> +		goto err_map_failed;
> +	}
> +
> +	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +	if (err) {
> +		dev_err(dev, "DMA mask config failed, abort\n");
> +		goto err_release_regions;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	pfdev =3D devm_kzalloc(dev, sizeof(struct gen_pf_dev), GFP_KERNEL);
> +	if (!pfdev) {
> +		err =3D -ENOMEM;
> +		goto err_release_regions;
> +	}
> +
> +	pci_set_drvdata(pdev, pfdev);
> +	pfdev->pdev =3D pdev;
> +	pfdev->dev =3D dev;
> +	pfdev->total_vfs =3D pci_sriov_get_totalvfs(pdev);
> +
> +	err =3D rvu_gen_pf_check_pf_usable(pfdev);
> +	if (err)
> +		goto err_release_regions;
> +
> +	return 0;
> +
> +err_release_regions:
> +	pci_release_regions(pdev);
> +	pci_set_drvdata(pdev, NULL);
> +err_map_failed:
> +	pci_disable_device(pdev);
> +	return err;
> +}
> +
> +static struct pci_driver rvu_gen_driver =3D {
> +	.name =3D DRV_NAME,
> +	.id_table =3D rvu_gen_pf_id_table,
> +	.probe =3D rvu_gen_pf_probe,
> +	.remove =3D rvu_gen_pf_remove,
> +	.sriov_configure =3D rvu_gen_pf_sriov_configure,
> +};
> +
> +static int __init rvu_gen_pf_init_module(void)
> +{
> +	return pci_register_driver(&rvu_gen_driver);
> +}
> +
> +static void __exit rvu_gen_pf_cleanup_module(void)
> +{
> +	pci_unregister_driver(&rvu_gen_driver);
> +}
> +
> +module_init(rvu_gen_pf_init_module);
> +module_exit(rvu_gen_pf_cleanup_module);
> diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h b/drivers/soc/marvel=
l/rvu_gen_pf/gen_pf.h
> new file mode 100644
> index 000000000000..4cf12e65a526
> --- /dev/null
> +++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell Octeon RVU Generic Physical Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +
> +#define RVU_PFFUNC(pf, func)=C2=A0=C2=A0=C2=A0 \
> +	((((pf) & RVU_PFVF_PF_MASK) << RVU_PFVF_PF_SHIFT) | \
> +	(((func) & RVU_PFVF_FUNC_MASK) << RVU_PFVF_FUNC_SHIFT))
> +
> +struct gen_pf_dev {
> +	struct pci_dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *p=
dev;
> +	struct device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *dev;
> +	void __iomem		*reg_base;
> +	int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pf;
> +	u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_vfs;
> +};

--=20
Alexander Sverdlin.


