Return-Path: <linux-kernel+bounces-273441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED594694D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99421F217E5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64914D708;
	Sat,  3 Aug 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="CONJO6R8"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1914D702;
	Sat,  3 Aug 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682730; cv=none; b=nig1c/dwy/UYBplYiVcAl+thtoCVqewvQzDJJ49NgUuyk9jnH559AApgiOLnO0CYxDXDICKazGdlkYgOJ7OIE/6R5KtNZCxwwrlNROLfdvck7hd1apWo9ocPPJXpJ9spybu271/hj8m9Dajv/WRa7B8z9ONE/L2iyHG5keSMSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682730; c=relaxed/simple;
	bh=+2Ps0RkWvd4hA5xbknz9GXhP/fqeSiFOTT6hvj1HlSY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhRkRL2Gwv9iuCSxgmUg3MNwwpCKBOgrXddTQbnfV1lTmUAomJjzK1wsWpJuga2sWl6eBRK2x7cpVZlgafYBPaAflIFyrTPgQYpf2EXFnlQqWPH49ZCj3AEgwNQ+MAcpMm2YbRWaTtvO4OZc8udZjvG+Rxsc1yF5ECqFjGE342k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=CONJO6R8; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722682726; x=1722941926;
	bh=0H2g73lUPxVU1hWK6gZKi285FJE1qovcLzfd2WX0+uE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CONJO6R8fF9XsX3qremVKWzb1WTgZAho8oQnYriBXxuVeBM2jnxqf1ArH4mEOjyR0
	 KHHYJaGAfYCOSih662ri1L4oFylwwe2ITNlpWDc88CkKdsyZTAiSufE+6eZIhguh8L
	 eq7mZLnF836BbB35EqedsbfloTvB/bMQcM9mxUTojKARkZaMLXnlh1uc5x3cVdvmQb
	 L4Hn7OCWbJ9Su8ZIzc04UlV4XB0HyokI4dBwNdTdCvT9BF0qp/nptdc/tHRsUW/bh5
	 xep/0GPf674cfporFewBA5llcBxcm+KbS07ZSYSQd0yFkLpIZ1hDFJ5SpyPrXAeIP7
	 AEJpS81s1lOTw==
Date: Sat, 03 Aug 2024 10:58:43 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 9/9] clk: clocking-wizard: move dynamic reconfig setup behind flag
Message-ID: <20240803105702.9621-10-hpausten@protonmail.com>
In-Reply-To: <20240803105702.9621-1-hpausten@protonmail.com>
References: <20240803105702.9621-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 25c4f45d44befa37fd567ea85bd876fa56719a8e
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
v1 -> v2: No functional change

 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 73 +++++++++++-----------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 557e11017faf9..fb655d53b2029 100644
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



