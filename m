Return-Path: <linux-kernel+bounces-201812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04048FC3C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554241F276E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F4419046D;
	Wed,  5 Jun 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="OD9Cp+j+"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5F18C32B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569259; cv=none; b=d5E/1ll2XjEJMF3nX1tFGPiwZf2a7mQqEYK73O3VtYipnEuGD6Lre1tCMOXskmrrUHNsWqT47xFPCwaOd76vD88AmBjOibEIsEt5xpeKMC+4l5rkrzZuN9oEfAB7soRlnX6pPbgvzvjSuEHkX6N81i2udIooQJtRgke+gbPQ/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569259; c=relaxed/simple;
	bh=ruqDG+QNwILXYDQjZdx8DjPIl7jOpAZrddO/qf+cPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkhyNJz3XwO+skK/XIAD0mP1zgm2L+c+PVAQoEGDb1YFfZPQIT59DTe7rrOVycaxNQDoqyhJDWqi+TSeR847edXHtsOYfDooRqOR8CFDFUkRUYA+YpnDvkQx8UtiurFvq6eYRHdqSUz39q+Q1W05dTD10+Ty77vz+Gp2DZPlmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=OD9Cp+j+; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VvHjx1G4bz9snn;
	Wed,  5 Jun 2024 08:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717569253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVWT4o4RJN6rHBWyrxsihWMYRQAtby4mFTEOZmR9bZ8=;
	b=OD9Cp+j+oYiI1npLa2sF9fA/R/eLbxx1cOSREITVCBCUUfp+T2KK9Vi8W7JzDNMpqmDF7Z
	evQ8iQSRvDne9UR39Pqjqnuc4oXX2vDbjqgbHl3Mxv15zNos3oTNouIAvjmhyAIZIcA9JW
	M/I0cDMFNvpNISrIE3skRPbVthuS8PbzZWykupAmKgj0UxAUpYnmLNoOn0QQ6pCnNR4Y8l
	1gX0iNm1A/hz/yYWyJHwZotrWYZ0SRycklaGMDZyN9/cUkWSS2Yjh+0hMGC4G1vmFt3w++
	I0EaQEJhNqyz2Iya8lcArailk830RT9RpPkdPryC9riJgMVWY2OwUhwmADmA2w==
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
Subject: [PATCH v3 5/5] platform/chrome: cros_ec_lpc: Add quirks for Framework Laptop
Date: Wed,  5 Jun 2024 07:33:51 +0100
Message-ID: <20240605063351.14836-6-ben@jubnut.com>
In-Reply-To: <20240605063351.14836-1-ben@jubnut.com>
References: <20240605063351.14836-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Framework Laptops with Microchip EC (MEC), use the ACPI id
"PNP0C09" to find the ACPI device, and AML mutex "ECMT" to protect EC
memory access.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 5d9cc8df208b..ebe9fb143840 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -636,6 +636,12 @@ static const struct lpc_driver_data framework_laptop_amd_lpc_driver_data __initc
 	.quirk_mmio_memory_base = 0xE00,
 };
 
+static const struct lpc_driver_data framework_laptop_11_lpc_driver_data __initconst = {
+	.quirks = CROS_EC_LPC_QUIRK_ACPI_ID|CROS_EC_LPC_QUIRK_AML_MUTEX,
+	.quirk_acpi_id = "PNP0C09",
+	.quirk_aml_mutex_name = "ECMT",
+};
+
 static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 	{
 		/*
@@ -704,6 +710,7 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop"),
 		},
+		.driver_data = (void *)&framework_laptop_11_lpc_driver_data,
 	},
 	{ /* sentinel */ }
 };
-- 
2.45.1


