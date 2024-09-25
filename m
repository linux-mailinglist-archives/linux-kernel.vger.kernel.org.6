Return-Path: <linux-kernel+bounces-339225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC6986179
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552D91C26FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D318732A;
	Wed, 25 Sep 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGeYFcQg"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2791862BB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273928; cv=none; b=o+S5/9SDLGNOh1Scnz7sXjLPyE1iktUl1z0mT02wfsHIcKNyXfZ1+Hqd1PUOKNcTxal1GojUR2MkUnw23pRg1mureNELZ1aSnomrlGFDIixPvdc4ZXAPW7OoHWYg1UPhIisAms23E/mtljGQVTFsVwGgBQhIs7x4vngf5nLenXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273928; c=relaxed/simple;
	bh=ZXsHY/N0ib9u2Hl5cFK5B5Evj32BWfZwfPIFrSdPOWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/piNkJApOa1o/UpERk1PZSB3OJb0Buvk7WDGpB1Z4Ahi6n+vYrb/dHFyadIdFOnCHWRryXZzVh3WSToDbBaxVRHGaq8iyujtPCx9vpJkaiWLXz2zcR5OARdQ5ROEWgr7xoGzPNG4Tk7DKbTz0AnXzEXvUSqiiuk9KCTP8SSPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qGeYFcQg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727273923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j1jLzGsVDLJpvcx9eHuYorQp4QLT+Mz2rR2lkvgJUBc=;
	b=qGeYFcQguJyat4m0Y6rli6DTb6lVeOVti6hvTMdkragSAjHgxBhjwN6/6LrJA5+6dgNiCk
	hAOU41BfwGN7U4syOz+hI6Vh/s1cKJQCsvE1hsqJPBGsLDvf+V2Ay3fDgpuTI383qbRVR5
	2+E/pcY3JoBLr04nrI3JspsG8fCFsrM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kunwu Chan <chentao@kylinos.cn>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ivan Briano <ivan.briano@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Use memdup_user() instead of kmalloc() and copy_from_user()
Date: Wed, 25 Sep 2024 16:17:46 +0200
Message-ID: <20240925141750.51198-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use memdup_user() instead of kmalloc() followed by copy_from_user() to
simplify set_context_image().

Fixes the following Coccinelle/coccicheck warning reported by
memdup_user.cocci:

  WARNING opportunity for memdup_user

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index c0543c35cd6a..c1cc41e90502 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -2159,18 +2159,12 @@ static int set_context_image(struct i915_gem_context *ctx,
 		goto out_ce;
 	}
 
-	state = kmalloc(ce->engine->context_size, GFP_KERNEL);
-	if (!state) {
-		ret = -ENOMEM;
+	state = memdup_user(u64_to_user_ptr(user.image), ce->engine->context_size);
+	if (IS_ERR(state)) {
+		ret = PTR_ERR(state);
 		goto out_ce;
 	}
 
-	if (copy_from_user(state, u64_to_user_ptr(user.image),
-			   ce->engine->context_size)) {
-		ret = -EFAULT;
-		goto out_state;
-	}
-
 	shmem_state = shmem_create_from_data(ce->engine->name,
 					     state, ce->engine->context_size);
 	if (IS_ERR(shmem_state)) {
-- 
2.46.1


