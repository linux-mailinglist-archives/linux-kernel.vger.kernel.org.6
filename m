Return-Path: <linux-kernel+bounces-315175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B9096BED4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1631C21B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54241DB53B;
	Wed,  4 Sep 2024 13:41:37 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0B26AED
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457297; cv=none; b=tAvpoIglYYc0N5cP+z40RkDCj9N+MqRzgMi2GUvDH6dUeQ11eJQODwwjZlFHHu1k13Z31OokLt1+8DQqZAc5VERnWmcJmFcbfEBAMtnC5F8+BRrLCOGN2uG1mjqnnHoDE5UxTboR3v6lZsTz8Sz2HmI8i1XBr63mb/k++6h4aoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457297; c=relaxed/simple;
	bh=0fCzj+OIc4N4SMC1QMIo3kEc+Ed0A0yHD28WRtrN4o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2HaNSmvMkGGwscJCVxi2PtnS5UckRdNaEgAKRSzE4ctT2G88ltRKFfFsYkZk41fpGW6ccR1FFm0ExtejkONu7/XTrrOFqHSrk3FEwKRETGkuQt6xg7sQgYEhwvYP1m7EYQpqOu1hLNfUo+c+se15nx1l6EgVflA8ayijGxxzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WzNtZ2LfZz1S9fT;
	Wed,  4 Sep 2024 21:41:10 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 691F11400DB;
	Wed,  4 Sep 2024 21:41:31 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:41:31 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/6] debugobjects: Fix the misuse of global variables in fill_pool()
Date: Wed, 4 Sep 2024 21:39:40 +0800
Message-ID: <20240904133944.2124-3-thunder.leizhen@huawei.com>
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

The global variable 'obj_pool_min_free' records the lowest historical
value of the number of nodes in the global list 'obj_pool', instead of
being used as the minimum level to keep around. It has to be replaced
with variable 'debug_objects_pool_min_level'.

Fixes: d26bf5056fc0 ("debugobjects: Reduce number of pool_lock acquisitions in fill_pool()")
Fixes: 36c4ead6f6df ("debugobjects: Add global free list and the counter")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7226fdb5e129a79..6329a86edcf12ac 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -142,13 +142,14 @@ static void fill_pool(void)
 	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
 	 * sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min_free)) {
+	while (READ_ONCE(obj_nr_tofree) &&
+	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-- 
2.34.1


