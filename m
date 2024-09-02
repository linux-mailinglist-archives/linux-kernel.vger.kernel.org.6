Return-Path: <linux-kernel+bounces-311456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47842968982
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028682832E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F295819E992;
	Mon,  2 Sep 2024 14:09:47 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6D21018F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286187; cv=none; b=cGWlDI0SkhSATaRHLMO+QJ7JFeErCwunu+tbPs9aKklzK8z1MxbUWynPKSPmSNCYYCwOWMBwG85AUfQlgUpqXfUMKkbT+FSPlXEO9I9GaeQLVWGdQzULK7h+tNWL9MvZTvmdb/LKe4KyhxjiTYsymxPtVenu32Jpwlba2+craRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286187; c=relaxed/simple;
	bh=L8pJ9sYAixGyyDr7T0fwgN2WWBSMszASMnDXD2rpsWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBvmJ9srz2iAjl3kElGgkORz6PZjkgCy3YxdQx7AkIJsKj96Em6f4Vp/9Jq93kuqUpN9U2NI6g1hjR6t911BSqEyMocrtkJr5bt6CJqpbTT/eoE2z2oUX9ptINJOlNGaXDClobdUSxeXxosVAvYyR+6zhqPAqZR0xT5iqd4hoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wy9c40sMxz1S9NK;
	Mon,  2 Sep 2024 22:09:24 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id A49721A0188;
	Mon,  2 Sep 2024 22:09:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 22:09:42 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/5] debugobjects: Don't start fill if there are remaining nodes locally
Date: Mon, 2 Sep 2024 22:05:30 +0800
Message-ID: <20240902140532.2028-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240902140532.2028-1-thunder.leizhen@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)

If the conditions for starting fill are met, it means that all cores that
call fill() later are blocked until the first core completes the fill
operation. But obviously, for a core that has free nodes locally, it does
not need to be blocked. This is good in stress situations.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index aba3e62a4315f51..fc8224f9f0eda8f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -130,10 +130,15 @@ static void fill_pool(void)
 	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
 	struct debug_obj *obj;
 	unsigned long flags;
+	struct debug_percpu_free *percpu_pool;
 
 	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
 		return;
 
+	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	if (likely(obj_cache) && percpu_pool->obj_free > 0)
+		return;
+
 	/*
 	 * Reuse objs from the global free list; they will be reinitialized
 	 * when allocating.
-- 
2.34.1


