Return-Path: <linux-kernel+bounces-257945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96421938130
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AEC2828E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD486250;
	Sat, 20 Jul 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="MqlN8s8z"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8212D744;
	Sat, 20 Jul 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721476932; cv=none; b=WCjcV8udRNbnHM9q4hs/cxPSbJ3kg6IoYXRxBZ7fBZ7X3N7n5F4niYiU+a+bwN3OR0xTZD9J6IG6WjoKG9UWRpLCD7sGPdGZ22QVihWtl9vpdganRdz2wfycHrpVRoELoC66dO5W7O6C1qqXZXa9dHmwavdp9BQjoiW3UBThPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721476932; c=relaxed/simple;
	bh=Ws4IVpy523pqF5J7VdsVTx/0uNjG4GIOrUTuGNPVRoo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXTdZkk3SB3nDy3OXQ3qMfEWShEyRuby6SjfQfh9rXMypD5MEJ/Ywfju804zy38JPYjjc5h4NOdN5Gwqm6R/qVJTBIFW4Xt5cgcnVXDzuV34s1gbFCuoIAY2OVBvBzpMaHkJ94a1QeooSJ8tlwzzTW4G7Q0yMqL3jWrLDVbH8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=MqlN8s8z; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721476928; x=1721736128;
	bh=/AxMqXWFPwoh5NZG4M7LLzEizR7UlModDwusasq5CQ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MqlN8s8zAZV40ZxGcDLWi/BAa5SdYTAdLc+NDcwsVX21YNl2MzuK+gmmjhbGDz5q+
	 CDCDFAd/tan8mAzSsz5GDqlYvwruSS/Nq9gKo0dgE7ll71/XaoVB89fHWFNhFVnFVm
	 8keS5+xKrSXZ2mffvQ0zg8Im8+UwvaoLJPg3FogiS2SiNPq1SdgjoNcYzMfUsi8lYk
	 o83AWyTvY6mCwadyJBmdouocBB5nsztxtLG4jbpHMe32C05ZjvvpqMIcGViuUIpU7v
	 R3wxxZy+vYqp/n+yuk+fNDEpZbhL3JLDFaJTDHfcBvtvyKieDmWTqndyshGkb5O7O5
	 i8l1vpcvcuuyg==
Date: Sat, 20 Jul 2024 12:02:04 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH 7/7] clk: clocking-wizard: move dynamic reconfig setup behind flag
Message-ID: <20240720120048.36758-8-hpausten@protonmail.com>
In-Reply-To: <20240720120048.36758-1-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 244be5160229920dc0c841865215c9e04b17831b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xilinx clocking wizard IP core's dynamic reconfiguration support is
optionally enabled at build time. Use the new boolean devicetree
property to indicate whether the hardware supports this feature or not.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 87 +++++++++++-----------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 2d419e8ad4419..8efe5246c8c0d 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1185,20 +1185,6 @@ static int clk_wzrd_probe(struct platform_device *pd=
ev)
 =09if (IS_ERR(clk_wzrd->base))
 =09=09return PTR_ERR(clk_wzrd->base);
=20
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
-
 =09clk_wzrd->axi_clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 =09if (IS_ERR(clk_wzrd->axi_clk))
 =09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->axi_clk),
@@ -1220,40 +1206,57 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09}
 =09}
=20
-=09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
-=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
-=09=09return -EINVAL;
-
-=09clk_wzrd->clk_data =3D devm_kzalloc(&pdev->dev, struct_size(clk_wzrd->c=
lk_data, hws,
-=09=09=09=09=09  nr_outputs), GFP_KERNEL);
-=09if (!clk_wzrd->clk_data)
-=09=09return -ENOMEM;
+=09if (of_property_read_bool(np, "xlnx,dynamic-reconfig")) {
+=09=09ret =3D of_property_read_u32(np, "xlnx,speed-grade", &clk_wzrd->spee=
d_grade);
+=09=09if (!ret) {
+=09=09=09if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade > 3) {
+=09=09=09=09dev_warn(&pdev->dev, "invalid speed grade '%d'\n",
+=09=09=09=09=09 clk_wzrd->speed_grade);
+=09=09=09=09clk_wzrd->speed_grade =3D 0;
+=09=09=09}
+=09=09}
=20
-=09ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs);
-=09if (ret)
-=09=09return ret;
+=09=09clk_wzrd->clk_in1 =3D devm_clk_get(&pdev->dev, "clk_in1");
+=09=09if (IS_ERR(clk_wzrd->clk_in1))
+=09=09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_in1),
+=09=09=09=09=09     "clk_in1 not found\n");
=20
-=09clk_wzrd->clk_data->num =3D nr_outputs;
-=09ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get, =
clk_wzrd->clk_data);
-=09if (ret) {
-=09=09dev_err(&pdev->dev, "unable to register clock provider\n");
-=09=09return ret;
-=09}
+=09=09ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
+=09=09if (ret || nr_outputs > WZRD_NUM_OUTPUTS)
+=09=09=09return -EINVAL;
=20
-=09if (clk_wzrd->speed_grade) {
-=09=09clk_wzrd->nb.notifier_call =3D clk_wzrd_clk_notifier;
+=09=09clk_wzrd->clk_data =3D devm_kzalloc(&pdev->dev, struct_size(clk_wzrd=
->clk_data, hws,
+=09=09=09=09=09=09  nr_outputs), GFP_KERNEL);
+=09=09if (!clk_wzrd->clk_data)
+=09=09=09return -ENOMEM;
=20
-=09=09ret =3D devm_clk_notifier_register(&pdev->dev, clk_wzrd->clk_in1,
-=09=09=09=09=09=09 &clk_wzrd->nb);
+=09=09ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs);
 =09=09if (ret)
-=09=09=09dev_warn(&pdev->dev,
-=09=09=09=09 "unable to register clock notifier\n");
+=09=09=09return ret;
+
+=09=09clk_wzrd->clk_data->num =3D nr_outputs;
+=09=09ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_ge=
t,
+=09=09=09=09=09=09  clk_wzrd->clk_data);
+=09=09if (ret) {
+=09=09=09dev_err(&pdev->dev, "unable to register clock provider\n");
+=09=09=09return ret;
+=09=09}
=20
-=09=09ret =3D devm_clk_notifier_register(&pdev->dev, clk_wzrd->axi_clk,
-=09=09=09=09=09=09 &clk_wzrd->nb);
-=09=09if (ret)
-=09=09=09dev_warn(&pdev->dev,
-=09=09=09=09 "unable to register clock notifier\n");
+=09=09if (clk_wzrd->speed_grade) {
+=09=09=09clk_wzrd->nb.notifier_call =3D clk_wzrd_clk_notifier;
+
+=09=09=09ret =3D devm_clk_notifier_register(&pdev->dev, clk_wzrd->clk_in1,
+=09=09=09=09=09=09=09 &clk_wzrd->nb);
+=09=09=09if (ret)
+=09=09=09=09dev_warn(&pdev->dev,
+=09=09=09=09=09 "unable to register clock notifier\n");
+
+=09=09=09ret =3D devm_clk_notifier_register(&pdev->dev, clk_wzrd->axi_clk,
+=09=09=09=09=09=09=09 &clk_wzrd->nb);
+=09=09=09if (ret)
+=09=09=09=09dev_warn(&pdev->dev,
+=09=09=09=09=09 "unable to register clock notifier\n");
+=09=09}
 =09}
=20
 =09return 0;
--=20
2.45.2



