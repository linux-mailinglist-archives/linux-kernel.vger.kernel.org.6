Return-Path: <linux-kernel+bounces-416110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E69D405B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179D81F22818
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CEC1527B1;
	Wed, 20 Nov 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khhn0moY"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273F148FE8;
	Wed, 20 Nov 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121046; cv=none; b=Wew6l/P4WTsHCmcktGse+kD8Jv8z2THwHyLnDuPR2LhACc+SAbSEi9PZqNpiuIyrSpd3KvNM/b8q0Xj85rMIegFqKuQAeboL2KHa2OdRzsbOzxzisfbbx97NLjhsGGy7usWv3MucbIpfB5WzSvPCzNVR35++YERsPTiISnDrN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121046; c=relaxed/simple;
	bh=VCGY9U7LwXliYd6d+9B7ied1jKmWIaArbzCfTm1DXuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7KnsYjq0yCWTPFZxHorSBKrOkoJkvX51s2XDQg/kkrAUtLCWLi2bjOVg43pszGJ31MBuW4TdXhv9rlr3o534YprBb4h9tqMeJAVRFP0brUXD/kopVHHih+oDn/OhBxzhFSOnvPkUTZhHpGRGvJ2WfxmuJCTru89FpDNvmHi4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Khhn0moY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2128383b86eso8285ad.2;
        Wed, 20 Nov 2024 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732121044; x=1732725844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vXq/v2AMJrAH9GOZRUpvetNG/P2rLtArw5ggNX+AwQ=;
        b=Khhn0moY5hlzQJspLmH5fh+iNNcOjIhbL7MAA0nJ3w/byK2bA0+zZEZjvFtrie05dU
         N2n0p23i1gadN+nNOXfiJhjeLrbJpNFsXlnGZ4tiEEFLkreOEsCbfRO7jcWbOhFFZ7E2
         F9ShsaCUDYEGV4cbbKJr/Xih6ss13t+SKJ6ZHAN8BjpSSy9quJwYoFch0rpzGQyQAgdO
         8zjShw+aMkKBqIncnACnVc9X8x4Iznyctpx55V1EQDSxhaTE3AoQv9W5yDP5gDcfjtku
         fEPmKoVhx2Um1tUPtcEwpJtbv82KkiiCKsD9FWY0VMVk+fAOEoHaKjvUCAKTequCVMXE
         e6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121044; x=1732725844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vXq/v2AMJrAH9GOZRUpvetNG/P2rLtArw5ggNX+AwQ=;
        b=nj2ALoEnOMgNqkFucLDFIPoehz74RYA4bnLzHuaY5Iwkz3CxMDAl10mZ8qcdaK5/x9
         FuHWq3OR+J5dN8mnUREI9YxWESA31mQfPUf5Oa6DHgcTGSEKlHDcjouWPl+fSt0Zv3jE
         p4dvq8XlMlaGTEny2pR6iMF8qbLYy1XDSAd62pBeIawAs6/aBR383H4xSLdGkmk+OoA9
         AIxWcHoOdS5o1egpNfU2rkTU3JaA5Bvcz0khH1rzx1GUuvdPyUCCYKBkOFsm3K7Ci+4J
         Aj6N9BN7ZVTxp5cRiWQBvRIvUOiUwAsKgbyUd0rZBCNc5l+rMj4QCKIexOMG8T3FAjka
         lcBg==
X-Forwarded-Encrypted: i=1; AJvYcCWs83J2LlQn16Chol9qlft3vZk080E0WcRg8BMZCoWjgNJgjozamngdpH8OF4S8qdOrZHkjZF1fmstbQRqsAvaFdYmCqg==@vger.kernel.org, AJvYcCXja4mLSp8dgR4Km0PSkRzO16cTcdQB5O2SM/TS3ULP4qnEoP0IAwu3dgw9gRpJRaCNmCdDVsbAqzCPEVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXeE8gBtt60AvwkxZNnpT9Ude9pwejz/UoiLWxNGbVNn4x5IbC
	WEYQ73Gnwidr44imK9XQkIGT5u5W0psCaiAB81/6odTFMMr49dIO
X-Google-Smtp-Source: AGHT+IE2ZNOi976fSbaTwURst4LgXE6RnNg00hQA2pr90t3Ffu1ZFVaejX9M0pVhEjAL8iJkyf8dxg==
X-Received: by 2002:a17:903:251:b0:20c:9d8d:1f65 with SMTP id d9443c01a7336-2126c11bf0fmr42262905ad.30.1732121044085;
        Wed, 20 Nov 2024 08:44:04 -0800 (PST)
Received: from localhost.localdomain ([181.84.94.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21253806c73sm32467485ad.157.2024.11.20.08.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:44:03 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH v2 3/4] alienware-wmi: Simplify platform device creation
Date: Wed, 20 Nov 2024 13:43:49 -0300
Message-ID: <20241120164348.7326-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120163834.6446-3-kuurtb@gmail.com>
References: <20241120163834.6446-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify platform device creation by using
platform_device_register_simple().

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
 - Unchanged
---
 drivers/platform/x86/dell/alienware-wmi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index ecab14d90b27..512f6b22585c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1163,14 +1163,13 @@ static int __init alienware_wmi_init(void)
 	ret = platform_driver_register(&platform_driver);
 	if (ret)
 		goto fail_platform_driver;
-	platform_device = platform_device_alloc("alienware-wmi", PLATFORM_DEVID_NONE);
-	if (!platform_device) {
-		ret = -ENOMEM;
+
+	platform_device = platform_device_register_simple("alienware-wmi",
+							  PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(platform_device)) {
+		ret = PTR_ERR(platform_device);
 		goto fail_platform_device1;
 	}
-	ret = platform_device_add(platform_device);
-	if (ret)
-		goto fail_platform_device2;
 
 	if (quirks->thermal) {
 		ret = create_thermal_profile();
@@ -1187,9 +1186,7 @@ static int __init alienware_wmi_init(void)
 fail_prep_zones:
 	remove_thermal_profile();
 fail_prep_thermal_profile:
-	platform_device_del(platform_device);
-fail_platform_device2:
-	platform_device_put(platform_device);
+	platform_device_unregister(platform_device);
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
-- 
2.47.0


