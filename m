Return-Path: <linux-kernel+bounces-441783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2E9ED411
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399FB1889EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1212120A5DC;
	Wed, 11 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CgP5BP/k"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72236203719
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939433; cv=none; b=pE4WNk6CP6tTWNpgVsJozlu+dwnFtlkxHSMUbx8S13alNew4cnCXzjbBGqKIx034QFvydLbB7CWNmX16RqL07n15gX7nzB5SYxQnySKbXoThHv/yAgcxFHLHMk/QbEbGDARTUxP4WKgfXco/re/HrYawkQmstb0CD2kQzuH7muY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939433; c=relaxed/simple;
	bh=Ojs3B544p0rHS9P9MqxyyOJrV4LPK6krTWQPqdCRmC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzYjWq3fEdTQWZDT2cmweGtg8KIER0Mwv5TCHzOtLHRtp2vTekdb6U53iTlMr9Pkud8f5qO+WEKonBTGibvRH4b/cEO4yKmytvhEWYwN9KD+1HdgG1yowwaO2cxt+m1gm2Gft/eR+TuqV2cn1lr4kblxrEdeccRDt3v5R3WPaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CgP5BP/k; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=Ojs3B544p0rHS9P9MqxyyOJrV4LPK6krTWQPqdCRmC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CgP5BP/kY4Nhj3oPBLqFrQDNM3SvgfnCZYGNsP+jiljF7fksXXd8Eo8RRCZgpnzQL
	 LTvKSG+oOqKbO0P8o17rSeQiZHyzoCvWUZ7FhxDvG6BvSa8ywnePpE3X08WRnEwICa
	 ZPEhGUVW1MEV9yrfwK/4lMPlS+8vbdn++SjXxDjw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:22 +0100
Subject: [PATCH 07/12] w1: ds2433: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-7-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=2998;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ojs3B544p0rHS9P9MqxyyOJrV4LPK6krTWQPqdCRmC0=;
 b=aT7eEsAwH/ltca6ri55VWjgudfeyNs4yPCXszWBJjFx9EVlf1jRTmvtVmsvv6UqQbY35gVoaQ
 Q+a6w8tEI1CDm03rMT/CCZ5ejMQt+q41ebFCGz1i6gELL1oQcisAweg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2433.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 250b7f7ec429e92a6146452a20d591644af4e083..22331d840ec18ae5fa6dfe7bd3437d8bb47057ad 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -110,7 +110,7 @@ static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
 #endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 
 static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr, char *buf,
+			   const struct bin_attribute *bin_attr, char *buf,
 			   loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -224,7 +224,7 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 }
 
 static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -274,27 +274,27 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute bin_attr_f23_eeprom = {
+static const struct bin_attribute bin_attr_f23_eeprom = {
 	.attr = { .name = "eeprom", .mode = 0644 },
-	.read = eeprom_read,
-	.write = eeprom_write,
+	.read_new = eeprom_read,
+	.write_new = eeprom_write,
 	.size = W1_EEPROM_DS2433_SIZE,
 };
 
-static struct bin_attribute bin_attr_f43_eeprom = {
+static const struct bin_attribute bin_attr_f43_eeprom = {
 	.attr = { .name = "eeprom", .mode = 0644 },
-	.read = eeprom_read,
-	.write = eeprom_write,
+	.read_new = eeprom_read,
+	.write_new = eeprom_write,
 	.size = W1_EEPROM_DS28EC20_SIZE,
 };
 
-static struct bin_attribute *w1_f23_bin_attributes[] = {
+static const struct bin_attribute *const w1_f23_bin_attributes[] = {
 	&bin_attr_f23_eeprom,
 	NULL,
 };
 
 static const struct attribute_group w1_f23_group = {
-	.bin_attrs = w1_f23_bin_attributes,
+	.bin_attrs_new = w1_f23_bin_attributes,
 };
 
 static const struct attribute_group *w1_f23_groups[] = {
@@ -302,13 +302,13 @@ static const struct attribute_group *w1_f23_groups[] = {
 	NULL,
 };
 
-static struct bin_attribute *w1_f43_bin_attributes[] = {
+static const struct bin_attribute *const w1_f43_bin_attributes[] = {
 	&bin_attr_f43_eeprom,
 	NULL,
 };
 
 static const struct attribute_group w1_f43_group = {
-	.bin_attrs = w1_f43_bin_attributes,
+	.bin_attrs_new = w1_f43_bin_attributes,
 };
 
 static const struct attribute_group *w1_f43_groups[] = {

-- 
2.47.1


