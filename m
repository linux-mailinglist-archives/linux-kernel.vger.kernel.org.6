Return-Path: <linux-kernel+bounces-411029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F39CF3A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF1DB426A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77F1D63D8;
	Fri, 15 Nov 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p37FMwWy"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2041D61AF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688979; cv=none; b=FmC+tyLABbRlzlFyDgx+pS831xLqzpXp8jyiZ3wW5ivI1E1ll4tIFiYKpX2k4qjOQp7h8LLlqRf6RyQiKcQZpuN7sPmBQixkrPTVXkBcGMlRCn8ilsxQSoYRgd43FHK8YQTczbOBdPoaoKkxUsssR30wF67kzlQaICyZTR2dUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688979; c=relaxed/simple;
	bh=sCHDvz5XINhe3NJ1hH91Y0pmA+s4dNVYcACqvMciAsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehkbmSO0UIX0Kgi45u1kTeQWS7vvjm04CAhZWMv21IZAyp4ad1pTiUNa8uUzXwLY7f4+CPp60KHPVHZGVpLIJqV3XAKLc9RPDqaQYFsuflQDD0tqusOmiUZQjHxSBZLy/GWJj0GtBynHZ4/SRXFBknvYP90kHwKg878skByIO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p37FMwWy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731688975;
	bh=sCHDvz5XINhe3NJ1hH91Y0pmA+s4dNVYcACqvMciAsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p37FMwWySAfICZ9XYXSTEs2+vOXT+DLicEVZGEyttGZvugM2vAtbxsO524HVEaMIH
	 Fx46SXVIa7UASUIov71vQVYGTXS4V6+v5dvwDua9XbCPNw61tPa/ZAKxsnN2Yu+J2X
	 a2NkVsqO9XzUFId+CxmWIGQgPbASDllJAuo0mHbQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Nov 2024 17:42:49 +0100
Subject: [PATCH 2/2] driver core: Constify bin_attribute definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241115-b4-sysfs-const-bin_attr-group-v1-2-2c9bb12dfc48@weissschuh.net>
References: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
In-Reply-To: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731688975; l=5476;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sCHDvz5XINhe3NJ1hH91Y0pmA+s4dNVYcACqvMciAsY=;
 b=ekXgEFbVdG8gUxAqk81cTBZKHWT94VW2pYv0gY3PF6puH7vzcMcZpMPtjAv2aM9wKMauVJyiW
 4L73m+lVVW/DlDqO2GNi+NFm/upTaSvWKxH3/mjwtIuvwRIpnruL/Tm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Mark all 'struct bin_attribute' instances as const to protect against
accidental and malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/base/node.c     |  8 ++++----
 drivers/base/topology.c | 36 ++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 3e761633ac75826bedb5dd30b879f7cc1af95ec3..0ea653fa34330eb2d89daae455b4b9f101b79f4e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
 
 static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 				   const struct bin_attribute *attr, char *buf,
@@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
 
 /**
  * struct node_access_nodes - Access class device to hold user visible
@@ -578,7 +578,7 @@ static struct attribute *node_dev_attrs[] = {
 	NULL
 };
 
-static struct bin_attribute *node_dev_bin_attrs[] = {
+static const struct bin_attribute *node_dev_bin_attrs[] = {
 	&bin_attr_cpumap,
 	&bin_attr_cpulist,
 	NULL
@@ -586,7 +586,7 @@ static struct bin_attribute *node_dev_bin_attrs[] = {
 
 static const struct attribute_group node_dev_group = {
 	.attrs = node_dev_attrs,
-	.bin_attrs = node_dev_bin_attrs
+	.bin_attrs_new = node_dev_bin_attrs,
 };
 
 static const struct attribute_group *node_dev_groups[] = {
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 1090751d7f458ce8d2a50e82d65b8ce31e938f15..cf160dd2c27bd7302bb8d181ca54ec9aa840fe1c 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -62,50 +62,50 @@ define_id_show_func(ppin, "0x%llx");
 static DEVICE_ATTR_ADMIN_RO(ppin);
 
 define_siblings_read_func(thread_siblings, sibling_cpumask);
-static BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
 
 define_siblings_read_func(core_cpus, sibling_cpumask);
-static BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
 
 define_siblings_read_func(core_siblings, core_cpumask);
-static BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
 
 #ifdef TOPOLOGY_CLUSTER_SYSFS
 define_siblings_read_func(cluster_cpus, cluster_cpumask);
-static BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 #ifdef TOPOLOGY_DIE_SYSFS
 define_siblings_read_func(die_cpus, die_cpumask);
-static BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 define_siblings_read_func(package_cpus, core_cpumask);
-static BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
 
 #ifdef TOPOLOGY_BOOK_SYSFS
 define_id_show_func(book_id, "%d");
 static DEVICE_ATTR_RO(book_id);
 define_siblings_read_func(book_siblings, book_cpumask);
-static BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 #ifdef TOPOLOGY_DRAWER_SYSFS
 define_id_show_func(drawer_id, "%d");
 static DEVICE_ATTR_RO(drawer_id);
 define_siblings_read_func(drawer_siblings, drawer_cpumask);
-static BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
-static BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
+static const BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
-static struct bin_attribute *bin_attrs[] = {
+static const struct bin_attribute *const bin_attrs[] = {
 	&bin_attr_core_cpus,
 	&bin_attr_core_cpus_list,
 	&bin_attr_thread_siblings,
@@ -163,7 +163,7 @@ static umode_t topology_is_visible(struct kobject *kobj,
 
 static const struct attribute_group topology_attr_group = {
 	.attrs = default_attrs,
-	.bin_attrs = bin_attrs,
+	.bin_attrs_new = bin_attrs,
 	.is_visible = topology_is_visible,
 	.name = "topology"
 };

-- 
2.47.0


