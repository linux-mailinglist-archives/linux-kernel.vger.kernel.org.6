Return-Path: <linux-kernel+bounces-300488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1539C95E454
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C71AB20F99
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FB813F43A;
	Sun, 25 Aug 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CER7Z9cw"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208ABB640
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724603012; cv=none; b=Lm6QJmA1e+vL3jcO6y0RCxxznxm75Gw4F8Fsz0R+2PDidroX9TvuWqEcEXjh1laY6/ga4p4lR/93QvjFM7tyJcz2R+6y4qCtxDFMSDHt3VldLgT2ouH5C6C0xtV+LHHYWGA3TCBYq+MTrFK7RtDNZsIwu6OrAe0lDsNeXkZUhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724603012; c=relaxed/simple;
	bh=9c0/mFJtPTEcFPABXk2NyyBsMPiEG5INItjCqp79CPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGG3935+RCYGzNrhNrV2LoKWW/b0k1EBsCzq1ditiqHWxudtYupm1BT4lGgxqOjVN/KcRI2Kan69mUwaiNfuoVnL28WSzO3pOv/h4vvwEA+tJKd6NUKtMPGrLSfMBhQf+/EA6O1QAU4qT5vj78oHa1ZnxsND7q4FX0yKk90He9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CER7Z9cw; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724603007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=okOLfjQVl4D8wTvlHZg+l7qNyNYtvSQnrJ226EM9Ivw=;
	b=CER7Z9cwG8vuqhW8bXU0fXKMBXslT0I23xEa2vfA1m4BwPlqeOCmMF7V0cNUuY9zswotoz
	SWoGcCYCZCx8etzk0WnHZ/PfOWb+bfguESF9xO3h3iBiIfDCeTx+eJzxlGsgH32JqAX+6a
	+3+e5vkQ5OCIsxmAeugqUYCRs5+bdds=
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
Subject: [PATCH] drm/etnaviv: Use unsigned type to count the number of pages
Date: Mon, 26 Aug 2024 00:23:00 +0800
Message-Id: <20240825162300.417306-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The drm_prime_pages_to_sg() function takes unsigned int argument to store
length of the page vector, and the type of struct drm_gem_object::size is
a size_t. The size of the object in CPU pages can not be negative, hence,
use unsigned variable to store the number of pages, instead of the signed
type.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 3524b5811682..6b98200068e4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -17,7 +17,7 @@ static struct lock_class_key etnaviv_prime_lock_class;
 struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
-	int npages = obj->size >> PAGE_SHIFT;
+	unsigned int npages = obj->size >> PAGE_SHIFT;
 
 	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
 		return ERR_PTR(-EINVAL);
-- 
2.34.1


