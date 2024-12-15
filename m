Return-Path: <linux-kernel+bounces-446425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CC9F2431
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2761655E7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18818871A;
	Sun, 15 Dec 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tb0PlQSG"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FB174EE4
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734269363; cv=none; b=Va2AuybiX9cZzNlJYNx170Psj7yGsp+hAPSJkNCXxsAw/qRiKJGplkGpDP40aH35L1/Zv3TLG6Str1hpvCsVk419AL5h+VUBCgkxCoha5FzYlVfZe/5a3hAGxzQ3ufbqaAL/2chS86UqV8H6fT5pRsNftuNCDOUXUfKrG/7zyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734269363; c=relaxed/simple;
	bh=5+FrfB2caBpHvRCQHU5a1w+yZLVExymWuXyTi6GSin0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TSPsFW7apLVpyngC3n7ILm72SObJkLzED4Smix4X4yDCafs3zByaQzftm5e4AIWXcCWdspttFUeNTwIvEbGS0YIaalk4KbxZzd50pnUmTuFwzQGnkxoQpvDZhJWooEk7Z11bTU3olOL4Hi7T/QvwDE4dqIuXRcaC5r/uSqGhLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tb0PlQSG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734269358;
	bh=5+FrfB2caBpHvRCQHU5a1w+yZLVExymWuXyTi6GSin0=;
	h=From:Date:Subject:To:Cc:From;
	b=tb0PlQSG6U/FaLUtbqr58ro4HpUp7xH+KLXPZzJTAnQAQASXEhtyhZjjAYA9Vqhat
	 Ubk5DMk2LnaGQ6Xf3UEHt3hx+m3FUvJfGc/A2cTressVY18pZ0zZ4c44UaPf3VLpoG
	 k0S9aIS2Fm5xATUhOC+tUWD43T86GR80cNeG78iw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 14:29:15 +0100
Subject: [PATCH] platform/chrome: cros_ec_vbc: Constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-chrome-v1-1-92249c4bc295@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKrZXmcC/x3MwQqDMAwA0F+RnA20RQvzV2RIW6PmsHYkRTbEf
 1/Z8V3eBUrCpDB1FwidrFxyg+07SEfIOyGvzeCMG6yzI+pXN8VUslaMnJdQq2A6pLwIfYirGSg
 m8g9ow1to489/n5/3/QOms+AubQAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-chrome-6abd04ebce69
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734269357; l=2113;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5+FrfB2caBpHvRCQHU5a1w+yZLVExymWuXyTi6GSin0=;
 b=QQwXZ2v/BiaOxnSxSNVElxtVbuhLfR02qpzf2sYEdI1BceiE8VRFtTRVk2jNCaCYGHffwXzAQ
 0w5QfBVUIasCSZ2g27WVRFNKvrTywTjjF/iRyOy3cQAI/7rn5nFtm/l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_vbc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 7bdb489354c5d203d2f4af22214314f6ead12c4e..963c4db23055d8fd807ec72072b1ae0a95c1bbb0 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -15,7 +15,7 @@
 #define DRV_NAME "cros-ec-vbc"
 
 static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *att, char *buf,
+				  const struct bin_attribute *att, char *buf,
 				  loff_t pos, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -59,7 +59,7 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf,
+				   const struct bin_attribute *attr, char *buf,
 				   loff_t pos, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -99,16 +99,16 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
 	return data_sz;
 }
 
-static BIN_ATTR_RW(vboot_context, 16);
+static const BIN_ATTR_RW(vboot_context, 16);
 
-static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
+static const struct bin_attribute *const cros_ec_vbc_bin_attrs[] = {
 	&bin_attr_vboot_context,
 	NULL
 };
 
 static const struct attribute_group cros_ec_vbc_attr_group = {
 	.name = "vbc",
-	.bin_attrs = cros_ec_vbc_bin_attrs,
+	.bin_attrs_new = cros_ec_vbc_bin_attrs,
 };
 
 static int cros_ec_vbc_probe(struct platform_device *pd)

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-chrome-6abd04ebce69

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


