Return-Path: <linux-kernel+bounces-525072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B85A3EA72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2191B3BF758
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A081A1D5AA7;
	Fri, 21 Feb 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PhksQYxB"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6870807;
	Fri, 21 Feb 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103136; cv=none; b=JRkvdzo9xe6HuOa/XQ3u8suHhbGrosOKyA/mTS8xTkMlF6OnQN6IiOylOqMHg2pLiKfKvrSL1tUR37QdzuHNsE6EL7Sb8VXhQF5lDuIDNtjR9zGTNi/DoyukKUJIzhy/JHCgZ3DwQYRihIG+NHJ7tfu/V/eNE/+xrrG9hacPbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103136; c=relaxed/simple;
	bh=KQSEupzzv6FPsVNyc/MIA29eHFqeVcEBGogw4XihUo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwLcfpS5S5+BcRojM/5hUayS6DwBbSDvyypNIpnPRI6qaB2APzKTjql0AKzGGj6tHZHfdiO5EYE5YGE62s3adqOxDAjX7bdgeGou/ISN5T7JqaqhyMKSaEnyohL3XHlrOT/R+l2XETmUy0U6+qNmIUoDssGqxbGcjue/nJO8glk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PhksQYxB; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=98PWmAb5l+OV6NfWNcp7ThHQ0YLhVqOeKE7dZBjUfng=; b=PhksQYxB/BTzKZvb
	200VsqPuyCa7g9z28SvlqUS0T1bW0Jq7dtTRD6A5JlfadZovTyzNcD3wJOQ2eVlpoX4/kNjTjwldy
	gQBfTo8Ad1eFNKUf9d9I24f2unV28bjwipcVZ6e3ihnL64tBphgiD7Twhu2l5ST3aSej/8J/6x4dc
	5ot5XqdMIXnpFUgP15t0eawsWU8bxgwMEnAqVVWN4LtGLeOChN1d/6bqciVxdZ4IAXRgFBaBVNDud
	aE9HvSoYVlN2SHaxhvfOFeFR95BnBoUG/8bFYoXNsaAb1GccP+/zBXSTUZ53yhd7XXYVZ+n28opDK
	NRet26ryZEAvFlqNDA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tlIJP-00HM47-36;
	Fri, 21 Feb 2025 01:58:44 +0000
From: linux@treblig.org
To: srinivas.kandagatla@linaro.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] nvmem: core: Remove remains of nvmem_cell_table
Date: Fri, 21 Feb 2025 01:58:41 +0000
Message-ID: <20250221015841.209458-4-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221015841.209458-1-linux@treblig.org>
References: <20250221015841.209458-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

With the previous patch removing the unused nvmem_add_cell_table, there's
no way to add a table, and thus the rest of the table infrastructure
can go.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/driver-api/nvmem.rst | 17 ------------
 drivers/nvmem/core.c               | 42 ------------------------------
 include/linux/nvmem-provider.h     | 19 --------------
 3 files changed, 78 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 27534d5e8fba..6e73bb2d2ca5 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -59,23 +59,6 @@ For example, a simple nvram case::
 	devm_nvmem_register(&config);
   }
 
-Users of board files can define and register nvmem cells using the
-nvmem_cell_table struct::
-
-  static struct nvmem_cell_info foo_nvmem_cells[] = {
-	{
-		.name		= "macaddr",
-		.offset		= 0x7f00,
-		.bytes		= ETH_ALEN,
-	}
-  };
-
-  static struct nvmem_cell_table foo_nvmem_cell_table = {
-	.nvmem_name		= "i2c-eeprom",
-	.cells			= foo_nvmem_cells,
-	.ncells			= ARRAY_SIZE(foo_nvmem_cells),
-  };
-
 Additionally it is possible to create nvmem cell lookup entries and register
 them with the nvmem framework from machine code as shown in the example below::
 
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 90fbfc00950e..6f7f2a84701f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -47,9 +47,6 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
-static DEFINE_MUTEX(nvmem_cell_mutex);
-static LIST_HEAD(nvmem_cell_tables);
-
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 static LIST_HEAD(nvmem_lookup_list);
 
@@ -705,41 +702,6 @@ int nvmem_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
 
-static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
-{
-	const struct nvmem_cell_info *info;
-	struct nvmem_cell_table *table;
-	struct nvmem_cell_entry *cell;
-	int rval = 0, i;
-
-	mutex_lock(&nvmem_cell_mutex);
-	list_for_each_entry(table, &nvmem_cell_tables, node) {
-		if (strcmp(nvmem_dev_name(nvmem), table->nvmem_name) == 0) {
-			for (i = 0; i < table->ncells; i++) {
-				info = &table->cells[i];
-
-				cell = kzalloc(sizeof(*cell), GFP_KERNEL);
-				if (!cell) {
-					rval = -ENOMEM;
-					goto out;
-				}
-
-				rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, info, cell);
-				if (rval) {
-					kfree(cell);
-					goto out;
-				}
-
-				nvmem_cell_entry_add(cell);
-			}
-		}
-	}
-
-out:
-	mutex_unlock(&nvmem_cell_mutex);
-	return rval;
-}
-
 static struct nvmem_cell_entry *
 nvmem_find_cell_entry_by_name(struct nvmem_device *nvmem, const char *cell_id)
 {
@@ -1024,10 +986,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_remove_cells;
 	}
 
-	rval = nvmem_add_cells_from_table(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	if (config->add_legacy_fixed_of_cells) {
 		rval = nvmem_add_cells_from_legacy_of(nvmem);
 		if (rval)
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 20c9fbd45b24..615a560d9edb 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -137,25 +137,6 @@ struct nvmem_config {
 	struct device		*base_dev;
 };
 
-/**
- * struct nvmem_cell_table - NVMEM cell definitions for given provider
- *
- * @nvmem_name:		Provider name.
- * @cells:		Array of cell definitions.
- * @ncells:		Number of cell definitions in the array.
- * @node:		List node.
- *
- * This structure together with related helper functions is provided for users
- * that don't can't access the nvmem provided structure but wish to register
- * cell definitions for it e.g. board files registering an EEPROM device.
- */
-struct nvmem_cell_table {
-	const char		*nvmem_name;
-	const struct nvmem_cell_info	*cells;
-	size_t			ncells;
-	struct list_head	node;
-};
-
 /**
  * struct nvmem_layout - NVMEM layout definitions
  *
-- 
2.48.1


