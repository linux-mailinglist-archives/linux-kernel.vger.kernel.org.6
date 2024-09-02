Return-Path: <linux-kernel+bounces-311935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FBE968FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1981F2456F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9F189F20;
	Mon,  2 Sep 2024 22:29:13 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683321885B5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316152; cv=none; b=T/snMnp0+LuNV2VMLYCUMOJW1CYs1mIpHSRP2spHSMeIGktKTqyj66X4xhemLuo5ot37ILSmc90D0uzKsASN0czb81z5gkLTbRDXTiFbdywqnq6w3xr0O94GbsZX4l3gFKhCvwTUPAfY1wiKXB3L/xtqy9ZOwgLRxLgyZWSA8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316152; c=relaxed/simple;
	bh=nHbfgrvQy0z0lM6FjGAHDJWcQ2iS9trkZXW+dADx3oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l67nVl3cZaEhfJg9ntKp4juqp/5+M4pkneF3FXTiMNJuIOtr/jk+NzEIReEH/wnatzB5xxwxv7U2ER/sfDRVCHGzc2wF59K66oEQx+1OL913F3+VnkF+Z6D7/W27dcuQPNA5JFbXPIkD99DjjLXLcMhQwSFR0spm4e7VKsMvaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id ae7e2ff2-697a-11ef-8e8a-005056bd6ce9;
	Tue, 03 Sep 2024 01:28:30 +0300 (EEST)
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
Subject: [PATCH v1 03/22] iio: adc: ad7791: Get platform data via dev_get_platdata()
Date: Tue,  3 Sep 2024 01:16:48 +0300
Message-ID: <20240902222824.1145571-4-andy.shevchenko@gmail.com>
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
 drivers/iio/adc/ad7791.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 86effe8501b4..5d2ad3dd6caa 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -371,7 +371,7 @@ static const struct iio_info ad7791_no_filter_info = {
 };
 
 static int ad7791_setup(struct ad7791_state *st,
-			struct ad7791_platform_data *pdata)
+			const struct ad7791_platform_data *pdata)
 {
 	/* Set to poweron-reset default values */
 	st->mode = AD7791_MODE_BUFFER;
@@ -401,7 +401,7 @@ static void ad7791_reg_disable(void *reg)
 
 static int ad7791_probe(struct spi_device *spi)
 {
-	struct ad7791_platform_data *pdata = spi->dev.platform_data;
+	const struct ad7791_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad7791_state *st;
 	int ret;
-- 
2.46.0


