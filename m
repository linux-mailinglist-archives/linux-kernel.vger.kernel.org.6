Return-Path: <linux-kernel+bounces-557226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AECA5D557
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED2D7A9903
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82A1E5B72;
	Wed, 12 Mar 2025 05:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyRa2rNu"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605491E32D6;
	Wed, 12 Mar 2025 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756332; cv=none; b=MaUk1RJM0dxhPsmKwFZxXziynWPdAEMEzGCc//GsiF+m28lBixMFWff0y7etCD7uV5vo8KBE38Di5A707brMsc6RtKrsmNLNRHTlfwD1Jp/0nr8XgJBM0VK9R1RdpI8mluefbdCHGm6c5QeUJ6T6KJnBtybIAzQ+zMj9CUz8XeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756332; c=relaxed/simple;
	bh=cPKPG5Vxh6Z/Se8zjhuifeo9I8dN5wM+mN+9d222mtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ez0FbVxfkbOcwXMradHiar9Udq+Ptfew93Ieoob6q0ocpK6wa7IKAD+0VOxLrrqf02QEntUn9aNZZ78mQcG8dhWRh+t+o8w78nOpcTgE3l5eqUlo0m3QMSeJCbH8B5Y50iL3AKeLjrlxfasRM/XS4UgQrft2Uygqz31Xj+hoXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyRa2rNu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fed0620395so36032217b3.3;
        Tue, 11 Mar 2025 22:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756329; x=1742361129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJz42pw5OoHFXvVMA6liTx4M4GaMhFeDvsfN2Iym2Zk=;
        b=UyRa2rNua19OxfV/oU136ZbmAUkVhqrsjGzsZl6N3uZqfrcBMQj8e/X3dmg2RVxzBW
         Js7rI3aNMcCYEkzJNCfA0PK+C77eV8nNN4xfwwIl2ur4/kztvNyGpfXlOnn3YsgkJDN9
         FmMTW1RQuA81W6I/0d+2wUSagCcR5b9WdU+CyP6ugy2Mp27SFHfNGDRrvHrpjhGzukd7
         3Tzyg6VFuUKSf+s6ZR2/fNNxhhddJb0It66XtM9o94ksKaMMZJATkCMPtcYse+e/WwAy
         A1xtyoAOQj2ETSXkfEmBI3hlM7OFr74Cn6TsRDzL2jMp6MWhMWWJzOmlwWksDK6yCi+A
         S1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756329; x=1742361129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJz42pw5OoHFXvVMA6liTx4M4GaMhFeDvsfN2Iym2Zk=;
        b=rtfFANv144yhnHxthpbHnNKt8aYkOLAKqoN6cAJw3ShdeRWxS9jRcSZYfq17/oP9Bg
         veXmisBFgjeyyHoySUnVYQX5GZpcYzUWqF9EY80ROogN1Gs5sx3nAZDvzuBn6HHQOHY2
         z0J5PopuIAuqBcmzQ2AAJvssXUntYpkM4LI85kfKj6WnaIf3NFktUy/QagNsd+7427ms
         X251X8h6zhq8CHxa9XHKMfwhP15OCe3oJ8SBcTtEESKWAWP6G3nhoAMhRABih38JQuom
         5pClFEUHvS5PLIMPAub6KgJ/O9oM3zMmKQdAR6khChfkiC4pSD+BT7KllOK22zewdRRT
         kk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6nW3G2LBHihibS3y3fDUUtjCe2Yuc5EaJk9x1npAiOrgycntcXnW7PH1uSutPl8Sh7ta8Gew06PvPQi8=@vger.kernel.org, AJvYcCWW2S5LWE9VroI4C15vQ8k6w5ICehggSCzH1i6q1l0oTnwv7+L+Nrjo3/GXX8YW8YQm6fxXftrN7bufjYb1VXzmIMEj+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6IrrZYhgPm7K4iv9FSg5ZGmHkeSRd22piJYlNnLTlklCEZED
	IFaBHkui/fxUc5vTABo+TGVX9WmRWEB2zjAFdYQjS43t6sWladLjaOB4+T3Z
X-Gm-Gg: ASbGncu7wQyvWb7MdAQpgtfiufMjSx8lGEZS0p6qSFQmA0gqiKQgBKO7SmUcKr+x07G
	xS21YZtsQOgsew/dIJiwztggCCNJB1DNyVwjFAUKw2NrW5zbYYYrQ8V7u34tDFdNz9bmQwuMdTL
	wfV0H70svhDqdSgg+IwxGwkNgwuxeYjxDyFd49sS9n5fKq+RHqljjgEoyljNvDyfF1Ra7YStASY
	QcdlpEHVoZ8b0opFoN0zj5uIb1O7lwkIT7U1uPB/o7ibDDe/kvQLqWDoIowltaTx2eZH78WoLT8
	dHoUCeb+bKO9MrQVFhBi+ReIalNDWuL6XVCBo8hxrxebGg==
X-Google-Smtp-Source: AGHT+IGnpS2WbKHcuV8C17LluqmtpayiXX8/sBkOWpJmpKbOmUyCgknKvQUIgn7ldUz6pnhIC5WN3A==
X-Received: by 2002:a05:690c:c96:b0:6fd:64ac:21f0 with SMTP id 00721157ae682-6febf2d4457mr297153417b3.10.1741756329207;
        Tue, 11 Mar 2025 22:12:09 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:08 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:18 -0500
Subject: [PATCH v5 05/12] platform/x86: alienware-wmi-wmax: Improve
 platform profile probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-5-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Get and store the AWCC system description in alienware_awcc_setup()
instead of awcc_platform_profile_probe() and add a check for integer
overflows to avoid misbehaviors.

While at it, replace set_bit() with it's non-atomic version __set_bit()
because `choices` belong to this thread only.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 61 +++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index a8a13779793abbcc8d1263474cac6227d524a6f5..0530f25b956f73f47c0354f40dac2910448c894e 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -38,6 +38,9 @@
 /* Some IDs have a BIT(8) flag that we ignore */
 #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
 
+/* Arbitrary limit based on supported models */
+#define AWCC_MAX_RES_COUNT			16
+
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
 MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
@@ -212,6 +215,17 @@ struct wmax_u32_args {
 
 struct awcc_priv {
 	struct wmi_device *wdev;
+	union {
+		u32 system_description;
+		struct {
+			u8 fan_count;
+			u8 temp_count;
+			u8 unknown_count;
+			u8 profile_count;
+		};
+		u8 res_count[4];
+	};
+
 	struct device *ppdev;
 	u8 supported_profiles[PLATFORM_PROFILE_LAST];
 };
@@ -624,37 +638,40 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
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
@@ -664,7 +681,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
 	return 0;
@@ -695,6 +712,20 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
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


