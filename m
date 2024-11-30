Return-Path: <linux-kernel+bounces-426227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B499DF08C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A83281422
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F81993B7;
	Sat, 30 Nov 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeKZHEE0"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B401145B10;
	Sat, 30 Nov 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973933; cv=none; b=PqeFfyAehVlU/M4kC22lDko4PncmlN2mFVlJSq93Pmbfs5Xirt3jFf/7EWN7acEHP3nJe1Ntg0dbw/meVcLKF3NBg3UViXOSgxc8ywFOndNVZ+TTtclv1xdEIXBd8mLklemY2rFpffqXhR1pxMwhhMsKNXdtXPrPVjLrFxy1lb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973933; c=relaxed/simple;
	bh=bUI1N88P7xCbhKkol6eoEsKyp4u4uzfpvzMUgzX9GuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQlNxpJ0/3Gck30I8t6Og6bgLXBfH5mdTeao+PBGjFMi/D1MFaa7fElY/HJD/GONnIprNjEiVid0DbgWoJzKWnGNWCpKHUCbp53vbZB2lQYNIUxkgm3AnejORrOrJOGrl7v0rycGYPKfUnADm0axSTZyCt9qbGLl2UfW6fDoiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeKZHEE0; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2155e9dcbe7so4114595ad.3;
        Sat, 30 Nov 2024 05:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732973930; x=1733578730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WdudPSttzD3lDEy6mYrl4aEv9XWR7fCdViuLxOP5ZE=;
        b=OeKZHEE0x75ONA86kDhxSrEQP3S1753V7DhUnIi8wRVwEclqForWixsuECnhsKitJi
         kJxX/d066QOpU2rGV8PRGS+Er+Ma6oLaNxGDfm/nuS7ZTuGxDntDtsnrKQd7mmuiDNbA
         WdP7U+qBHjLV2may2KrH+4tOhV9K9N4kocWk6s/9Phs3V8HKyV+h5tlTkKWJ/Hl/SwO1
         GVUqRCjKXcpOi0P53khCXq6IUVmyR+na8St/jT1/lNRGJI3fcQQGBS5IhN19L1FwWnSV
         YtW0tP4RLYjVCJURELpEDIn/VqI8LW/RMsb1AruW4dGJ3EiH6UmomtfXXUBOLkYUd/fA
         IAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732973930; x=1733578730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WdudPSttzD3lDEy6mYrl4aEv9XWR7fCdViuLxOP5ZE=;
        b=DWvk+iJ2wIME8LuGilS+RYPzBhoQ5bAs5u0s5had3pB0+IudzSjFOiYurriaC2ayK/
         UfP8V+o/gRCPN73MysuFal9VGQYKPQXnmqUj+Zb2w2JLeGVORLUIy/FWOH3IstFaQ42F
         Z+09nMLxm6WpQhKbQbLuQzO5sQ/WYRj/3+YNtuohaRlAgNUqC1hSdbShaGOC1IiLoMHN
         Isiqv3uqApLrRDdyASksa9uTrCbFTKDLNXne7GAvKOdsqckVKaapLIShMUvs99m6nEzl
         1Qspa6OxkHDuIJCXqTD5ezZGcXhIc8HrdUOiX8VsUWFibL6julafPKgC6q9Ga3H4GsMm
         KJdg==
X-Forwarded-Encrypted: i=1; AJvYcCUhAvX7IodYBXma1nz42mmYNJ8I09CPmrEA57W+GW6UjSHcLjIkAJy2NbEiNUOTYkUDgYfGBJuUGpk=@vger.kernel.org, AJvYcCVVEhJMQV1aq36/VOUQCjxuNpdrZiMolp5dJLslegBWaV98gmGMnTGS51wfzjrfxp4yY5vOeUwBg/qAy38=@vger.kernel.org, AJvYcCX8MZsax0SLTxOG6pz2hVXCYoF83Zl93O3XpyJLZn2V/Fy43FvHqFOnB37FMHOeS+YfB54cEp9I+aRNmcjE@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7qpHvl3vSDb4eiTX2CbhtVI1ZzzVIG5lLmBqRg4IPg/OU2gb
	SAbaMFzvlQklRYqEmy9ix2HpOv9nSgaXqHyYp0ntn/mF7v5nXWnt
X-Gm-Gg: ASbGncsTFjm8Fu21qbv7nBV+6VTZHsPVdFeB1iu4v4FjujsRDn17hrf+iVn2eHE+otx
	ylqoHxLDr/jSB2Lc20AMEQYQ6GTTGgPipOoM5wgPjizMxrfeVEmaEEEJTL4ZnvhhB1lab7Hm8ZB
	kcccBIu8KgDjpAX1PjCqOTszSeFq30wlocfHQEG1bZJzbIPf7S/usLVtFjL8O0Kyhxc9OyqMeWc
	yr6XfUXvpfcndmvubdtW+By5UqGmy1rdE/LH17ignKQ2+uzJmmhyJdJLFfOQ5WV
X-Google-Smtp-Source: AGHT+IHyHe8V3s7+Z7XjtyH0gBWA7NAxzM1jkdFiODM0yCPB0SZHE0sPCWmXiIxUQVlMp+BN9VbIBA==
X-Received: by 2002:a17:902:f641:b0:212:5f9b:249 with SMTP id d9443c01a7336-21501097483mr229993905ad.23.1732973930349;
        Sat, 30 Nov 2024 05:38:50 -0800 (PST)
Received: from localhost.localdomain ([38.47.127.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156b1601basm5954215ad.196.2024.11.30.05.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 05:38:49 -0800 (PST)
From: Li XingYang <yanhuoguifan@gmail.com>
To: eugene.shalygin@gmail.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li XingYang <yanhuoguifan@gmail.com>
Subject: [PATCH 1/1] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Date: Sat, 30 Nov 2024 21:38:34 +0800
Message-ID: <20241130133837.24454-2-yanhuoguifan@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241130133837.24454-1-yanhuoguifan@gmail.com>
References: <20241130133837.24454-1-yanhuoguifan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add asus-ec-sensors on the mainboard TUF GAMING X670E PLUS
support these sensors:
SENSOR_TEMP_CPU, SENSOR_TEMP_CPU_PACKAGE, SENSOR_TEMP_MB
SENSOR_TEMP_VRM, SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT
and SENSOR_FAN_CPU_OPT

Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index ca38922f4ec5..d049a62719b0 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -17,6 +17,7 @@ Supported boards:
  * ROG CROSSHAIR VIII IMPACT
  * ROG CROSSHAIR X670E HERO
  * ROG CROSSHAIR X670E GENE
+ * TUF GAMING X670E PLUS
  * ROG MAXIMUS XI HERO
  * ROG MAXIMUS XI HERO (WI-FI)
  * ROG STRIX B550-E GAMING
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 9555366aeaf0..d9b4074080bd 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
 		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
 	[ec_sensor_temp_water_out] =
 		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
 };
 
 static const struct ec_sensor_info sensors_family_intel_300[] = {
@@ -354,6 +356,15 @@ static const struct ec_board_info board_info_crosshair_x670e_hero = {
 	.family = family_amd_600_series,
 };
 
+static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_crosshair_x670e_gene = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 		SENSOR_TEMP_T_SENSOR |
@@ -512,6 +523,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_crosshair_x670e_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E GENE",
 					&board_info_crosshair_x670e_gene),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
+					&board_info_tuf_gaming_x670e_plus),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
 					&board_info_maximus_xi_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",
-- 
2.47.1


