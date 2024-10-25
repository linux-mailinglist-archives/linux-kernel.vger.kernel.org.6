Return-Path: <linux-kernel+bounces-382603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F3C9B10F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833692832A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58821B85E;
	Fri, 25 Oct 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNInL612"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B021B856
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889062; cv=none; b=FrzfN/Wzu0YelnUaTUTu9I/jCgvOw9Ij7DDbDChkxzHpfcSpvlNV3FbcEt3gRLa5RLpd5LO4sXmOzoeRFuRhwg/FDW/P2dYwvOkPJFKK1cOSxZ2NAcrlxPyMo1wVKSRL3+X5Xr0pHk8CcoKBICUwDHYGXJLhnLgCloYSbp3mz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889062; c=relaxed/simple;
	bh=KH/Uc9Bqd49yQWEPvlfNuvlmh+2p+dhV8EK0vT+fBRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsCWwZ7O5Hfrf0RcnYJSSNSWOwaB78MkeuFdukwVvLp/vF8DldXJGLx58SwnIcoZ90yD/IkIz/DtI8CyWpwcR1LKK8mryqhErNd30r1TeXPKptbIaR8jfQHYiqJami8YDwWy6is7AfBP+84jwM4rrXHZVX/m+aZC9NypJVDmngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNInL612; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729889058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ztrVlzbJYDXKngabmXQa19bNYJjSoNew/4bl4Bb5+R4=;
	b=MNInL612oKc4OjrZvlDlt47LPzsAp9VZMufaTdMf4GUv0eEAjhte5Az3BebVpBDigmqlvt
	Q0se7Ax16Y0qb4YCPXoMxmsdquYWGtjtV8U5keaBcg70ZoE5S8ZqGjGj60Y34BPOoHaex9
	snZEoSHthP+31dr9WEsYgEmLlOhsBeM=
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
Subject: [PATCH v2 0/2] drm/etnaviv: Fix GPUVA range collision when CPU page size is not equal to GPU page size
Date: Sat, 26 Oct 2024 04:43:53 +0800
Message-Id: <20241025204355.595805-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Etnaviv assumes that GPU page size is 4KiB, however, when using
softpin capable GPUs on a different CPU page size configuration.
The userspace allocated GPUVA ranges collision, unable to be
inserted to the specified address hole exactly.


For example, when running glmark2-drm:

[kernel space debug log]

 etnaviv 0000:03:00.0: Insert bo failed, va: 0xfd38b000, size: 0x4000
 etnaviv 0000:03:00.0: Insert bo failed, va: 0xfd38a000, size: 0x4000

[user space debug log]

bo->va = 0xfd38c000, bo->size=0x100000
bo->va = 0xfd38b000, bo->size=0x1000  <-- Insert IOVA fails here.
bo->va = 0xfd38a000, bo->size=0x1000
bo->va = 0xfd389000, bo->size=0x1000


The root cause is that kernel side BO takes up bigger address space
than userspace assumes.

To solve this problem, we first track the GPU visible size of GEM buffer
object, then map and unmap the GEM BOs exactly with respect to its GPUVA
size. Ensure that GPU VA is fully mapped/unmapped, not more and not less.

v2:
- Aligned to the GPU page size (Lucas)

v1:
- No GPUVA range wasting (Lucas)
Link: https://lore.kernel.org/dri-devel/20241004194207.1013744-1-sui.jingfeng@linux.dev/

v0:
Link: https://lore.kernel.org/dri-devel/20240930221706.399139-1-sui.jingfeng@linux.dev/

Sui Jingfeng (2):
  drm/etnaviv: Record GPU visible size of GEM BO separately
  drm/etnaviv: Map and unmap GPUVA range with respect to the GPUVA size

 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 11 ++++----
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  5 ++++
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 36 +++++++++------------------
 3 files changed, 22 insertions(+), 30 deletions(-)

-- 
2.34.1


