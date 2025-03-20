Return-Path: <linux-kernel+bounces-569730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24AA6A6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EB9468DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70038224AFB;
	Thu, 20 Mar 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luAsT/bk"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F62236ED;
	Thu, 20 Mar 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475704; cv=none; b=FvoCt+iRsfpH2YeAa+Y03Gu3hRbfKQ2Im/jCTV+ev1mARBJQyNai7mJhyn+GpC51EnM4G2kdCnsG+twJciF8Gvs/v4w6B94EPNTLtgyRjgCCpFrvC9GeZePqhtTShNHiqx0zyGRBdSbrLqu/1scJbrlqYRPafNQd4jTaXo9ATT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475704; c=relaxed/simple;
	bh=KcGI1lTmvuWRPusPQcZonrgvBEs0ltW3p3fegTmFIAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFu5rv9pCTPiu5fwB7QfljIP4gU/MjO4WERWhkIXDK5T680GEL4J4Dr9Vyy/xpIt+jExdmmSDReNdKEJG2THFwnY6VIlIyuxTeaKBiKK17Yy0asCJ+hX3ICrwSJu1GW6WB83enHmCa5p1/i2bUgscz02ORFDcKtglLWQ5Eu7aLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luAsT/bk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39130ee05b0so698251f8f.3;
        Thu, 20 Mar 2025 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475701; x=1743080501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1i3DRbTdyzbpnAKiDfDQZ1mLdcscqRmuPns+JX+LUjs=;
        b=luAsT/bks3QvbALnIq62wDwGlbCY97sfKTezIPOkSlVNRiXibz7A7UN5LD+N3NM9FI
         0fMK06oyrsL6BqXgJL67E/YS6bnL8/emX1KT9+QwVKvWEpien7ihih089frH99HF2PIO
         hhj6hjGjQ2BYGBvqRmkO1nxEyL5NF6C2LKWhVhcg1XmpauKwE8FIvn4JmNe54biBPX42
         ATY0yLRQR72Z5O+/veLyMClbbLEjvNFNWy75LezE3Tzn4h4tvIrfZIAUi0ILO9XVlbEa
         AHju+tuXeirPqL5ruWPC+F5qo9/uFCNr12qqz4XyYZxiJsx2GwvjUw+zexMqoS83b5h3
         FXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475701; x=1743080501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i3DRbTdyzbpnAKiDfDQZ1mLdcscqRmuPns+JX+LUjs=;
        b=nRzYqXKkIrEtH4wlpoigvGPSDYmtogv09rSQTXMv18ad07JeQDVm+DI9o9G3yeZtlF
         fpHiA2Fu8jFVtw7GOjFmmHljMdkF4FUA2mHdK8nzHtvm1d1+HaJFOZEncxk2l0R3ttqM
         b6EUZrSnxH5KjRo+zqa8lgKgH5r91EjMps7aQP7p6xEh9+Edg+dEm5J5jjsw2QkDr8v1
         boRl5wf1+1Q8iWp4Gp/8Y/EZi7GITAuyPlGkVT2s76TnPormOgkzMyuokOnTNWjGEyfd
         lPNlAxIR43h4TZqcvmKH9zyJojjC3RHzCBpGpevoyiPQ+6nADr+KxUPQa4OfVyfiOkE/
         098Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAFQcLLBgGy4sDMpQNdfhZPYcYXuIToQhHqfBpC9n+h3XWbHlBzNPTRKwUdbLYweAIZnSKWrcE7BIB@vger.kernel.org, AJvYcCUg+TmEip8OkcFMBMOU3aUjNzVsaQzqi7EvmMpmMoYE0dmGr+BzL/2Z/MvfrTQuaG8q5RqD+oCWTmps@vger.kernel.org, AJvYcCUsr28Ds767MI7DVGGzPgdJdHCh85wSk15vzz311IjXs/KbJqfMNMasohE9ut3Bu1WYRrXUqOtBZ050nUyA@vger.kernel.org, AJvYcCVrRoGI+lT6ANLwPZ2IQsTUPNWq1uiL1q+BUpMnDmz1UVFslNV8EP6o5csKqmi8jxskHHcs3lvJJ36m@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ksrP9SgSLEnhU/8nKHrsvWmP1SSevglnrtwIRzrTCQRvB2X6
	7eN7RYPBLy/oKMMMjO5+tfI0nF6Bwho9w+7PzWxFNz7Ufv8oGFxu
X-Gm-Gg: ASbGncsTP3yFO3BkBX7YE1GZgEYyB4megof9N1kw6uS1MJ0Btsp49U8x/6P9A1LXDFP
	2eAS/OleKPtn6woHBnQD/nYzFR6GI5/2bKGNZtd0EHd6NXoaJV7H65j/p7wR6KtSfOcMk/Kbt+/
	ElqrSfSu+yp8EHTKKNrY5Y91ojssllIrGAljUWRXlQQG+VZ7kXVpp7L1tawZ799+uarv4PdaNDP
	+H4XtgFcIhPzw6qftKfOSJA6tJHUCrowAx5pAqbgGq0RqnYUEYyBK40GXk6k5B7oxtlEui4c1zu
	hzZcB/0Zzc7Ptzp7/U+D7lox4FvdTEIRD/NcSln7DkfBkz/pX4xKd8iX1CcIwoOXZae8Cnqyw1T
	lRa5ChkyLwo2QiQ==
X-Google-Smtp-Source: AGHT+IEQRynyz9JGzu+Wy/hCcpiQtdW/bJaEM9RuaZOW49I93OxOlyiURvahKTtdmPXSEWXajsfaYQ==
X-Received: by 2002:a5d:6c6a:0:b0:391:4559:876a with SMTP id ffacd0b85a97d-399795e77d5mr3094168f8f.46.1742475699266;
        Thu, 20 Mar 2025 06:01:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 06/11] soc: airoha: scu-ssr: expose API to read current Serdes Port mode
Date: Thu, 20 Mar 2025 14:00:29 +0100
Message-ID: <20250320130054.4804-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320130054.4804-1-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose an API to read the current Serdes Port mode. This is needed for
pheriperal attached to the Serdes mode to validate the Serdes port is in
the correct mode.

Each driver will have to define in DT the phandle airoha,scu
pointing to the SCU node to make use of this API.

Function airoha_scu_ssr_get_serdes_mode() will then parse the phandle,
and extract tha Serdes Port state from the SCU SSR driver priv.

Driver will use the new API airoha_scu_ssr_get_serdes_mode() by passing
the dev and the serdes mode reference from dt-bindings header.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/soc/airoha/airoha-scu-ssr.c       | 50 +++++++++++++++++++++++
 include/linux/soc/airoha/airoha-scu-ssr.h | 11 +++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/soc/airoha/airoha-scu-ssr.c b/drivers/soc/airoha/airoha-scu-ssr.c
index 29e17577e9a4..3fbc36f793d0 100644
--- a/drivers/soc/airoha/airoha-scu-ssr.c
+++ b/drivers/soc/airoha/airoha-scu-ssr.c
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/soc/airoha,scu-ssr.h>
 #include <linux/bitfield.h>
+#include <linux/clk/clk-en7523.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -54,6 +55,55 @@ static int airoha_scu_serdes_str_to_mode(const char *serdes_str)
 	return -EINVAL;
 }
 
+/**
+ * airoha_scu_ssr_get_serdes_mode - Get current Mode for Serdes Port
+ * @dev: Device pointer of the Serdes Port peripheral
+ * @port: Reference number of the Serdes Port
+ *
+ * Parse the phandle pointed by the Device Node property
+ * "airoha,scu" present in Devide Node of dev and get
+ * the current Mode of the Serdes Port reference by port
+ *
+ * Return the mode or a negative error code. If the pdev
+ * or the driver data for the SCU can't be found,
+ * -EPROBE_DEFER is returned.
+ */
+int airoha_scu_ssr_get_serdes_mode(struct device *dev,
+				   unsigned int port)
+{
+	struct airoha_scu_ssr_priv *priv;
+	struct en_clk_priv *clk_priv;
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "airoha,scu", 0);
+	if (!np)
+		return -ENODEV;
+
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev || !platform_get_drvdata(pdev)) {
+		if (pdev)
+			put_device(&pdev->dev);
+		return -EPROBE_DEFER;
+	}
+
+	/*
+	 * Get pdev from clk priv. Clock driver register
+	 * SSR driver hence it can be assumed present.
+	 */
+	clk_priv = platform_get_drvdata(pdev);
+	priv = platform_get_drvdata(clk_priv->ssr_pdev);
+
+	return priv->serdes_port[port];
+}
+EXPORT_SYMBOL_GPL(airoha_scu_ssr_get_serdes_mode);
+
 static int airoha_scu_ssr_apply_modes(struct airoha_scu_ssr_priv *priv)
 {
 	int ret;
diff --git a/include/linux/soc/airoha/airoha-scu-ssr.h b/include/linux/soc/airoha/airoha-scu-ssr.h
index 0224c0340b6d..81f2c1b57889 100644
--- a/include/linux/soc/airoha/airoha-scu-ssr.h
+++ b/include/linux/soc/airoha/airoha-scu-ssr.h
@@ -20,4 +20,15 @@ struct airoha_scu_ssr_data {
 	const struct airoha_scu_ssr_serdes_info *ports_info;
 };
 
+#if IS_ENABLED(CONFIG_AIROHA_SCU_SSR)
+int airoha_scu_ssr_get_serdes_mode(struct device *dev,
+				   unsigned int port);
+#else
+static inline int airoha_scu_ssr_get_serdes_mode(struct device *dev,
+						 unsigned int port);
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif
-- 
2.48.1


