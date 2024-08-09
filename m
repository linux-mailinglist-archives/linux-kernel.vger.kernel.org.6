Return-Path: <linux-kernel+bounces-280991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54294D1AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6874A1F24D4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE070197A9B;
	Fri,  9 Aug 2024 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OtU+fIZx"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35494197A65
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211648; cv=none; b=IhD0UjsV0J9Zp8EngBlvkBW6OMwvkKi03uvkS5czaWtFtdv0SsrWA4fVJKNDqo5fXfqTLTAgunYGygR4PoSKqXk8N4JsVRSRIJhOdiaMoBesdBcU4HbCDkbq9LGymJs755WQvYrStGOTOhlTgnO1BVrAZLovn14ZNkOAovjukFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211648; c=relaxed/simple;
	bh=GQXQ8wVFOUDUI+Zyz/HLa/N07Vz10zEEqMoocpvUBqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJfjKQN9c/lZ8tvtbXRXOdmezg7OUPeVnSaHkX4Um0+7ygITBi5EgxxSUzwGVGSbFco5NQ9XCEpIFXwif6eInlmWMLihJUdTlOx6dOnD3g7CvRA6J8mvo4LQu6sqtQ53EmrrOSarzVNLSQvhnWMDE2+bYnMx90qQAoU1G8/OcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OtU+fIZx; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093efbade6so1336326a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723211646; x=1723816446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcd0Lyz5JwSqZfd6Y5W712pL2iousIM4OAnnr2KOowM=;
        b=OtU+fIZxBNEP6b+19k7weAy8xF0bU1m/nflzJGtjJ3VWGDnLJJKrcscX1h9GJbY9Bt
         creJlbCqtt6Je49JDoXzbamMdc6g40AcjSDvkBKzpmhH/7eagKAuSyLJ2gbPX0H04aci
         XaG+MDDYMMM8Jr8NB+dvGiBkfww1p0XtWGjbbF8OLJWf5Lf51D11Ni4wkFE1T02/Pibz
         tmFnciBDhSDUtbAjxl82VvIcT+MsVuYIvRf0TmRqDWbGrFAbGXGB3EZ9IaqOwMM06RPB
         B1LsXpzhmijiNU9ozwzlN3BMB1vxmVg6Ra2k6ELrfyt2LWun1MbzvJTtAnMgP2M4zsGn
         YY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211646; x=1723816446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcd0Lyz5JwSqZfd6Y5W712pL2iousIM4OAnnr2KOowM=;
        b=oP1ns3j7lqk3cRamUcpU+0z0Fw5b9K6Y0gNd/QW12ea3hhayQTfethgtEQtEnEuoy6
         iLGz1kmBd5F+NmJ+A0rgLGGfUjh8k5nzb+En2KRVobKHplu1TfpoFIdZi7SObxoP62T8
         ItOSP9D4ion+w5poxPhsxXmGke3ColiXwiPby/QjcnC1mXsxO/fUkbbpAc/SxlB74/Lk
         aOKTdRQVu5RuE59ZHYsPJYUjCzmlESQSasCPN8jyHB2KDVNO9oRvI8znIiGqXVUrX3gj
         KOP+7Ws6FzxQl3yIi+MvuCnXWJPCFqAmlG1lnKQ4wrKYKlv9u+r0iiSDVCH70mvvxy6O
         hcEg==
X-Forwarded-Encrypted: i=1; AJvYcCUzjHHgrX+YvaArqttpysIWbg5Ie9hMQqMZK2Ib8Hqx1CNn5Qrz6sxukza5s5x3SshwyLu8vLytZB9jFsGOBzP8m9CaaikRsCLRp41T
X-Gm-Message-State: AOJu0Yy9NwTXRz6iwVJPaVR/qMBLJ1o7uTNvFUVIOmzeLJN2l7aZaMvl
	JY75mRyDpvw3QHBVEooz4ARsfpB10R6zwsDHXVrPTJquMrpKTyL01nnb9wY7iik=
X-Google-Smtp-Source: AGHT+IGxziKJpCJ3mF7dRPKIDKXl3jdK0ixQw2TmnjOWrBNN31EoWUD8HkNBvokPEvqccdQBDsGsUQ==
X-Received: by 2002:a05:6830:620f:b0:70b:2aaa:4bd4 with SMTP id 46e09a7af769-70b747318cdmr2155508a34.19.1723211646327;
        Fri, 09 Aug 2024 06:54:06 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a2728bsm4158640173.103.2024.08.09.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:54:05 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v9 4/4] firmware: ti_sci: add CPU latency constraint management
Date: Fri,  9 Aug 2024 15:53:47 +0200
Message-ID: <20240809135347.2112634-5-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809135347.2112634-1-msp@baylibre.com>
References: <20240809135347.2112634-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Hilman <khilman@baylibre.com>

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
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 5cbeca5df313..481b7649fde1 100644
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
@@ -3639,7 +3641,25 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 static int ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
-	int ret;
+	struct device *cpu_dev;
+	s32 val, cpu_lat = 0;
+	int i, ret;
+
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+		for_each_possible_cpu(i) {
+			cpu_dev = get_cpu_device(i);
+			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
+			if (val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
+				cpu_lat = max(cpu_lat, val);
+		}
+		if (cpu_lat && cpu_lat != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
+			dev_dbg(cpu_dev, "%s: sending max CPU latency=%u\n", __func__, cpu_lat);
+			ret = ti_sci_cmd_set_latency_constraint(&info->handle,
+								cpu_lat, TISCI_MSG_CONSTRAINT_SET);
+			if (ret)
+				return ret;
+		}
+	}
 
 	ret = ti_sci_prepare_system_suspend(info);
 	if (ret)
-- 
2.45.2


