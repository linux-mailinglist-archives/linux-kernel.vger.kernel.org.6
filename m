Return-Path: <linux-kernel+bounces-432455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B29E4B68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA3163AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9310A1F;
	Thu,  5 Dec 2024 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6vx2i4/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D1CA6F;
	Thu,  5 Dec 2024 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359532; cv=none; b=Ys25yWDK2mTUrRm+j6CdDPHV0TZU+biNOsWGEbmqz2YdA7wWbrLfh/527w7ExJoAPLwXbq21gIzb8bRXsWx+v1Hgycs36vLTeMNLz80q1eU2cN8QI/55gA75gy594+CfZLzU0IDLKW07JF7f/QaZ/gZcmdWY4aBtTKnTPQ4f28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359532; c=relaxed/simple;
	bh=XaaeTh4i9x9GcUZBoJdkg6ob76CEdYTvanlP7WUGrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWQTH8YCUkQUcQvWPFwWo1Ij9hgdqjUp7CfMR5K1juWg3j9eUEbvJ1BnuVHLNOoT6dpx/ryivozeHoVdpgtASdoVzUePqizkorkVwISAsy+9augdQQcK2hlcPQdunw4XmsPnDZRQ1FnfEcrRKJ4tWSgd3Rj/tMYvb+IGMjsyspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6vx2i4/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2153e642114so3121145ad.0;
        Wed, 04 Dec 2024 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359530; x=1733964330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soMelWL1/UQuv4PwOE6os4uBGru2kyLXQzhxEqo4tZA=;
        b=i6vx2i4/sGx8oCxEPXdce7eIqftw+tIc4RLCz/OE6rucP6crZbeXCUos7p9aKgHnAx
         CHEQCzrDNDOIuckAFjaEgkPoB+/RxrqbfWfvXJlZsFBn71M6FsJwv9/qykXQJt5M44BH
         shMEqx92e1bYczF8yXiC0fO/EyFxC0u0AixhKxLV0k59NguiSgBAQQIw100YcOsUftZ+
         hVP9FO+/ndTCirg1eQQjSeNhW277E0dK21XsSae4C8yR5Em1JkQ4mbBgUHucJHX4V2+c
         sl9S8whYSlUPvo1+DbXU7Qn8ThRDe6ESTvw1KmvynFSyLUUFbG5YASRE5Cxsmz6m2g8f
         u5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359530; x=1733964330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soMelWL1/UQuv4PwOE6os4uBGru2kyLXQzhxEqo4tZA=;
        b=B6GaWH3T6encbsqonxRWhVoiSrHV/OjzKquNR1A1l2aTwAP7ucMB1d6emUOt7QFYQH
         K3wfPuvrA0OVNJl4ekCNVWs2mRjcYdyfbg3u6iU+5lK9SDAvBDViqMAsuqo8GGHt6Kuc
         bnAJNh1+pHM6ir+Zn5HNvUoYzK/2KZeteogjpLEu4UOUtXpJMeQvOZvraXWfCSwZs1Fk
         ubTFZI9xHyYPM8h8iha/yqYmxTQP2TG214n4Lg+jBC1dXgXw3dNPZSLA0pInSBr9Ag9e
         OaxwLqCbbgZW7biNEkq36RIcJR+IRcSroLpVA/VLoKZKBcoWeTLGUpoaeNlkRdJ/Cf43
         EWSA==
X-Forwarded-Encrypted: i=1; AJvYcCVCbMYCKptV0s2O+9C/Rc5EoDK+AuQozbPuDVEFBQN/hVrOiLfQhYCdBV13Cy5err8h8zNSL0qyotKyWqvKJo/Bxkv7AQ==@vger.kernel.org, AJvYcCW7hy6GUy1tqVf9wBhpJ3KvVJghlOEMmDkz/2z0l/navvzi5qXVBO/h9FN052l/9JXaLjivxikFuaNhyCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15pFwRPKzKl5EcDEtca+zHRcek2G6dXGufJN4ePimG2XW2C4P
	FecM14EO8fSj71KujSyV4NUdz2cIFJPn7FGhziDGIQFyqHdJdDtH
X-Gm-Gg: ASbGnct79MaSOsK/ahafw43rorWBw5JsnqeNIKZDM6PyXcChJh7DTEnLR+i0UtLuLob
	6M79vmcOPvojbkQXSsxgd9DahSFPN6d4C7v1d5zwdv2diqgETMBp0tkge8j3+TZ6L4NDLaZOKsM
	pwR3oOYl2Es3TNYtTFkq9+bhgvSsfc0wKv2ljdMMGYjf1Efzen5HeIpIuyyGbUbDMKTfQbwF+7t
	BKlLpyx7mm+35GKyF+qX2RNW5z6/qqHBoJBM2XwN6BGMD1fIKlSbC6ApzigRmEigQBYcv1GBdCo
	qWHIF3DXnB/BIIunzV8=
X-Google-Smtp-Source: AGHT+IEV+4iLTnRE7vFLN2dsQHUYs+JAPWWL3QLDKIzFNjanYtt7/v7YLAQSqKHy7+wdek6dN9A0OQ==
X-Received: by 2002:a17:903:2343:b0:215:5a53:eded with SMTP id d9443c01a7336-215bd241404mr127216975ad.39.1733359529938;
        Wed, 04 Dec 2024 16:45:29 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa535sm1338625ad.129.2024.12.04.16.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:45:29 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 15/21] alienware-wmi: Refactor sysfs visibility methods
Date: Wed,  4 Dec 2024 21:44:58 -0300
Message-ID: <20241205004457.2186386-2-kuurtb@gmail.com>
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

All sysfs visibility methods relied on the `quirks` global variable. To
avoid this let the WMI drivers set this information as platform specific
data, and refactor visibility methods accordingly.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 52 ++++++++++++++++++++---
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 18a15dcf90a3..25e0139ed78c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -427,6 +427,10 @@ struct alienfx_ops {
 struct alienfx_platdata {
 	struct wmi_device *wdev;
 	struct alienfx_ops ops;
+	u8 num_zones;
+	bool hdmi_mux;
+	bool amplifier;
+	bool deepslp;
 };
 
 static u8 interface;
@@ -597,12 +601,24 @@ static DEVICE_ATTR_RW(lighting_control_state);
 static umode_t zone_attr_visible(struct kobject *kobj,
 				 struct attribute *attr, int n)
 {
-	return n < quirks->num_zones + 1 ? 0644 : 0;
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return n < pdata->num_zones + 1 ? 0644 : 0;
 }
 
 static bool zone_group_visible(struct kobject *kobj)
 {
-	return quirks->num_zones > 0;
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->num_zones > 0;
 }
 DEFINE_SYSFS_GROUP_VISIBLE(zone);
 
@@ -737,7 +753,13 @@ static DEVICE_ATTR(source, S_IRUGO | S_IWUSR, show_hdmi_source,
 
 static bool hdmi_group_visible(struct kobject *kobj)
 {
-	return quirks->hdmi_mux;
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->hdmi_mux;
 }
 DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
 
@@ -786,7 +808,13 @@ static DEVICE_ATTR(status, S_IRUGO, show_amplifier_status, NULL);
 
 static bool amplifier_group_visible(struct kobject *kobj)
 {
-	return quirks->amplifier;
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->amplifier;
 }
 DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
 
@@ -862,7 +890,13 @@ static DEVICE_ATTR(deepsleep, S_IRUGO | S_IWUSR, show_deepsleep_status, toggle_d
 
 static bool deepsleep_group_visible(struct kobject *kobj)
 {
-	return quirks->deepslp;
+	struct device *dev;
+	struct alienfx_platdata *pdata;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdata = dev_get_platdata(dev);
+
+	return pdata->deepslp;
 }
 DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
 
@@ -1211,6 +1245,10 @@ static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
 			.upd_led = legacy_wmi_update_led,
 			.upd_brightness = legacy_wmi_update_brightness,
 		},
+		.num_zones = quirks->num_zones,
+		.hdmi_mux = quirks->hdmi_mux,
+		.amplifier = quirks->amplifier,
+		.deepslp = quirks->deepslp,
 	};
 
 	if (quirks->num_zones > 0)
@@ -1291,6 +1329,10 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 			.upd_led = wmax_wmi_update_led,
 			.upd_brightness = wmax_wmi_update_brightness,
 		},
+		.num_zones = quirks->num_zones,
+		.hdmi_mux = quirks->hdmi_mux,
+		.amplifier = quirks->amplifier,
+		.deepslp = quirks->deepslp,
 	};
 
 	if (quirks->thermal)
-- 
2.47.1


