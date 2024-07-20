Return-Path: <linux-kernel+bounces-257944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46C93812C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60ED128281E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7681E12F386;
	Sat, 20 Jul 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XKRNFcLf"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275BA142642;
	Sat, 20 Jul 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721476919; cv=none; b=aM5i15m0TMbniV4oaucTfjKuvtkHwHBOUNcWPLbQgxWf7XHbtTpPqtahJTAEaXtWLtgD4itj4xPm6fmp6PBoXs37kYTCl2yVdC/fqq1SWSMOlBAV0jv2JRYVOyxf1Dt4QQcOcANQFj7QNC25PXhfMizFJmGE0+l4CYBr9jnS1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721476919; c=relaxed/simple;
	bh=XOgrXmx36ocMe8yIaBXGwCdgaghYMUR0QuYNWB3MhaI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRgBkW2lMv50rRBTf9yTtXAQhhe96I1kTJIkboGhkkML4Ix9XXQWz4Sl/9TjHl7ymBzgKrRfZHkLqCe3Hw6Zq7uG15WUXLSkjOSJOJqCwgkzXaAZitRRUwslyDsQblOeCA9Re+RG8U3PpVM8mRBSDWlcORXTCa/YixeclkwVByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XKRNFcLf; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721476916; x=1721736116;
	bh=5jmaGGTO5BGOVrfoAL7oMQKQ1TobOvHpgQ3brd4v+V8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XKRNFcLfw8O4t/3COaptXfuxp7td5eg23225dmSe9YqpnFh1h+dwJTl442VUXoN3H
	 XztQjo7cCySyVdi0XDGVeEUdk0kb89cE85rTYvBKMaIHpfumi1O6E3eCgt+wqx/8KE
	 qoZYkTcnOdeJZx0sMsLqi6bueW5cQxToDPB/yfSe2HINtqGLOAjJInrftyrLpIER28
	 f0jpdbY6N1YjY5sn9RUslXJvL6hJcggCkuEYZENnRp3BVnOfWQd/2TOxBfVSeXMk6C
	 foAqNpO7IDpC4stg3v4h5z9WKfpXyF8vklBdq4neX1SAWnyJ6O7xCVwreRvp1m/I6e
	 YrNzgnxwEDXAw==
Date: Sat, 20 Jul 2024 12:01:53 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH 5/7] clk: clocking-wizard: add user clock monitor support
Message-ID: <20240720120048.36758-6-hpausten@protonmail.com>
In-Reply-To: <20240720120048.36758-1-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: f88c42a272ee02b36f2b255480c94508f9b0f581
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

Use presence of the user monitor interrupt description in devicetree to
indicate whether or not the UIO device should be registered. Also, this
functionality is only supported from v6.0 onwards, so add indication of
support to the device match data, in order to be tied to the utilised
compatible string.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 drivers/clk/xilinx/Kconfig                 |  1 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 67 ++++++++++++++++++++--
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/xilinx/Kconfig b/drivers/clk/xilinx/Kconfig
index 051756953558b..907a435694687 100644
--- a/drivers/clk/xilinx/Kconfig
+++ b/drivers/clk/xilinx/Kconfig
@@ -21,6 +21,7 @@ config COMMON_CLK_XLNX_CLKWZRD
 =09tristate "Xilinx Clocking Wizard"
 =09depends on OF
 =09depends on HAS_IOMEM
+=09depends on UIO
 =09help
 =09  Support for the Xilinx Clocking Wizard IP core clock generator.
 =09  Adds support for clocking wizard and compatible.
diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 7b262d73310fe..2d419e8ad4419 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -20,10 +20,13 @@
 #include <linux/overflow.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
+#include <linux/uio_driver.h>
=20
 #define WZRD_NUM_OUTPUTS=097
 #define WZRD_ACLK_MAX_FREQ=09250000000UL
=20
+#define WZRD_INTR_ENABLE=090x10
+
 #define WZRD_CLK_CFG_REG(v, n)=09(0x200 + 0x130 * (v) + 4 * (n))
=20
 #define WZRD_CLKOUT0_FRAC_EN=09BIT(18)
@@ -171,8 +174,9 @@ struct clk_wzrd_divider {
 =09spinlock_t *lock;  /* divider lock */
 };
=20
-struct versal_clk_data {
+struct clk_wzrd_data {
 =09bool is_versal;
+=09bool supports_monitor;
 };
=20
 #define to_clk_wzrd(_nb) container_of(_nb, struct clk_wzrd, nb)
@@ -958,16 +962,55 @@ static int __maybe_unused clk_wzrd_resume(struct devi=
ce *dev)
 static SIMPLE_DEV_PM_OPS(clk_wzrd_dev_pm_ops, clk_wzrd_suspend,
 =09=09=09 clk_wzrd_resume);
=20
-static const struct versal_clk_data versal_data =3D {
-=09.is_versal=09=3D true,
+static const struct clk_wzrd_data version_6_0_data =3D {
+=09.is_versal=09=09=3D false,
+=09.supports_monitor=09=3D true,
+};
+
+static const struct clk_wzrd_data versal_data =3D {
+=09.is_versal=09=09=3D true,
+=09.supports_monitor=09=3D true,
 };
=20
+static int clk_wzrd_irqcontrol(struct uio_info *info, s32 irq_on)
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
+static int clk_wzrd_setup_monitor(struct device *dev, int irq, const struc=
t resource *res)
+{
+=09struct clk_wzrd *clk_wzrd =3D dev_get_drvdata(dev);
+=09struct uio_info *info;
+
+=09info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+=09if (!info)
+=09=09return -ENOMEM;
+
+=09info->name =3D KBUILD_MODNAME;
+=09info->version =3D "0.0.1";
+
+=09info->mem[0].name =3D "user monitor";
+=09info->mem[0].memtype =3D UIO_MEM_PHYS;
+=09info->mem[0].addr =3D res->start;
+=09info->mem[0].size =3D WZRD_INTR_ENABLE;
+=09info->mem[0].internal_addr =3D clk_wzrd->base;
+
+=09info->irq =3D irq;
+=09info->irqcontrol =3D clk_wzrd_irqcontrol;
+=09return devm_uio_register_device(dev, info);
+}
+
 static int clk_wzrd_register_output_clocks(struct device *dev, int nr_outp=
uts)
 {
 =09const char *clkout_name, *clk_name, *clk_mul_name;
 =09struct clk_wzrd *clk_wzrd =3D dev_get_drvdata(dev);
 =09u32 regl, regh, edge, regld, reghd, edged, div;
-=09const struct versal_clk_data *data;
+=09const struct clk_wzrd_data *data;
 =09unsigned long flags =3D 0;
 =09bool is_versal =3D false;
 =09void __iomem *ctrl_reg;
@@ -1127,10 +1170,11 @@ static int clk_wzrd_register_output_clocks(struct d=
evice *dev, int nr_outputs)
 static int clk_wzrd_probe(struct platform_device *pdev)
 {
 =09struct device_node *np =3D pdev->dev.of_node;
+=09const struct clk_wzrd_data *data;
 =09struct clk_wzrd *clk_wzrd;
 =09unsigned long rate;
 =09int nr_outputs;
-=09int ret;
+=09int irq, ret;
=20
 =09clk_wzrd =3D devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
 =09if (!clk_wzrd)
@@ -1165,6 +1209,17 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
 =09=09return -EINVAL;
 =09}
=20
+=09data =3D device_get_match_data(&pdev->dev);
+=09if (data && data->supports_monitor) {
+=09=09irq =3D platform_get_irq(pdev, 0);
+=09=09if (irq > 0) {
+=09=09=09ret =3D clk_wzrd_setup_monitor(&pdev->dev, irq,
+=09=09=09=09=09=09     platform_get_resource(pdev, IORESOURCE_IO, 0));
+=09=09=09if (ret)
+=09=09=09=09return dev_err_probe(&pdev->dev, ret, "failed to setup monitor=
\n");
+=09=09}
+=09}
+
 =09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
 =09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
 =09=09return -EINVAL;
@@ -1208,7 +1263,7 @@ static const struct of_device_id clk_wzrd_ids[] =3D {
 =09{ .compatible =3D "xlnx,versal-clk-wizard", .data =3D &versal_data },
 =09{ .compatible =3D "xlnx,clocking-wizard"   },
 =09{ .compatible =3D "xlnx,clocking-wizard-v5.2"   },
-=09{ .compatible =3D "xlnx,clocking-wizard-v6.0"  },
+=09{ .compatible =3D "xlnx,clocking-wizard-v6.0", .data =3D &version_6_0_d=
ata },
 =09{ },
 };
 MODULE_DEVICE_TABLE(of, clk_wzrd_ids);
--=20
2.45.2



