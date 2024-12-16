Return-Path: <linux-kernel+bounces-447247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3149F2F99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C321627E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754A204C19;
	Mon, 16 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="r7cZsmWq"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF810204591
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348786; cv=none; b=bTw0SPt+LdI7+rH+Lm/39Y0ycQ4WnBX4RBc1Noy4CaUaui2ZtT/OTwoLyt7WKQduitCvMurHhq4gdELAhxzmTxnLMWsvQR6AEE1J0eEDbGH3PtA3l94oYcbDYy+sZrn06dpGzJPOyZIE3dcveo3KXqQfxg6AEjOoqAnwmlW+c5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348786; c=relaxed/simple;
	bh=N27SW5V9S6zkyqz00AIvVG+5Rix9h0ENrJDmGyAeG8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqpITFeuNZVISlT8K4nneiZZh7yU8Hav8GCNWGY6dXlCig84mzv+tWHm5NeFjoKV1XEBDoTtyX+YeG3s8BzeyQrnMq9FYnjVfSWC0YCJkMH3EPG9fX23pDz/a5ibswzLlks4RLST4dONcjKH+ZILwOBEHbUQH70La12sE9Iz3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=r7cZsmWq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348782;
	bh=N27SW5V9S6zkyqz00AIvVG+5Rix9h0ENrJDmGyAeG8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r7cZsmWqkSHnWWTQwUfmtSM3avVaTLeMBQ+0ZIlNhWIb3YunB/5/WbAYBm3ILU8di
	 Xg5Kpn6jYvHdLgxlAhONLCUPToOmQPQlA/IVbOEqHEybO5ppstUWToGUbWB+FyVaSN
	 s6pY99uTMeTX248ff8x6WP/bndLS6dFjIYsIN6AQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:33:01 +0100
Subject: [PATCH 6/9] misc: pch_phub: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-6-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1571;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N27SW5V9S6zkyqz00AIvVG+5Rix9h0ENrJDmGyAeG8A=;
 b=Vg1WUEDQnr3nZOKV8hRgDVUS+4THPY1UyKWYauf/B9CFckAcJE3ZW1ijdp1vYL8eG0Zw7vmZE
 OJxRrEYRgIMCaPzGEyPSAJbwOZfPUTkjXzaNexouPQsjy0C9YaCO8qb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/pch_phub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 8d2b7135738ed5543138f2249d2379a10113b410..6121c0940cd148d48b8d574065c50703b6a301d7 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -483,7 +483,7 @@ static int pch_phub_write_gbe_mac_addr(struct pch_phub_reg *chip, u8 *data)
 }
 
 static ssize_t pch_phub_bin_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *attr, char *buf,
+				 const struct bin_attribute *attr, char *buf,
 				 loff_t off, size_t count)
 {
 	unsigned int rom_signature;
@@ -553,7 +553,7 @@ static ssize_t pch_phub_bin_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t pch_phub_bin_write(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *attr,
+				  const struct bin_attribute *attr,
 				  char *buf, loff_t off, size_t count)
 {
 	int err;
@@ -655,8 +655,8 @@ static const struct bin_attribute pch_bin_attr = {
 		.mode = S_IRUGO | S_IWUSR,
 	},
 	.size = PCH_PHUB_OROM_SIZE + 1,
-	.read = pch_phub_bin_read,
-	.write = pch_phub_bin_write,
+	.read_new = pch_phub_bin_read,
+	.write_new = pch_phub_bin_write,
 };
 
 static int pch_phub_probe(struct pci_dev *pdev,

-- 
2.47.1


