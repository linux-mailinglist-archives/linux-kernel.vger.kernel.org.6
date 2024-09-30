Return-Path: <linux-kernel+bounces-344920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092098AFBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330921C20F46
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34B4188596;
	Mon, 30 Sep 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZLoTrfJ"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562229429
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734648; cv=none; b=mBo1QiAX6SHfspr86cey6RrfEKUzeviLLTpOSZLeDT0RII2TkZZpHRYOM59hNht/xtSE48Tgbjmorjpr46SMuQ7zvlBo47qbrhN071xHxS6QwkY0ZTnny/eVU4KePNyQuEKtLoAMLzs6c6gEob/c3pdnxwYzY3ml5s9OLLwji/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734648; c=relaxed/simple;
	bh=PyNiT461wE+KoBkKnNpv87SxsxhghQTGG9V/03xpa/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtcTgYX19GjYxaQwLyEv2Hv5cm9PhGAUqNlJVSSV25Ub03QEnlDF7+tOOBZ6nsSlqigSkdLG8b3BwuUg5okl+7rtGT1C9HbC0s979siWjsipC5VRubeSC85oV48TPW5Scynh2As1+JwLgMbNf3o5Zn+3jeTOHR3QJix9Y+10skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZLoTrfJ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727734640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y4YstUzFg6ou6O0nN1/xveTy1frOB8d3+83QVeA1OZk=;
	b=qZLoTrfJ1AIsNSTjv69oocKO6STCrG8uB0KYkjDrXGA6S1Kc4Fmz3QZyEzS01TJ/z4mLRw
	3+oNuUZ6T6Od4yvdQt9KSQno8NMyYKhXCLwMiSNzL/I9JAI37kXvmk55uyuAn+SFomxL9U
	Rw3S5w2pdXvBctWLa0tTbPieif37M14=
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
Subject: [PATCH] drm/etnaviv: Print error message if inserting IOVA address range fails
Date: Tue,  1 Oct 2024 06:17:06 +0800
Message-Id: <20240930221706.399139-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Etnaviv assumes that GPU page size is 4KiB, yet on some systems, the CPU
page size is 16 KiB. The size of etnaviv buffer objects will be aligned
to CPU page size on kernel side, however, userspace still assumes the
page size is 4KiB and doing allocation with 4KiB page as unit. This
results in softpin(userspace managed per-process address spaces) fails.
Because kernel side BO takes up bigger address space than user space
assumes whenever the size of a BO is not CPU page size aligned.

Insert an error message to help debug when such an issue happen.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
For example, when running glmark2-drm:

[kernel space debug log]

 etnaviv 0000:03:00.0: Insert bo failed, va: fd38b000, size: 4000
 etnaviv 0000:03:00.0: Insert bo failed, va: fd38a000, size: 4000

[user space debug log]

bo->va = 0xfd48c000, bo->size=100000
bo->va = 0xfd38c000, bo->size=100000
bo->va = 0xfd38b000, bo->size=1000   <-- Insert IOVA fails started at here.
bo->va = 0xfd38a000, bo->size=1000
bo->va = 0xfd389000, bo->size=1000

[texture] texture-filter=nearest:MESA: error: etna_cmd_stream_flush:238: submit failed: -28 (No space left on device)
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index 1661d589bf3e..682f27b27d59 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -310,8 +310,12 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 	else
 		ret = etnaviv_iommu_find_iova(context, node,
 					      etnaviv_obj->base.size);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(context->global->dev,
+			"Insert iova failed, va: %llx, size: %zx\n",
+			va, etnaviv_obj->base.size);
 		goto unlock;
+	}
 
 	mapping->iova = node->start;
 	ret = etnaviv_iommu_map(context, node->start, sgt,
-- 
2.34.1


