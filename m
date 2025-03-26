Return-Path: <linux-kernel+bounces-577279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B25A71ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FA8168082
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7D1F874F;
	Wed, 26 Mar 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bd0Ufp8t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA41F2369
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003479; cv=none; b=VVRNIUT4tRG0xvq5DWIBy47xVK/o6YM/1T6n47GpkBQVusRtIKvjHSUkdj8TnqFTRaTC4T80WO8GL61QTUjNlDWkhLtkN7eRWY8GbOv6R2hy2oWpOoRP/zDXfDubJiY3wLbOOYLo3eLhVnLQCo7dSGw/Jj7ocO4KmU5E/d+TGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003479; c=relaxed/simple;
	bh=nfNlQaQAx8Vv722WAjFHHGbTA8WrwldfoILRmHYeMfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L78HbjEYnx0abQ/JlJFb5Kc4H8rs5cjHfzOMnLspxcm/3e12ftKMaEXt7U/YtGsGekRS3Ual0BzXIjxHU+014EntAXXXNsx88QfQeUGaMX8oIxLoZie60GgsRZPinkaJcNDghA2jKHfljbjrKeYICotzdI1djry2ZpagEX3zb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bd0Ufp8t; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743003478; x=1774539478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nfNlQaQAx8Vv722WAjFHHGbTA8WrwldfoILRmHYeMfU=;
  b=bd0Ufp8tdExICccpJuiRAIC5k1WcUzEzh29Xxzuyge2xguh4tTIPOV/3
   zuTwoUFwGySdKmEdJlGwPB/r1PGpcC/LdnGu9AersCJAvQWVfXlBOfGWv
   yfeWPwZV1RUBBJzsCxTWEJuTETaFWlbAwAQ+ZiSfv7nUVvNZbdtlFPyeX
   4NBpJ4Hh4xTFBwoo6YKen0uiFGTpxeilFThQTmqby138cieW+LmerfZ15
   /BWumERCI/QBsgD8jOUul8O0lfqzdWM135ZMF2D+SKQzcxP0KS8PCHMU9
   /wzxytaPrWgbzTH0dkMvac2SX7/emvV4KLPpE3pMnOxQADJw95S/waU5u
   A==;
X-CSE-ConnectionGUID: VHHd3EWgQb+U6FhjcuPQFQ==
X-CSE-MsgGUID: pIXoaKFAQ+SuRq8F1rKcxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55665534"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="55665534"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:37:57 -0700
X-CSE-ConnectionGUID: REDmp821SCi1Z+b85XrWcA==
X-CSE-MsgGUID: fcn0x/bnTryeQJbGtQiqTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129923517"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:37:51 -0700
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
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v7 07/12] mtd: intel-dg: wake card on operations
Date: Wed, 26 Mar 2025 17:26:18 +0200
Message-ID: <20250326152623.3897204-8-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326152623.3897204-1-alexander.usyskin@intel.com>
References: <20250326152623.3897204-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable runtime PM in mtd driver to notify graphics driver that
whole card should be kept awake while nvm operations are
performed through this driver.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Karthik Poosa <karthik.poosa@intel.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/devices/mtd_intel_dg.c | 79 +++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index 3535f7b64429..9f4bb15a03b8 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -15,11 +15,14 @@
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/pm_runtime.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 
+#define INTEL_DG_NVM_RPM_TIMEOUT 500
+
 struct intel_dg_nvm {
 	struct kref refcnt;
 	struct mtd_info mtd;
@@ -460,6 +463,7 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 	loff_t from;
 	size_t len;
 	size_t total_len;
+	int ret = 0;
 
 	if (WARN_ON(!nvm))
 		return -EINVAL;
@@ -474,20 +478,28 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 	total_len = info->len;
 	addr = info->addr;
 
+	ret = pm_runtime_resume_and_get(&mtd->dev);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %d\n", ret);
+		return ret;
+	}
+
 	guard(mutex)(&nvm->lock);
 
 	while (total_len > 0) {
 		if (!IS_ALIGNED(addr, SZ_4K) || !IS_ALIGNED(total_len, SZ_4K)) {
 			dev_err(&mtd->dev, "unaligned erase %llx %zx\n", addr, total_len);
 			info->fail_addr = addr;
-			return -ERANGE;
+			ret = -ERANGE;
+			goto out;
 		}
 
 		idx = idg_nvm_get_region(nvm, addr);
 		if (idx >= nvm->nregions) {
 			dev_err(&mtd->dev, "out of range");
 			info->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
-			return -ERANGE;
+			ret = -ERANGE;
+			goto out;
 		}
 
 		from = addr - nvm->regions[idx].offset;
@@ -503,14 +515,18 @@ static int intel_dg_mtd_erase(struct mtd_info *mtd, struct erase_info *info)
 		if (bytes < 0) {
 			dev_dbg(&mtd->dev, "erase failed with %zd\n", bytes);
 			info->fail_addr += nvm->regions[idx].offset;
-			return bytes;
+			ret = bytes;
+			goto out;
 		}
 
 		addr += len;
 		total_len -= len;
 	}
 
-	return 0;
+out:
+	pm_runtime_mark_last_busy(&mtd->dev);
+	pm_runtime_put_autosuspend(&mtd->dev);
+	return ret;
 }
 
 static int intel_dg_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
@@ -539,17 +555,25 @@ static int intel_dg_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (len > nvm->regions[idx].size - from)
 		len = nvm->regions[idx].size - from;
 
+	ret = pm_runtime_resume_and_get(&mtd->dev);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	guard(mutex)(&nvm->lock);
 
 	ret = idg_read(nvm, region, from, len, buf);
 	if (ret < 0) {
 		dev_dbg(&mtd->dev, "read failed with %zd\n", ret);
-		return ret;
+	} else {
+		*retlen = ret;
+		ret = 0;
 	}
 
-	*retlen = ret;
-
-	return 0;
+	pm_runtime_mark_last_busy(&mtd->dev);
+	pm_runtime_put_autosuspend(&mtd->dev);
+	return ret;
 }
 
 static int intel_dg_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
@@ -578,17 +602,25 @@ static int intel_dg_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (len > nvm->regions[idx].size - to)
 		len = nvm->regions[idx].size - to;
 
+	ret = pm_runtime_resume_and_get(&mtd->dev);
+	if (ret < 0) {
+		dev_err(&mtd->dev, "rpm: get failed %zd\n", ret);
+		return ret;
+	}
+
 	guard(mutex)(&nvm->lock);
 
 	ret = idg_write(nvm, region, to, len, buf);
 	if (ret < 0) {
 		dev_dbg(&mtd->dev, "write failed with %zd\n", ret);
-		return ret;
+	} else {
+		*retlen = ret;
+		ret = 0;
 	}
 
-	*retlen = ret;
-
-	return 0;
+	pm_runtime_mark_last_busy(&mtd->dev);
+	pm_runtime_put_autosuspend(&mtd->dev);
+	return ret;
 }
 
 static void intel_dg_nvm_release(struct kref *kref)
@@ -670,6 +702,15 @@ static int intel_dg_nvm_init_mtd(struct intel_dg_nvm *nvm, struct device *device
 
 	kfree(parts);
 
+	if (ret)
+		goto out;
+
+	devm_pm_runtime_enable(&nvm->mtd.dev);
+
+	pm_runtime_set_autosuspend_delay(&nvm->mtd.dev, INTEL_DG_NVM_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(&nvm->mtd.dev);
+
+out:
 	return ret;
 }
 
@@ -719,6 +760,17 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 	}
 	nvm->nregions = n; /* in case where kasprintf fail */
 
+	devm_pm_runtime_enable(device);
+
+	pm_runtime_set_autosuspend_delay(device, INTEL_DG_NVM_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(device);
+
+	ret = pm_runtime_resume_and_get(device);
+	if (ret < 0) {
+		dev_err(device, "rpm: get failed %d\n", ret);
+		goto err_norpm;
+	}
+
 	nvm->base = devm_ioremap_resource(device, &invm->bar);
 	if (IS_ERR(nvm->base)) {
 		dev_err(device, "mmio not mapped\n");
@@ -740,9 +792,12 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
 	dev_set_drvdata(&aux_dev->dev, nvm);
 
+	pm_runtime_put(device);
 	return 0;
 
 err:
+	pm_runtime_put(device);
+err_norpm:
 	kref_put(&nvm->refcnt, intel_dg_nvm_release);
 	return ret;
 }
-- 
2.43.0


