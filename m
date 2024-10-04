Return-Path: <linux-kernel+bounces-350117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC999001C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6221F24653
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A81553A7;
	Fri,  4 Oct 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsWjUK/A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52215575B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034904; cv=none; b=k2Q3qsTZzrfXYsHVKryFkMRGgFPWsjYqozDdcS7ZlWrytsgjE5gfsihIOkx4C/Y1jTOC/qnQEwfhLGDSfcJEPE1nQ8SxNfKlAqHVmSS/yEQfXMiTnaZruFzRXxNS3H0eimeFbKGvFKeNVoFy1WuTlMD4fxa4EvGXAu143ufWClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034904; c=relaxed/simple;
	bh=naAuDqb0vFu4Dw0Ubf8SaUqzSDSbfkpbpELOVNHDQlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgqtrAkec6TBeZnlZ6dEQvqpl0DKAL2VPf7ZYFq5Uie5/f+Aiuhtz/oSvTzN5LilonEQzS236Iz+9nggJms/E7FZuZFbdasqTF/arWJ23bYR0y1UJZs+2RoErZ9JI2ix4UmwxGNB7VcyvGogmIReG7yMb+JTOTOJaofIOMwqN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsWjUK/A; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034902; x=1759570902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=naAuDqb0vFu4Dw0Ubf8SaUqzSDSbfkpbpELOVNHDQlk=;
  b=jsWjUK/AOs8bX16Q2RcYtVZnOrB0KFXZK81P9vRIAkJADTYf//PA7b2W
   7X7HVIX7qyIYEVMhicfnPiiE0LmZc9wo+9i+2SOUtc3JoN7aZSwn4wIPj
   Tv9m+wTZSVoIzXLhxvv8LtNxV7GUPwtJJC0d6C2gqXLsyEhZwK2CT2YhO
   BBb2+YQrNGt15A4e1jibyHHZOXW/E1EkdA/hvhqgQtwg4umbebXgckACn
   lZm1B/+Xh0LAlKjo3gKjAUkyDJOVtHzRQx2k4pD+yjWjt5TQJtsclsgxr
   p9W4MsY7hsEYPFBSzZcWNAyV0Y7P/1Ui3KeVOI02svRD3Bskle4fq01hk
   A==;
X-CSE-ConnectionGUID: UJSA2NwJTvCBeaDJ4LVZEA==
X-CSE-MsgGUID: DMng9nL/SQeYQiJKX2+8XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656272"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656272"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:40 -0700
X-CSE-ConnectionGUID: SasjtWRPQoG+diFBrb1+jA==
X-CSE-MsgGUID: Ai9dtViLSsK/llsIGvIENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975102"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:39 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 602E6120E8F;
	Fri,  4 Oct 2024 12:41:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoY-000Te4-1E;
	Fri, 04 Oct 2024 12:41:34 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Andrew Davis <afd@ti.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 35/51] power: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:34 +0300
Message-Id: <20241004094134.113947-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/power/supply/bq24190_charger.c | 28 +++++++++++++-------------
 drivers/power/supply/twl4030_charger.c |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 2b393eb5c282..526387a5faeb 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -502,7 +502,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 		count = sysfs_emit(buf, "%hhx\n", v);
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
 }
@@ -533,7 +533,7 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 		count = ret;
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
 }
@@ -560,7 +560,7 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 		ret = bq24190_charger_set_charge_type(bdi, &val);
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
 }
@@ -597,7 +597,7 @@ static int bq24296_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 
 out:
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
 }
@@ -630,7 +630,7 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 				BQ24190_REG_POC_CHG_CONFIG_SHIFT, &val);
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	if (ret)
 		return ret;
@@ -667,7 +667,7 @@ static int bq24296_vbus_is_enabled(struct regulator_dev *dev)
 				BQ24296_REG_POC_OTG_CONFIG_SHIFT, &val);
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	if (ret)
 		return ret;
@@ -1367,7 +1367,7 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
 }
@@ -1409,7 +1409,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
 }
@@ -1667,7 +1667,7 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
 }
@@ -1698,7 +1698,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
 }
@@ -1846,7 +1846,7 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	}
 	bq24190_check_status(bdi);
 	pm_runtime_mark_last_busy(bdi->dev);
-	pm_runtime_put_autosuspend(bdi->dev);
+	__pm_runtime_put_autosuspend(bdi->dev);
 	bdi->irq_event = false;
 
 	return IRQ_HANDLED;
@@ -2148,7 +2148,7 @@ static int bq24190_probe(struct i2c_client *client)
 	enable_irq_wake(client->irq);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
@@ -2235,7 +2235,7 @@ static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 
 	if (error >= 0) {
 		pm_runtime_mark_last_busy(bdi->dev);
-		pm_runtime_put_autosuspend(bdi->dev);
+		__pm_runtime_put_autosuspend(bdi->dev);
 	}
 
 	return 0;
@@ -2260,7 +2260,7 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 
 	if (error >= 0) {
 		pm_runtime_mark_last_busy(bdi->dev);
-		pm_runtime_put_autosuspend(bdi->dev);
+		__pm_runtime_put_autosuspend(bdi->dev);
 	}
 
 	/* Things may have changed while suspended so alert upper layer */
diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index f3f1a0862e93..1060a3b0d285 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -513,7 +513,7 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 					TWL4030_BCIMDKEY);
 		if (bci->usb_enabled) {
 			pm_runtime_mark_last_busy(bci->transceiver->dev);
-			pm_runtime_put_autosuspend(bci->transceiver->dev);
+			__pm_runtime_put_autosuspend(bci->transceiver->dev);
 			bci->usb_enabled = 0;
 		}
 		bci->usb_cur = 0;
-- 
2.39.5


