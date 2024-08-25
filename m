Return-Path: <linux-kernel+bounces-300486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE59295E43E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5CE28172D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22915688C;
	Sun, 25 Aug 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E1R5EZVe"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D313DDA7
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724601964; cv=none; b=hq6YGzPEi02idtrXM0sYaCD+jtdLKZ52pOCwtSsQY0CEOkVF2uekTDemjmA0KPKF/qokXFY8HOYfQU/UpOnLE8WtreO7EbArODLHhWlhVDdjHNYs84sjguVWsJXWsUHCsptyuDaE03kO/K887SpvtlwxHbs+bNCcuS6rQL1+MZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724601964; c=relaxed/simple;
	bh=RxgxbUXh2saESal7J3+WUhqsU/LyAqNh7T7NoJ98MuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EihFXedPOtb6uMOkNiVEqeO75rAHnsJdqZ50VRhhf9tgnZ8n6U6zn+YSUwOrdyoILYpVz60YNbJYVahkf9s4Xy9z6jE4qmRFlFnMgnGnML+1l8rcAQdQx8lW6y0IxKk0KRmmALWnaGBejIrdeHwaJLdY9jVqG+c0r1zvU7XmC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E1R5EZVe; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724601952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TYGIN6dFnE6ddJqp5ti4+Fd91MRSp+JrwofPL1YAO60=;
	b=E1R5EZVeRZmUuZiKXIJU5bwEUTOMiYnHy9Tqdhbm6sfU05LErbeRpPi7k3dIMQ26p7XS2+
	lT7WjxmTYgYEFYFHMAvxu47cNX6jo4jWKocZgBCKO4mcl2Wt2NJsggcyJ3KGUf8B0JHxwr
	eh9i5r/pkWyEhP9uQ4bYHISLNGxGpcE=
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
Subject: [PATCH] drm/etnaviv: Drop the <linux/pm_runtime.h> header
Date: Mon, 26 Aug 2024 00:05:38 +0800
Message-Id: <20240825160538.404005-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the etnaviv_gem_submit.c isn't call any runtime power management
functions. So drop it, we can re-include it when the header really get used
though.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 3d0f8d182506..3c0a5c3e0e3d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -6,7 +6,6 @@
 #include <drm/drm_file.h>
 #include <linux/dma-fence-array.h>
 #include <linux/file.h>
-#include <linux/pm_runtime.h>
 #include <linux/dma-resv.h>
 #include <linux/sync_file.h>
 #include <linux/uaccess.h>
-- 
2.34.1


