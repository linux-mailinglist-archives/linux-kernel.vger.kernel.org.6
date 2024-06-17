Return-Path: <linux-kernel+bounces-217025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4324C90A9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF56F1F21026
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7A194A73;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXvy602C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD78B193065
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617103; cv=none; b=qEoCUCLwstweDk3QwJzFU1NliBcN8uMVQemAIcOgd85JnVBw/IAu4l7EyjMgoV04LynlhhJcB63s3fDqZEYyz7eNZzYg4hPLB8NuKxjwKI2AmhOQNFdgwTocXSzYxL3hvX6guxOjtt3yTUDoeFx+CimcKxWiW1vu4Wz51rM9kxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617103; c=relaxed/simple;
	bh=yucCIDomIMUeYvavvG6WOeiBbK/6iHEzd0B1YMaaHXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Avq4YKBMQ3hhzaZt5GfzNkr3rEsXOTr2aB+ilLh2sjISMusFqjfaMg6OetOMKxg0E7mc/FA6cuDZdG7LhV80ac7Yhzeg582+ker/Wp0qklrnQ8qjFiankebFaRLmP5lBpm/7FFGVKZ7fCRreaG6kiao0w6KKe1E7iyjzioVu28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXvy602C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 937D2C4AF1A;
	Mon, 17 Jun 2024 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617103;
	bh=yucCIDomIMUeYvavvG6WOeiBbK/6iHEzd0B1YMaaHXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VXvy602C0tyX7IV/953cj7VrK3VTDQVccGvcj3D1R9sgZ+2KtHuT0UAaJ2OT0ck5r
	 /pl8lJlgAcn8g7G5mieT4htscto2bKkLtXYUX2ESQ7XFm+e0N7K0PgLTR1spvDgdte
	 ggnsLslAr6U1QRx8JGRiyafhiR27jR6Yi5SZxeEa+0QW0MqPyfKc3I3dEcNViL14WF
	 e2hQRXnSrZj8Yg6oytROjQbJGhAddBnTL8f8R8q2suY/Q3oj7JocvDSYjzYYtEibB/
	 Jy8b40+fG+KttU0nXwlWUTMqfoUbkG3Po+cFzG1CJ+hQh63wQS4mhQtKX4dHrNhcMp
	 Am/2CWOudtqbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8826EC2BA16;
	Mon, 17 Jun 2024 09:38:23 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:36:36 +0300
Subject: [PATCH v10 02/38] ARM: ep93xx: add regmap aux_dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ep93xx-v10-2-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=1982;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=qKYG1dvu9jbPQUSaZcYLmIk38kz0vsDfRewTf4KPvt0=;
 b=JbzadCel/rsGE2NAAHU1g5fep4qqSMvJZnDGPUVlPJ1pk47peUDCwDX5kylHtjoKQTo8QLHSZjhj
 TbQASLHBDr59f03kPormfKnLEDCLITs6EKKebwBHNKvvNfEqTE3F
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

The following driver's should be instantiated by ep93xx syscon driver:

- reboot
- pinctrl
- clock

They all require access to DEVCFG register with a shared lock held, to
avoid conflict writing to swlocked parts of DEVCFG.

Provide common resources such as base, regmap and spinlock via auxiliary
bus framework.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/soc/cirrus/ep93xx.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 56fbe2dc59b1..a27447971302 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -3,6 +3,18 @@
 #define _SOC_EP93XX_H
 
 struct platform_device;
+struct regmap;
+struct spinlock_t;
+
+enum ep93xx_soc_model {
+	EP93XX_9301_SOC,
+	EP93XX_9307_SOC,
+	EP93XX_9312_SOC,
+};
+
+#include <linux/auxiliary_bus.h>
+#include <linux/compiler_types.h>
+#include <linux/container_of.h>
 
 #define EP93XX_CHIP_REV_D0	3
 #define EP93XX_CHIP_REV_D1	4
@@ -10,6 +22,20 @@ struct platform_device;
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
+struct ep93xx_regmap_adev {
+	struct auxiliary_device adev;
+	struct regmap *map;
+	void __iomem *base;
+	spinlock_t *lock;
+	void (*write)(struct regmap *map, spinlock_t *lock, unsigned int reg,
+		      unsigned int val);
+	void (*update_bits)(struct regmap *map, spinlock_t *lock,
+			    unsigned int reg, unsigned int mask, unsigned int val);
+};
+
+#define to_ep93xx_regmap_adev(_adev) \
+	container_of((_adev), struct ep93xx_regmap_adev, adev)
+
 #ifdef CONFIG_ARCH_EP93XX
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);

-- 
2.43.2



