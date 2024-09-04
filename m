Return-Path: <linux-kernel+bounces-315171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A596BED2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EDE1C20D23
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301DB1DA30E;
	Wed,  4 Sep 2024 13:41:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45621D9D97
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457296; cv=none; b=FtkPbH0GgEzANZ+b+en+PAr5I1wtUWZzid7SYm1erY3RZUTlieZOH6W3P1e/J0FWj1PpsVw/dF69Fg1d5i5GlRzxc9ZGL0gH8059U5+CJ6wlsYFEnDgiWYOuZzDTeiLCZXxtmbF3nSa/PIToAWxqLd6myHYsXgbD5SBkVn/LIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457296; c=relaxed/simple;
	bh=Hqux90Rf0JdCR6jWI+BtwgNNcGnqTvrBr9spid367Ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYGgvTX2zCA/RTzqTkKo6oIVmUI7UmWKq+FibRnAtX+Od6PFfZtyax5B6R9/B6xnq88seBYve/Z0jeBK09nOtwlM6BhHKaowFgXJ9MWoD0jgGPNe5T+K3ZD9ztYEHYEXQMUgc4js/2cMDJFogkxTRyw8LCcIOYJVJpAkcyb02Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WzNtc1ZXGz2DbdH;
	Wed,  4 Sep 2024 21:41:12 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id B4F3918002B;
	Wed,  4 Sep 2024 21:41:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:41:32 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 5/6] debugobjects: Use hlist_splice_init() to reduce lock conflicts
Date: Wed, 4 Sep 2024 21:39:43 +0800
Message-ID: <20240904133944.2124-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240904133944.2124-1-thunder.leizhen@huawei.com>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)

The sub list can be prepared in advance outside the lock, so that the
operation time inside the lock can be reduced and the possibility of
lock conflict can be reduced.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4f64b5d4329c27d..9876e7ad5291492 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -171,23 +171,25 @@ static void fill_pool(void)
 		return;
 
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
-		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		struct debug_obj *new, *last = NULL;
+		HLIST_HEAD(freelist);
 		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
-			if (!new[cnt])
+			new = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new)
 				break;
+			hlist_add_head(&new->node, &freelist);
+			if (!last)
+				last = new;
 		}
 		if (!cnt)
 			return;
 
 		raw_spin_lock_irqsave(&pool_lock, flags);
-		while (cnt) {
-			hlist_add_head(&new[--cnt]->node, &obj_pool);
-			debug_objects_allocated++;
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
+		hlist_splice_init(&freelist, &last->node, &obj_pool);
+		debug_objects_allocated += cnt;
+		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }
-- 
2.34.1


