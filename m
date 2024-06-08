Return-Path: <linux-kernel+bounces-206959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0903901091
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A6228358C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A5177991;
	Sat,  8 Jun 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsiKKfaP"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B22BAE9;
	Sat,  8 Jun 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836744; cv=none; b=DY3FOcUpM4AxtYMnxx9DhprzpMyUxFiA02pp2Yf1q5M6SIdWnrG1sqJ0TU8GLEqJ5te1Hac5IOd/dPZSQ9w10LolGBDnjBxQF5GTw52QAHSda71aO8xJJzlPmCQoJpW3Jg3boAbLiiboyZejwn5Iv4JlgIWNNCF7oxjegLUaOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836744; c=relaxed/simple;
	bh=ha7EzrpsruY6y9xDIkz/nhmxyf0XxlQ+52RUFa2ziNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEOSX+7az5YdCgg9bk5nMq5FDW2cGglEGtfw/AjpgX31CDFh721mDKiTiWlEkfOzy3w4ztWyz7N/pz2G1Ajn0dB+Nrdi0pRD5oHsDJqjgfJq5i4uB3qvSbnUJ/Sy3p7vw7rc1/YdBLYnJOdSMmBQhH758eEFI+gJ4evN5q16vIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsiKKfaP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6e0a499687so135733066b.2;
        Sat, 08 Jun 2024 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717836741; x=1718441541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1aXjWmtgZ3e8sv722YupJkGCAHwEEWx+AcscMfS3UI=;
        b=HsiKKfaPTpqswHjqPBp9bR6b+9ihcnsARcehS6lv5XHD1Kw3MS78BODbDfWzAq0dZG
         JHjubAKUuxL18aUpVRM5ioRTp2bg7eWVCMDMRbmIhFvKSQ2r0QbJGZT6OBnSnMcfL9tl
         iX88nQYpwB1ikU5FGK+UwUNcCOFyFrph1dm5ubuk4GLlCC66bhhQGTZ5fqU9RAkl/jZm
         HiLpIx37+IHndikXl8Jt3bXp2dP8orWUB1rJSq5yeAh+PMj10P/oi0AtJp6OL9d1eKFI
         r49VYIJz6qQehiQ8WDEYkJTRNQthXAuAvizBZuxYWH0SdX3zPYnEHcC2WDNSjYj3ax5t
         scjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717836741; x=1718441541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1aXjWmtgZ3e8sv722YupJkGCAHwEEWx+AcscMfS3UI=;
        b=wyn//DCgspDB411wQdKWSWjnRFMjiYFbT53EGP9nkCCBflTZnB56j33fpDmf4eD6yY
         vwOYoqfH39aXrhMmqhbllyiRHjOC9Ou1DF00qM/7yn2wEhRrPp2/SjEzDt9uwlGhkCen
         zlIio/1wBd4CASI+nSvvCLyvzAnIEJ5DgdS+X9R05v8CX9cQdUvdDQHaPYu64wtC68zw
         Kk/WA5k9gwUrTX9ualndJ5IorUlZqJju78hR+8/HNahpbR+Nooz1dR620mSKZQUseW67
         21dbFpTTQi/74c0yk0uvZAebd79nqwzdveZeCL4t6K/xuHZ+BuHtP2zzxFcEqY21+65a
         UNgw==
X-Forwarded-Encrypted: i=1; AJvYcCUKw67NnFraa/cI0NS4jRDOwqS9CNELrLwIXzSi4CZ03E8E9aM0gpOGcV7dpW+TdLJYMyzBK4C8uZmOSWZkruoRIHYoX2as0s+DaXqSxSzo4k4yJa9d8k3Kbnfx5hDRb4v5vSPGb0A8qOcGaZuORUDZPvzTIW8oPsZeQYOSbyvWTAqTDgM=
X-Gm-Message-State: AOJu0YwWVE2mwYILNgUOSh+3AEuUyVIleBxPK9ZQkAWZXG8i1CBsMnPs
	ZvG2BV1XRDOovEf+OoVDCN6XbyAHTOxrMoaWg59+6ooqmNZpWgRz
X-Google-Smtp-Source: AGHT+IFbDZmJD7JT3b/jbSma58/rkMWsWZspI9oABhrJ/uKXNK/8TzbM8H3qFUVbwUIAU2urSQtEXw==
X-Received: by 2002:a17:906:3882:b0:a69:2025:1535 with SMTP id a640c23a62f3a-a6cd7a8abdemr323683866b.33.1717836740945;
        Sat, 08 Jun 2024 01:52:20 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f200400a86c445e36ca9cbe.dip0.t-ipconnect.de. [2003:cf:9f20:400:a86c:445e:36ca:9cbe])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6c805fa410sm359066266b.94.2024.06.08.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 01:52:20 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (asus-ec-sensors) add ProArt X670E-CREATOR WIFI
Date: Sat,  8 Jun 2024 10:50:05 +0200
Message-ID: <20240608085146.572777-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240608085146.572777-1-eugene.shalygin@gmail.com>
References: <20240608085146.572777-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provided and tested by a user in a GitHub PR [1].

[1] https://github.com/zeule/asus-ec-sensors/pull/56

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 0bf99ba406dd..ca38922f4ec5 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -8,6 +8,7 @@ Supported boards:
  * PRIME X570-PRO
  * Pro WS X570-ACE
  * ProArt X570-CREATOR WIFI
+ * ProArt X670E-CREATOR WIFI
  * ProArt B550-CREATOR
  * ROG CROSSHAIR VIII DARK HERO
  * ROG CROSSHAIR VIII HERO (WI-FI)
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 36f9e38000d5..6bb8d7b1d219 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -322,6 +322,14 @@ static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_pro_art_x670E_creator_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_pro_art_b550_creator = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -486,6 +494,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_prime_x570_pro),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI",
 					&board_info_pro_art_x570_creator_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X670E-CREATOR WIFI",
+					&board_info_pro_art_x670E_creator_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt B550-CREATOR",
 					&board_info_pro_art_b550_creator),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE",
-- 
2.45.2


