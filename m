Return-Path: <linux-kernel+bounces-447314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C869F3073
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB1F18848BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C1E204C03;
	Mon, 16 Dec 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="psT501tO"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D8204563
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351780; cv=none; b=KTtGHqsPehVXJnixl/znedozdHXqs9uNygLl4bHXHhCCTjEmz1iqBpQFy+zF1GMBl4mCvK9rZyd5ab1kgCVb91Rz7Z+jn6oU4jVKCrcpxY8wRTxzal2jmn8lHv6VZhzb3k7y21/2VNaww1b1Kz9p6bOkpR0gvd2A9YS943bL+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351780; c=relaxed/simple;
	bh=bsw1R3PrXav/ak1MSjYG8HxVy8MEpaINmTpeVmBaqYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uyLu3KbSOl51ROFvOY/QDnd2NzuoxuqHGJeHF+EPPrLtq4ex7eL5zA6bHt0k4/OhlYFAsr55t2s5aIi1S+wtxrD8Je0JqKPeF/42Jm2jWWKAPpc+MlTDjCbLUZ9Q7y3P8tVnFq3mP2szRLwwSUFZLNIxmytR6dmBqIcaHl/4lfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=psT501tO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734351775;
	bh=bsw1R3PrXav/ak1MSjYG8HxVy8MEpaINmTpeVmBaqYI=;
	h=From:Date:Subject:To:Cc:From;
	b=psT501tOnGzdAWEYbEj1GYYHLZmjdM8bKTS0ohlEiDzemAiKcsHhC7w/3IdTnq4lg
	 XELZ3XCy0IGLx4xZJdPvP5jr5lZ41fVGxqqtzJe6tDd5xnL9N3QNWpQwMH4tTSkhUG
	 RIKzN0v2bHAHQQ1Ew2cz6pzGRY41HNhHTNJHhwdY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 13:22:54 +0100
Subject: [PATCH] rapidio: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-rapidio-v1-1-0f47f4719683@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJ0bYGcC/x3MwQrCMAwA0F8ZORuwoQzdr4whsUs1l3YkZShj/
 27x+C7vABdTcZiGA0x2da2lI1wGSG8uL0Fdu4GuFAOFEf3r2THV4g2fWh7cmqHxpqtWjGO6x8S
 ZmG7Qi80k6+ffz8t5/gBNkn1QbgAAAA==
X-Change-ID: 20241216-sysfs-const-bin_attr-rapidio-46c94caf2a28
To: Matt Porter <mporter@kernel.crashing.org>, 
 Alexandre Bounine <alex.bou9@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734351775; l=2388;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bsw1R3PrXav/ak1MSjYG8HxVy8MEpaINmTpeVmBaqYI=;
 b=U4r7DOgcxHNUUTd8qA2R89jzfPXiXai9oqt2W8yzvu8SK68VbmKU9kkxeEx82vVuIf+pAcwuk
 9AWjux5OX85AP4UK7FNBML5XpBdEVN43i1EeyyXAPULeow9IWMOJcn8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/rapidio/rio-sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
index 90d3912105338233b5f1cafc01fd499a77b66427..6f89b232f1d5d10a4dccf51422a57d4355ccf0c2 100644
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -114,7 +114,7 @@ static struct attribute *rio_dev_attrs[] = {
 
 static ssize_t
 rio_read_config(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *bin_attr,
+		const struct bin_attribute *bin_attr,
 		char *buf, loff_t off, size_t count)
 {
 	struct rio_dev *dev = to_rio_dev(kobj_to_dev(kobj));
@@ -185,7 +185,7 @@ rio_read_config(struct file *filp, struct kobject *kobj,
 
 static ssize_t
 rio_write_config(struct file *filp, struct kobject *kobj,
-		 struct bin_attribute *bin_attr,
+		 const struct bin_attribute *bin_attr,
 		 char *buf, loff_t off, size_t count)
 {
 	struct rio_dev *dev = to_rio_dev(kobj_to_dev(kobj));
@@ -241,17 +241,17 @@ rio_write_config(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute rio_config_attr = {
+static const struct bin_attribute rio_config_attr = {
 	.attr = {
 		 .name = "config",
 		 .mode = S_IRUGO | S_IWUSR,
 		 },
 	.size = RIO_MAINT_SPACE_SZ,
-	.read = rio_read_config,
-	.write = rio_write_config,
+	.read_new = rio_read_config,
+	.write_new = rio_write_config,
 };
 
-static struct bin_attribute *rio_dev_bin_attrs[] = {
+static const struct bin_attribute *const rio_dev_bin_attrs[] = {
 	&rio_config_attr,
 	NULL,
 };
@@ -278,7 +278,7 @@ static umode_t rio_dev_is_attr_visible(struct kobject *kobj,
 static const struct attribute_group rio_dev_group = {
 	.attrs		= rio_dev_attrs,
 	.is_visible	= rio_dev_is_attr_visible,
-	.bin_attrs	= rio_dev_bin_attrs,
+	.bin_attrs_new	= rio_dev_bin_attrs,
 };
 
 const struct attribute_group *rio_dev_groups[] = {

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241216-sysfs-const-bin_attr-rapidio-46c94caf2a28

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


