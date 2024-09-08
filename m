Return-Path: <linux-kernel+bounces-320194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB47970744
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4ABA1F21B5F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8615C141;
	Sun,  8 Sep 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZynd5DH"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551215C12D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797495; cv=none; b=AIG/Z5odAzmqenJTqcQEn+QjnpKCh/9Kuu9UL+ntoCiwTtAliRgByZkuPvf4QV/LU9egLcoPrabAZugN7pnJLDIiyDl7pONXI0l6KZPCLAfdvWVCQcbdYZR91s21tSUQvQmt4iE3SwXbSl8phEesURL/8plIrvW17ph6b9l/hsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797495; c=relaxed/simple;
	bh=mZrvh+w+VqZsOrFScFcQgZ3WTIZ6gvwIq4FDC85KVNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR1D1Gt9ETH9mX5csRsrqYSKMtWjeX6iE2gMpDJJDXSUGYq1QP9LO6jlizN1gimJ8K+rqXLzTURLojxyk66p34YDQaeIGbQ+hJ4ihAnYY6tLiaB7EmCy08yanPoTCc/8eYcXD/JPk+/btfvxgn0LwBrBXeRiMHHgHdziykUd3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZynd5DH; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725797490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFIA//LZNZFXa5gLBbDp9kzrenwYgY2aO2hf6ChFS/Y=;
	b=EZynd5DHsP7GDe9JZ3QNLDI5O6c/c86By1mI0LV0ZGnMGNcjBr3swwpHksMnEpN/3n6Glg
	W/eA5z1qewiBAyGTzSkn8tqnhTVwKFF3nFCLflD0IbYx1qeLQeyJNdA5jwoRSqFB4ny5bw
	tYRvA88+OxYWOrmcc5YtUHGA+ReQ0co=
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
Subject: [PATCH v2 3/5] drm/etnaviv: Drop the <linux/pm_runtime.h> header
Date: Sun,  8 Sep 2024 20:11:05 +0800
Message-ID: <20240908121107.328740-3-sui.jingfeng@linux.dev>
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

Currently, the etnaviv_gem_submit.c isn't call any runtime power management
functions. So drop this unused header, we can include it back when it
really get used though.

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
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
2.43.0


