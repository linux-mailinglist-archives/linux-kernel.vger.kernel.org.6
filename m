Return-Path: <linux-kernel+bounces-262636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C9493C9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE6828169D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6E1465BC;
	Thu, 25 Jul 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JHCHykUz"
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DC143C41
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940495; cv=none; b=LIrvzO1dJ/bGV9zjHC/ASjk+3oSc+hwTwN6MpcuhkOZ7H2BEGYIfXSom6gOyXGnGuXrPSrERrgfFFZYqzT7HsqjGepymn7TKsH4aykKGtkv11TeqWKz6MQ10jI80dFL8U6+vnhkYz/gS0TIDH/r89gGqfFj2IQVcNg8fZ9uHayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940495; c=relaxed/simple;
	bh=JHDXKeWytPW/ro4uzW8sk6fYfCOgjS6eqK7o1zZy53g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM57fh5PPbIej8dtmw9o3Efupt+CtuUwwawG0TJ2maKySfOOxDjXfyh+xWsst0ImQKU80RBPphN6/HyAO3huxY7eW6K9tAh/iGh12ScOfVYMFWnsjK2DxILCBzfSUQkNB1z0Gx+O9AtTAjniYH4TQj0+Jso2waqpybcFbFc0Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JHCHykUz; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id X5MSsJCR06bu3X5Mbs696W; Thu, 25 Jul 2024 22:47:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721940423;
	bh=O3ZVT0Ujn9hJ7jDCPbtGlOBgrRHSOXl/SJzBREYLERg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JHCHykUzoFQDo6moseWVMxr3phGNAXoZAwrR5hJo0TQIehH5Sw5sR1/P3azDW5VP5
	 dTFuSjrySH1iW+3GFgjFIM/hbs77WjbjR3f6nE/Hq+YfmD9Z2Y76Jkg6UCUd8Y7klw
	 VSmqzABFeUioO8eKfMvVVJZrOGMjFaeKjgcjm7zcSvQvaw7heh/LwTQckU5k4RMWZU
	 gVCP2t/BNOLhcIxZGuy1rwwK9R+23uIf47QXg5aFkOf4qpG1pWK0HoTaAspcxcvq9m
	 hge9vciqNUvw7jnUvAK0r+j9q1E85f7j+J6GRmIaQNUieQNgTPMUmtloqv9EHALnN2
	 yf2gq719CMNhA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Jul 2024 22:47:03 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dmitry.torokhov@gmail.com,
	vipulkumar.samar@st.com,
	viresh.kumar@linaro.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] Input: spear-keyboard - Switch to devm_clk_get_prepared()
Date: Thu, 25 Jul 2024 22:46:50 +0200
Message-ID: <ea855328eb4396cd1c44d2b6acc1fc394fcb1508.1721939824.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721939824.git.christophe.jaillet@wanadoo.fr>
References: <cover.1721939824.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_prepared() in order to remove a clk_unprepare() in an
error handling path of the probe and completely remove the .remove()
function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/input/keyboard/spear-keyboard.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 5d9fc8dc9433..1df4feb8ba01 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -222,7 +222,7 @@ static int spear_kbd_probe(struct platform_device *pdev)
 	if (IS_ERR(kbd->io_base))
 		return PTR_ERR(kbd->io_base);
 
-	kbd->clk = devm_clk_get(&pdev->dev, NULL);
+	kbd->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(kbd->clk))
 		return PTR_ERR(kbd->clk);
 
@@ -255,14 +255,9 @@ static int spear_kbd_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = clk_prepare(kbd->clk);
-	if (error)
-		return error;
-
 	error = input_register_device(input_dev);
 	if (error) {
 		dev_err(&pdev->dev, "Unable to register keyboard device\n");
-		clk_unprepare(kbd->clk);
 		return error;
 	}
 
@@ -272,13 +267,6 @@ static int spear_kbd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void spear_kbd_remove(struct platform_device *pdev)
-{
-	struct spear_kbd *kbd = platform_get_drvdata(pdev);
-
-	clk_unprepare(kbd->clk);
-}
-
 static int spear_kbd_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -372,7 +360,6 @@ MODULE_DEVICE_TABLE(of, spear_kbd_id_table);
 
 static struct platform_driver spear_kbd_driver = {
 	.probe		= spear_kbd_probe,
-	.remove_new	= spear_kbd_remove,
 	.driver		= {
 		.name	= "keyboard",
 		.pm	= pm_sleep_ptr(&spear_kbd_pm_ops),
-- 
2.45.2


