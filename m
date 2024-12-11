Return-Path: <linux-kernel+bounces-441786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F09ED413
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599D6188A707
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951352210EB;
	Wed, 11 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RmF+FqYx"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7692040AD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939433; cv=none; b=nw9jQc/q2J37KbZTinmkTyl1+v94mskUCRMz/yk1DgxLP1jGdP0Drq5D9gh05KMHrXxKajDYUqDMkr7fLBqRfsW+JrSTn/kBnliraQAyHImF4ft/G/Sl1qEqf1a0vtfMeYK2+Jb82zPky6grsayU8QBILEyzQ20dIFqF3ZZD9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939433; c=relaxed/simple;
	bh=J3vCtI5hdQabQGG0Jx/gVuyxcXRIrep+wGD5E3ZqU1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5fMz+lQnXRp8/fvqdTE6s8wpy+lkANPVT9at6wY+ORsmD5I+SkUDLsqKH47Xgtd36q34rLURGth7sFfie3Bw2dHsns9+s7WYFcfBmW93AA2NZDqKGIV25l71eLBa9FFsZZnSvjMTVU8pTGmawM20Zga5sAEp6MOe8ZeJ6+TkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RmF+FqYx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=J3vCtI5hdQabQGG0Jx/gVuyxcXRIrep+wGD5E3ZqU1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RmF+FqYxo7LxC9NMrjiM8Rn3BGr+hqsVDoyNSxxfijLIXRJHZ8YcFwpXR//LiE3lD
	 92UjZiQNCncaIX/oc8xJmISUKRr3Ms5Kda9mNWjKRxuUlr0zebV+bKlsiXOWCE92NI
	 sXKLP84Qej8RtKynGbhu6kypPuoVsbxrrFNt6D0M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:18 +0100
Subject: [PATCH 03/12] w1: ds2408: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-3-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939417; l=5344;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=J3vCtI5hdQabQGG0Jx/gVuyxcXRIrep+wGD5E3ZqU1s=;
 b=duuUEp6q1SdVl5y569ZOAVnjuJD/GJmSo7LHP0DvAd72XHbSsxV44g8smPAaJ/sY/GuC5yHPE
 apa8PmGd2lRBBGSGbQVSvfhkIpm3yQ8ubW7+6bt1kaYwKL3YgIsrLNo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2408.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index 56f822a1dfdbed46ccc7db136255a1d021e6189a..beccd2912d2aeb9a5f83cabba19c32946778a790 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -65,8 +65,8 @@ static int _read_reg(struct w1_slave *sl, u8 address, unsigned char *buf)
 }
 
 static ssize_t state_read(struct file *filp, struct kobject *kobj,
-			  struct bin_attribute *bin_attr, char *buf, loff_t off,
-			  size_t count)
+			  const struct bin_attribute *bin_attr, char *buf,
+			  loff_t off, size_t count)
 {
 	dev_dbg(&kobj_to_w1_slave(kobj)->dev,
 		"Reading %s kobj: %p, off: %0#10x, count: %zu, buff addr: %p",
@@ -77,7 +77,7 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t output_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr, char *buf,
+			   const struct bin_attribute *bin_attr, char *buf,
 			   loff_t off, size_t count)
 {
 	dev_dbg(&kobj_to_w1_slave(kobj)->dev,
@@ -90,7 +90,7 @@ static ssize_t output_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t activity_read(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
+			     const struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
 	dev_dbg(&kobj_to_w1_slave(kobj)->dev,
@@ -103,8 +103,8 @@ static ssize_t activity_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t cond_search_mask_read(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *bin_attr, char *buf,
-				     loff_t off, size_t count)
+				     const struct bin_attribute *bin_attr,
+				     char *buf, loff_t off, size_t count)
 {
 	dev_dbg(&kobj_to_w1_slave(kobj)->dev,
 		"Reading %s kobj: %p, off: %0#10x, count: %zu, buff addr: %p",
@@ -117,7 +117,7 @@ static ssize_t cond_search_mask_read(struct file *filp, struct kobject *kobj,
 
 static ssize_t cond_search_polarity_read(struct file *filp,
 					 struct kobject *kobj,
-					 struct bin_attribute *bin_attr,
+					 const struct bin_attribute *bin_attr,
 					 char *buf, loff_t off, size_t count)
 {
 	if (count != 1 || off != 0)
@@ -127,8 +127,8 @@ static ssize_t cond_search_polarity_read(struct file *filp,
 }
 
 static ssize_t status_control_read(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *bin_attr, char *buf,
-				   loff_t off, size_t count)
+				   const struct bin_attribute *bin_attr,
+				   char *buf, loff_t off, size_t count)
 {
 	if (count != 1 || off != 0)
 		return -EFAULT;
@@ -160,7 +160,7 @@ static bool optional_read_back_valid(struct w1_slave *sl, u8 expected)
 #endif
 
 static ssize_t output_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -210,7 +210,7 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
  * Writing to the activity file resets the activity latches.
  */
 static ssize_t activity_write(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *buf,
+			      const struct bin_attribute *bin_attr, char *buf,
 			      loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -240,8 +240,8 @@ static ssize_t activity_write(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t status_control_write(struct file *filp, struct kobject *kobj,
-				    struct bin_attribute *bin_attr, char *buf,
-				    loff_t off, size_t count)
+				    const struct bin_attribute *bin_attr,
+				    char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	u8 w1_buf[4];
@@ -310,14 +310,14 @@ static int w1_f29_disable_test_mode(struct w1_slave *sl)
 	return res;
 }
 
-static BIN_ATTR_RO(state, 1);
-static BIN_ATTR_RW(output, 1);
-static BIN_ATTR_RW(activity, 1);
-static BIN_ATTR_RO(cond_search_mask, 1);
-static BIN_ATTR_RO(cond_search_polarity, 1);
-static BIN_ATTR_RW(status_control, 1);
+static const BIN_ATTR_RO(state, 1);
+static const BIN_ATTR_RW(output, 1);
+static const BIN_ATTR_RW(activity, 1);
+static const BIN_ATTR_RO(cond_search_mask, 1);
+static const BIN_ATTR_RO(cond_search_polarity, 1);
+static const BIN_ATTR_RW(status_control, 1);
 
-static struct bin_attribute *w1_f29_bin_attrs[] = {
+static const struct bin_attribute *const w1_f29_bin_attrs[] = {
 	&bin_attr_state,
 	&bin_attr_output,
 	&bin_attr_activity,
@@ -328,7 +328,7 @@ static struct bin_attribute *w1_f29_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_f29_group = {
-	.bin_attrs = w1_f29_bin_attrs,
+	.bin_attrs_new = w1_f29_bin_attrs,
 };
 
 static const struct attribute_group *w1_f29_groups[] = {

-- 
2.47.1


