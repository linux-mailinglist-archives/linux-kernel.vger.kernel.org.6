Return-Path: <linux-kernel+bounces-557230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95C7A5D562
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA56189939D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338F1EB19D;
	Wed, 12 Mar 2025 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMr+1mgC"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430F1E9B3D;
	Wed, 12 Mar 2025 05:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756342; cv=none; b=kSGzyzJQx6WVeSleB2lrG051XhzBWsFen615/IvCXZ7cRWeEbMLxZmFS66UVsL3KNW7nQEmr1p590Z5O5k3qlnLd679OMF49ESV9Q8ZtpzDTB8LwcE1h4YDplcWnQoKtE8gpHb0sPDbOipp1Bg8W6fscU6c0MgxJsNvpT7wbA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756342; c=relaxed/simple;
	bh=dHuXujcVSt1ISFTA0cys14pup7MMvnU5i4aKzf2dcw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2sp7nbCJaGYinKyzyl0suomagNtd1gQ663OdJHDM3IPZzptGCuT9zSt6/AxDrOSwGrSsOX9SziUjYJY6TBKjpU6M4aeAGiDXrLWijWRZ7PsAiMYgbU1Xrd9gsJUs5Gt9HEabC8sBR7KSKOd17vn5zhLKI8gCXxyqyX+gA8RmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMr+1mgC; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f74b78df93so60013637b3.0;
        Tue, 11 Mar 2025 22:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756339; x=1742361139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyyMMDT9jY3GwgMomKZZLoHQgXtzrxyYgo+dpoCdkj0=;
        b=HMr+1mgCw80c7EH7jPavLErRbUkN6qjgZT77GMwNtwd2IPZHu4d/WDFtFdHsF/zKOp
         8nnbHhvMIV/LEdK3sMRXWwFizzX+lt4XhGHdlgU8kmfV4Imra1YkKwqnaic0uDGAkuNA
         31TpKJ+8OTgN/zB0Tq5e7TRIiNHb9zuZcP0eR7cArSbxG2hGRXv58WLbu0mpCiMK7og7
         154EpA/b89Zcw1NqJpYNd7R4qfquMdIFYIOQlI3aFqvuffK9Y2hi3n80nMI04L9rPVEx
         OY2eCGdRFfdf00fV5ytVi+MO4+fAd+eVVgYD8tMTDR5C6CqKh3j2RpTUGzfjTorntTf0
         JBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756339; x=1742361139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyyMMDT9jY3GwgMomKZZLoHQgXtzrxyYgo+dpoCdkj0=;
        b=eRkg+4ltVMj07MiRxOGQSfukIbr5i9oM72ndoYQSEsAuGyqnhvHgOoIIIxIlHIbHHp
         bIycpVHCMMA5/FXiJQHTBMfcHqOqLKyyRHdHb+7mux9VYMrckbCZhHcwMueJob7zFPLo
         y9xQrKAD/Bq2wg23aTBK2Hfpw0s9ne/Y7F26FqOp/uf7o+VeLZBQ16S/WCQqDC/SsEh2
         wBjT95CyiNGHQawaCSq85ho2IOrAlQ7MVgBTfHKj8bZBiZ4B1weZJyU8O0bgb5/3ALPj
         6xJupw3eB1KbxIEJsZNGR9x0vzUbWQv7r33V8nZIgHIZpLa9qpnBdGybaG9KK/Bk5bv4
         COxw==
X-Forwarded-Encrypted: i=1; AJvYcCX33qc8aQuGVr40D8AqfMsz2gxvgglCmuOeFjyrBqIEzawPwd/5Odazsq//EBVNTJ9woGHt/ff9YbiO8Pg=@vger.kernel.org, AJvYcCXsPMAdaDKGguVcZsJwWJIhyB0mPvf9YAEUcviF1bmVgGuQiDpv+FSDlECd13b4MaIenavNTD7AgDYVx17yIle/KWpYVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jc9qvO2Ymrz0u9w8Y0JN4hOx9TSUq4jmSOSzNfQqWaA4UeoZ
	slTUUTNTl4P3iTMWnVInaXu/Zkax104rT0Cc44L/BZMX2ULgFf7gDvm0JJ1S
X-Gm-Gg: ASbGncvAjFDTaZiQRiYox/BFm5Tijf22hspky0juPsvVh21UBVgV9wL/3uPGcfQldO0
	5CHutgb7QUa6UEgzNDE6FQTNqSKWITCVxbdUvHPSRQZzszOAkpZChQkkUpX5ZxlxKris7Yx51vw
	NYiHK+jMa9DYFUX902nu+w7ZbMY7o3Gq8oPP/zV4hoG+3bCZASWf8q5vQK0P2JmcJVJxaZ4In00
	f7kMi66CPpEFqjDkVTyPDVOQN6o0GQvtv4CpqdgrXNBUlM8Kw/YVLGDcAU++pplgERlXuKFaUKm
	oSxmiqHFkfUWCM3zumwbeBRhp/Lfwhy/bPJAh/nLIfftRg==
X-Google-Smtp-Source: AGHT+IG5ckgeFhRxiTcewwcfIfkwkTt9CJpTFF1HJ6yB7pNYBlYSlTaJXrmmbsE03/0Ut/06cYGaqA==
X-Received: by 2002:a05:690c:23c1:b0:6fd:2feb:eb6e with SMTP id 00721157ae682-6febf387345mr269399407b3.28.1741756338962;
        Tue, 11 Mar 2025 22:12:18 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:18 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:22 -0500
Subject: [PATCH v5 09/12] platform/x86: alienware-wmi-wmax: Add a DebugFS
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-9-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add a debugfs interface which exposes thermal private data.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index bc15f78054f3c87148b8729d6ae471cdbb36a940..e89dc1389a383fd7d20b0a46e56b3a324c3e63d8 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/dmi.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -19,6 +20,7 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_profile.h>
 #include <linux/pm.h>
+#include <linux/seq_file.h>
 #include <linux/units.h>
 #include <linux/wmi.h>
 #include "alienware-wmi.h"
@@ -1252,6 +1254,92 @@ static int awcc_platform_profile_init(struct wmi_device *wdev)
 	return PTR_ERR_OR_ZERO(priv->ppdev);
 }
 
+/*
+ * DebugFS
+ */
+static int awcc_debugfs_system_description_read(struct seq_file *seq, void *data)
+{
+	struct device *dev = seq->private;
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+
+	seq_printf(seq, "0x%08x\n", priv->system_description);
+
+	return 0;
+}
+
+static int awcc_debugfs_hwmon_data_read(struct seq_file *seq, void *data)
+{
+	struct device *dev = seq->private;
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	const struct awcc_fan_data *fan;
+	unsigned int bit;
+
+	seq_printf(seq, "Number of fans: %u\n", priv->fan_count);
+	seq_printf(seq, "Number of temperature sensors: %u\n\n", priv->temp_count);
+
+	for (u32 i = 0; i < priv->fan_count; i++) {
+		fan = priv->fan_data[i];
+
+		seq_printf(seq, "Fan %u:\n", i);
+		seq_printf(seq, "  ID: 0x%02x\n", fan->id);
+		seq_printf(seq, "  Related temperature sensors bitmap: %lu\n",
+			   fan->auto_channels_temp);
+	}
+
+	seq_puts(seq, "\nTemperature sensor IDs:\n");
+	for_each_set_bit(bit, priv->temp_sensors, AWCC_ID_BITMAP_SIZE)
+		seq_printf(seq, "  0x%02x\n", bit);
+
+	return 0;
+}
+
+static int awcc_debugfs_pprof_data_read(struct seq_file *seq, void *data)
+{
+	struct device *dev = seq->private;
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+
+	seq_printf(seq, "Number of thermal profiles: %u\n\n", priv->profile_count);
+
+	for (u32 i = 0; i < PLATFORM_PROFILE_LAST; i++) {
+		if (!priv->supported_profiles[i])
+			continue;
+
+		seq_printf(seq, "Platform profile %u:\n", i);
+		seq_printf(seq, "  ID: 0x%02x\n", priv->supported_profiles[i]);
+	}
+
+	return 0;
+}
+
+static void awcc_debugfs_remove(void *data)
+{
+	struct dentry *root = data;
+
+	debugfs_remove(root);
+}
+
+static void awcc_debugfs_init(struct wmi_device *wdev)
+{
+	struct dentry *root;
+	char name[64];
+
+	scnprintf(name, ARRAY_SIZE(name), "%s-%s", "alienware-wmi", dev_name(&wdev->dev));
+	root = debugfs_create_dir(name, NULL);
+
+	debugfs_create_devm_seqfile(&wdev->dev, "system_description", root,
+				    awcc_debugfs_system_description_read);
+
+	if (awcc->hwmon)
+		debugfs_create_devm_seqfile(&wdev->dev, "hwmon_data", root,
+					    awcc_debugfs_hwmon_data_read);
+
+	if (awcc->pprof)
+		debugfs_create_devm_seqfile(&wdev->dev, "pprof_data", root,
+					    awcc_debugfs_pprof_data_read);
+
+	devm_add_action_or_reset(&wdev->dev, awcc_debugfs_remove, root);
+}
+
 static int alienware_awcc_setup(struct wmi_device *wdev)
 {
 	struct awcc_priv *priv;
@@ -1290,6 +1378,8 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
 			return ret;
 	}
 
+	awcc_debugfs_init(wdev);
+
 	return 0;
 }
 

-- 
2.48.1


