Return-Path: <linux-kernel+bounces-445973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601799F1E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF8E188BE4E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E071186294;
	Sat, 14 Dec 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxammann.org header.i=@maxammann.org header.b="rmrxbY8G"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5B262BE;
	Sat, 14 Dec 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734171747; cv=none; b=tlEUygATUztVr8D1LXV7dzkAEvXplxzFPCr8kCCYmxRgfB0AG+e0ql7jaqXxbf6SdRMmVfV6aSGPg6uSwztKBuz0Ti+FXmnp66UzLltVR1RntD1bxvRi5wLevuJpHNfJugANwmgZuqYFnlvhYgPoXQBzgBY4nsOMO7u58iV4c7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734171747; c=relaxed/simple;
	bh=TI9oprvG7Qgynm0Jsa8YgWjcQmv53gHW7nzqAswmXqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uI7zF5bxM+ecAzL1aQofSFOfNxuvkhNk7f8LxT1twRIXi5mXinFkKOvqC4B+up34L5U3CGT7XYLz+zjB6CGlGRV5UB+F3PhjtKtyWWP/r/ycwIpvVWcYaHL//soH6RBb8t9K3Yixw2h+5Wz4LSRqVJRUW8ML1NEYPDDvoqMbZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maxammann.org; spf=pass smtp.mailfrom=maxammann.org; dkim=pass (2048-bit key) header.d=maxammann.org header.i=@maxammann.org header.b=rmrxbY8G; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maxammann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxammann.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y9MhN3nPKz9spF;
	Sat, 14 Dec 2024 11:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxammann.org;
	s=MBO0001; t=1734171732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FOcJNEE6Ruq6z82qmua45rResUYjl5YozfkY2UrlkGg=;
	b=rmrxbY8G6zFFAV1thyGqP8mozjPkV6O2UN9jD++xVVwrEjPHUzAwDkL1c9kNfa3QZkRSSf
	NGFQNM7pbhetN+Hl7b1+ruPmJOZOxoqyxdiR6QOXp+md3wxr/xVjSz5nKgzLh++uH2+wRH
	CJU9HHqrqF8KNEm8kTCcTMLctqo9sHVVV7fNZXJVNROd4JVBdnEy9QiRFRJHoSwN5KrC1q
	Pck+A/oRWCGi4ZdLqoppcIPGOf9KM9RpnCgnry+Zmws1pd0Skq0+bvO44vAQ984tMmdoyw
	xRadq5E508pspq//LhU0QA2YC0RZw6pZ3mkTQmP8uA4m41M39x7jpcsDk+bqtQ==
From: Max Ammann <max@maxammann.org>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Ammann <max@maxammann.org>
Subject: [PATCH] hwmon: (nct6683) Add customer ID for ASRock B650 Steel Legend WiFi
Date: Sat, 14 Dec 2024 11:22:01 +0100
Message-ID: <20241214102201.122851-1-max@maxammann.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This value was found on an ASRock B650 Steel Legend WiFi with an
NCT6686D chip.

Signed-off-by: Max Ammann <max@maxammann.org>
---
 Documentation/hwmon/nct6683.rst | 1 +
 drivers/hwmon/nct6683.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/hwmon/nct6683.rst b/Documentation/hwmon/nct6683.rst
index 2a7a78eb1b46..f224639229d2 100644
--- a/Documentation/hwmon/nct6683.rst
+++ b/Documentation/hwmon/nct6683.rst
@@ -63,6 +63,7 @@ Intel DH87MC	NCT6683D EC firmware version 1.0 build 04/03/13
 Intel DB85FL	NCT6683D EC firmware version 1.0 build 04/03/13
 ASRock X570	NCT6683D EC firmware version 1.0 build 06/28/19
 ASRock X670E	NCT6686D EC firmware version 1.0 build 05/19/22
+ASRock B650 Steel Legend WiFi	NCT6686D EC firmware version 1.0 build 11/09/23
 MSI B550	NCT6687D EC firmware version 1.0 build 05/07/20
 MSI X670-P	NCT6687D EC firmware version 0.0 build 09/27/22
 =============== ===============================================
diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index f71615e06a8f..3d31b8e2c835 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -178,6 +178,7 @@ superio_exit(int ioreg)
 #define NCT6683_CUSTOMER_ID_ASROCK		0xe2c
 #define NCT6683_CUSTOMER_ID_ASROCK2	0xe1b
 #define NCT6683_CUSTOMER_ID_ASROCK3	0x1631
+#define NCT6683_CUSTOMER_ID_ASROCK4	0x163e
 
 #define NCT6683_REG_BUILD_YEAR		0x604
 #define NCT6683_REG_BUILD_MONTH		0x605
@@ -1233,6 +1234,8 @@ static int nct6683_probe(struct platform_device *pdev)
 		break;
 	case NCT6683_CUSTOMER_ID_ASROCK3:
 		break;
+	case NCT6683_CUSTOMER_ID_ASROCK4:
+		break;
 	default:
 		if (!force)
 			return -ENODEV;
-- 
2.47.0


