Return-Path: <linux-kernel+bounces-425224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196399DBF10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D5A281A64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95536155300;
	Fri, 29 Nov 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="AUVDfcf5"
Received: from sonic316-13.consmr.mail.bf2.yahoo.com (sonic316-13.consmr.mail.bf2.yahoo.com [74.6.130.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97C22EE4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854978; cv=none; b=tZABTmZd6y4kWOyXeYu/2N+e9lUkIYqYHrsxqgq6EQCJw8eIw+gMJByxGOFObST6yH9jjNri90m4HmIYoQ3bVaPoNebPQbsQtKh4Y4YGWG8NbXt5SXWWVPFEtLmK3rTTkuF0r8d/vYcUh0KeMYSF2e+ebq0u6ZvGIbLCFQXxZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854978; c=relaxed/simple;
	bh=/GYS3tyk6ohx/hpEoVAYc20lAtMbm/H6RZw+6ZfaHj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REC2Ko5H6vbVrRz5sySyBZ4JMq54UNTGd+J1D7ocL4/7teanK4+IBSjYriPk6cCQ/aIKDCdwTbO3Pqlj9jfaPNsjgpr2oU0vcSDf0BA5hznTFhUpQ23tqSe9Tq5Q8pHnuGK0zreKZzT1jB269+fuonjFSeSWpBGypMS50aFEdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=AUVDfcf5; arc=none smtp.client-ip=74.6.130.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1732854976; bh=mnpaswUcNfqc5Ew93OTCuZPe99F1ItTwUwh/LKE14ZQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AUVDfcf5lIiszUwPtfq7o7L+ojFrufsTA9zEi5tbZQTsM3qRaPVsYa4gOaaGG2yCM5biV9mIGsX7x+1730dTQ0cog4tjaNoHZVrr4iW0RwAZ9g35xteXyNPRsNAl8eRLnlL+vLAWXscrwGHIz/+uaAF5iQjWYisiEbt2iBZXP9t6T+uhRZBWPBLf2dnPw4YBFgYWoiCHPlRpkNkrq8yR4rzTemBrAkAD6cfH26sLf2WFbzdXghiQZ5/2sBgHvixhKyTDow47OIUFqoRfg++wY9LVru+cUgDO6M8NOzJfdUZksWVfYKlLVUiq7O1Vh4BMo2RGMDyttabJN9IrJo8Wgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732854976; bh=9aIVFp3JVERvmrLHu/mFW72NVlPTwHSmQ4K7Y4MMHIo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LzaxeogTLHy4v+mgxzc7xd9TGEDCaEsRVrrjaBGaZoOnci64v5j1O4HNYo/AWnFyTDfNklUJYNP0pPl9LePuSmkJ12n2aXM45fyd2uVX/Sr1qi2ytEM5B9biSV7451PKECXnY0HVV4xJa7eySdCa+87bE3rmtf416hg9lsRbHplrgR7G/hAX1qP7+fGNBqSZSlyw6yuNj9jUJ5Imlt0o1VERSW/oIWc5OL8uKooHRoapT4AqQmVM3atI4FmPMPNLqR/H7bOLj/qESqV1M21YWLRdZSkEQAUcl1WtxqiZD0oBdg8/tnprgDe+M1Cqqv3uid+z8xMXJji/Lh8BrI+Njg==
X-YMail-OSG: H2x0rF8VM1kOb4Al08UiVihAI2bnLOSgpTEIEwTpRz6.yzPcRe2i6aotVmLMnLZ
 7ZAyZ7Eu3mmLEbH7QRlZtg4b.9cWvtwPpi2bEvKSSWu0L2D0eydEIo6ymVa4epN5c3qqHCTCWHVh
 O_ajIvY0kmig84phz.TuWjRg.pjXEDxdhDI7dZURjXZKjAa4oABsHWeUiBX4eRpvFQOpenMvlOtr
 My22cxsoZ8fyJ5kKkp1uVINsXDXS7bvnqt2McxhGjzTMWUhahj4UeoGTH8PNLMFYVqF1GhPY1Wpq
 IRQrEunh5tiQ5NwT8G.baexCzduBdFIY6GQBHg3MNKCRQQg63DEWZXwG6jW7pScwe47VgG4DEPzV
 Jk_Po2qCUSxW0rHrpmRKA88DKUdkxE8Gkwn_m1lHwPOQrYmk3wjR6UTH2EW64VDno_IYQWqd68wT
 SZQbLHY_YYPNgHXppG0BNcqSziRL04vyYPptyu2fN2xCvIIJ.x3n84vJqGae6QobC6.cAiohRXDO
 x3EVzcC56xBLsmbb8At60gYKGfHavso8paUrfmUp06D0tpOfF8c4vskqj5O2cxJz0ET7oRJbwhkh
 Wvly.g0bhmQNXOSMRojKrKOzl17SXu5CrBWF5VxXSLKNkVT4.ObpXo3_ZAWQOojtpicoA1qj6_TO
 5X7QNaMtwpIJ_ryoK6vLxui8WNIE9qCJ3.Voc3sDS97O0SjsZJzcerf0vt28R_2ttOKSVtqpttCN
 2Y1N1aMXqkgbLkMV6ntHHeAy2hzwnBNhCj3KE7qZeu8bzc5Sb0IqmisziGZXxf0NnNHyxVmav2rI
 mjqi31duylmbYUI2QxpKmYzau3nns.vXl1LCI9PzoA0INPxWJpl_5Xgly0lB0zC_6IhblWWYMy2E
 U4g0ErUC_SrHNtyT39.TWGpIYa6hiZzc38zdiKtclj_cSQQPedFHzuUO8pW3rJTJMB7ETqxbjUu.
 bVVRlLpPUS.yYJ.opUQtf0xxLKzfr6IpklbNMvCvnL5gD51O1Pk5uxmy.WEP5v0Xs7cYSm8CqLut
 cax7GNqgnx0HQVAWxHSll4kYz9amEnIMSXLpJAwgNRkT1EMnJyrOSbadHXcikBTMCjn4eu_rTbJ9
 YcCWOwiJtgAiG_GOBSscNK_.Do1H5nwYEr1SSY8c_bEnbx2VFvGQ4AT9_fzWssJcrO1woExFoDIv
 Ew3cDeAPvGM76uC24i2MwpeclGdOQHlxchF0WTgLX3TZRXsQcYy8bWCKn4u482u2RF6ksxwnB85_
 nX_OzsRR1XoIh0HXLmBPiy4RuI0oHSAAbpIezyZxwgIos3mlVGJWfZ2HJA7Fe2G2Z2LYVB1zK7x6
 BllHAhdlKcM7EWUKZJGQf2eVLqbiWBLJCg6IYVCGLn2OgA.D9da3VR4iYrQ0zNWAXDFeluX7vkZ7
 QSwT_8td22Nv4Qphg1ihNq8X_TAb.ZP6OsII53ANH6T_nZ6al56HhXbbVJepxCmpkwzgbjmsPsJn
 nH_5G2jiQTIY5Mo9s5QLoRfVMBLYNetsusLc.26zjhOM8eiNiFjTalhoen3q33b9pulzGtAF3jw6
 G50bB2HrgYvMUnr4hsnuahp2f820ug_vlmvxcUd3BFFE13SjSnmgcMTDUB0ntN3yfmV346.SVx82
 df_ZC47AkIe015I_a64v.0o_gbEwvodXH9RkfNNPlhaUrOVBigVczQC8BIFACrKh49dlPMiu3JSx
 1bJyKLnoRDOS6bJw8GkTNiCWtRHiOu7MuwNiFrAHbSq0xhvAsu.rDeDodYQG2OSj1nUAaayL0etN
 ps5LcqqlFnHvmHeEYYzUDw8IAnUXGec6BwlSOP_Wy7q9fz9VPx3nLtzsnDDQo3QtLSIs5JfsmU4z
 0TiWmMN5hY_P31kdMpA4OSvry8AOy5o.n92JX4eqVO51hSfxC_v4At5qv2.YySc_KPrXzG644B4z
 yLMFp16w4QoLkFFVFpTvaH.RmeqAjZO6x68VNd.d66RC.Zw2EMEUgAcnwmQZGJEEaIUhRHMELrg7
 dJfbG6eeEEk5MjmgQq5M5JPEq9UllJxBAXCglryqug1dG6nUnXZU1OYrqrba68pV0dtTq.QaFv86
 q_DX0XFYdaunW_cPpBB_LV54UmgUV9AzwDXgwnMCjAWvE5lKuU9t.Yr.Nt2NVWw1oG7OPhJIu2YK
 WNHCNLOfhCovHj2aL8PumdfxY2JksQr14E1Dmp3LN4.pHmHcgMA0T10lzfR1aEvR.XqsX7w8sYP_
 O27PsPTF7R59xksQGXJGot2ORR0EFdJMnhr2t_uj0u0YkAyhNU8o9FbgG61puIqmG_pEve6c3yyk
 fXJrnObsD0sU-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: ca1826b7-3d04-4018-9831-c93515cd764e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Fri, 29 Nov 2024 04:36:16 +0000
Received: by hermes--production-bf1-66bb576cbb-h2pjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af1c0b40292d512b9d850181f2953147;
          Fri, 29 Nov 2024 04:15:58 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: n3rdopolis <bluescreen_avenger@verizon.net>
Subject: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a console device
Date: Thu, 28 Nov 2024 23:15:48 -0500
Message-ID: <20241129041549.778959-2-bluescreen_avenger@verizon.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
initialized by console_initcall() and selected as a possible console
device.
Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
---
 drivers/tty/Kconfig   | 18 +++++++++++++++++-
 drivers/tty/ttynull.c | 16 +++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..afe4e7722d4c 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,23 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  CONFIG_NULL_TTY_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_CONSOLE
+        bool "Supports /dev/ttynull as a console automatically"
+        depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device.
+
+	  This is useful for userspace applications that expect a working
+	  console device, without changing the kernel boot options, such as a
+	  distribuition or environment that historically had CONFIG_VT_CONSOLE
+	  enabled, and have now disabled it, but still need /dev/console to be
+	  working for userspace applications.
 
 	  If unsure, say N.
 
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..8ba629ae426b 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,10 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+#ifdef CONFIG_NULL_TTY_CONSOLE
+	.index = -1,
+	.flags = CON_PRINTBUFFER,
+#endif
 };
 
 static int __init ttynull_init(void)
@@ -90,10 +94,20 @@ static int __init ttynull_init(void)
 	}
 
 	ttynull_driver = driver;
-	register_console(&ttynull_console);
+	if (!console_is_registered(&ttynull_console))
+		register_console(&ttynull_console);
+
+	return 0;
+}
 
+#ifdef CONFIG_NULL_TTY_CONSOLE
+static int __init ttynull_register(void)
+{
+	register_console(&ttynull_console);
 	return 0;
 }
+console_initcall(ttynull_register);
+#endif
 
 static void __exit ttynull_exit(void)
 {
-- 
2.45.2


