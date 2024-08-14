Return-Path: <linux-kernel+bounces-286773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9F951EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CF81F231C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD41B8E88;
	Wed, 14 Aug 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BE9AjM89"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045D1B5812
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650001; cv=none; b=mOyo5T47L7EzQIK5RXUncAaSAoHR7uzUMPnl2Bt4OaqsNnOppi1zP919/kDCFrevDIdDnxE84Zmr5nObfv5dBgCR4pCv1ih11d/CLIinuuinYFag6PV4blLEFhDGZAnQkNPZpoYjuo1YYTxXcGGrLdFypbomzw1ax/k53uVtqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650001; c=relaxed/simple;
	bh=KJIXodqaL/PlsDNGovQcl2iggmyHiixGfjVtxIDXn9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1Gco/WbIpyWSVKPkSl5WStg7R4ms7EpK7WegCg7ucIZ/aWE++7Gf/gy8RakGVYvzMfZ9ktwevCQH2gak5AcpwQtFCWWNhNDvF5VVadeN59Xvw6v4NOAEuB4ElWzmyyFxdvFIdza/vVk2jCMCZ89uoCyW0GlNBYDB3iwJ2xVuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BE9AjM89; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd70ba6a15so52935565ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723649998; x=1724254798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2mHcNudHQ2J7KK+PvZEplwN1eJNrfpSWSE1XYB762U=;
        b=BE9AjM8905Xmsonh7g6XGECRszAmTdTh7+JYHCY6iGtmQ3KQuxmohIAwJMth2gSuIi
         RCQQOiTlPeuTW/DBmOiU2x561DfNxTmVbtZV9r/Q5XAGR2wpgl3bJnvxf+Ok5h6XIIzk
         xtFjh5aAVxGXF+MxdtD//SZQNiK2VcrqBYKgmqmQ8sWYG2uFo1/WxADbf3+scWGr6SCS
         XjdB4bNojTn5qZju0Z3ddwytqF2M6NP50uywMYNrUNZQO73fvxweagoJGEaLhiiFVR3W
         R+sxPKo5/aaImenjTl8iDgdHmgoVBZkU1wG35QTVNTmq0X+P9imynxVZ+PPanNOmYqFl
         LOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649998; x=1724254798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2mHcNudHQ2J7KK+PvZEplwN1eJNrfpSWSE1XYB762U=;
        b=SkCa7hxhY4Py2lP6o0yA084UKKuKydrUbVgACqGSJuchuLeTGANqN0spSgGFjYQTJv
         vZdMS/vnPgZb9VA2m/zZlnpnxZ6an5b4LTmPLo1HZH1lvhU1kF/fiDPuyt5YO6YdI6mu
         dQ8oXNuc2VHM5CWHei8JTp029D85cYUmZKZSBXBsc8RBwtbk9KxPt90sicGYnMQLftxx
         rJl6fZhkC6sU5NFrqwOvPRfKpt1O0SrW4rOhN9jQuc/je3KGXqCDsKZU0cmCQtogR/AX
         DXoTRDiDN/BoAu8Kh5okIDETiuZe8ZtUS6lNS0uO/1ESLVnxMzLTfSx3KfQVVsMN1Pkl
         XwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzG51fCIW3dEXKCkUHbzvX0UVtdHQbbUfeI0AYEmk0n3dZ9WnVdbUIlvqLaILNboFLgDHQZDeWWiBkIf3xs1U51yTwFJDBhqZlbQ0d
X-Gm-Message-State: AOJu0YxdDNBaP7Ms6be75R8oQE4c7hR859iVL5202/Luqr+t7R8WbD6A
	OMqj2FvyuDfsJelDoXPQxTRUu9j0M3OPkTzsuJ9f2BI/wNfP4SlcLxlnlLHqs4k=
X-Google-Smtp-Source: AGHT+IFFuFlXHcCpgUXl2SWCuQLztcXNYrz5ohSNtrXnZ2RsGSm/ZnWNqQZ7tX0OfV01B0yJywvE6g==
X-Received: by 2002:a17:902:dac3:b0:1fd:6c5b:afbc with SMTP id d9443c01a7336-201d64b075amr39750105ad.49.1723649997979;
        Wed, 14 Aug 2024 08:39:57 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e2947sm30963465ad.306.2024.08.14.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:39:57 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Wed, 14 Aug 2024 08:39:31 -0700
Subject: [PATCH v10 4/4] firmware: ti_sci: add CPU latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-lpm-constraints-firmware-msp-v10-4-bee4314bbdc8@baylibre.com>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2353; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=KJIXodqaL/PlsDNGovQcl2iggmyHiixGfjVtxIDXn9g=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmvM/Io/sKs8c84RWhexj+Zi6QBwTej+YUooUjb
 s97x27p1lOJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrzPyAAKCRBZNxia0/vG
 Zbj3D/9C07sip72O4Z5THjZtYagRVIR6SubwIE6eJYGg/7jzPwBA/CNELi2giSqGsSVsRNCRF9r
 HUKM+fzJapObF5XTNoJYRD8KcxNhAvQdXZcB+y+29jcnrw2GPH6Go3+Rb1MDXkI288gXSbUolpW
 hKWU1bN1B894RlxHQJa9jvrs5DT00kZzF4xjM67h7q4aI1LE/tnuXCLtlG7llK/KImGUp297WhG
 YE26VWO9fTwOsboD9t/fsjRHH7rpw0wYJXKYi16Ei0kKC0kGPumYtSl64nqYkKnVUzGn2opz0w8
 7vJjKRGooIwZOdSRPY2EO2IgVqGssgm+8fDPOIdEBBTVgbfoukyrOBxXQGq8gdNqCt6YJ1jgaE7
 eY+qyjImHQYAScEa0JqRFYJvMgTebgsfY6K/fVs7AZ5ptN+iHGPXFUsHj58LeGg7suQSu8IrBBg
 ad4f9PiW8r194/lvYEqYlzPfIR070N3+wR+2IVjVEs1D/DNVmhVUfT/9T4mQCnymGwxtkDSPdh6
 tGQycTDPSs5rpyAs1Z7mZ71Li6g9YoQ2T1rasfUMxID2E1+zcUUBQ5ZJ9mtr3xP1TAGjxMiKkTV
 zgQ6+CMzN4iqW7naaYkBJeYsPl/eUjP76+jCqKWYUImnLSv2omR/KnZb31N1wnMEydl2HTenJ/+
 3wXwJlCd5vnMpeA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

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
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/firmware/ti_sci.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 107494406fa5..e0b11ca30af5 100644
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
@@ -3645,7 +3647,27 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 static int ti_sci_suspend(struct device *dev)
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
2.46.0


