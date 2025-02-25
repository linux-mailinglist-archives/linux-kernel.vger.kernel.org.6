Return-Path: <linux-kernel+bounces-532621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA45A45002
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF911189DEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D22153D1;
	Tue, 25 Feb 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOKG8JqD"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9521507D;
	Tue, 25 Feb 2025 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522318; cv=none; b=XQ3cKrmPW3aLg/RENVcndS2lgW4QSx/JEGw5Io6X6623/L99NNkVWo4RXFzdByNILYWDnvqSTKpzLFtkMUEb+oVbwIc3ucRPwpCb+L/ewhPgoqVAsaych/8CxfiC1T6o3e9YVbvLoSxZJAxZlTK7R/Eyuawpl3qktmRrRG0+zkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522318; c=relaxed/simple;
	bh=3MNEnjIAjYB08ds2Q4WfcgD2Ilr3jiw1InwJo1UyKVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5jCglMwo1FWmX/tma2p2uVwBmi9f73gwto3D/AUYSRWRha0dOKKau0iQT6RC/Vi3DbeBj06/MLjcI0cSemQbq97+lsqMK3ESjeXnjc6r+gDkoQiW0JfHS5Oo9z+eBo7tQ7uMDojcilN16YPwjuyRfkLEa5VyHEjzinp/YiKgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOKG8JqD; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dcc411189so5550164276.0;
        Tue, 25 Feb 2025 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522315; x=1741127115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoNTNsiugx95qIkwhmVKR6HdZgnCFcxvQrL16Y+N13g=;
        b=jOKG8JqD465wfcmi2spXLWfZGxEBVsFd5g/WQijE9WZAQykrJX1+fQqw5C/7UJuLKB
         BHJyyNZqM6lix173wlcf5zwZKFAXGK9EcJ7hReBY7LjNE+UdHlmIqgF8PECq7d+Fu94k
         vknOm/e0+kLC2b2Qb7+vi8DzjlzG45iVD4Rwy063kdg4DSaLEVRjyR9ZRbVP9ve9Kdks
         /Js9GAdPxo2JmyruIGT8SeaMLKRgNbLgXV2P3JwhrC8LYtK1VqnQZdWogwXtES0yKbOT
         RO7uwgAeDaPyA60vtcrh7Vn9O8FORrkUjinbIu2t/NaX/ArhtI+yw2c8BVIpgEC4xUto
         zVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522315; x=1741127115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoNTNsiugx95qIkwhmVKR6HdZgnCFcxvQrL16Y+N13g=;
        b=i9HqHmGZ62IGlCZ8IdEP9OWlHMmfdaNM07eMi0yw+OdfXykXF+Zem+k/JpBE79hKRf
         O+8iBDy0j10aqB3r2m3aJ/M29Tdq+Bu3L/WoU/ngQIc05x445nWeJjq3gOAbf2MJXFqI
         F3uoPrWkgSGx/KRmotX/jLxQAqtygCmCHFbZTu91fi903bBdDVGJF74U0/2l3tXAIDd8
         RuR5GP4I4EGWIlcj8Wsrp/5yAGo9mEXREicRG2fpIg6i74zmFAYZEK2Y/9PM1hGai5JD
         nR66WlyBEaiZ0HIwNVtHmkf6SflvMoaC/+Pq8DDbDxxGvD2wDXSRsJGhfvoZpZrkmRto
         F69w==
X-Forwarded-Encrypted: i=1; AJvYcCWEps1AA7WNU5l/j0/9SYSI0nPYNI50oIk5aZ+h49wzyHo5Ku2uZu00cjK336blU1YXA6SAi+E8AtFfFic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8g/LJdBde6ptT4zeS9Ik98wQSI7VzePlv8d1kGQ8sH7Ur7TcF
	21FYcnZFaITR63wEY7y+A451kFJqls1dpZ/ZHdIyYvGDiRaBd2R7
X-Gm-Gg: ASbGncvmUUQQ9dkK+U5/0L/7lwLYMEFlcHw4fm+U7IEdRYAIMyPpl7PZokhi6PyO11g
	UylPtm3E3wspluVZDUlw2y5BlkUd5lfd0o8103r/JRroEzBcggx5je4ztnkz43f+gphj9tJx99I
	Ym2mjVLrupm7yK2B9e3F7RKEshMc+5zB8x6I/gH4acgAs58/Z7czG0oKHJpCgXBT6Wdq0KWjV4r
	W/UHbyq2VohOG4z/luHfP4kvVXPNtsSjN55bwrzp2tm0Xa0F/etn4uWBzuUHBOY7RujTCYruLkX
	TbMqSqFuHNEDaGKirmHxZQ7kpdtDfgc1dg==
X-Google-Smtp-Source: AGHT+IEoFjMy7r8fYkL27z+bW59UNaOPFMaPAMBlIRPWEu7Lg/1mg4ldvVhY6l2D8ZqbFiL05FJ7bA==
X-Received: by 2002:a05:6902:248c:b0:e60:78b7:faf1 with SMTP id 3f1490d57ef6-e607a5033a2mr4124715276.21.1740522315360;
        Tue, 25 Feb 2025 14:25:15 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:15 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 02/10] platform/x86: alienware-wmi-wmax: Refactor is_awcc_thermal_mode()
Date: Tue, 25 Feb 2025 17:24:52 -0500
Message-ID: <20250225222500.23535-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225222500.23535-1-kuurtb@gmail.com>
References: <20250225222500.23535-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor is_awcc_thermal_mode() to use FIELD_GET() instead of bitwise
operations. Drop the check for BIT(8) sensor flag and rename it to
is_awcc_thermal_profile_id().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 .../platform/x86/dell/alienware-wmi-wmax.c    | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index ed70e12d73d7..7f0aa88221d6 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -34,7 +34,7 @@
 #define AWCC_FAILURE_CODE			0xFFFFFFFF
 #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
 #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
-#define AWCC_SENSOR_ID_MASK			BIT(8)
+#define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
 
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
@@ -168,8 +168,8 @@ enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
 };
 
 enum AWCC_THERMAL_TABLES {
-	AWCC_THERMAL_TABLE_LEGACY		= 0x90,
-	AWCC_THERMAL_TABLE_USTT			= 0xA0,
+	AWCC_THERMAL_TABLE_LEGACY		= 0x9,
+	AWCC_THERMAL_TABLE_USTT			= 0xA,
 };
 
 enum awcc_thermal_profile {
@@ -445,20 +445,18 @@ const struct attribute_group wmax_deepsleep_attribute_group = {
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
  */
-static bool is_awcc_thermal_mode(u32 code)
+static bool is_awcc_thermal_profile_id(u8 code)
 {
-	if (code & AWCC_SENSOR_ID_MASK)
-		return false;
+	u8 table = FIELD_GET(AWCC_THERMAL_TABLE_MASK, code);
+	u8 mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, code);
 
-	if ((code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LAST)
+	if (mode >= AWCC_PROFILE_LAST)
 		return false;
 
-	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_LEGACY &&
-	    (code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LEGACY_QUIET)
+	if (table == AWCC_THERMAL_TABLE_LEGACY && mode >= AWCC_PROFILE_LEGACY_QUIET)
 		return true;
 
-	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_USTT &&
-	    (code & AWCC_THERMAL_MODE_MASK) <= AWCC_PROFILE_USTT_LOW_POWER)
+	if (table == AWCC_THERMAL_TABLE_USTT && mode <= AWCC_PROFILE_USTT_LOW_POWER)
 		return true;
 
 	return false;
@@ -548,7 +546,7 @@ static int awcc_platform_profile_get(struct device *dev,
 		return 0;
 	}
 
-	if (!is_awcc_thermal_mode(out_data))
+	if (!is_awcc_thermal_profile_id(out_data))
 		return -ENODATA;
 
 	out_data &= AWCC_THERMAL_MODE_MASK;
@@ -597,6 +595,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	u32 first_mode;
 	u32 out_data;
 	int ret;
+	u8 id;
 
 	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
 				       0, (u32 *) &sys_desc);
@@ -615,12 +614,14 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		if (ret == -EBADRQC)
 			break;
 
-		if (!is_awcc_thermal_mode(out_data))
+		/* Some IDs have a BIT(8) flag that should be ignored */
+		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
+		if (!is_awcc_thermal_profile_id(id))
 			continue;
 
-		mode = out_data & AWCC_THERMAL_MODE_MASK;
+		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
-		priv->supported_thermal_profiles[profile] = out_data;
+		priv->supported_thermal_profiles[profile] = id;
 
 		set_bit(profile, choices);
 	}
-- 
2.48.1


