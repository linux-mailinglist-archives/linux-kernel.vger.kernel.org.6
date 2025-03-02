Return-Path: <linux-kernel+bounces-540582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A52A4B272
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330C4188EE0D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11F1E98F4;
	Sun,  2 Mar 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Dx0/ybMq"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1F1E8326
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927584; cv=none; b=X7NGXx/QHVTtI9ZOYMxOEnTn4wAex7lScZN3ODPyl9sqXVPZSSpeGmMCH83f8I+PoB/HYhMA0hcrLRgKOQbRkBnJcCWtwRb9qt5g2I2e2J+Aup80vUvuN55z8e2BNRaNt4PWqlbiZV0j+6Nc91wUMDIAoAgMaLdQSjkasBYJFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927584; c=relaxed/simple;
	bh=dEP2cqeSMCkQOUObe5v/f+NSjsWbqaiovk6XDkqA1Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6kU3KHxib6hCrOJnW06aOGkDe7Aawalb6NoL6VqA6e/JtbHi5/+3WE+rHg5UfX0coloHfKy7s/cJ+UetSiEtNCvEUQcCIwHbDCIjyOTjlTKXYZZ2350YIPwaagWg+9uNzBc/1LZ5B0EFHbMVEZhVH7dHP5FztNvn22zXUUAkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Dx0/ybMq; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id okmqtJVk70yWRokn6t9OJ1; Sun, 02 Mar 2025 15:59:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740927581;
	bh=KMpJ1cgSZnZMApMOU4s4omcRGFI4bQ1HNYVgjZASNXo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Dx0/ybMqwXj8mbrXBHEK6pjr9gGi0LI4qtj1udzo9LebLiYUEKhR/IgPOG24dEoDK
	 NOIYY2bkElFeMi2bSqs4/EFCCw/gpEQ3g1jT6Mb2xQlxMZmBTGo0Ofu5OtDD1y6w4C
	 fEcfOBYRKV53Ji6SqTgbCSGVyshsgKXRCJVBEXY9Ycj719ran9PVo92lb6wJig9xPW
	 6rVY+E5CHdfrG0/yl95P6J9CbGOrOmcQqF60QKIHFOuQza5S/xR2vKmw9v2Jf/rc/A
	 JxRFbkpP0e1ORq8zuo0i+vRnEFfBKWtIpQ1e6bd6Vdj9w4b5x4A97CsoVm7HcNpzwm
	 m8aS0h8jNJxyw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Mar 2025 15:59:41 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] powerpc: gpio_mdio: Use devm_of_mdiobus_register()
Date: Sun,  2 Mar 2025 15:59:16 +0100
Message-ID: <639cf94e5b5f0f9532b65a34844165b889934d52.1740926808.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740926808.git.christophe.jaillet@wanadoo.fr>
References: <cover.1740926808.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_of_mdiobus_register() in order to remove the now empty .remove()
function.

Doing so dev_set_drvdata() is now also unneeded. Remove it as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.
---
 arch/powerpc/platforms/pasemi/gpio_mdio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index 2c54f5f063b7..6712ccb84c0a 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -234,10 +234,8 @@ static int gpio_mdio_probe(struct platform_device *ofdev)
 	priv->mdio_pin = *prop;
 
 	new_bus->parent = dev;
-	dev_set_drvdata(dev, new_bus);
-
-	err = of_mdiobus_register(new_bus, np);
 
+	err = devm_of_mdiobus_register(dev, new_bus, np);
 	if (err != 0) {
 		pr_err("%s: Cannot register as MDIO bus, err %d\n",
 				new_bus->name, err);
@@ -247,16 +245,6 @@ static int gpio_mdio_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-
-static void gpio_mdio_remove(struct platform_device *dev)
-{
-	struct mii_bus *bus = dev_get_drvdata(&dev->dev);
-
-	mdiobus_unregister(bus);
-
-	dev_set_drvdata(&dev->dev, NULL);
-}
-
 static const struct of_device_id gpio_mdio_match[] =
 {
 	{
@@ -269,7 +257,6 @@ MODULE_DEVICE_TABLE(of, gpio_mdio_match);
 static struct platform_driver gpio_mdio_driver =
 {
 	.probe		= gpio_mdio_probe,
-	.remove		= gpio_mdio_remove,
 	.driver = {
 		.name = "gpio-mdio-bitbang",
 		.of_match_table = gpio_mdio_match,
-- 
2.48.1


