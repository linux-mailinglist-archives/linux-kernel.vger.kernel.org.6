Return-Path: <linux-kernel+bounces-282256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEF194E161
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB18281CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097014C5A7;
	Sun, 11 Aug 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVKhOOBg"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF514AD17;
	Sun, 11 Aug 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382409; cv=none; b=oAhAs3S2gnnk0FpQxjNzqbV5pGG7OJTTP0rgNTlBn1hIiRKo3OLGN1SKUuLksqoDQU5ZjZPd8B+HKWvapjj3NMsEshMt4yyqNUfC94GDnA6oGimLaciCfwOcyUv3v3Ecsh2GZbby4gR2g/i3sOyP1e7h0ol98CxbhbCGGT0Y6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382409; c=relaxed/simple;
	bh=xlymcr2s7bHoejfCgSbWQ1ulppUX/pDDreFaRkEd+Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMTCFsiBQd+1vZ6jHg5lcAHwJGx9y/JUpynb80USG+DgXsB8rdGOXvsAcSe7K6ggdq+rEDzn30XQhh9snbd5oyGMXJUHYF2ELalM68s9eODsyg9HeB9SkpcJQzZoBoa8GfxZoaNmxFit2iTVVGpHVZIC8HSsmepwMX+6Ae6uWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVKhOOBg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3686b554cfcso1792103f8f.1;
        Sun, 11 Aug 2024 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723382406; x=1723987206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qSu+XYZvg8aJyxyPDl/Z4Lf7ilf3PAcS6FCJUdAgeQ=;
        b=TVKhOOBgLiwbKS0VIcNY5+oWsKw1UwVMdeoeBjAmmMXMObjLMNRTGceAD7icg2yfrm
         imoSU7RCWSM58yYaWbgLwv9pIcYow+2LYQ+s7R4gduoZ0hLYqVJXGuQ318JsPwFxUl3s
         o6Nnj/LZSyZGsRygyb3yYCN5DnONESH6oMVIKDIYWRTeTZ0n5Drj3hZbHTN0fM/24d5D
         joiWVlNptTc6I3xtvB76U2AZp6L0mhsyeRqeXGckfBTJcD7t7j7UoKySPPOTioCqZ5Kj
         Szkg5wmTEk6NP7ixc7QjTxR+n6bXMrwSEk/y63gePGpjfx0bKlcU6XlN8uZFJMIspSBx
         4hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382406; x=1723987206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qSu+XYZvg8aJyxyPDl/Z4Lf7ilf3PAcS6FCJUdAgeQ=;
        b=Kry5Q10Fu725XS2GV+lr9bDW3B4k2PzPdQn6XQQ3nB4xieQ8KvRE3YodWShT4qZh9C
         3u0Rz0t4QQ0QdStn0yzPdxUr4mNSZvTmZZfxZp/p1YbfK11bwgZyQ2M/6DgIgOUNn/ri
         KhWUZLx+9bVO3t8gIb0Eo6CEAJSNIhBne4WEJi5DuNwu9lrGDSmH7wGEVAom8ao8SBHH
         WRh0p0wQ4caJ8mno4mqHpG5zfz/9+zjvXH0wzT8ulw5JvX6+wwb/51qiSeBZmSkwzBvb
         8jBOxrQ8wyhsRflqRboQgKWjZ8pAz3T5oCyyw2w/dqBpvTOyQmGrLA6QFyNvtGc+2hFp
         wqkA==
X-Forwarded-Encrypted: i=1; AJvYcCUYvxcraGxvLtdVYIz+J7UxB/o6NQO3VpsbMLq5ppVGoQNA/vXmO99rlMSAXA1XX/35GvixiemIv9Ng4tSnfySFCgBhEXekHZK6k1/I
X-Gm-Message-State: AOJu0Yys/wpfsNr9nN9BRs6xNNQhWtj0AatNUA3154Pcdc54L9Vn5SIT
	klz3SysW7Sfnqjv20oVOfKEa320c6F4iHHQ17HS3CjV8ZSIV52Tg
X-Google-Smtp-Source: AGHT+IES4sHabdlnxp4TmPOTy+xX0s7CArdV8hK+q7UfvRwN0EZnzIoPMh7HMwR9+mPHklZFCimSJw==
X-Received: by 2002:a5d:6287:0:b0:367:8383:6305 with SMTP id ffacd0b85a97d-36d609268d5mr3507639f8f.55.1723382406186;
        Sun, 11 Aug 2024 06:20:06 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36b874sm4959680f8f.1.2024.08.11.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:20:05 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 5/5] platform/surface: aggregator_registry: Add support for Surface Laptop 6
Date: Sun, 11 Aug 2024 15:19:48 +0200
Message-ID: <20240811131948.261806-6-luzmaximilian@gmail.com>
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

Add SAM client device nodes for the Surface Laptop Studio 6 (SL6). The
SL6 is similar to the SL5, with the typical battery/AC, platform
profile, and HID nodes. It also has support for the newly supported fan
interface.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 4d3f5b3111ba..a23dff35f8ca 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -275,6 +275,22 @@ static const struct software_node *ssam_node_group_sl5[] = {
 	NULL,
 };
 
+/* Devices for Surface Laptop 6. */
+static const struct software_node *ssam_node_group_sl6[] = {
+	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_perf_profile_with_fan,
+	&ssam_node_tmp_sensors,
+	&ssam_node_fan_speed,
+	&ssam_node_hid_main_keyboard,
+	&ssam_node_hid_main_touchpad,
+	&ssam_node_hid_main_iid5,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_hid_sam_ucm_ucsi,
+	NULL,
+};
+
 /* Devices for Surface Laptop Studio 1. */
 static const struct software_node *ssam_node_group_sls1[] = {
 	&ssam_node_root,
@@ -410,6 +426,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop 5 */
 	{ "MSHW0350", (unsigned long)ssam_node_group_sl5 },
 
+	/* Surface Laptop 6 */
+	{ "MSHW0530", (unsigned long)ssam_node_group_sl6 },
+
 	/* Surface Laptop Go 1 */
 	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
 
-- 
2.46.0


