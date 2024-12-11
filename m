Return-Path: <linux-kernel+bounces-441781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23EF9ED40E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240D1284B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B6209F35;
	Wed, 11 Dec 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OLgEH0Ap"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE920126B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939432; cv=none; b=DZAkMiODGjrIjbi8xtSCjDL4Xwd5ou2vEkdH24Z8fm+E2lGeL/1YDNOBeDQVyIXbeiNrAZiFU3LbR4PkKVGbpqWf4PSXU46cQSjmu47Sb5wA8QREd3ZKTx8KURpmYnT55VX5Ri9YwNjqlaOLZZmpT48X4Hd4z/JdrEF5iWXyH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939432; c=relaxed/simple;
	bh=K28ML1hqqA6gwMqXnOGpt/Gj5CvGgPCGHs5mNLnIE7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9wbxLin2vwTovd2TeXXXbe/15CITPrY47R/+YrfGZ/wOPo1AFheVpt6XiURwL23BH+X7S9dtanBJE2PMfU6RkMNhjRO5RLOflRnHDNEgrud996GU6cZGllU/ugfoM5fPKI0iGQHUy4UYOLniDw/9liCD9LWTZ7/Sl+F8H/pSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OLgEH0Ap; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=K28ML1hqqA6gwMqXnOGpt/Gj5CvGgPCGHs5mNLnIE7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OLgEH0ApCOoHJN6tSOdkSfgmgvexJBQRpkBSkKX8Wdiu3D9C99jnCgHdG1fPVHSjU
	 ddXbdzfbhmrnkOFe05NKxAKgEh4UqDEQfNlIWYvbyPJzhz7P9PAwzzaudsikQlYCcS
	 ckUIS0drzwSbdu8V7xOUx0MUHKBvKx8NJX94qPAM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:21 +0100
Subject: [PATCH 06/12] w1: ds2431: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-6-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=1931;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K28ML1hqqA6gwMqXnOGpt/Gj5CvGgPCGHs5mNLnIE7I=;
 b=48dv9trO7Sad5mhBNvPtmHB5DfJMY+PDMRA/oU+UvdsXsBekJNSYdU7AZeJWpQrgRa2xdwrKN
 ILu1gTMaP/cCdcaZhcO8DSvVndqKItCxOIByQtsxi/Kbm8NcEAPJ6vK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2431.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2431.c b/drivers/w1/slaves/w1_ds2431.c
index 6856b1c29e179afe072ff06b94b3ba86759c7fcc..27b390fb59da11b610e1d126347ddba46a2f4f29 100644
--- a/drivers/w1/slaves/w1_ds2431.c
+++ b/drivers/w1/slaves/w1_ds2431.c
@@ -95,7 +95,7 @@ static int w1_f2d_readblock(struct w1_slave *sl, int off, int count, char *buf)
 }
 
 static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr, char *buf,
+			   const struct bin_attribute *bin_attr, char *buf,
 			   loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -201,7 +201,7 @@ static int w1_f2d_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 }
 
 static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -262,15 +262,15 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static BIN_ATTR_RW(eeprom, W1_F2D_EEPROM_SIZE);
+static const BIN_ATTR_RW(eeprom, W1_F2D_EEPROM_SIZE);
 
-static struct bin_attribute *w1_f2d_bin_attrs[] = {
+static const struct bin_attribute *const w1_f2d_bin_attrs[] = {
 	&bin_attr_eeprom,
 	NULL,
 };
 
 static const struct attribute_group w1_f2d_group = {
-	.bin_attrs = w1_f2d_bin_attrs,
+	.bin_attrs_new = w1_f2d_bin_attrs,
 };
 
 static const struct attribute_group *w1_f2d_groups[] = {

-- 
2.47.1


