Return-Path: <linux-kernel+bounces-576903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87455A715CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66594188AF10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341B1DC993;
	Wed, 26 Mar 2025 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stravers.net header.i=@stravers.net header.b="gYozEA4H"
Received: from mail.stravers.net (mail.stravers.net [185.170.214.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95251B87F2;
	Wed, 26 Mar 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.170.214.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988787; cv=none; b=sKVvqKuxBaDFnf/jE2iNqux+hHxI5czm4xlsL7v6aOBZBO1b7DAw4oxVVaW/n9hYTnqyOHuL3Wyxdm1NmRCamBI7wafHZ/lIEKMzaibKvQkWmk+2h91utZPMvosFSRfhXVofeifd4GFmE667Gc2KGU9BWkx3hVIzHO9m5FEKDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988787; c=relaxed/simple;
	bh=APYVVjVsS3qCZ/z1wxK6HUjwQSli5QEkKwva+CQeZhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyidLyF1Jg47kFf10FVT643NUXw6alnb902iK7M6q6LfS8kMK70pML/VvFGchgbNMnDWIjbodbGUVL1ILE3ylmeQtt2RB+hDUtwtb8xmyrHeF3flndNYEQTKoC3rj3pyFLr8JToMAfmYAibE2oh7qx8MR+g8Np6JzRZCktcDV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stravers.net; spf=pass smtp.mailfrom=stravers.net; dkim=fail (1024-bit key) header.d=stravers.net header.i=@stravers.net header.b=gYozEA4H reason="signature verification failed"; arc=none smtp.client-ip=185.170.214.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stravers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stravers.net
From: Kevin Robert Stravers <kevin@stravers.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stravers.net;
	s=mail; t=1742988776;
	bh=RjhMLAf+se+V4P+5Mfr5CunsJkkri+FoJWfxa75R8Ds=;
	h=From:To:Cc:Subject:Date;
	b=gYozEA4HfSSDpGRgoBOTzsGxowNFSb5GSQF6OJy0wqY/Vk+oWPNNrtfTyWaNerUYy
	 I2V6JvBYsCBI2TeGstQGYusI9TufDFL2K0cuzba5q/qzZ5nufk+nzm25yxvl4U7sdo
	 nmsE8/hmL3RA9+XNk6K2ujm3xShJn4OBK3qvwB2o=
To: linux-kernel@vger.kernel.org
Cc: Kevin Robert Stravers <kevin@stravers.net>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS)
Subject: [PATCHv5] platform/x86: asus-wmi: Add quirk for ASUS Vivobook S14
Date: Wed, 26 Mar 2025 07:31:56 -0400
Message-ID: <20250326113157.2341184-1-kevin@stravers.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS Vivobook S14 will have wifi disabled on boot as well as
resumption from suspend if the asus-wmi driver invokes rfkill functions.

This patch disables asus-wmi's rfkill usage to prevent the wifi card
from being software disabled.
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
 drivers/platform/x86/asus-wmi.c    |  5 +++++
 drivers/platform/x86/asus-wmi.h    |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 3f8b2a324efd..1e6fb9308560 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -150,6 +150,10 @@ static struct quirk_entry quirk_asus_zenbook_duo_kbd = {
 	.ignore_key_wlan = true,
 };
 
+static struct quirk_entry quirk_asus_vivobook_s14 = {
+	.skip_rfkill = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -530,6 +534,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_zenbook_duo_kbd,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS VivoBook S14",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S5406SA"),
+		},
+		.driver_data = &quirk_asus_vivobook_s14,
+	},
 	{},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 38ef778e8c19..42e58a28c3e2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2138,6 +2138,8 @@ static int asus_new_rfkill(struct asus_wmi *asus,
 
 static void asus_wmi_rfkill_exit(struct asus_wmi *asus)
 {
+	if (asus->driver->quirks->skip_rfkill)
+		return;
 	if (asus->driver->wlan_ctrl_by_user && ashs_present())
 		return;
 
@@ -2188,6 +2190,9 @@ static void asus_wmi_rfkill_exit(struct asus_wmi *asus)
 
 static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 {
+	if (asus->driver->quirks->skip_rfkill)
+		return 0;
+
 	int result = 0;
 
 	mutex_init(&asus->hotplug_lock);
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 018dfde4025e..3692de24e326 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -41,6 +41,7 @@ struct quirk_entry {
 	bool wmi_ignore_fan;
 	bool filter_i8042_e1_extended_codes;
 	bool ignore_key_wlan;
+	bool skip_rfkill;
 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
-- 
2.48.1


