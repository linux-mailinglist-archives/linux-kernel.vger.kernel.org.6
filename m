Return-Path: <linux-kernel+bounces-356240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73ED995E61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821B2283F92
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1FA14885E;
	Wed,  9 Oct 2024 03:55:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9C41C65
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728446158; cv=none; b=Tipz5yGG7uFkuAbwt6PmOKcR2zH9HaGF5rDH0XQ8u/hjTRALgp0A/5R1eb4TH3hw5Z3hd8CZDoYi6jst3x/2FlqAYlG/RF1ACpjfERYSUtGMPZiVjWZYWwxcJVxGu0Ox2ubfJnOzs8Io8Eu2FVfhBR/54FpOsronO9I3JHSuxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728446158; c=relaxed/simple;
	bh=GskaGwcDgGnQgNJBQpa3K0Zqfm7LuDw78va7gQG41qg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UdsTNOiY+1XnEChOr7oxv3EDHMZWJ+glm4mVG2vU1bw28iv6dRHRjmcBzQWVCMn+ZN5k3UWeNiSMc2GRKveeE2DOwF94tyIAQsHCoQ0vfaJLuZexVP7Osjy+GNUs/0uPtRbDzUDS5cUKj6Mz7CoG0KiGx17J+wk9UOfraIoxb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XNfBh03lYzpWGw;
	Wed,  9 Oct 2024 11:53:48 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id D731E18006C;
	Wed,  9 Oct 2024 11:55:47 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 11:55:47 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Roman
 Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] mm/slab: remove duplicate check in create_cache()
Date: Wed, 9 Oct 2024 11:54:55 +0800
Message-ID: <20241009035455.616-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)

The WARN_ON() check in static function create_cache() is done by its only
parent __kmem_cache_create_args() before calling it.
	if (... ||
	    WARN_ON(... ||
		    object_size - args->usersize < args->useroffset))
		args->usersize = args->useroffset = 0;
	...
	s = create_cache(cache_name, object_size, args, flags);

Therefore, the WARN_ON() check in create_cache() can be safely removed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/slab_common.c | 3 ---
 1 file changed, 3 deletions(-)

v1 --> v2:
Updates based on the latest v6.12-rc2.

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3d26c257ed8b57c..88aa64fc8cd2742 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -222,9 +222,6 @@ static struct kmem_cache *create_cache(const char *name,
 	struct kmem_cache *s;
 	int err;
 
-	if (WARN_ON(args->useroffset + args->usersize > object_size))
-		args->useroffset = args->usersize = 0;
-
 	/* If a custom freelist pointer is requested make sure it's sane. */
 	err = -EINVAL;
 	if (args->use_freeptr_offset &&
-- 
2.34.1


