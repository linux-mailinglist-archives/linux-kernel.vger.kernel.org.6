Return-Path: <linux-kernel+bounces-273438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF23946941
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DAA1C20C49
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663B1514F1;
	Sat,  3 Aug 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KtgwXZRc"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2214EC56;
	Sat,  3 Aug 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682711; cv=none; b=DIoacBxNFvBxImzms9c8e9+t45joqQLdYvWeO6rq+ZOjZjm8yvtnoEyGfs9YkTXv3l+Qr1c0kyXiYf2XD02/ciAipvaruEgh1GqyMG3cDxFmMrXq+zmzrfCJPmwdIK4+3aBI42RqlmX96qeXLZZ05pbZ+pGwS/Z7Rku0mm4oyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682711; c=relaxed/simple;
	bh=gvWrW/1wtge8jipyut5vNCvN2H6YSOziPTrjTVdSIWA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoayBPfRoBQ9QEbLNsFOr9b5+0QDLD186W/xSWqkLhMajqk2uomA3f7jMuUa2g0Ne1OuJ94ksPxxtMFFx1UhHPlHD1wji9Mzkr0g6+A8igyIrohyccqUKchLl80HIO0nUSOdjpAAnKoQgn6NR/lp3E8rln51QZJhwr9j8+oo2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KtgwXZRc; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722682707; x=1722941907;
	bh=llyHHwAfUnsQLIATlG97RZG3ZZL4o5MlcbSrH2uwttg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KtgwXZRcvI58S6gOfvukZO9zhvLEuRtNpQVrE9J8XQNIjLKvXc+4CEiD+Nxh/HmMR
	 glDD7qqvsGWhNVExbjIz7J0irBda6n0E55BqDYb1UajKCFpOl7bS+LNcC2cthNwPsP
	 wzFyBZYSn8tp6D6CVcCnCasvEY2lJseFyE03ayO5bIxCV0dMXpUkQljYfgGYvYPc0g
	 QxPQS1hxMGzTLE1EpkLjqDXwhYbRNz42L3MX1vOjasxf3eu+jHhwKXFRtIfxJLSXVD
	 kbze4Ny2LdU85VhXjdodobsqsFGm6wLcUoIWGnzoATvV6biAn73ZnlNqtQk4a9kEw2
	 guYTJp2FUb+CQ==
Date: Sat, 03 Aug 2024 10:58:24 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 6/9] clk: clocking-wizard: add user clock monitor support
Message-ID: <20240803105702.9621-7-hpausten@protonmail.com>
In-Reply-To: <20240803105702.9621-1-hpausten@protonmail.com>
References: <20240803105702.9621-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 53032881eef22176f8403430de3565ccf3a6858e
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
glitch). Give access to this monitor logic through use of an auxiliary
device.

Use presence of the user monitor interrupt description in devicetree to
indicate whether or not the auxiliary device should be registered. Also,
this functionality is only supported from v6.0 onwards, so add
indication of support to the device match data, in order to be tied to
the utilised compatible string.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
v1 -> v2:
- Remove direct UIO dependency by utilising auxiliary device
- Move some logic from probe into clk_wzrd_setup_monitor for tidiness

 drivers/clk/xilinx/Kconfig                 |  1 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 60 ++++++++++++++++++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/xilinx/Kconfig b/drivers/clk/xilinx/Kconfig
index 051756953558b..87f507bd9b6f3 100644
--- a/drivers/clk/xilinx/Kconfig
+++ b/drivers/clk/xilinx/Kconfig
@@ -21,6 +21,7 @@ config COMMON_CLK_XLNX_CLKWZRD
 =09tristate "Xilinx Clocking Wizard"
 =09depends on OF
 =09depends on HAS_IOMEM
+=09select AUXILIARY_BUS
 =09help
 =09  Support for the Xilinx Clocking Wizard IP core clock generator.
 =09  Adds support for clocking wizard and compatible.
diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 1f8023d24029f..557e11017faf9 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -8,6 +8,7 @@
  *
  */
=20
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
@@ -129,6 +130,7 @@ enum clk_wzrd_int_clks {
  * @axi_clk:=09=09Handle to input clock 's_axi_aclk'
  * @clks_internal:=09Internal clocks
  * @speed_grade:=09Speed grade of the device
+ * @adev:=09=09User clock monitor auxiliary device
  * @suspended:=09=09Flag indicating power state of the device
  */
 struct clk_wzrd {
@@ -139,6 +141,7 @@ struct clk_wzrd {
 =09struct clk_hw *clks_internal[wzrd_clk_int_max];
 =09unsigned int speed_grade;
 =09bool suspended;
+=09struct auxiliary_device adev;
 =09struct clk_hw_onecell_data clk_data;
 };
=20
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
@@ -958,16 +962,58 @@ static int __maybe_unused clk_wzrd_resume(struct devi=
ce *dev)
 static SIMPLE_DEV_PM_OPS(clk_wzrd_dev_pm_ops, clk_wzrd_suspend,
 =09=09=09 clk_wzrd_resume);
=20
-static const struct versal_clk_data versal_data =3D {
-=09.is_versal=09=3D true,
+static const struct clk_wzrd_data version_6_0_data =3D {
+=09.is_versal=09=09=3D false,
+=09.supports_monitor=09=3D true,
 };
=20
+static const struct clk_wzrd_data versal_data =3D {
+=09.is_versal=09=09=3D true,
+=09.supports_monitor=09=3D true,
+};
+
+static void clk_wzrd_unregister_adev(void *_adev)
+{
+=09struct auxiliary_device *adev =3D _adev;
+
+=09auxiliary_device_delete(adev);
+=09auxiliary_device_uninit(adev);
+}
+
+static int clk_wzrd_setup_monitor(struct platform_device *pdev)
+{
+=09struct device *dev =3D &pdev->dev;
+=09const struct clk_wzrd_data *data =3D device_get_match_data(dev);
+=09struct clk_wzrd *clk_wzrd =3D dev_get_drvdata(dev);
+=09struct auxiliary_device *adev =3D &clk_wzrd->adev;
+=09int ret;
+
+=09if (!data || !data->supports_monitor)
+=09=09return 0;
+
+=09adev->name =3D "clk-mon";
+=09adev->dev.parent =3D dev;
+=09adev->dev.platform_data =3D (__force void *)clk_wzrd->base;
+
+=09ret =3D auxiliary_device_init(adev);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D auxiliary_device_add(adev);
+=09if (ret) {
+=09=09auxiliary_device_uninit(adev);
+=09=09return ret;
+=09}
+
+=09return devm_add_action_or_reset(dev, clk_wzrd_unregister_adev, adev);
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
@@ -1170,6 +1216,10 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
 =09=09return -EINVAL;
 =09}
=20
+=09ret =3D clk_wzrd_setup_monitor(pdev);
+=09if (ret)
+=09=09return dev_err_probe(&pdev->dev, ret, "failed to setup monitor\n");
+
 =09ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs);
 =09if (ret)
 =09=09return ret;
@@ -1204,7 +1254,7 @@ static const struct of_device_id clk_wzrd_ids[] =3D {
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
2.46.0



