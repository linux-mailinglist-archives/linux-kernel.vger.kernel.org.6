Return-Path: <linux-kernel+bounces-552790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19590A57E20
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE263AB574
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C0020E020;
	Sat,  8 Mar 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqdz5i7P"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6F20DD67;
	Sat,  8 Mar 2025 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465447; cv=none; b=nzK6F9Wm432f9Ain0Ko00fesQFYTseAIfldnsc26QeY6knWBR59phVtl6goZ9/x6e3Z+RWg+09EdMJQCbL0w66WoZDBKSHZGiG5QHskBwZIuH1RUjVx1oej6M/jFoXhx42so08hl/3v/vhscYQLc+7TQ+Zusk7Dzihd8q4dfONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465447; c=relaxed/simple;
	bh=KwrCLpK8le08otfiFGfZZYH0fnGuFvXy84GjEXmIJac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXaCOsCz90kkiZAQ8UTkloqtDQS5lylwplRf1KgB90poHHBK9DlH0kZFoBAN7tUtDV2jvfakuVG6OLS1ME1nTZsfqHP7JDcMxP1qc/L86UQMngKEBDHNbZEXzQG3A7YipZC3c+0RxSgzOozpQZ3yEqO/BYOBxhND89DlPX+WDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqdz5i7P; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86b31db3c3bso1192235241.3;
        Sat, 08 Mar 2025 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465443; x=1742070243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Pd44e4mOe+bD5C1vl3vRJ8fZ0guGsHvauJTp/rwYSw=;
        b=Uqdz5i7PGhaPqOBgPWYsQ9cEZ7cHxIhEDlvdg0pcYIt64oPpCj7jmsP+9c0XNLAZnT
         ZHPH8zkxgHe8k1pWVUmrXc5ClvXbe/skoMUGq2EfFcVSho8sHbF0hZTR73yPPa/yM1JZ
         mumcNx3I2Aql+rJFdfhkaw+rpRTEerxTW5dEVP+vuc7NflBh4nPVktn8LiyXsro0ftuS
         e1tpeqIaaek0iph2JAs2FkFYnm22G83gd/TYMVt9U30ZoY88vWtczpltRZ/XcfDq5RgJ
         vSsK9UQXPYEURvkPDW5wFDR7VsX+J1b31XLucRJWcye5ukS+sZOG2JNyaE3Lk8gMmBpm
         Ft6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465443; x=1742070243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Pd44e4mOe+bD5C1vl3vRJ8fZ0guGsHvauJTp/rwYSw=;
        b=DILOA3L9S4iuPCcpqIYyAXS1ezQX/AZVvcCmdTTT/ZxRj9hM42QTVdLaqbqGScQQGJ
         KcdcDm8SAgqdS1sRQ6NF0SvRLqM6Q0qSDLPm1QEO+aPJKIAYZ/8iw9TtqKDgxii8Xu/X
         rHIXAlps2vvOKvFE/r+/KnA/pEMJTtKnfU1YfLXvRNbb7URXiATIjbVhx4z8aduZmnKb
         b1q/VzSYRyVhJ3RVuUEPCV3D2Eb9fx5otoXkcPut/jGoJAw39T0sadaVHdMBU6JyR7se
         nq0u/+sK+HlwxbYc4FejJYATptGTf5tp1s3CqXRnU/OM5pSRLef03b0TGE7InJ1cuocs
         ARig==
X-Forwarded-Encrypted: i=1; AJvYcCWAo0ut7leRkOFC/FZBQL+E1X6/ZfobU++Okcrldjo+aA8nVJA32h03kkhja8q+AOE3v+u9hiBMBkO8nSA=@vger.kernel.org, AJvYcCXMZU5hEBJRjhDvpK3n+IXUpa6xSqbZ+AihbJtiLLF7aiZwnrS5X3tIG0Bvx8R7oQIz0d7iILZ41XOmAGVVqJ1tQdA7pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJUK41Pur9r71yLuhaLcukiIJDE3ma/cRNbJ2kXd7/H7wGJWd
	NKXuaDLEoQ/zLh3ZqU8Idz2CVwC+YNIuNlxgivsblcSaWUn/26QdBKfc9aoQ
X-Gm-Gg: ASbGncs2CS5R/2FhGnZz7WKzqQOqm6g5HLcaV4DUh/EcxcAeSEUO/DpavthZDPuoPGP
	/ZvrUWW7derSeZlO5s4LPOOgRjDCnKkfeLCWNIFxufA105OzAVGbPK6KnEejCtky7cGE2xDOoaV
	p1zekrwGTBUqJrqljfzV39FfA/MKjgP9xk3oCzTVCNw/pU85q+CPWj4beavx/sSGBP1s/KPdu2a
	1eljT8DLz41IPKXw/OKOTBhQBkb9pBcAUk7Rf2teReRy3akRgIiXFTdAZTRQrNlZHiipTDtGh6Y
	ifeRdZaHWHgArzBbdtsW8k13XQYmequX8J0BCvoZCOD4XQ==
X-Google-Smtp-Source: AGHT+IHLsdwldUVtT72+0KCW67ZAr32woKdVpLiiHrNEJ202SOCU0qArbfrBNGq4LruYBqxg/+5aGw==
X-Received: by 2002:a05:6102:41a8:b0:4ba:974c:891e with SMTP id ada2fe7eead31-4c30a67bb0dmr5259292137.17.1741465443568;
        Sat, 08 Mar 2025 12:24:03 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:24:02 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:21 -0500
Subject: [PATCH v4 09/12] platform/x86: alienware-wmi-wmax: Add a DebugFS
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-9-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
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
index 68ff520f016d2d567cddcefe41f01bf284b4d979..46d11b200820cdbaa841fc97e33b339fca42104e 100644
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


