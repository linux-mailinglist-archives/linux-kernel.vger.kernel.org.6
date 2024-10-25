Return-Path: <linux-kernel+bounces-381503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E89B0025
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57E6285077
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB918DF6E;
	Fri, 25 Oct 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LXY+DoAL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CD1E3765
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852197; cv=none; b=DCgSK3c68nSK7XrAUOisUUQ3AAiVLnme4A0hwyfNlu0w47DtIYU3rYETV8wIixg2ZHSt10DfvYUfBhWZPxcdw7rVz0N6ER6j1aMpxmgMesjc6jcEM5r3CZ/DZfZ650WFJR0ayvxluRJ95pwDcZyw9bKkpxl+DqgrwRMsuoafw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852197; c=relaxed/simple;
	bh=wEi6wwKjIXHH1Ku7uh7cUgEeLJTJHt/hXNm1/jB00VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EdIxHJVvBw5JAN5tsiNF8jYqX6rO75Q+GE2seec2RlogyQvY0WxqQeOgLH5wNeY1Yx27sva6q5hR5df74lIbdLFhL7/eY94sRmd4jN3yGCdbgoSu29wrPYD8g8DRrh/zJQ91uwtCYkaNcIUKRa8v2xrjovZY8BKfjHE2MKgUXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LXY+DoAL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2634096e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729852191; x=1730456991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6r40w+9gpBYWi6R9MLIo8X0+anDd7L2g4ENJQi2L/0=;
        b=LXY+DoALKv+62IP1CHc5lwgjVi1SFnyx7OD4XX1hZcXr1jgCN7DaVlA+j3+sVblgz4
         arwstEuGhgRsz8PO8zAxgfW/tKbGqLL3eoXOtP4UvLMbvRv5QHBy6XaY8kmGIzYB8m8s
         V0D3rzsa1qG0FR+3FGUVX0yLv4gFEcSSN0IJp0/seSWqoKMt8w3NqTy2E+VG6fv2jP4n
         5KatfXCzY/dUs7fTR5mL60Bt31QhF4kJ0muUb+OBDYTBJKp6pEjd8zARixV3GxDb5xnq
         PE2WTJ+pWjoo2FwcsIRe/yKCM58KlKfauA8DjWs6hEW63nXyyy88MMGH5BFHU+VqRnVp
         qHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729852191; x=1730456991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6r40w+9gpBYWi6R9MLIo8X0+anDd7L2g4ENJQi2L/0=;
        b=NwdL5mq1UrTMaBYiFdYQmudCbkCaVKVYaG1monl3YFoS08ibAJ7cPB4FlxOJ1OTTXd
         GuH7ocwchj7ixZy7FvZzO7r5h1CLZFeatKpWGWefUxkmlXPzYUvpUCSJbR0Kumdvq2sh
         YgBKKZl68+W2Uohn528LN79212hFJgWhYZT1IxLrUWU/ecuG3zDqSNBgW+5e6bjCSVGq
         aan1UUkKEyLP54cE72iTYeq9GcXmH9novrwfo1rIeGK4q+dd0E5fOuBXyNiLoYDCDXxW
         dOfalmeLz8WTr6P0fK0VHagjKt67HFleYDKV9IoNyI3kxA4R/Ne+gn8K6c4tmrO/0g0x
         tKeg==
X-Gm-Message-State: AOJu0Yy85/dt+PQnO4fywv9+ReMeVaEudMQXyuL7O9Rjdlq9+w0b4hV1
	ktjVrw7iKojQ+5Y99JG/ZWfhhqU8fw4fq/hF6FJI7DCbb/Y+KmmRbOnajI2Xhb6bWupvIwY8AgI
	e
X-Google-Smtp-Source: AGHT+IEgP5FVj5qOZDjvdN0ba2o3v4LpTKCegCT/omjf+BIFfcyrlXoJFjMhxy5fNTIPFbYb/zaE2A==
X-Received: by 2002:a05:6512:3195:b0:539:e333:1822 with SMTP id 2adb3069b0e04-53b23dde3e4mr3273700e87.4.1729852191084;
        Fri, 25 Oct 2024 03:29:51 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567868sm44117335e9.24.2024.10.25.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:29:50 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: Switch back to struct platform_driver::remove()
Date: Fri, 25 Oct 2024 12:29:44 +0200
Message-ID: <20241025102943.250184-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11583; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=wEi6wwKjIXHH1Ku7uh7cUgEeLJTJHt/hXNm1/jB00VE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnG3MXxgSAA5OkCcck2j85C38DrVvbxvBjnM2ky +PH4vqOJvyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZxtzFwAKCRCPgPtYfRL+ TtYkB/0VVINJBgtlH59G9D8seZGx1CkNFnQ3EiBbIjQSjlnqXroU9gDouppPD+KNVkUWlJUtJaP A1J1NsMhLFLxr405pRtHocX9vneZ+Izpu8gAi+WDX9RIETGTOrpk1F9xvW9cTdhXXVuhW2ughME +eEQbIpnfkgMUDdg4bmPhzQTo9EQgFH1Jsxt1a+3qLuE8IAqxdqeW6AXgk0wkuJpgRfZ+nfYX5c JHsUV76IcuS8DJL4/t87zC+8zPnl6LQXN+aMmp74BT2Dmmf6YqYFRqHabx8QG0PH+dzPvTiyQ6n MqxtpRPAo8IAJF4ovkG0B65eeUz4Md5DM3rO7dMmjza+HSrW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/mfd to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

On the way do a few whitespace changes to make indention consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/mfd. While I usually prefer to
do one logical change per patch, this seems to be overengineering here
as the individual changes are really trivial and shouldn't be much in
the way for stable backports. But I'll happily split the patch if you
prefer it split. I also can break out the whitespace changes if you
prefer.

Note I didn't Cc: the maintainers of each driver as this would hit
sending limits.

This is based on today's next, if conflicts arise when you apply it at
some later time and don't want to resolve them, feel free to just drop
the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend.

Best regards
Uwe

 drivers/mfd/ab8500-sysctrl.c      | 2 +-
 drivers/mfd/cgbc-core.c           | 2 +-
 drivers/mfd/cros_ec_dev.c         | 2 +-
 drivers/mfd/exynos-lpass.c        | 4 ++--
 drivers/mfd/fsl-imx25-tsadc.c     | 2 +-
 drivers/mfd/hi655x-pmic.c         | 8 ++++----
 drivers/mfd/intel-lpss-acpi.c     | 2 +-
 drivers/mfd/kempld-core.c         | 2 +-
 drivers/mfd/mcp-sa11x0.c          | 2 +-
 drivers/mfd/mxs-lradc.c           | 2 +-
 drivers/mfd/omap-usb-host.c       | 2 +-
 drivers/mfd/omap-usb-tll.c        | 2 +-
 drivers/mfd/pcf50633-adc.c        | 2 +-
 drivers/mfd/qcom-pm8xxx.c         | 2 +-
 drivers/mfd/sm501.c               | 2 +-
 drivers/mfd/stm32-timers.c        | 2 +-
 drivers/mfd/ti_am335x_tscadc.c    | 2 +-
 drivers/mfd/tps65911-comparator.c | 2 +-
 drivers/mfd/twl4030-audio.c       | 2 +-
 19 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 8f3ebe651eea..b6b44e2e3198 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -159,7 +159,7 @@ static struct platform_driver ab8500_sysctrl_driver = {
 		.of_match_table = ab8500_sysctrl_match,
 	},
 	.probe = ab8500_sysctrl_probe,
-	.remove_new = ab8500_sysctrl_remove,
+	.remove = ab8500_sysctrl_remove,
 };
 
 static int __init ab8500_sysctrl_init(void)
diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 93004a6b29c1..ac3042fd5aa1 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -364,7 +364,7 @@ static struct platform_driver cgbc_driver = {
 		.dev_groups	= cgbc_groups,
 	},
 	.probe		= cgbc_probe,
-	.remove_new	= cgbc_remove,
+	.remove		= cgbc_remove,
 };
 
 static const struct dmi_system_id cgbc_dmi_table[] __initconst = {
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 2cbd07359954..9f84a52b48d6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -365,7 +365,7 @@ static struct platform_driver cros_ec_dev_driver = {
 	},
 	.id_table = cros_ec_id,
 	.probe = ec_device_probe,
-	.remove_new = ec_device_remove,
+	.remove = ec_device_remove,
 };
 
 static int __init cros_ec_dev_init(void)
diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index e58990c85ed8..6a585173230b 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -179,13 +179,13 @@ static const struct of_device_id exynos_lpass_of_match[] = {
 MODULE_DEVICE_TABLE(of, exynos_lpass_of_match);
 
 static struct platform_driver exynos_lpass_driver = {
-	.driver = {
+	.driver	= {
 		.name		= "exynos-lpass",
 		.pm		= &lpass_pm_ops,
 		.of_match_table	= exynos_lpass_of_match,
 	},
 	.probe	= exynos_lpass_probe,
-	.remove_new = exynos_lpass_remove,
+	.remove	= exynos_lpass_remove,
 };
 module_platform_driver(exynos_lpass_driver);
 
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 2e4ab2404154..6fe388da6fb6 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -211,7 +211,7 @@ static struct platform_driver mx25_tsadc_driver = {
 		.of_match_table = mx25_tsadc_ids,
 	},
 	.probe = mx25_tsadc_probe,
-	.remove_new = mx25_tsadc_remove,
+	.remove = mx25_tsadc_remove,
 };
 module_platform_driver(mx25_tsadc_driver);
 
diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 5f61909c85e9..3b4ffcbbee20 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -159,12 +159,12 @@ static const struct of_device_id hi655x_pmic_match[] = {
 MODULE_DEVICE_TABLE(of, hi655x_pmic_match);
 
 static struct platform_driver hi655x_pmic_driver = {
-	.driver	= {
-		.name =	"hi655x-pmic",
+	.driver = {
+		.name = "hi655x-pmic",
 		.of_match_table = hi655x_pmic_match,
 	},
-	.probe  = hi655x_pmic_probe,
-	.remove_new = hi655x_pmic_remove,
+	.probe = hi655x_pmic_probe,
+	.remove = hi655x_pmic_remove,
 };
 module_platform_driver(hi655x_pmic_driver);
 
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 2a83f8678f1d..557061856e58 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -208,7 +208,7 @@ static void intel_lpss_acpi_remove(struct platform_device *pdev)
 
 static struct platform_driver intel_lpss_acpi_driver = {
 	.probe = intel_lpss_acpi_probe,
-	.remove_new = intel_lpss_acpi_remove,
+	.remove = intel_lpss_acpi_remove,
 	.driver = {
 		.name = "intel-lpss",
 		.acpi_match_table = intel_lpss_acpi_ids,
diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 8a332852bf97..c5bfb6440a93 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -486,7 +486,7 @@ static struct platform_driver kempld_driver = {
 		.dev_groups	  = pld_groups,
 	},
 	.probe		= kempld_probe,
-	.remove_new	= kempld_remove,
+	.remove		= kempld_remove,
 };
 
 static const struct dmi_system_id kempld_dmi_table[] __initconst = {
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 3883e472b739..228c4a2f4c1f 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -286,7 +286,7 @@ static const struct dev_pm_ops mcp_sa11x0_pm_ops = {
 
 static struct platform_driver mcp_sa11x0_driver = {
 	.probe		= mcp_sa11x0_probe,
-	.remove_new	= mcp_sa11x0_remove,
+	.remove		= mcp_sa11x0_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= pm_sleep_ptr(&mcp_sa11x0_pm_ops),
diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index b2ebb5433121..64afc7631790 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -243,7 +243,7 @@ static struct platform_driver mxs_lradc_driver = {
 		.of_match_table = mxs_lradc_dt_ids,
 	},
 	.probe = mxs_lradc_probe,
-	.remove_new = mxs_lradc_remove,
+	.remove = mxs_lradc_remove,
 };
 module_platform_driver(mxs_lradc_driver);
 
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 6de7ba752345..a77b6fc790f2 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -843,7 +843,7 @@ static struct platform_driver usbhs_omap_driver = {
 		.of_match_table = usbhs_omap_dt_ids,
 	},
 	.probe		= usbhs_omap_probe,
-	.remove_new	= usbhs_omap_remove,
+	.remove		= usbhs_omap_remove,
 };
 
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 5f25ac514ff2..0f7fdb99c809 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -301,7 +301,7 @@ static struct platform_driver usbtll_omap_driver = {
 		.of_match_table = usbtll_omap_dt_ids,
 	},
 	.probe		= usbtll_omap_probe,
-	.remove_new	= usbtll_omap_remove,
+	.remove		= usbtll_omap_remove,
 };
 
 int omap_tll_init(struct usbhs_omap_platform_data *pdata)
diff --git a/drivers/mfd/pcf50633-adc.c b/drivers/mfd/pcf50633-adc.c
index ab55906f91f9..1fbba0e666d5 100644
--- a/drivers/mfd/pcf50633-adc.c
+++ b/drivers/mfd/pcf50633-adc.c
@@ -243,7 +243,7 @@ static struct platform_driver pcf50633_adc_driver = {
 		.name = "pcf50633-adc",
 	},
 	.probe = pcf50633_adc_probe,
-	.remove_new = pcf50633_adc_remove,
+	.remove = pcf50633_adc_remove,
 };
 
 module_platform_driver(pcf50633_adc_driver);
diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 8b6285f687da..f9ebdf5845b8 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -595,7 +595,7 @@ static void pm8xxx_remove(struct platform_device *pdev)
 
 static struct platform_driver pm8xxx_driver = {
 	.probe		= pm8xxx_probe,
-	.remove_new	= pm8xxx_remove,
+	.remove		= pm8xxx_remove,
 	.driver		= {
 		.name	= "pm8xxx-core",
 		.of_match_table = pm8xxx_id_table,
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index b3592982a83b..0469e85d72cf 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1705,7 +1705,7 @@ static struct platform_driver sm501_plat_driver = {
 		.of_match_table = of_sm501_match_tbl,
 	},
 	.probe		= sm501_plat_probe,
-	.remove_new	= sm501_plat_remove,
+	.remove		= sm501_plat_remove,
 	.suspend	= pm_sleep_ptr(sm501_plat_suspend),
 	.resume		= pm_sleep_ptr(sm501_plat_resume),
 };
diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index 9fd13d88950c..650724e19b88 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -326,7 +326,7 @@ MODULE_DEVICE_TABLE(of, stm32_timers_of_match);
 
 static struct platform_driver stm32_timers_driver = {
 	.probe = stm32_timers_probe,
-	.remove_new = stm32_timers_remove,
+	.remove = stm32_timers_remove,
 	.driver	= {
 		.name = "stm32-timers",
 		.of_match_table = stm32_timers_of_match,
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 0c1364d88469..068c25401c6c 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -377,7 +377,7 @@ static struct platform_driver ti_tscadc_driver = {
 		.of_match_table = ti_tscadc_dt_ids,
 	},
 	.probe	= ti_tscadc_probe,
-	.remove_new = ti_tscadc_remove,
+	.remove = ti_tscadc_remove,
 
 };
 
diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index f206a9c50e9d..7098712ea008 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -154,7 +154,7 @@ static struct platform_driver tps65911_comparator_driver = {
 		.name = "tps65911-comparator",
 	},
 	.probe = tps65911_comparator_probe,
-	.remove_new = tps65911_comparator_remove,
+	.remove = tps65911_comparator_remove,
 };
 
 static int __init tps65911_comparator_init(void)
diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index d436ddf661da..a4a550bafb3c 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -276,7 +276,7 @@ static struct platform_driver twl4030_audio_driver = {
 		.of_match_table = twl4030_audio_of_match,
 	},
 	.probe		= twl4030_audio_probe,
-	.remove_new	= twl4030_audio_remove,
+	.remove		= twl4030_audio_remove,
 };
 
 module_platform_driver(twl4030_audio_driver);

base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
-- 
2.45.2

