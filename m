Return-Path: <linux-kernel+bounces-557225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C692A5D555
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA4217588C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7E1E51EE;
	Wed, 12 Mar 2025 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIZ7BVgg"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90B1E1A08;
	Wed, 12 Mar 2025 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756330; cv=none; b=Mr/0vz3SelkWnqPVA0Im15cv2+TxIzWKjxEU5WyG25QXF89TsrWT6NjQfy4hGbatEiEAFLJxfuvDJKcpXFPsWpGeekVRuiHw64xMC1KQBuSYH861a2elXbqD92sJjFeUzGaywLS2HtgXjdp12NSZOeG4XaytEZy+1ZpgWvVTyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756330; c=relaxed/simple;
	bh=0/cs7k9NEYKOzfKSWrMqL/b8KZs7Y/LPsKkPsOmnrDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msSO43AsGYAA9vDKpMNbcKKfs3WHxBfVe0dfAWlOq4TIrej21+u6Z5SmkJzWAAa8VDM1xvTKn1kjZUUzdm2RDRPmkxrZHLtA2ZUgu3QBHsi6gv4cmDx74Hnb90uD4EWUtW2+Nu7ykOczjCfxkr00/p/TOlf7vc5FnPJx+nLlZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIZ7BVgg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fee50bfea5so30506947b3.1;
        Tue, 11 Mar 2025 22:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756328; x=1742361128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfPNOoHpP1FsVmbeiwOjL1eZebItbrovfjcUpFcyo94=;
        b=CIZ7BVggAnjryaaf1tiz2zefG2SJEi8xkcbw5Qz5kVZ+b+QSxW6h6NINkJmJVwNN7+
         7y2VwFxIlN6cL0dVo1T+FKjMicGSwMhQzQtNly1poJvo+8Fz80to64qjYiMNjKI1GMuq
         vqyzI5Pe+0SlQFg+LhVR72JtFVRDF6BGp2B1bvGJYnrYtDa0ttSg3TtBfaiBKKmGtrVO
         OtQV5lK3ZEAjdpBH5NSEgfJljWvPIU88gWXUpqj7oP2SEVsOLUSA6LmV1ds/5JVE2Vht
         PeS3z5SioZ56a2bSHbxva6Kx5HEmQTqS+pVKI0k3piPk5b2faLy0iyu+chJGeZ31t21N
         FaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756328; x=1742361128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfPNOoHpP1FsVmbeiwOjL1eZebItbrovfjcUpFcyo94=;
        b=iGicBQ9/vuGMe17cb0yvHwOsvq0ngM4N0P20gYF94Q+k1iTzftYSM1UQ/cKmZ2M5Rb
         2nl5n7WQ/Gk7Bmd+HzgpjnU0z2X7s3SumonKSbIWh/BLvZ/gxiFsvo1j6bKEo4qrTJsi
         lMWRd283Qkdt/OnQGAny1FVX7GGjnYrmL3+DsK71h28Hy7aE/4fKuoUTren1cKxa/tB5
         ZgyWlW1SXAu75jkxHwu2cuNxGIdBGVmtZ3Ixa+wwakcc+W2M4PebPAJdNE5LDI7n5tTh
         DQYQ1S5V4skOdK3pJjPFIlMEr12jUdIQ9rcGdAQUdhLAM9/WiSBoN6A6U55ghbrvRsTp
         MTNg==
X-Forwarded-Encrypted: i=1; AJvYcCWwLPHorb4qpDuWA0Qp7DJP21pxojP5k5vC8YGZLhkknb9mMzDT6LjeAUFaJ/kgzjxpcCDavfYoZv49YgU=@vger.kernel.org, AJvYcCX0VKQcB0Rlo9/6+vN2HldgTsHuzM31bdH+DZ2v4xbISJECo9WozXn5ig3klh+FT6uLJi8/h0je6ak8aqC/fAok49VYBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyglCgEE0RccQ3pswFdexli/xQE9f5XQY4dOGcjuvmxL16/5oTC
	COsEijoT05QObcK/GBD++pz8wcvByUyCfPK4y3fJ5n+hOkItJ2irIA7117MG
X-Gm-Gg: ASbGncs2HWwzjIDrx+iXFtvEs/pLxPXky4AIsBwdOtkWrsF5i3ea2geK+C+cMP3v9ma
	C8W/DJB38fKhfjCGmkPimUMUe2Bplayen/ao1nH776dahI4TVQR4qH2ivHYyM1NtHlU3lmAmIhi
	oYND8t21pal0tvnXqo+ujOT5LwDRnoiiN42tVDCXvo0K4UD2Xry7vrJzOvCTz8q10umeGyzuWwq
	QkFM7yh9WuWHZlNluvuhsCd2INMQ6CWBveCOCiBRmpTkU6G1nJLlum6m6IyC4eybtZsmzsDB1Wo
	UBfY72aBpS8/y1CXph8zo7z2JSdUFDqFSbqAzjmHJ9XYVQ==
X-Google-Smtp-Source: AGHT+IFu9GDEuRPI9SHsSV4tu4487/eSk8rfb+SYTrCph1E6KcBJB/0KiTAbFi8Hah/GI08FugSHXA==
X-Received: by 2002:a05:690c:3612:b0:6fb:b2c0:71da with SMTP id 00721157ae682-6febf3b37c8mr281791657b3.36.1741756327791;
        Tue, 11 Mar 2025 22:12:07 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:07 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:17 -0500
Subject: [PATCH v5 04/12] platform/x86: alienware-wmi-wmax: Modify
 supported_thermal_profiles[]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250312-hwm-v5-4-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Rename supported_thermal_profiles[] -> supported_profiles[] and change
it's type to u8 because it stores AWCC thermal IDs.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index b9dbfdc8096c571722b3c7ac3e73989e235e2eb9..a8a13779793abbcc8d1263474cac6227d524a6f5 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -213,7 +213,7 @@ struct wmax_u32_args {
 struct awcc_priv {
 	struct wmi_device *wdev;
 	struct device *ppdev;
-	enum awcc_thermal_profile supported_thermal_profiles[PLATFORM_PROFILE_LAST];
+	u8 supported_profiles[PLATFORM_PROFILE_LAST];
 };
 
 static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
@@ -616,8 +616,7 @@ static int awcc_platform_profile_set(struct device *dev,
 		}
 	}
 
-	return awcc_op_activate_profile(priv->wdev,
-					priv->supported_thermal_profiles[profile]);
+	return awcc_op_activate_profile(priv->wdev, priv->supported_profiles[profile]);
 }
 
 static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
@@ -653,7 +652,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
-		priv->supported_thermal_profiles[profile] = id;
+		priv->supported_profiles[profile] = id;
 
 		set_bit(profile, choices);
 	}
@@ -662,7 +661,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		return -ENODEV;
 
 	if (awcc->gmode) {
-		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);

-- 
2.48.1


