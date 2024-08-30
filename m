Return-Path: <linux-kernel+bounces-308016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C28965620
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABEB1C223EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AC615886B;
	Fri, 30 Aug 2024 04:01:52 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70C1547D6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990511; cv=none; b=EyscXKP8Zj1x1FiQkSXOZfStKo3eOFH8fnyqpr0PvS5POb/lUVX+CaAqnldoVCuzza01Bqgu79SefyIiNt3ochckWuDvkBWw4W+3/0alfGlYGqRk1yoZ5rwwWZ1ploXxohdG80zULZU366L25CjN28vpNkcofI4USii1258HbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990511; c=relaxed/simple;
	bh=bVY6nkE8npnR7INNnavG7kol8HKafj89St7NtxH+j3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fi8Ubt0fMYfFuAtut5YxJXF3N8nQVO5wHxRzfby6aOjLiQn05cy+H9vlw/n3bpeQo9eU+ODYMe+a4UcS7E1uDrlvFVcoeJVqGj2Tg7H4I98JHzJ9YHEevqa9G/Jr4McBtBWs9kbau5L6WU65a1VSfDklAGvsjbTAvcwsMr6JUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ww4FP1sRdz146Yf;
	Fri, 30 Aug 2024 12:00:57 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id AC5AB1800D1;
	Fri, 30 Aug 2024 12:01:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 12:01:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <andrew@lunn.ch>, <sebastian.hesselbarth@gmail.com>,
	<gregory.clement@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next RESEND] soc: dove: Simplify with scoped for each OF child loop
Date: Fri, 30 Aug 2024 12:09:56 +0800
Message-ID: <20240830040956.3508919-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v1-> RESEND
- Split from the whole soc patch set.
---
 drivers/soc/dove/pmu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 6202dbcd20a8..75f5fc3cb2c6 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -372,7 +372,7 @@ int __init dove_init_pmu_legacy(const struct dove_pmu_initdata *initdata)
  */
 int __init dove_init_pmu(void)
 {
-	struct device_node *np_pmu, *domains_node, *np;
+	struct device_node *np_pmu, *domains_node;
 	struct pmu_data *pmu;
 	int ret, parent_irq;
 
@@ -405,21 +405,18 @@ int __init dove_init_pmu(void)
 
 	pmu_reset_init(pmu);
 
-	for_each_available_child_of_node(domains_node, np) {
+	for_each_available_child_of_node_scoped(domains_node, np) {
 		struct of_phandle_args args;
 		struct pmu_domain *domain;
 
 		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-		if (!domain) {
-			of_node_put(np);
+		if (!domain)
 			break;
-		}
 
 		domain->pmu = pmu;
 		domain->base.name = kasprintf(GFP_KERNEL, "%pOFn", np);
 		if (!domain->base.name) {
 			kfree(domain);
-			of_node_put(np);
 			break;
 		}
 
-- 
2.34.1


