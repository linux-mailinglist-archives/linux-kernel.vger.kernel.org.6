Return-Path: <linux-kernel+bounces-201810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D18FC3BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D530DB27A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBA190493;
	Wed,  5 Jun 2024 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="IwTP1eaY"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5119046C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569253; cv=none; b=KIFRZhXdJKrPJ/wVfL71GybkqzBeDo9U5g98YPH3Ebv5KXJHqCO8JXwhuEdRWUAJOhJAJUz9teCTDcNjho6dWPvXOqzpFE8Qr7V0nJlH5vDE+RTYpKHZM+u5mP9gtMIliAqyhmaTfy3FoKsuva7HRYsEB+shHZazEk0W7kSmZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569253; c=relaxed/simple;
	bh=BFYXFSaJf+5I7Oshefz5hefmDkIxJaEdUbAYQkpD9fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv3Fkvq4c01izEr8szoZ6P0nI4lr5b9pRkP3tsgqsWI3bxisLRPkZkeNbt5TcKOTrWd3EDiUbXb4bumM2Hd9X3PdyEuK3nZJh/1zM6eEC38doNS72MsnEWN4cLpHIEdsag4BZ4UlE/S+V2nhAPhIyJTUvN/pYYuo/xFCrciIdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=IwTP1eaY; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VvHjq2cSSz9stT;
	Wed,  5 Jun 2024 08:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717569247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpyzWk+z7BoUogPMEwclr/gL3oFn+Jdg/0hnUJBFVPI=;
	b=IwTP1eaYDdnnm+Thhsaaf8SPPJwc53yvHXScxlXVFmOI+Apk5GOaXv5CobZrVB/L6DnfkB
	Zx1x2GvqxwigHL1QpVPuubkK5idgSdGb5gjYmOQt9xYuyOcMRYLYAWG31wzJoqe8XAD/o3
	ijzwSISm7/My9GG1z5hACI3CM2IONT8wG2n2baoHgocsLxO7F9NsJQjZZNlIXmAVv9SXG8
	hf7rG6L16KbAY0CKGvz9bDtyRB0n+oiuVU0+oWmzr2g3HpKLyytFnuonroBWR9h0Ht0BOa
	0NfrnWU1lVl98I7B1czzh1aYJr+5OWytOFiYxukxi2LqzvAVy4Uj43wjtp1xbA==
From: Ben Walsh <ben@jubnut.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ben Walsh <ben@jubnut.com>
Subject: [PATCH v3 2/5] platform/chrome: cros_ec_lpc: MEC access can use an AML mutex
Date: Wed,  5 Jun 2024 07:33:48 +0100
Message-ID: <20240605063351.14836-3-ben@jubnut.com>
In-Reply-To: <20240605063351.14836-1-ben@jubnut.com>
References: <20240605063351.14836-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VvHjq2cSSz9stT

Framework Laptops have ACPI code which accesses the MEC memory. It
uses an AML mutex to prevent concurrent access. But the cros_ec_lpc
driver was not aware of this mutex. The ACPI code and LPC driver both
attempted to talk to the EC at the same time, messing up communication
with the EC.

Allow the LPC driver MEC code to find and use the AML mutex.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc_mec.c | 76 ++++++++++++++++++++++-
 drivers/platform/chrome/cros_ec_lpc_mec.h | 11 ++++
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index 395dc3a6fb5e..93ebfeb44dc6 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -10,13 +10,65 @@
 
 #include "cros_ec_lpc_mec.h"
 
+#define ACPI_LOCK_DELAY_MS 500
+
 /*
  * This mutex must be held while accessing the EMI unit. We can't rely on the
  * EC mutex because memmap data may be accessed without it being held.
  */
 static DEFINE_MUTEX(io_mutex);
+/*
+ * An alternative mutex to be used when the ACPI AML code may also
+ * access memmap data.  When set, this mutex is used in preference to
+ * io_mutex.
+ */
+static acpi_handle aml_mutex;
+
 static u16 mec_emi_base, mec_emi_end;
 
+/**
+ * cros_ec_lpc_mec_lock() - Acquire mutex for EMI
+ *
+ * @return: Negative error code, or zero for success
+ */
+static int cros_ec_lpc_mec_lock(void)
+{
+	bool success;
+
+	if (!aml_mutex) {
+		mutex_lock(&io_mutex);
+		return 0;
+	}
+
+	success = ACPI_SUCCESS(acpi_acquire_mutex(aml_mutex,
+						  NULL, ACPI_LOCK_DELAY_MS));
+	if (!success)
+		return -EBUSY;
+
+	return 0;
+}
+
+/**
+ * cros_ec_lpc_mec_unlock() - Release mutex for EMI
+ *
+ * @return: Negative error code, or zero for success
+ */
+static int cros_ec_lpc_mec_unlock(void)
+{
+	bool success;
+
+	if (!aml_mutex) {
+		mutex_unlock(&io_mutex);
+		return 0;
+	}
+
+	success = ACPI_SUCCESS(acpi_release_mutex(aml_mutex, NULL));
+	if (!success)
+		return -EBUSY;
+
+	return 0;
+}
+
 /**
  * cros_ec_lpc_mec_emi_write_address() - Initialize EMI at a given address.
  *
@@ -78,6 +130,7 @@ int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 	int io_addr;
 	u8 sum = 0;
 	enum cros_ec_lpc_mec_emi_access_mode access, new_access;
+	int ret;
 
 	/* Return checksum of 0 if window is not initialized */
 	WARN_ON(mec_emi_base == 0 || mec_emi_end == 0);
@@ -93,7 +146,9 @@ int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 	else
 		access = ACCESS_TYPE_LONG_AUTO_INCREMENT;
 
-	mutex_lock(&io_mutex);
+	ret = cros_ec_lpc_mec_lock();
+	if (ret)
+		return ret;
 
 	/* Initialize I/O at desired address */
 	cros_ec_lpc_mec_emi_write_address(offset, access);
@@ -135,7 +190,9 @@ int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 	}
 
 done:
-	mutex_unlock(&io_mutex);
+	ret = cros_ec_lpc_mec_unlock();
+	if (ret < 0)
+		return ret;
 
 	return sum;
 }
@@ -147,3 +204,18 @@ void cros_ec_lpc_mec_init(unsigned int base, unsigned int end)
 	mec_emi_end = end;
 }
 EXPORT_SYMBOL(cros_ec_lpc_mec_init);
+
+int cros_ec_lpc_mec_acpi_mutex(struct acpi_device *adev, const char *pathname)
+{
+	int status;
+
+	if (!adev)
+		return -ENOENT;
+
+	status = acpi_get_handle(adev->handle, pathname, &aml_mutex);
+	if (ACPI_FAILURE(status))
+		return -ENOENT;
+
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_lpc_mec_acpi_mutex);
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
index 69670832f187..69f9d8786f61 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.h
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
@@ -8,6 +8,8 @@
 #ifndef __CROS_EC_LPC_MEC_H
 #define __CROS_EC_LPC_MEC_H
 
+#include <linux/acpi.h>
+
 enum cros_ec_lpc_mec_emi_access_mode {
 	/* 8-bit access */
 	ACCESS_TYPE_BYTE = 0x0,
@@ -45,6 +47,15 @@ enum cros_ec_lpc_mec_io_type {
  */
 void cros_ec_lpc_mec_init(unsigned int base, unsigned int end);
 
+/**
+ * cros_ec_lpc_mec_acpi_mutex() - Find and set ACPI mutex for MEC
+ *
+ * @adev:     Parent ACPI device
+ * @pathname: Name of AML mutex
+ * @return:   Negative error code, or zero for success
+ */
+int cros_ec_lpc_mec_acpi_mutex(struct acpi_device *adev, const char *pathname);
+
 /**
  * cros_ec_lpc_mec_in_range() - Determine if addresses are in MEC EMI range.
  *
-- 
2.45.1


