Return-Path: <linux-kernel+bounces-311937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40B1968FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A817285C70
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31A18BBBB;
	Mon,  2 Sep 2024 22:29:23 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632A18BBBC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316163; cv=none; b=CPyfkpFcM8gnyImXCHbYM+ZAs4P3cB02CJC6Rc6B91l4EZ+Y02nnTL97xRvYFDdTni0tWUlELWUBxvFINnPK8B9sIUhkqriqFCgN9AAAnWg6m8y6vn59+4ymUop9o3+8gvSC0XFbldMI8iC/3ttYjmRr7w5lBJRypMFxFmsTWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316163; c=relaxed/simple;
	bh=JbN8T71a/PZKhOL1QNhERt7e8cyfCWMB8Ep8u0D95s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh1YVx0RY2qWd9jxEr+hOAFqePdZ7vmCDovFLEh6cBgdPxcQ/PBvibwMyRU1WhWFb8LRIK9PRthlY3UpcgqRZPfiUMbQuTcWURlQf5gJMFaV8MpxpLHed6oqUtUu3Bh8i3Y5msjUEDVoxPPPrLPgqUdrosEovggobpHiWQihMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id aff40cbd-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:33 +0300 (EEST)
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
Subject: [PATCH v1 06/22] iio: adc: ltc2497: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:51 +0300
Message-ID: <20240902222824.1145571-7-andy.shevchenko@gmail.com>
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

While at it, drop duplicate NULL check that iio_map_array_register()
already has.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/ltc2497-core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 996f6cbbed3c..ad8ddf80310e 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -168,6 +168,7 @@ static const struct iio_info ltc2497core_info = {
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
+	struct iio_map *plat_data = dev_get_platdata(dev);
 	int ret;
 
 	/*
@@ -200,16 +201,10 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	if (dev->platform_data) {
-		struct iio_map *plat_data;
-
-		plat_data = (struct iio_map *)dev->platform_data;
-
-		ret = iio_map_array_register(indio_dev, plat_data);
-		if (ret) {
-			dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
-			goto err_regulator_disable;
-		}
+	ret = iio_map_array_register(indio_dev, plat_data);
+	if (ret) {
+		dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
+		goto err_regulator_disable;
 	}
 
 	ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
-- 
2.46.0


