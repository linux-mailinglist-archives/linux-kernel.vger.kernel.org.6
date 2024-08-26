Return-Path: <linux-kernel+bounces-301487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A444F95F193
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA30E1C2137D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA118FC7C;
	Mon, 26 Aug 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="P5fbGaqa"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F818CBF6;
	Mon, 26 Aug 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675931; cv=none; b=BKKgnOhLYfauGw01fHHNMWby1WoYJCmGxvn7+zQz3YTupocdXAHZvZt9zTvQ42oW/hlrkMKDnuIFdRE4+y/0rDb8lHCYkXCZu4QED6yvq3aT+RHx3TBqt3y7btSRewUfLD0b3UDa/iuUH+fb3z8ioypXlE7mNFmdWp3xyN2pBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675931; c=relaxed/simple;
	bh=fexhxZ/Wj12N9dTkQwKjwCev2VJVFEceVWSjgTO2IC0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXYSL7f6MHqWlIk88cgmMNhC/N7VTmL1wTV0Re8j2hlq+ppgp7a+6eeWBptAtYNvMWosXNtAOx/Hu4vf8CeTtzFR/vOau4MTUcriG+C9p3C3VZjtjUgqfIEQaXSfSrz89jzDOGQoAY5KjXEqghdETHTwuDAdV5mrMOuWKbKArK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=P5fbGaqa; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724675927; x=1724935127;
	bh=BMjURepHiOaapx7nusjSR8eg3pgiVBp6E6m/pDd+PKM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=P5fbGaqa1rOJypmPNzY8uDiHz2kM0cJzvVzPvgAgFPKzPlir7ee1r2uYbmTwXSJHA
	 NjT9ziDrrRvn0EesvUUpqzR9eLbhQ2APCYHbbQHP36muo0dYd5qm3mYeqoorDfOmMU
	 5X0BrcElyW9LNe+RCYAd+3pmRA3ET+o9BekDEJ2Qqo3j+fEz44u+vCjRgB2YiYB2XJ
	 FBRvgiMlHdjwhSUPsOnCMK9k7T5ltBKbC6UyVXxJ4Kxd+qwRzLn7P82NxuYlNmVLqn
	 e/q97GwdytGozcc+nJThIfEmk9XqkXdsimeb6JrdL0sFkdefmPwOqP8bDyqLHuc0K6
	 PLb9LOrYqTlWg==
Date: Mon, 26 Aug 2024 12:38:43 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v3 9/9] clk: clocking-wizard: move dynamic reconfig setup behind flag
Message-ID: <20240826123602.1872-10-hpausten@protonmail.com>
In-Reply-To: <20240826123602.1872-1-hpausten@protonmail.com>
References: <20240826123602.1872-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 4fbfffd3599013b558dc9f5e4809d01e0aac1b0b
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
index 35dad2fda254b..b30d8106ac279 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1192,20 +1192,6 @@ static int clk_wzrd_probe(struct platform_device *pd=
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
@@ -1220,31 +1206,48 @@ static int clk_wzrd_probe(struct platform_device *p=
dev)
 =09if (ret)
 =09=09return dev_err_probe(&pdev->dev, ret, "failed to setup monitor\n");
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



