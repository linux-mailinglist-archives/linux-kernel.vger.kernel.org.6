Return-Path: <linux-kernel+bounces-257941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2118938124
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E6D282116
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E484052;
	Sat, 20 Jul 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YnV+TIXy"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDE86645;
	Sat, 20 Jul 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721476907; cv=none; b=Da44ec94TKsWm77zhgdCIBe4IBCGJjm9V9xLXXlU80uIiz0YIZoWwDq0VZI21vi/Dv/440ryDaNa3FUue9hLgvrQazJFyg/aUlSvzy70til3XlopDl3Y1fN35XeN6wLTd6QrPfnzngpWTaiRUgq+4lDbGQSzAzmSye6VgoTG12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721476907; c=relaxed/simple;
	bh=bAR34Bj3/CU3OixdApV8Gt3dj9CwU5YhvuMIzZtxORo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1EiYbeAvY4ZQ4bIK9OYltqg8IfOAmtCj7duurF6vyYO4Iy6q1c3QgzHv0K7Iz3ogvx9qeJl+YP5wpQ4coDaibWP1mNJuyyYOOWR9BVRKWifOapgFvYybzzuQGHH1JOYKl47dvn72xt0NnDdMoWWe8cNFdvoJxHT1gTX4Pb2AwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=YnV+TIXy; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721476899; x=1721736099;
	bh=b+my+Pzqz+8pBWPLWyBxzD6/LSOG2F/F1JP1sZoQBH8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YnV+TIXywSIWCHKYYpgnjNbJbQ7TZdIRlaRgeifJ/CBQZtN1m0LC1JZcA18CABI86
	 BHzV1CFPWRg/Zh1SW57+a+2uEP1zXKmqQAUjcFL7cdposFmht+LLxrfPEgoakxztMN
	 /qrilBf+EryCLR3T9A0UJK24X4rtbYv5TXcqfWs8oXa9noIufv8fJ2vsF2dGCT5sR0
	 HSyjwupohK7PcbpxjYmVbz03ibOjYLPkx7Cgbv5Eyj551jzfyKdyN1ohHlSR3koHcR
	 jnam18egGKC3UPBueHVCxUUWPlQJeldLru1qGW6hyL0aLUEqLOszY6tS1wvcBsogFu
	 LhYWw6l1HciFw==
Date: Sat, 20 Jul 2024 12:01:36 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH 2/7] clk: clocking-wizard: use newer clk_hw API
Message-ID: <20240720120048.36758-3-hpausten@protonmail.com>
In-Reply-To: <20240720120048.36758-1-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 6d2cc723cb0fbc2a43e76000cee6a5ab25071872
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Utilise clock provider API with struct clk_hw instances instead of the
consumer-side struct clk.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 101 ++++++++-------------
 1 file changed, 39 insertions(+), 62 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 0ca045849ea3e..30c5cc9dcd7e9 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
=20
@@ -121,24 +122,22 @@ enum clk_wzrd_int_clks {
 /**
  * struct clk_wzrd - Clock wizard private data structure
  *
- * @clk_data:=09=09Clock data
+ * @clk_data:=09=09Output clock data
  * @nb:=09=09=09Notifier block
  * @base:=09=09Memory base
  * @clk_in1:=09=09Handle to input clock 'clk_in1'
  * @axi_clk:=09=09Handle to input clock 's_axi_aclk'
  * @clks_internal:=09Internal clocks
- * @clkout:=09=09Output clocks
  * @speed_grade:=09Speed grade of the device
  * @suspended:=09=09Flag indicating power state of the device
  */
 struct clk_wzrd {
-=09struct clk_onecell_data clk_data;
+=09struct clk_hw_onecell_data *clk_data;
 =09struct notifier_block nb;
 =09void __iomem *base;
 =09struct clk *clk_in1;
 =09struct clk *axi_clk;
-=09struct clk *clks_internal[wzrd_clk_int_max];
-=09struct clk *clkout[WZRD_NUM_OUTPUTS];
+=09struct clk_hw *clks_internal[wzrd_clk_int_max];
 =09unsigned int speed_grade;
 =09bool suspended;
 };
@@ -765,7 +764,7 @@ static const struct clk_ops clk_wzrd_clk_divider_ops_f =
=3D {
 =09.recalc_rate =3D clk_wzrd_recalc_ratef,
 };
=20
-static struct clk *clk_wzrd_register_divf(struct device *dev,
+static struct clk_hw *clk_wzrd_register_divf(struct device *dev,
 =09=09=09=09=09  const char *name,
 =09=09=09=09=09  const char *parent_name,
 =09=09=09=09=09  unsigned long flags,
@@ -805,10 +804,10 @@ static struct clk *clk_wzrd_register_divf(struct devi=
ce *dev,
 =09if (ret)
 =09=09return ERR_PTR(ret);
=20
-=09return hw->clk;
+=09return hw;
 }
=20
-static struct clk *clk_wzrd_ver_register_divider(struct device *dev,
+static struct clk_hw *clk_wzrd_ver_register_divider(struct device *dev,
 =09=09=09=09=09=09 const char *name,
 =09=09=09=09=09=09 const char *parent_name,
 =09=09=09=09=09=09 unsigned long flags,
@@ -852,10 +851,10 @@ static struct clk *clk_wzrd_ver_register_divider(stru=
ct device *dev,
 =09if (ret)
 =09=09return ERR_PTR(ret);
=20
-=09return hw->clk;
+=09return hw;
 }
=20
-static struct clk *clk_wzrd_register_divider(struct device *dev,
+static struct clk_hw *clk_wzrd_register_divider(struct device *dev,
 =09=09=09=09=09     const char *name,
 =09=09=09=09=09     const char *parent_name,
 =09=09=09=09=09     unsigned long flags,
@@ -898,7 +897,7 @@ static struct clk *clk_wzrd_register_divider(struct dev=
ice *dev,
 =09if (ret)
 =09=09return ERR_PTR(ret);
=20
-=09return hw->clk;
+=09return hw;
 }
=20
 static int clk_wzrd_clk_notifier(struct notifier_block *nb, unsigned long =
event,
@@ -1020,13 +1019,18 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
 =09=09return -EINVAL;
=20
+=09clk_wzrd->clk_data =3D devm_kzalloc(&pdev->dev, struct_size(clk_wzrd->c=
lk_data, hws,
+=09=09=09=09=09  nr_outputs), GFP_KERNEL);
+=09if (!clk_wzrd->clk_data)
+=09=09return -ENOMEM;
+
 =09clkout_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_out0", dev_n=
ame(&pdev->dev));
 =09if (!clkout_name)
 =09=09return -ENOMEM;
=20
 =09if (is_versal) {
 =09=09if (nr_outputs =3D=3D 1) {
-=09=09=09clk_wzrd->clkout[0] =3D clk_wzrd_ver_register_divider
+=09=09=09clk_wzrd->clk_data->hws[0] =3D clk_wzrd_ver_register_divider
 =09=09=09=09(&pdev->dev, clkout_name,
 =09=09=09=09__clk_get_name(clk_wzrd->clk_in1), 0,
 =09=09=09=09clk_wzrd->base, WZRD_CLK_CFG_REG(is_versal, 3),
@@ -1059,7 +1063,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09div =3D 64;
 =09} else {
 =09=09if (nr_outputs =3D=3D 1) {
-=09=09=09clk_wzrd->clkout[0] =3D clk_wzrd_register_divider
+=09=09=09clk_wzrd->clk_data->hws[0] =3D clk_wzrd_register_divider
 =09=09=09=09(&pdev->dev, clkout_name,
 =09=09=09=09__clk_get_name(clk_wzrd->clk_in1), 0,
 =09=09=09=09clk_wzrd->base, WZRD_CLK_CFG_REG(is_versal, 3),
@@ -1082,7 +1086,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09clk_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_mul", dev_name(=
&pdev->dev));
 =09if (!clk_name)
 =09=09return -ENOMEM;
-=09clk_wzrd->clks_internal[wzrd_clk_mul] =3D clk_register_fixed_factor
+=09clk_wzrd->clks_internal[wzrd_clk_mul] =3D clk_hw_register_fixed_factor
 =09=09=09(&pdev->dev, clk_name,
 =09=09=09 __clk_get_name(clk_wzrd->clk_in1),
 =09=09=090, mult, div);
@@ -1092,10 +1096,8 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
 =09}
=20
 =09clk_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_mul_div", dev_n=
ame(&pdev->dev));
-=09if (!clk_name) {
-=09=09ret =3D -ENOMEM;
-=09=09goto err_rm_int_clk;
-=09}
+=09if (!clk_name)
+=09=09return -ENOMEM;
=20
 =09if (is_versal) {
 =09=09edged =3D !!(readl(clk_wzrd->base + WZRD_CLK_CFG_REG(is_versal, 20))=
 &
@@ -1108,35 +1110,32 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09if (!div)
 =09=09=09div =3D 1;
=20
-=09=09clk_mul_name =3D __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul=
]);
+=09=09clk_mul_name =3D clk_hw_get_name(clk_wzrd->clks_internal[wzrd_clk_mu=
l]);
 =09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D
-=09=09=09clk_register_fixed_factor(&pdev->dev, clk_name,
-=09=09=09=09=09=09  clk_mul_name, 0, 1, div);
+=09=09=09clk_hw_register_fixed_factor(&pdev->dev, clk_name,
+=09=09=09=09=09=09     clk_mul_name, 0, 1, div);
 =09} else {
 =09=09ctrl_reg =3D clk_wzrd->base + WZRD_CLK_CFG_REG(is_versal, 0);
-=09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D clk_register_divider
+=09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D clk_hw_register_divide=
r
 =09=09=09(&pdev->dev, clk_name,
-=09=09=09 __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
+=09=09=09 clk_hw_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
 =09=09=09flags, ctrl_reg, 0, 8, CLK_DIVIDER_ONE_BASED |
 =09=09=09CLK_DIVIDER_ALLOW_ZERO, &clkwzrd_lock);
 =09}
 =09if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
 =09=09dev_err(&pdev->dev, "unable to register divider clock\n");
-=09=09ret =3D PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
-=09=09goto err_rm_int_clk;
+=09=09return PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
 =09}
=20
 =09/* register div per output */
 =09for (i =3D nr_outputs - 1; i >=3D 0 ; i--) {
 =09=09clkout_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
 =09=09=09=09=09     "%s_out%d", dev_name(&pdev->dev), i);
-=09=09if (!clkout_name) {
-=09=09=09ret =3D -ENOMEM;
-=09=09=09goto err_rm_int_clk;
-=09=09}
+=09=09if (!clkout_name)
+=09=09=09return -ENOMEM;
=20
 =09=09if (is_versal) {
-=09=09=09clk_wzrd->clkout[i] =3D clk_wzrd_ver_register_divider
+=09=09=09clk_wzrd->clk_data->hws[i] =3D clk_wzrd_ver_register_divider
 =09=09=09=09=09=09(&pdev->dev,
 =09=09=09=09=09=09 clkout_name, clk_name, 0,
 =09=09=09=09=09=09 clk_wzrd->base,
@@ -1148,7 +1147,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09=09=09=09=09 DIV_O, &clkwzrd_lock);
 =09=09} else {
 =09=09=09if (!i)
-=09=09=09=09clk_wzrd->clkout[i] =3D clk_wzrd_register_divf
+=09=09=09=09clk_wzrd->clk_data->hws[i] =3D clk_wzrd_register_divf
 =09=09=09=09=09(&pdev->dev, clkout_name, clk_name, flags, clk_wzrd->base,
 =09=09=09=09=09(WZRD_CLK_CFG_REG(is_versal, 2) + i * 12),
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
@@ -1156,7 +1155,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09=09=09=09CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 =09=09=09=09=09DIV_O, &clkwzrd_lock);
 =09=09=09else
-=09=09=09=09clk_wzrd->clkout[i] =3D clk_wzrd_register_divider
+=09=09=09=09clk_wzrd->clk_data->hws[i] =3D clk_wzrd_register_divider
 =09=09=09=09=09(&pdev->dev, clkout_name, clk_name, 0, clk_wzrd->base,
 =09=09=09=09=09(WZRD_CLK_CFG_REG(is_versal, 2) + i * 12),
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
@@ -1164,22 +1163,20 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09=09=09=09CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 =09=09=09=09=09DIV_O, &clkwzrd_lock);
 =09=09}
-=09=09if (IS_ERR(clk_wzrd->clkout[i])) {
-=09=09=09int j;
-
-=09=09=09for (j =3D i + 1; j < nr_outputs; j++)
-=09=09=09=09clk_unregister(clk_wzrd->clkout[j]);
+=09=09if (IS_ERR(clk_wzrd->clk_data->hws[i])) {
 =09=09=09dev_err(&pdev->dev,
 =09=09=09=09"unable to register divider clock\n");
-=09=09=09ret =3D PTR_ERR(clk_wzrd->clkout[i]);
-=09=09=09goto err_rm_int_clks;
+=09=09=09return PTR_ERR(clk_wzrd->clk_data->hws[i]);
 =09=09}
 =09}
=20
 out:
-=09clk_wzrd->clk_data.clks =3D clk_wzrd->clkout;
-=09clk_wzrd->clk_data.clk_num =3D ARRAY_SIZE(clk_wzrd->clkout);
-=09of_clk_add_provider(np, of_clk_src_onecell_get, &clk_wzrd->clk_data);
+=09clk_wzrd->clk_data->num =3D nr_outputs;
+=09ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get, =
clk_wzrd->clk_data);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "unable to register clock provider\n");
+=09=09return ret;
+=09}
=20
 =09if (clk_wzrd->speed_grade) {
 =09=09clk_wzrd->nb.notifier_call =3D clk_wzrd_clk_notifier;
@@ -1198,25 +1195,6 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
 =09}
=20
 =09return 0;
-
-err_rm_int_clks:
-=09clk_unregister(clk_wzrd->clks_internal[1]);
-err_rm_int_clk:
-=09clk_unregister(clk_wzrd->clks_internal[0]);
-=09return ret;
-}
-
-static void clk_wzrd_remove(struct platform_device *pdev)
-{
-=09int i;
-=09struct clk_wzrd *clk_wzrd =3D platform_get_drvdata(pdev);
-
-=09of_clk_del_provider(pdev->dev.of_node);
-
-=09for (i =3D 0; i < WZRD_NUM_OUTPUTS; i++)
-=09=09clk_unregister(clk_wzrd->clkout[i]);
-=09for (i =3D 0; i < wzrd_clk_int_max; i++)
-=09=09clk_unregister(clk_wzrd->clks_internal[i]);
 }
=20
 static const struct of_device_id clk_wzrd_ids[] =3D {
@@ -1235,7 +1213,6 @@ static struct platform_driver clk_wzrd_driver =3D {
 =09=09.pm =3D &clk_wzrd_dev_pm_ops,
 =09},
 =09.probe =3D clk_wzrd_probe,
-=09.remove_new =3D clk_wzrd_remove,
 };
 module_platform_driver(clk_wzrd_driver);
=20
--=20
2.45.2



