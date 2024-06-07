Return-Path: <linux-kernel+bounces-205314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF638FFA92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4680D1C23E83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D565155A46;
	Fri,  7 Jun 2024 04:27:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A79155721
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734434; cv=none; b=H07UoPX8GRK5djUs8VBVOasOLQbsouhOEPMFkGg1TlQ6hr9H4VUzDAk5ID3bsiw1LOyqHG45bcq8FgSqCzwYZgkD8HbwmPD02Vsj72EF4cvjMvpG/4fEFsKBWmR7iieo47onrdSlqs87zVKrMBOKSgi6REREPZ+t4bfPgwEjCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734434; c=relaxed/simple;
	bh=H5g+ozEoXYHRgM2mWeR1WnD3zFm8t3yW/MmLkD2THLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCJoVP451zozQ9fCbf7V5TxFuZid7MjfUZAN82IK9nrne53gG+jZpkJ2TReHtxZvbbjfU7HdS2XHzKqjjOPhzSAdp6Op2vOHTWKQeeT2xkhArzE4lx7FCR3GQHfGz2L2jeMsmLDJpQgXMrM3I3vKm6jAx6S/Jx6fggOVpzBMMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSjr2m1jzsTRt;
	Fri,  7 Jun 2024 12:23:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EF8E18007E;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:55 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 039/110] ubifs-utils: Adapt log.c in libubifs
Date: Fri, 7 Jun 2024 12:25:04 +0800
Message-ID: <20240607042615.2069840-40-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Adapt log.c in libubifs, compared with linux kernel implementations:
 1. Remove debug related implementations(eg. dbg_check_bud_bytes), debug
    functions are not needed by fsck, because fsck will check fs in
    another way.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/log.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/ubifs-utils/libubifs/log.c b/ubifs-utils/libubifs/log.c
index b6ac9c42..0d459261 100644
--- a/ubifs-utils/libubifs/log.c
+++ b/ubifs-utils/libubifs/log.c
@@ -15,7 +15,13 @@
  * journal.
  */
 
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "misc.h"
 
 static int dbg_check_bud_bytes(struct ubifs_info *c);
 
@@ -737,26 +743,7 @@ out_free:
  * ('c->bud_bytes' is correct). Returns zero in case of success and %-EINVAL in
  * case of failure.
  */
-static int dbg_check_bud_bytes(struct ubifs_info *c)
+static int dbg_check_bud_bytes(__unused struct ubifs_info *c)
 {
-	int i, err = 0;
-	struct ubifs_bud *bud;
-	long long bud_bytes = 0;
-
-	if (!dbg_is_chk_gen(c))
-		return 0;
-
-	spin_lock(&c->buds_lock);
-	for (i = 0; i < c->jhead_cnt; i++)
-		list_for_each_entry(bud, &c->jheads[i].buds_list, list)
-			bud_bytes += c->leb_size - bud->start;
-
-	if (c->bud_bytes != bud_bytes) {
-		ubifs_err(c, "bad bud_bytes %lld, calculated %lld",
-			  c->bud_bytes, bud_bytes);
-		err = -EINVAL;
-	}
-	spin_unlock(&c->buds_lock);
-
-	return err;
+	return 0;
 }
-- 
2.13.6


