Return-Path: <linux-kernel+bounces-198654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676B8D7BB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F88C2825AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF844C94;
	Mon,  3 Jun 2024 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="vHPS4Tah"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF63F8F7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396745; cv=none; b=RZCwz7W6H6iWJSSEyeF6dXeiGXYk7g790SoeOTg8dOVkIh5M5Y0G6WQqWTtVzsL62go7HNcPqqX8gtYqR51stS1nIHdFfyIUbBRcV15YeTFpQD40uuIQPF6+NMzI9EMY4iPDtNp+2GS/uZczMcJUP4HqBN9yq++MGi4M+Xn3rDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396745; c=relaxed/simple;
	bh=hkNs5q0Ag3u8/av4iTBEluUDEHvKgcU6hIRJDGCuqBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGeo6xsvPC65dvuwM5Fh4FFmlenTvDtC+xeLjTODofWnbwhBLHcqG4te3sHYt/yLvlpTD/MC36yVDZH3sEBshSDfglyPlVza1dJnGcU/nGkwMLo4ldb8dwTP0OHyB4ahjncbzRJy1aOjZ2aZ+TH3sHuq4rs6M/VbzEhh9tQxaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=vHPS4Tah; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vt3wJ5W4Bz9sT7;
	Mon,  3 Jun 2024 08:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717396736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27yHvoqXvTKgDtibjbQpIqsEZ0fGGVbEGRHK5/yVtA0=;
	b=vHPS4TahH1ywsnpjIC/gz2MLCRnPUnGVg8OXoyzlUWg6fQKUjnPJOOaOygoKujO1heUODL
	UmCK8uCIPaGkevvzAG30lvFSY08XDM3QahnqNJ+JRYvRVBW72eSPlY3DzORgiXloyGat+2
	haE39ARYb406DPPYK3FZmj0+aND9GefcnxgYMWE6h2w+K3tExVeM3mwcw1Q5cP7Qc+9P1U
	9epBHYLFYkiKDNSZx4EdPDhlH03VAWwqYeIDtXzP+GCZ6ZI2+O6DpGpS6+bI0bUVo2VVei
	hj+Byj8O7J531Q4wpQNcZWEiBZS/QMRKCcYC8ar+AmKMUY/zrvSbl7WUy/0q9g==
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
Subject: [PATCH v2 4/5] platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
Date: Mon,  3 Jun 2024 07:38:33 +0100
Message-ID: <20240603063834.5580-5-ben@jubnut.com>
In-Reply-To: <20240603063834.5580-1-ben@jubnut.com>
References: <20240603063834.5580-1-ben@jubnut.com>
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
 drivers/platform/chrome/cros_ec_lpc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index c1c26a7ba6d4..60627c5a596b 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -44,6 +44,11 @@ static bool cros_ec_lpc_acpi_device_found;
  * the ACPI device.
  */
 #define CROS_EC_LPC_QUIRK_ACPI_ID                   BIT(1)
+/*
+ * Indicates that lpc_driver_data.quirk_aml_mutex_name should be used
+ * to find an AML mutex to protect access to Microchip EC.
+ */
+#define CROS_EC_LPC_QUIRK_AML_MUTEX                 BIT(2)
 
 /**
  * struct lpc_driver_data - driver data attached to a DMI device ID to indicate
@@ -52,11 +57,14 @@ static bool cros_ec_lpc_acpi_device_found;
  * @quirk_mmio_memory_base: The first I/O port addressing EC mapped memory (used
  *                          when quirk ...REMAP_MEMORY is set.)
  * @quirk_acpi_id: An ACPI HID to be used to find the ACPI device.
+ * @quirk_aml_mutex_name: The name of an AML mutex to be used to protect access
+ *                        to Microchip EC.
  */
 struct lpc_driver_data {
 	u32 quirks;
 	u16 quirk_mmio_memory_base;
 	const char *quirk_acpi_id;
+	const char *quirk_aml_mutex_name;
 };
 
 /**
@@ -484,6 +492,18 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 			}
 			ACPI_COMPANION_SET(dev, adev);
 		}
+
+		if (quirks & CROS_EC_LPC_QUIRK_AML_MUTEX) {
+			const char *name
+				= driver_data->quirk_aml_mutex_name;
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
-- 
2.45.1


