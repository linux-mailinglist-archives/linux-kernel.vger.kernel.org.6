Return-Path: <linux-kernel+bounces-559703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E062A5F85C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411D63B2AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A322686AD;
	Thu, 13 Mar 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi55fLzQ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA82698BC;
	Thu, 13 Mar 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876234; cv=none; b=WzqbI19xhOZS5GX4Pf0MGNoI9BLGu3dAAI0LbwMWOQNbHB/FcD87BTYsqhgtlrNebS0cEUVhjicFONMFi6o8DHEh2fb7TzcTNAansTJU60soGYIe8eWj/aJ5jnyAljDF492tlbVdBZmq8Wt25cbZHIyViV0Q9gf/lvCTldCrCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876234; c=relaxed/simple;
	bh=ZvzPBd7CyT6TPutX3RzSw4oI/HMVtgz3XsoaM+0Sm3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5ZRLv7ezWwy5DCJLJSQRH4p1u866xmkqR2ksLrQH3yXaze06ZdeBRaiboKlzpNvKvszSkBpeTvYZwvsMBUi0T0TkDhjzPFrvBvYU1+4CBQMdXLr98wL5sSfk/h7lW0p7qSfBCdy2tZBimlGypGysMUm8sLN39HAjrMBSY5NJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi55fLzQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff07872097so8872067b3.3;
        Thu, 13 Mar 2025 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876231; x=1742481031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CvqXIK1HKLafOhJzmaRIgOV23DcLfPOQLHCwOVZEuM=;
        b=Fi55fLzQw3PkaHSLR/R0llBzPg3cq1i4e6YVv+ieiqUp8naVUrRMfV0pSzc2VdbDlr
         m7EQrAvHAyE0id9c2nfluBqcwzp2Q7wKcQkugOgyPyKODU2WTt7ugdKHG1Fa53zcDjo0
         BPpyNzVmqYf8aQooKZ9+cza0gK3jDZcS5AbOEc6nGH5YknEw/K3o3RR9riAjm4XvlKRU
         yYn4Qv4etTeQm3G1gSYyBkbhf7a+FS1VNZ3dC6sOpuvyU1XKxiMXrl3piCKNqWgzQgtT
         ZhYenhE9pEKzVs3H/TwpJTJcIhHGgt8Bho+tBUtrW2KezlAlX5o+w4tiiKXvUcfqOWXv
         fHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876231; x=1742481031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CvqXIK1HKLafOhJzmaRIgOV23DcLfPOQLHCwOVZEuM=;
        b=R/ykmoG4MiNE/uEthEoJTiHHdRncrShED6PIg2b/TT4ZE+L8oGy+gT/wqTrOAslYDl
         icIoRvr71wDb5frSK7FZbJamJodHRKV2meojInH9RMFRMLZAxXEpAvz3Hy+UEXKHhC/+
         UKe0zZGap6UnwvyseQY3hSS9ZqRLG0NkgPbJSKUyLhk1vnpI73I4rYGGsKZiZ0ZBcbWJ
         CRYPf0wUM4NatmjvmNK/hNYVA7dbU20PGYQqJstkjjPrLPRN09LXegz6D+Kca8NFnXwI
         fybD7eF9Oc7cv5OrKrHwpXR2XvKpuWkmptKt5eML4FDc8lweu2lJEBuQsb3sV1WtrIq3
         Dv0g==
X-Forwarded-Encrypted: i=1; AJvYcCUsx+oGKfwk7w9/jUxRORhbqgWzFSTcOW3Ts1L1YK0YgaQEFsc/SaCCRM6cyYPhmPu3iEfkYsWWqmpgKYCYlQC0vOFfCQ==@vger.kernel.org, AJvYcCXjinesk/jhwaFQTxsmMKCx6Bw3oU2LME6E0wlpOKD5xsmrEK84jpMKzUoIMDOG0zwGZAWy1sdHDhHUMpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GGxmKweznzIL9MUhdkCZ26iWEtpHIzP03O4KoJYQzMw/r1oC
	S+hLm8e4dKJyyrtY4UGKRllV+p63iWrSBcCfsyQybhhlJCWnTxTpl+HhUTvZ
X-Gm-Gg: ASbGncuVCdryECmgTD4OtsmTI3i3qBBCKN6kqT+DFmqlIUc0Px5ky9YxCVO6I3/8F0B
	ttoG0TASdgx69liWXcHuDs0zrnLQlVGFYzBy7iRKHGwsJtRzQz5g0RY50nfEagZ4HqKsz8CAv8A
	VHr/XcGA0e8O5arK1J6xYR7mealQzn4bTNfbRUVxws7duLDfyWiT0EGvB7kl1jnlFZUZh2fo4Q9
	NsTnBH0zgy+JLHEOv4UsRbF9IVgrpL1/32NMnDCXpmJfEGvH3bzo8uB0ThHKeKG2x40mb20odfA
	iLS27nVgJ5mWkzH5wIObvyEljtNR15YK5YUmzgcftfBQuQ==
X-Google-Smtp-Source: AGHT+IECycEP6tdbMhuIwGBhPz887Ioicikyg6JsVvULRdpINQCWyhCrxMomdvFfI1YbiSoFyRSL9w==
X-Received: by 2002:a05:6902:3101:b0:e5d:ddd2:8acf with SMTP id 3f1490d57ef6-e635c1d966bmr26174905276.38.1741876230964;
        Thu, 13 Mar 2025 07:30:30 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:30 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:30:04 -0500
Subject: [PATCH v6 09/12] platform/x86: alienware-wmi-wmax: Add a DebugFS
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-9-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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
index 823b579260555085ef6ac793b806738a756bb9da..472e6289fec5be0db0a5cb8e76718b750fa558b5 100644
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


