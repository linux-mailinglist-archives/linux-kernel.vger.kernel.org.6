Return-Path: <linux-kernel+bounces-301477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE995F172
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABD2826C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6211179958;
	Mon, 26 Aug 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rnNGkq2Z"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98816EC19;
	Mon, 26 Aug 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675903; cv=none; b=LFRlLlRZd+7JLrjbQ6nKzE7itUpvpSru+KGoqlivgwFOMM3mkjCodO6BSCOnu4fmsQAY1Vu94TBVqm3WgiKflSFLjV0zypjzfwsbnCAoGZzsV7dHGZ5DTQDdetAECZQTwp31+RuWEW2BCU+0G5YaQLqSywfPoehzhzazvVvx2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675903; c=relaxed/simple;
	bh=Cp/wdpFfcr8KNcsQ9M19F6cNZl5icvYiIeOWezrDwaY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXmOh+51Cm7B6JYSGiGGbl3vXdF2owaNCygR98yV1hcOCHUcz5/YqWChYgkfl94nbJc49uUSzuemf+IM4Est0p3zpGq6gg/l7kulUcJfjaq1f0zthMFbfClxsU+sUYSsicUIpN9WvPPFQf10Mv0+ZgzSdh0yk5m5R6xoCaRc4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rnNGkq2Z; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724675899; x=1724935099;
	bh=HpL57b35Xgk1jI0euyh2wxEnpr5lIQdBh0j+DUbMFwU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rnNGkq2ZE8jLrADIbN27FF51VfSijQ8xq1Cmv7Os9Fln2bc0c/40TAILXm7/xX+DO
	 ZIsIwqMA90v3vqe7RUt0KjkbJqo0cQzU1+FYOzukNN6PNZdXtrZZ98mpaK7qKvjDBG
	 p6Gbi6kE3uK0Ak/H2Dv1OleHZ021rboi/cASOJ2TliaVtWuSpedrwQBp7K0McCS+/f
	 JnXaCaCCfCMUUUnCajfAP0xJv0jTOnvbffGWcBKkGES2yYlZEokld9xdopQYcbx4LQ
	 DHJGhq3emP28pPdBGPJFV+frQS0zlxSzaBfF/e/XRiOg793KaewaoHYA5MpjwWyAS4
	 GFMFfNQ34hjng==
Date: Mon, 26 Aug 2024 12:38:14 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v3 2/9] clk: clocking-wizard: use newer clk_hw API
Message-ID: <20240826123602.1872-3-hpausten@protonmail.com>
In-Reply-To: <20240826123602.1872-1-hpausten@protonmail.com>
References: <20240826123602.1872-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 540320f489ab97a665acd4ab2d014861d1b470f7
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
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 77 +++++++++++-----------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 0ca045849ea3e..cd795a4952099 100644
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
@@ -121,26 +122,24 @@ enum clk_wzrd_int_clks {
 /**
  * struct clk_wzrd - Clock wizard private data structure
  *
- * @clk_data:=09=09Clock data
  * @nb:=09=09=09Notifier block
  * @base:=09=09Memory base
  * @clk_in1:=09=09Handle to input clock 'clk_in1'
  * @axi_clk:=09=09Handle to input clock 's_axi_aclk'
  * @clks_internal:=09Internal clocks
- * @clkout:=09=09Output clocks
  * @speed_grade:=09Speed grade of the device
  * @suspended:=09=09Flag indicating power state of the device
+ * @clk_data:=09=09Output clock data
  */
 struct clk_wzrd {
-=09struct clk_onecell_data clk_data;
 =09struct notifier_block nb;
 =09void __iomem *base;
 =09struct clk *clk_in1;
 =09struct clk *axi_clk;
-=09struct clk *clks_internal[wzrd_clk_int_max];
-=09struct clk *clkout[WZRD_NUM_OUTPUTS];
+=09struct clk_hw *clks_internal[wzrd_clk_int_max];
 =09unsigned int speed_grade;
 =09bool suspended;
+=09struct clk_hw_onecell_data clk_data;
 };
=20
 /**
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
@@ -978,7 +977,12 @@ static int clk_wzrd_probe(struct platform_device *pdev=
)
 =09int nr_outputs;
 =09int i, ret;
=20
-=09clk_wzrd =3D devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
+=09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
+=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
+=09=09return -EINVAL;
+
+=09clk_wzrd =3D devm_kzalloc(&pdev->dev, struct_size(clk_wzrd, clk_data.hw=
s, nr_outputs),
+=09=09=09=09GFP_KERNEL);
 =09if (!clk_wzrd)
 =09=09return -ENOMEM;
 =09platform_set_drvdata(pdev, clk_wzrd);
@@ -1016,17 +1020,13 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09if (data)
 =09=09is_versal =3D data->is_versal;
=20
-=09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
-=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
-=09=09return -EINVAL;
-
 =09clkout_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_out0", dev_n=
ame(&pdev->dev));
 =09if (!clkout_name)
 =09=09return -ENOMEM;
=20
 =09if (is_versal) {
 =09=09if (nr_outputs =3D=3D 1) {
-=09=09=09clk_wzrd->clkout[0] =3D clk_wzrd_ver_register_divider
+=09=09=09clk_wzrd->clk_data.hws[0] =3D clk_wzrd_ver_register_divider
 =09=09=09=09(&pdev->dev, clkout_name,
 =09=09=09=09__clk_get_name(clk_wzrd->clk_in1), 0,
 =09=09=09=09clk_wzrd->base, WZRD_CLK_CFG_REG(is_versal, 3),
@@ -1059,7 +1059,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09div =3D 64;
 =09} else {
 =09=09if (nr_outputs =3D=3D 1) {
-=09=09=09clk_wzrd->clkout[0] =3D clk_wzrd_register_divider
+=09=09=09clk_wzrd->clk_data.hws[0] =3D clk_wzrd_register_divider
 =09=09=09=09(&pdev->dev, clkout_name,
 =09=09=09=09__clk_get_name(clk_wzrd->clk_in1), 0,
 =09=09=09=09clk_wzrd->base, WZRD_CLK_CFG_REG(is_versal, 3),
@@ -1082,7 +1082,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
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
@@ -1108,15 +1108,15 @@ static int clk_wzrd_probe(struct platform_device *p=
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
@@ -1136,7 +1136,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09}
=20
 =09=09if (is_versal) {
-=09=09=09clk_wzrd->clkout[i] =3D clk_wzrd_ver_register_divider
+=09=09=09clk_wzrd->clk_data.hws[i] =3D clk_wzrd_ver_register_divider
 =09=09=09=09=09=09(&pdev->dev,
 =09=09=09=09=09=09 clkout_name, clk_name, 0,
 =09=09=09=09=09=09 clk_wzrd->base,
@@ -1148,7 +1148,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09=09=09=09=09 DIV_O, &clkwzrd_lock);
 =09=09} else {
 =09=09=09if (!i)
-=09=09=09=09clk_wzrd->clkout[i] =3D clk_wzrd_register_divf
+=09=09=09=09clk_wzrd->clk_data.hws[i] =3D clk_wzrd_register_divf
 =09=09=09=09=09(&pdev->dev, clkout_name, clk_name, flags, clk_wzrd->base,
 =09=09=09=09=09(WZRD_CLK_CFG_REG(is_versal, 2) + i * 12),
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
@@ -1156,7 +1156,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09=09=09=09CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 =09=09=09=09=09DIV_O, &clkwzrd_lock);
 =09=09=09else
-=09=09=09=09clk_wzrd->clkout[i] =3D clk_wzrd_register_divider
+=09=09=09=09clk_wzrd->clk_data.hws[i] =3D clk_wzrd_register_divider
 =09=09=09=09=09(&pdev->dev, clkout_name, clk_name, 0, clk_wzrd->base,
 =09=09=09=09=09(WZRD_CLK_CFG_REG(is_versal, 2) + i * 12),
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
@@ -1164,22 +1164,25 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09=09=09=09CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 =09=09=09=09=09DIV_O, &clkwzrd_lock);
 =09=09}
-=09=09if (IS_ERR(clk_wzrd->clkout[i])) {
+=09=09if (IS_ERR(clk_wzrd->clk_data.hws[i])) {
 =09=09=09int j;
=20
 =09=09=09for (j =3D i + 1; j < nr_outputs; j++)
-=09=09=09=09clk_unregister(clk_wzrd->clkout[j]);
+=09=09=09=09clk_hw_unregister(clk_wzrd->clk_data.hws[j]);
 =09=09=09dev_err(&pdev->dev,
 =09=09=09=09"unable to register divider clock\n");
-=09=09=09ret =3D PTR_ERR(clk_wzrd->clkout[i]);
+=09=09=09ret =3D PTR_ERR(clk_wzrd->clk_data.hws[i]);
 =09=09=09goto err_rm_int_clks;
 =09=09}
 =09}
=20
 out:
-=09clk_wzrd->clk_data.clks =3D clk_wzrd->clkout;
-=09clk_wzrd->clk_data.clk_num =3D ARRAY_SIZE(clk_wzrd->clkout);
-=09of_clk_add_provider(np, of_clk_src_onecell_get, &clk_wzrd->clk_data);
+=09clk_wzrd->clk_data.num =3D nr_outputs;
+=09ret =3D of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_onecell_get=
, &clk_wzrd->clk_data);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "unable to register clock provider\n");
+=09=09return ret;
+=09}
=20
 =09if (clk_wzrd->speed_grade) {
 =09=09clk_wzrd->nb.notifier_call =3D clk_wzrd_clk_notifier;
@@ -1200,9 +1203,9 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09return 0;
=20
 err_rm_int_clks:
-=09clk_unregister(clk_wzrd->clks_internal[1]);
+=09clk_hw_unregister(clk_wzrd->clks_internal[1]);
 err_rm_int_clk:
-=09clk_unregister(clk_wzrd->clks_internal[0]);
+=09clk_hw_unregister(clk_wzrd->clks_internal[0]);
 =09return ret;
 }
=20
@@ -1214,9 +1217,9 @@ static void clk_wzrd_remove(struct platform_device *p=
dev)
 =09of_clk_del_provider(pdev->dev.of_node);
=20
 =09for (i =3D 0; i < WZRD_NUM_OUTPUTS; i++)
-=09=09clk_unregister(clk_wzrd->clkout[i]);
+=09=09clk_hw_unregister(clk_wzrd->clk_data.hws[i]);
 =09for (i =3D 0; i < wzrd_clk_int_max; i++)
-=09=09clk_unregister(clk_wzrd->clks_internal[i]);
+=09=09clk_hw_unregister(clk_wzrd->clks_internal[i]);
 }
=20
 static const struct of_device_id clk_wzrd_ids[] =3D {
--=20
2.46.0



