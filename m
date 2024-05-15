Return-Path: <linux-kernel+bounces-179483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1788C605A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730031F22F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1B41A81;
	Wed, 15 May 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="dq8WFuXJ"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE303BBE2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752611; cv=none; b=Mk1t47Fz41homosqIdhXtL47DvSfdxCVr74UpqhE8PmerS/2LcjYKZnvtBn0kSMfYWhXk4GhexG4FSRTLFTh8vttz341ovvC8Yn9d49KHh9ew/RNTahkoKXukt/HT1h6McdTL+PjCizyxDfIKMoXTmLlNW/UGxZwGT3lOLJWU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752611; c=relaxed/simple;
	bh=rAt8YNpQKXXcDBfl3fABzFqpMOxWyaiM90IYalzeEDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXlKdfCR5hxrq6ABXMfi0D3hcvhNeOzcpQM/gxvnraF1aHXF0+8qg5OPujqDkl2Mu5nqu/QBHsJYp3wfBkypX0hvfm3Az4HNu9wh6w6WPXq+IeRXgRTtvNl8u5hLLRZDd6JfAb4mvdMWjtQHDvghOOUYl/AAbXJQSv052jF6pL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=dq8WFuXJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VfMtQ60KSz9spP;
	Wed, 15 May 2024 07:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1715752606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnqCSCUcBf38TreUS2aZDdjexDedf0EYPbjnTnEk6Wg=;
	b=dq8WFuXJUyCJLCr2/SeARo6yMchJxAqd+agNYVAstyhQbe00OCzKvSesNU49uQJymeURgE
	+1tzgo1Peah8V4JSwmVyWQZQrh70pvvRAbxzajvsG0ePlGc/xAVBVH2PLNJQp5Rx9Kj7Rg
	cOwyzZ7ycG7rG2G1j32QB5h+8A6Rlhhi91Fi3RSHE4UkJW28GPVQeQuzhfNjz5VgCUDCpD
	4+Y+lWkMIQy26eUrWSliOYwy0Q0yIdYIitOslTBtUwe9sXDvJ61RIcXlGie40DOlDZkBo7
	ZiHrwwr74crol1sDGMAK0CJyekiGgxkUcP49lnT0ehz1OsKrhO7puV0e1hWIVQ==
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
Subject: [PATCH 6/6] platform/chrome: cros_ec_lpc: Add AML mutex for Framework Laptop
Date: Wed, 15 May 2024 06:56:31 +0100
Message-ID: <20240515055631.5775-7-ben@jubnut.com>
In-Reply-To: <20240515055631.5775-1-ben@jubnut.com>
References: <20240515055631.5775-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VfMtQ60KSz9spP

For Framework Laptops with Microchip EC (MEC), use the AML mutex
"ECMT" to protect EC memory access.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index a9200f0a1a37..eebc66a39a23 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -611,6 +611,11 @@ static const struct lpc_driver_data framework_laptop_amd_lpc_driver_data __initc
 	.quirk_mmio_memory_base = 0xE00,
 };
 
+static const struct lpc_driver_data framework_laptop_11_lpc_driver_data __initconst = {
+	.quirks = CROS_EC_LPC_QUIRK_AML_MUTEX,
+	.quirk_aml_mutex_name = "ECMT",
+};
+
 static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 	{
 		/*
@@ -679,6 +684,7 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop"),
 		},
+		.driver_data = (void *)&framework_laptop_11_lpc_driver_data,
 	},
 	{ /* sentinel */ }
 };
-- 
2.45.0


