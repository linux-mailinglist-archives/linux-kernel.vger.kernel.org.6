Return-Path: <linux-kernel+bounces-407069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4D9C682B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72660B26D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022A116FF26;
	Wed, 13 Nov 2024 04:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kflLzSQG"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D221714A8;
	Wed, 13 Nov 2024 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472767; cv=none; b=bLo2fh5GcFvQaTYkkrJZFZCtlQ0z+MHk2H/fjp5ewiK4Kd5QecB++8NSp7d+sVtBTjL7u5SCzZnjRqfjmCriUk6qvJNUCKG1bNrUJwv4PnQlZdMEYsWbySmhtGjRpIufilARFRtt5oAdhnvvHsZDzyrX1OUeuv9Aj4bORxcUaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472767; c=relaxed/simple;
	bh=VXlyg1iYL20U+q7NRI+j44FKT/JI+59MkXqT/xSpk+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qy7/0RcYsbIcu90Ee3j9Bjfp37z8AkF2V1Cy9QfU4jVnFc8eay0TET3QLLMtoEGlF27u04KYwu9NYZ/dJl6gmwbXDPNkfU/ywUGPJJMbgxOLp2bYovb1DSF/7ufmuHq1x7GaXY7N8NcCm41b4IhByyB+YL17j8dHzepSUfdm5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kflLzSQG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731472757;
	bh=VXlyg1iYL20U+q7NRI+j44FKT/JI+59MkXqT/xSpk+k=;
	h=From:Date:Subject:To:Cc:From;
	b=kflLzSQGNyMec9neRrM4yOqM01ruKG8ueDxr4hLywPKDkp0yS3GUOA/B+EsMbqGZb
	 a6xucRiwOa8n/Omvl4rfd+eoHOWVD7tVbQtDWoRdDsqgu4YSRHF9OgZ/iZYn4IO7fS
	 ZbPTGkUiZTFktSRkYK+oL6AbfblO06d3ScCQL698=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 13 Nov 2024 05:39:16 +0100
Subject: [PATCH] hwmon: (core) Avoid ifdef in C source file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHMtNGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Nj3Yzy3Pw83ZKM1KLcxBxdoxSjlERTC8NkI3MzJaCegqLUtMwKsHn
 RsbW1APYe+WJfAAAA
X-Change-ID: 20241113-hwmon-thermal-2d2da581c276
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731472756; l=2493;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=VXlyg1iYL20U+q7NRI+j44FKT/JI+59MkXqT/xSpk+k=;
 b=iHIF9EfKy8TcHgkHF6w9lPq+xRCi44NVauAzryZceoGYgMCQLEllQQ6ufZsHrQGLbpTnHK1us
 4xCSr25Mf1cDyZO+2mSQStx9YscSvt5uRaop7Tl7vCfyzlARWtpCVly
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Using an #ifdef in a C source files to have different definitions
of the same symbol makes the code harder to read and understand.
Furthermore it makes it harder to test compilation of the different
branches.

Replace the ifdeffery with IS_ENABLED() which is just a normal
conditional.
The resulting binary is still the same as before as the compiler
optimizes away all the unused code and definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This confused me a bit while looking at the implementation of
HWMON_C_REGISTER_TZ.
---
 drivers/hwmon/hwmon.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 9c35c4d0369d7aad7ea61ccd25f4f63fc98b9e02..86fb674c85d3f54d475be014c3fd3dd74c815c57 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -147,11 +147,6 @@ static DEFINE_IDA(hwmon_ida);
 
 /* Thermal zone handling */
 
-/*
- * The complex conditional is necessary to avoid a cyclic dependency
- * between hwmon and thermal_sys modules.
- */
-#ifdef CONFIG_THERMAL_OF
 static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
@@ -257,6 +252,9 @@ static int hwmon_thermal_register_sensors(struct device *dev)
 	void *drvdata = dev_get_drvdata(dev);
 	int i;
 
+	if (!IS_ENABLED(CONFIG_THERMAL_OF))
+		return 0;
+
 	for (i = 1; info[i]; i++) {
 		int j;
 
@@ -285,6 +283,9 @@ static void hwmon_thermal_notify(struct device *dev, int index)
 	struct hwmon_device *hwdev = to_hwmon_device(dev);
 	struct hwmon_thermal_data *tzdata;
 
+	if (!IS_ENABLED(CONFIG_THERMAL_OF))
+		return;
+
 	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
 		if (tzdata->index == index) {
 			thermal_zone_device_update(tzdata->tzd,
@@ -293,16 +294,6 @@ static void hwmon_thermal_notify(struct device *dev, int index)
 	}
 }
 
-#else
-static int hwmon_thermal_register_sensors(struct device *dev)
-{
-	return 0;
-}
-
-static void hwmon_thermal_notify(struct device *dev, int index) { }
-
-#endif /* IS_REACHABLE(CONFIG_THERMAL) && ... */
-
 static int hwmon_attr_base(enum hwmon_sensor_types type)
 {
 	if (type == hwmon_in || type == hwmon_intrusion)

---
base-commit: 3022e9d00ebec31ed435ae0844e3f235dba998a9
change-id: 20241113-hwmon-thermal-2d2da581c276

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


