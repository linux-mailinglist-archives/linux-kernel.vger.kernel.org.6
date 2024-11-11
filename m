Return-Path: <linux-kernel+bounces-403925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DB9C3CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87311F22645
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53501885B0;
	Mon, 11 Nov 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B3KgHnqQ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0D15B111
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323379; cv=none; b=MelZe9egBpk2YbH/9O2HtUB0sr7eqhOiBK6LK3TbTPGL/Ccpqj7O26l6y3NFHJZ/vCSP42s34h7qvt+io+vlpea16FIQfR3K1F66xmSFqGz+c/ayfccv3dPg5YjWeh8uDYaIebCQSwTrSV05CEEGjgktvAeXz3xp+KqSfE85MnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323379; c=relaxed/simple;
	bh=RnJDEX+e8M1SKac+t/KfkBTvvWb4921UTTN3vtqwVQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f8XYKLSd6gJ/DQpI+OEXuT4VV1/PO/bkaM5CWz87w1CC3fFM1ASGbcP7clmIEgYj7xakmc90mIbR9ORWxYXh5QFSUnVRtBZtYyXd6CdMSN/k6kB1NJPRQO8acufryNzK3FhAMj9EMUsrztvVkHEmPk8ecouPHNVNSF6o2cnZE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B3KgHnqQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314f38d274so55638765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731323373; x=1731928173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JeDyppQr/52qjjY/sVCNOM57E5CoacIekvSQbtIZVSg=;
        b=B3KgHnqQs+p/0LMwKC3jMWyFydFDy3rdC3ykAeXLSStgRaEQ3VGhk3wkf8fClNgQyA
         xO45mxH3z0hUbjI73Ln+7Nu3dHaoAsvV+ioIbSpLvOQzQ7W99HFglR+Dbr5uQrIjI8Ui
         PAV2kG37Qqqn8g9mQh5XackIPvqLOuKdlz0HEkELBImxlAtN7ZpTjHsSGnyx/h6ChMyd
         OgOpLzghVZhR0jpQYJCgFPaUYwCL+VzceoahY0ZO8RTSzJhH1ZF4xZe18yP9faFa1eV+
         J/YZwVfJw59wuBu8+J2wnCRcZy9tmiTn97Abcex5T0AAMf9mL+uuvAczlslmj0SUKUHu
         Cclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323373; x=1731928173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeDyppQr/52qjjY/sVCNOM57E5CoacIekvSQbtIZVSg=;
        b=ZX8tuYDvBZXDD7i7/Y5w4gFpg/SmvnEGOcWtsVELH0SCEa0mXaSA8f5Pus/dXgUcQW
         HI4FexMaP9vAKnIrWDGXIqc1woaEsnsCQLK+oVC5+5jYCNKYwAMmoZSeu97DBCY+lMth
         tRruV8BDwMx1jfaRMjkzyiTdrOEvfFr5P6xfQTo4NjHZv0zIwh8M8wnJeO4fBwrek2mC
         Cctl7oVdwWFoMdiT65ur+06gHBjNLlJmroVBAm49Rw3rXBqFsab1uXX2yhX1CkiyUJON
         scnC3W1Mu/mF0OakZjONxENTLYL+tkAft1IIbLqFY9ihyJcc57TmMX1HC+FNPt4zHONy
         u0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqope+r4BJfnECdp+No16kNn306RIY+4I6NSDa4ozTV85IZaFBTxANG8wTYBGBe6sUPTlv8+gccAwEzeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwweXyr/OsEbEz1Al9OBZgmJ7Xp2UdvsbsLQpwjJgR+xoi7BCb
	4xcBK30cD8xaGeGPtsG0B/lsKaeZw2cCo5CJWO6Ghd5EvtW67vopJ4osVlLje5g=
X-Google-Smtp-Source: AGHT+IGNNcgbDl4Gjze/hD2NJqFaWQ3onyE4s6CpeGAHpgde3gbIZHMy/7KJHU0Z+5MjV8yVvVXtrw==
X-Received: by 2002:a05:600c:190e:b0:431:5465:8072 with SMTP id 5b1f17b1804b1-432b751f555mr131405445e9.31.1731323373228;
        Mon, 11 Nov 2024 03:09:33 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e56sm213656485e9.2.2024.11.11.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:09:32 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] hwtracing: Switch back to struct platform_driver::remove()
Date: Mon, 11 Nov 2024 12:09:21 +0100
Message-ID: <20241111110922.334610-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9497; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=RnJDEX+e8M1SKac+t/KfkBTvvWb4921UTTN3vtqwVQI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnMeXicyreSYH3tGtlKi+QoIjeO7ZecvhVykXhv 5iZNPi4+9WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzHl4gAKCRCPgPtYfRL+ TlZvB/4ongM8ev2nzjBonTl6LHFPWH/dW4XaKq06lslOITmSCMFUOjyvunGbOsvH/We2gE0AReI rEgypT1beQyxxZtkHnX9B/KL0aMbsQ/z5z8K3wvwjs49X7vCfMg39GRSreQVaE6D2pAupua3NO5 gqAdIlK/B1ulQCbckqk/CoKbOOHzVNiKUXlKgycwXSL8Jexb6yfMFHGSdmT3siTzoFr7vHLQloJ NpOvGGa+h14rW1BOFTxpb229KI1mWdcmW/LXYeMn8ngNm0AmPELvuydGuMXhR3jENb4CvFYltg+ BevQ8rf5/OL4qFNtbN5ajj2T0fQi4T/95/gj6K36xXgaGD84
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/hwtracing to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Also adapt some whitespace to make indention consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/hwtracing. While I usually
prefer to do one logical change per patch, this seems to be
overengineering here as the individual changes are really trivial and
shouldn't be much in the way for stable backports. But I'll happily
split the patch if you prefer it split. Maybe split for coresight vs.
intel_th? Also if you object the indentation stuff, I can rework that.

This is based on today's next, if conflicts arise when you apply it at
some later time and don't want to resolve them, feel free to just drop
the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend. (Having said that, I
recommend b4 am -3 + git am -3 which should resolve most conflicts just
fine.)

Best regards
Uwe

 drivers/hwtracing/coresight/coresight-catu.c       | 2 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  | 2 +-
 drivers/hwtracing/coresight/coresight-dummy.c      | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
 drivers/hwtracing/coresight/coresight-funnel.c     | 2 +-
 drivers/hwtracing/coresight/coresight-replicator.c | 2 +-
 drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       | 4 ++--
 drivers/hwtracing/coresight/coresight-trbe.c       | 6 +++---
 drivers/hwtracing/coresight/ultrasoc-smb.c         | 2 +-
 drivers/hwtracing/intel_th/acpi.c                  | 2 +-
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index bfea880d6dfb..fe2412f83452 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -689,7 +689,7 @@ MODULE_DEVICE_TABLE(acpi, catu_acpi_ids);
 
 static struct platform_driver catu_platform_driver = {
 	.probe	= catu_platform_probe,
-	.remove_new = catu_platform_remove,
+	.remove	= catu_platform_remove,
 	.driver	= {
 		.name			= "coresight-catu-platform",
 		.acpi_match_table	= ACPI_PTR(catu_acpi_ids),
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 75962dae9aa1..3ac2b4a81694 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -763,7 +763,7 @@ static const struct dev_pm_ops debug_dev_pm_ops = {
 
 static struct platform_driver debug_platform_driver = {
 	.probe	= debug_platform_probe,
-	.remove_new = debug_platform_remove,
+	.remove	= debug_platform_remove,
 	.driver	= {
 		.name			= "coresight-debug-platform",
 		.acpi_match_table	= ACPI_PTR(debug_platform_ids),
diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
index bb85fa663ffc..fca219c0bba1 100644
--- a/drivers/hwtracing/coresight/coresight-dummy.c
+++ b/drivers/hwtracing/coresight/coresight-dummy.c
@@ -144,7 +144,7 @@ static const struct of_device_id dummy_match[] = {
 
 static struct platform_driver dummy_driver = {
 	.probe	= dummy_probe,
-	.remove_new = dummy_remove,
+	.remove	= dummy_remove,
 	.driver	= {
 		.name   = "coresight-dummy",
 		.of_match_table = dummy_match,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0..dd8c74f893db 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2399,7 +2399,7 @@ MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
 
 static struct platform_driver etm4_platform_driver = {
 	.probe		= etm4_probe_platform_dev,
-	.remove_new	= etm4_remove_platform_dev,
+	.remove		= etm4_remove_platform_dev,
 	.driver			= {
 		.name			= "coresight-etm4x",
 		.of_match_table		= etm4_sysreg_match,
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 5a819c8970fb..33efe1acbef7 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -377,7 +377,7 @@ MODULE_DEVICE_TABLE(acpi, funnel_acpi_ids);
 
 static struct platform_driver funnel_driver = {
 	.probe		= funnel_platform_probe,
-	.remove_new	= funnel_platform_remove,
+	.remove		= funnel_platform_remove,
 	.driver		= {
 		.name   = "coresight-funnel",
 		/* THIS_MODULE is taken care of by platform_driver_register() */
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 3e55be9c8418..0fba87de6d1a 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -389,7 +389,7 @@ MODULE_DEVICE_TABLE(acpi, replicator_acpi_ids);
 
 static struct platform_driver replicator_driver = {
 	.probe          = replicator_platform_probe,
-	.remove_new     = replicator_platform_remove,
+	.remove         = replicator_platform_remove,
 	.driver         = {
 		.name   = "coresight-replicator",
 		/* THIS_MODULE is taken care of by platform_driver_register() */
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index cb3e04755c99..93080849a1dc 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -1036,7 +1036,7 @@ MODULE_DEVICE_TABLE(acpi, stm_acpi_ids);
 
 static struct platform_driver stm_platform_driver = {
 	.probe	= stm_platform_probe,
-	.remove_new = stm_platform_remove,
+	.remove	= stm_platform_remove,
 	.driver	= {
 		.name			= "coresight-stm-platform",
 		.acpi_match_table	= ACPI_PTR(stm_acpi_ids),
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 3a482fd2cb22..45a94d5d995f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -730,7 +730,7 @@ MODULE_DEVICE_TABLE(acpi, tmc_acpi_ids);
 
 static struct platform_driver tmc_platform_driver = {
 	.probe	= tmc_platform_probe,
-	.remove_new = tmc_platform_remove,
+	.remove	= tmc_platform_remove,
 	.driver	= {
 		.name			= "coresight-tmc-platform",
 		.acpi_match_table	= ACPI_PTR(tmc_acpi_ids),
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b048e146fbb1..a7510122c6dd 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -307,8 +307,8 @@ MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
 
 static struct platform_driver tpiu_platform_driver = {
 	.probe	= tpiu_platform_probe,
-	.remove_new = tpiu_platform_remove,
-	.driver = {
+	.remove	= tpiu_platform_remove,
+	.driver	= {
 		.name			= "coresight-tpiu-platform",
 		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
 		.suppress_bind_attrs	= true,
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 96a32b213669..eca0801206ec 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1556,13 +1556,13 @@ MODULE_DEVICE_TABLE(platform, arm_trbe_acpi_match);
 
 static struct platform_driver arm_trbe_driver = {
 	.id_table = ACPI_PTR(arm_trbe_acpi_match),
-	.driver	= {
+	.driver = {
 		.name = DRVNAME,
 		.of_match_table = of_match_ptr(arm_trbe_of_match),
 		.suppress_bind_attrs = true,
 	},
-	.probe	= arm_trbe_device_probe,
-	.remove_new = arm_trbe_device_remove,
+	.probe = arm_trbe_device_probe,
+	.remove = arm_trbe_device_remove,
 };
 
 static int __init arm_trbe_init(void)
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index ef7f560f0ffa..dc3c9504dd7c 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -600,7 +600,7 @@ static struct platform_driver smb_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = smb_probe,
-	.remove_new = smb_remove,
+	.remove = smb_remove,
 };
 module_platform_driver(smb_driver);
 
diff --git a/drivers/hwtracing/intel_th/acpi.c b/drivers/hwtracing/intel_th/acpi.c
index 503620e9fd10..d229324978bd 100644
--- a/drivers/hwtracing/intel_th/acpi.c
+++ b/drivers/hwtracing/intel_th/acpi.c
@@ -69,7 +69,7 @@ static void intel_th_acpi_remove(struct platform_device *pdev)
 
 static struct platform_driver intel_th_acpi_driver = {
 	.probe		= intel_th_acpi_probe,
-	.remove_new	= intel_th_acpi_remove,
+	.remove		= intel_th_acpi_remove,
 	.driver		= {
 		.name			= DRIVER_NAME,
 		.acpi_match_table	= intel_th_acpi_ids,

base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
-- 
2.45.2


