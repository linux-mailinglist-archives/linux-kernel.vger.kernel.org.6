Return-Path: <linux-kernel+bounces-540552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EFAA4B224
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03767A72D9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309F31E7C0B;
	Sun,  2 Mar 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7Q084e0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA81E8353
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740925254; cv=none; b=FuzOSb5MN92R6jELOQzfZ8gRYeAjLcET20ASpyt+RIp2t7DbGwDD6FfrbHkv0vEsf0ESKgneK464wJ+DbpTJ7/+JNHU+4xOtm+fFtIBzccI0AsI9wnfTxQsR6b0US8SmISBz92OL0pZZ6gclObxLHknS+0HuhwwYKsOYNElX2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740925254; c=relaxed/simple;
	bh=a0B7fMkJxt2Wb7bBeMVZwsKjEvvl5x89e9KqNreoDzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQZNoNNNY7Ersp4i8mTU94JscPknV/APCUvEWQk1BgiPxpTDo6/lF6B6TgMOVOHN3B0zQSvMZMaozuJBqWLpFlROOsHtAqkdeT9TnsRwdI43Rn407Y2DKhoNfEwsDPOVNiWy2b/DGSyc6K8OJf+CpRBV++tbnIsRymh9Yt57KtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7Q084e0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740925253; x=1772461253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0B7fMkJxt2Wb7bBeMVZwsKjEvvl5x89e9KqNreoDzc=;
  b=S7Q084e06shqX0UZypg3ArBt/6r9D/nzOpK97ieuIqAXhO73vebV38S0
   hsoBGujRXuOa/ko1Vn1TXwZaf0lT+uUnm8OBik1oMHBv6r8lB7xJakkTt
   oBWnyueOxTMTaqn76PoUvhATDgQ7KexTnB5IJ1wD+ylNEHD0PohoR48aB
   na8Ect2arfjLk899aIF8AjizN6VTB3xmG3U8nFtBw40GM3Yj7NIp8In8o
   cCkfSbh27fQibjkXLRv66Av8eLtpRo8BNnfZPpWdaWix6flJOQPvtpn3+
   SohhJH8zsFjWzXchTaFTb/T/OEccfY9AbhRGpyhChrnJSo9c/xg8rh71f
   Q==;
X-CSE-ConnectionGUID: 5T0Dv4BMQhW4iwlo6YyfFw==
X-CSE-MsgGUID: xDF+ejQ7TUqVdUDan7ds7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="67176396"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="67176396"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 06:20:53 -0800
X-CSE-ConnectionGUID: ILVEsQWeQn25tRMdsBkFmg==
X-CSE-MsgGUID: 57aHayV8TTW5QzjT45R12g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="122737313"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 06:20:46 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Karthik Poosa <karthik.poosa@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Oren Weil <oren.jer.weil@intel.com>,
	linux-mtd@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomasw@gmail.com>
Subject: [PATCH v6 03/11] mtd: intel-dg: implement region enumeration
Date: Sun,  2 Mar 2025 16:09:13 +0200
Message-ID: <20250302140921.504304-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302140921.504304-1-alexander.usyskin@intel.com>
References: <20250302140921.504304-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In intel-dg, there is no access to the spi controller,
the information is extracted from the descriptor region.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/devices/mtd_intel_dg.c | 198 +++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index 963a88cacc6c..ba1c720e717b 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -3,6 +3,8 @@
  * Copyright(c) 2019-2025, Intel Corporation. All rights reserved.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/intel_dg_nvm_aux.h>
 #include <linux/io.h>
@@ -22,9 +24,199 @@ struct intel_dg_nvm {
 		u8 id;
 		u64 offset;
 		u64 size;
+		unsigned int is_readable:1;
+		unsigned int is_writable:1;
 	} regions[] __counted_by(nregions);
 };
 
+#define NVM_TRIGGER_REG       0x00000000
+#define NVM_VALSIG_REG        0x00000010
+#define NVM_ADDRESS_REG       0x00000040
+#define NVM_REGION_ID_REG     0x00000044
+/*
+ * [15:0]-Erase size = 0x0010 4K 0x0080 32K 0x0100 64K
+ * [23:16]-Reserved
+ * [31:24]-Erase MEM RegionID
+ */
+#define NVM_ERASE_REG         0x00000048
+#define NVM_ACCESS_ERROR_REG  0x00000070
+#define NVM_ADDRESS_ERROR_REG 0x00000074
+
+/* Flash Valid Signature */
+#define NVM_FLVALSIG          0x0FF0A55A
+
+#define NVM_MAP_ADDR_MASK     GENMASK(7, 0)
+#define NVM_MAP_ADDR_SHIFT    0x00000004
+
+#define NVM_REGION_ID_DESCRIPTOR  0
+/* Flash Region Base Address */
+#define NVM_FRBA      0x40
+/* Flash Region __n - Flash Descriptor Record */
+#define NVM_FLREG(__n) (NVM_FRBA + ((__n) * 4))
+/*  Flash Map 1 Register */
+#define NVM_FLMAP1_REG  0x18
+#define NVM_FLMSTR4_OFFSET 0x00C
+
+#define NVM_ACCESS_ERROR_PCIE_MASK 0x7
+
+#define NVM_FREG_BASE_MASK GENMASK(15, 0)
+#define NVM_FREG_ADDR_MASK GENMASK(31, 16)
+#define NVM_FREG_ADDR_SHIFT 12
+#define NVM_FREG_MIN_REGION_SIZE 0xFFF
+
+static inline void idg_nvm_set_region_id(struct intel_dg_nvm *nvm, u8 region)
+{
+	iowrite32((u32)region, nvm->base + NVM_REGION_ID_REG);
+}
+
+static inline u32 idg_nvm_error(struct intel_dg_nvm *nvm)
+{
+	void __iomem *base = nvm->base;
+
+	u32 reg = ioread32(base + NVM_ACCESS_ERROR_REG) & NVM_ACCESS_ERROR_PCIE_MASK;
+
+	/* reset error bits */
+	if (reg)
+		iowrite32(reg, base + NVM_ACCESS_ERROR_REG);
+
+	return reg;
+}
+
+static inline u32 idg_nvm_read32(struct intel_dg_nvm *nvm, u32 address)
+{
+	void __iomem *base = nvm->base;
+
+	iowrite32(address, base + NVM_ADDRESS_REG);
+
+	return ioread32(base + NVM_TRIGGER_REG);
+}
+
+static int idg_nvm_get_access_map(struct intel_dg_nvm *nvm, u32 *access_map)
+{
+	u32 flmap1;
+	u32 fmba;
+	u32 fmstr4;
+	u32 fmstr4_addr;
+
+	idg_nvm_set_region_id(nvm, NVM_REGION_ID_DESCRIPTOR);
+
+	flmap1 = idg_nvm_read32(nvm, NVM_FLMAP1_REG);
+	if (idg_nvm_error(nvm))
+		return -EIO;
+	/* Get Flash Master Baser Address (FMBA) */
+	fmba = (FIELD_GET(NVM_MAP_ADDR_MASK, flmap1) << NVM_MAP_ADDR_SHIFT);
+	fmstr4_addr = fmba + NVM_FLMSTR4_OFFSET;
+
+	fmstr4 = idg_nvm_read32(nvm, fmstr4_addr);
+	if (idg_nvm_error(nvm))
+		return -EIO;
+
+	*access_map = fmstr4;
+	return 0;
+}
+
+static bool idg_nvm_region_readable(u32 access_map, u8 region)
+{
+	if (region < 12)
+		return access_map & BIT(region + 8); /* [19:8] */
+	else
+		return access_map & BIT(region - 12); /* [3:0] */
+}
+
+static bool idg_nvm_region_writable(u32 access_map, u8 region)
+{
+	if (region < 12)
+		return access_map & BIT(region + 20); /* [31:20] */
+	else
+		return access_map & BIT(region - 8); /* [7:4] */
+}
+
+static int idg_nvm_is_valid(struct intel_dg_nvm *nvm)
+{
+	u32 is_valid;
+
+	idg_nvm_set_region_id(nvm, NVM_REGION_ID_DESCRIPTOR);
+
+	is_valid = idg_nvm_read32(nvm, NVM_VALSIG_REG);
+	if (idg_nvm_error(nvm))
+		return -EIO;
+
+	if (is_valid != NVM_FLVALSIG)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device)
+{
+	int ret;
+	unsigned int i, n;
+	u32 access_map = 0;
+
+	/* clean error register, previous errors are ignored */
+	idg_nvm_error(nvm);
+
+	ret = idg_nvm_is_valid(nvm);
+	if (ret) {
+		dev_err(device, "The MEM is not valid %d\n", ret);
+		return ret;
+	}
+
+	if (idg_nvm_get_access_map(nvm, &access_map))
+		return -EIO;
+
+	for (i = 0, n = 0; i < nvm->nregions; i++) {
+		u32 address, base, limit, region;
+		u8 id = nvm->regions[i].id;
+
+		address = NVM_FLREG(id);
+		region = idg_nvm_read32(nvm, address);
+
+		base = FIELD_GET(NVM_FREG_BASE_MASK, region) << NVM_FREG_ADDR_SHIFT;
+		limit = (FIELD_GET(NVM_FREG_ADDR_MASK, region) << NVM_FREG_ADDR_SHIFT) |
+			NVM_FREG_MIN_REGION_SIZE;
+
+		dev_dbg(device, "[%d] %s: region: 0x%08X base: 0x%08x limit: 0x%08x\n",
+			id, nvm->regions[i].name, region, base, limit);
+
+		if (base >= limit || (i > 0 && limit == 0)) {
+			dev_dbg(device, "[%d] %s: disabled\n",
+				id, nvm->regions[i].name);
+			nvm->regions[i].is_readable = 0;
+			continue;
+		}
+
+		if (nvm->size < limit)
+			nvm->size = limit;
+
+		nvm->regions[i].offset = base;
+		nvm->regions[i].size = limit - base + 1;
+		/* No write access to descriptor; mask it out*/
+		nvm->regions[i].is_writable = idg_nvm_region_writable(access_map, id);
+
+		nvm->regions[i].is_readable = idg_nvm_region_readable(access_map, id);
+		dev_dbg(device, "Registered, %s id=%d offset=%lld size=%lld rd=%d wr=%d\n",
+			nvm->regions[i].name,
+			nvm->regions[i].id,
+			nvm->regions[i].offset,
+			nvm->regions[i].size,
+			nvm->regions[i].is_readable,
+			nvm->regions[i].is_writable);
+
+		if (nvm->regions[i].is_readable)
+			n++;
+	}
+
+	dev_dbg(device, "Registered %d regions\n", n);
+
+	/* Need to add 1 to the amount of memory
+	 * so it is reported as an even block
+	 */
+	nvm->size += 1;
+
+	return n;
+}
+
 static void intel_dg_nvm_release(struct kref *kref)
 {
 	struct intel_dg_nvm *nvm = container_of(kref, struct intel_dg_nvm, refcnt);
@@ -88,6 +280,12 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 		goto err;
 	}
 
+	ret = intel_dg_nvm_init(nvm, device);
+	if (ret < 0) {
+		dev_err(device, "cannot initialize nvm %d\n", ret);
+		goto err;
+	}
+
 	dev_set_drvdata(&aux_dev->dev, nvm);
 
 	return 0;
-- 
2.43.0


