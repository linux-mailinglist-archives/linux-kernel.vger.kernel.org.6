Return-Path: <linux-kernel+bounces-311930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE0968F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98D7B22E1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA8188598;
	Mon,  2 Sep 2024 22:29:06 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDC188599
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316146; cv=none; b=dcvTykP5AF53YkHv8kBWTj1hhqD2bfriNl+z8/JWj1vs7bygT4v7Z9VPYMS/S/r30Zl1sxqbjuc4jvR5++2IGvT+TqEAb7zCny34Nrz1cRUVJQK3IRld2RTPp5ixBAJZJyJ9F9awkloyBcA8qKYh3bOYVRzDHNCcldNzCOyzvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316146; c=relaxed/simple;
	bh=rz4cPLPk4U/N9gxi84pXdf1L9hx4wLHD3D5UxEPPbnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIndE731LBVhU1rkVAc+zA6Md9VhJg1f38Od39huOg0WWs5nRm7WLfiBKytF/djTos8AfUJKjT1o54Y9X3ZQriwztGWU3B7a4OszqM0FPmMmFzzzbDy6n2qWacCilMf1vvUCg6B/g4zc09nWSthnTyvg8JQ6bBdpMTV6zQNhqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id b3ad4428-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:39 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 14/22] iio: imu: st_lsm6dsx: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:59 +0300
Message-ID: <20240902222824.1145571-15-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index ed0267929725..3958b5e1a3f6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2132,14 +2132,11 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 			const struct st_lsm6dsx_reg **drdy_reg)
 {
 	struct device *dev = hw->dev;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	int err = 0, drdy_pin;
 
-	if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) < 0) {
-		struct st_sensors_platform_data *pdata;
-
-		pdata = (struct st_sensors_platform_data *)dev->platform_data;
+	if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) < 0)
 		drdy_pin = pdata ? pdata->drdy_int_pin : 1;
-	}
 
 	switch (drdy_pin) {
 	case 1:
@@ -2162,14 +2159,13 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
-	struct st_sensors_platform_data *pdata;
 	struct device *dev = hw->dev;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	unsigned int data;
 	int err = 0;
 
 	hub_settings = &hw->settings->shub_settings;
 
-	pdata = (struct st_sensors_platform_data *)dev->platform_data;
 	if (device_property_read_bool(dev, "st,pullups") ||
 	    (pdata && pdata->pullups)) {
 		if (hub_settings->pullup_en.sec_page) {
@@ -2524,9 +2520,9 @@ static irqreturn_t st_lsm6dsx_sw_trigger_handler_thread(int irq,
 
 static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 {
-	struct st_sensors_platform_data *pdata;
 	const struct st_lsm6dsx_reg *reg;
 	struct device *dev = hw->dev;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	unsigned long irq_type;
 	bool irq_active_low;
 	int err;
@@ -2554,7 +2550,6 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 	if (err < 0)
 		return err;
 
-	pdata = (struct st_sensors_platform_data *)dev->platform_data;
 	if (device_property_read_bool(dev, "drive-open-drain") ||
 	    (pdata && pdata->open_drain)) {
 		reg = &hw->settings->irq_config.od;
@@ -2639,7 +2634,7 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
-	struct st_sensors_platform_data *pdata = dev->platform_data;
+	const struct st_sensors_platform_data *pdata = dev_get_platdata(dev);
 	const struct st_lsm6dsx_shub_settings *hub_settings;
 	struct st_lsm6dsx_hw *hw;
 	const char *name = NULL;
-- 
2.46.0


