Return-Path: <linux-kernel+bounces-320193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469AC970741
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F025A1F21AE1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFA15D5BB;
	Sun,  8 Sep 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GIZQHfKg"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204715C13D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797489; cv=none; b=uABm1mfs55YIgjVhl7A2/yWP4uSFf+FNEmS+ugCqD9q9buJO4AKBsi+hnMvUY91deeA1q1LnqyYaqe+qTgq+szyg7VxF9JyPX3WPC3a9j9kPEA10OwQYnoNXYuVt/PvjdlPEiLxTPMRj0NP8gpMEy8zCWns80KeSpps6K2dLwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797489; c=relaxed/simple;
	bh=VgxW43r04ZJOcB77HQwsaG9JJpyLsTPQIimAk55gDcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/Vcc45DA+drYceWYOeKxx+Qm1MinLo4Ysrbv9yYa8XE2wJL8AyM8RTJ3yDGeWw+cJupF/nHJ7wu/tKZRC2CvKJf6hzA9LmGE7UqEP20xk6Np8NhtOqZObBh7pKJdPw7Xu/5P9FnYqHg5qiD+MR3Bl26fTKML67HexIe83LnZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GIZQHfKg; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725797485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wcen4kcvpDwIaeiESKNLrKqnOT9ib0C4GbjhHrhdTA=;
	b=GIZQHfKgy0pDhySpoGH5JNeNHg/YMH071QNMYmYOMZTsFuR4oUBMvYaQvDKyTWrkDQQoem
	WEOrUbDyDn+a/SJcTvoaH2APqQuzaNbxlFKGAMosl6gCbbt5DV9+XiZORhgejJxb3eDIpU
	p0kvjnJCW2L7ImTPlhiL+9WYs11LhdQ=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Christian Gmeiner <cgmeiner@igalia.com>
Subject: [PATCH v2 2/5] drm/etnaviv: Use 'unsigned' type to count the number of pages
Date: Sun,  8 Sep 2024 20:11:04 +0800
Message-ID: <20240908121107.328740-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240908121107.328740-1-sui.jingfeng@linux.dev>
References: <20240908121107.328740-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The unpin_user_pages() function takes an 'unsigned long' argument to
store the number of userspace pages, and the struct drm_gem_object::size
is a size_t type. The number of pages can not be negative, hence, use
'unsigned' variable to count the number of pages.

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---

 v2: Pick up tags and improve commit message

 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 5ffc31f32ac9..4ce3d2ea7767 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -686,7 +686,7 @@ static void etnaviv_gem_userptr_release(struct etnaviv_gem_object *etnaviv_obj)
 		kfree(etnaviv_obj->sgt);
 	}
 	if (etnaviv_obj->pages) {
-		int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
+		unsigned int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
 
 		unpin_user_pages(etnaviv_obj->pages, npages);
 		kvfree(etnaviv_obj->pages);
-- 
2.43.0


