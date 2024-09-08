Return-Path: <linux-kernel+bounces-320192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9D97073C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6931F1F21B83
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA315C13E;
	Sun,  8 Sep 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNKQaUaz"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B515B0E0
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797486; cv=none; b=OWizGzReaxtTma8YA62xkCnDIBvONzPQh60Okv0SkL+iGIn9Jp2WcAljlr4Mu2TGTQ0/WO4FE+E92SfrtDS/VnK2esDFNNumTaasv7eYBEn4px5FhpoSg6MkZwDHk705e2GKHPllb3uAcftzvMQRHRDTDSK1FSy1lIoHulhbWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797486; c=relaxed/simple;
	bh=i8d13tBmv6I09evsqBgoqb2zRwpMIrOW5cdrPNX/8gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwAtujDo9ygbkyq2i65h7VuczqhL90jkd+BWmmSQtxpuc8e/Wkvjy8x/z2SMC1B4wFL+2bylMal104Nop8Pb0DmnJtE0w+QDBOtMWgCwFFxQQbgEw84Ad2zVsqmFjdKPJ2nXTj4kmtfMV3PQvWaVGiWAr7D4LfL1GQiD8llwl/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNKQaUaz; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725797480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rwOczaLe6uqVz6NheSsaNQI0Fd3X29dHQQcS+05QMqQ=;
	b=pNKQaUazGNurQItNPSWv4e9eEwRRPv4VB2HsJ3KsVxnp3CDNgcdTE33dD2igl+NH70kTM6
	VbD3oplLpnhltl4TuCMmy0uCMcm6N3fOR0wafZOk4dSIktyEqpsgoJVUyAHC1IJRvKLSrO
	jYFb90Bgjnv4UVPpOy5GC3a2tPKjn24=
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
Subject: [PATCH v2 1/5] drm/etnaviv: Use unsigned type to count the number of pages
Date: Sun,  8 Sep 2024 20:11:03 +0800
Message-ID: <20240908121107.328740-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The drm_prime_pages_to_sg() function takes an 'unsigned int' argument to
store the length of the page vector. The size of the object in number of
CPU pages can not be negative, hence, use 'unsigned' variable to store
the number of pages, instead of the 'signed' one.

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---

v2: Pick up tags and improve commit message

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
2.43.0


