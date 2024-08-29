Return-Path: <linux-kernel+bounces-307634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C428F96509D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879FD284A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F11BB68A;
	Thu, 29 Aug 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pyLnjCIe"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF61BA88F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962582; cv=none; b=AifXg9RQg3bkZ3JDHGsi/BmyYKUqj3pkCbcw6J6eO1vfjSThsQOulk38HRs/2DSYoKnRm9Rr/EPdMEuAp6ukzZJBly6VyTYycd2pO1+GArSEiD+qN0fb4WDGQNbzJbYX/1+KrDgU+J7C+XDbPwcWm4B91Zo/ghNRMQcwxOY0VJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962582; c=relaxed/simple;
	bh=A6Dz60AD+ga95ilNqCCxo3WOK2G69iNC5GdueqoGzbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMmkwNtyRrmNcTQECzyyKqkLt53og+w/2fpRbiEsQuMNnw6unPNJ+FfQk+CZ4Ie4irFoeRt+1Y9SiFgAWDMciMLPiDmmFbVCVVsUU+hWpb3q4U6WaVXM0D6HjpbEOsADPY7c+lmahd7zEHGQVfCrCCRJ2zD8X0F0YEELYLH3DFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pyLnjCIe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bb6d3e260so9424435e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724962579; x=1725567379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWfsv29r3VhWhUdf7/jPyF2un00LRMtxeQCEnGIAQLs=;
        b=pyLnjCIe79H6Ig4QaHUDFzQWwYkUfdHHFOl0kDN2nnVB6QGivk1sTg4FCmpEmBPJjG
         LczjcHzR9KdooMpndI44MCArQ6QmnZT9HUdBLaR6+hQIX+sd9oeRa5fZ76JalLB8QoMv
         P3/J/Eswed65VOdBE58N1tF5cAcj99LWkw6FnGGmHun5eZfsjfv3h5JAcjN1PW5h2Q9K
         NR2UpjUR3MQmHRufQmvnCyeEXTp1adpwda3SayTUHgaJR15u5fBOikmNL2qFGRrQ/hjm
         D3+MClQManRtnpOf539JUGWtPTL5+BGC8XNkjRhkDKtZkpBc13Qyb3mw5n+PjGhqNRjm
         WHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962579; x=1725567379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWfsv29r3VhWhUdf7/jPyF2un00LRMtxeQCEnGIAQLs=;
        b=l47fdVbYKVB0BfylBAE074AWI5mfmiZ70ot/cZG7xSOQaHwltNHlIXEsFZxb4dOK6X
         ZQVjZIr83ondJr1TxJFxt8y1fD+pySzHU8KDzX5m9FG+8+EydNqqUcqZO3CNZrUTivW5
         YrO+v5YhdTrvT8InW5LEwyvw8PgQTNSvMC4xnXnXmN9tLMjMeizeToIciBCr17DmGanC
         OJRRpDxh1VX51jfJhsVQSWt8FjgikNkYkaoP9GOMwAKz7TtAWXUqDKLBrVXft+lgai24
         8sDgAvjSecPDcAIHM0VsedPlr4H/iVaETmaveq/jRPjVXMhpH3GC5RNzbAqSCQPyPCzr
         3xQw==
X-Forwarded-Encrypted: i=1; AJvYcCWVn4xD8IBbB9os5p2jh8mQztGqIFlEuCTpw6V6pwHC8dy6k7Dwo6pE5ufBMZcu31SSTnPT2NW73ZvwHfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3w28Li5uXOX/+eFu3uf3tuIpXlHfq8rmy9CiQPUHUlAVyoeW
	gJCg0EpG5jvPw8F/RV0Kgtq02jI6eJKV4IeApLjAdDpTdcVRkS/nze946HHhzM4=
X-Google-Smtp-Source: AGHT+IENmqCm1q5qqRQc1yXcMb059f8u73uG8GUWYmbtJQbfirOWVwNs39SXI20l1WQ9ce5IcIBbGQ==
X-Received: by 2002:a05:600c:3b11:b0:426:6667:5c42 with SMTP id 5b1f17b1804b1-42bb023cdc0mr33044905e9.4.1724962578764;
        Thu, 29 Aug 2024 13:16:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:802f:3a47:b29:5530:28a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb303sm26681385e9.9.2024.08.29.13.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:16:18 -0700 (PDT)
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
Subject: [PATCH v11 4/4] firmware: ti_sci: add CPU latency constraint management
Date: Thu, 29 Aug 2024 22:16:05 +0200
Message-ID: <20240829201606.1407773-5-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829201606.1407773-1-msp@baylibre.com>
References: <20240829201606.1407773-1-msp@baylibre.com>
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
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8482b7077eef..d5d64e5ffbd7 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/bitmap.h>
+#include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/io.h>
@@ -20,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/property.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
@@ -3669,7 +3671,27 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 static int __maybe_unused ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
-	int ret;
+	struct device *cpu_dev, *cpu_dev_max = NULL;
+	s32 val, cpu_lat = 0;
+	int i, ret;
+
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+		for_each_possible_cpu(i) {
+			cpu_dev = get_cpu_device(i);
+			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
+			if (val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
+				cpu_lat = max(cpu_lat, val);
+				cpu_dev_max = cpu_dev;
+			}
+		}
+		if (cpu_dev_max) {
+			dev_dbg(cpu_dev_max, "%s: sending max CPU latency=%u\n", __func__, cpu_lat);
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


