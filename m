Return-Path: <linux-kernel+bounces-389895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6B9B729C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675671C224C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E913AD32;
	Thu, 31 Oct 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="R8mMj1ng"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951A10A3E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342670; cv=none; b=GKkqLdR0BR4gZgdOTdJiJV2QVRODRZHiLy8MxNfehlzNpPB4ZDA5+KPXCw+3jTv4U0OZPC62ZtJ2QmI0TsrnlQd39CfUKEhxToHyelNWWRGCgz5l8byEqKAhg0yW9DR96MUbX8FaWV3VPUt6h91z0xVnGErjWvPFcV18IagV6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342670; c=relaxed/simple;
	bh=p7EKoDjpwnqyDMvTqsimORFFg1riJU8XKmsg0+Giqpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kn8Pmnu7OG7977wI74X4P/cRiOEw2Zar9KTdf/PKuYEuHTrvSplkqLujxWUBjKUOZ4km60FDEDYglsd/SIgzZq/ipyHnmJT5wgMXOAJdGwfhaamND4scnQNeSb7RS2iZyoGnoURohwD7xPfmIEloiMrqI15gbih88URMCW6U/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=R8mMj1ng; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342665;
	bh=p7EKoDjpwnqyDMvTqsimORFFg1riJU8XKmsg0+Giqpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R8mMj1ngxhvqUAuT5ez/2BOsCNA8Az14hAqtgE4NzRPx2ZHJPXOh9uU2j2MxhCvi1
	 1C5dVjyxe1AZYyjSjQlrZ6WdxW5MXweoUIjcLgTLYFSNHiTD6n2r1Iiy/853ugAuHw
	 rpciPOr3CRvD8ZO7WZZsfzIS1KTUg6KonTc+x+g4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 31 Oct 2024 02:43:54 +0000
Subject: [PATCH RFC 05/10] sysfs: treewide: constify attribute callback of
 bin_is_visible()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-sysfs-const-bin_attr-v1-5-2281afa7f055@weissschuh.net>
References: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
In-Reply-To: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=10037;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=p7EKoDjpwnqyDMvTqsimORFFg1riJU8XKmsg0+Giqpo=;
 b=BMpqyoXfTRVDZbZQc+boC7moxXAfgSr/uUDETPcmrPqFq9/LRUZcABjh/lhqXnDrm8onN7ndP
 mFFuNE+Nq5sApT70sUR50a52CGZd79d9DvymWDGkO8EoVLmvouuf0oO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The is_bin_visible() callbacks should not modify the struct
bin_attribute passed as argument.
Enforce this by marking the argument as const.

As there are not many callback implementers perform this change
throughout the tree at once.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/cxl/port.c                      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 +-
 drivers/infiniband/hw/qib/qib_sysfs.c   |  2 +-
 drivers/mtd/spi-nor/sysfs.c             |  2 +-
 drivers/nvmem/core.c                    |  3 ++-
 drivers/pci/pci-sysfs.c                 |  2 +-
 drivers/pci/vpd.c                       |  2 +-
 drivers/platform/x86/amd/hsmp.c         |  2 +-
 drivers/platform/x86/intel/sdsi.c       |  2 +-
 drivers/scsi/scsi_sysfs.c               |  2 +-
 drivers/usb/core/sysfs.c                |  2 +-
 include/linux/sysfs.h                   | 30 +++++++++++++++---------------
 12 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 861dde65768fe383d3ccbb49ffd31fb29aeb42e9..ed78043ec13a6f6db5f077a5679e0342ce7f7eff 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -173,7 +173,7 @@ static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
 static BIN_ATTR_ADMIN_RO(CDAT, 0);
 
 static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
-					    struct bin_attribute *attr, int i)
+					    const struct bin_attribute *attr, int i)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_port *port = to_cxl_port(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b28b2cf1517d130da01989df70b9dff6433edc4..c1c329eb920b52af100a93bdf00df450e25608c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3999,7 +3999,7 @@ static umode_t amdgpu_flash_attr_is_visible(struct kobject *kobj, struct attribu
 }
 
 static umode_t amdgpu_bin_flash_attr_is_visible(struct kobject *kobj,
-						struct bin_attribute *attr,
+						const struct bin_attribute *attr,
 						int idx)
 {
 	struct device *dev = kobj_to_dev(kobj);
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 53ec7510e4ebfb144e79884ca7dd7d0c873bd8a7..ba2cd68b53e6c240f1afc65c64012c75ccf488e0 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -283,7 +283,7 @@ static struct bin_attribute *port_ccmgta_attributes[] = {
 };
 
 static umode_t qib_ccmgta_is_bin_visible(struct kobject *kobj,
-				 struct bin_attribute *attr, int n)
+				 const struct bin_attribute *attr, int n)
 {
 	struct qib_pportdata *ppd = qib_get_pportdata_kobj(kobj);
 
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 96064e4babf01f6950c81586764386e7671cbf97..5e9eb268073d18e0a46089000f18a3200b4bf13d 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -87,7 +87,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
 }
 
 static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
-					    struct bin_attribute *attr, int n)
+					    const struct bin_attribute *attr, int n)
 {
 	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
 	struct spi_mem *spimem = spi_get_drvdata(spi);
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 63370c76394ee9b8d514da074779617cef67c311..73e44d724f90f4cd8fe8cafb9fa0c0fb23078e61 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -298,7 +298,8 @@ static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
 }
 
 static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
-					 struct bin_attribute *attr, int i)
+					 const struct bin_attribute *attr,
+					 int i)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 040f01b2b999175e8d98b05851edc078bbabbe0d..13912940ed2bb66c0086e5bea9a3cb6417ac14dd 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1326,7 +1326,7 @@ static struct bin_attribute *pci_dev_rom_attrs[] = {
 };
 
 static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
-					   struct bin_attribute *a, int n)
+					   const struct bin_attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index e4300f5f304f3ca55a657fd25a1fa5ed919737a7..a469bcbc0da7f7677485c7f999f8dfb58b8ae8a3 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -325,7 +325,7 @@ static struct bin_attribute *vpd_attrs[] = {
 };
 
 static umode_t vpd_attr_is_visible(struct kobject *kobj,
-				   struct bin_attribute *a, int n)
+				   const struct bin_attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 8fcf38eed7f00ee01aade6e3e55e20402458d5aa..8f00850c139fa8d419bc1c140c1832bf84b2c3bd 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -620,7 +620,7 @@ static int hsmp_get_tbl_dram_base(u16 sock_ind)
 }
 
 static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
-					 struct bin_attribute *battr, int id)
+					 const struct bin_attribute *battr, int id)
 {
 	if (plat_dev.proto_ver == HSMP_PROTO_VER6)
 		return battr->attr.mode;
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 9d137621f0e6e7a23be0e0bbc6175c51c403169f..33f33b1070fdc949c1373251c3bca4234d9da119 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -541,7 +541,7 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
 };
 
 static umode_t
-sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
+sdsi_battr_is_visible(struct kobject *kobj, const struct bin_attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 32f94db6d6bf5d2bd289c1a121da7ffc6a7cb2ff..f3a1ecb42128a2b221ca5c362e041eb59dba0f20 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1274,7 +1274,7 @@ static umode_t scsi_sdev_attr_is_visible(struct kobject *kobj,
 }
 
 static umode_t scsi_sdev_bin_attr_is_visible(struct kobject *kobj,
-					     struct bin_attribute *attr, int i)
+					     const struct bin_attribute *attr, int i)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct scsi_device *sdev = to_scsi_device(dev);
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 61b6d978892c799e213018bed22d9fb12a19d429..b4cba23831acd2d7d395b9f7683cd3ee3a8623c8 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -925,7 +925,7 @@ static struct bin_attribute *dev_bin_attrs[] = {
 };
 
 static umode_t dev_bin_attrs_are_visible(struct kobject *kobj,
-		struct bin_attribute *a, int n)
+		const struct bin_attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct usb_device *udev = to_usb_device(dev);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 4746cccb95898b24df6f53de9421ea7649b5568f..d1b22d56198b55ee39fe4c4fc994f5b753641992 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -101,7 +101,7 @@ struct attribute_group {
 	umode_t			(*is_visible)(struct kobject *,
 					      struct attribute *, int);
 	umode_t			(*is_bin_visible)(struct kobject *,
-						  struct bin_attribute *, int);
+						  const struct bin_attribute *, int);
 	size_t			(*bin_size)(struct kobject *,
 					    const struct bin_attribute *,
 					    int);
@@ -199,22 +199,22 @@ struct attribute_group {
  * attributes, the group visibility is determined by the function
  * specified to is_visible() not is_bin_visible()
  */
-#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                             \
-	static inline umode_t sysfs_group_visible_##name(                \
-		struct kobject *kobj, struct bin_attribute *attr, int n) \
-	{                                                                \
-		if (n == 0 && !name##_group_visible(kobj))               \
-			return SYSFS_GROUP_INVISIBLE;                    \
-		return name##_attr_visible(kobj, attr, n);               \
+#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                                   \
+	static inline umode_t sysfs_group_visible_##name(                      \
+		struct kobject *kobj, const struct bin_attribute *attr, int n) \
+	{                                                                      \
+		if (n == 0 && !name##_group_visible(kobj))                     \
+			return SYSFS_GROUP_INVISIBLE;                          \
+		return name##_attr_visible(kobj, attr, n);                     \
 	}
 
-#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name)                   \
-	static inline umode_t sysfs_group_visible_##name(             \
-		struct kobject *kobj, struct bin_attribute *a, int n) \
-	{                                                             \
-		if (n == 0 && !name##_group_visible(kobj))            \
-			return SYSFS_GROUP_INVISIBLE;                 \
-		return a->mode;                                       \
+#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name)                         \
+	static inline umode_t sysfs_group_visible_##name(                   \
+		struct kobject *kobj, const struct bin_attribute *a, int n) \
+	{                                                                   \
+		if (n == 0 && !name##_group_visible(kobj))                  \
+			return SYSFS_GROUP_INVISIBLE;                       \
+		return a->mode;                                             \
 	}
 
 #define SYSFS_GROUP_VISIBLE(fn) sysfs_group_visible_##fn

-- 
2.47.0


