Return-Path: <linux-kernel+bounces-425532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3A9DC353
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B522827E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA919C56D;
	Fri, 29 Nov 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lrkt3IfV"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D19157484
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882553; cv=none; b=cmMIICjSw4kz/YPO4Ry63nlwUYQxEFaeZzXx0xChP/78CHawL+hAMI7bZ5xOAr2SqDpviPgYQFnzOBpXUt5XrToA1yhigs6YjcBVdj8+tM9vmLdqMlWIFJxkQ9z+QQT66HTG6GMJP4pQ8TyG385MQOo0lfDK/m6sCFU+bgfPGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882553; c=relaxed/simple;
	bh=Ec5Ylbw+5EsfXxfjsO5YMqVrCLxU4XrwLj6ZYaSKphA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKU/eIYnhzmcd5Ey884Swt+sjTFqEWG7LtJ6A4nCaKIBgveq1OQJEiY8cVgoPxVaaZ8J0ml/QHgJvxMYKpBoAVpl6p7y9Ja7TwM3sVF4TZiyPSd54jjFTWccNHIq7LYl2oBgMvMT6xN7htMPjf1MJMNfkqTtCV07/XL+vnFeuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lrkt3IfV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BfCTylWU9ZNPvECdPAqaK056rc2dMnZuQjjgKC06NTc=; t=1732882551; x=1734092151; 
	b=lrkt3IfVFV2gkTIchR07KY2AL0liPBQW4m0yMiZpJQi1V26Jwh9Pg/PpCXKqXuNI7v48AGHXDTB
	S413mQKFd2f27Eu/MgBJXG5wr1uGy8LOyCecrfMPdW1Yh3iU1Q1nH53ylnpxxWK+LN+yCNv2XFWtm
	XfPBYZVc3GVF6Z3p+j34yYMg7A8IcrjPITjQFyxBRkx6EMVPPhkEQbDnCvzz4h/eBp0Oqk8aafOg/
	S6/UIDB4hA6d0HmMayOAeM9zFl9reYklnfKUEQJ3ENVAfGwEsBUDD8DM5gllybCVaTvI4WxQPdEUK
	qI6/GgR70PqulDcUq1f/svI833KoADk/Eiwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tGzuQ-00000001Mux-3zFM;
	Fri, 29 Nov 2024 13:15:43 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fs: debugfs: differentiate short fops with proxy ops
Date: Fri, 29 Nov 2024 13:15:37 +0100
Message-ID: <20241129121536.30989-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Geert reported that my previous short fops debugfs changes
broke m68k, because it only has mandatory alignement of two,
so we can't stash the "is it short" information into the
pointer (as we already did with the "is it real" bit.)

Instead, exploit the fact that debugfs_file_get() called on
an already open file will already find that the fsdata is
no longer the real fops but rather the allocated data that
already distinguishes full/short ops, so only open() needs
to be able to distinguish. We can achieve that by using two
different open functions.

Unfortunately this requires another set of full file ops,
increasing the size by 536 bytes (x86-64), but that's still
a reasonable trade-off given that only converting some of
the wireless stack gained over 28k. This brings the total
cost of this to around 1k, for wins of 28k (all x86-64).

Reported-and-tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com
Fixes: 8dc6d81c6b2a ("debugfs: add small file operations for most files")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c     | 72 ++++++++++++++++++++++++++++++-------------
 fs/debugfs/inode.c    | 11 +++----
 fs/debugfs/internal.h |  6 +---
 3 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 47dc96dfe386..bdb4f2ca0506 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -64,22 +64,13 @@ const struct file_operations *debugfs_real_fops(const struct file *filp)
 }
 EXPORT_SYMBOL_GPL(debugfs_real_fops);
 
-/**
- * debugfs_file_get - mark the beginning of file data access
- * @dentry: the dentry object whose data is being accessed.
- *
- * Up to a matching call to debugfs_file_put(), any successive call
- * into the file removing functions debugfs_remove() and
- * debugfs_remove_recursive() will block. Since associated private
- * file data may only get freed after a successful return of any of
- * the removal functions, you may safely access it after a successful
- * call to debugfs_file_get() without worrying about lifetime issues.
- *
- * If -%EIO is returned, the file has already been removed and thus,
- * it is not safe to access any of its data. If, on the other hand,
- * it is allowed to access the file data, zero is returned.
- */
-int debugfs_file_get(struct dentry *dentry)
+enum dbgfs_get_mode {
+	DBGFS_GET_ALREADY,
+	DBGFS_GET_REGULAR,
+	DBGFS_GET_SHORT,
+};
+
+static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 {
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
@@ -96,15 +87,17 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
 	} else {
+		if (WARN_ON(mode == DBGFS_GET_ALREADY))
+			return -EINVAL;
+
 		fsd = kmalloc(sizeof(*fsd), GFP_KERNEL);
 		if (!fsd)
 			return -ENOMEM;
 
-		if ((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT) {
+		if (mode == DBGFS_GET_SHORT) {
 			fsd->real_fops = NULL;
 			fsd->short_fops = (void *)((unsigned long)d_fsd &
-						~(DEBUGFS_FSDATA_IS_REAL_FOPS_BIT |
-						  DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+						~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
 		} else {
 			fsd->real_fops = (void *)((unsigned long)d_fsd &
 						~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -138,6 +131,26 @@ int debugfs_file_get(struct dentry *dentry)
 
 	return 0;
 }
+
+/**
+ * debugfs_file_get - mark the beginning of file data access
+ * @dentry: the dentry object whose data is being accessed.
+ *
+ * Up to a matching call to debugfs_file_put(), any successive call
+ * into the file removing functions debugfs_remove() and
+ * debugfs_remove_recursive() will block. Since associated private
+ * file data may only get freed after a successful return of any of
+ * the removal functions, you may safely access it after a successful
+ * call to debugfs_file_get() without worrying about lifetime issues.
+ *
+ * If -%EIO is returned, the file has already been removed and thus,
+ * it is not safe to access any of its data. If, on the other hand,
+ * it is allowed to access the file data, zero is returned.
+ */
+int debugfs_file_get(struct dentry *dentry)
+{
+	return __debugfs_file_get(dentry, DBGFS_GET_ALREADY);
+}
 EXPORT_SYMBOL_GPL(debugfs_file_get);
 
 /**
@@ -424,7 +437,8 @@ static void __full_proxy_fops_init(struct file_operations *proxy_fops,
 		proxy_fops->unlocked_ioctl = full_proxy_unlocked_ioctl;
 }
 
-static int full_proxy_open(struct inode *inode, struct file *filp)
+static int full_proxy_open(struct inode *inode, struct file *filp,
+			   enum dbgfs_get_mode mode)
 {
 	struct dentry *dentry = F_DENTRY(filp);
 	const struct file_operations *real_fops;
@@ -432,7 +446,7 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 	struct debugfs_fsdata *fsd;
 	int r;
 
-	r = debugfs_file_get(dentry);
+	r = __debugfs_file_get(dentry, mode);
 	if (r)
 		return r == -EIO ? -ENOENT : r;
 
@@ -491,8 +505,22 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 	return r;
 }
 
+static int full_proxy_open_regular(struct inode *inode, struct file *filp)
+{
+	return full_proxy_open(inode, filp, DBGFS_GET_REGULAR);
+}
+
 const struct file_operations debugfs_full_proxy_file_operations = {
-	.open = full_proxy_open,
+	.open = full_proxy_open_regular,
+};
+
+static int full_proxy_open_short(struct inode *inode, struct file *filp)
+{
+	return full_proxy_open(inode, filp, DBGFS_GET_SHORT);
+}
+
+const struct file_operations debugfs_full_short_proxy_file_operations = {
+	.open = full_proxy_open_short,
 };
 
 ssize_t debugfs_attr_read(struct file *file, char __user *buf,
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 38a9c7eb97e6..65e46c7b6bf1 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -455,8 +455,7 @@ struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					const struct file_operations *fops)
 {
 	if (WARN_ON((unsigned long)fops &
-		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
-		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
 		return ERR_PTR(-EINVAL);
 
 	return __debugfs_create_file(name, mode, parent, data,
@@ -471,15 +470,13 @@ struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
 					 const struct debugfs_short_fops *fops)
 {
 	if (WARN_ON((unsigned long)fops &
-		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
-		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
 		return ERR_PTR(-EINVAL);
 
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_full_proxy_file_operations :
+				fops ? &debugfs_full_short_proxy_file_operations :
 					&debugfs_noop_file_operations,
-				(const void *)((unsigned long)fops |
-					       DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_short);
 
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index a3edfa4f0d8e..bbae4a228ef4 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -15,6 +15,7 @@ struct file_operations;
 extern const struct file_operations debugfs_noop_file_operations;
 extern const struct file_operations debugfs_open_proxy_file_operations;
 extern const struct file_operations debugfs_full_proxy_file_operations;
+extern const struct file_operations debugfs_full_short_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
@@ -40,11 +41,6 @@ struct debugfs_fsdata {
  * pointer gets its lowest bit set.
  */
 #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
-/*
- * A dentry's ->d_fsdata, when pointing to real fops, is with
- * short fops instead of full fops.
- */
-#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)
 
 /* Access BITS */
 #define DEBUGFS_ALLOW_API	BIT(0)
-- 
2.47.0


