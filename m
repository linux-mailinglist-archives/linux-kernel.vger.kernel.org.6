Return-Path: <linux-kernel+bounces-198653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF61E8D7BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0092D1C20E35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05A3F9E8;
	Mon,  3 Jun 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="ObEChmy1"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684AD39850
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396743; cv=none; b=tHlRhjk7OG52eUUhJBxRejgZaGurD0VvEcmbXP5KoZR9XIrsVcIexX6zCK/rJ9RDVXG2vFPBc0qveDV4EQTzOpIXzEEx1GxqD+Ywsi4/PLeZKA6gYQjtilQQoCn/Up9nWqfv9h+dw3qCcwTZ3PHYKCi7n4uJnwVplW+i3Mp5z7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396743; c=relaxed/simple;
	bh=zyqkLT5mV7DFDlZD2cERTDZc1/oX7YWjlhRS0J33Al8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzlut8BlXYxz061u9dNWXkHdfiZk/NNyLUzwD7D+L6FMzfBBF07teAB6zuoQPINeFbwMLsDwzJvU9tgybtifMfBo5teS6gO0TqMLWrmeqjjNjCwjMDY5DfoSq9ykj/sflJru9e9uglzlQaHvIMeVows+zTvCJW0AmXtpP0cfA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=ObEChmy1; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vt3wM3CCxz9sQL;
	Mon,  3 Jun 2024 08:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717396739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqLYrR5cnnvV3FDBiknPtKPsivF9+i98Tj6Gjo1gOLQ=;
	b=ObEChmy1qiQootQYkyfmHAkcWsmfEVzmAkNKw0W2mlPX05DIDqosANk+KQrWaLBsOFO4q9
	F9XNjnLYnaR4kXvOAHEE9PbPEhNSpuvPO45cBZYsdR1yeGcLwkDX54yaLBFPWUmlLvJE1Z
	zmYRWah+JJRDLEuQxb3LtHXd53bKpjGEb00FrJbUn1hJs5mv08BOH1b5y0Nn+K3jqK2VYf
	K5xbmGAQMbAT3OJ75C+sKLz2bXjHqUNjGLYfYIACgFPn7N91oHVlFRkNtVZ7JIe9uwm4Yt
	WZCi3v63/PbkfQA8QMCACJvoizubyagR5bGETJhjUhN8E4IRU2KLG3fxnUJlmQ==
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
Subject: [PATCH v2 5/5] platform/chrome: cros_ec_lpc: Add quirks for Framework Laptop
Date: Mon,  3 Jun 2024 07:38:34 +0100
Message-ID: <20240603063834.5580-6-ben@jubnut.com>
In-Reply-To: <20240603063834.5580-1-ben@jubnut.com>
References: <20240603063834.5580-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vt3wM3CCxz9sQL

For Framework Laptops with Microchip EC (MEC), use the ACPI id
"PNP0C09" to find the ACPI device, and AML mutex "ECMT" to protect EC
memory access.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 60627c5a596b..bebf76404512 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -634,6 +634,12 @@ static const struct lpc_driver_data framework_laptop_amd_lpc_driver_data __initc
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
@@ -702,6 +708,7 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop"),
 		},
+		.driver_data = (void *)&framework_laptop_11_lpc_driver_data,
 	},
 	{ /* sentinel */ }
 };
-- 
2.45.1


