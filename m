Return-Path: <linux-kernel+bounces-552783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9C3A57E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF99E188E8E7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609020F07F;
	Sat,  8 Mar 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN8329+T"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66320C00B;
	Sat,  8 Mar 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465432; cv=none; b=LelQAN+L7ebchRQHDYCr6QQAiWm4w2YYBKdD49gA1pJTNqKx9QqA5K+u/etS1yiBD8PEdFYLSPtXDWMPTBegy5HLd8EgP11ZxvTS7IrbsAgmPmFKzipFYvbsb/vFKXebATDXNZ8KUkIscKfs5lgpHUNS375L4VHIczcjVEvD6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465432; c=relaxed/simple;
	bh=b6I4LW2lXRr4zSKyCgVo5hQkgsNPWVdZQx2aOlTduKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YH7E41+HtLdYa50hdYFkuuJ8avuItQI0wx6q4ZsQOtir0a6Pp+A4HNZx2NSAX2mvZmGBY+Cojp7cJoZW3xQeamOaoxsA2loSSimx3oZtv3X6EfKWx0JXXju4H5rof7Onhe1XCpo5FswqS1JBqzOK1nD0oT1eqjICFczvjP2YTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN8329+T; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-523efb24fb9so535523e0c.3;
        Sat, 08 Mar 2025 12:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465429; x=1742070229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki8JJlqvtQ1DWozBXa70s7Vleuhvzvt2Tgc/aHkAO4s=;
        b=HN8329+T0Doec6DOKf38RHa08eymk6K7h+qm4zm4y25EYEnnqCsvKIcxycs6VPEmSX
         V86E+rcq1jeEy3cVVsMA3ShxFTj8mWvhBAU273lV81INPWmfvX3o5JrgSaQGueKzJhcF
         4YJbyREHNj/lbW5EIy0tqQ/Jx2k3QmLOuEkoo1OfuGoCz5UVa7z9mbaxC+9i4kekC9bb
         9KKkwmYNuedipTAsCF6+tWbTKrNrzvdGn3fCeDwCCozrc2nMz3Mnuiq9kD597cX781jE
         PPLnNxWbsMyE8LHTjyr67PmnoRQWtN46b/FMUod+H5DMEfZ2cbtwRA44y2NFbRtgLtog
         Uxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465429; x=1742070229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki8JJlqvtQ1DWozBXa70s7Vleuhvzvt2Tgc/aHkAO4s=;
        b=m9gAjDm1ykINXhdwZ3t/vVbt9g2f6D4lrCCUN1wtBTe0hUIlbmsy1rBu8WQG5Ls8He
         D7V4DzYuvr4F15YHSvSHmulypcdRpfp9Gx6VIM1R0OQ9GsETcS7YnzFFnAgLz9Q7M/Q4
         jwhfzX/04qKM+B+lPELAso0g5WPESy33d5C/tkeyJHCUHOru9vYpD3fipbMPEt9KOcmO
         6zMR0dUC9WRv4UxG1OrnpL7Q/C0O0wzH7PRSuFvanpKaZkFTku0dszDuF9uJD2TOTp+2
         KYFugavC6YiJkxoqwheWHDz97lgzoivCiSKU51TvXEr6naK7/MW2o2SxeGWn2Dsmjcni
         jDYw==
X-Forwarded-Encrypted: i=1; AJvYcCV5zfP6IBmLBluEltTuokclZr05J/SzUdj2xRz50uXpALSLhaOy1TDI2gTdksREjXUf6QqaLUCpeJ2GCb0=@vger.kernel.org, AJvYcCW0f3AM7Lgj348IRcf+3W8PRTd/ZWXDY1s6BVdpECo8+2r2IpFAtcas9aJ9SNTdlWAdyD4tG0/or5lHBF6yu8No9lGNyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCr2PAqCCw/hCf/JR3sUQRdw3Y3lPNQrKOtYIL2i5E0494/Gbe
	7l6Ndzsy3OXER5lsU8pDBJzCj+FmIGK4RvwBWihcWxHNVxbSB1Qj2FHa5Ryn
X-Gm-Gg: ASbGnctHN7imgO9a6hXd1/0FerG4MnEVHrLuTQ0MOHXcVIKh0849TAg1JA0DSP9W7+q
	nmUD/qSB8Bm6reKbERE55X+pIMsNz/Ocal964yQEmCd4Be2s0rjmy/ZIDKY9XG2xPIQyTayt0ZN
	gh9U6LJmC3eDcV5vf3nJTKPFqFdGoB8LJCCBa6azoGOfF2CoW8tOvIouOMIpKMpUMUuidQxvOED
	tNmRNZWO8m/biXdf2ossTpoA9xvkR0Z11NFQ1eiOhyaR9pq9cQCQzhFhk7qJCa/+KDUujgahlYn
	g9Lvf5hilzB8xN/U1prekDyy++qKvYfoLRNVZ3EfEQupx4SIeLFE0lOi
X-Google-Smtp-Source: AGHT+IHU2ZK0HS4qNxZqWbt7VYhGplFMMoA+CI1Bm5NG9H8wfq6wPD7P2v1ssp1vrM2u1L2cheF8FA==
X-Received: by 2002:a05:6102:2b96:b0:4bb:5d61:127e with SMTP id ada2fe7eead31-4c30a72e288mr5487214137.25.1741465428993;
        Sat, 08 Mar 2025 12:23:48 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:23:48 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:14 -0500
Subject: [PATCH v4 02/12] platform/x86: alienware-wmi-wmax: Refactor
 is_awcc_thermal_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-2-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Refactor is_awcc_thermal_mode() to use FIELD_GET() instead of bitwise
operations. Drop the check for BIT(8) sensor flag and rename it to
is_awcc_thermal_profile_id().

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 33 +++++++++++++-------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index ed70e12d73d7fe5d89f3364c5367820bf47e3c1e..80aefba5b22d6b4ac18aeb2ca356f8c911150abd 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -34,7 +34,8 @@
 #define AWCC_FAILURE_CODE			0xFFFFFFFF
 #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
 #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
-#define AWCC_SENSOR_ID_MASK			BIT(8)
+/* Some IDs have a BIT(8) flag that we ignore */
+#define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
 
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
@@ -168,8 +169,8 @@ enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
 };
 
 enum AWCC_THERMAL_TABLES {
-	AWCC_THERMAL_TABLE_LEGACY		= 0x90,
-	AWCC_THERMAL_TABLE_USTT			= 0xA0,
+	AWCC_THERMAL_TABLE_LEGACY		= 0x9,
+	AWCC_THERMAL_TABLE_USTT			= 0xA,
 };
 
 enum awcc_thermal_profile {
@@ -445,20 +446,18 @@ const struct attribute_group wmax_deepsleep_attribute_group = {
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
  */
-static bool is_awcc_thermal_mode(u32 code)
+static bool is_awcc_thermal_profile_id(u8 code)
 {
-	if (code & AWCC_SENSOR_ID_MASK)
+	u8 table = FIELD_GET(AWCC_THERMAL_TABLE_MASK, code);
+	u8 mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, code);
+
+	if (mode >= AWCC_PROFILE_LAST)
 		return false;
 
-	if ((code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LAST)
-		return false;
-
-	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_LEGACY &&
-	    (code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LEGACY_QUIET)
+	if (table == AWCC_THERMAL_TABLE_LEGACY && mode >= AWCC_PROFILE_LEGACY_QUIET)
 		return true;
 
-	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_USTT &&
-	    (code & AWCC_THERMAL_MODE_MASK) <= AWCC_PROFILE_USTT_LOW_POWER)
+	if (table == AWCC_THERMAL_TABLE_USTT && mode <= AWCC_PROFILE_USTT_LOW_POWER)
 		return true;
 
 	return false;
@@ -548,7 +547,7 @@ static int awcc_platform_profile_get(struct device *dev,
 		return 0;
 	}
 
-	if (!is_awcc_thermal_mode(out_data))
+	if (!is_awcc_thermal_profile_id(out_data))
 		return -ENODATA;
 
 	out_data &= AWCC_THERMAL_MODE_MASK;
@@ -597,6 +596,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	u32 first_mode;
 	u32 out_data;
 	int ret;
+	u8 id;
 
 	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
 				       0, (u32 *) &sys_desc);
@@ -615,12 +615,13 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		if (ret == -EBADRQC)
 			break;
 
-		if (!is_awcc_thermal_mode(out_data))
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


