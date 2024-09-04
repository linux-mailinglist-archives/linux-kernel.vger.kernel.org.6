Return-Path: <linux-kernel+bounces-315862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD75A96C7CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F5E1F2678D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E31E8B7B;
	Wed,  4 Sep 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M8eAIlbe"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E91E765B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478961; cv=none; b=Dr09W1OlbfIj7wRrmgzpsD3GO7+vWt/v0lTo51Y1B7pllsmzJHJuKzS2/qnGODYRzTH/iITlNsogJGrhGPAURDDo0WkeemRngyuvuHnJkV7TIS1SRAY3Wta2RbvBLvX0dv6SHsD6ehOPaUK1OOPzTFJFxhBq8C2gcZW5Sij8v0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478961; c=relaxed/simple;
	bh=44BXOKXdLJCvEAVHyoVkeaamQ+iZvELFFR29PDD1dqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiWXK3zZ6ZBt3DnDMCLR/cWJD2hgzEb7f+iMA2c55jja0Zkl7YssINmJ2IjalnHnrdrT/yA6eeCTKqfjyIC7hEjJs1MBUTfAPKufTVQLgYASrDmlHL1OhHv0E03C8N+dz43dC6Sz3brl8qTdZ2+Y8Sj5ZpOQlvxNdNEvLSMaCRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M8eAIlbe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so878943f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725478958; x=1726083758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAYmMntq9XaKQNw9iaVuNGFPUV3MBScA2g35OLasFfE=;
        b=M8eAIlbeYRqMaO2kVJrXaAu17d87BQgZH0MLghmdEp3DQcjnOgDylVHjm+CuuViFEN
         PWi9dIoLiePZ8XPJLcQyneoaoIGc+qnddtFmUg/wF5dPwyZJNjwAeJMTtvj0F5BvOKkz
         Pa2XMxTsdbrrKh2qlqY2W5lFvFYt1Z/PnJ+h7XWrroH09gHHK/NnPO3TCwJZLUj8hgf8
         XviQjrkIEleJpsIltLVx12dXTHb2PngrOtkSLkEDXI6mJ6iGtqXybUMkde8gPUTpbBFk
         lOysqpa2BPPxsrSWI+mGHD05g2DuiMlQrEQbe2MLC4VaQsVET42MgirI0iI2J+Rtyaha
         w7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478958; x=1726083758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAYmMntq9XaKQNw9iaVuNGFPUV3MBScA2g35OLasFfE=;
        b=Av1fubMHBa831MK0GkDucFP1zSAdepoR7Ui5ReSXZmoRhHJ1bGiQ8SrCq2z/jolNWW
         HY/EF1qMdLMLgXnCx3OtKHb6jYClfO0kYbd8yirSaA/kwNz1csco2bE7i0T5mC5+0Yju
         pMHo1gifzEEVzqYPS9Jm9ci++S/5V46SVuqKm/VYGHfSHQVRxy7FJNCKUpidYp7zJwra
         pkrvmkiCphAnziGpN69xLORbH93O8b/3MKCEdJCUCnuVudM8TZsGDpdi3LzD0aqT5Tg1
         h1OAdvHmBlljlSKyjoYwAMhCPtklOXPuiZXohJq3I59IbtgpYBbjq6Rshe08/8M9xo+Z
         4PjA==
X-Forwarded-Encrypted: i=1; AJvYcCWOqjcbXEXr+HBwBUsvm7xBcrXyeH7jhNLhqb9JlfHctHLlbNDLfvS1kbfi/Fg6d9onaF3wf6v2HUplYQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZR7r9laNjF/uq4ATs3ktOtvSBH8rowJj3txTrPQi7mRz3YGB
	7GMj9h56tFSizTgT/f5IckFSXSYAUyytv7iNi1genEoFZhvaPg4/+otcnpSb5us=
X-Google-Smtp-Source: AGHT+IGeFXrS58iTnxiUV2gfQpUIo7icIwItZKonDh8l22+eulPfWMGweBZRMCoRGHziEWki1lzwLA==
X-Received: by 2002:adf:fa81:0:b0:371:8763:763c with SMTP id ffacd0b85a97d-3776f92935dmr2665282f8f.33.1725478957588;
        Wed, 04 Sep 2024 12:42:37 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c03595fcsm12473625f8f.98.2024.09.04.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:42:37 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v12 5/5] firmware: ti_sci: add CPU latency constraint management
Date: Wed,  4 Sep 2024 21:42:29 +0200
Message-ID: <20240904194229.109886-6-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904194229.109886-1-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
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
index e0018d3e2df8..be02a923f7c6 100644
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
@@ -3668,7 +3670,27 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
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


