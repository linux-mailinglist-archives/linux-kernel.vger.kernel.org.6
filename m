Return-Path: <linux-kernel+bounces-311947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D7968FC6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E472871EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485961885A1;
	Mon,  2 Sep 2024 22:30:13 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1413BC2F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316212; cv=none; b=sHTDTeGz5Q8x47h7ppmeEASoL/Iv9f80pjq4Xa5BHfwRDYLupAOEPYtdZfuj5b4m8dRVgA4zYcbb84ZUnLlkDSmYgkLOQFEgpxfvObctHw1QFgSVf9KhDFC533t6yhbhVxTecPwxmPN+46pQI0aZoDDp2bDrbMKn21waiS57zio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316212; c=relaxed/simple;
	bh=Axn5OvqB+CcBxhl3sti9L7ZitYsHqJrWtIcCua+j95g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg9pIIg8uROY+pUen2VJgUTG/UOHqcRJFpV3lSwFXtY4Xazu2ojxDppJAQqEL3YlbjrRij0z+cvvZeQ3F8w2K3g/0DNcZdXoRqQxlAAL16AfKHsVItbsYNq3Z4hl/7g0gTfLBA4G2c/vtiddkpMv2iyA+VF8RVVgV4tYQB120cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id b7e48c59-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:46 +0300 (EEST)
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
Subject: [PATCH v1 22/22] iio: pressure: hid-sensor-press: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:17:07 +0300
Message-ID: <20240902222824.1145571-23-andy.shevchenko@gmail.com>
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
 drivers/iio/pressure/hid-sensor-press.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 956045e2db29..b7e9a085f0cc 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -241,11 +241,11 @@ static int press_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_press_probe(struct platform_device *pdev)
 {
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	int ret = 0;
 	static const char *name = "press";
 	struct iio_dev *indio_dev;
 	struct press_state *press_state;
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 				sizeof(struct press_state));
@@ -325,7 +325,7 @@ static int hid_press_probe(struct platform_device *pdev)
 /* Function to deinitialize the processing for usage id */
 static void hid_press_remove(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct press_state *press_state = iio_priv(indio_dev);
 
-- 
2.46.0


