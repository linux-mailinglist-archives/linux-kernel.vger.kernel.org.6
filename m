Return-Path: <linux-kernel+bounces-311938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75551968FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CE0285FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A918BC1D;
	Mon,  2 Sep 2024 22:29:28 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB6187FF7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316168; cv=none; b=cgkh2CnPYKm2QVP2Bk4nfklZxkzchPiP0uEuXeTiCxEsjQZDWahnC1YRQCQremk5jbcN5LCYDhkeimLBd4EoZQ6Sm4lyOAWB/rnMMOf1yasVm4vPj2FoXxIyoCbdFc0Ngw3yl5+eQDUSNDvlkWAWGZjNzVyhXHYy87aaQqv1Zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316168; c=relaxed/simple;
	bh=3dUeMEczuVrufl8SGQjkyOoqnQqLp4XWk+aY6v1VujM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5QIxw5FIn6R94xncra5qHGdAjnG8PkbdY/fNcPqdspzKQ/PQNT+uS1UwKvAScWzzFfWAu6o4D08CarPgqrIahozoMnvYRpemWng/qFMG92FI4SBzX57nMqUihvzpq1DfYUKFCF/4wzaRnD4YlzFYanUtV7S+a15etePOCn6G+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b330a4cc-697a-11ef-abae-005056bdd08f;
	Tue, 03 Sep 2024 01:28:38 +0300 (EEST)
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
Subject: [PATCH v1 13/22] iio: gyro: hid-sensor-gyro-3d: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:58 +0300
Message-ID: <20240902222824.1145571-14-andy.shevchenko@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 59a38bf9459b..490c325897bd 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -279,11 +279,11 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_gyro_3d_probe(struct platform_device *pdev)
 {
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	int ret = 0;
 	static const char *name = "gyro_3d";
 	struct iio_dev *indio_dev;
 	struct gyro_3d_state *gyro_state;
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
 	if (!indio_dev)
@@ -361,7 +361,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 /* Function to deinitialize the processing for usage id */
 static void hid_gyro_3d_remove(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
-- 
2.46.0


