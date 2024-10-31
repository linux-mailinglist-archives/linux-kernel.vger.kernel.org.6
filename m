Return-Path: <linux-kernel+bounces-389897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4C9B729E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DED1F22D36
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165D13D502;
	Thu, 31 Oct 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ClujitPX"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77EF135A79
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342672; cv=none; b=IdG7b3dwq3S4cmdPd+oHDbeJaBWQ94gwEr1dHiFZBBMl23E7CWrayHy5+0k80NmshEOJbVe4ltIar60dV0sahArVFrFbXLVIuUgC/uXy1JTHca47InPUuRO1n2M5j7oixlWFVePBwWPBkDEWlJmmU8Z4jiZCE3HHEJcSd9qS+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342672; c=relaxed/simple;
	bh=G9vi/uBbOI72OcQYHh5qlCzGWOHssI8eKKs/SaJCZV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdOwF/k2rEADUULirkJVOaT/9JPHHIaW+ACw1uVF5HiXrzkSb1cCAHa9W62/ZAQaQvI7LYfzihWcJ2u7UzCEuIqpoGH9JnJaxenqu+o/nqsfLDr8cLG/5UpOkRUmMyptMggPwoY7zncOPwaIqXhkXMD8nbCaFg0bC+pwvdZKs9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ClujitPX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342665;
	bh=G9vi/uBbOI72OcQYHh5qlCzGWOHssI8eKKs/SaJCZV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ClujitPXxLbHUO1PUByTCfoGFn89ghcIfl7WgXVeHvTyMsslCAB3WJQcUcn6skVoe
	 aWyjRJTSDWBCYmZ1gQWDz5lf4eCKtp43tx73dxKAFZmrSTSOuosRWQSwR8uv3IOdvW
	 OWmZG5qYcfV54ulpVhYOHnN8nAMH85/z+gUAxiqk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:55 +0000
Subject: [PATCH RFC 06/10] sysfs: treewide: constify attribute callback of
 bin_attribute::mmap()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-6-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=5001;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=G9vi/uBbOI72OcQYHh5qlCzGWOHssI8eKKs/SaJCZV8=;
 b=qPnmCoKo88DEseAckSWRQYFHJLv962m74QL1AL8t625CLvay8P8mf/TYeqw3KPxIDJZcuisEr
 zHVYKIrmsBWAlrEXkL3QSUjyOnHkQzgHw0jYXS0dRkwZF+0xVYPFNWE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The mmap() callbacks should not modify the struct
bin_attribute passed as argument.
Enforce this by marking the argument as const.

As there are not many callback implementers perform this change
throughout the tree at once.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/ocxl/sysfs.c              | 2 +-
 drivers/pci/p2pdma.c                   | 2 +-
 drivers/pci/pci-sysfs.c                | 6 +++---
 drivers/platform/x86/intel/pmt/class.c | 2 +-
 drivers/uio/uio_hv_generic.c           | 2 +-
 include/linux/sysfs.h                  | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index 405180d47d9bff0aaa7a736bb3fecfbe318db961..07520d6e6dc55702696b8656440914c379e6e27a 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -125,7 +125,7 @@ static const struct vm_operations_struct global_mmio_vmops = {
 };
 
 static int global_mmio_mmap(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr,
+			const struct bin_attribute *bin_attr,
 			struct vm_area_struct *vma)
 {
 	struct ocxl_afu *afu = to_afu(kobj_to_dev(kobj));
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500ff5339cde426b6ccb020fcd74ae7..7abd4f546d3c071f31e622d881f5c5ac3e4de55e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -90,7 +90,7 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(published);
 
 static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr, struct vm_area_struct *vma)
+		const struct bin_attribute *attr, struct vm_area_struct *vma)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	size_t len = vma->vm_end - vma->vm_start;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 13912940ed2bb66c0086e5bea9a3cb6417ac14dd..36017fd1d4235d0a42fa91b47a3c6de82d9af978 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1034,7 +1034,7 @@ void pci_remove_legacy_files(struct pci_bus *b)
  *
  * Use the regular PCI mapping routines to map a PCI resource into userspace.
  */
-static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
+static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *attr,
 			     struct vm_area_struct *vma, int write_combine)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
@@ -1059,14 +1059,14 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 }
 
 static int pci_mmap_resource_uc(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				const struct bin_attribute *attr,
 				struct vm_area_struct *vma)
 {
 	return pci_mmap_resource(kobj, attr, vma, 0);
 }
 
 static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *attr,
+				const struct bin_attribute *attr,
 				struct vm_area_struct *vma)
 {
 	return pci_mmap_resource(kobj, attr, vma, 1);
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index c04bb7f97a4db13268fc5697887951cf8f0f5a25..f9afa23e754b8b68bd59b72d6a72d26503a21f31 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -103,7 +103,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 
 static int
 intel_pmt_mmap(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr, struct vm_area_struct *vma)
+		const struct bin_attribute *attr, struct vm_area_struct *vma)
 {
 	struct intel_pmt_entry *entry = container_of(attr,
 						     struct intel_pmt_entry,
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 8704095994118c2660f345c504b5ea466d053efb..3976360d0096d6681faf88815cc6277fb76a1d9f 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -135,7 +135,7 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
  * The ring buffer is allocated as contiguous memory by vmbus_open
  */
 static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *attr,
+			    const struct bin_attribute *attr,
 			    struct vm_area_struct *vma)
 {
 	struct vmbus_channel *channel
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d1b22d56198b55ee39fe4c4fc994f5b753641992..9fcdc8cd3118f359742bfd8b708d5c3eff511042 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -309,7 +309,7 @@ struct bin_attribute {
 			 char *, loff_t, size_t);
 	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
 			 loff_t, int);
-	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
+	int (*mmap)(struct file *, struct kobject *, const struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
 };
 

-- 
2.47.0


