Return-Path: <linux-kernel+bounces-273128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CBA9464CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834ED2838F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78B61FF0;
	Fri,  2 Aug 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s+lW2JtM"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB91ABEB9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632808; cv=none; b=jUmUEYozXA9TrYB+WhA2TFAojxRhSuTrl/jozz1N2UaT/6n+SiWFSUdi1QGe0cIaCUxH6A8qMTL/QwmcxmSAz2d7p+ZDSc9F3WEUAktL1V9q/YRuP1iygGHg0+6nFo0pMI68uQX428WyFpmzHdAuPAo/+nFELiitbmfXM7dTVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632808; c=relaxed/simple;
	bh=4swQTR/YoFXh0DTfU105oy5S2631ljGLMjlf6mgdfsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0aDZPCgWqz4E7R6xdPNfKGtZZne7Rkoyj9ig5XqIJGcfJ13LFJ5nTN2T1N9Cy/z4/O8QMhspFR/CAQBVDL6l7FgRFRIrRpNY86189NxqskGGLtakfePb2BapNIML640jIhnueD1J7OJbSLvNKvg3Wp2tUZmH0sXJicqNjqAV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s+lW2JtM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd70ba6a15so67565505ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722632803; x=1723237603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsPDBFDSDGtTL2KXQ6qVY7dOAW5W1axnv1PXbOxRfbg=;
        b=s+lW2JtM/E7JvAOKY/gB9QTE7ZCanqFvmQUT6z5TIm3duzavthvK51s5W+lMDSoSqR
         W2jXNRRPx5t8NNAjuZaITfl+F5oShO3VP+QTPVy39AwdzLud5YgmM3lkwXKAinZUcuCb
         UsRhMgyEhSHMVEDRgbF7YbyESZ61pAj6Yjy1MugNf46AFvCh+try3s0aLkpE8SqDx/86
         jW+BRRQ+1exvsLJy74bsLCP4EcvHZq93CArhps1RKZzqIy/Bpz19n9f605KIkSqCP1Q6
         wgPUGyeDFOZV0gYclEQ6jGF6/Et6oQR5WF09A6rv4Mmgv0Lg4tJNfLejjiDySQkJvaBN
         zjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632803; x=1723237603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsPDBFDSDGtTL2KXQ6qVY7dOAW5W1axnv1PXbOxRfbg=;
        b=pD2Cop/hQ5O5NaLRR98u4vPquE5yiJcChzGudTIhAKRnryjvcXrBgaBByHJgQaCd2I
         iYpsY2uR4lDGRwm1qyakFUcN9BATGrqwNw8Evv/tXw75agUaqhhUP8TO9Kosmbhkp2Ji
         b2EiUOoJIch8itiwz5rhdI1OHCEMvn6dsXIemdeykGWTeLgYepT5uKZ+wRDEfmZQT3tf
         HTyLY4zRTOMRlVyeQCNn1w9NQp0XuLEMklG69xYgfyacq45N7uk5gWcmCscPBgiLq8/e
         kt7z0sQbgfXnMrfzuNXDTQv5mrgMzaBUfv1EINHS8QEKhxLbI/6uLRcTUrvw1xp7GTwR
         4kZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+DAn59FlaYkrewD8Oq/MwbI3CBVnq2nYsIDwCfZkFcXzsfe4T7s6pIbtT+k14FevuHPq5D1a/cwz1l6gVqf26iz2ZUqVWiZ9VBIAm
X-Gm-Message-State: AOJu0YzJXJJWX7Gqwe0iBdUKai8UacyX87cioOAputugpxuIXm2XhRDo
	JB+uDqqWENoqxguLhTy0qFCH1eq2jFfUaymIeio9Pjh+u1tiunMgToWbiFt5ouc=
X-Google-Smtp-Source: AGHT+IEk+MyYQ3fBrl4l7itZmBATX+jOjtFMUtipugbS7KUgE3sPfKUT1apPEm7M18ZarXXll/qjRQ==
X-Received: by 2002:a17:902:ecd2:b0:1fd:93d2:fb94 with SMTP id d9443c01a7336-1ff573cc1f2mr58142545ad.48.1722632803561;
        Fri, 02 Aug 2024 14:06:43 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905c879sm21610365ad.148.2024.08.02.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:06:43 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Akashdeep Kaur <a-kaur@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Vibhore Vardhan <vibhore@ti.com>,
	Dhruva Gole <d-gole@ti.com>
Subject: [PATCH] firmware: ti_sci: add CPU latency constraint management
Date: Fri,  2 Aug 2024 14:06:42 -0700
Message-ID: <20240802210642.3366046-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During system-wide suspend, check if any of the CPUs have PM QoS
resume latency constraints set.  If so, set TI SCI constraint.

TI SCI has a single system-wide latency constraint, so use the max of
any of the CPU latencies as the system-wide value.

Note: DM firmware clears all constraints at resume time, so
constraints need to be checked/updated/sent at each system suspend.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Depends on the TI SCI series where support for the constraints APIs
are added:
https://lore.kernel.org/r/20240801195422.2296347-1-msp@baylibre.com

 drivers/firmware/ti_sci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index c6544cc12417..a141e07e7864 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/bitmap.h>
+#include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/io.h>
@@ -19,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/property.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
@@ -3640,8 +3642,26 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 static int ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
+	struct device *cpu_dev;
+	s32 val, cpu_lat = 0;
 	int ret;
 
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+		for_each_possible_cpu(i) {
+			cpu_dev = get_cpu_device(i);
+			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
+			if (val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
+				cpu_lat = max(cpu_lat, val);
+		}
+		if (cpu_lat && (cpu_lat != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)) {
+			dev_dbg(cpu_dev, "%s: sending max CPU latency=%u\n", __func__, cpu_lat);
+			ret = ti_sci_cmd_set_latency_constraint(&info->handle,
+								cpu_lat, TISCI_MSG_CONSTRAINT_SET);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = ti_sci_prepare_system_suspend(info);
 	if (ret)
 		return ret;
-- 
2.46.0


