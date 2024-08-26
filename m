Return-Path: <linux-kernel+bounces-301479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A395F17A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1536AB22792
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A9E17C9B2;
	Mon, 26 Aug 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qupk6xsL"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869817BEB7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675908; cv=none; b=ei+LKf6ma5iSn6wr7zFeTf31+mDNKlWkBxWuv9DKLZydPWnKlvm8DnZPZSyTp+YEdv6kE8tJUn5DXh8FIAmlPwcGwytJg//QsClj7ZGoYOpC4JHQsNHo0XFXpQwY98wKX1SlPNiGKp64cc59eI06IFuh4jm3C2NawgP3GmRBI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675908; c=relaxed/simple;
	bh=7PIXhv7l5NwDu8aIH1um6fUTdp9QndNFB1avfLBoH8s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7In8lU5/MWi+pD8rirkRa2oo/+MZiTFVERm32EHyagolAOrcWgbIbpbxISC3/POw6d/f62gD0QKSsdsACBD63kTGE6ixNIgrP5gD90Q//rsISJqxa93KA+lrhWt/PMSTOd1trbwiRT/cgmbGSEgWJVI3ZLRjWhQQqhOhbHRY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qupk6xsL; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724675904; x=1724935104;
	bh=BGalRL9o6f637EmyVXtZVrUv2eCLH5tTBp+42n6pyxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qupk6xsLjbRB/bbyGK3M8jvelTHh+awrO+swmDKvfHUynSPUjnemkCJggYxd1XC4R
	 nQUbPtlpO1YVuC/R++0Q5RJxaiK+BQEcOOsHFAuebBYVQ1TnXxpSQOLbLQlJoc5N4+
	 QAx0ui/bdqSmAgmkFfHUJDNL1Vwt7ej0+CiBAWZXW8L/6nweGcfMgorjcvbbW1snDr
	 uAb3kWKFif1aL8B8V3r4xYcueBju5XOw5AdOHpNhTJQZ+JDN+hIMu60chMAEArTcZf
	 SIQjcCmNcJclzkyVYpff+KCDuDsq76F20+epo8/Ndz2VVFxE8A1kYqFtCsFPyKNTpi
	 I8U2sX4/fPA6g==
Date: Mon, 26 Aug 2024 12:38:18 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v3 3/9] clk: clocking-wizard: use devres versions of clk_hw API
Message-ID: <20240826123602.1872-4-hpausten@protonmail.com>
In-Reply-To: <20240826123602.1872-1-hpausten@protonmail.com>
References: <20240826123602.1872-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: c9cf9339f11a6660db3ccb817d904ebfc687e1aa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Use device managed versions of the clk_hw API, entirely removing the
need for the driver's remove() callback and greatly simplifying the
probe() function's error paths.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 52 +++++-----------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index cd795a4952099..f332e0eee56c8 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1082,7 +1082,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09clk_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_mul", dev_name(=
&pdev->dev));
 =09if (!clk_name)
 =09=09return -ENOMEM;
-=09clk_wzrd->clks_internal[wzrd_clk_mul] =3D clk_hw_register_fixed_factor
+=09clk_wzrd->clks_internal[wzrd_clk_mul] =3D devm_clk_hw_register_fixed_fa=
ctor
 =09=09=09(&pdev->dev, clk_name,
 =09=09=09 __clk_get_name(clk_wzrd->clk_in1),
 =09=09=090, mult, div);
@@ -1092,10 +1092,8 @@ static int clk_wzrd_probe(struct platform_device *pd=
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
@@ -1110,11 +1108,11 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
=20
 =09=09clk_mul_name =3D clk_hw_get_name(clk_wzrd->clks_internal[wzrd_clk_mu=
l]);
 =09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D
-=09=09=09clk_hw_register_fixed_factor(&pdev->dev, clk_name,
-=09=09=09=09=09=09     clk_mul_name, 0, 1, div);
+=09=09=09devm_clk_hw_register_fixed_factor(&pdev->dev, clk_name,
+=09=09=09=09=09=09=09  clk_mul_name, 0, 1, div);
 =09} else {
 =09=09ctrl_reg =3D clk_wzrd->base + WZRD_CLK_CFG_REG(is_versal, 0);
-=09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D clk_hw_register_divide=
r
+=09=09clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D devm_clk_hw_register_d=
ivider
 =09=09=09(&pdev->dev, clk_name,
 =09=09=09 clk_hw_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
 =09=09=09flags, ctrl_reg, 0, 8, CLK_DIVIDER_ONE_BASED |
@@ -1122,18 +1120,15 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
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
 =09=09=09clk_wzrd->clk_data.hws[i] =3D clk_wzrd_ver_register_divider
@@ -1165,20 +1160,15 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09=09=09=09DIV_O, &clkwzrd_lock);
 =09=09}
 =09=09if (IS_ERR(clk_wzrd->clk_data.hws[i])) {
-=09=09=09int j;
-
-=09=09=09for (j =3D i + 1; j < nr_outputs; j++)
-=09=09=09=09clk_hw_unregister(clk_wzrd->clk_data.hws[j]);
 =09=09=09dev_err(&pdev->dev,
 =09=09=09=09"unable to register divider clock\n");
-=09=09=09ret =3D PTR_ERR(clk_wzrd->clk_data.hws[i]);
-=09=09=09goto err_rm_int_clks;
+=09=09=09return PTR_ERR(clk_wzrd->clk_data.hws[i]);
 =09=09}
 =09}
=20
 out:
 =09clk_wzrd->clk_data.num =3D nr_outputs;
-=09ret =3D of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_onecell_get=
, &clk_wzrd->clk_data);
+=09ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get, =
&clk_wzrd->clk_data);
 =09if (ret) {
 =09=09dev_err(&pdev->dev, "unable to register clock provider\n");
 =09=09return ret;
@@ -1201,25 +1191,6 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
 =09}
=20
 =09return 0;
-
-err_rm_int_clks:
-=09clk_hw_unregister(clk_wzrd->clks_internal[1]);
-err_rm_int_clk:
-=09clk_hw_unregister(clk_wzrd->clks_internal[0]);
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
-=09=09clk_hw_unregister(clk_wzrd->clk_data.hws[i]);
-=09for (i =3D 0; i < wzrd_clk_int_max; i++)
-=09=09clk_hw_unregister(clk_wzrd->clks_internal[i]);
 }
=20
 static const struct of_device_id clk_wzrd_ids[] =3D {
@@ -1238,7 +1209,6 @@ static struct platform_driver clk_wzrd_driver =3D {
 =09=09.pm =3D &clk_wzrd_dev_pm_ops,
 =09},
 =09.probe =3D clk_wzrd_probe,
-=09.remove_new =3D clk_wzrd_remove,
 };
 module_platform_driver(clk_wzrd_driver);
=20
--=20
2.46.0



