Return-Path: <linux-kernel+bounces-367823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1B59A0740
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC011C24BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0B208205;
	Wed, 16 Oct 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OawZXEiU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689D207A2C;
	Wed, 16 Oct 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074236; cv=none; b=gK0K1VyBsE2Xj9U4mP7PYRGvxyZS/PZ9ylNC53gB6bm7Nn7708NU1509B8PjPrihXYRJLwUgpUQCZTZPXHa1fhoS6sH4Zr+r7CjRPKV1rHWANtNNMk3l3qBzQH826kshaEElSmpgLJBQTpY/Cn7GFVDJ9+VYCAm44jxwYCPKQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074236; c=relaxed/simple;
	bh=w+/f4EEiwvS2DsYowjzczU9v3DyZ+l0kFaSro8GL824=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUBEQVzB9/wIlIt1f1OLWcN34U/fAJarhKGT91XQqrD5I2TJY99Y1TdMS+bCC5sCbid1TFmFRO4YuNuebVhR1myTxE3apJ/K68Ye9uMNF/bM6iP0xmhoougOxDgWn70nc8TrL32nJLe1X7yCg86RUBpAw/cFk6AMe0sqi6cvOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OawZXEiU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074235; x=1760610235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+/f4EEiwvS2DsYowjzczU9v3DyZ+l0kFaSro8GL824=;
  b=OawZXEiUJugM2sWzkf6IBgLnLfh0R6T+Kz8fhS2GGExEzRS5sSVSgV2f
   rWKIF9t7vLAojnlyZOJTuywgFgRifZt4HU1C4BkDKjNe2yzSy+yABto5B
   h88f+6ZnVwuu3xf0Oo3W+d0big1A7OZ0Su5b2Rp7qV64fzIl2xE3vh9SW
   pbCEnXf3NMRFmo2MP6GinxyU5wEydW63KHJA2GbJMCYzpooy5DK2XJxDh
   3Bdbi4yrSzsOaWxSjnAUA0yFIl2Ipat/Z8ecoCSqLQpIg6Pd1mlmkR297
   vx09mG9At2Sgf4pzx17IRIOtbJ4UkNmaY+tp62baWSUBPMUZqzypECa+C
   w==;
X-CSE-ConnectionGUID: L8ZMEuk0Ry+cVHUL7FwWLA==
X-CSE-MsgGUID: O2k3H/f0SSSrrcsQVbXodA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985873"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:54 -0700
X-CSE-ConnectionGUID: ELUNtIPNSOGobDxsLEcWdg==
X-CSE-MsgGUID: 097grx1TRv+h5MiJ6oCzFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960831"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:51 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 02/11] ASoC/soundwire: remove sdw_slave_extended_id
Date: Wed, 16 Oct 2024 18:23:24 +0800
Message-ID: <20241016102333.294448-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This structure is used to copy information from the 'sdw_slave'
structures, it's better to create a flexible array of 'sdw_slave'
pointers and directly access the information. This will also help
access additional information stored in the 'sdw_slave' structure,
such as an SDCA context.

This patch does not add new functionality, it only modified how the
information is retrieved.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/amd_init.c        | 12 ++++++------
 drivers/soundwire/intel_init.c      | 13 ++++++-------
 include/linux/soundwire/sdw.h       |  6 +++---
 include/linux/soundwire/sdw_amd.h   |  7 ++-----
 include/linux/soundwire/sdw_intel.h |  7 ++-----
 include/sound/soc-acpi.h            |  3 +--
 sound/soc/amd/ps/pci-ps.c           |  3 +--
 sound/soc/soc-acpi.c                | 30 +++++++++++++++--------------
 sound/soc/sof/amd/acp-common.c      |  3 +--
 sound/soc/sof/intel/hda.c           | 16 ++++++++-------
 10 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index db040f435059..53d1d707ca1a 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -177,7 +177,7 @@ EXPORT_SYMBOL_NS(sdw_amd_probe, SOUNDWIRE_AMD_INIT);
 void sdw_amd_exit(struct sdw_amd_ctx *ctx)
 {
 	sdw_amd_cleanup(ctx);
-	kfree(ctx->ids);
+	kfree(ctx->peripherals);
 	kfree(ctx);
 }
 EXPORT_SYMBOL_NS(sdw_amd_exit, SOUNDWIRE_AMD_INIT);
@@ -204,10 +204,11 @@ int sdw_amd_get_slave_info(struct sdw_amd_ctx *ctx)
 			num_slaves++;
 	}
 
-	ctx->ids = kcalloc(num_slaves, sizeof(*ctx->ids), GFP_KERNEL);
-	if (!ctx->ids)
+	ctx->peripherals = kmalloc(struct_size(ctx->peripherals, array, num_slaves),
+				   GFP_KERNEL);
+	if (!ctx->peripherals)
 		return -ENOMEM;
-	ctx->num_slaves = num_slaves;
+	ctx->peripherals->num_peripherals = num_slaves;
 	for (index = 0; index < ctx->count; index++) {
 		if (!(ctx->link_mask & BIT(index)))
 			continue;
@@ -215,8 +216,7 @@ int sdw_amd_get_slave_info(struct sdw_amd_ctx *ctx)
 		if (amd_manager) {
 			bus = &amd_manager->bus;
 			list_for_each_entry(slave, &bus->slaves, node) {
-				ctx->ids[i].id = slave->id;
-				ctx->ids[i].link_id = bus->link_id;
+				ctx->peripherals->array[i] = slave;
 				i++;
 			}
 		}
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index a09134b97cd6..12e7a98f319f 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -252,17 +252,16 @@ static struct sdw_intel_ctx
 			num_slaves++;
 	}
 
-	ctx->ids = kcalloc(num_slaves, sizeof(*ctx->ids), GFP_KERNEL);
-	if (!ctx->ids)
+	ctx->peripherals = kmalloc(struct_size(ctx->peripherals, array, num_slaves),
+				   GFP_KERNEL);
+	if (!ctx->peripherals)
 		goto err;
-
-	ctx->num_slaves = num_slaves;
+	ctx->peripherals->num_peripherals = num_slaves;
 	i = 0;
 	list_for_each_entry(link, &ctx->link_list, list) {
 		bus = &link->cdns->bus;
 		list_for_each_entry(slave, &bus->slaves, node) {
-			ctx->ids[i].id = slave->id;
-			ctx->ids[i].link_id = bus->link_id;
+			ctx->peripherals->array[i] = slave;
 			i++;
 		}
 	}
@@ -371,7 +370,7 @@ void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 	}
 
 	sdw_intel_cleanup(ctx);
-	kfree(ctx->ids);
+	kfree(ctx->peripherals);
 	kfree(ctx->ldev);
 	kfree(ctx);
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 5e0dd47a0412..283c8bfdde49 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -488,9 +488,9 @@ struct sdw_slave_id {
 	__u8 sdw_version:4;
 };
 
-struct sdw_extended_slave_id {
-	int link_id;
-	struct sdw_slave_id id;
+struct sdw_peripherals {
+	int num_peripherals;
+	struct sdw_slave *array[];
 };
 
 /*
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 28a4eb77717f..585b4c58a8a6 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -115,19 +115,16 @@ struct sdw_amd_acpi_info {
  * struct sdw_amd_ctx - context allocated by the controller driver probe
  *
  * @count: link count
- * @num_slaves: total number of devices exposed across all enabled links
  * @link_mask: bit-wise mask listing SoundWire links reported by the
  * Controller
- * @ids: array of slave_id, representing Slaves exposed across all enabled
- * links
  * @pdev: platform device structure
+ * @peripherals: array representing Peripherals exposed across all enabled links
  */
 struct sdw_amd_ctx {
 	int count;
-	int num_slaves;
 	u32 link_mask;
-	struct sdw_extended_slave_id *ids;
 	struct platform_device *pdev[AMD_SDW_MAX_MANAGER_COUNT];
+	struct sdw_peripherals *peripherals;
 };
 
 /**
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index fae345987b8c..491ddd27270f 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -287,31 +287,28 @@ struct hdac_bus;
  * hardware capabilities after all power dependencies are settled.
  * @link_mask: bit-wise mask listing SoundWire links reported by the
  * Controller
- * @num_slaves: total number of devices exposed across all enabled links
  * @handle: ACPI parent handle
  * @ldev: information for each link (controller-specific and kept
  * opaque here)
- * @ids: array of slave_id, representing Slaves exposed across all enabled
- * links
  * @link_list: list to handle interrupts across all links
  * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
  * @shim_mask: flags to track initialization of SHIM shared registers
  * @shim_base: sdw shim base.
  * @alh_base: sdw alh base.
+ * @peripherals: array representing Peripherals exposed across all enabled links
  */
 struct sdw_intel_ctx {
 	int count;
 	void __iomem *mmio_base;
 	u32 link_mask;
-	int num_slaves;
 	acpi_handle handle;
 	struct sdw_intel_link_dev **ldev;
-	struct sdw_extended_slave_id *ids;
 	struct list_head link_list;
 	struct mutex shim_lock; /* lock for access to shared SHIM registers */
 	u32 shim_mask;
 	u32 shim_base;
 	u32 alh_base;
+	struct sdw_peripherals *peripherals;
 };
 
 /**
diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 60d3b86a4660..ac7f9e791ee1 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -233,7 +233,6 @@ static inline bool snd_soc_acpi_sof_parent(struct device *dev)
 
 bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 					const struct snd_soc_acpi_link_adr *link,
-					struct sdw_extended_slave_id *ids,
-					int num_slaves);
+					struct sdw_peripherals *peripherals);
 
 #endif
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index c72d666d51bd..4365499c8f82 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -302,8 +302,7 @@ static struct snd_soc_acpi_mach *acp63_sdw_machine_select(struct device *dev)
 			link = mach->links;
 			for (i = 0; i < acp_data->info.count && link->num_adr; link++, i++) {
 				if (!snd_soc_acpi_sdw_link_slaves_found(dev, link,
-									acp_data->sdw->ids,
-									acp_data->sdw->num_slaves))
+									acp_data->sdw->peripherals))
 					break;
 			}
 			if (i == acp_data->info.count || !link->num_adr)
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 6d693b2ad5a3..270f9777942f 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -131,8 +131,7 @@ EXPORT_SYMBOL_GPL(snd_soc_acpi_codec_list);
 /* Check if all Slaves defined on the link can be found */
 bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 					const struct snd_soc_acpi_link_adr *link,
-					struct sdw_extended_slave_id *ids,
-					int num_slaves)
+					struct sdw_peripherals *peripherals)
 {
 	unsigned int part_id, link_id, unique_id, mfg_id, version;
 	int i, j, k;
@@ -146,22 +145,25 @@ bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 		link_id = SDW_DISCO_LINK_ID(adr);
 		version = SDW_VERSION(adr);
 
-		for (j = 0; j < num_slaves; j++) {
+		for (j = 0; j < peripherals->num_peripherals; j++) {
+			struct sdw_slave *peripheral = peripherals->array[j];
+
 			/* find out how many identical parts were reported on that link */
-			if (ids[j].link_id == link_id &&
-			    ids[j].id.part_id == part_id &&
-			    ids[j].id.mfg_id == mfg_id &&
-			    ids[j].id.sdw_version == version)
+			if (peripheral->bus->link_id == link_id &&
+			    peripheral->id.part_id == part_id &&
+			    peripheral->id.mfg_id == mfg_id &&
+			    peripheral->id.sdw_version == version)
 				reported_part_count++;
 		}
 
-		for (j = 0; j < num_slaves; j++) {
+		for (j = 0; j < peripherals->num_peripherals; j++) {
+			struct sdw_slave *peripheral = peripherals->array[j];
 			int expected_part_count = 0;
 
-			if (ids[j].link_id != link_id ||
-			    ids[j].id.part_id != part_id ||
-			    ids[j].id.mfg_id != mfg_id ||
-			    ids[j].id.sdw_version != version)
+			if (peripheral->bus->link_id != link_id ||
+			    peripheral->id.part_id != part_id ||
+			    peripheral->id.mfg_id != mfg_id ||
+			    peripheral->id.sdw_version != version)
 				continue;
 
 			/* find out how many identical parts are expected */
@@ -180,7 +182,7 @@ bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 				 */
 				unique_id = SDW_UNIQUE_ID(adr);
 				if (reported_part_count == 1 ||
-				    ids[j].id.unique_id == unique_id) {
+				    peripheral->id.unique_id == unique_id) {
 					dev_dbg(dev, "found part_id %#x at link %d\n", part_id, link_id);
 					break;
 				}
@@ -189,7 +191,7 @@ bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 					part_id, reported_part_count, expected_part_count, link_id);
 			}
 		}
-		if (j == num_slaves) {
+		if (j == peripherals->num_peripherals) {
 			dev_dbg(dev, "Slave part_id %#x not found\n", part_id);
 			return false;
 		}
diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index dbcaac84cb73..fc792956bb97 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -145,8 +145,7 @@ static struct snd_soc_acpi_mach *amd_sof_sdw_machine_select(struct snd_sof_dev *
 			link = mach->links;
 			for (i = 0; i < acp_data->info.count && link->num_adr; link++, i++) {
 				if (!snd_soc_acpi_sdw_link_slaves_found(sdev->dev, link,
-									acp_data->sdw->ids,
-									acp_data->sdw->num_slaves))
+									acp_data->sdw->peripherals))
 					break;
 			}
 			if (i == acp_data->info.count || !link->num_adr)
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e4cb4ffc7270..9abc4c071ae5 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1064,7 +1064,7 @@ static struct snd_soc_acpi_mach *hda_sdw_machine_select(struct snd_sof_dev *sdev
 {
 	struct snd_sof_pdata *pdata = sdev->pdata;
 	const struct snd_soc_acpi_link_adr *link;
-	struct sdw_extended_slave_id *ids;
+	struct sdw_peripherals *peripherals;
 	struct snd_soc_acpi_mach *mach;
 	struct sof_intel_hda_dev *hdev;
 	u32 link_mask;
@@ -1083,7 +1083,7 @@ static struct snd_soc_acpi_mach *hda_sdw_machine_select(struct snd_sof_dev *sdev
 		return NULL;
 	}
 
-	if (!hdev->sdw->num_slaves) {
+	if (!hdev->sdw->peripherals || !hdev->sdw->peripherals->num_peripherals) {
 		dev_warn(sdev->dev, "No SoundWire peripheral detected in ACPI tables\n");
 		return NULL;
 	}
@@ -1119,8 +1119,7 @@ static struct snd_soc_acpi_mach *hda_sdw_machine_select(struct snd_sof_dev *sdev
 			 * are not found on this link.
 			 */
 			if (!snd_soc_acpi_sdw_link_slaves_found(sdev->dev, link,
-								hdev->sdw->ids,
-								hdev->sdw->num_slaves))
+								hdev->sdw->peripherals))
 				break;
 		}
 		/* Found if all Slaves are checked */
@@ -1136,10 +1135,13 @@ static struct snd_soc_acpi_mach *hda_sdw_machine_select(struct snd_sof_dev *sdev
 	}
 
 	dev_info(sdev->dev, "No SoundWire machine driver found for the ACPI-reported configuration:\n");
-	ids = hdev->sdw->ids;
-	for (i = 0; i < hdev->sdw->num_slaves; i++)
+	peripherals = hdev->sdw->peripherals;
+	for (i = 0; i < peripherals->num_peripherals; i++)
 		dev_info(sdev->dev, "link %d mfg_id 0x%04x part_id 0x%04x version %#x\n",
-			 ids[i].link_id, ids[i].id.mfg_id, ids[i].id.part_id, ids[i].id.sdw_version);
+			 peripherals->array[i]->bus->link_id,
+			 peripherals->array[i]->id.mfg_id,
+			 peripherals->array[i]->id.part_id,
+			 peripherals->array[i]->id.sdw_version);
 
 	return NULL;
 }
-- 
2.43.0


