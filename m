Return-Path: <linux-kernel+bounces-376127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C6D9AA07B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038F728399B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2F19B5B4;
	Tue, 22 Oct 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ghs/wtab"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E0199EA2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594435; cv=none; b=SZSVYS580pip1YuGw0UF8OEiqF5FJeqDkRz+L4gr2yjHSBq0h9j6Ti5iI99sZg7ocZy5ac+zEUs7F7WgNWRmdXy536HTFOIqRH2YBy0FEL85NFccv7up83h5EFCsMclEMx2/XDrPnli0IyjzqQELDuxYarN+tHwCaU1hWsk/0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594435; c=relaxed/simple;
	bh=kxRm/gIWV9t8+mhBKVrkdxXSfSLyFC00LqaghTUcp1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3usf+J2JGLwk/69WxKVSksvHGSxnjBKEbWfjDccQijIyfb4o6IH3uJGnd0nsLl/NPTNlVIs2AV0LKHU4JxExjbDncOVV1/JDndiDpEzuvnpKX1Z4Fe5WFJ28bgiz6hzwiGuJ0S0yLaWGgHCiPu2ScElyUMA84/VJ/BtmanLVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ghs/wtab; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729594434; x=1761130434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxRm/gIWV9t8+mhBKVrkdxXSfSLyFC00LqaghTUcp1k=;
  b=Ghs/wtabl97sQ/o65sy0IiSu/rC0bfbVrT+PoYy59g0AnpC+w5TggNV2
   1KwFYy7hQaCsDiF1Z4EeKBCc3tOPdBowrH6ektJ4jS42JlejOPESnsmJ/
   wHxKTnOLQQhaZGPefY/0+mvzPwajNWfwPhrbXGBGlaKkamSXCbhKXSZ5e
   6VE3Czg7B8VsVUw4SKDGWnaPWoOGKWEKpd4rj/NzUY+A0Yk5c6Ul+dUak
   +s/MV2huV/ZNM7/lUp8SM3lfHIm4V1bDcJUcojh2Na5JjSsdyXYB+N8YQ
   CqgKgngxJnJ7SqUG9ui1OAA+IfsCALQgAeurf222FTYCWbMc0C+1nFjey
   Q==;
X-CSE-ConnectionGUID: YTLoJUoQSESYLRTI+P62Og==
X-CSE-MsgGUID: vn2eBFsnRdyWSrhNyJtgTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39704978"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="39704978"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP; 22 Oct 2024 03:53:41 -0700
X-CSE-ConnectionGUID: 2lhHKdamTIWdpViQnlu/pA==
X-CSE-MsgGUID: bfY8UXGTQo2gFVlFhPRXrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79847596"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 03:53:16 -0700
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
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Oren Weil <oren.jer.weil@intel.com>,
	linux-mtd@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomasw@gmail.com>
Subject: [PATCH 02/10] mtd: intel-dg: implement region enumeration
Date: Tue, 22 Oct 2024 13:41:11 +0300
Message-ID: <20241022104119.3149051-3-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022104119.3149051-1-alexander.usyskin@intel.com>
References: <20241022104119.3149051-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In intel-dg, there is no access to the spi controller,
the information is extracted from the descriptor region.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/devices/mtd-intel-dg.c | 199 +++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/mtd/devices/mtd-intel-dg.c b/drivers/mtd/devices/mtd-intel-dg.c
index 746c963ea540..05e333771be0 100644
--- a/drivers/mtd/devices/mtd-intel-dg.c
+++ b/drivers/mtd/devices/mtd-intel-dg.c
@@ -3,6 +3,8 @@
  * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
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
 	} regions[];
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
+static bool idg_nvm_region_writeable(u32 access_map, u8 region)
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
+		nvm->regions[i].is_writable = idg_nvm_region_writeable(access_map, id);
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
@@ -89,6 +281,13 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 		goto err;
 	}
 
+	ret = intel_dg_nvm_init(nvm, device);
+	if (ret < 0) {
+		dev_err(device, "cannot initialize nvm\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
 	dev_set_drvdata(&aux_dev->dev, nvm);
 
 	return 0;
-- 
2.43.0


