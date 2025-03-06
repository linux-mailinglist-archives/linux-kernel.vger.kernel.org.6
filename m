Return-Path: <linux-kernel+bounces-548073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4EA53F84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F517166983
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87612D1F1;
	Thu,  6 Mar 2025 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgXwcB4+"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3E1591E3;
	Thu,  6 Mar 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222705; cv=none; b=CXW42rzwjodrSbNaulQOShvLeP/ijFHVAnpjjiPGkBaxyUIZy3kMri1VUCYHs3RfDoLmEVEeZ7Tr6kZkNnS3snie/hkZl3hAgQkn9tLMq31YxIqaac2dgqg9+ThbljhTFIMPjpP2dN+gFa9a3/RZMlYCu7CIGWyyghRQ/1sc0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222705; c=relaxed/simple;
	bh=chp/F8Y6++Gx+STgHaqN3GAqSE8+yKLRRtC/dnQoEf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcWHRY6XWWmVeefkCh0Qlzo3uxaifcLL87QtnWeXrhaCn7CqEfYCm7w57pUKJGtbUMmdLmwdMP8hPAJrd/nV5aDTcbZ/L16ZSC1eDeJDxuY+wrEqFOn8gXYwq+cW0ZqYTrmCmYOIk9zelUMkWqbePbELFcyIC98cO1PpRM1YCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgXwcB4+; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523b8881d31so42653e0c.2;
        Wed, 05 Mar 2025 16:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222702; x=1741827502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TI0lDHvpkiROiD8ucwvU9Fu6HnI1c33Ny10vRXqT7Qo=;
        b=QgXwcB4+CPv5xKeJ6Z9+8QTdz0qgKSxk8xoEW/VDzySH5FbaVfKr/Rws+W8nvwItix
         vh7TYK01iT73UJ9GzzUkMP8shbuNl8jM1Gl/8McWePwnMX/zMH5HZE+4PdFD55bsEYJN
         m1sipeyypZxPl1dydMLNdvH9aUMiURa1sAkQYKiB56Dc3RupTNpQGKkIneJ2BUUNX+mG
         +a0ZSNoF9iYa4t2OjbTyiFa/pbhcLFknt6K+7Q6C8i047k2hH5/nZOBBsQVxUF8moJGN
         mrF6mTyly0IqAmSMhlxyhx8LQtu3GzYvC3x4/QndikAU5GQzHA51kpQFDg9fIrqW0ozm
         N2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222702; x=1741827502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI0lDHvpkiROiD8ucwvU9Fu6HnI1c33Ny10vRXqT7Qo=;
        b=JGYTcGvqh+ppET9Frg5TQUg/8BK+ZSG1HYNyjzQwzHgd73hxfB2lJIpm7H4Q42NCP/
         Xf2kddfuqtz86Wo7VqXeRNiTi06x2S8NHsJaRSrKAaO2ZImxMrdJ4NQUUpy59usqtCpD
         nwSsTAMI7f5qTimRLGhoUUFuMdxP7cSSN/SlME3OagCvB748hYvTkph6h9xO68msl9fx
         wsYuhjobw4CqURfOluJqyseHSX650jytL/H9ZpOwAwf8O17uboEdC3hGhiiiyLzi2hg6
         hGKxlIZoRjvoWksrCq8VESQrh6SrSoNGqNA3cHM//y2iwSvcqzR2gEBHiEZ2xfnYGy8h
         4Ytg==
X-Forwarded-Encrypted: i=1; AJvYcCUgOtAGQ/EPtEyZvgnGERkvJ5XYbA8PPI4BYavMno8ebzT7rGzRuVqdoM/ME/xS5ckKFCwEKjKrg83uN9jYbWG/28g8EA==@vger.kernel.org, AJvYcCUtuHlAzQIepBvyDQpZ9nWLmeLamSjc2+hYNbrqgg+uol9j6B3y7Jz9v0BVCe52XJk1dTng7EE9nJiEFIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIuahwaEOP86dVlXzKATlxwnQywT6t0ojci8XjF/ckU3ph8f5
	f/aKmuSD8HRKal597130ZJYasVmzEaVER6yM4mqdrBYORu9/JjlN
X-Gm-Gg: ASbGnculDotvdyqLdklvD9Y+r9XArDfbn5aj83nl1Vc/1b/17ylFyYr71fe/oPGyCyc
	A1eVboCGT6x+apRCPGyJY70CD8lFd2Kya5Eku6V6aIMSFEFYbNe0QGvDw/KHscJqf+rhWt0CJga
	fZV+H1OArDlFAMS8/hlSRGFuqKLp+DMEj7BqLQZfC2Kz+5K3EM0iMVIX+resVJKHfSOMEX+HkxS
	mA5bupaBTJO6tCdmueTSh9LAYHNkPTtK6ZJBLj6Qj9ptE3PmZBt0GsNhT+51Z/1+Q72dloZKxIl
	W1hWSOMPggYN9H9J0hlbAhcnQRCW3wbIx4pWqpPVRUyi1Q==
X-Google-Smtp-Source: AGHT+IHSP/wPQY1MOgpK6eN2qRWvOtKdySUE6FO2WSm3x2YJ+60ZsvqRdTYqhblt2l4T3wT4bSkj6Q==
X-Received: by 2002:a05:6122:3208:b0:520:6773:e5bf with SMTP id 71dfb90a1353d-523c611e608mr3202308e0c.1.1741222702505;
        Wed, 05 Mar 2025 16:58:22 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:22 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:57:00 -0500
Subject: [PATCH v3 09/10] platform/x86: alienware-wmi-wmax: Add a DebugFS
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-9-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add a debugfs interface which exposes thermal private data.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 92 ++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index de4e8f177aadc9552b05cc732e41ee458b761143..23f8680a212fb9ef2a6f23aafcc2d25738ae4364 100644
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
@@ -1343,6 +1345,94 @@ static int awcc_platform_profile_init(struct wmi_device *wdev)
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
@@ -1381,6 +1471,8 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
 			return ret;
 	}
 
+	awcc_debugfs_init(wdev);
+
 	return 0;
 }
 

-- 
2.48.1


