Return-Path: <linux-kernel+bounces-395467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B79BBE41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D67C2827CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73861CC881;
	Mon,  4 Nov 2024 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cAQ0lG44"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDD23A6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749953; cv=none; b=IdGo9YaD6rcojcXR9JZyKb2UQ1ve4TwATIAHeVtoLu19xdor95zoH+6cPXRmkyjBet0CdxlE0ASLllZd2V8+7p3TqYATttwAUwsGO4fSjDdvOINKFBXHDifYOqnRf7MNe3W6XM4a26+p/aJqYvmPZQ+Yby4npfO8+hjoDWdAvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749953; c=relaxed/simple;
	bh=nNkQEz7q1y9TA9WHY/dcUZQ0DF9WN7rRvFNtajJJ+zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dNdVmSHaKiuqcFCWtnKhsDXoe3pYuzb5YfK9I2trxbHdF+NUKZb0zdbaJdsFioniXit4wYEo2OhQfR91FTxtT7m4SH0Fj+A2x4kvOaZwOuIbaP6UwfkDiikhMrXa2e10j3m39mf8SwG0jW8KfPMMRt19LGgDZFYff9f1UkffQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cAQ0lG44; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730749948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EGVrayaSxuajQ0X9yfhxdRUCreSD+4GY2Mj0JWo6b5E=;
	b=cAQ0lG44JiIahSI5ZJeZ43i3ciy/9XtFdb4qqvYIBxUQuHUjiUNooulBW2GhInqpBzKKWl
	9ZnxIzDYZM9QzLebFZ1HHOHqBxoiWxmq7H76jAyMARCFvUyqFIT91djElI5IeNi+i9EeFe
	7eLgxYLWxSevUT2cx41ou/QzbPwdUNw=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/i915: Use sg_set_buf(), sg_dma_address() helper
Date: Tue,  5 Nov 2024 03:52:20 +0800
Message-Id: <20241104195220.655343-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch switch to use sg_set_buf() and sg_dma_address() helpers, no
function change.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 135ded17334e..9680cde47b5a 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -66,10 +66,8 @@
 static void __sg_set_buf(struct scatterlist *sg,
 			 void *addr, unsigned int len, loff_t it)
 {
-	sg->page_link = (unsigned long)virt_to_page(addr);
-	sg->offset = offset_in_page(addr);
-	sg->length = len;
-	sg->dma_address = it;
+	sg_set_buf(sg, addr, len);
+	sg_dma_address(sg) = it;
 }
 
 static bool __i915_error_grow(struct drm_i915_error_state_buf *e, size_t len)
-- 
2.34.1


