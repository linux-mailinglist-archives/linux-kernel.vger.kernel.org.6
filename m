Return-Path: <linux-kernel+bounces-328771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D7978899
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94990B25A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5AA146D53;
	Fri, 13 Sep 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ed7tRmub"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21271465A4;
	Fri, 13 Sep 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254698; cv=none; b=PWfNStE0N9+ZG51xCCOGMtM10l3gbuK7UdUIGKx2e+Si5InR49KHdwaBdJXGCoRgfoaS1BraJ+DANoH0iu/OI37BtMS62LmnTXdnHfJuJv6aD7y+1IIFCOrYWkx5dzeYI6IxQj8DuE2i2yDHHuH9uCgBg+D/j2sVK0sbF/i4uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254698; c=relaxed/simple;
	bh=Cmvb9v7ErBT+zz3Mh/JY2S9DNhwAg9EYNg152PFLStc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkeiWC/a4VKX6iePRy3VG6wpQYBWB52M91Rj2z/2N8T8Pje/meiO4mrqX3jZ0RgSCFZTjB16tCopmIUtutGNaLFPRZQcShviIy7brGZ9bV+wviJIh71y6F3gkgoYomOBqRqrEHjBEvyPK9pYMs0uKK3a/GQZTi96kcd5IGx3vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ed7tRmub; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726254694; x=1726513894;
	bh=NUYqQAvuUojX9asIccPtUZ8xbqnpZCMJ1CsUSTncDQc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ed7tRmubYQkQtdaEmrO5iwMl/B06EXnYZLVxvJR4BA8MpCFVhMy/AzTJqgv5gbGyg
	 P+Ajqhb7IeLq/moq4LIffKIrH6UGDaBePjxIdedVT26KXhLOIPLtxnuFMMi67qIL8z
	 5k+GV34e4gVhj6o7SEoontlGAUzOwDJvwspb+valWFAGzp33/5Y7Rj+KsiYfisASlx
	 nQTCdk1AYLWnt9f9jIQuaPC6X5R+n3TbFGF6PTJRXDejJNvkk53mvML3NtQAWQxEEi
	 tcjpRf6YaZOQCR7/c5AaNuSMAopAZzua3BoSghULnqg+9MYZuEOtQzy7lv+DBimSQI
	 qbxxxwuhjBAdA==
Date: Fri, 13 Sep 2024 19:11:32 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 4/6] clk: clocking-wizard: move clock registration to separate function
Message-ID: <20240913191037.2690-5-hpausten@protonmail.com>
In-Reply-To: <20240913191037.2690-1-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 36ca9d4e2c22f23203d6e50fe690f1a364ddcdd8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Provide clear separation of dynamic reconfiguration logic, by moving its
setup procedure to its own dedicated function.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
v1 -> v2: No change

 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 143 +++++++++++----------
 1 file changed, 75 insertions(+), 68 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index f332e0eee56c8..1a65a7d153c35 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -962,72 +962,30 @@ static const struct versal_clk_data versal_data =3D {
 =09.is_versal=09=3D true,
 };
=20
-static int clk_wzrd_probe(struct platform_device *pdev)
+static int clk_wzrd_register_output_clocks(struct device *dev, int nr_outp=
uts)
 {
 =09const char *clkout_name, *clk_name, *clk_mul_name;
+=09struct clk_wzrd *clk_wzrd =3D dev_get_drvdata(dev);
 =09u32 regl, regh, edge, regld, reghd, edged, div;
-=09struct device_node *np =3D pdev->dev.of_node;
 =09const struct versal_clk_data *data;
-=09struct clk_wzrd *clk_wzrd;
 =09unsigned long flags =3D 0;
+=09bool is_versal =3D false;
 =09void __iomem *ctrl_reg;
 =09u32 reg, reg_f, mult;
-=09bool is_versal =3D false;
-=09unsigned long rate;
-=09int nr_outputs;
-=09int i, ret;
-
-=09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
-=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
-=09=09return -EINVAL;
-
-=09clk_wzrd =3D devm_kzalloc(&pdev->dev, struct_size(clk_wzrd, clk_data.hw=
s, nr_outputs),
-=09=09=09=09GFP_KERNEL);
-=09if (!clk_wzrd)
-=09=09return -ENOMEM;
-=09platform_set_drvdata(pdev, clk_wzrd);
-
-=09clk_wzrd->base =3D devm_platform_ioremap_resource(pdev, 0);
-=09if (IS_ERR(clk_wzrd->base))
-=09=09return PTR_ERR(clk_wzrd->base);
-
-=09ret =3D of_property_read_u32(np, "xlnx,speed-grade", &clk_wzrd->speed_g=
rade);
-=09if (!ret) {
-=09=09if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade > 3) {
-=09=09=09dev_warn(&pdev->dev, "invalid speed grade '%d'\n",
-=09=09=09=09 clk_wzrd->speed_grade);
-=09=09=09clk_wzrd->speed_grade =3D 0;
-=09=09}
-=09}
-
-=09clk_wzrd->clk_in1 =3D devm_clk_get(&pdev->dev, "clk_in1");
-=09if (IS_ERR(clk_wzrd->clk_in1))
-=09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_in1),
-=09=09=09=09     "clk_in1 not found\n");
+=09int i;
=20
-=09clk_wzrd->axi_clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
-=09if (IS_ERR(clk_wzrd->axi_clk))
-=09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->axi_clk),
-=09=09=09=09     "s_axi_aclk not found\n");
-=09rate =3D clk_get_rate(clk_wzrd->axi_clk);
-=09if (rate > WZRD_ACLK_MAX_FREQ) {
-=09=09dev_err(&pdev->dev, "s_axi_aclk frequency (%lu) too high\n",
-=09=09=09rate);
-=09=09return -EINVAL;
-=09}
-
-=09data =3D device_get_match_data(&pdev->dev);
+=09data =3D device_get_match_data(dev);
 =09if (data)
 =09=09is_versal =3D data->is_versal;
=20
-=09clkout_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_out0", dev_n=
ame(&pdev->dev));
+=09clkout_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_out0", dev_name(dev=
));
 =09if (!clkout_name)
 =09=09return -ENOMEM;
=20
 =09if (is_versal) {
 =09=09if (nr_outputs =3D=3D 1) {
 =09=09=09clk_wzrd->clk_data.hws[0] =3D clk_wzrd_ver_register_divider
-=09=09=09=09(&pdev->dev, clkout_name,
+=09=09=09=09(dev, clkout_name,
 =09=09=09=09__clk_get_name(clk_wzrd->clk_in1), 0,
 =09=09=09=09clk_wzrd->base, WZRD_CLK_CFG_REG(is_versal, 3),
 =09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
@@ -1035,7 +993,7 @@ static int clk_wzrd_probe(struct platform_device *pdev=
)
 =09=09=09=09CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 =09=09=09=09DIV_ALL, &clkwzrd_lock);
=20
-=09=09=09goto out;
+=09=09=09return 0;
 =09=09}
 =09=09/* register multiplier */
 =09=09edge =3D !!(readl(clk_wzrd->base + WZRD_CLK_CFG_REG(is_versal, 0)) &
@@ -1060,7 +1018,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09} else {
 =09=09if (nr_outputs =3D=3D 1) {
 =09=09=09clk_wzrd->clk_data.hws[0] =3D clk_wzrd_register_divider
-=09=09=09=09(&pdev->dev, clkout_name,
+=09=09=09=09(dev, clkout_name,
 =09=09=09=09__clk_get_name(clk_wzrd->clk_in1), 0,
 =09=09=09=09clk_wzrd->base, WZRD_CLK_CFG_REG(is_versal, 3),
 =09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
@@ -1068,7 +1026,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09=09=09CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 =09=09=09=09DIV_ALL, &clkwzrd_lock);
=20
-=09=09=09goto out;
+=09=09=09return 0;
 =09=09}
 =09=09reg =3D readl(clk_wzrd->base + WZRD_CLK_CFG_REG(is_versal, 0));
 =09=09reg_f =3D reg & WZRD_CLKFBOUT_FRAC_MASK;
@@ -1079,19 +1037,19 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09mult =3D (reg * 1000) + reg_f;
 =09=09div =3D 1000;
 =09}
-=09clk_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_mul", dev_name(=
&pdev->dev));
+=09clk_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_mul", dev_name(dev));
 =09if (!clk_name)
 =09=09return -ENOMEM;
 =09clk_wzrd->clks_internal[wzrd_clk_mul] =3D devm_clk_hw_register_fixed_fa=
ctor
-=09=09=09(&pdev->dev, clk_name,
+=09=09=09(dev, clk_name,
 =09=09=09 __clk_get_name(clk_wzrd->clk_in1),
 =09=09=090, mult, div);
 =09if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul])) {
-=09=09dev_err(&pdev->dev, "unable to register fixed-factor clock\n");
+=09=09dev_err(dev, "unable to register fixed-factor clock\n");
 =09=09return PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul]);
 =09}
=20
-=09clk_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_mul_div", dev_n=
ame(&pdev->dev));
+=09clk_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_mul_div", dev_name(dev=
));
 =09if (!clk_name)
 =09=09return -ENOMEM;
=20
@@ -1108,31 +1066,29 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
=20
 =09=09clk_mul_name =3D clk_hw_get_name(clk_wzrd->clks_internal[wzrd_clk_mu=
l]);
 =09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D
-=09=09=09devm_clk_hw_register_fixed_factor(&pdev->dev, clk_name,
-=09=09=09=09=09=09=09  clk_mul_name, 0, 1, div);
+=09=09=09devm_clk_hw_register_fixed_factor(dev, clk_name, clk_mul_name, 0,=
 1, div);
 =09} else {
 =09=09ctrl_reg =3D clk_wzrd->base + WZRD_CLK_CFG_REG(is_versal, 0);
 =09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D devm_clk_hw_register_d=
ivider
-=09=09=09(&pdev->dev, clk_name,
+=09=09=09(dev, clk_name,
 =09=09=09 clk_hw_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
 =09=09=09flags, ctrl_reg, 0, 8, CLK_DIVIDER_ONE_BASED |
 =09=09=09CLK_DIVIDER_ALLOW_ZERO, &clkwzrd_lock);
 =09}
 =09if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
-=09=09dev_err(&pdev->dev, "unable to register divider clock\n");
+=09=09dev_err(dev, "unable to register divider clock\n");
 =09=09return PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
 =09}
=20
 =09/* register div per output */
 =09for (i =3D nr_outputs - 1; i >=3D 0 ; i--) {
-=09=09clkout_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
-=09=09=09=09=09     "%s_out%d", dev_name(&pdev->dev), i);
+=09=09clkout_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_out%d", dev_name=
(dev), i);
 =09=09if (!clkout_name)
 =09=09=09return -ENOMEM;
=20
 =09=09if (is_versal) {
 =09=09=09clk_wzrd->clk_data.hws[i] =3D clk_wzrd_ver_register_divider
-=09=09=09=09=09=09(&pdev->dev,
+=09=09=09=09=09=09(dev,
 =09=09=09=09=09=09 clkout_name, clk_name, 0,
 =09=09=09=09=09=09 clk_wzrd->base,
 =09=09=09=09=09=09 (WZRD_CLK_CFG_REG(is_versal, 3) + i * 8),
@@ -1144,7 +1100,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09} else {
 =09=09=09if (!i)
 =09=09=09=09clk_wzrd->clk_data.hws[i] =3D clk_wzrd_register_divf
-=09=09=09=09=09(&pdev->dev, clkout_name, clk_name, flags, clk_wzrd->base,
+=09=09=09=09=09(dev, clkout_name, clk_name, flags, clk_wzrd->base,
 =09=09=09=09=09(WZRD_CLK_CFG_REG(is_versal, 2) + i * 12),
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_WIDTH,
@@ -1152,7 +1108,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09=09=09=09=09DIV_O, &clkwzrd_lock);
 =09=09=09else
 =09=09=09=09clk_wzrd->clk_data.hws[i] =3D clk_wzrd_register_divider
-=09=09=09=09=09(&pdev->dev, clkout_name, clk_name, 0, clk_wzrd->base,
+=09=09=09=09=09(dev, clkout_name, clk_name, 0, clk_wzrd->base,
 =09=09=09=09=09(WZRD_CLK_CFG_REG(is_versal, 2) + i * 12),
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_SHIFT,
 =09=09=09=09=09WZRD_CLKOUT_DIVIDE_WIDTH,
@@ -1160,13 +1116,64 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09=09=09=09DIV_O, &clkwzrd_lock);
 =09=09}
 =09=09if (IS_ERR(clk_wzrd->clk_data.hws[i])) {
-=09=09=09dev_err(&pdev->dev,
-=09=09=09=09"unable to register divider clock\n");
+=09=09=09dev_err(dev, "unable to register divider clock\n");
 =09=09=09return PTR_ERR(clk_wzrd->clk_data.hws[i]);
 =09=09}
 =09}
=20
-out:
+=09return 0;
+}
+
+static int clk_wzrd_probe(struct platform_device *pdev)
+{
+=09struct device_node *np =3D pdev->dev.of_node;
+=09struct clk_wzrd *clk_wzrd;
+=09unsigned long rate;
+=09int nr_outputs;
+=09int ret;
+
+=09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
+=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
+=09=09return -EINVAL;
+
+=09clk_wzrd =3D devm_kzalloc(&pdev->dev, struct_size(clk_wzrd, clk_data.hw=
s, nr_outputs),
+=09=09=09=09GFP_KERNEL);
+=09if (!clk_wzrd)
+=09=09return -ENOMEM;
+=09platform_set_drvdata(pdev, clk_wzrd);
+
+=09clk_wzrd->base =3D devm_platform_ioremap_resource(pdev, 0);
+=09if (IS_ERR(clk_wzrd->base))
+=09=09return PTR_ERR(clk_wzrd->base);
+
+=09ret =3D of_property_read_u32(np, "xlnx,speed-grade", &clk_wzrd->speed_g=
rade);
+=09if (!ret) {
+=09=09if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade > 3) {
+=09=09=09dev_warn(&pdev->dev, "invalid speed grade '%d'\n",
+=09=09=09=09 clk_wzrd->speed_grade);
+=09=09=09clk_wzrd->speed_grade =3D 0;
+=09=09}
+=09}
+
+=09clk_wzrd->clk_in1 =3D devm_clk_get(&pdev->dev, "clk_in1");
+=09if (IS_ERR(clk_wzrd->clk_in1))
+=09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_in1),
+=09=09=09=09     "clk_in1 not found\n");
+
+=09clk_wzrd->axi_clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
+=09if (IS_ERR(clk_wzrd->axi_clk))
+=09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->axi_clk),
+=09=09=09=09     "s_axi_aclk not found\n");
+=09rate =3D clk_get_rate(clk_wzrd->axi_clk);
+=09if (rate > WZRD_ACLK_MAX_FREQ) {
+=09=09dev_err(&pdev->dev, "s_axi_aclk frequency (%lu) too high\n", rate);
+=09=09return -EINVAL;
+=09}
+
+=09ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs);
+=09if (ret)
+=09=09return ret;
+
 =09clk_wzrd->clk_data.num =3D nr_outputs;
 =09ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get, =
&clk_wzrd->clk_data);
 =09if (ret) {
--=20
2.46.0



