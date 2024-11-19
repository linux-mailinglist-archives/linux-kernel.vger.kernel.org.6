Return-Path: <linux-kernel+bounces-413831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A009D1F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB72281022
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6414D6ED;
	Tue, 19 Nov 2024 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeFGDfMy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C93149C57;
	Tue, 19 Nov 2024 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990930; cv=none; b=WitiFL3Fn51VrpJ7qtL/acYZwREl0a4ocjZkDXmgc2sMsh0d0/Ef1cqirz/OOjqwX6F4gPQjtd4MpY73unbjJbOcUlXM8Wj2IRwU/hCaE9GA/q14NulpEAYKUNQXGwbJrR3XwjSkTr4bYnSkyEbM0lr8TgUWauHjrwqtaA9KfPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990930; c=relaxed/simple;
	bh=8wuAZsTBhNUwhdQkZXHbwWv41FpbwOHG9TqAiR1vqc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYmnzP02SKFTPhEGhJR39Y93L13EKXzv9je9TOfeBLnPT30ooYg1NkrVCY8bql6A8XfLiKjeq8NGaVeV5AJm5vsLxEsBNHASzaS7F3IdAleraI29jkhSbprh/n4sbUZJScswgjKg0jGB3o1fKt38jHIrRumt4KKHS8iP8grvzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeFGDfMy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c70abba48so23089195ad.0;
        Mon, 18 Nov 2024 20:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731990928; x=1732595728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7f3VVsKlKn3uK84HbMZ0iSO4Dt/y5UTYoKWdW3JUriM=;
        b=VeFGDfMy9pNg3llDmup/BgxuFRbASl7ZirUSX7vrhvMVHZAoLu/+xsv1LLMuOD8rGI
         58aJnF/K8cMsr/pdC/t1yrpyOKrEUIA1DfejCZr9nT6juUxUYOrlVNT684bmwNpUzazI
         AocDvd5T5iQIEX5zCugFOfGlAhrcJCQuotMO9HXyDgm9d9jh123ewmpT6SdOeyCWPOv8
         CrcYs8AbzL/TZtvKop8zzTYDmVzqrp1uAbhmqsDoSogrw5OmOf1xZDILgnTa8of/tZYx
         Dh/Ed7YygfvJ7nQfVKTXHkkFk+ek3KSblUs8iQR3IYATA/PRC+hGgqTyFi2fdx6pTh71
         P3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990928; x=1732595728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7f3VVsKlKn3uK84HbMZ0iSO4Dt/y5UTYoKWdW3JUriM=;
        b=Ker13BLnGEx12PngLR+B4J/aaPrc/AISgtNNZMm9xVfDB2GlvxkJxb97RTMlfyYHLE
         p79A7BQGvNFvCCDtQykRwxfXracIkFCAuAONg8dGcHi8Ih7s4gZtF47gpj+Ibr24jEqm
         punNZZuJzJQAjEHkGQDn+GF0ah8TSNUWuSd1IHPUhK0UnTm/YQu6fG2LLVhw05+9pJRn
         3QbKpD4A1oQ6DzLoLbaEP3eKfAVlmyistV/95+h+V9dZv9to8IPjtpux7zRMInXbcuGq
         GRyb16sbA2sYn/606S1/cjYb0/9QndeKcZIJCIvsYCFhjhtDlofZUj40QGWToBbGHnQV
         GcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaZWMzpDk0124uRvsWu2CQQc6yTeJo1u7mxTeGicR9J7+lhLvywM7G4D+f9q3aQi/VpAYyoiERZck6umE=@vger.kernel.org, AJvYcCXTD+i6Owk5RtS/fbZTCjaGLVYMrlZiiFdnxc0PTFIIurtL17deBFBw4hcws3No3JG8qpf0NVIC1QG+wdjYlOedzomg+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ov85l3VBbGO4zfz9ojlU6S+8FyL3fDNz0Gjx1n/eEjfgqHCP
	Wmz2hs2sZsgfZ5/Vyq2DRgvIoaiKeurcZ5YsrbrEuA/fiobSTf8Z
X-Google-Smtp-Source: AGHT+IFLot3x/OiWOd2HLL0ZEAOvNkW+em39WPt3+hKjvb6vOhBcOvY1ficoZJafNEV6gU63PXTj7A==
X-Received: by 2002:a17:902:cecf:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-211d0ebf182mr190185955ad.46.1731990928332;
        Mon, 18 Nov 2024 20:35:28 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211fb9cb4e7sm44953045ad.217.2024.11.18.20.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:35:28 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH 4/5] alienware-wmi: Fix module init error handling
Date: Tue, 19 Nov 2024 01:35:23 -0300
Message-ID: <20241119043523.25650-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate led_classdev_register return value in case of error.
Call led_classdev_unregister in case sysfs_create_group fails.

If alienware_zone_init fails, alienware_zone_exit should not be called
because the latter unregisters/removes the led class and the sysfs
group, which may not be registered/created if the former failed
prematurely.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 980ffc545093..44f1f7b57d0a 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -628,6 +628,7 @@ static int alienware_zone_init(struct platform_device *pdev)
 	char *name;
 	struct device_attribute *zone_dev_attrs;
 	struct attribute **zone_attrs;
+	int ret;
 
 	if (interface == WMAX) {
 		lighting_control_state = WMAX_RUNNING;
@@ -675,9 +676,19 @@ static int alienware_zone_init(struct platform_device *pdev)
 	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
 	zone_attribute_group.attrs = zone_attrs;
 
-	led_classdev_register(&pdev->dev, &global_led);
+	ret = led_classdev_register(&pdev->dev, &global_led);
+	if (ret < 0)
+		return ret;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &zone_attribute_group);
+	if (ret < 0)
+		goto fail_prep_zone_group;
+
+	return 0;
 
-	return sysfs_create_group(&pdev->dev.kobj, &zone_attribute_group);
+fail_prep_zone_group:
+	led_classdev_unregister(&global_led);
+	return ret;
 }
 
 static void alienware_zone_exit(struct platform_device *dev)
@@ -1223,7 +1234,6 @@ static int __init alienware_wmi_init(void)
 	return 0;
 
 fail_prep_zones:
-	alienware_zone_exit(platform_device);
 	remove_thermal_profile();
 fail_prep_thermal_profile:
 fail_prep_deepsleep:
-- 
2.47.0


