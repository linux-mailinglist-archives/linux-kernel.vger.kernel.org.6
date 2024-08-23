Return-Path: <linux-kernel+bounces-299714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF395D915
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90582B21ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D298194C8F;
	Fri, 23 Aug 2024 22:07:24 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36F1C8710
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450843; cv=none; b=VRl1079uKhE5PsjcXzhw3aQSQ77xKPGpLonMcE0QqgV27bLRIcsDuxbrpWZ9LospMmMG/xXhmQm/QqXd2VBJxNZnikNJTcFkSOFWs+YGx9DIveSQZHrmmNOlj2DuRSH8dByyfNKDt8l8jxpXzqmZ2Pb9C9d2yU59a6QDzUwzxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450843; c=relaxed/simple;
	bh=3hw+CZqza9xuGv8IMOyhBwEUy4qPvlzZcseXAnIfo9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBKmF5WR3sRhpL4q1u40kpOg0kOu+vp7uBjVtlvqDOSfqE41fu5jNBdoyNSpGRJqrw0iKnja4LvU21rZwGFtKNh7e1B+BT0JwUD6UFNXLv0WchfJJ+/5W0jKxW51Olpr8cqey7P1vPGYCr4PYv5jq9kXStEWq/G1ywtSClBmORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 10c4aa32-619c-11ef-8232-005056bdfda7;
	Sat, 24 Aug 2024 01:07:19 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] iio: proximity: cros_ec_mkbp_proximity: Switch to including mod_devicetable.h for struct of_device_id definition
Date: Sat, 24 Aug 2024 01:07:18 +0300
Message-ID: <20240823220718.743596-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of.h was only included for this definition, so include the correct header
instead.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 4df506bb8b38..cff57d851762 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -6,10 +6,10 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-- 
2.46.0


