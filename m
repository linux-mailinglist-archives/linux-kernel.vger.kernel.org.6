Return-Path: <linux-kernel+bounces-532625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D38A45011
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9822D7AAE99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A33421CA02;
	Tue, 25 Feb 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2+lYNl0"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E8217677;
	Tue, 25 Feb 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522322; cv=none; b=Eorg40kwsgATixJ3FQeWOVQXqF5xnmb9/cBlWP4odWmepL+kPkceICIuTgzMQIF/mwNYiEZbjpAz2EwwLht+F7J51kVqFSMdjskVdfFydDYyirEvqv/Ag6PVLts8oDWxVfANMiFq1QpsPNk7bujUnJmWrZnqLUZ3xv0PN447lO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522322; c=relaxed/simple;
	bh=coz2p1iCYGic1nUNNDm5ZUZct2+avkofXt7SJW+CW6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwmJV/ouQp7bSti+ibSIMqWXySxCDWjc72O2sDDzCYMEau2iwq2cCqq6NwqNBvqjlVds0Tbu4P9IlN0V6u4eB+Ni8CwLmtnmf6yfKSqsNXpMp8RCDyReC/c2gnMpKVsqtAfGt0c1067eaPWd1G9ZppHh+famC+jKGgUcSTBFbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2+lYNl0; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e606b74ccc0so2181760276.3;
        Tue, 25 Feb 2025 14:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522320; x=1741127120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3/TGlPK8TXmQtMShaone+EJa0sKCUnXmW8tDejZZQo=;
        b=P2+lYNl0R9zkt3wx5mZaETfOAcR2T8QbKu++5eveEFsZGCLxLtQqrfZGU531jjAu+S
         zcZUajbfHz4VQnOLHyABTILofSPoypOXLIPQc1lRK4HhmPe6mYTFLF69OPtrrRGicSo+
         4ejaRiHYOkaEFsgiF5rS5s53/y7nuHakXp/Q3DnpU5j6BPfPK9BC6XJlXNsbLYQcJVMa
         lfcfDh6l/GQcfFSqJGj3i/vvZJJBIKpOLWsNWolCILhnDXGWtdBwIIyrD8IHQsiHLtm3
         J2mS0rVxWp1xchUQ9Lc6tUcnxpqnj93M/vEwsSWHq5xg2Krqr48pn6SMiS8Pkii1S3/z
         /xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522320; x=1741127120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3/TGlPK8TXmQtMShaone+EJa0sKCUnXmW8tDejZZQo=;
        b=MIEk93spYsKpefWFsMn6m2mCIdB17iCQDodsUZ0IjhKwo6hNxTa9gpqLBRJawIPfHF
         WDcBhT3Sw4JLEQt/3W+Bpw9yrag/GiaFYkvpPZmKe32cTMqEkOQ88fc4eRw27Dsa5PbC
         rBLxIVNdFURDPhcpmMAFGg3mLz4FhL+oqzSzB0+COurxejY61xHfDPHgisfjGD5r4kv4
         tn72aDFkabQRGdYuDaHWyNPzd9+g0t7c2USyWDWmvX+bosH5CgnjZDfEgwGo4HJ40FJS
         Y4Slm+r3uUyYrFvbjVH7a2aP5xHtvy60TuSd+6CmwPwgZQgxhwWQUi/O8OgKSbaAPgVd
         VQiw==
X-Forwarded-Encrypted: i=1; AJvYcCV8s1bdfDg1gpKUSoW45vKXUHu7K6+sHoOiO3SedL+z+2xgtRkRLUz03T8NBw+QRoc3hk3UKyxOulvF8ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdmsM/71L5ezJOq4zwYbpyLAhApUmv5adrMp85VyLs0jhpH63
	11QKtxUM8txrLaQUSMIkyXcZsax7zjs+LiX8oG4Kn4NX3CCmgKMtVYGNIhHE
X-Gm-Gg: ASbGncukyeIILyHL32opzXG61l3CiKBZWUBqsy8jfI7bXq0nN85RXrJMbQBd/AKWfrC
	4/GqI+iV/lFcUJumZWaNdGZTqFYQUvmbDyGSRIUVxtlA5L2LZtRfwriuZi+ikoqlBqRoVltPm+H
	vM2/tZI2gNK7ZaOtOlwWrMmvP/k14q4OHbvLXZKAARAOm4eVPNRbB+zr+u95ouf3Q/xOn3RBave
	CxZvcOmnHLKvSloRFapoJd7+W2dHyaRsKXWEDiezJ/t408rSVIZK9Sn7vmGwH28oeg8Czxa1kJA
	/SjJPASoe0oY+55Di3bJA6t8qJv5ZzNjAQ==
X-Google-Smtp-Source: AGHT+IEkWY2Ro0A0rYTD/iff35oqluoSFbxm+LSNmEPGn1VLR7VEJkNinZUqWDGX0zrQpXtWtnMKZA==
X-Received: by 2002:a05:6902:2204:b0:e5d:b88e:4f07 with SMTP id 3f1490d57ef6-e5e8afe33edmr13486780276.21.1740522319842;
        Tue, 25 Feb 2025 14:25:19 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:19 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 05/10] platform/x86: alienware-wmi-wmax: Improve platform profile probe
Date: Tue, 25 Feb 2025 17:24:55 -0500
Message-ID: <20250225222500.23535-6-kuurtb@gmail.com>
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

Get and store the AWCC system description in alienware_awcc_setup()
instead of awcc_platform_profile_probe() and add a check for integer
overflows to avoid misbehaviors.

While at it, replace set_bit() with it's non-atomic version __set_bit()
because `choices` belong to this thread only.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 .../platform/x86/dell/alienware-wmi-wmax.c    | 61 ++++++++++++++-----
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 4a8335d90b5d..965b427f8f0a 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -37,6 +37,9 @@
 #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
 #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
 
+/* Arbitrary limit based on supported models */
+#define AWCC_MAX_RES_COUNT			16
+
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
 MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
@@ -211,6 +214,17 @@ struct wmax_u32_args {
 
 struct awcc_priv {
 	struct wmi_device *wdev;
+	union {
+		u32 system_description;
+		struct {
+			u8 fan_count;
+			u8 temp_count;
+			u8 unknown_count;
+			u8 profile_count;
+		} __packed;
+		u8 res_count[4];
+	} __packed;
+
 	struct device *ppdev;
 	u8 supported_profiles[PLATFORM_PROFILE_LAST];
 };
@@ -614,38 +628,41 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	enum platform_profile_option profile;
 	struct awcc_priv *priv = drvdata;
 	enum awcc_thermal_profile mode;
-	u8 sys_desc[4];
-	u32 first_mode;
+	u8 id, offset = 0;
 	u32 out_data;
 	int ret;
-	u8 id;
 
-	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
-				       0, (u32 *) &sys_desc);
-	if (ret < 0)
-		return ret;
-
-	first_mode = sys_desc[0] + sys_desc[1];
-
-	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data);
+	/*
+	 * Thermal profile IDs are listed last at offset
+	 *	fan_count + temp_count + unknown_count
+	 */
+	for (unsigned int i = 0; i < ARRAY_SIZE(priv->res_count) - 1; i++)
+		offset += priv->res_count[i];
 
+	for (unsigned int i = 0; i < priv->profile_count; i++) {
+		ret = awcc_op_get_resource_id(priv->wdev, i + offset, &out_data);
 		if (ret == -EIO)
 			return ret;
 
+		/*
+		 * Some devices report an incorrect number of thermal profiles
+		 * so the resource ID list may end prematurely
+		 */
 		if (ret == -EBADRQC)
 			break;
 
 		/* Some IDs have a BIT(8) flag that should be ignored */
 		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
-		if (!is_awcc_thermal_profile_id(id))
+		if (!is_awcc_thermal_profile_id(id)) {
+			dev_dbg(&priv->wdev->dev, "Unmapped thermal profile ID 0x%02x\n", id);
 			continue;
+		}
 
 		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
 		priv->supported_profiles[profile] = id;
 
-		set_bit(profile, choices);
+		__set_bit(profile, choices);
 	}
 
 	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
@@ -655,7 +672,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
 	return 0;
@@ -686,6 +703,20 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
 	if (!priv)
 		return -ENOMEM;
 
+	ret = awcc_thermal_information(wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
+				       0, &priv->system_description);
+	if (ret < 0)
+		return ret;
+
+	/* Sanity check */
+	for (unsigned int i = 0; i < ARRAY_SIZE(priv->res_count); i++) {
+		if (priv->res_count[i] > AWCC_MAX_RES_COUNT) {
+			dev_err(&wdev->dev, "Malformed system description: 0x%08x\n",
+				priv->system_description);
+			return -ENXIO;
+		}
+	}
+
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
-- 
2.48.1


