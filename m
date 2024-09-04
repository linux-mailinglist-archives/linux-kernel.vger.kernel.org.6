Return-Path: <linux-kernel+bounces-315172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8BE96BED7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B36B2A56E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301501DA2F7;
	Wed,  4 Sep 2024 13:41:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45BD1DA10D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457296; cv=none; b=hlGnaVQXbZclLkhik3zanw7twEzSTBUFmcDdD6fj6l709utRTlZ01W+JdAj5tSv5+V0GRQ5kFe94mQbN8AI2KyauI/wha3bpyoeTDMIiAHC2ZcUGQM7wsfwlAyTk23yyyXcCNJuXtrusoH2kmlWscD9XEnCVLTOoqkb/pUDNgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457296; c=relaxed/simple;
	bh=sB78dWO5QeNHu/5FpHflaziWOlOYJ6eILUJmj7kKJDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0SgCdKK78zxRf7Ai4N0Hr0esHg0N6eDtqyVg1yhPwagOnoT+oTmpV9aHG+6fwIzlgbNnrjJdQbgXvS8dWKylH2Bi0vJ41WKKj+NGZjUr0V4ymAn28IdwBPyYRTmpwARG5COnuxOjJgvyEgL2AaT6nCK7R9hmnH68P7XfsJWRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WzNnG4vfGz20n6Q;
	Wed,  4 Sep 2024 21:36:34 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id DF2D51400DB;
	Wed,  4 Sep 2024 21:41:31 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:41:31 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 3/6] debugobjects: Remove redundant checks in fill_pool()
Date: Wed, 4 Sep 2024 21:39:41 +0800
Message-ID: <20240904133944.2124-4-thunder.leizhen@huawei.com>
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

(1)	if (READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level)
		return;

(2)	while (READ_ONCE(obj_nr_tofree) &&
	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
		raw_spin_lock_irqsave(&pool_lock, flags);
(3)		while (obj_nr_tofree &&
(3)		       (obj_pool_free < debug_objects_pool_min_level)) {
			... ...
		}
		raw_spin_unlock_irqrestore(&pool_lock, flags);
	}

The conditions for the outer loop (2) and inner loop (3) are exactly the
same. The inner loop is completed under the protection of the spinlock.
When the inner loop ends, at least one of the two loop conditions must be
met. The time from the end of the inner loop to the restart of the outer
loop is extremely short, and the probability of other cores modifying
'obj_nr_tofree' and 'obj_pool_free' is almost zero during this time. In
fact, after the outer loop ends, it is still possible for other cores to
modify the values of these two variables. Therefore, restarting the outer
loop has no practical effect except for an additional check. So the outer
'while' should be changed to 'if'. Then we'll see that the second
condition of the new 'if' is already guaranteed above (1) and can be
removed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6329a86edcf12ac..7a8ccc94cb037ba 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -135,15 +135,13 @@ static void fill_pool(void)
 		return;
 
 	/*
-	 * Reuse objs from the global free list; they will be reinitialized
+	 * Reuse objs from the global tofree list; they will be reinitialized
 	 * when allocating.
 	 *
-	 * Both obj_nr_tofree and obj_pool_free are checked locklessly; the
-	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
-	 * sections.
+	 * The obj_nr_tofree is checked locklessly; the READ_ONCE() pair with
+	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) &&
-	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
+	if (READ_ONCE(obj_nr_tofree)) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
-- 
2.34.1


