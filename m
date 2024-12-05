Return-Path: <linux-kernel+bounces-432446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492639E4B53
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C8F166022
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A90101F2;
	Thu,  5 Dec 2024 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2PnjjUh"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827223918B;
	Thu,  5 Dec 2024 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359307; cv=none; b=o+GPWkN7g7iEPzHRoTj6DVOpgsTa56X2AeMeo+fI7yDll62jChMzy7KjggIcpMm2dREJJhTAw/BAp3hssO45Hoydl3RDXapm1r9GELSIZ4Lvm2HmIkUPPB+VDnRTzEQosslhEn0mGBd9Nf1WxVUgDoG+vtElnxY4kkENd+2fWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359307; c=relaxed/simple;
	bh=idEFuKUfX0GdLxKRG884CM/bWcChZzON4b29M8UiufI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSweUstl+lQMygSj3iM7P9Ao4zSCBKeQckWSYPTnewMa4OJgI2bDA5h83hr7lQYzGs9e4/kny57oRaj/RQTSKm/VVMYmAH7oy9hF9Ja0WulTmXJJyoLmkwZojPURxnFXoh8s6r3JNHtMxt64pNOb3ph3Eklo5lZwd9c4j42nq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2PnjjUh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7252f48acf2so326542b3a.2;
        Wed, 04 Dec 2024 16:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359305; x=1733964105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgR2RY/7h0XKplR8sv56yktKeGsrAmbG5SmI2iAFKxU=;
        b=i2PnjjUhzvFOcsU7JT8Firp4rXRscvrJORjq9kVrxqH4U6FXMwpkSqj26kj+eh5YvL
         8LVqiAx0c+q//OKXio6bzT41tO830SCYP97JYQf8hGdtR0/cWplu/ab1LYCp1hUIBvEy
         ktAQEs9mpqtXzRhWEA+TekNu43wFG5ZWW9/7d/9/eA6aNDh4uEXhnXhs0KnQMT4uLxTH
         MNZjnM7MxNmsDM65YBHoeYu7VkMF4TqbV0/1/ZMimamSWHrGUlTgdYf17nF5cvxyqtfr
         bnehtIoUfT8pV01XfYL4Pnsn0c/t30KZBUoYMRmGi0n/6LIbv1Y6Facg/tWHc/jUJWTe
         Xl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359305; x=1733964105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgR2RY/7h0XKplR8sv56yktKeGsrAmbG5SmI2iAFKxU=;
        b=EHE4JA4f0ITTV/vtKMP5KNVbUIa02vkO1SGSaxSMi+VHO6iIdWARAtqov4i29sPUX4
         Lao8pYGzPWWDIgTJR2bgpDkhZ2tvBKhNX7QgNSR9vofj0EtSLvHToXYvj8AHcWGNmtQu
         BlgRB+INEws5il3BfnTBbH2HZKupSRH3hgd9JU6xzqtkfDO+GjoDEKxm6xgX1Rzw5NFn
         7sgJ2QVsti79UFblKAriacptEYaiHAPOVj5YFS8vgS17nN1b+Igcr9FbBcYskHlYFgs3
         CcWhLLYtvnHGOsyo1cF34BA+TzwUddX1ZHOMq1eEjAK3DvgGhbVBhoJQ0vEupMzSJ3pw
         7ihA==
X-Forwarded-Encrypted: i=1; AJvYcCVWDSt3qZVEyWpOOgIh9I4BeucRQt8T2s4uTEAuXu0Zq2Tu7y7ocHEDnskbqZg0/e8ZPof9ZvmH6mdrvkM=@vger.kernel.org, AJvYcCXbEL8o2ZrF4lgEFYgb0PRFV/EYodjzJ1aa8u68agCbEXV/PxE2W17Gl+WjbR6cxD3wkvydWu6wSsYTItDOreAZRiMyTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmeEsIhsvLQ+f8t7q9qG9KVq6DeoWjiZR9FUIcj5/kr/coAkbT
	EpaEUv7laAw9kjFqHZzk6adcIwkjtza6a1ePwzh9few1L4FGUq0X
X-Gm-Gg: ASbGnctkZo1dHEkp6vfsqypWkU5AAIssvyVH8wqfOt0cc3MVnnlLPtVxDS+DsCzUpOw
	Jk5qsFpETNMZTRDvvB1yC4kLfRZUTBYeGvFieakG6LMzIjkT/B9rbCS3OEbUYRKhWj4D4ATnhst
	IH2YvKt8Kt3bCGixLezYLG5BElkNt30K0IZFC7Tkhrm23Kv6xtsEledidUcg3t1o1B2wW7j2mGV
	CvgxCsIiL0EOPhXYXlVdw0P21VXzE5qRW93+/2wVJ4BQQ0AdzmXyvR2+RX5KEoeV8vz/Ivqo/ir
	5fionilOrTZnY9Oh9U8=
X-Google-Smtp-Source: AGHT+IGQwUfpbct958vNmk6A46ODIykELevFx7EGJjQHU8D103XHHLsrvVSOUdgZmIoY/XZ/im2RIw==
X-Received: by 2002:a05:6a00:ad2:b0:724:e582:19fd with SMTP id d2e1a72fcca58-72587ee6238mr10177556b3a.3.1733359305488;
        Wed, 04 Dec 2024 16:41:45 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2ca61aesm98823b3a.140.2024.12.04.16.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:41:45 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 08/21] alienware-wmi: Add WMI Drivers
Date: Wed,  4 Dec 2024 21:41:26 -0300
Message-ID: <20241205004125.2185385-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WMI drivers for LEGACY and WMAX devices. On hosts that support the
AlienFX interface, the corresponding platform device will be registered
as a bundle on the WMI driver's probe and will "pass" a WMI device
pointer to the platform device as platform specific data.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 115 +++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index e5e4a7b4e9ca..38e9cb80ae69 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -15,6 +15,7 @@
 #include <linux/platform_profile.h>
 #include <linux/dmi.h>
 #include <linux/leds.h>
+#include <linux/wmi.h>
 
 #define LEGACY_CONTROL_GUID		"A90597CE-A997-11DA-B012-B622A1EF5492"
 #define LEGACY_POWER_CONTROL_GUID	"A80593CE-A997-11DA-B012-B622A1EF5492"
@@ -39,8 +40,6 @@
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
 MODULE_DESCRIPTION("Alienware special feature control");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("wmi:" LEGACY_CONTROL_GUID);
-MODULE_ALIAS("wmi:" WMAX_CONTROL_GUID);
 
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
@@ -412,6 +411,10 @@ struct alienfx_priv {
 	u8 lighting_control_state;
 };
 
+struct alienfx_platdata {
+	struct wmi_device *wdev;
+};
+
 static struct platform_device *platform_device;
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
@@ -1150,6 +1153,114 @@ static struct platform_driver platform_driver = {
 	.probe = alienfx_probe,
 };
 
+static int alienfx_wmi_init(struct alienfx_platdata *pdata)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_create_bundle(&platform_driver, alienfx_probe, NULL, 0,
+				      pdata, sizeof(*pdata));
+
+	dev_set_drvdata(&pdata->wdev->dev, pdev);
+
+	return PTR_ERR_OR_ZERO(pdev);
+}
+
+static void alienfx_wmi_exit(struct wmi_device *wdev)
+{
+	struct platform_device *pdev;
+
+	pdev = dev_get_drvdata(&wdev->dev);
+
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&platform_driver);
+}
+
+/*
+ * Legacy WMI device
+ */
+static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	int ret = 0;
+	struct alienfx_platdata pdata = {
+		.wdev = wdev,
+	};
+
+	if (quirks->num_zones > 0)
+		ret = alienfx_wmi_init(&pdata);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void legacy_wmi_remove(struct wmi_device *wdev)
+{
+	if (quirks->num_zones > 0)
+		alienfx_wmi_exit(wdev);
+}
+
+static struct wmi_device_id alienware_legacy_device_id_table[] = {
+	{ LEGACY_CONTROL_GUID, NULL },
+	{ },
+};
+MODULE_DEVICE_TABLE(wmi, alienware_legacy_device_id_table);
+
+static struct wmi_driver alienware_legacy_wmi_driver = {
+	.driver = {
+		.name = "alienware-wmi-alienfx",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = alienware_legacy_device_id_table,
+	.probe = legacy_wmi_probe,
+	.remove = legacy_wmi_remove,
+};
+
+/*
+ * WMAX WMI device
+ */
+static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	int ret = 0;
+	struct alienfx_platdata pdata = {
+		.wdev = wdev,
+	};
+
+	if (quirks->thermal)
+		ret = create_thermal_profile();
+	else if (quirks->num_zones > 0)
+		ret = alienfx_wmi_init(&pdata);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void wmax_wmi_remove(struct wmi_device *wdev)
+{
+	if (quirks->thermal)
+		remove_thermal_profile();
+	else if (quirks->num_zones > 0)
+		alienfx_wmi_exit(wdev);
+}
+
+static struct wmi_device_id alienware_wmax_device_id_table[] = {
+	{ WMAX_CONTROL_GUID, NULL },
+	{ },
+};
+MODULE_DEVICE_TABLE(wmi, alienware_wmax_device_id_table);
+
+static struct wmi_driver alienware_wmax_wmi_driver = {
+	.driver = {
+		.name = "alienware-wmi-wmax",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = alienware_wmax_device_id_table,
+	.probe = wmax_wmi_probe,
+	.remove = wmax_wmi_remove,
+};
+
 static int __init alienware_wmi_init(void)
 {
 	int ret;
-- 
2.47.1


