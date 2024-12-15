Return-Path: <linux-kernel+bounces-446423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDFC9F242E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846FA1652AC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D986B18871A;
	Sun, 15 Dec 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qzpQgw33"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE191D696;
	Sun, 15 Dec 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734269149; cv=none; b=EaZN52vCAB9hedbzHp3aqcle++COWVdGgO3bbTa3o+U1XGr3DRVROZqJ5zERbyjIHkEkO1crikrbjSx2rRXQkKjWXhYDjIzbxqRIj8gXvnoRdfudKIU12P0fIijuZsoGqQ58kqozm3ShbncUI+RAboVAx8T7oqVDhiydBVgIoY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734269149; c=relaxed/simple;
	bh=N/lB5gYneBd9IFIjiiYEnblaonZz81LGrbhwQ231yJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AJkAWyHAeKuH+eWmbDgV4BtVLkQVDHGMAnwySjaZIUY18KNU+Gse+VwS3xUgWIvm+GjKNeYaeXebHwG7zfoZ/4wrFbLY9BPAW3H5uJWXFkfkmd3lRxKniZzoaNkP4KoiA1MaKuXlVHVAO2v7W4cBZD1Bk1SG3AGmyqTE8VvJWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qzpQgw33; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734269143;
	bh=N/lB5gYneBd9IFIjiiYEnblaonZz81LGrbhwQ231yJE=;
	h=From:Date:Subject:To:Cc:From;
	b=qzpQgw33uLi5EmmezLrtDvI3SVbzaXAzmPIeDekLqsjirB/svC0KVXqLC4/F9e+S8
	 0P1i9LQt8GLtyo9JVRsckWLAugroES3TO+40z9phEPdq5mRhCaXHFmCN4GTsNyeG7n
	 ODq36CkLiczqqju5WQAW+55TzMSVsMBrbNxiJSpc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 14:25:40 +0100
Subject: [PATCH] mlxbf-bootctl: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-mellanox-v1-1-b6fe4f68e2ca@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANPYXmcC/x3MUQqDMAwA0KtIvhdoO4vbrjJEqqYu4NLRFHGId
 1/Z5/t5ByhlJoVHc0CmjZWTVNhLA9MryELIczU441rrrEf9alSckmjBkWUIpWR807oGSTteO3O
 LYzsb7+9Qj0+myPv/f/bn+QNpkS8HbwAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-mellanox-3708fb4d0559
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Vadim Pasternak <vadimp@nvidia.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734269142; l=1609;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N/lB5gYneBd9IFIjiiYEnblaonZz81LGrbhwQ231yJE=;
 b=+CItkQDjvjWt4TOE6o+WJ26/kZ5d0tJ9HUztb1/YK6IdS2eNoT54Rfz8k8PT2iXMQQnn3PAbZ
 BPx/G6581w/C9QpVO7uMcNcn9hkzIZwx0BKMCZciGWpXSGjVX6aE30x
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index c5b36837e6943ab2cfb8908b03e3d0fe387f2cb0..a2011af48201c6561565920cbac2f18b667c3006 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -939,7 +939,7 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_bootctl_acpi_ids);
 
 static ssize_t mlxbf_bootctl_bootfifo_read(struct file *filp,
 					   struct kobject *kobj,
-					   struct bin_attribute *bin_attr,
+					   const struct bin_attribute *bin_attr,
 					   char *buf, loff_t pos,
 					   size_t count)
 {
@@ -971,9 +971,9 @@ static ssize_t mlxbf_bootctl_bootfifo_read(struct file *filp,
 	return p - buf;
 }
 
-static struct bin_attribute mlxbf_bootctl_bootfifo_sysfs_attr = {
+static const struct bin_attribute mlxbf_bootctl_bootfifo_sysfs_attr = {
 	.attr = { .name = "bootfifo", .mode = 0400 },
-	.read = mlxbf_bootctl_bootfifo_read,
+	.read_new = mlxbf_bootctl_bootfifo_read,
 };
 
 static bool mlxbf_bootctl_guid_match(const guid_t *guid,

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-mellanox-3708fb4d0559

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


