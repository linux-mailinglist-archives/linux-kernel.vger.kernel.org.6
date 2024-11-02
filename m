Return-Path: <linux-kernel+bounces-393173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93439B9CCB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 05:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3688F1C20A19
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4BC1448C7;
	Sat,  2 Nov 2024 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a6Y1igLy"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F923CB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730521628; cv=none; b=b4t7CTbq60foJWuJjb3aKQFCJpnCOxSEJufP8flwHO0X6PgGBqNHLeBGOKC6pyXhWezepOwgvFbqrKw6QkTNZY/MF4lRlAME8gDMP21rL8R1QEi1opLxLi8IA/hkAls+5VImXX0tGrKqJqrWyS4wu4LHfpPWx/5n70JioXmUVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730521628; c=relaxed/simple;
	bh=jypRQ8mSKx3sxH4jdVfdAqbOuYpQcWI/gYm2nD7LQhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h8G/15tIxtKd4VdCxjKR7T17fBK3YbM6QaA1z0kdBZ0ZQq8VXcVkDj0TODhDm181o4KYM8/AHxJnmWX4jQZIB+XSvntRzoRjN8ZVQ0wxIlXe9g0VziXbwE27L/Wdk9+mcXB8sVXGVgriPlI3X2J9A1Pwcar8vSUjVBmc/T3bURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a6Y1igLy; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730521621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LjM8+cIQXYtSO2YQDr5pKwc3LLU72AYnqnGxdbYDS6E=;
	b=a6Y1igLywdkFGq5aojQWQtTor7xHEi/41wqgwW8bsC145NLK/K5m7ZDwi2xhY+U9wD/CkC
	m/bSDWzkrm8DJR7Lwh6fYFpqEJ6KXlRoXKal3JrTBp0grslb/Awm4V7XGRmzXTa3d9fzhk
	mGkc/PaEani4Uu0Wqi7Gbt628/sHK2I=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/etnaviv: Drop unused data member from the etnaviv_gem_object structure
Date: Sat,  2 Nov 2024 12:26:52 +0800
Message-Id: <20241102042652.3325597-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Referencing the 'struct etnaviv_gpu *' by every etnaviv GEM BO is weird.
Drop it and drop yet another unused data field, namely 'access'.

Memory footprint of etnaviv GEM BOs reduced.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index bf0d049d8a79..8da32fb5df16 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -50,9 +50,7 @@ struct etnaviv_gem_object {
 	u32 flags;
 
 	struct list_head gem_node;
-	struct etnaviv_gpu *gpu;     /* non-null if active */
 	atomic_t gpu_active;
-	u32 access;
 
 	struct page **pages;
 	struct sg_table *sgt;
-- 
2.34.1


