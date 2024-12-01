Return-Path: <linux-kernel+bounces-426538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4BC9DF48D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 04:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A989CB21570
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958861FD8;
	Sun,  1 Dec 2024 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jITr2xi2"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6F4C62E;
	Sun,  1 Dec 2024 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733024903; cv=none; b=BbmTgRHn9qYMyckUvL90bm5YpAH8DelQQj7GrU+Icbn6txMva6OOBDSkS96tOM5yVQrogQAhPv3ncivVOrLTwb/toBRQupQJH5Y4grmMlOgQ5YOzpALfwirwVXjQd3NQKn58d2pG6m0aji3gZo8TzCQyDR5o2d9cCgqzVj9nH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733024903; c=relaxed/simple;
	bh=QUmMAsjeG99DwdFnyGNZiSfrmf7sPDG4WSpDHLtbmtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7T8RaAkv9QtKE083XKKPH6gDkQKmoRW0yES+gXOe++SK5VSxxONxSXccsmT696JPQa06Os3SevsMcAXkXQJcJIf0jQ7UbFC7vlaYXAxpYWWDghwPcJufe9X/ctx/YAZEhJwO95Zz6+K9Uu6XOXaGBdPtiTdmQR7swcnMVq2s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jITr2xi2; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so1876759a12.1;
        Sat, 30 Nov 2024 19:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733024901; x=1733629701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uhzrsH8OTQDxGvLwR9Qrzbbyk+z63xmncKqVB1avBE=;
        b=jITr2xi2NYICZc5EnBWdP0QwPkVcYYxBEl4X0bUr2P1hwWGLHyD7SbE9C+DzYryl6Q
         YeXP76gzzqNp/h5IkfQpk+diDPRMF0+3PDRfzY+T9GFAIVUZRPoqr2ddDW2ITnwKwaWl
         n1Z1ytaUwWPgsI0Qg5HxeH46JWubkD98eW+EFO6NZAlFhQ75HwwhgACMkAT22uxoVH5Q
         U8Qe75llTTSVw2C5W/tZrODAAL+SB/C7NXkewpsjlYpKIuZy6iwMB07xc6KljQOKk/Oy
         TAht6u3SybO1V5GbCVi2LsW9MVzKuUo9tZz7g4x8HGxMOyFkyV4zJ65NPMT6U9c3N/bF
         xIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733024901; x=1733629701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uhzrsH8OTQDxGvLwR9Qrzbbyk+z63xmncKqVB1avBE=;
        b=fzupSv7MWkhtsfs+ppYbo8bPCJ0spp/Qf58Rca46o5ETWKBbCgqpgX6cYXryyvcDQ3
         GpFSKhbJA9wBnZNU/eDN3ag5nyX4r7WQEpDGrdrI+OCL2VxFV6XU2N4qAn4OsPJaaleo
         /oW4We4xJewyuugIsQTrW02neB4ltcech0i9131DMJphzbU0YepbIs6F+Nkpa6U5ZDRH
         WY8bE9dKZkjQCrVg1CC3zcVmnIAldOgZUDbHHopIoICSGac+D3BLBgfOnS43OSaA3y8V
         Bs4Fm2SJMzOl3sWeJt4UBerYfcfF27pBi71Rwako0k0ZVA257Sv+qR/9RnEXuVpYpRbw
         bPwA==
X-Forwarded-Encrypted: i=1; AJvYcCU0SB+sOQ7/T/Dhq+Zk4onWSR3ygZhQhXAKcOs3lwj9Bm0aKmG7tlzouO7723+8TDnYGhoA3nVK/C0=@vger.kernel.org, AJvYcCU6UissKzXHJoNLpVa4lAmhAyKHD8PKxB80wMRcB6b+RgewcO+g4NvZvn8YZ1F8/n9Y0dfFYyJfthwGv31B@vger.kernel.org, AJvYcCXkAPZHOdgQsWe07hD+3dIS92l2+Ih3Ro6b/U3GaOqiIuxYihAwgiFsO2ziTmRd26TVtAs4Fr5x0nrlBc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxNRdFqjTdITA7fNIhxzTAP66gxiEoAWTSMqd5q2RXGjWVqrz
	wTxjqmhUx33lR02sDChsgMZsZ2t3YZjLYAS7ZCPR1jnD20AMs/Ir
X-Gm-Gg: ASbGncviymkvs7IdoT1x3pVT+CFXgjMo6LCXyw3NnLNgOL7/akazuioEqE7DFNHyrvy
	FAOLV8x8awnEkSiscg77YXWrwtd3AHuu43JPQpEfDv33aPr9lWi6PxcIh6YeuqQjXfKDXh62RX1
	qany6DXvU4EXzfUn0lEnZzsOGrYh2G0fmIcrPip15rVZ7ErvzeMheEbqnYSBLNenDzTHUE4rrgv
	cS6meuyyRvvmXQDoIzDngv+3Xokj6i21Ju23yW4RQTwE42A6lqDhVbu4bXk9OzF
X-Google-Smtp-Source: AGHT+IHlvcFIf5K/8VjLo/7B7eq/4KDuEghrGQshWWELMBAkkhDe8oEUOUqJJaUyjkHHkFiTY3W0aA==
X-Received: by 2002:a05:6a20:a108:b0:1d9:2408:aa4c with SMTP id adf61e73a8af0-1e0e0af5cdcmr25979505637.23.1733024900885;
        Sat, 30 Nov 2024 19:48:20 -0800 (PST)
Received: from localhost.localdomain ([38.47.127.59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c321125sm5442471a12.45.2024.11.30.19.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 19:48:20 -0800 (PST)
From: Li XingYang <yanhuoguifan@gmail.com>
To: eugene.shalygin@gmail.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li XingYang <yanhuoguifan@gmail.com>
Subject: [PATCH v3 2/2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Date: Sun,  1 Dec 2024 11:47:45 +0800
Message-ID: <20241201034803.584482-3-yanhuoguifan@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201034803.584482-1-yanhuoguifan@gmail.com>
References: <20241201034803.584482-1-yanhuoguifan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add asus-ec-sensors support on the mainboard TUF GAMING X670E PLUS

Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index ca38922f4ec5..739636cf7994 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -29,6 +29,7 @@ Supported boards:
  * ROG STRIX Z690-A GAMING WIFI D4
  * ROG ZENITH II EXTREME
  * ROG ZENITH II EXTREME ALPHA
+ * TUF GAMING X670E PLUS
 
 Authors:
     - Eugene Shalygin <eugene.shalygin@gmail.com>
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 381bf117104f..43e54dc513da 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -479,6 +479,15 @@ static const struct ec_board_info board_info_zenith_ii_extreme = {
 	.family = family_amd_500_series,
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
 #define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, board_info)                      \
 	{                                                                      \
 		.matches = {                                                   \
@@ -540,6 +549,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_zenith_ii_extreme),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
 					&board_info_zenith_ii_extreme),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
+					&board_info_tuf_gaming_x670e_plus),
 	{},
 };
 
-- 
2.47.1


