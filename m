Return-Path: <linux-kernel+bounces-282254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C894E15D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824E31F21392
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ADA19478;
	Sun, 11 Aug 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ6Ij/4f"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578D148FF7;
	Sun, 11 Aug 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382406; cv=none; b=e4sSgyjC8MpZXJ0XLJgkxmAMjDj20Fz7beN7fqNdvttMiLz2bMqN3iw6fuA7uEEjdrcYoTmiO22qjOPjtb5QhdIosqxY2YOVVRZJSniEWMnooYVWypMwOZeyto3HNaq66HK2RdGrU/ZX+almKuL2BhMFyC9mjwp6xIV16pjKfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382406; c=relaxed/simple;
	bh=zjEvzHfdpu7yRo881pt5hR5cjEakgFaYtnnkEIEwSd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICKgcHr4GbuwnUTyfb0NqufHkjn7ImbOcAM6xIi4uocRg5BTPhxedK/9hy5E4JKk1Rjq9QIQp8AnVCDkamkAsq3epShbKYT5gpfiuVC6UnpAViRUkvkWNw/IX9yicZLjmhBwVOl0gl7XVIyvuWJ7BG2B9cZqiIkb679aSGf7trQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ6Ij/4f; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so24198715e9.2;
        Sun, 11 Aug 2024 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723382403; x=1723987203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES++erLf7p9IX7hRLAGApIRVbxemIHSDx7uSblDCG1Y=;
        b=WJ6Ij/4f5jxgeb+24K1TJZv5E2Y5PUExwkTHYzFHd2XH0mT5gEPZqkzLcQ8AwYgXpu
         5aXyX8oJd7VaWi9HnKfa4N+lSPzkTBx1jCvdxkuYJAVybmymSHffaRDtHzgEKmWAEJDD
         pbvVhnG3Lw7rSrOzTsZib1ewF8qZip0v/bpNltDYlpEU6u6V1h386dbWKmCw+9Ta5um4
         mX79GTC9RWrfhdswWXs+mLmHDWuFnHS9hfOklZtm367hrupTTrLQYU38qP+iDopHgZxh
         T+CzGuK0s8EqGNsZ5RxGVOkW9UW5nUyiXPWArzrqPQzm3+evo5DxkkZd90RtiJ+H94Qd
         j4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382403; x=1723987203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES++erLf7p9IX7hRLAGApIRVbxemIHSDx7uSblDCG1Y=;
        b=EVjyqAkpWKRXoFrhqPuXcowKCnDShBiiM183KVK0lPWFngP4CgLccEDs0htJT1PbyT
         tBWJkQ4agA+O260PE78L4k4nxJQFYj95KjYagJfbhdCCnRQwBg6aizZl7zhRS6/MxXC2
         HtsptjDHRUY+rdTBVFo5m9MUhdLzkFyeQ5NpcDmbYFN7lsCPrQd5P75vDpfKqL7vVoV4
         KMsKmbwsm5VVdMz8Kmw16JWWJX15NtYZRTiEOQ1YkOrWhMYOCcFV7K6Oiep1qEw8tI6Y
         DrxrRqFp085SzOM3y7aqKRK3P4f2sWgSdNBeGFxW2M7C0mDZWEtRGhjQKVqg0uudca+C
         x8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6HzAYGg+CGQXzR5O+1bs/HxBmfRE3xAzWOYtAoxZ07pmU3WxOj/qMuFylQUmiMtYwvbCOpYghRCKddJQ69OW0J4shDHo3bSEnuPY1
X-Gm-Message-State: AOJu0YwMF+qxs5f0i87w2GKFiSCulGADfIcxb+oFPqCCsVQwqkIfx/mo
	smDPzerOJ6tG4HIGqdNuDR4cCjia8Cd7a+rhR/nrHkSZYZI4vNfM
X-Google-Smtp-Source: AGHT+IFN34tnPXeI0Atz6UZT6OByelPTkY9oz+5E0pDYEDPXN/k3VF9WRalm7I6ZMrg+TB2o6hEjfQ==
X-Received: by 2002:a05:600c:19c9:b0:428:e09d:3c with SMTP id 5b1f17b1804b1-429c3a56a67mr45079475e9.33.1723382403200;
        Sun, 11 Aug 2024 06:20:03 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36b874sm4959680f8f.1.2024.08.11.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:20:02 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 3/5] platform/surface: aggregator_registry: Add support for Surface Laptop Studio 2
Date: Sun, 11 Aug 2024 15:19:46 +0200
Message-ID: <20240811131948.261806-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240811131948.261806-1-luzmaximilian@gmail.com>
References: <20240811131948.261806-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SAM client device nodes for the Surface Laptop Studio 2 (SLS2). The
SLS2 is quite similar to the SLS1, but it does not provide the touchpad
as a SAM-HID device. Therefore, add a new node group for the SLS2 and
update the comments accordingly. In addition, it uses the new fan
control interface.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 4d36810c2308..892ba9549f6a 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -273,8 +273,8 @@ static const struct software_node *ssam_node_group_sl5[] = {
 	NULL,
 };
 
-/* Devices for Surface Laptop Studio. */
-static const struct software_node *ssam_node_group_sls[] = {
+/* Devices for Surface Laptop Studio 1. */
+static const struct software_node *ssam_node_group_sls1[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
@@ -289,6 +289,22 @@ static const struct software_node *ssam_node_group_sls[] = {
 	NULL,
 };
 
+/* Devices for Surface Laptop Studio 2. */
+static const struct software_node *ssam_node_group_sls2[] = {
+	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_perf_profile_with_fan,
+	&ssam_node_tmp_sensors,
+	&ssam_node_fan_speed,
+	&ssam_node_pos_tablet_switch,
+	&ssam_node_hid_sam_keyboard,
+	&ssam_node_hid_sam_penstash,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_hid_sam_ucm_ucsi,
+	NULL,
+};
+
 /* Devices for Surface Laptop Go. */
 static const struct software_node *ssam_node_group_slg1[] = {
 	&ssam_node_root,
@@ -401,8 +417,11 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop Go 3 */
 	{ "MSHW0440", (unsigned long)ssam_node_group_slg1 },
 
-	/* Surface Laptop Studio */
-	{ "MSHW0123", (unsigned long)ssam_node_group_sls },
+	/* Surface Laptop Studio 1 */
+	{ "MSHW0123", (unsigned long)ssam_node_group_sls1 },
+
+	/* Surface Laptop Studio 2 */
+	{ "MSHW0360", (unsigned long)ssam_node_group_sls2 },
 
 	{ },
 };
-- 
2.46.0


