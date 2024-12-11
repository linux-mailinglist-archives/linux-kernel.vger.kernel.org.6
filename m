Return-Path: <linux-kernel+bounces-441782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C929ED40F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1731889BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7815020A5CF;
	Wed, 11 Dec 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XDCsGxJS"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8D201267
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939432; cv=none; b=PgHXlmashBtsM0+fZxH4xzNkf2Gh4LmEblhis0AtcFNwt/M/2ZRPZ1i5y8GMLxsz0Grsl6RKGc+i5RNhINllFt2/qJ862ogm1hPfIIy1w+GMB9nYCRsmV1azS7eH2JzDSwXK3JS9FlbzGg3aGy8leL7lbNtZSMkUUL5SYdTzJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939432; c=relaxed/simple;
	bh=ARO5UZ4nujLsozplk8hxJJBHhcGp9DQWJ4aefMn2kr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNqMQ+Y0QLuT0lYfy9kGCQqgHtJuInO+RCCf1YL1sG4yjy2Sa8PWSfGV18G3gh7qXOjrC6uEbtLWZ1uvLxROeRlfdCrMOKt3jNdWFjUnP+U+aBfTyz/iN4+irrT11CxThV4QlN/7aUbvvNAczuyP9xqCr5zmvKTTzVMA9zDZpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XDCsGxJS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=ARO5UZ4nujLsozplk8hxJJBHhcGp9DQWJ4aefMn2kr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XDCsGxJSpREFR8Mw+k2E7iZRmfoYEWENS7s9+l4JveCiOsOnMwE/GeqqcjhaFT2Wi
	 lsbdRnD9d3QD0RmTDUUes0sEQqvXVS0GFZp67VJlBsv3mXw0hijbBnasnLt7z6MWB/
	 wg3syymVGIEEOTuedH8Ce0hjasPVfi4kkCmg4guc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:23 +0100
Subject: [PATCH 08/12] w1: ds2438: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-8-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=4754;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ARO5UZ4nujLsozplk8hxJJBHhcGp9DQWJ4aefMn2kr4=;
 b=aNAJnV+bcYDx4Xkjh1MLcVdNNQScwTus1HoZBOA6G5pNCWIDd1jgVZmTSocIKW0wWNrz+9Wr5
 JqhOZnvn069Cl0RuXRFysWPDBS2JcAcetVKRWbftNWC52FaaRmibOG6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2438.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index e008c27b3db9efaaba4e6965cc7c3ff032afe3cc..630a6db5045e8c2985cae6fef684bb6f2081f95d 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -288,7 +288,7 @@ static int w1_ds2438_get_current(struct w1_slave *sl, int16_t *voltage)
 }
 
 static ssize_t iad_write(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *bin_attr, char *buf,
+			 const struct bin_attribute *bin_attr, char *buf,
 			 loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -310,7 +310,7 @@ static ssize_t iad_write(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t iad_read(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf,
+			const struct bin_attribute *bin_attr, char *buf,
 			loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -331,7 +331,7 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t page0_read(struct file *filp, struct kobject *kobj,
-			  struct bin_attribute *bin_attr, char *buf,
+			  const struct bin_attribute *bin_attr, char *buf,
 			  loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -361,7 +361,7 @@ static ssize_t page0_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t page1_read(struct file *filp, struct kobject *kobj,
-			  struct bin_attribute *bin_attr, char *buf,
+			  const struct bin_attribute *bin_attr, char *buf,
 			  loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -391,7 +391,7 @@ static ssize_t page1_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t offset_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -410,7 +410,7 @@ static ssize_t offset_write(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *buf,
+				const struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -431,7 +431,7 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t vad_read(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf,
+			const struct bin_attribute *bin_attr, char *buf,
 			loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -452,7 +452,7 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf,
+			const struct bin_attribute *bin_attr, char *buf,
 			loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -472,15 +472,15 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
-static BIN_ATTR_RW(iad, 0);
-static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
-static BIN_ATTR_RO(page1, DS2438_PAGE_SIZE);
-static BIN_ATTR_WO(offset, 2);
-static BIN_ATTR_RO(temperature, 0/* real length varies */);
-static BIN_ATTR_RO(vad, 0/* real length varies */);
-static BIN_ATTR_RO(vdd, 0/* real length varies */);
+static const BIN_ATTR_RW(iad, 0);
+static const BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
+static const BIN_ATTR_RO(page1, DS2438_PAGE_SIZE);
+static const BIN_ATTR_WO(offset, 2);
+static const BIN_ATTR_RO(temperature, 0/* real length varies */);
+static const BIN_ATTR_RO(vad, 0/* real length varies */);
+static const BIN_ATTR_RO(vdd, 0/* real length varies */);
 
-static struct bin_attribute *w1_ds2438_bin_attrs[] = {
+static const struct bin_attribute *const w1_ds2438_bin_attrs[] = {
 	&bin_attr_iad,
 	&bin_attr_page0,
 	&bin_attr_page1,
@@ -492,7 +492,7 @@ static struct bin_attribute *w1_ds2438_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_ds2438_group = {
-	.bin_attrs = w1_ds2438_bin_attrs,
+	.bin_attrs_new = w1_ds2438_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2438_groups[] = {

-- 
2.47.1


