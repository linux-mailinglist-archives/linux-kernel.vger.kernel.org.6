Return-Path: <linux-kernel+bounces-389901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F69B72A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC482853AD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F815146A60;
	Thu, 31 Oct 2024 02:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QM1O/uH8"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029C13C9C0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342674; cv=none; b=CYNnNoWXlilB5/qDNvFLov8//UoYiKQEjA0VQ5yIoq8V1RZk2EFYBkeK0PQFs2YwUC9K29T5Px0pBCyzDnV8mW5GAZuKxhTd6HO28mL2b0EtvmcZiX2/7r3SwpY+RAGRt/DO1RF1wEZN5hHKR2n3oYH8mX6kmohF0XzMFhesfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342674; c=relaxed/simple;
	bh=oL8Kp9Zy302HGyHPYfss16ykvbWIdf2BUzXuS9J1tY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DODF8jhZjqmlPjQ79w7BCPcOVk8piuB+NkOAceTeuYGmYQuqtDNM5lMwqvwvPh+uCLQj6LA3PnYQoxDxotg0z5EEvv5kEfpCn73hpNw/Gw78SHGb+cGT+E1imam0OEgibYrVx49UNvFNBhuMcJQiDqkWVEC9jTuNfB1vUI+y298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QM1O/uH8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342670;
	bh=oL8Kp9Zy302HGyHPYfss16ykvbWIdf2BUzXuS9J1tY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QM1O/uH80bioL45UeRTBIQxfPBaVT14107nyKAlmZ//FiCCl1PWa+qZrnbZnk1VGh
	 PQojZSy/guUQ/LB0NEfNNU5W77tnNqReTOcDwHUwBRYQqQfmThqwaMa1gsW9u65hcl
	 DMTGS79r5uqi9Z9EWGPcbi9utL7E08rkHRWGLcQo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:58 +0000
Subject: [PATCH RFC 09/10] sysfs: bin_attribute: add const read/write
 callback variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-9-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=4665;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oL8Kp9Zy302HGyHPYfss16ykvbWIdf2BUzXuS9J1tY4=;
 b=8CA5QG4cEMCokmQetltBwJND1XMM/NIPB0ZHqAwc3GbqGDdIR/RrddTTG+IZPi1ovkNFt5Jyd
 Vd7WxvlDFORDhlPVtpulQM5v8eEYdVN4ckfleobNKqxmEiJdkzSKofe
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To make it possible to put struct bin_attribute into read-only memory,
the sysfs core has to stop passing mutable pointers to the read() and
write() callbacks.
As there are numerous implementors of these callbacks throughout the
tree it's not possible to change all of them at once.
To enable a step-by-step transition, add new variants of the read() and
write() callbacks which differ only in the constness of the struct
bin_attribute argument.

As most binary attributes are defined through macros, extend these
macros to transparently handle both variants of callbacks to minimize
the churn during the transition.
As soon as all handlers are switch to the const variant, the non-const
one can be removed together with the transition machinery.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/sysfs/file.c       | 16 +++++++++++-----
 include/linux/sysfs.h | 31 +++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 3515c172ec8ff70b87847d226a1b3bc3b60826f9..58a98b4dc9b28dab9e36c831581608eaf6f95848 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -91,9 +91,12 @@ static ssize_t sysfs_kf_bin_read(struct kernfs_open_file *of, char *buf,
 			count = size - pos;
 	}
 
-	if (!battr->read)
+	if (!battr->read && !battr->read_new)
 		return -EIO;
 
+	if (battr->read_new)
+		return battr->read_new(of->file, kobj, battr, buf, pos, count);
+
 	return battr->read(of->file, kobj, battr, buf, pos, count);
 }
 
@@ -152,9 +155,12 @@ static ssize_t sysfs_kf_bin_write(struct kernfs_open_file *of, char *buf,
 	if (!count)
 		return 0;
 
-	if (!battr->write)
+	if (!battr->write && !battr->write_new)
 		return -EIO;
 
+	if (battr->write_new)
+		return battr->write_new(of->file, kobj, battr, buf, pos, count);
+
 	return battr->write(of->file, kobj, battr, buf, pos, count);
 }
 
@@ -319,11 +325,11 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 
 	if (battr->mmap)
 		ops = &sysfs_bin_kfops_mmap;
-	else if (battr->read && battr->write)
+	else if ((battr->read || battr->read_new) && (battr->write || battr->write_new))
 		ops = &sysfs_bin_kfops_rw;
-	else if (battr->read)
+	else if (battr->read || battr->read_new)
 		ops = &sysfs_bin_kfops_ro;
-	else if (battr->write)
+	else if (battr->write || battr->write_new)
 		ops = &sysfs_bin_kfops_wo;
 	else
 		ops = &sysfs_file_kfops_empty;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 5ece63c83ba5829b6eb0f115bdea12a1412ae039..34e94e75231166839452b89aa1114d90657257d1 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -305,8 +305,12 @@ struct bin_attribute {
 	struct address_space *(*f_mapping)(void);
 	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
 			char *, loff_t, size_t);
+	ssize_t (*read_new)(struct file *, struct kobject *, const struct bin_attribute *,
+			    char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
 			 char *, loff_t, size_t);
+	ssize_t (*write_new)(struct file *, struct kobject *,
+			     const struct bin_attribute *, char *, loff_t, size_t);
 	int (*mmap)(struct file *, struct kobject *, const struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
 };
@@ -323,11 +327,34 @@ struct bin_attribute {
  */
 #define sysfs_bin_attr_init(bin_attr) sysfs_attr_init(&(bin_attr)->attr)
 
+typedef ssize_t __sysfs_rw_handler(struct file *, struct kobject *,
+				   struct bin_attribute *, char *, loff_t, size_t);
+typedef ssize_t __sysfs_rw_handler_new(struct file *, struct kobject *,
+				       const struct bin_attribute *, char *, loff_t, size_t);
+
 /* macros to create static binary attributes easier */
 #define __BIN_ATTR(_name, _mode, _read, _write, _size) {		\
 	.attr = { .name = __stringify(_name), .mode = _mode },		\
-	.read	= _read,						\
-	.write	= _write,						\
+	.read = _Generic(_read,						\
+		__sysfs_rw_handler * : _read,				\
+		__sysfs_rw_handler_new * : NULL,			\
+		void * : NULL						\
+	),								\
+	.read_new = _Generic(_read,					\
+		__sysfs_rw_handler * : NULL,				\
+		__sysfs_rw_handler_new * : _read,			\
+		void * : NULL						\
+	),								\
+	.write = _Generic(_write,					\
+		__sysfs_rw_handler * : _write,				\
+		__sysfs_rw_handler_new * : NULL,			\
+		void * : NULL						\
+	),								\
+	.write_new = _Generic(_write,					\
+		__sysfs_rw_handler * : NULL,				\
+		__sysfs_rw_handler_new * : _write,			\
+		void * : NULL						\
+	),								\
 	.size	= _size,						\
 }
 

-- 
2.47.0


