Return-Path: <linux-kernel+bounces-432464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A757F9E4B80
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E431880764
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657E11B59A;
	Thu,  5 Dec 2024 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqSKL1xz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359517BD6;
	Thu,  5 Dec 2024 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359706; cv=none; b=pLt+er5vU+lLTbiyzQ/SWv0zUh87usbhWHobB16sKoYHcy5u+OgJZaOTicmmooApAyaNwpZ2BsjhcrxpLVn64KqNJ3JVsmmc8rBvVhzk6mrhQ24OccbMLIQhPPbkjQDvq7IYZrj1HnbMcpLQvOFRdw9D/aG2ALE8z0wHMjGQAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359706; c=relaxed/simple;
	bh=U9buNCn3Q6EwBDv1ejzzt7584TCtyKt3bwWsdIBPaRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SosCRFfXcI7X3JrDu+s2mVlADD2dHWn0jTkXzjma+j53Kw31sFvfb40XOrRbE73jgVM7btCh1RWOLKnAdiM127uBCGu/xMSGjPTHmHMD3Yu0OtF0HHzjc4wuLFcALueovJPtbpwv6CaRhGpt/XSnbGSCVtYSyayzeHOEI57z7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqSKL1xz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215c4000c20so3735135ad.3;
        Wed, 04 Dec 2024 16:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359704; x=1733964504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V9Nc2MLGRoLsywNBsHM1XPUkoBaWbrhQmpIa1sSKzU=;
        b=aqSKL1xz5sPdGK2YrhH2uDy7eSd+xGRL1SH7xRHxOWxmcV9dxF3iNaRbKc933JVpR4
         gz+rwQll1bUlAOqJM5gXhX228ZEFtPZ62MD9eCejemjqpxvBe1PI340sxKjMjp5tbrO5
         HkVpo/WJTkp3v86hB4rIoOrfpovbp3pWj9X6SmRYKiPgxYB/buRYlh6Kbh76oX8QVEDe
         p4FkF8xKE3V4WyVBwJ4Tw3spPR+pQMsLb86jqJ6NvSf2eih8rl3lYcbhtR1MVIf+6aQY
         slowIEednpO3Qqjten0nJjJ4hV/GosJvwmVv9m+fGtO2srRl3yRIaM7m3MDitW6yC5Q1
         cqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359704; x=1733964504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V9Nc2MLGRoLsywNBsHM1XPUkoBaWbrhQmpIa1sSKzU=;
        b=l6I72+VEKadIRIPWup5W0XpVWJNEJgLeIH3wDYTOHsbpu+ZqGBRrW+HHK6JVQwhx2F
         1t/ROigpCTSrAEitrGnk0gH+aD4k6atoifXqL9WR+FpRBEQB7TeqrCV+ZSNfAmVaZ7UQ
         ON6bozFsusTKMT+4akBmt7b06SG6EWyOHIqUY3eFz41QUzARUQWdd+ycO4HmWV7uQz+l
         sprIaJkZpVj73biOWna9JefcOM6kd6dwm/AsKZIGHCw66ypYTE3+lB4TXMAdZX0VgAxe
         njNn66pZV7g1s6aV/yXD+9yX5kei6kTVzaapWUjnPXAzrq8eW4ZYHIY5BZPiCQKrca1O
         VRRA==
X-Forwarded-Encrypted: i=1; AJvYcCUalRLQbZofrn2qy7B831gkX6WAlGhaMsH6W1er3Y3J861S9WgdCSYRDtyaTxhW5zs/vR/4pcORzt0Oz4bNTpssDC0Jgw==@vger.kernel.org, AJvYcCUwc3e2KQZMrQZWvEllOqLAQMC1sLN+lwJ6Mvmxpvt8HMeMwYeE4B4sBbSIBvg48sRvPGPv6dBB1Y+zqc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBa+DiKfLlXTcdlPS+pfSy1ZKYZlbmAtl0sGwR38i3xkQVjmms
	y+MgYhuNgzWYqzYcmwmMD+cP3i7SBocWL+4sApdoeItdn3mVAdv5JVtf+WGd
X-Gm-Gg: ASbGnct5/ZP5GfJCqhwq6G3xy+vlaKU0+nzzujvsIixmV2bZDdNdT1ucyawaBsgI1pD
	ZYE88edZevjCo28O6Ck555lmh82e6zNrdhernHRVn+X9LkyRMCJf+JVoC2veyhkTaj/PtteRiim
	+oTT9QbcAg13KVHvEWIAxCiBdG/C5oJ1BtLGpf2WlJV+4TBLiDZSdE/N6KePRJ6Nl7lBKK2tYCr
	ALjfT3rUl6R4RlymQITNyxzfWLyuETEWC4hmTlDAHZmclmtlEIck3++7Tp/ArlOa7k3X72V/g3q
	7C2eldLeg9vBDs9LbiY=
X-Google-Smtp-Source: AGHT+IHdW9EoBC+guyiuoiRxfVcpdxSPxViXTfYiPBAPPbJb7JPwiQUl+M5/dg7Emlzr5VAx6iaM2Q==
X-Received: by 2002:a17:902:cec2:b0:215:7fad:49ab with SMTP id d9443c01a7336-215bd1b3babmr103860265ad.10.1733359704549;
        Wed, 04 Dec 2024 16:48:24 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0921asm1384655ad.178.2024.12.04.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:48:24 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 21/21] platform-x86: Add config entries to alienware-wmi
Date: Wed,  4 Dec 2024 21:48:05 -0300
Message-ID: <20241205004804.2187253-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add config entries to conditionally compile alienware-wmi-alienfx.c and
alienware-wmi-awcc.c.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/Kconfig         | 25 ++++++++++++++++++-----
 drivers/platform/x86/dell/Makefile        |  8 ++++----
 drivers/platform/x86/dell/alienware-wmi.h | 22 ++++++++++++++++++++
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 2dddafb3f7fa..fcc7f7d28ac1 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -18,16 +18,31 @@ config ALIENWARE_WMI
 	tristate "Alienware Special feature control"
 	default m
 	depends on ACPI
+	depends on ACPI_WMI
+	help
+	 This is a driver for controlling Alienware WMI driven
+	 features.
+
+config ALIENWARE_ALIENFX
+	bool "Alienware AlienFX backend"
+	default y
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
-	depends on ACPI_WMI
-	select ACPI_PLATFORM_PROFILE
+	depends on ALIENWARE_WMI
 	help
-	 This is a driver for controlling Alienware BIOS driven
-	 features.  It exposes an interface for controlling the AlienFX
-	 zones on Alienware machines that don't contain a dedicated AlienFX
+	 It exposes an interface for controlling the AlienFX zones on
+	 Alienware machines that don't contain a dedicated AlienFX
 	 USB MCU such as the X51 and X51-R2.
 
+config ALIENWARE_AWCC
+	bool "Alienware AWCC backend"
+	default y
+	depends on ALIENWARE_WMI
+	select ACPI_PLATFORM_PROFILE
+	help
+	 Provides thermal control features on Alienware and Dell's
+	 GSeries laptops with a WMI device with UID "AWCC".
+
 config DCDBAS
 	tristate "Dell Systems Management Base Driver"
 	default m
diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
index 54a592fd6ae6..6153cff5538f 100644
--- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -4,10 +4,10 @@
 # Dell x86 Platform-Specific Drivers
 #
 
-obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
-alienware-wmi-objs			:= alienware-wmi-base.o
-alienware-wmi-y				+= alienware-wmi-alienfx.o
-alienware-wmi-y				+= alienware-wmi-awcc.o
+obj-$(CONFIG_ALIENWARE_WMI)			+= alienware-wmi.o
+alienware-wmi-objs				:= alienware-wmi-base.o
+alienware-wmi-$(CONFIG_ALIENWARE_ALIENFX)	+= alienware-wmi-alienfx.o
+alienware-wmi-$(CONFIG_ALIENWARE_AWCC)		+= alienware-wmi-awcc.o
 obj-$(CONFIG_DCDBAS)			+= dcdbas.o
 obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
 obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
diff --git a/drivers/platform/x86/dell/alienware-wmi.h b/drivers/platform/x86/dell/alienware-wmi.h
index 1c12b8e330e2..16624c824828 100644
--- a/drivers/platform/x86/dell/alienware-wmi.h
+++ b/drivers/platform/x86/dell/alienware-wmi.h
@@ -110,10 +110,32 @@ struct awcc_priv {
 acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
 				  void *in_args, size_t in_size, u32 *out_data);
 
+#if IS_ENABLED(CONFIG_ALIENWARE_ALIENFX)
 int alienfx_wmi_init(struct alienfx_platdata *pdata);
 void alienfx_wmi_exit(struct wmi_device *wdev);
+#else
+int inline alienfx_wmi_init(struct alienfx_platdata *pdata)
+{
+	return 0;
+}
+
+void inline alienfx_wmi_exit(struct wmi_device *wdev)
+{
+}
+#endif
 
+#if IS_ENABLED(CONFIG_ALIENWARE_AWCC)
 int create_thermal_profile(struct wmi_device *wdev, bool has_gmode);
 void remove_thermal_profile(void);
+#else
+int inline create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
+{
+	return 0;
+}
+
+void inline remove_thermal_profile(void)
+{
+}
+#endif
 
 #endif
-- 
2.47.1


