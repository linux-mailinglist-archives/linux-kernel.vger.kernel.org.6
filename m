Return-Path: <linux-kernel+bounces-294852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E3959359
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610E5B21E58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A31547E2;
	Wed, 21 Aug 2024 03:35:56 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD751803E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724211355; cv=none; b=CwiZVEH8AtUV+1i0SHYvTEkltlg3U+D5qnjrCmGSC3sRuL3yVc4Mc0yPLHe5oFKewxaxb09vz7XsUO62R5cjL7jw4LDG5ZcRM5+c2b1PpSsVXzE8MMkV4oFE+VQhQ16ZaaJFF14HKS9SK5NX4IuF3zjQp9QZerKmRw2451au1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724211355; c=relaxed/simple;
	bh=zgBVU+v1RgQT22S6T4hUoVtw6AbSkEnjK5YuJWCn01E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTggq3BReZ7mqc1EaNhF3Sd9ude8onJNw1yJGh/9UD04ZIj2PlBRDOx1zrgI4LgpSS22Wit1kxGc/HqOiDjpj+gLwhSE2QnL4J/9E0Fo1s2ZD7PvR31envk5lnPdoXA0xFjAEJhBA7aCSUm+hVhqzMY4dPAy1fl4rTg/XC/pNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpX6X1tHYz2Cn5k;
	Wed, 21 Aug 2024 11:35:48 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 330C71A016C;
	Wed, 21 Aug 2024 11:35:50 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 11:35:49 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Roman
 Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mm/slab: remove duplicate check in create_cache()
Date: Wed, 21 Aug 2024 11:26:37 +0800
Message-ID: <20240821032637.1930-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
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

The WARN_ON() check in static function create_cache() is done by its only
parent kmem_cache_create_usercopy() before calling it.
	if (...
	    WARN_ON(size < usersize || size - usersize < useroffset))
		usersize = useroffset = 0;
	...
	s = create_cache(..., size, ..., useroffset, usersize, ...);

Therefore, the WARN_ON() check in create_cache() can be safely removed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/slab_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b8f2f..3069c9095523484 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -210,9 +210,6 @@ static struct kmem_cache *create_cache(const char *name,
 	struct kmem_cache *s;
 	int err;
 
-	if (WARN_ON(useroffset + usersize > object_size))
-		useroffset = usersize = 0;
-
 	err = -ENOMEM;
 	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
 	if (!s)
-- 
2.34.1


