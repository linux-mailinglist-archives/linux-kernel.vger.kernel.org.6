Return-Path: <linux-kernel+bounces-413828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C31C9D1F44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59E62817BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B485914B945;
	Tue, 19 Nov 2024 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B61HWkvw"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866A14883C;
	Tue, 19 Nov 2024 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990879; cv=none; b=AWp/tEtDU1R58YS/eZlGseN2vsOqBJbkfiTKIMAUT+lGYtvxYXBBjz1IehD47tHbdPb+pOImLhdfGv0DgklhZYUDDag3hyc40LOFDpUYbNk4ReawPO2ia7kk0higwEcYGJdL8fheqz9nWvfelmgejDypGDWtK3zT6eVA3tOL3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990879; c=relaxed/simple;
	bh=SEQpEaowS0OdYUDTCat7cY8a/l1lk//Ix8hlUOQQ6oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLcaUg6+n15uy+L7hsPkzLF4fvqneN3Pu+bbNTwYf/8eHVqAV5JnWDhi6X+Ri7IhPJfwvoD+cSDiL+hrPq4z+GHClEEMkY/ghUVpoFCCBQEushYVCTQ3mXv4lRj1xNh0s5PLlyUcZ6xNe/YzMu/z17+pDOiS1n7gUDurMvI0HoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B61HWkvw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cf6eea3c0so4612915ad.0;
        Mon, 18 Nov 2024 20:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731990877; x=1732595677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MGnvmdEROwEwV4J3OrYTF1e+3PLHvjyYjupX2tzbmI=;
        b=B61HWkvwIrenN0WxeZhLY/sl7xlSIHBY3iDqm9iTblNH4Q94Ohx037oEZzQaLcxgMk
         9ZHKmlrdb59RPRa6+G/TibjQq7pgk3oooOYsPnRKNmohnB1+VRBm0l+a+ANK/V07vS2q
         kJDXRlb1ClJrGEJJSLWjVj/eUEbPyuHxRirWBYbJ8OMk2m5lB6791gGNR+MlNOLs/i1t
         0WsaZ4aGUKKn6R97OV2RKxe+kPdrCc6W0zyGm/e9pmVD2CPSL/ZzqbwnJkgsWaPcigq3
         lv6Vt8+KIchwW/c5NgNuUbn1Wm8n+2A0lKsFCjlfpESk7VBVEI7rxtBjVzhjRPt/9JmX
         hD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990877; x=1732595677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MGnvmdEROwEwV4J3OrYTF1e+3PLHvjyYjupX2tzbmI=;
        b=VfVC5AhVnBzQlrd38G4Vw8b9zvFVeCqkqSerQwri1xCLxHqkKXouD58V6O2yQ21cwD
         YHiHNkPcwnt/s0Uo7prrr7BpnyGlz7mWmtBaHFwxDGwWoSUwSWkC0p4CEKeYyRYVxI5U
         YdfK5HEqa9VsAjZGTCcg0X6zLnkD5Sz5l0g/iJo7A8812oDtbdL19vo/Xd0cHCv0kwEe
         3Q0n80hH0dcbEeXn5yIF6T4r7mVSEJBIMyg07YtQBgUChvBdvP2aK8bm4S/zz74/7Pyf
         KObjSbNozN5wnBVNXNvH+JelGehcB9mm1by7p4efMWi7SUCYRUAC5wN9Bqlr8AJc80rp
         61iw==
X-Forwarded-Encrypted: i=1; AJvYcCUdh/rNGB2F6dPceWnW0ZdNHAyPggWtodITlSL72wxDrQQ6piqN0ZrBq896UwsVoBlpmTwEj0AdM6I7ddDWuVCLuy99ZA==@vger.kernel.org, AJvYcCUvLROAhkK5w5xWaEeFjuQxihdzJDCSYd60qXKrDn419unPBLG+mYgUGytQr+wfplM9C0BP4A3ydOaarTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNzYDZiLCbtY1P9FCj7s/VYI5a4x1Mker/u5K7mbo5tQOq7Q5
	u96YctIwf4eivSBEvlS6XomAYTqXk/QsflsgmCo0VHQBxS1SS9bn
X-Google-Smtp-Source: AGHT+IGPIyD3t78gxunz8Gv3ugpZPEDp5GR+HrdJ+kIyD2a3w7XddKzUVvy7vlyibNLSlwzhq9+eAw==
X-Received: by 2002:a17:903:2292:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-211d0d624cbmr238407335ad.1.1731990876965;
        Mon, 18 Nov 2024 20:34:36 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ecc6a4sm65560665ad.94.2024.11.18.20.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:34:36 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH 1/5] alienware-wmi: Simplify platform device creation
Date: Tue, 19 Nov 2024 01:34:29 -0300
Message-ID: <20241119043429.25538-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplfy platform device creation by using
platform_device_register_simple().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449..742fe79f13dc 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1196,14 +1196,13 @@ static int __init alienware_wmi_init(void)
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
 
 	if (quirks->hdmi_mux > 0) {
 		ret = create_hdmi(platform_device);
@@ -1242,9 +1241,7 @@ static int __init alienware_wmi_init(void)
 fail_prep_deepsleep:
 fail_prep_amplifier:
 fail_prep_hdmi:
-	platform_device_del(platform_device);
-fail_platform_device2:
-	platform_device_put(platform_device);
+	platform_device_unregister(platform_device);
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
-- 
2.47.0


