Return-Path: <linux-kernel+bounces-328774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA09788A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42ABA1C21535
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6A156C62;
	Fri, 13 Sep 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uPgWAy7z"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242F155757;
	Fri, 13 Sep 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254708; cv=none; b=o64qnT8KyQT+3HHShX2ZjjgbuIa6QsInil+hQQ9ivGB9KEWqtpz6/VYiWR2VlwKR24akG2LskScFe5Q6wMDzdl1Bk2a4uY6likJFHuMpWGbFhf5BLhb3V8MCsbjxdhgxdpNsKvpoGHCv0lR+mn9tDeqNeWhi4chSQYJmh6D1roU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254708; c=relaxed/simple;
	bh=FSP8+aZvygGlFdnBS0yY0alytQkKXdz2tdXRla1srC4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOFluyJCO6hlvMUeC98chhbh4VtPxmOlyCgHidNItT1kp3oxp1V1Y/1T4WxbfNi3j+r6bJ4RqHflBmw674IcIx8YUNy4xYpeb9ozUqXBi9a6twNoqE51wOmfcrmWJNQJ000EYbU5xXg77fyyxWOE+13GQgrzpvFoB9ugunM1mw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=uPgWAy7z; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726254704; x=1726513904;
	bh=6/lBrZ2oDDRZvVUHlxFsYvMr6aYJJQrOCFEf51HfHeg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uPgWAy7zSjTBka6AISIp1jmQ42aVGA8jKYC2DYVpZxx9rqR7tLO6EjK75ego4B5m8
	 V3CFAY0C85OszAvyxLMbhJeSR8FGTgdoEhdXFkEzs3GlUleGiGb0N1C2wn6RaKv1hd
	 hKBOur9wA4+gIygtUEB4u1HLguqlU3ZH1p38asyQ19lTCMG5AZzCORU2l+yp6DR9+f
	 vXjKTLJnkl6YM6t7Z4627b75+XLSUfQ4WxO97cupmNVyx1sb8rKQ4QQatnvxZ290Ty
	 8ks1Zw/DD+/qI8osw832p+c54JoctYTNufEWZJoOqDhy1dPLGwElPvddwGX0Rb79J5
	 sRT6B1wl4nEIw==
Date: Fri, 13 Sep 2024 19:11:42 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 6/6] clk: clocking-wizard: move dynamic reconfig setup behind flag
Message-ID: <20240913191037.2690-7-hpausten@protonmail.com>
In-Reply-To: <20240913191037.2690-1-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 5bf6a2b04b808efc1b0da601da58340992b043d8
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
v1 -> v2:
- Update if condition with renamed inverted DT property

 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 73 +++++++++++-----------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 1a65a7d153c35..b2233d3ff9a99 100644
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
+=09if (!of_property_present(np, "xlnx,static-config")) {
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



