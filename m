Return-Path: <linux-kernel+bounces-449758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502599F55BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E782169E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA91F8AC4;
	Tue, 17 Dec 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0ltokNF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3321F8930
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459120; cv=none; b=cfXDD8EVl6jxUsbTxhp0WwX9QM0pUVSds8HpLWPAPv2eMmuZHtXbaQYfEfVMP1rWastk/5J7gTPRI88fCoi9MswjWM81x25LI93P7oxO8ig/+2Mojw9atOAwqB7ByCrphgzWrPv5Fxhlto+lw0d6qL1ajh0SEjj8y3dnezO3T6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459120; c=relaxed/simple;
	bh=kpOrvxsnyhKACVQ2qsRTR3Nb4KrhnGtNpRfRPuIsYjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oT1W4d7qDIq+cVqqD4zyP37A4BxtkljoklfUGmcaEHJFtioSFiUQtTepVI7DEV5/T49agD6zHDjEv4+n7q8dvRygEYYUOYIkar4/9TBOHVQESFg+nBHgiycbLvYEFunNpeM9e9rSrr98ywYBLJamt9g1MsKhCCN/O4fNYpQIsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0ltokNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC21C4CED7;
	Tue, 17 Dec 2024 18:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459119;
	bh=kpOrvxsnyhKACVQ2qsRTR3Nb4KrhnGtNpRfRPuIsYjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E0ltokNFg7sPjq2BCTSCoR6FLN9OUNYcz44OAduYWcIEGL2xsONP3goHw5eFh05fP
	 hVjFTZQdqoyCS1kvwnMjMU9VxHCUlFDiNcD/TDRfEvEVTT07ZsDm4+vFkiQo4Ggn9z
	 mHm2FQI8Lci6zYulzLJiuhngBn0U7+wD7aTLn/nXabFeTTJ0Zzi5Voe8/0rhbVbMS+
	 GoaiDEOPrHAy6frh+DJc5H2E9Bx3aO2c/G8xXRb26T+WRRohVkbq8xO1sPjQPqJgmC
	 A62rpgjIBPDtG5H4HmnE/b/yftZdliDvdyRc3e2NjbgBo9s8VVWaxgWFqApIWRva+M
	 OByw7KNGq9Yfw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 17 Dec 2024 12:11:41 -0600
Subject: [PATCH v2 2/3] mfd: syscon: Remove the platform driver support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-syscon-fixes-v2-2-4f56d750541d@kernel.org>
References: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
In-Reply-To: <20241217-syscon-fixes-v2-0-4f56d750541d@kernel.org>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Pankaj Dubey <pankaj.dubey@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 John Madieu <john.madieu.xa@bp.renesas.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

The platform driver is dead code. It is not used by DT platforms since
commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
platform devices") which said:

    For non-DT based platforms, this patch keeps syscon platform driver
    structure so that syscon can be probed and such non-DT based drivers
    can use syscon_regmap_lookup_by_pdev API and access regmap handles.
    Once all users of "syscon_regmap_lookup_by_pdev" migrated to DT based,
    we can completely remove platform driver of syscon, and keep only helper
    functions to get regmap handles.

The last user of syscon_regmap_lookup_by_pdevname() was removed in 2018.
syscon_regmap_lookup_by_pdevname() was then removed in 2019, but that
commit failed to remove the rest of the platform driver.

Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/mfd/syscon.c                 | 66 ------------------------------------
 drivers/mfd/vexpress-sysreg.c        |  1 -
 include/linux/platform_data/syscon.h |  9 -----
 3 files changed, 76 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 72f20de9652da2d7bad12e4bc2c43ac0c9a97f76..bfb1f69fcff1d3cd35cf04ccd4c449e7d0395c79 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -12,22 +12,15 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
-#include <linux/io.h>
-#include <linux/init.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/platform_data/syscon.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
 
-static struct platform_driver syscon_driver;
-
 static DEFINE_MUTEX(syscon_list_lock);
 static LIST_HEAD(syscon_list);
 
@@ -337,62 +330,3 @@ struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 	return regmap;
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_optional);
-
-static int syscon_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct syscon_platform_data *pdata = dev_get_platdata(dev);
-	struct syscon *syscon;
-	struct regmap_config syscon_config = syscon_regmap_config;
-	struct resource *res;
-	void __iomem *base;
-
-	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
-	if (!syscon)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-
-	base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!base)
-		return -ENOMEM;
-
-	syscon_config.max_register = resource_size(res) - 4;
-	if (!syscon_config.max_register)
-		syscon_config.max_register_is_0 = true;
-
-	if (pdata)
-		syscon_config.name = pdata->label;
-	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
-	if (IS_ERR(syscon->regmap)) {
-		dev_err(dev, "regmap init failed\n");
-		return PTR_ERR(syscon->regmap);
-	}
-
-	platform_set_drvdata(pdev, syscon);
-
-	dev_dbg(dev, "regmap %pR registered\n", res);
-
-	return 0;
-}
-
-static const struct platform_device_id syscon_ids[] = {
-	{ "syscon", },
-	{ }
-};
-
-static struct platform_driver syscon_driver = {
-	.driver = {
-		.name = "syscon",
-	},
-	.probe		= syscon_probe,
-	.id_table	= syscon_ids,
-};
-
-static int __init syscon_init(void)
-{
-	return platform_driver_register(&syscon_driver);
-}
-postcore_initcall(syscon_init);
diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index d34d58ce46db2ad0d53b3daeabc9d3763883b39a..ef03d6cec9ff6927668d051ca459eb1d8ff7269e 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -10,7 +10,6 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
-#include <linux/platform_data/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
diff --git a/include/linux/platform_data/syscon.h b/include/linux/platform_data/syscon.h
deleted file mode 100644
index 2c089dd3e2bda3baf5cef201ef43bca709e12c0b..0000000000000000000000000000000000000000
--- a/include/linux/platform_data/syscon.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PLATFORM_DATA_SYSCON_H
-#define PLATFORM_DATA_SYSCON_H
-
-struct syscon_platform_data {
-	const char *label;
-};
-
-#endif

-- 
2.45.2


