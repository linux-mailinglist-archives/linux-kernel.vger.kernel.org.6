Return-Path: <linux-kernel+bounces-441776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F09ED409
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C5D1888D51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C2200108;
	Wed, 11 Dec 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Khw3oY59"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6661FF1D1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939429; cv=none; b=r8jf7LWorvXdlnoR6UlrOdwG/Wi2Jh7v3d/gOokVGghgL7LG774liv5T978qGYzkAiExRI0ExftrLuLlpCeAd9lyktjxpyf2Y9/h6GW2B9GLMEexv1P5synaNgQI7elGqHZmqkFqKSpMc/5G91HPJaY7wFQFT3uR7AqR6cDrvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939429; c=relaxed/simple;
	bh=9ocxmATh3LJZkTpVvdOx9dEWaYWzc6nNHhkg7FFPmm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/fgo/X1DJvaoUCAzbqiE3qYJmUpw8JjMzYUzW/+vnJ8sb7YbaYKKhZJ0xl1dnTRAaQcu7BgWXJdDCp7Lfaa80shUkYCvc/6r0tuhj4miWHpN9QBxSiMZzd9cIve25eOBhTesnY37MPm9DkYLFoZHANGdJCm32oQh5fJbhPMCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Khw3oY59; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=9ocxmATh3LJZkTpVvdOx9dEWaYWzc6nNHhkg7FFPmm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Khw3oY59rR3cfpxW0Mb1881sGnq6QKAvEzOgpQ0QcriyAVihNZbclum6m8OaHABSW
	 K12Ij/WbuCwxSi4Wl9u6Ue2dVzur8hx88ETqcHQ5TEef5VA+jMLx7QoExBTZcsjhjx
	 W8HTBKE04CVTTbkVUzYXnL6lu8Lk58+XMKx0vbw4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:20 +0100
Subject: [PATCH 05/12] w1: ds2430: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-5-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=1931;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9ocxmATh3LJZkTpVvdOx9dEWaYWzc6nNHhkg7FFPmm0=;
 b=pGWU/ox6BFZOX8HRGHdHVC5bYq3QQ8hfjtMG2lcd7fO7ETqpAo8HamRGXZtsD3Dmyohfz+fq/
 Pot18GhBOgwBETpdDIxl52gY+TYyk0dM8Na1whSTSwORvfHmYg2uOZT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2430.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
index 0ea7d779d17aecf8cbdd19320a6df6070ed9d507..ff56e2e68e583b3bb4df82c119e9325271342595 100644
--- a/drivers/w1/slaves/w1_ds2430.c
+++ b/drivers/w1/slaves/w1_ds2430.c
@@ -95,7 +95,7 @@ static int w1_f14_readblock(struct w1_slave *sl, int off, int count, char *buf)
 }
 
 static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr, char *buf,
+			   const struct bin_attribute *bin_attr, char *buf,
 			   loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -202,7 +202,7 @@ static int w1_f14_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 }
 
 static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
+			    const struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -263,15 +263,15 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static BIN_ATTR_RW(eeprom, W1_F14_EEPROM_SIZE);
+static const BIN_ATTR_RW(eeprom, W1_F14_EEPROM_SIZE);
 
-static struct bin_attribute *w1_f14_bin_attrs[] = {
+static const struct bin_attribute *const w1_f14_bin_attrs[] = {
 	&bin_attr_eeprom,
 	NULL,
 };
 
 static const struct attribute_group w1_f14_group = {
-	.bin_attrs = w1_f14_bin_attrs,
+	.bin_attrs_new = w1_f14_bin_attrs,
 };
 
 static const struct attribute_group *w1_f14_groups[] = {

-- 
2.47.1


