Return-Path: <linux-kernel+bounces-320852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F1971167
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C0D2833DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A51B1D53;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah5gWAVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F73172BD0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869535; cv=none; b=jHflR8Q1FxoAd5Wiwd4j7JErcfVJ0L8MjXV8K3WCTjVVPHWOp3K5zWrnD7D/q9c20rN+03etL57bPOketQXl92sKzrHVf1WgLuGkvsMbQ8JE4UU1deFqKOEQyHG7UJJ6eEuZM6rI4hjzvHyDHW9fM9hThXh2AT0vbZRoOmNbb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869535; c=relaxed/simple;
	bh=yucCIDomIMUeYvavvG6WOeiBbK/6iHEzd0B1YMaaHXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HR2sjt4oyezmb2rkfjEDt4vdv+uvYbhFZLwVzJxoaPDIopZGibn4tON4+O2rzqRceqY50gk7ClDeP7rCOFwAib5S+o6R2OlMOpjMc5m/lsA81G46ytYfzSifHnyfpgRh/3+lco9kmW+f5f/hzsjLagLjPbRdRP1JoKhqlQ5AK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah5gWAVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AE9EC4CECC;
	Mon,  9 Sep 2024 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725869535;
	bh=yucCIDomIMUeYvavvG6WOeiBbK/6iHEzd0B1YMaaHXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ah5gWAVhQ8il9gS9WNiyJw6O5J3kwkbtR2fKh/QQMZbKmmq0JqDipAQc+eTLDSi+n
	 5j+FjZ4Hs9HSxeKRg3PjjWFObruYQVvYiO3eZPkXrtgP1HqgC0bj1igTy1qq9APEgG
	 Ol+3F36JI61uw1OjPsfU7+eJCYrw71/ueOue+riQ9Hqy3hRp1QA3GPhTMRTlbBM1o7
	 lCZM1CgDxZ4N9cJGbyfCgR0vj3UUFcgD1iW/nMeIr9G53u1ZRIN93LEIF7tx9PDOYY
	 uld2EQMqtNRrWbJatPLt6brVMudiopiPEXLlaB0MdOaEyE0EJAN5PDEi2h0g3b9KSr
	 oIDZ/PGfPpBlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E2CE7AB0;
	Mon,  9 Sep 2024 08:12:15 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 09 Sep 2024 11:10:27 +0300
Subject: [PATCH v12 02/38] ARM: ep93xx: add regmap aux_dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-ep93xx-v12-2-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
In-Reply-To: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
To: Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725869532; l=1982;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=qKYG1dvu9jbPQUSaZcYLmIk38kz0vsDfRewTf4KPvt0=;
 b=Jxtypqj92yD9XaTk7sfQKzGgfE3Y5dqID1b7Vn+NtjPzHkFRsbrpk6nznPd+MWnECHPhnPc/uwnG
 dd2M4mU9CYBQZ2XqPqbBkvhRSRyxUZP4fYE0/lt3p5SmdxfECm+e
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



