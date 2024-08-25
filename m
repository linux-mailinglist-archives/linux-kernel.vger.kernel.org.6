Return-Path: <linux-kernel+bounces-300511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B595E49D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 19:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A161F21434
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC066158D66;
	Sun, 25 Aug 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dwOtLsgg"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835D1DA3D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724607705; cv=none; b=drK/xBrpQ/wk3eSsWBu4RfKMwM8SJ41YIuLACpFjJt7oDGIn7dSHKCUPFPBQ3WlM6LMla/Fv+HwEHjaeL1cdRpfVNL+yegh1sz5YdlIGnpj5245jwfjYUPQCNJt9jTX0EDvfdBDnt69v+Itq8AbN73mupxksoAL6X4krdEyYlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724607705; c=relaxed/simple;
	bh=5e76Ul+WCH+8lGGNDt0QcqT1L5ud/pM3un2Fkpmbwbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ROxtSsz6WwHzvzC0FUt4TIT77eGt8qHzBnMkLGBnHLdGhXvA5F+YtGjv1apH87hAc4JAOKTpTfdIYGpTgm19eGmKsyEGuUSn+5hrRapJJMp+Qtp7VVlKNbaP0TUqbIzg+IaGSf/zvl5g0XJqi+aW+Vap8s5JCmy9zXSrZW6sX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dwOtLsgg; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724607699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dUjbebKPyAzDyV2pAzp4K1FFmau1gTXM+zFmTzQpT1Q=;
	b=dwOtLsggz+/wSCgXFOPCV39W70aFlw1aNJqSVoTgvpj3BM27FYYoJ6eeVTJ3UOnDijEth8
	ONXsjZqt3g8+xTT4Zge5ly/j8P345LGNMScna4FT8eaepFjb37C+ceBhwVSIMv4nEkyHTu
	JGVE2b9FZ42VM01wMK99oUv4jKVEK1I=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/etnaviv: Use unsigned type to count the number of userspace pages
Date: Mon, 26 Aug 2024 01:41:28 +0800
Message-Id: <20240825174128.474100-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The unpin_user_pages() function takes an unsigned long argument to store
length of the number of user space pages, and struct drm_gem_object::size
is a size_t type. The number of pages can not be negative, hence, use an
unsigned variable to store the number of pages.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index ce9c9233c4a6..fa0d193cec26 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -695,7 +695,7 @@ static void etnaviv_gem_userptr_release(struct etnaviv_gem_object *etnaviv_obj)
 		kfree(etnaviv_obj->sgt);
 	}
 	if (etnaviv_obj->pages) {
-		int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
+		unsigned int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
 
 		unpin_user_pages(etnaviv_obj->pages, npages);
 		kvfree(etnaviv_obj->pages);
-- 
2.34.1


