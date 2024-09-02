Return-Path: <linux-kernel+bounces-311932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13311968F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3BE284C66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723D91891D4;
	Mon,  2 Sep 2024 22:29:09 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450B188A2E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316149; cv=none; b=LpWct7jquJEdLZQrcqO6jd++8j0XARKSYaug6jOLPK5jSnhKPxH/PA+Sf4+SDwGvLHX8iqEx/8lVfi+NJeG0OX7ZxP08Kby7T4wDI7109AG35JF4Blw0qwEnOCtbhDK1HmXnODR+PFU24eO/BRRtVZENpO/3KBIygMiWeQoPrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316149; c=relaxed/simple;
	bh=Uy3gw0baEyg93YMzdsYyOhpSjIuIj+PESe4MBDgyQns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjIFcwzmKA6Py9UBoDV9mxMTg3rvt147k/1XjGvXiC7bWRcSy2T96RPdhmCVd9P4PDST3uMZqoxUPvfxWoQuwqVw83UfrilqfT3ezPTr516RLUXa2RsRFVzzVYRPUWh99EIY8Ec77PSsHMMYlzugtFHPHPkc3xM8VpKqf8R8oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id b4efba77-697a-11ef-8256-005056bdfda7;
	Tue, 03 Sep 2024 01:28:41 +0300 (EEST)
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
Subject: [PATCH v1 17/22] iio: light: lm3533-als: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:17:02 +0300
Message-ID: <20240902222824.1145571-18-andy.shevchenko@gmail.com>
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
 drivers/iio/light/lm3533-als.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 7800f7fa51b7..6429d951ce7f 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -754,7 +754,7 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 }
 
 static int lm3533_als_setup(struct lm3533_als *als,
-			    struct lm3533_als_platform_data *pdata)
+			    const struct lm3533_als_platform_data *pdata)
 {
 	int ret;
 
@@ -828,8 +828,8 @@ static const struct iio_info lm3533_als_info = {
 
 static int lm3533_als_probe(struct platform_device *pdev)
 {
+	const struct lm3533_als_platform_data *pdata;
 	struct lm3533 *lm3533;
-	struct lm3533_als_platform_data *pdata;
 	struct lm3533_als *als;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -838,7 +838,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	if (!lm3533)
 		return -EINVAL;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data\n");
 		return -EINVAL;
-- 
2.46.0


