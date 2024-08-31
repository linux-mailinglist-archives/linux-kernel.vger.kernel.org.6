Return-Path: <linux-kernel+bounces-309861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB58967133
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80540B22608
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D517DE2D;
	Sat, 31 Aug 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="t0VEA7Ie"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD7181B87
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102815; cv=none; b=gP7JXony2ehIwz5JasmV/8xe8fKzh8HUZLODd7WCpBPqqLT3a3n37Qnxu9FEvpwW6+vJeRDOM+FKp8GTJ7p7VHYkWRF8SAWh9SIXiojbrmSl9inH4jqX8kbBxCNaBDkIzPGeem00YK74lpjSEKrsB3jpUJqBa0h+EO2lNobVEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102815; c=relaxed/simple;
	bh=edbM/3TAGfeqort+xVmo0O+PZME0wyHoMvqOD2fEG1E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pa9vAEBLOnUUC6znh84fG/IBN8ZdJJ+pOoT6ILk3eDu/UYxUM28raVyg7vVUWANRrWU6yvyHO7VF89/rwPf0guLRym8woPGnU0GvsBYTRNmt8jZHZNSfvRYLNF3GoLB2JsAeFy+GGk/PooL34PdL3b14ubTDRvDgiWGBEUoP3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=t0VEA7Ie; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1725102812; x=1725362012;
	bh=G1HciThtxbRjzDlZaKZyocJPb1VkjxqvDwhyzO94G+I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=t0VEA7IeLBAMyOltI5bAl456/ebap4GLdP/zftos12hBuY1b/3FYi1HFt/XQ0RTzM
	 3vAGPsnsOOWDAkZB6afhDX8HSsiEru5McQP7h4Pl+BZw+h30TbCTTAd/YmyExK3VZq
	 Jklmu1TsoM9cD+e4j+wkK0mD+DRXt6s1o1JZ9xYPpOD/UZRzP6o5cq5YkVrBfS9LyZ
	 ojBuW3hr8+oZvuGfML6tu1mnXE7HhYMko6GcZ+tBi/n+awC/DAKznhGhaBqmPJEr6V
	 87NoywDqRMX1TCE/1GA/tq6DEFXDh4Ypq4VbPo+6z4b6/9ggaitvXWa6VMD8VZDAEB
	 eJ7UP35+KQXyg==
Date: Sat, 31 Aug 2024 11:13:26 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH 6/6] clk: clocking-wizard: move dynamic reconfig setup behind flag
Message-ID: <20240831111056.3864-7-hpausten@protonmail.com>
In-Reply-To: <20240831111056.3864-1-hpausten@protonmail.com>
References: <20240831111056.3864-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: ca92a0caa7a068db06bbfe0ef97d3fbcd5490ea2
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
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 73 +++++++++++-----------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 1a65a7d153c35..967eacc28050d 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1146,20 +1146,6 @@ static int clk_wzrd_probe(struct platform_device *pd=
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
@@ -1170,31 +1156,48 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09=09return -EINVAL;
 =09}
=20
-=09ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs);
-=09if (ret)
-=09=09return ret;
-
-=09clk_wzrd->clk_data.num =3D nr_outputs;
-=09ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get, =
&clk_wzrd->clk_data);
-=09if (ret) {
-=09=09dev_err(&pdev->dev, "unable to register clock provider\n");
-=09=09return ret;
-=09}
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
-=09if (clk_wzrd->speed_grade) {
-=09=09clk_wzrd->nb.notifier_call =3D clk_wzrd_clk_notifier;
+=09=09clk_wzrd->clk_in1 =3D devm_clk_get(&pdev->dev, "clk_in1");
+=09=09if (IS_ERR(clk_wzrd->clk_in1))
+=09=09=09return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_in1),
+=09=09=09=09=09     "clk_in1 not found\n");
=20
-=09=09ret =3D devm_clk_notifier_register(&pdev->dev, clk_wzrd->clk_in1,
-=09=09=09=09=09=09 &clk_wzrd->nb);
+=09=09ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs);
 =09=09if (ret)
-=09=09=09dev_warn(&pdev->dev,
-=09=09=09=09 "unable to register clock notifier\n");
+=09=09=09return ret;
+
+=09=09clk_wzrd->clk_data.num =3D nr_outputs;
+=09=09ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_ge=
t,
+=09=09=09=09=09=09  &clk_wzrd->clk_data);
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
2.46.0



