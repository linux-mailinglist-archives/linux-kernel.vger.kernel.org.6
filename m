Return-Path: <linux-kernel+bounces-320038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B86970550
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCF41F21DCE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D94D8C8;
	Sun,  8 Sep 2024 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eKYbH2W3"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F61CA81
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725780008; cv=none; b=DyBFHnK+PjBgycUjfi6dPETc5+H/4sZNivgUml7CzjdVKJBnpMgKsGYnaZwbRQLyM0Vfup6egLHR+Rp6oDVeQS/ym6tU2hULBefJFuabBwVpvtwgG+LbiyaY4v3+CdZwjZrwmA9iJjSgwZDENPniSe1PapDpp2jox0p1k8ZwFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725780008; c=relaxed/simple;
	bh=QKek4z8eLQcZylK2hsqIodQSecQVxvOpWDvOHZ7nKyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPf3+yyZLK08E9ojajw2jOHZq6ripr5nrLiIIcnJa628Q7Xr7MiLp7HaMb2y0DVgPuA2JZYXfNUdNMAtXuM1WgzwKavLy44V1BWmMentHa6KrPkexpIMoiqw5WMXqiXJ+PrtU8O9piNwwSnEoKDbMJ8A0ps4jQ9NmaXBNzPfVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eKYbH2W3; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725780002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jechb95hmorUhOngmJkF9gCQgvUHcIPjIBZ73kyW/N8=;
	b=eKYbH2W3T8L9iU6FxtWjDR20MtrRZZ/TWlvZWwrJiCeyrgMGDnAak6jaVEcE3pqKEXkC1+
	qjX6MBu5BSQ/sAoF2aoyzlwBg8JDqGiKcPF72+mHQjHX3UytXo2c8nXL44gbm+5W/PC8WF
	nx6R4rgvOIW3T3VW/UC33MIQ3brZWCM=
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
Subject: [PATCH] drm/etnaviv: Print error message when driver can't get pages
Date: Sun,  8 Sep 2024 15:19:50 +0800
Message-ID: <20240908071950.200508-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This error could happen when the GFP_HIGHUSER flag is set, such an error
can also be seen on the X86 platform. According to the kernel document in
gfp_types.h, "the GFP_HIGHUSER is for userspace allocations that may be
mapped to userspace, it do not need to be directly accessible by the
kernel."

However, drm/etnaviv will use the pages to implement vmap and mmap
operations of the GEM object function. The flag still set at present.
When we can't get pages, it certainly is a bug. Hence, we should print
this kind of error with drm_err() instead of dev_dbg().

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 5c0c9d4e3be1..5ffc31f32ac9 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -61,7 +61,7 @@ static int etnaviv_gem_shmem_get_pages(struct etnaviv_gem_object *etnaviv_obj)
 	struct page **p = drm_gem_get_pages(&etnaviv_obj->base);
 
 	if (IS_ERR(p)) {
-		dev_dbg(dev->dev, "could not get pages: %ld\n", PTR_ERR(p));
+		drm_err(dev, "could not get pages: %ld\n", PTR_ERR(p));
 		return PTR_ERR(p);
 	}
 
-- 
2.43.0


