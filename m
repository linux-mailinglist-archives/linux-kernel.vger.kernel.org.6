Return-Path: <linux-kernel+bounces-540018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5391A4AC6F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58F0170FB0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8191E1C1F;
	Sat,  1 Mar 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jRHd29SD"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027A43597B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740840947; cv=none; b=rc71tPVGcnvh3qDcCGHJOEnbWE+GfOaYFrt53d4Iv0YvU2X8UKsK35VNYm2SZ/FSDMT2S9C0ZeLeDz3GOitOpu/elxd+kgN1DJF2AE+yXEb1ndwxaAnnEJzCdXNbE80mxW05qAGahREknFCnHhxkmRGpEZxE4ZWh7xNgm8n2BX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740840947; c=relaxed/simple;
	bh=sTzSp/8qfcEqBSVHmyuGqrapK+jTuhfWi4FyeGdXC+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyu30NMexNa87zHFFRhGL7nLa6PnypIh/7eKB/LKNJcvozQCExO+Ihrterl3Q2RbQDW/vKN1YP/MxlTSoOVrPH0bR5eMpfjIgrJBCDIuetqF3eo8rGKIdINV+XlR/k7666XnrttIACtW+wyIzqDf77sh34U+iAbg06cYRLioT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jRHd29SD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840934; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wO9fUs9nTc63v3PD92iK3A86VObYSvLUKYRWlwxrLN8=;
	b=jRHd29SDNM9xwm3nc0b4mVcc8ijSpSOXUUFTk48qw609RocqX/+ju1T3qVimqqdiGcsLa2rBcAUx9BdKTviijklIp4QkOplHS3eXknGxspAUowm1GQ+/prvYRNcAsCK0wFJMtmHXo9yyTRarGCKkGgd3Ixaha8F1PhQ+mdn03Kw=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSfpY4_1740840614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:14 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [RFC PATCH v6 2/7] erofs: support user-defined fingerprint name
Date: Sat,  1 Mar 2025 22:49:39 +0800
Message-ID: <20250301145002.2420830-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating the EROFS image, users can specify the fingerprint name.
This is to prepare for the upcoming inode page cache share.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/Kconfig    | 10 +++++++++
 fs/erofs/erofs_fs.h |  9 ++++++---
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/super.c    |  4 ++++
 fs/erofs/xattr.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/xattr.h    |  6 ++++++
 6 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6ea60661fa55..d2416d35035a 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -178,3 +178,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_INODE_SHARE
+	bool "EROFS inode page cache share support"
+	depends on EROFS_FS && EROFS_FS_XATTR
+	default n
+	help
+	  This permits EROFS to share page cache for files with same
+	  fingerprints.
+
+	  If unsure, say N.
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 199395ed1c1f..261bd9bd47c4 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -30,6 +30,7 @@
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
+#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000080
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -40,7 +41,8 @@
 	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
 	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
 	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
-	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES)
+	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES | \
+	 EROFS_FEATURE_INCOMPAT_ISHARE_KEY)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -84,8 +86,9 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved2[23];
-};
+	__le32 ishare_key_start; /* start of ishare key */
+	__u8 reserved2[19];
+} __packed;
 
 /*
  * EROFS inode datalayout (i_format in on-disk inode):
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 47004eb89838..21bf9b694048 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -166,6 +166,11 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* inode page cache share support */
+	u32 ishare_key_start;
+	int ishare_key_idx;
+	char *ishare_key;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -233,6 +238,7 @@ EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
+EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index eb052a770088..6af02cc8b8c6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -313,6 +313,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
+	sbi->ishare_key_start = le32_to_cpu(dsb->ishare_key_start);
+
 	sbi->build_time = le64_to_cpu(dsb->build_time);
 	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
@@ -676,6 +678,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	erofs_xattr_set_ishare_key(sb);
+
 	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 7940241d9355..30a64ac3239a 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -549,3 +549,52 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 #endif
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+void erofs_xattr_set_ishare_key(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	struct xattr_handler const *handler;
+	erofs_off_t pos;
+	char *key;
+	int len, i;
+	void *ptr;
+
+	if (!erofs_sb_has_fragments(sbi) || !erofs_sb_has_ishare_key(sbi) ||
+	    !sbi->packed_inode)
+		return;
+
+	buf.mapping = sbi->packed_inode->i_mapping;
+	pos = sbi->ishare_key_start << 2;
+	ptr = erofs_read_metadata(sb, &buf, &pos, &len);
+
+	if (IS_ERR(ptr)) {
+		erofs_put_metabuf(&buf);
+		return;
+	}
+
+	for (i = 0; ARRAY_SIZE(erofs_xattr_handlers); i++) {
+		handler = erofs_xattr_handlers[i];
+		if (!handler)
+			break;
+		if (!memcmp(handler->prefix, ptr, strlen(handler->prefix)))
+			break;
+	}
+
+	if (!handler)
+		return;
+
+	len -= strlen(handler->prefix);
+	key = kzalloc(len + 1, GFP_KERNEL);
+	if (!key) {
+		erofs_put_metabuf(&buf);
+		return;
+	}
+
+	memcpy(key, ptr + strlen(handler->prefix), len);
+	sbi->ishare_key = key;
+	sbi->ishare_key_idx = handler->flags;
+	erofs_put_metabuf(&buf);
+}
+#endif
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index b246cd0e135e..24a243165417 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -70,4 +70,10 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
 #define erofs_get_acl	(NULL)
 #endif
 
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+void erofs_xattr_set_ishare_key(struct super_block *sb);
+#else
+static inline void erofs_xattr_set_ishare_key(struct super_block *sb) {}
+#endif
+
 #endif
-- 
2.43.5


