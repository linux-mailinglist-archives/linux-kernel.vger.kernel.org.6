Return-Path: <linux-kernel+bounces-389899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D309B72A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A731C22F18
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239312C489;
	Thu, 31 Oct 2024 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IDH4HxRW"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5C13B586
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342673; cv=none; b=R+/JJTj/if3qVz4qUDN9gANvChgpuVXJRoeFtzTO3IIpO2h+P8sIyONlNeIhZUuFC3vQ/how/BsPy94GYapzO3lZbjpmwJSzgpBGZuIwOj19ytIs+fRE2XyswWb3rSa2P6C6uuX3hk0IdCx30u8+/1d6MxxYjGHtm1wLKK142no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342673; c=relaxed/simple;
	bh=T1BA7i5hh0VB3bv+J/Vp/hXtY5JBZ5VWww5X1VE5szM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5OneQjphYvFexzlF+r6Nnn2iXDg2ImpZWDsyB7tlBonVryJfC4TlNBSKgHUd6iw60DP/N9aNadVDfj0v7MFIB1/tWQmUceJuarI53Yv3brAfrVO5zzccqNXkgghBsIjI9A850PmP7BgPCGJJR961hMqLuLcPMI0MakuDHzGAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IDH4HxRW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342669;
	bh=T1BA7i5hh0VB3bv+J/Vp/hXtY5JBZ5VWww5X1VE5szM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IDH4HxRWPL+3qnZ4RiYBMZEFS5WlyYl7Wno1oflObQwP92amMxAEk+0YIpj04xL04
	 +/tfefUYg28F0cp+4xvvwtT6qkwIx5ujFVgEYkC/Ru3iupmCt8UpoL/dXMmJ06GxZP
	 N12s5YcwNnoQuY9tudgGnCDI/TXidfsy6qM2es64=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:56 +0000
Subject: [PATCH RFC 07/10] sysfs: drop callback bin_attribute::llseek
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-7-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=1612;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=T1BA7i5hh0VB3bv+J/Vp/hXtY5JBZ5VWww5X1VE5szM=;
 b=3dln9Zw+Okjg5Zioa5YThSfXDcVFJh2zOMjYeAAdfxukctVYtITWxGJRFBV4s1zZJ1bUdcCyZ
 ZZejcuP82y4C7peLy9t/kyJJ0fO11L7LJz6PbYW/94bVNgq86BsxxiQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The callback is never implemented, drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/file.c       | 8 +-------
 include/linux/sysfs.h | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 6d39696b43069010b0ad0bdaadcf9002cb70c92c..3515c172ec8ff70b87847d226a1b3bc3b60826f9 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -170,13 +170,7 @@ static int sysfs_kf_bin_mmap(struct kernfs_open_file *of,
 static loff_t sysfs_kf_bin_llseek(struct kernfs_open_file *of, loff_t offset,
 				  int whence)
 {
-	struct bin_attribute *battr = of->kn->priv;
-	struct kobject *kobj = of->kn->parent->priv;
-
-	if (battr->llseek)
-		return battr->llseek(of->file, kobj, battr, offset, whence);
-	else
-		return generic_file_llseek(of->file, offset, whence);
+	return generic_file_llseek(of->file, offset, whence);
 }
 
 static int sysfs_kf_bin_open(struct kernfs_open_file *of)
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 9fcdc8cd3118f359742bfd8b708d5c3eff511042..8344c0198c61cc44995c38d46d926360e7a88873 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -307,8 +307,6 @@ struct bin_attribute {
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
 			 char *, loff_t, size_t);
-	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
-			 loff_t, int);
 	int (*mmap)(struct file *, struct kobject *, const struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
 };

-- 
2.47.0


