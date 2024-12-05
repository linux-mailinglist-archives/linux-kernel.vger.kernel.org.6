Return-Path: <linux-kernel+bounces-432441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577A9E4B49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C840118814A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8CBEAFA;
	Thu,  5 Dec 2024 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMJJ/gzM"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1423918B;
	Thu,  5 Dec 2024 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359202; cv=none; b=olJ9zk22Umw+jmkn2Yq38qWXilnJ1DsNOCXq3dZtG6JvvGwM2YfXTo5x/4jEG+OScZtFTVZCxGN2fRwlS7WK4npOnBA/z5bS09P4up6sPVe/RRu1pTNmdl8OlSNl+oYanHcd+5LwFMNJUD1UOfPAd1lnCo6yb6dX0I9WHsqBS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359202; c=relaxed/simple;
	bh=eB6rqDQZJqYeQ6+a6L0lQmoGUOd81Y85RyheWlqsR/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM07PSV37qmVlGr8cbW8Vn2yEI9u+NGunFtG6q4lrvUto4j0D5pvOu8BYXzKRKK9TE+c2TIaC9Kqh93pYg1P8I4uPYaVsq19VWKilpJVt6XbHeo30oK+s6NmUNRO5AkfjFpcPtvpBxuEOIBe5d33vvCgZFJLmcs+sm44q8c0HCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMJJ/gzM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so381300a12.1;
        Wed, 04 Dec 2024 16:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359200; x=1733964000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+Jtuvl+mnPWEufHbehoFpaa+naDAoewS2n342oQAfI=;
        b=WMJJ/gzMzeQPx8dd/Cq7adGfp/ZjaRDUH67QvRvl+N2nW6ueZYz88sFG0zXRpyNmk/
         VzjWbaY3w0i3fsYfHtqj93G+u91GOgKYlh8zYCgs8/09h1iMyvc3/FLvo5O9g2pG2HXi
         QXLm/79xfFlrlZQdfrEq4MHsDl/AIAePdZuGV0KuF4tEXSzU1MGyoJAhPEWpKwORV/2D
         rc6ZofIdtet/R5dQHZDkfOcuXYZRAre1u23ZrbzKcCmxx0f3LqFK8gqSIZ00lPHGk2uE
         KyahMu2KmgVXGVdEFw8wvs+EqUDl4qsO7Vp7ZbzPRHvGhvvSVcpI1+OXIhUgglMJ6MR9
         l/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359200; x=1733964000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+Jtuvl+mnPWEufHbehoFpaa+naDAoewS2n342oQAfI=;
        b=H42quZCBAReO144QRvB6uHR3AnZkgYQWLVetPWWulM1ycGio/4Ygf8vBOfO6Im8lzE
         OOx84Jd5/yYea5+hv6zvoprCVck5N4NcV8ZN87AS1W5bOLU/IDt05f567fOK0uDmb2cu
         SufPXnrU8VgI6gpAB0xj4LX6ixphznwUDQuDH9gDmOxv4BSVNzNpJFDPv1gYaEDknYGF
         v4hiBkx/6fDnvIUk4vrKpFXxiiMnG3ccgFCMwxpuiLpMF55Z6pnyjdcMg9ng0oN/lrzD
         FVJ89d227OkmGsZtrpq+uguJ2F79hfhfbAdHE2m6FExkmWkrlQp18rpEdyKXuvGZMWFD
         8Vxw==
X-Forwarded-Encrypted: i=1; AJvYcCW1YFzW6r/h+i+RKkWEeBU3PETRjW1GBb+KMkfTNIi6HwAbw1gdwKL9xfuphDa/MHxTqdJZYrrDNXb7g8E=@vger.kernel.org, AJvYcCW2kiy5M86XbdYGmOd3l5oygVraCrzaq8HIR80kq0vicdjETV8+aklph0U3J694emJNXkh9lNAi9of/qx82OtzEi4Dbgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ADYSP6/vPirK2u751nV4DOkl1wkkR0o5z81MRZL/DmNag6/2
	mUPg9NuGOcwxboZHqa/2Z50WaPugRLQiuezG2bH00PkHK0ivLLCy
X-Gm-Gg: ASbGncsAnS4QZWpv5mw06DIUDGVR79zyrF++nmmZbZQ4XmQAe+8t5pIFSvpT9Qhrokz
	wJvdtFG3GE+r9M5qYWfiYalKPdagtmU9SoeDVrw9QSGfkeSzFl2H7DNVf9lB1m6R7Hnq64eIADi
	VLSLyIkONipfxYufytuYGfoSJxhL0T30gQbk6FxetKdEBdhrFxu/dBxOIZosHFnjcQmERrm+VAa
	h8OCvzNM05cIfu2dh2Sj8oFw//JeqCATxwKYAtHpdM1P/xijQ6pmZEH9f9L59ik4gWid8xc8ODZ
	xb7l1RBTfORDvJmkMjY=
X-Google-Smtp-Source: AGHT+IH4xnCC5Pm95+cvkoaE97WlquH6efSLoe+E2GhvRluDbGxXzaCqsRAf3et/tLxQHY4s4Rcz+w==
X-Received: by 2002:a05:6a20:430b:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1e1653b7c9amr11564552637.11.1733359199719;
        Wed, 04 Dec 2024 16:39:59 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5abdsm100574b3a.35.2024.12.04.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:39:59 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 04/21] alienware-wmi: Improve sysfs groups creation
Date: Wed,  4 Dec 2024 21:39:40 -0300
Message-ID: <20241205003939.2184799-2-kuurtb@gmail.com>
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

Devices with hdmi_mux, amplifier or deepslp quirks create a sysfs group
for each available feature. To accomplish this, helper create/remove
functions were called on module init, but they had the following
problems:

 - Create helpers called remove helpers on failure, which in turn tried
   to remove the sysfs group that failed to be created
 - If group creation failed mid way, previous successfully created groups
   were not cleaned up
 - Module exit only removed hdmi_mux group

To improve this, drop all helpers and let the platform driver manage these
sysfs groups, while controlling visibility with their respective quirks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 114 ++++++++--------------
 1 file changed, 38 insertions(+), 76 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 115b3aa5637b..78bbb4ef4526 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -417,12 +417,6 @@ static struct platform_zone *zone_data;
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
-static struct platform_driver platform_driver = {
-	.driver = {
-		.name = "alienware-wmi",
-	}
-};
-
 static struct attribute_group zone_attribute_group = {
 	.name = "rgb_zones",
 };
@@ -803,6 +797,12 @@ static DEVICE_ATTR(cable, S_IRUGO, show_hdmi_cable, NULL);
 static DEVICE_ATTR(source, S_IRUGO | S_IWUSR, show_hdmi_source,
 		   toggle_hdmi_source);
 
+static bool hdmi_group_visible(struct kobject *kobj)
+{
+	return quirks->hdmi_mux;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
+
 static struct attribute *hdmi_attrs[] = {
 	&dev_attr_cable.attr,
 	&dev_attr_source.attr,
@@ -811,25 +811,10 @@ static struct attribute *hdmi_attrs[] = {
 
 static const struct attribute_group hdmi_attribute_group = {
 	.name = "hdmi",
+	.is_visible = SYSFS_GROUP_VISIBLE(hdmi),
 	.attrs = hdmi_attrs,
 };
 
-static void remove_hdmi(struct platform_device *dev)
-{
-	if (quirks->hdmi_mux > 0)
-		sysfs_remove_group(&dev->dev.kobj, &hdmi_attribute_group);
-}
-
-static int create_hdmi(struct platform_device *dev)
-{
-	int ret;
-
-	ret = sysfs_create_group(&dev->dev.kobj, &hdmi_attribute_group);
-	if (ret)
-		remove_hdmi(dev);
-	return ret;
-}
-
 /*
  * Alienware GFX amplifier support
  * - Currently supports reading cable status
@@ -858,6 +843,12 @@ static ssize_t show_amplifier_status(struct device *dev,
 
 static DEVICE_ATTR(status, S_IRUGO, show_amplifier_status, NULL);
 
+static bool amplifier_group_visible(struct kobject *kobj)
+{
+	return quirks->amplifier;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
+
 static struct attribute *amplifier_attrs[] = {
 	&dev_attr_status.attr,
 	NULL,
@@ -865,25 +856,10 @@ static struct attribute *amplifier_attrs[] = {
 
 static const struct attribute_group amplifier_attribute_group = {
 	.name = "amplifier",
+	.is_visible = SYSFS_GROUP_VISIBLE(amplifier),
 	.attrs = amplifier_attrs,
 };
 
-static void remove_amplifier(struct platform_device *dev)
-{
-	if (quirks->amplifier > 0)
-		sysfs_remove_group(&dev->dev.kobj, &amplifier_attribute_group);
-}
-
-static int create_amplifier(struct platform_device *dev)
-{
-	int ret;
-
-	ret = sysfs_create_group(&dev->dev.kobj, &amplifier_attribute_group);
-	if (ret)
-		remove_amplifier(dev);
-	return ret;
-}
-
 /*
  * Deep Sleep Control support
  * - Modifies BIOS setting for deep sleep control allowing extra wakeup events
@@ -936,6 +912,12 @@ static ssize_t toggle_deepsleep(struct device *dev,
 
 static DEVICE_ATTR(deepsleep, S_IRUGO | S_IWUSR, show_deepsleep_status, toggle_deepsleep);
 
+static bool deepsleep_group_visible(struct kobject *kobj)
+{
+	return quirks->deepslp;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
+
 static struct attribute *deepsleep_attrs[] = {
 	&dev_attr_deepsleep.attr,
 	NULL,
@@ -943,25 +925,10 @@ static struct attribute *deepsleep_attrs[] = {
 
 static const struct attribute_group deepsleep_attribute_group = {
 	.name = "deepsleep",
+	.is_visible = SYSFS_GROUP_VISIBLE(deepsleep),
 	.attrs = deepsleep_attrs,
 };
 
-static void remove_deepsleep(struct platform_device *dev)
-{
-	if (quirks->deepslp > 0)
-		sysfs_remove_group(&dev->dev.kobj, &deepsleep_attribute_group);
-}
-
-static int create_deepsleep(struct platform_device *dev)
-{
-	int ret;
-
-	ret = sysfs_create_group(&dev->dev.kobj, &deepsleep_attribute_group);
-	if (ret)
-		remove_deepsleep(dev);
-	return ret;
-}
-
 /*
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
@@ -1169,6 +1136,23 @@ static void remove_thermal_profile(void)
 		platform_profile_remove();
 }
 
+/*
+ * Platform Driver
+ */
+static const struct attribute_group *alienfx_groups[] = {
+	&hdmi_attribute_group,
+	&amplifier_attribute_group,
+	&deepsleep_attribute_group,
+	NULL
+};
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = "alienware-wmi",
+		.dev_groups = alienfx_groups,
+	},
+};
+
 static int __init alienware_wmi_init(void)
 {
 	int ret;
@@ -1208,24 +1192,6 @@ static int __init alienware_wmi_init(void)
 	if (ret)
 		goto fail_platform_device2;
 
-	if (quirks->hdmi_mux > 0) {
-		ret = create_hdmi(platform_device);
-		if (ret)
-			goto fail_prep_hdmi;
-	}
-
-	if (quirks->amplifier > 0) {
-		ret = create_amplifier(platform_device);
-		if (ret)
-			goto fail_prep_amplifier;
-	}
-
-	if (quirks->deepslp > 0) {
-		ret = create_deepsleep(platform_device);
-		if (ret)
-			goto fail_prep_deepsleep;
-	}
-
 	if (quirks->thermal) {
 		ret = create_thermal_profile();
 		if (ret)
@@ -1242,9 +1208,6 @@ static int __init alienware_wmi_init(void)
 	alienware_zone_exit(platform_device);
 	remove_thermal_profile();
 fail_prep_thermal_profile:
-fail_prep_deepsleep:
-fail_prep_amplifier:
-fail_prep_hdmi:
 	platform_device_del(platform_device);
 fail_platform_device2:
 	platform_device_put(platform_device);
@@ -1259,7 +1222,6 @@ module_init(alienware_wmi_init);
 static void __exit alienware_wmi_exit(void)
 {
 	alienware_zone_exit(platform_device);
-	remove_hdmi(platform_device);
 	remove_thermal_profile();
 	platform_device_unregister(platform_device);
 	platform_driver_unregister(&platform_driver);
-- 
2.47.1


