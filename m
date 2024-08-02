Return-Path: <linux-kernel+bounces-273168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC25946531
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980E01C20E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499D82486;
	Fri,  2 Aug 2024 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="akAds8UQ"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B81ABEC2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634945; cv=none; b=J3KrXSxzKMZHG+WXfeBpcpsBf83cVQGcwwLb7uupQMlnxKwhEeSx/CawynsHloXEXHRw0FTwKmf4TClg8NX/7YyGM96HFhEFnHSxFddSZ5GgRffLsQ1+teQ2Yz++XZ2CNwYgag7qm1x8FsZPVJMvjBUXcNL9vImQ3FbNHHVCVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634945; c=relaxed/simple;
	bh=dAObxfXKisvFAMk67xZCAZybDGU4uDZkiLoheq/j/Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMnl47hb5xfArFWsKqnGjQIx+LSBHM9MrE0j24+S9uvYcyLnlfaxt8zHnBUnXbSHMCS8SpGiye8VDo9BHGQvvkhRYkOQbpXd97jHnVxeHgvKbSmafTKSFJiOVNck/jVDy06G76rl7hUEqwj9N9n4j1fVI0s3QJPeUYllLmfwr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=akAds8UQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-656d8b346d2so5435001a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722634941; x=1723239741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNKtZ0KTw5GtPPNBJQf6DmjccyQlawY3aucAOEr0jBk=;
        b=akAds8UQv7cfGXx5p6913wJjOd3ngzHSVKIcrSCqvHg3RFsCxMNAcwtlLIx5InMb3A
         BIgRqmMYLJ6Bn/1L25Ah7ipD1MmW1LM3Floem903MVvuiyG/NsY5rlmGPKUVJUu3LLCn
         kHl1kZcpZVqkXLhmbKvA35AZo76LmwzVrAveMJ+qyFWSiG3W2lsmgCbFtxslLSAdn4eu
         wtGizQFDBAXC4skUqk0NiPIoTqTDV9QOMlOMy7A4p2eRF4TTy98VhZN5X2NhQA0QDawd
         WiDd2FNRHin88fZk0+yTLEFK1Tr3qCCznIGhRccWH962dTPuWcYc/sIABU5eVlZJp1hn
         0PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634941; x=1723239741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNKtZ0KTw5GtPPNBJQf6DmjccyQlawY3aucAOEr0jBk=;
        b=tHYB6mywJElJd80ROANeTVxKtfTn+4wb5oIldKBjBRsFCSqhDtvZAOLauoznzAsWiV
         RIBy3aYnLjCGEMXyU/HA0tngFExkeTcDkZkiqqe4M7nWlO6tTaTbrG9NDQFy0mXxv5nk
         u+huaw9WvHi9ngjYrkwaLA6gS8OymWVmgNMYovsKV6LYIHIUJfkzRve7xblNT3UwWAJm
         ympbOEJSJCJmgBQkG07C3Z2WqBOiAOP5J7h8Bo+CBFC+t5Z9A6JlGkqmal9Q33v3CiXL
         QvCUYEXxAhz6Xkz4ATYjLfA+uHdlFtPVXSMoECk6YItPF0zl9mlvLWQR7G1au8+4wjEV
         hN9g==
X-Forwarded-Encrypted: i=1; AJvYcCUx+RRt5rCdAAlf49SQfi4hMhW9OsshUuoBAnPJnEGCRGTrRPmcsoSiSsth+5ctVLkjU2wE8A3fTcr0HY+bTIhBGEIciXRSJAcLBmZs
X-Gm-Message-State: AOJu0YyVfTifm4rFO2h8ktdHs5biikZAkVARFD9AzmktAIzKYcLnCXqJ
	8ymrJ8I+VJe2HYp/Fem/hsuPMRjoNu2bjIRbPYBLuj2ll1G/e3QK1uuAVh8e49g=
X-Google-Smtp-Source: AGHT+IFIx2NnsHOvcE8wpLbwKKasLieneIaFU+PXOBrrI4w8dyWPBEXDA0ATCO8qJbdMOFAXHLqk6w==
X-Received: by 2002:a17:903:32c2:b0:1fd:6766:6848 with SMTP id d9443c01a7336-1ff57261aa8mr59603225ad.17.1722634941471;
        Fri, 02 Aug 2024 14:42:21 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058d03sm21910195ad.179.2024.08.02.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:42:21 -0700 (PDT)
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
Subject: [PATCH v3] firmware: ti_sci: add CPU latency constraint management
Date: Fri,  2 Aug 2024 14:42:20 -0700
Message-ID: <20240802214220.3472221-1-khilman@baylibre.com>
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

v2->v3: actually fixed silly compile error

v1->v2: fixed silly compile error

 drivers/firmware/ti_sci.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index c6544cc12417..097417526ff8 100644
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
@@ -3640,7 +3642,25 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
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
+		if (cpu_lat && (cpu_lat != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)) {
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
2.46.0


