Return-Path: <linux-kernel+bounces-299738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CF95D973
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9399E1F23BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035251C945D;
	Fri, 23 Aug 2024 23:01:15 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7B1C944D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454074; cv=none; b=ioyDDmNraWyNHdQGnOvVSmi+iYPl0JOosZBCIxmx9fLOT+MSGc3Kzhhp4JYJLy3La1ehzvuab3tWF66VzGGZ2CjJ69eweHDsDp5xXGQxJQTpkvew5wDNhovNqUA8tbu65lnWtWDeGLphWnqXb064tkBoWuPkqmTPVNKqdrNagmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454074; c=relaxed/simple;
	bh=yJaFCLUseZJ+UMqQU3DIqu/jfdw1TQ24lhPHFYbZllc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwWGM/FBzxjJ3E9KDKa7uTABCxDFSPIz7r+cL17ie9CYxaRliBmHj280nlVyne2PaGAlREt+QuEbzCY5Zh36yNMdad+7RbEG1uAAFF1V18eEWrusB5heBRWEttATvmJ4lFt1FDb6OOwJXC5Zp1KCDWAy2CXzof9fGQMzN0zfb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 9661658c-61a3-11ef-8e42-005056bd6ce9;
	Sat, 24 Aug 2024 02:01:10 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: accel: bmc150: Improve bmc150_apply_bosc0200_acpi_orientation()
Date: Sat, 24 Aug 2024 02:01:07 +0300
Message-ID: <20240823230107.745900-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By using ACPI_HANDLE() the handler argument can be retrieved directly.
Replace ACPI_COMPANION() + dereference with ACPI_HANDLE().

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 14ce03c70ab5..0f32c1e92b4d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -387,7 +387,7 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 						   struct iio_mount_matrix *orientation)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_handle handle = ACPI_HANDLE(dev);
 	char *name, *alt_name, *label;
 
 	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0) {
@@ -398,9 +398,9 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 		label = "accel-display";
 	}
 
-	if (acpi_has_method(adev->handle, "ROTM")) {
+	if (acpi_has_method(handle, "ROTM")) {
 		name = "ROTM";
-	} else if (acpi_has_method(adev->handle, alt_name)) {
+	} else if (acpi_has_method(handle, alt_name)) {
 		name = alt_name;
 		indio_dev->label = label;
 	} else {
-- 
2.46.0


