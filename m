Return-Path: <linux-kernel+bounces-363875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA799C815
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB697B288E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84C1C330D;
	Mon, 14 Oct 2024 11:01:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24731C32FF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903664; cv=none; b=MNi8YBDL795gg840lkT8srHnC65jTV2w2juSNcqIZkVDGkNrsS4ysGVLTDDQGNmd66Jn9qzyAG4O1M7J18EqZSFsmMB2yfjFK9vMi04jKQaThF2tW15s8tiPpK62GyFgrhhHZlJS9OYsYLdkQBOXcCUWCJa4uOLzyW5ftPKRptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903664; c=relaxed/simple;
	bh=S3goNA8RPfHYwLHqtnd5h1RE7o8K/K9TDeZQJY3JteE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLHIrqDoL+HWPl/YkbdAHXcSaFUxkyZMF5+tGaNj47Y6/jivvjZXZ1AWisHDiDCoGZo6tlA8b86MkGbGPKQCGI8HVPdyysQDe/pxdaUJ+v2t//kW1mFDlxG2AZ+StMjbbW5qf+L5BXUEEl8OXgcH1mr1lvUblv4siAPHMyh02QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1454116F3;
	Mon, 14 Oct 2024 04:01:32 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAD463F51B;
	Mon, 14 Oct 2024 04:00:59 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 30/57] drivers/base: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:37 +0100
Message-ID: <20241014105912.3207374-30-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Update BUILD_BUG_ON() to test against page size limits.

CPUMAP_FILE_MAX_BYTES and CPULIST_FILE_MAX_BYTES are both defined
relative to PAGE_SIZE, so when these values are assigned to global
variables via BIN_ATTR_RO(), let's wrap them with
DEFINE_GLOBAL_PAGE_SIZE_VAR() so that their assignment can be deferred
until boot-time.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/base/node.c     |  6 +++---
 drivers/base/topology.c | 32 ++++++++++++++++----------------
 include/linux/cpumask.h |  5 +++++
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e62..30e6549e4c438 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
 
 static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 				   struct bin_attribute *attr, char *buf,
@@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
 
 /**
  * struct node_access_nodes - Access class device to hold user visible
@@ -558,7 +558,7 @@ static ssize_t node_read_distance(struct device *dev,
 	 * buf is currently PAGE_SIZE in length and each node needs 4 chars
 	 * at the most (distance + space or newline).
 	 */
-	BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE);
+	BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE_MIN);
 
 	for_each_online_node(i) {
 		len += sysfs_emit_at(buf, len, "%s%d",
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b99..bdbdbefd95b15 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -62,47 +62,47 @@ define_id_show_func(ppin, "0x%llx");
 static DEVICE_ATTR_ADMIN_RO(ppin);
 
 define_siblings_read_func(thread_siblings, sibling_cpumask);
-static BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
 
 define_siblings_read_func(core_cpus, sibling_cpumask);
-static BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
 
 define_siblings_read_func(core_siblings, core_cpumask);
-static BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
 
 #ifdef TOPOLOGY_CLUSTER_SYSFS
 define_siblings_read_func(cluster_cpus, cluster_cpumask);
-static BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 #ifdef TOPOLOGY_DIE_SYSFS
 define_siblings_read_func(die_cpus, die_cpumask);
-static BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 define_siblings_read_func(package_cpus, core_cpumask);
-static BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
 
 #ifdef TOPOLOGY_BOOK_SYSFS
 define_id_show_func(book_id, "%d");
 static DEVICE_ATTR_RO(book_id);
 define_siblings_read_func(book_siblings, book_cpumask);
-static BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 #ifdef TOPOLOGY_DRAWER_SYSFS
 define_id_show_func(drawer_id, "%d");
 static DEVICE_ATTR_RO(drawer_id);
 define_siblings_read_func(drawer_siblings, drawer_cpumask);
-static BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
+static CPU_FILE_BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 static struct bin_attribute *bin_attrs[] = {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 53158de44b837..f654b4198abc2 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1292,4 +1292,9 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
 					? (NR_CPUS * 9)/32 - 1 : PAGE_SIZE)
 #define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7)/2 > PAGE_SIZE) ? (NR_CPUS * 7)/2 : PAGE_SIZE)
 
+#define CPU_FILE_BIN_ATTR_RO(_name, _size)				\
+	DEFINE_GLOBAL_PAGE_SIZE_VAR(struct bin_attribute,		\
+				    bin_attr_##_name,			\
+				    __BIN_ATTR_RO(_name, _size))
+
 #endif /* __LINUX_CPUMASK_H */
-- 
2.43.0


