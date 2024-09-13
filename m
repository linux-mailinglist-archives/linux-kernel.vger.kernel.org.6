Return-Path: <linux-kernel+bounces-328768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6F97888F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED4D1F23D06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C067146D40;
	Fri, 13 Sep 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="aPWUXV3r"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF312A14C;
	Fri, 13 Sep 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254683; cv=none; b=O+NntyJOrynjF7y2eNC+4nGs53x/ppsGRuc0VkIGBDB7Dk+cnh9ANqgfbkViMSv1czGLPtAL4O/MNd84mGgmD0JwUjnxdbZh+tZsLLunY2fMcAYlVSzotw+FPNifffPCnt9f1FhoS2V8RmGcvc72eU7yQD26hXEBt4ZR3pg3Q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254683; c=relaxed/simple;
	bh=Es8JdwSQ9ax+pU0G5tFUE5Jhn8umXUmkWnJWw1Ctqn4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kReyO7JwGJ7rh2knIpB9oMS9D89OOVQ9FCuC+xYykXqH6xSRTlblCWtsjrUQMYyuJtZ8b2F0B+ejhIL8hyEwtzU9CF74a4d9Z6tM9kS0g/fsDLlsrVNARkgIxByp0Fuy6jgRrWEI00k9XrH9LmNNg9sVphnFz5GKhKuV0kDqBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=aPWUXV3r; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726254680; x=1726513880;
	bh=nGDqcT9scXiqdNA7FshndttvVc1Jc6qKkBgVZRzZuSA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aPWUXV3rm6JwVtBOuX8Q5bH6YzYwhJWaGBtDDzzIva2vPUz3vajv/R6MCTPpzb4AD
	 F94H20dDleoONzCD5MD6drB54jNyqDtGBwsuwqjN+SJ85d2PIEDyAFLILic9mABQyn
	 1M7mh1pnP3kzyf/mWugzQJEv5+Iot6di2J1cQ6i3v0klO1lDiL/DDKPAgbg8YkQYJH
	 Ue58OueloV7PIBpyqpu/bipWmJ1lmRRLtwLsPljCJ270B9l8Zd3L50WYteXYhPedlo
	 5jLtYPPz5e0uiKrhQlry970JUubjl+mOSkrxZDfOOy30jPGzCTATp2SkXwXgywYgrb
	 W5wWlNMT3zSHg==
Date: Fri, 13 Sep 2024 19:11:14 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 1/6] clk: clocking-wizard: simplify probe/remove with devres helpers
Message-ID: <20240913191037.2690-2-hpausten@protonmail.com>
In-Reply-To: <20240913191037.2690-1-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: bcd8f4103bdcf1f5f0841c737fc2650f2cd52353
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove need to do various operations in remove callback and error paths
by utilising device managed versions of clock and notifier APIs.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
v1 -> v2: No change

 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 48 ++++++----------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 19eb3fb7ae319..0ca045849ea3e 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1001,21 +1001,15 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_in1),
 =09=09=09=09     "clk_in1 not found\n");
=20
-=09clk_wzrd->axi_clk =3D devm_clk_get(&pdev->dev, "s_axi_aclk");
+=09clk_wzrd->axi_clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 =09if (IS_ERR(clk_wzrd->axi_clk))
 =09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->axi_clk),
 =09=09=09=09     "s_axi_aclk not found\n");
-=09ret =3D clk_prepare_enable(clk_wzrd->axi_clk);
-=09if (ret) {
-=09=09dev_err(&pdev->dev, "enabling s_axi_aclk failed\n");
-=09=09return ret;
-=09}
 =09rate =3D clk_get_rate(clk_wzrd->axi_clk);
 =09if (rate > WZRD_ACLK_MAX_FREQ) {
 =09=09dev_err(&pdev->dev, "s_axi_aclk frequency (%lu) too high\n",
 =09=09=09rate);
-=09=09ret =3D -EINVAL;
-=09=09goto err_disable_clk;
+=09=09return -EINVAL;
 =09}
=20
 =09data =3D device_get_match_data(&pdev->dev);
@@ -1023,16 +1017,12 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09is_versal =3D data->is_versal;
=20
 =09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
-=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS) {
-=09=09ret =3D -EINVAL;
-=09=09goto err_disable_clk;
-=09}
+=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
+=09=09return -EINVAL;
=20
 =09clkout_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_out0", dev_n=
ame(&pdev->dev));
-=09if (!clkout_name) {
-=09=09ret =3D -ENOMEM;
-=09=09goto err_disable_clk;
-=09}
+=09if (!clkout_name)
+=09=09return -ENOMEM;
=20
 =09if (is_versal) {
 =09=09if (nr_outputs =3D=3D 1) {
@@ -1090,18 +1080,15 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09div =3D 1000;
 =09}
 =09clk_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_mul", dev_name(=
&pdev->dev));
-=09if (!clk_name) {
-=09=09ret =3D -ENOMEM;
-=09=09goto err_disable_clk;
-=09}
+=09if (!clk_name)
+=09=09return -ENOMEM;
 =09clk_wzrd->clks_internal[wzrd_clk_mul] =3D clk_register_fixed_factor
 =09=09=09(&pdev->dev, clk_name,
 =09=09=09 __clk_get_name(clk_wzrd->clk_in1),
 =09=09=090, mult, div);
 =09if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul])) {
 =09=09dev_err(&pdev->dev, "unable to register fixed-factor clock\n");
-=09=09ret =3D PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul]);
-=09=09goto err_disable_clk;
+=09=09return PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul]);
 =09}
=20
 =09clk_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_mul_div", dev_n=
ame(&pdev->dev));
@@ -1197,13 +1184,14 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09if (clk_wzrd->speed_grade) {
 =09=09clk_wzrd->nb.notifier_call =3D clk_wzrd_clk_notifier;
=20
-=09=09ret =3D clk_notifier_register(clk_wzrd->clk_in1,
-=09=09=09=09=09    &clk_wzrd->nb);
+=09=09ret =3D devm_clk_notifier_register(&pdev->dev, clk_wzrd->clk_in1,
+=09=09=09=09=09=09 &clk_wzrd->nb);
 =09=09if (ret)
 =09=09=09dev_warn(&pdev->dev,
 =09=09=09=09 "unable to register clock notifier\n");
=20
-=09=09ret =3D clk_notifier_register(clk_wzrd->axi_clk, &clk_wzrd->nb);
+=09=09ret =3D devm_clk_notifier_register(&pdev->dev, clk_wzrd->axi_clk,
+=09=09=09=09=09=09 &clk_wzrd->nb);
 =09=09if (ret)
 =09=09=09dev_warn(&pdev->dev,
 =09=09=09=09 "unable to register clock notifier\n");
@@ -1215,9 +1203,6 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
 =09clk_unregister(clk_wzrd->clks_internal[1]);
 err_rm_int_clk:
 =09clk_unregister(clk_wzrd->clks_internal[0]);
-err_disable_clk:
-=09clk_disable_unprepare(clk_wzrd->axi_clk);
-
 =09return ret;
 }
=20
@@ -1232,13 +1217,6 @@ static void clk_wzrd_remove(struct platform_device *=
pdev)
 =09=09clk_unregister(clk_wzrd->clkout[i]);
 =09for (i =3D 0; i < wzrd_clk_int_max; i++)
 =09=09clk_unregister(clk_wzrd->clks_internal[i]);
-
-=09if (clk_wzrd->speed_grade) {
-=09=09clk_notifier_unregister(clk_wzrd->axi_clk, &clk_wzrd->nb);
-=09=09clk_notifier_unregister(clk_wzrd->clk_in1, &clk_wzrd->nb);
-=09}
-
-=09clk_disable_unprepare(clk_wzrd->axi_clk);
 }
=20
 static const struct of_device_id clk_wzrd_ids[] =3D {
--=20
2.46.0



