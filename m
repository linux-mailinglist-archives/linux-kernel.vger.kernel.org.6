Return-Path: <linux-kernel+bounces-214080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698A3907F28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC21C2289A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D82414D43B;
	Thu, 13 Jun 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WTTp7Y4M"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232B13D50F;
	Thu, 13 Jun 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319709; cv=none; b=bLSy97RU9bBHZW7G8RR3enxENXKDlsd8IIrFW8l2C5fQUhbgUG/4Z1AU02kZrAWzeSrc6eYlbcK2P0w/Qv7lXDjObKSsdhjAv11I5NXhtnwLnNi22jWgzGQmUsazUGGsZgQJ35gOPfwVtBksgjC0uNjxHbEXfU3kqa0PLl0tG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319709; c=relaxed/simple;
	bh=BZVtQqHhflViNbQmzgYDT7jR3J6wdX6z8FyyRLKusww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bmx/aIuiEpTfKjR+9I9DvWxEkBA55dZhGSlna67K3n9rut9LH88ggNGWVCGVkQS0caI3+x4L8lk+vj9xIPv0S3g8a/EhPgOP0gRNsgVsrplf3n9/1FMZ9ogu8C++n9NzANM4QYWY+LmO4UgfbpHM17qbmYssad7MDxTNX7u7cLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WTTp7Y4M; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718319705;
	bh=BZVtQqHhflViNbQmzgYDT7jR3J6wdX6z8FyyRLKusww=;
	h=From:Date:Subject:To:Cc:From;
	b=WTTp7Y4M8BiDpHvCdh14luro0jfvDcuOOcD3M+KVpkMKyeRQ+0kBabd2x/kIllHzD
	 Xz+tIplvqdenDMXV9vksQqUAETd3zUCIjsMrfNDixqM4UBjHg+quO1RclBjQ7o6YkS
	 6S0EdBnBcPrMEGpIBAzzER+AOPd8T1A3P76/k2x0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 14 Jun 2024 01:01:42 +0200
Subject: [PATCH] hwmon: (core) Make hwmon_class const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240614-class-const-hwmon-v1-1-27b910d06a90@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFV6a2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MT3eScxOJi3eT8vOIS3Yzy3Pw8XVNTMwNDk2QDoyRzAyWgvoKi1LT
 MCrCZ0bG1tQBb+5WbYwAAAA==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718319704; l=861;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BZVtQqHhflViNbQmzgYDT7jR3J6wdX6z8FyyRLKusww=;
 b=qF8cZO+mKNoYus/N7MwoMK6aWB6D65m0p87hoQVF6RCxd/5G89MMqfsgK6wNv1iXmN08KODaf
 Ym6fHTxdE9FBbHQc/KN9VoQKiMJHNsetDXtJ2SP9DeUxvbidsdcuD/5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the driver core allows for struct class to be in read-only
memory, mark hwmon_class as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hwmon/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3b259c425ab7..1d1451dd239d 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -136,7 +136,7 @@ static void hwmon_dev_release(struct device *dev)
 	kfree(hwdev);
 }
 
-static struct class hwmon_class = {
+static const struct class hwmon_class = {
 	.name = "hwmon",
 	.dev_groups = hwmon_dev_attr_groups,
 	.dev_release = hwmon_dev_release,

---
base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
change-id: 20240614-class-const-hwmon-556014c02b70

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


