Return-Path: <linux-kernel+bounces-522535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11603A3CB94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8B1177EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE42580E6;
	Wed, 19 Feb 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fS5AAjqT"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C42580DE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000965; cv=none; b=EhVEUfSIa6vrNRzNE8N6jDban51sjs8uRBB4sgPqRCo9M3JCdqC+iq+E3ng7mAmOwXqF+DIvVS2160KJlVJEjc0zDdhZOJQjZQmmvz9d2k9EoLFlKr+lKi5P1wprq+7yDL2inlG2pYqxIsh4bJGNs50BxOEY2tfjln0KUHlT4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000965; c=relaxed/simple;
	bh=M5B8kvCq/gjHQEEY5uZDw9RlEzBjc3h1b3/euy/FrR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AglhTGjCU/aUCCF39foUkMtjGO4ZblugxFumktR6WFck8+FR48oWS/k+cnH6WPjU/lq8rBXh8GQE7lOUCoTKg6JFG4bYN3KMdqpZiFkl3gGVjJ0qf8kpBR1CdFC/KBN968Txmk+pbKsDO3vnE2RTQFrNICx6BGMaccYaBxPIonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fS5AAjqT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740000961;
	bh=M5B8kvCq/gjHQEEY5uZDw9RlEzBjc3h1b3/euy/FrR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fS5AAjqTCu0oonlBRsIwS4LwQ7ymrLcHUoh3EHqmVO6JolRsnp9AShTi8ErogZyZO
	 fayg9bWtpZhNhzqcyEOnUCpAruMmFQfjRrZ4JOWjrINT7rDhhWi38xkcywhW1qhQ+K
	 nJIL92BZx4mnd79TghbnWHjcu7/v13fWT9OzifEI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Feb 2025 22:34:54 +0100
Subject: [PATCH 5/6] sysfs: remove bin_attribute::read_new/write_new()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-sysfs-const-bin_attr-final-v1-5-02828d86af3c@weissschuh.net>
References: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
In-Reply-To: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740000960; l=2951;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=M5B8kvCq/gjHQEEY5uZDw9RlEzBjc3h1b3/euy/FrR8=;
 b=VAYRHpN9coNA5YzhgxXZJLH7tRe8yLOSC6bLEPkzR4DENQEczOSOg9xbF+h5VuNZ3rIY71R+e
 wHkJguS9yX7ArnRwgb/+QxK6eCxbIFsTA338DW020COfdw+g3MdOLv1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These transitional fields are unnecessary und unused.
Remove them and their logic in the sysfs core.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/file.c       | 22 +++++-----------------
 include/linux/sysfs.h |  4 ----
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 6931308876c4ac3b4c19878d5e1158ad8fe4f16f..7f4cac71615a4331166cba9139ccb6b458f227a3 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -91,12 +91,9 @@ static ssize_t sysfs_kf_bin_read(struct kernfs_open_file *of, char *buf,
 			count = size - pos;
 	}
 
-	if (!battr->read && !battr->read_new)
+	if (!battr->read)
 		return -EIO;
 
-	if (battr->read_new)
-		return battr->read_new(of->file, kobj, battr, buf, pos, count);
-
 	return battr->read(of->file, kobj, battr, buf, pos, count);
 }
 
@@ -155,12 +152,9 @@ static ssize_t sysfs_kf_bin_write(struct kernfs_open_file *of, char *buf,
 	if (!count)
 		return 0;
 
-	if (!battr->write && !battr->write_new)
+	if (!battr->write)
 		return -EIO;
 
-	if (battr->write_new)
-		return battr->write_new(of->file, kobj, battr, buf, pos, count);
-
 	return battr->write(of->file, kobj, battr, buf, pos, count);
 }
 
@@ -329,19 +323,13 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 	const struct kernfs_ops *ops;
 	struct kernfs_node *kn;
 
-	if (battr->read && battr->read_new)
-		return -EINVAL;
-
-	if (battr->write && battr->write_new)
-		return -EINVAL;
-
 	if (battr->mmap)
 		ops = &sysfs_bin_kfops_mmap;
-	else if ((battr->read || battr->read_new) && (battr->write || battr->write_new))
+	else if (battr->read && battr->write)
 		ops = &sysfs_bin_kfops_rw;
-	else if (battr->read || battr->read_new)
+	else if (battr->read)
 		ops = &sysfs_bin_kfops_ro;
-	else if (battr->write || battr->write_new)
+	else if (battr->write)
 		ops = &sysfs_bin_kfops_wo;
 	else
 		ops = &sysfs_file_kfops_empty;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index f418aae4f1134f8126783d9e8eb575ba4278e927..7544f6d81c05982b5d168624f376cd647127ab51 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -308,12 +308,8 @@ struct bin_attribute {
 	struct address_space *(*f_mapping)(void);
 	ssize_t (*read)(struct file *, struct kobject *, const struct bin_attribute *,
 			char *, loff_t, size_t);
-	ssize_t (*read_new)(struct file *, struct kobject *, const struct bin_attribute *,
-			    char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, const struct bin_attribute *,
 			 char *, loff_t, size_t);
-	ssize_t (*write_new)(struct file *, struct kobject *,
-			     const struct bin_attribute *, char *, loff_t, size_t);
 	loff_t (*llseek)(struct file *, struct kobject *, const struct bin_attribute *,
 			 loff_t, int);
 	int (*mmap)(struct file *, struct kobject *, const struct bin_attribute *attr,

-- 
2.48.1


