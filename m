Return-Path: <linux-kernel+bounces-446779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4049F2920
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8AF1884A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947301C3BEF;
	Mon, 16 Dec 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lVyEtQL9"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA22E401
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322072; cv=none; b=Zg3uf7oDzqfX0u1qjr2at00cn7srCjJtYWXOUG/bhOS+biY/c/HV4DQ9QP1f9q2h9bqlRmQd6P2t4t4nh7aaCkiDoExm6wSsJSiRRdFfoyomt0DmmWbWFnVm8A/BwEcz8tmsAWzLPdbQw3278qL5D94TcW3OzAV7Yq3DEmZ8Jbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322072; c=relaxed/simple;
	bh=xVlfF3vwhCOzCWvL8Ii8hOh/IkFAQglYuNvWAMyTYs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7dDrEIdE/RfurTMh7sE0oS93PkM3iNATlIxeoRnw40J1G+WegEwjWogCFkn4V3YfLiFS4JYVXht3LTIb3cOB/94igcO8U6d1xfDD3NpuzaT1x7b9/kgPNd4IGjsvSXOiXQwh/UYAZa9rO+Yb/dWDqJ/z/lsG3g7fI6hgQkANuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lVyEtQL9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734322066;
	bh=xVlfF3vwhCOzCWvL8Ii8hOh/IkFAQglYuNvWAMyTYs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lVyEtQL94BGDrg733MzGrad3i6Ww9VapAuG8dBIxraCIbivycNs0p2YIoGAdSquk1
	 eWXKJhSyNFvnB4wDmdQW/IJkWkWTmRSNYMLX5ZdjH4qdQD7bdQEwRWa5W7aoxnfuPS
	 QOR1l8oJM0tgfbDdh9yg7WpMaSg6V/ADiAO26qFA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 05:07:46 +0100
Subject: [PATCH 4/5] powerpc/powernv/opal: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-powerpc-v1-4-bbed8906f476@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734322065; l=6045;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xVlfF3vwhCOzCWvL8Ii8hOh/IkFAQglYuNvWAMyTYs8=;
 b=v+ZhvbX5ifsO6BpGDVoed2HvRqEPe6UBGxRFwd+zOtrS9MgvHfZXvenQJPZAuot4SPRQeyWC3
 hj3BdHTiZipCkeeYL/LkPyyHk8KBrNUvIW3/IWMZTVIubSF5Xlwrzio
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/platforms/powernv/opal-core.c   | 10 +++++-----
 arch/powerpc/platforms/powernv/opal-dump.c   |  4 ++--
 arch/powerpc/platforms/powernv/opal-elog.c   |  4 ++--
 arch/powerpc/platforms/powernv/opal-flash.c  |  4 ++--
 arch/powerpc/platforms/powernv/opal-msglog.c |  6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index c9a9b759cc928b931a0ac18f7ed7469a6ecd52b5..d95a5f67211b73724d61a0404336a32116872527 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -159,7 +159,7 @@ static Elf64_Word *__init auxv_to_elf64_notes(Elf64_Word *buf,
  * Returns number of bytes read on success, -errno on failure.
  */
 static ssize_t read_opalcore(struct file *file, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *to,
+			     const struct bin_attribute *bin_attr, char *to,
 			     loff_t pos, size_t count)
 {
 	struct opalcore *m;
@@ -206,9 +206,9 @@ static ssize_t read_opalcore(struct file *file, struct kobject *kobj,
 	return (tpos - pos);
 }
 
-static struct bin_attribute opal_core_attr = {
+static struct bin_attribute opal_core_attr __ro_after_init = {
 	.attr = {.name = "core", .mode = 0400},
-	.read = read_opalcore
+	.read_new = read_opalcore
 };
 
 /*
@@ -599,7 +599,7 @@ static struct attribute *mpipl_attr[] = {
 	NULL,
 };
 
-static struct bin_attribute *mpipl_bin_attr[] = {
+static const struct bin_attribute *const mpipl_bin_attr[] = {
 	&opal_core_attr,
 	NULL,
 
@@ -607,7 +607,7 @@ static struct bin_attribute *mpipl_bin_attr[] = {
 
 static const struct attribute_group mpipl_group = {
 	.attrs = mpipl_attr,
-	.bin_attrs =  mpipl_bin_attr,
+	.bin_attrs_new =  mpipl_bin_attr,
 };
 
 static int __init opalcore_init(void)
diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 608e4b68c5ea9d1610e2270b1ba08ed12b69860e..27e25693cf3990e4f53687d38355c4f4c0a7d8c5 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -286,7 +286,7 @@ static int64_t dump_read_data(struct dump_obj *dump)
 }
 
 static ssize_t dump_attr_read(struct file *filep, struct kobject *kobj,
-			      struct bin_attribute *bin_attr,
+			      const struct bin_attribute *bin_attr,
 			      char *buffer, loff_t pos, size_t count)
 {
 	ssize_t rc;
@@ -342,7 +342,7 @@ static void create_dump_obj(uint32_t id, size_t size, uint32_t type)
 	dump->dump_attr.attr.name = "dump";
 	dump->dump_attr.attr.mode = 0400;
 	dump->dump_attr.size = size;
-	dump->dump_attr.read = dump_attr_read;
+	dump->dump_attr.read_new = dump_attr_read;
 
 	dump->id = id;
 	dump->size = size;
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 5db1e733143bfa8c7cb4bda1ab604e825b3f176f..de33f354e9fdd1440f39407aecf1e7085e9b52df 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -156,7 +156,7 @@ static const struct kobj_type elog_ktype = {
 #define OPAL_MAX_ERRLOG_SIZE	16384
 
 static ssize_t raw_attr_read(struct file *filep, struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
+			     const struct bin_attribute *bin_attr,
 			     char *buffer, loff_t pos, size_t count)
 {
 	int opal_rc;
@@ -203,7 +203,7 @@ static void create_elog_obj(uint64_t id, size_t size, uint64_t type)
 	elog->raw_attr.attr.name = "raw";
 	elog->raw_attr.attr.mode = 0400;
 	elog->raw_attr.size = size;
-	elog->raw_attr.read = raw_attr_read;
+	elog->raw_attr.read_new = raw_attr_read;
 
 	elog->id = id;
 	elog->size = size;
diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index d5ea04e8e4c526b99ca8f1ab613266b385362d82..fd8c8621e97340cdf5570d72ce82f86516cb2786 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -432,7 +432,7 @@ static int alloc_image_buf(char *buffer, size_t count)
  * and pre-allocate required memory.
  */
 static ssize_t image_data_write(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buffer, loff_t pos, size_t count)
 {
 	int rc;
@@ -493,7 +493,7 @@ static ssize_t image_data_write(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute image_data_attr = {
 	.attr = {.name = "image", .mode = 0200},
 	.size = MAX_IMAGE_SIZE,	/* Limit image size */
-	.write = image_data_write,
+	.write_new = image_data_write,
 };
 
 static struct kobj_attribute validate_attribute =
diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 22d6efe17b0d01223d1c216a9fb21203a350bddf..f1988d0ab45ce49f09f47c9e8859cc5dfcee3a6d 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -94,15 +94,15 @@ ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
 }
 
 static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
-				struct bin_attribute *bin_attr, char *to,
+				const struct bin_attribute *bin_attr, char *to,
 				loff_t pos, size_t count)
 {
 	return opal_msglog_copy(to, pos, count);
 }
 
-static struct bin_attribute opal_msglog_attr = {
+static struct bin_attribute opal_msglog_attr __ro_after_init = {
 	.attr = {.name = "msglog", .mode = 0400},
-	.read = opal_msglog_read
+	.read_new = opal_msglog_read
 };
 
 struct memcons *__init memcons_init(struct device_node *node, const char *mc_prop_name)

-- 
2.47.1


