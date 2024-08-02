Return-Path: <linux-kernel+bounces-273158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E94946509
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735462819F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A27D07D;
	Fri,  2 Aug 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xlUrkNWY"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E64130484
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634026; cv=none; b=mmP42mDTaxxhdwMY1H3CLNDN/C1E1AK91jamUT8YkmW/NWfBbOmEYDMxd0YQipe0xreiRZQCbNHgclgMuoubgByop9O/6f0xYjiqVyjrHsHgvdJJvf5yxRScWi7gRlteTrqgU42JBfT2ah8p0L6WB9O2TcqpN0WI3tLeVR82Suk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634026; c=relaxed/simple;
	bh=bAIqvgs1Ew3PEoplW5l5E2quPBV8GvZ5470qyDJM3EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgrfO6FkWeXmHi0awdLODLAYaGsPDvfNcJKPtIcC1bO/heOhj3aR8VLEfr1CFEsL4vUGjiDJcDGf449j3L6dN1FW8FYtfvUukMsGVj94F8oL65QRrvJURKBylQXbRG8iIEebbFOQL4LiUm/fdTgNBgsKhcajsjkGL7UmtJ5r7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xlUrkNWY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-71871d5e087so6540050a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722634024; x=1723238824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjd2Z3JManhntUqc1Oo4FhLNvn0xZqe3OfAIMPEAOhI=;
        b=xlUrkNWY89GE2XBNitucunV4q70YLJw6X5BMATWpiE6hkCF2VCEmpOSwYh2mppluIa
         K1VhMzJ5xyQfgbKXZHYrZwbjrNtdfKJpvgtAeEEvbUj/JU/9uGnOXjJ2DXh/XXAGls4V
         HsvNjlZBMADxGOtgomFh5OP9I9qU7wOb/VbxgaexEweETxl547xV2aGuDdaVbm30ivoM
         Ti/DFpMFy/AQu0x3oOiUMxyFpOKQ0PZOVp2mp0JkJkqG65WiT3lqqGPpxdv9Dfsn/t2l
         sUfAE1y6mtRlbCmmIQuIWswXuMH9IxFX11wQn/7M8Y3YUID+sASzul2CD9PyqDmTcQUX
         qJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634024; x=1723238824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bjd2Z3JManhntUqc1Oo4FhLNvn0xZqe3OfAIMPEAOhI=;
        b=a3SYWphDQV7Nez3/nPjhYi+msiN33GG7q3/mP/9NyrhjlgFn972wyijUB5hMJZRgFZ
         cGZbWTofnkh5Efm95Gqgz8fMZ8StpY4Co5oeepIj/3Mw/+KAzDhceorhMkN3lwhm2p2B
         fOA1rjYjnKLV+/SEEVj1a8vNy+CClYTq3jYZtlZfQd6Qmu4Ww1gbpNKV+sjZRTmgdAdr
         uYkfg8avAMx3VFXO/QY7A5XXqOATWvMI/OcnXD6kVlRMYnqQ3eCr+o0y6PHzTIelR9ry
         0EoCYqe1Luc8SqHZ8WQVKQn5jYYy//XyQCY8RG9+OuSo59aznaJMiFllKiPYjBO8af0b
         BDOA==
X-Forwarded-Encrypted: i=1; AJvYcCUqP/kvr72pg2+KJyq15CUvyIH9zLu/1vvrH/1oZJisEJdGwcjiKflspZE20lIKvn8MPrn1aJwt+3DTuCgfXNbnjfu6LysLTpNDjuZR
X-Gm-Message-State: AOJu0YzYWS9HsyA94vEyc6M5TtXlmbDu1fj1MH4vFGYJYa5/zzlu7e6O
	16FsBNylqc0DrsoD5fKIAO12/nc+46cgeu4FsMo56yDFGkYnPMYlffvtLENx5vgi9kpl9nofnrC
	4tf0=
X-Google-Smtp-Source: AGHT+IGNN0qRhHKclgcVNV7yOORGn4jJKrOIgaiVYQTCSA/yBx4CoN2NULxXVWodrCnPR87v8AcTTA==
X-Received: by 2002:a05:6a21:99aa:b0:1c1:31d0:c7a7 with SMTP id adf61e73a8af0-1c699580b18mr5852797637.16.1722634023687;
        Fri, 02 Aug 2024 14:27:03 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec5878asm1751640b3a.76.2024.08.02.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:27:03 -0700 (PDT)
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
Subject: [PATCH v2] firmware: ti_sci: add CPU latency constraint management
Date: Fri,  2 Aug 2024 14:27:02 -0700
Message-ID: <20240802212702.3424132-1-khilman@baylibre.com>
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

v1->v2: fixed silly compile error

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


