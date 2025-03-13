Return-Path: <linux-kernel+bounces-559846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3917A5FA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754B17A5FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD44269882;
	Thu, 13 Mar 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i2lSVCkW"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68C26980E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881479; cv=none; b=DdXMN1wiBvslTWIyej4Px9vVti4vmjCJ1zI/pJ1uqrJnUGGGN6X0iEVAB3jwbxTPIMCjyxkn/GVxK3x3eXCy8pP4kEw4sIhE6Kp3Otb9ty6oVaGm/avO/F5J9on0xv8tGYCxFtiXNW/3E2r6yEWqefdjKma5YhK7zv4ioNSoo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881479; c=relaxed/simple;
	bh=qEXiivsnDQoG0MrFFiTKQ0Vm/iXPPpAB53Ih4xeTTUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XklqtKR3wHUdJuY4nPK8maHz35n6KtgEQcO7JOemDGd+Ef/ACH9hVSqsDKLed+ZLht1EtR0NGP6VrdPfjq7Ds31gsJwa7tMtATUrbg70FDKwCjA9fJpZeUDVmaeNjgUq4u3Rfzdb46pBFt58PYitjXjgTSyfJwatsYhEh9I2VgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i2lSVCkW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741881466;
	bh=qEXiivsnDQoG0MrFFiTKQ0Vm/iXPPpAB53Ih4xeTTUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i2lSVCkWGH/q15IGK0GxSKBFO31xEbEnh72tjHtHu1pFCcI2KWP8s/PAtJHwHggv2
	 +osTy6ZuYFFzKeJwVsIJLk7mbHMNGKw3mnDh6UCkDykNArVU5iyqX72VbQXwAOluq3
	 92Dq+q1Wt4Vbnp4xa/TZLlvYVHcFSfk/9Mgq4NPM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Mar 2025 16:57:49 +0100
Subject: [PATCH v2 5/6] sysfs: remove bin_attribute::read_new/write_new()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-sysfs-const-bin_attr-final-v2-5-96284e1e88ce@weissschuh.net>
References: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
In-Reply-To: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741881465; l=2951;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qEXiivsnDQoG0MrFFiTKQ0Vm/iXPPpAB53Ih4xeTTUE=;
 b=+uZvg7SS/j8v2BHKKA7hILiJR2Jd7lGBMWF3Do+YrTSjYLT3rEHOJSAHrgK3yQ4ySNcdFFL5p
 jYrg5RWSuPMByboZcBnowGh8nmDqwI5u59DjTnkmAMDKzZSS618S4Qs
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
index c3d3b079aedde7ca5318328fe853ccf891d663e9..05b61c701a377ea2644d19c1b89491a49b69da63 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -97,12 +97,9 @@ static ssize_t sysfs_kf_bin_read(struct kernfs_open_file *of, char *buf,
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
 
@@ -161,12 +158,9 @@ static ssize_t sysfs_kf_bin_write(struct kernfs_open_file *of, char *buf,
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
 
@@ -335,19 +329,13 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
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


