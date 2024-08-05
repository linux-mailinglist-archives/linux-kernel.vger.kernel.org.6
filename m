Return-Path: <linux-kernel+bounces-274352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EFA947717
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B494281B93
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AA14E2DF;
	Mon,  5 Aug 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaBwdpb8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022413E881
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846087; cv=none; b=gOJjwuyBXTk2Kta9DpxkQN4t6cZ/7N0/DJSwDaLgBwqbkDcKLaTckMzaFKv+4gyKKVkQMGYv7M0TaEZfECjwo1RykqYCt3irxTnbMt/+zAlwFgjR0Muwk+FmjoUdufSatMjpITyJu2vjdT0xlNE6dD1RGckUoTm1RArDYlBonSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846087; c=relaxed/simple;
	bh=JFF1Gkhd1Ahm+S+sAfcuLs7MekS43Qwvuj1bs3rNd3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LX+36SzT7u4OWL8qo6GOccWojnc0JmmqBZ9wdnmTYW9CKAnOxm9jywgSFNy74gmBn+JwjZJANHg5CyE1gde9vNphUFu8O/wR/qx0jtPMtkHtR0oDLpLk56AoJcP9w9UpusCJmBt4Ux7zYshtWucHwZydrnssfYmuag9aFKRC0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaBwdpb8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722846083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+p/W2q7vNtsCSk1hop06eQcM6R9eKnUBXTd9dXAayE=;
	b=eaBwdpb86gf19WNykzS+gt4GYmeswCITsGST3UzZa9UKUSYYaNHtFbg+FBQk0JyrrbpwV/
	/pMO9Yq8SxDTVofBSIBLC+7MnHaLkFnZcrXMQW9bRVfpjNStXNCHfFVcXl2tD2Sx/lxyJB
	Zpfl2WC3c+KMoaVezTtPuWLytzPwGxQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-rSsPaaEGPBG5G-FpSH6Fow-1; Mon,
 05 Aug 2024 04:21:19 -0400
X-MC-Unique: rSsPaaEGPBG5G-FpSH6Fow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD8F41955BED;
	Mon,  5 Aug 2024 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D44519560AE;
	Mon,  5 Aug 2024 08:21:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: maxime.coquelin@redhat.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: [PATCH] vduse: avoid using __GFP_NOFAIL
Date: Mon,  5 Aug 2024 16:21:06 +0800
Message-ID: <20240805082106.65847-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Barry said [1]:

"""
mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
__GFP_NOFAIL without direct reclamation may just result in a busy
loop within non-sleepable contexts.
""“

Unfortuantely, we do that under read lock. A possible way to fix that
is to move the pages allocation out of the lock into the caller, but
having to allocate a huge number of pages and auxiliary page array
seems to be problematic as well per Tetsuon [2]:

"""
You should implement proper error handling instead of using
__GFP_NOFAIL if count can become large.
"""

So I choose another way, which does not release kernel bounce pages
when user tries to register usersapce bounce pages. Then we don't need
to do allocation in the path which is not expected to be fail (e.g in
the release). We pay this for more memory usage but further
optimizations could be done on top.

[1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
[2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480

Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buffer")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 18 ++++++++++--------
 drivers/vdpa/vdpa_user/iova_domain.h |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 791d38d6284c..933d2f7cd49a 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 				enum dma_data_direction dir)
 {
 	struct vduse_bounce_map *map;
+	struct page *page;
 	unsigned int offset;
 	void *addr;
 	size_t sz;
@@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 			    map->orig_phys == INVALID_PHYS_ADDR))
 			return;
 
-		addr = kmap_local_page(map->bounce_page);
+		page = domain->user_bounce_pages ?
+		       map->user_bounce_page : map->bounce_page;
+
+		addr = kmap_local_page(page);
 		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
 		kunmap_local(addr);
 		size -= sz;
@@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				memcpy_to_page(pages[i], 0,
 					       page_address(map->bounce_page),
 					       PAGE_SIZE);
-			__free_page(map->bounce_page);
 		}
-		map->bounce_page = pages[i];
+		map->user_bounce_page = pages[i];
 		get_page(pages[i]);
 	}
 	domain->user_bounce_pages = true;
@@ -297,17 +300,16 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 		struct page *page = NULL;
 
 		map = &domain->bounce_maps[i];
-		if (WARN_ON(!map->bounce_page))
+		if (WARN_ON(!map->user_bounce_page))
 			continue;
 
 		/* Copy user page to kernel page if it's in use */
 		if (map->orig_phys != INVALID_PHYS_ADDR) {
-			page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
+			page = map->bounce_page;
 			memcpy_from_page(page_address(page),
-					 map->bounce_page, 0, PAGE_SIZE);
+					 map->user_bounce_page, 0, PAGE_SIZE);
 		}
-		put_page(map->bounce_page);
-		map->bounce_page = page;
+		put_page(map->user_bounce_page);
 	}
 	domain->user_bounce_pages = false;
 out:
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index f92f22a7267d..7f3f0928ec78 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -21,6 +21,7 @@
 
 struct vduse_bounce_map {
 	struct page *bounce_page;
+	struct page *user_bounce_page;
 	u64 orig_phys;
 };
 
-- 
2.31.1


