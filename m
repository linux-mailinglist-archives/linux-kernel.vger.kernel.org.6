Return-Path: <linux-kernel+bounces-301485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5695F18F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AC81C2105A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF89189F2C;
	Mon, 26 Aug 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uhm7go/h"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886A17ADE7;
	Mon, 26 Aug 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675927; cv=none; b=bYIFPsDu3WSS/Nx7GA2C8kLYey8rLe5EmNtaf/foXGw5u+RXtLqDk1drNzULVl2qecxYlCkJxEKYXQWfpiKLAwWUdGLHJb26GOu5WHypZaVkzez9sK6raaduBIpm+X16/a0dvEvXExJ5h9IGLK1XEFSS8bM57cPvDVl2M3a9ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675927; c=relaxed/simple;
	bh=lzcURjcSmOthFLoqrPwefiMjLoXk+SnTZKdXF+C63I8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMCiqYhYrusFcYjp5Q41xMbcVP9GyqcGwfoIsglwLQsx99d5ler91nkmN6OJNGyGQdU2yFbRIDH+s0VvnwBgRFAoWqWNNzCGv3C9BgjhLGEiENV2A680ZXF5d+J+gAhb42BugW1xpzb7qq8h51EniuusoSGrCzLcsvlPKcB3XUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=uhm7go/h; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724675919; x=1724935119;
	bh=RBOC+RDywST6N92zvalAllQSujzs0kpTlYmclip8eRc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uhm7go/hzA/XiJNo2AAbl0a48N/WIt8x+zhiS3fIUC7+4nXwJFvNkXu3Lrfjp0yVR
	 7hLeUtok2U4b1rlSCSY66zzP2cRseb2W1LjAhRGDFCJSSxeH0yFyFQocpDSixTAdHO
	 P2f2GWyZlJgahkGWVFxusZt0aNeZSBCoj5U5aeaOu0bdak4scbpTf7LUYqbxlaHZC3
	 FVLicOxZvcNvubH7IbBjfCrnXxZyTgzemN4zyO6q8qA65VMGaAn6LSwaZ6FrhZ8DiD
	 iL6wRHjaaIh5lLXnv5b8LN1AcjFDKKT2dM491dqi9de3wgRq5+tr8iyz9P/AeGnGng
	 2+kIPLFnCvquA==
Date: Mon, 26 Aug 2024 12:38:36 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v3 7/9] uio: add Xilinx user clock monitor support
Message-ID: <20240826123602.1872-8-hpausten@protonmail.com>
In-Reply-To: <20240826123602.1872-1-hpausten@protonmail.com>
References: <20240826123602.1872-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: e5939776709711e659ff91bcb8ce68658111b277
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xilinx clocking wizard IP core supports monitoring of up to four
optional user clock inputs, with a corresponding interrupt for
notification in change of clock state (stop, underrun, overrun or
glitch). Give userspace access to this monitor logic through use of the
UIO framework.

Implemented as an auxiliary_driver to avoid introducing UIO dependency
to the main clock driver.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 drivers/uio/Kconfig            |  8 ++++
 drivers/uio/Makefile           |  1 +
 drivers/uio/uio_xlnx_clk_mon.c | 71 ++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 drivers/uio/uio_xlnx_clk_mon.c

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index b060dcd7c6350..ca8a53de26a67 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -164,4 +164,12 @@ config UIO_DFL
 =09    opae-sdk/tools/libopaeuio/
=20
 =09  If you compile this as a module, it will be called uio_dfl.
+
+config UIO_XLNX_CLK_MON
+=09tristate "Xilinx user clock monitor support"
+=09depends on COMMON_CLK_XLNX_CLKWZRD
+=09help
+=09  Userspace I/O interface to the user clock monitor logic within the
+=09  Xilinx Clocking Wizard IP core.
+
 endif
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index 1c5f3b5a95cf5..1e8c242265431 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_MF624)         +=3D uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)=09+=3D uio_fsl_elbc_gpcm.o
 obj-$(CONFIG_UIO_HV_GENERIC)=09+=3D uio_hv_generic.o
 obj-$(CONFIG_UIO_DFL)=09+=3D uio_dfl.o
+obj-$(CONFIG_UIO_XLNX_CLK_MON)=09+=3D uio_xlnx_clk_mon.o
diff --git a/drivers/uio/uio_xlnx_clk_mon.c b/drivers/uio/uio_xlnx_clk_mon.=
c
new file mode 100644
index 0000000000000..afcbeae98eaaf
--- /dev/null
+++ b/drivers/uio/uio_xlnx_clk_mon.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for user clock monitor logic within Xilinx 'Clocking Wizard' IP =
core
+ *
+ * Copyright (C) 2024 Harry Austen <hpausten@protonmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/uio_driver.h>
+
+#define WZRD_INTR_ENABLE=090x10
+
+static int clk_mon_irqcontrol(struct uio_info *info, s32 irq_on)
+{
+=09if (irq_on)
+=09=09iowrite32(GENMASK(15, 0), info->mem[0].internal_addr + WZRD_INTR_ENA=
BLE);
+=09else
+=09=09iowrite32(0, info->mem[0].internal_addr + WZRD_INTR_ENABLE);
+
+=09return 0;
+}
+
+static int probe(struct auxiliary_device *adev, const struct auxiliary_dev=
ice_id *id)
+{
+=09struct platform_device *pdev =3D to_platform_device(adev->dev.parent);
+=09struct device *dev =3D &adev->dev;
+=09struct uio_info *info;
+=09int irq;
+
+=09info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+=09if (!info)
+=09=09return -ENOMEM;
+
+=09irq =3D platform_get_irq(pdev, 0);
+=09if (irq < 0)
+=09=09return 0;
+
+=09info->name =3D KBUILD_MODNAME;
+=09info->version =3D "0.0.1";
+
+=09info->mem[0].name =3D "clock monitor";
+=09info->mem[0].memtype =3D UIO_MEM_PHYS;
+=09info->mem[0].addr =3D platform_get_resource(pdev, IORESOURCE_IO, 0)->st=
art;
+=09info->mem[0].size =3D (WZRD_INTR_ENABLE + 4 + PAGE_SIZE - 1) & PAGE_MAS=
K;
+=09info->mem[0].internal_addr =3D (__force void __iomem *)dev->platform_da=
ta;
+
+=09info->irq =3D irq;
+=09info->irqcontrol =3D clk_mon_irqcontrol;
+=09return devm_uio_register_device(dev, info);
+}
+
+static struct auxiliary_device_id ids[] =3D {
+=09{ .name =3D "clk_xlnx_clock_wizard.clk-mon" },
+=09{}
+};
+MODULE_DEVICE_TABLE(auxiliary, ids);
+
+static struct auxiliary_driver xlnx_clk_mon_driver =3D {
+=09.id_table =3D ids,
+=09.probe =3D probe,
+};
+
+module_auxiliary_driver(xlnx_clk_mon_driver);
+
+MODULE_AUTHOR("Harry Austen <hpausten@protonmail.com>");
+MODULE_DESCRIPTION("Driver for Xilinx user clock monitor logic");
+MODULE_LICENSE("GPL");
--=20
2.46.0



