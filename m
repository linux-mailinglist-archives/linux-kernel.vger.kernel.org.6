Return-Path: <linux-kernel+bounces-532630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F1A4501D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66CC17D842
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B2221551;
	Tue, 25 Feb 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD+WU+fU"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CF21D3FB;
	Tue, 25 Feb 2025 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522328; cv=none; b=n7Apfkm61UI0QTx3ndc6z7y4xkp6PxEm2YDCoEe0B+LTyJBsXstM5ZEXE7qGKrPk6n8QP5gLLDe5WayTImBNH46Kw1xxSBNrZdV0VHMyR48Y8BtnOeppoIs44ZoK8shraRAtGOq1PBdE+HPA94HI2rOTnYcyHYY5UFqYLcxUDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522328; c=relaxed/simple;
	bh=zxWzws/0dfdvCvtJm21MjieatCumRVusoWb38x7G/B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDcjexKNlN+loXPoWyIJ1LeHYlwKryOIPgibyhZcg/SSqyrmqmknkIb897LVenak4eHGQvzqIsk9i+Pt3+Kxj1Px9RI3JEQHUQUTHrjYzc+NDvoWSgcDqognzfpB3aCm4h0j4ywCO5/+3CKNPmJPeY/3dlw+iVzK5DEggmgl960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD+WU+fU; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4419a47887so4846653276.0;
        Tue, 25 Feb 2025 14:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522326; x=1741127126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFIwlEXi4ymhMThLkuI8bhGcLjvZhvmy0OkefTSAnKU=;
        b=SD+WU+fUdURPUCDesffM4RBGIwz2KVmiZq9Jj7BFmJIVSzXlXHX7DnIVwiqc5lqYjC
         wN8juX/Qk3GjsBlMLQvDQw971fP4YQJDFDXF5R7+GIS6h7EGSk+ZfDurOpzKyt8TGbzh
         Z9oCz6fOVXoT3ivQZFFbHSTognB3H3hNiPl57Fe+HQ1Cg3YerpVDLDTHyubwNM+AxUSc
         YJEIfe2nkPqtYjCy90GZiwyFjyyW3NyWRqs4UbObv6O6eQTu5kLSrA3mvsgoUTKr1mn5
         LvsD8CX/hILa+wi9FGO/lASvRcQ+e3dMDKV2xKig/gU/zNVOX6WrOUzxP06+ldtIsXKA
         +GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522326; x=1741127126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFIwlEXi4ymhMThLkuI8bhGcLjvZhvmy0OkefTSAnKU=;
        b=IIHG3h0wNAS5QcMkzw9FwMTII+8sHwXEgwMlirWFeBs/0x8qhP8YUCL5X6hHWER8YW
         nkbcSpXEpE0kedgs119y2ZDdjC2kvhv345N4rLrEdvsiX9y6U83IaQIycxj8dBZ6tmDh
         RRL/IRUo8dKx2sc5u38BfwVI9MRCziPkqY9DXgdz/q+D6ttsDXXAUc9LFKczpA/rBPEq
         BhEULasyu/0e/auqoh+uj+J1V3bnyqrB2YL+kFU+piouCjk5xOsnYcn/UItf8K+ef5PK
         q0ZTM5PJVKEqMAu4lSq75J8vSEo254cb96KFYDGrUNix5wBrcYJ64Fj5kD4TJvoK3YwS
         LU3w==
X-Forwarded-Encrypted: i=1; AJvYcCUyiXWuRl0/0VAifDwq/G4sEMXIPhkRkfDwmAnsHWORjB0biCzjQMYBCREglNuDCgIFmsyX06BpRVbQnKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkUgbL1BCxEYEv1eC9UBMJpnv2MnYTzrmbL5mvuz4NHFFdXya
	ko6Txz6pp8R6RMxSEs7LVd7lF6rmL0FENLpUhdHbJXwhDUX4gh42mFX1zelj
X-Gm-Gg: ASbGncsCed60ThAavT5Z76umORLk3jn1pynnYuqcvgPmo47woPe0Rr9Y0b3E0G/CJ40
	cWbNCKZVyKvUUb5QPf0UkVl/z1WhTm6U5zUOA+x5SXWOkZUF/9FJcheTZS6HCKq8wHZB1jC6k4J
	8SFc4bugo5VLHqkBzVs442j5y8WNUbYF6t5hBWchLXavfWkJyDIv0YKKdpTmbxtXWKYfkJqH+IL
	grKfubmXZLeu5nWTj+SCJWSnvreH6ZuaPsibkMFYH/TcWbm5Ml7FupGFKk8PuR0cp8yAN0c8oNK
	fmrz1RIOCF658WNC6sJF70191adUE/YaRg==
X-Google-Smtp-Source: AGHT+IHYj3MrD1NV+iRrXbiOmr0b8vvvCdJCAjzh5LSJk22MDKxV9+FejXuJ2mqpNPvVHPGNDaEdZg==
X-Received: by 2002:a05:6902:1882:b0:e5b:42c7:8f28 with SMTP id 3f1490d57ef6-e608a80dc3dmr1116394276.35.1740522325968;
        Tue, 25 Feb 2025 14:25:25 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:25 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 09/10] platform/x86: alienware-wmi-wmax: Add a DebugFS interface
Date: Tue, 25 Feb 2025 17:24:59 -0500
Message-ID: <20250225222500.23535-10-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225222500.23535-1-kuurtb@gmail.com>
References: <20250225222500.23535-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debugfs interface which exposes thermal private data.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../platform/x86/dell/alienware-wmi-wmax.c    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 64818efc3a1a..14faa6ee3e73 100644
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
@@ -18,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_profile.h>
 #include <linux/pm.h>
+#include <linux/seq_file.h>
 #include <linux/units.h>
 #include <linux/wmi.h>
 #include "alienware-wmi.h"
@@ -1216,6 +1218,94 @@ static int awcc_platform_profile_init(struct wmi_device *wdev)
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
+	struct awcc_fan_data *fan_data;
+	u8 bit;
+
+	seq_printf(seq, "Number of fans: %u\n", priv->fan_count);
+	seq_printf(seq, "Number of temperature sensors: %u\n\n", priv->temp_count);
+
+	for (u32 i = 0; i < priv->fan_count; i++) {
+		fan_data = priv->fan_data[i];
+
+		seq_printf(seq, "Fan %u:\n", i);
+		seq_printf(seq, "  ID: 0x%02x\n", fan_data->id);
+		seq_printf(seq, "  Related temperature sensors: ");
+		for_each_set_bit(bit, fan_data->related_temps, priv->temp_sensors_size)
+			seq_printf(seq, "0x%02x ", bit);
+		seq_puts(seq, "\n");
+	}
+
+	seq_puts(seq, "\n");
+
+	seq_printf(seq, "Temperature sensor IDs:\n");
+	for_each_set_bit(bit, priv->temp_sensors, priv->temp_sensors_size)
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
+
+	root = debugfs_create_dir("alienware-wmi", NULL);
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
@@ -1254,6 +1344,8 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
 			return ret;
 	}
 
+	awcc_debugfs_init(wdev);
+
 	return 0;
 }
 
-- 
2.48.1


