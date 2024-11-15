Return-Path: <linux-kernel+bounces-410633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B79CDE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B02B1F22F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3BC1BD038;
	Fri, 15 Nov 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tEpmfXTA"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA071BD00A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674032; cv=none; b=WjF2A0EVZPxfPFuY10SdhUYaLGeT8YRrAVZQBxV3w1wiGw6Y/M1aJZZh5E0WBHYetuzwkO1TZL2r2ELB73w6+niywQNKdV7XdyYKjHxY2P2zLAwkZ72RkSmy06qd+Xl5Cep7lPwx8bYq3VydJIeUdLak+9JBMpOhsVn+sA6XI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674032; c=relaxed/simple;
	bh=QR+yyH9uPJ/OqaN5IdQwKdfdKmwO+NOSoIP1GccCk24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGBCLxVEsf83irKho7caB98CL31jQVMv7a+GmGTVMOlejIxOwoEljcE5QThkxn3K98Jy1wCHYYe9TVZt1soZGhbuap3+UFVBlMa7/3d3WTiKW06Lvax6A+3Ud6mSWfEq3myJRzKbNLb6WGQouRHF9d3ff/t/L7d0KnNnD5rkN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tEpmfXTA; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731674028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q1NNXm8xCGlaeYRhrzTJWYfqyDhwYjiiGjFlTLExYI=;
	b=tEpmfXTAbP1X+EpnZ/kMxs8+Keov1Wrn1IC2phl4qaNcaMwKv+I2ursKhEvzRdc2kLo+4M
	9jdZHHnkPlpE/CBM6tIedljxu+eVgnZ3MqJAZPS0UgV6A8+EVRV+StvEwtY+U/mufIdHmr
	+3aSAl+isWcrlvU7oIm+k2gX2fsbS7A=
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
Subject: [PATCH v3 2/3] drm/etnaviv: Fix the debug log  of the etnaviv_iommu_map()
Date: Fri, 15 Nov 2024 20:32:45 +0800
Message-Id: <20241115123246.111346-3-sui.jingfeng@linux.dev>
In-Reply-To: <20241115123246.111346-1-sui.jingfeng@linux.dev>
References: <20241115123246.111346-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The value of the 'iova' variable is the start GPUVA that is going to be
mapped, its value doesn't changed when the mapping is on going.

Replace it with the 'da' variable, which is incremental and it reflects
the actual address being mapped exactly.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index c786df840a18..ff90bf85c156 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -86,7 +86,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context,
 		unsigned int da_len = sg_dma_len(sg);
 		unsigned int bytes = min_t(unsigned int, da_len, va_len);
 
-		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);
+		VERB("map[%d]: %08x %pap(%x)", i, da, &pa, bytes);
 
 		ret = etnaviv_context_map(context, da, pa, bytes, prot);
 		if (ret)
-- 
2.34.1


