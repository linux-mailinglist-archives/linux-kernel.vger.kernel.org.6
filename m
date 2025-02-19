Return-Path: <linux-kernel+bounces-520866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E9A3B03A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65CB17A5E75
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFCA1A317F;
	Wed, 19 Feb 2025 04:01:29 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF19C3FD4;
	Wed, 19 Feb 2025 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937688; cv=none; b=STWhqBVRX4TlNnT1dFsfthO4iQuDjNsWv1r/dk+BuN792ampSJdimX2mrIZtKTVJU8g/QnhGMp4ZIaJ+e0TG9TWfCjMquMS6tNYJILRMWGqFwwwGGrykIm7+h5XwoyNfoGZWUfHGfyi6e4v/7HWnJVygw8uKaq2rsQ1d4dBRGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937688; c=relaxed/simple;
	bh=SkUXG0yngRNLFHVrTZubLG5b4GdicoMIi2rSucfNbD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mr1+lKou1kxDYjSQPK56AX8rwA3OFIl3SU+63+DQEod8EbWUiHQWP/U+Vs/EOqhDQE+ooCd4CpPgMfa18L1n5IwY4A+Omzcv+n8M3vvPnvVyEBg2dJ0YPmdyFM/KG++iiIAnHQdlpP0eNkxrxR1QRBsiDsH43aKWqgdLO9sHnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHJ7yFV7VnreLgAw--.39578S2;
	Wed, 19 Feb 2025 12:01:09 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCHjYl4V7VnvbsrAA--.18029S4;
	Wed, 19 Feb 2025 12:01:08 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v5 1/1] cxl/pmem: debug invalid serial number data
Date: Wed, 19 Feb 2025 12:00:29 +0800
Message-Id: <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219040029.515451-1-wangyuquan1236@phytium.com.cn>
References: <20250219040029.515451-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCHjYl4V7VnvbsrAA--.18029S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWe0524BYgAAs-
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tryfXF4rJr47GrWxJF1xGrg_yoW8uF1rpr
	48tayY9rW3AF13Zw4xZa48XFyFg3Z7G3y8Cryqqw1Y9rn5tFn2qF4xJa1jya4fCa95tw4a
	9a4j9FyUur4DJ3DanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

In a nvdimm interleave-set each device with an invalid or zero
serial number may cause pmem region initialization to fail, but in
cxl case such device could still set cookies of nd_interleave_set
and create a nvdimm pmem region.

This adds the validation of serial number in cxl pmem region creation.
The event of no serial number would cause to fail to set the cookie
and pmem region.

For cxl-test to work properly, always +1 on mock device's serial
number.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/cxl/pmem.c           | 12 ++++++++++--
 tools/testing/cxl/test/mem.c |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index f9c95996e937..11c5a65acacf 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -375,6 +375,16 @@ static int cxl_pmem_region_probe(struct device *dev)
 			goto out_nvd;
 		}
 
+		if (cxlds->serial == 0) {
+			/* include missing alongside invalid in this error message. */
+			dev_err(dev, "%s: invalid or missing serial number\n",
+				dev_name(&cxlmd->dev));
+			rc = -ENXIO;
+			goto out_nvd;
+		}
+		info[i].serial = cxlds->serial;
+		info[i].offset = m->start;
+
 		m->cxl_nvd = cxl_nvd;
 		mappings[i] = (struct nd_mapping_desc) {
 			.nvdimm = nvdimm,
@@ -382,8 +392,6 @@ static int cxl_pmem_region_probe(struct device *dev)
 			.size = m->size,
 			.position = i,
 		};
-		info[i].offset = m->start;
-		info[i].serial = cxlds->serial;
 	}
 	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
 	ndr_desc.mapping = mappings;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 8d731bd63988..9e098cf06603 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1533,7 +1533,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
-	cxlds->serial = pdev->id;
+	cxlds->serial = pdev->id + 1;
 	if (is_rcd(pdev))
 		cxlds->rcd = true;
 
-- 
2.34.1


