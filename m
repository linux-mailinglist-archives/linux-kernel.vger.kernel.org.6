Return-Path: <linux-kernel+bounces-447244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AFA9F2F82
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5173A7A2683
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E29204681;
	Mon, 16 Dec 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uR6FKeW5"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF5203D50
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348785; cv=none; b=gK00+BvbcWh/ejOlLlFF5n+5d2MsuUqEcVXbxw0O7F59JI9CUQW8B5hs2/cRU/bweJ7uzC2L3ikqeuahNetdLrUmyof9+9o8L3nFe92Yrf2FSXQxVedwSpA+IIKJwDSOflkJTivmuTB8VfM9ErIsJzgJzztEWGjzrmHeqsXahm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348785; c=relaxed/simple;
	bh=FtAXAyK33C589+S6JQ5FOb5ZXZI9TCjN1J5zeoHgJe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X27KDWhVeI5bxuNVagbOVJgE07dDX4sd5i2ALj5N3tVb/WPq9H7c+A/Sc85mAQNU1qb00q/lRAj6Kb3ZbuH2/jnLy7LYF0IO3qDUlKcusIp6BpJ8VKxOQkDPQJoITAkMe1AiynrJqxCkRZMFxT1go6ytf5y28L1NIBxnmpWNCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uR6FKeW5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348781;
	bh=FtAXAyK33C589+S6JQ5FOb5ZXZI9TCjN1J5zeoHgJe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uR6FKeW5WemX75/DpwkpBUUCpL65H1aFnpr0t8HgXiJqnknlY8LoYHlwqkPu4iutA
	 yDMhKqcGpes9Bz7STcfERxVg2AToGTsDDCBiTxK/1uzZgXOVwFYfvhqjweerR2H+Vv
	 iZggsiTn7pDhkO8gjcqFaC+ciRTgao0ZTCBAZGV4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:32:56 +0100
Subject: [PATCH 1/9] ocxl: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-1-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=1409;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FtAXAyK33C589+S6JQ5FOb5ZXZI9TCjN1J5zeoHgJe4=;
 b=7YG497eEqeHdVldUHhxXeVxJPMnzNYLDz/i1aXZ4WDfHJBu+adlcVWn9wpigL5EQ/xT7FRLsY
 jqdPY64QgfkBPUA/Qf/D0TksQxgf0I+vSdbUPsdYlKjMgagPVeSZ6st
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/ocxl/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index 07520d6e6dc55702696b8656440914c379e6e27a..e849641687a005fec5eb7a6b2e96bc0e9d04dc05 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -94,7 +94,7 @@ static struct device_attribute afu_attrs[] = {
 };
 
 static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *buf,
+				const struct bin_attribute *bin_attr, char *buf,
 				loff_t off, size_t count)
 {
 	struct ocxl_afu *afu = to_afu(kobj_to_dev(kobj));
@@ -155,7 +155,7 @@ int ocxl_sysfs_register_afu(struct ocxl_file_info *info)
 	info->attr_global_mmio.attr.name = "global_mmio_area";
 	info->attr_global_mmio.attr.mode = 0600;
 	info->attr_global_mmio.size = info->afu->config.global_mmio_size;
-	info->attr_global_mmio.read = global_mmio_read;
+	info->attr_global_mmio.read_new = global_mmio_read;
 	info->attr_global_mmio.mmap = global_mmio_mmap;
 	rc = device_create_bin_file(&info->dev, &info->attr_global_mmio);
 	if (rc) {

-- 
2.47.1


