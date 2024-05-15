Return-Path: <linux-kernel+bounces-179479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5588C6056
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2A81F21B69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCFF3C062;
	Wed, 15 May 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="ZSYzLBED"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F83A8E4
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752608; cv=none; b=kLQa6JLarT/KIFRaxs8Q4gPFiPDyNe1Pvjb+Xk7D9MSqt9nvSSluxpwClAb4vc7GYuhID1i/BaAj3A1ycVKjge0zVJZUXwKPvGK48Stt5aqmkO9NMvhV2iLtKj0snswNulZ+JVY9KYuqvqCLSPeOd0ErYM1NIbR7m7yr+S0xuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752608; c=relaxed/simple;
	bh=D7CpYDExM494dbCKSkQctXHhZUJA2TBjnIBvLsZaFFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDmPlz9WaO6cYbv5pAV6+M1YSOtD5ozaG9us0AG6NuA99d+gomua8csW3PjcFHYhn8sGBBinlQJqs5QuVLSBBjeKS9Ocv6ZtJqyTvIQsZoNyK10UwmWA5ml6PLbEugYYDh3YpwQZJ6NftE+V2Bz92Lw3MJyl8/W3fC1oEcbnZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=ZSYzLBED; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VfMtM2fZPz9t7y;
	Wed, 15 May 2024 07:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1715752603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kr18AnmiILeV8cuOnL1ySQXzyB4WeUh9qD8Jd+mlR40=;
	b=ZSYzLBEDKKv4aI8fdfwgjyQdziES6arauQi18wrD4/No9n6nGNwyP4HxvQru+Zk4NYY7VN
	kfAaM00KjWzBWabLyU4Hibyf/MwRLkQcKhsiHELgfkWOZvDyVZADpV8XP0Ps834AnWmuD/
	iGbFbzbRWfKqFVHOAznwpkA54Q0RcJf2MLzxHr0pmwoGl51vNL/PGiWBRbel9gLRrVtTr0
	CMAgFDBbkJJL0tpMQNrojjNi+wdOeOVcR1aiKpZu2dgCLgh464P36s8NvvcybFVDzxivmT
	WhytwyxLXHllXiDm0Oq6UNHg8FBTnc34Twir1viHbfNx477RXUlEt9UAEv+YBA==
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
Subject: [PATCH 4/6] platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
Date: Wed, 15 May 2024 06:56:29 +0100
Message-ID: <20240515055631.5775-5-ben@jubnut.com>
In-Reply-To: <20240515055631.5775-1-ben@jubnut.com>
References: <20240515055631.5775-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new quirk "CROS_EC_LPC_QUIRK_AML_MUTEX" which provides the name
of an AML mutex to protect MEC memory access.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index b27519fbdf58..ab7779b57a13 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -39,6 +39,11 @@ static bool cros_ec_lpc_acpi_device_found;
  * be used as the base port for EC mapped memory.
  */
 #define CROS_EC_LPC_QUIRK_REMAP_MEMORY              BIT(0)
+/*
+ * Indicates that an AML mutex should be used to protect access to
+ * Microchip EC.
+ */
+#define CROS_EC_LPC_QUIRK_AML_MUTEX                 BIT(1)
 
 /**
  * struct lpc_driver_data - driver data attached to a DMI device ID to indicate
@@ -46,10 +51,13 @@ static bool cros_ec_lpc_acpi_device_found;
  * @quirks: a bitfield composed of quirks from CROS_EC_LPC_QUIRK_*
  * @quirk_mmio_memory_base: The first I/O port addressing EC mapped memory (used
  *                          when quirk ...REMAP_MEMORY is set.)
+ * @quirk_aml_mutex_name: The name of an AML mutex to be used to protect access
+ *                        to Microchip EC.
  */
 struct lpc_driver_data {
 	u32 quirks;
 	u16 quirk_mmio_memory_base;
+	const char *quirk_aml_mutex_name;
 };
 
 /**
@@ -447,6 +455,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 
 	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
 
+	adev = ACPI_COMPANION(dev);
+
 	if (cros_ec_lpc_driver_data) {
 		quirks = cros_ec_lpc_driver_data->quirks;
 
@@ -456,6 +466,18 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 		if (quirks & CROS_EC_LPC_QUIRK_REMAP_MEMORY)
 			ec_lpc->mmio_memory_base
 				= cros_ec_lpc_driver_data->quirk_mmio_memory_base;
+
+		if (quirks & CROS_EC_LPC_QUIRK_AML_MUTEX) {
+			const char *name
+				= cros_ec_lpc_driver_data->quirk_aml_mutex_name;
+			ret = cros_ec_lpc_mec_acpi_mutex(adev, name);
+			if (ret) {
+				dev_err(dev, "failed to get AML mutex '%s'", name);
+				return ret;
+			}
+
+			dev_info(dev, "got AML mutex '%s'", name);
+		}
 	}
 
 	/*
@@ -549,7 +571,6 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	 * Connect a notify handler to process MKBP messages if we have a
 	 * companion ACPI device.
 	 */
-	adev = ACPI_COMPANION(dev);
 	if (adev) {
 		status = acpi_install_notify_handler(adev->handle,
 						     ACPI_ALL_NOTIFY,
-- 
2.45.0


