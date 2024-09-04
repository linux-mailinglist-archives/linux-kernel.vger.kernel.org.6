Return-Path: <linux-kernel+bounces-315173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE6996BED3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD0828890C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC491DB52D;
	Wed,  4 Sep 2024 13:41:37 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47441CF7C4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457297; cv=none; b=T3J4ui0oE1c1MNZJ9NNTCsvxBASAiFTC7zjHVkalwO7LmipOFMRxuvelmEUMawlxH1aOR7ynUm1X6CVSiFYYYOlI0IMC7GHVtJzuqSvfULwOEQ+Qd3c7J5GTpniP2bnS2CPtVEl7+MpF5joNtvSxswbnRqrfDQ9aNxxLxzLhOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457297; c=relaxed/simple;
	bh=1AbWWeZEOpWtGlqls25ky1dwlnbdmQsHIPVJg7ZCeVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnuoFZTeSTgmPRu6Rh0+Nnc1r5/uJG5SWx/fkudUMXgYiWPjVI3pBrT3Nf1uOP9uefp6qQgT19BCycqBjpV9plzRJHTLYLt4VQd2MpRxBRdTMjVFNRtL3Lro2S48lYKL7iOiz5/JHfg3bt5fr+Y1WmuHDfZ5UAAX5c8hCB2xsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzNtZ4wzLz1j82j;
	Wed,  4 Sep 2024 21:41:10 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 0632C1A016C;
	Wed,  4 Sep 2024 21:41:31 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:41:30 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/6] debugobjects: Fix the compilation attributes of some global variables
Date: Wed, 4 Sep 2024 21:39:39 +0800
Message-ID: <20240904133944.2124-2-thunder.leizhen@huawei.com>
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

1. Both debug_objects_pool_min_level and debug_objects_pool_size are
   read-only after initialization, change attribute '__read_mostly' to
   '__ro_after_init', and remove '__data_racy'.
2. Many global variables are read in the debug_stats_show() function, but
   didn't mask KCSAN's detection. Add '__data_racy' for them.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7cea91e193a8f04..7226fdb5e129a79 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -70,10 +70,10 @@ static HLIST_HEAD(obj_to_free);
  * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
  * can be off.
  */
-static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
-static int			obj_pool_free = ODEBUG_POOL_SIZE;
+static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
+static int __data_racy		obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
-static int			obj_pool_max_used;
+static int __data_racy		obj_pool_max_used;
 static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
@@ -84,9 +84,9 @@ static int __data_racy			debug_objects_fixups __read_mostly;
 static int __data_racy			debug_objects_warnings __read_mostly;
 static int __data_racy			debug_objects_enabled __read_mostly
 					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int __data_racy			debug_objects_pool_size __read_mostly
+static int				debug_objects_pool_size __ro_after_init
 					= ODEBUG_POOL_SIZE;
-static int __data_racy			debug_objects_pool_min_level __read_mostly
+static int				debug_objects_pool_min_level __ro_after_init
 					= ODEBUG_POOL_MIN_LEVEL;
 
 static const struct debug_obj_descr *descr_test  __read_mostly;
@@ -95,8 +95,8 @@ static struct kmem_cache	*obj_cache __ro_after_init;
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
  */
-static int			debug_objects_allocated;
-static int			debug_objects_freed;
+static int __data_racy		debug_objects_allocated;
+static int __data_racy		debug_objects_freed;
 
 static void free_obj_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
-- 
2.34.1


