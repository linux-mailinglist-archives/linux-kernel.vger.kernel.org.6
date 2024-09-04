Return-Path: <linux-kernel+bounces-315763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2323396C6A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDEAB20A75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911FA1E0B8A;
	Wed,  4 Sep 2024 18:45:49 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0F41C6D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475549; cv=none; b=Jv2hs4n5dlBCIGCWfre4dtOpryLgCT+NKQIZk+zFzfFzgkALlDAgD3vBAW13OK9OsvirfZYZcuiId/d2QfMOP66ThASPBsO/HiRkG2ky2QbDpUoUO2E2XKYPnSJwOxe7Xv37VoegDq57ylckFuDqjcbnVr8HGWfHeijYZzvPSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475549; c=relaxed/simple;
	bh=ju5c2JcKzafSYkNLjzrCOJ9FC4i2ixivDaI3ty1dn68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7M0cZpSq2FwUZH1jzZI6OjOHAGpkCUUN4YQaffOILCWf7K88OgW9R6xcT0jdXE1uUgpYIgaZT1gfMBJ7bxP9FJcziyJBsdNvi6jj8mHzAJrsw/tKdXGptHusc6JwPdL1sUF955KnG1xXBIq2qjZzhI6S+YwTLR3TPWz/NxcJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id e42f4ce3-6aed-11ef-abaf-005056bdd08f;
	Wed, 04 Sep 2024 21:45:44 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: imu: inv_mpu6050: Use upper_16_bits()/lower_16_bits() helpers
Date: Wed,  4 Sep 2024 21:45:43 +0300
Message-ID: <20240904184543.1219866-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use upper_16_bits()/lower_16_bits() helpers instead of open-coding them.
This is easier to scan quickly compared to bitwise manipulation, and
it is pleasingly symmetric.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index f7bce428d9eb..b15d8c94cc11 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -10,6 +10,8 @@
 #include <linux/i2c.h>
 #include <linux/dmi.h>
 #include <linux/acpi.h>
+#include <linux/wordpart.h>
+
 #include "inv_mpu_iio.h"
 
 enum inv_mpu_product_name {
@@ -118,8 +120,8 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
 		return ret;
 
 	acpi_dev_free_resource_list(&resources);
-	*primary_addr = i2c_addr & 0x0000ffff;
-	*secondary_addr = (i2c_addr & 0xffff0000) >> 16;
+	*primary_addr = lower_16_bits(i2c_addr);
+	*secondary_addr = upper_16_bits(i2c_addr);
 
 	return 0;
 }
-- 
2.46.0


