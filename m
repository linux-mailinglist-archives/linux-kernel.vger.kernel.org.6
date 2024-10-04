Return-Path: <linux-kernel+bounces-351344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46257990FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7DD282A9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A901E0493;
	Fri,  4 Oct 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gs+lwkXa"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DF1DFDBA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070963; cv=none; b=Mk7OgBO1OLKNkTWjlHZyATtG/9eMj76OZ0RxCl04JuelWWdXhxwIx5ppcvad65LMT4mgovtigTTwCcXnqfU1iPm245NTCsHe01MdDJNwZkvj4uC/Rgtqw1a3Ku8dUklvBIK3+2LEiDkDr0rxAHBl5hB0EJMrHbQFvSTaGpxejv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070963; c=relaxed/simple;
	bh=joHc5d6HhG9WMAEvUcuvZ4bj4d9zFNpkenhSe597ZEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goAD9v91WXMLTR74dCn9XqB0X9hETviGbaYJdfvmIRKyA10TRRdwAovcwW+liPFptW/ghkwltZyCD0LcoddvtdJ/9iTK4+Bf2YEm2F5kwwYanQ9ip2qevukR5mL2SwCO8UPU3BlsA6oG4QXzi3XVT1VLIS/G7tbS3llkBUrpmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gs+lwkXa; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728070960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4HgvyzfgIepFwk/c9SOPAgoWvUuHNu+CqXfvHDy0mU=;
	b=Gs+lwkXaylIbGwOi83yonCCU74a+DnJS+lLO3LOg8JVomMmh3rKEfwPLFJ6I5myPUo8Yxh
	KR14ry7JUwenza/SPTQz8gWh1yF8sedOFXPKMcjjo4dFpIYlufLht/eQGVHoyuczOD9pP6
	0Imgtt3nhEO5HL509c8EBguyuDUO0is=
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
Subject: [PATCH 3/3] drm/etnaviv: Print an error message if inserting IOVA range fails
Date: Sat,  5 Oct 2024 03:42:07 +0800
Message-Id: <20241004194207.1013744-4-sui.jingfeng@linux.dev>
In-Reply-To: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
References: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Print an error message to help debug when such an issue happen, since it's
not so obvious.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
v0 -> v1: Use dev_err_ratelimited() to prevent spamming the logs

v0 is at https://lore.kernel.org/dri-devel/20240930221706.399139-1-sui.jingfeng@linux.dev/
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index a52ec5eb0e3d..37866ed05c13 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -300,8 +300,12 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 		ret = etnaviv_iommu_insert_exact(context, node, user_size, va);
 	else
 		ret = etnaviv_iommu_find_iova(context, node, user_size);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err_ratelimited(context->global->dev,
+				    "Insert iova failed: 0x%llx(0x%x)\n",
+				    va, user_size);
 		goto unlock;
+	}
 
 	mapping->iova = node->start;
 	ret = etnaviv_iommu_map(context, node->start, user_size, sgt,
-- 
2.34.1


