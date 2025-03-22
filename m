Return-Path: <linux-kernel+bounces-572656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3CA6CCB8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50A23AB13C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFEA23716F;
	Sat, 22 Mar 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Bzb8p2WH"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05723536B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678989; cv=pass; b=Vtg9gfaKQMA8b9ThLfv13V4xxVUjYNxLfX3WvRnpRbUJm4zjUXOcK3LDcyObOZ3CEdtqcraG+F1022I80wuVjnPS1QilPsHBf/sHIc4v9Zsj4LCQqvldrgPWQ9a4hPClDRtCseJVaulqBRUinUZ6e1Nk8JNiBmYe20iJVIad0/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678989; c=relaxed/simple;
	bh=tNIVmmqvdn0BbSGupXXauZbKEV8m5jRAzxUwA3qwYTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH6eq9F0wBZhgP020gNfXG1r5y2JTvR9w7P3Tv0Z3U8Br4Kvj6UGjRWKp5wCFsHe4mFahRciyGuPIPgrRiD9tYDCUnxwykfSpTMKl776ywb384wPWbPEk4oSoHYDcEDBauGR62jqsSA37ZMlDdLESqX/q1AxMPpO5rZjlY+1hyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Bzb8p2WH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742678969; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MObpe1hBvD+xE6c61j/lE28XU2aNW9N1v/0/JqDaqcjfWfigMH378voLegXJqNuBtPI2F2ezXa+JuKSTMF6bl6Q9mJ1rx6GHyAa5YSfr8o6B7fzVw2vZjoBv9ZAK2tAFAWdMVawjXZOtDJ6KsD4riUmraHl0/v3bx6TN56OUdK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742678969; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q83oIT0cBFEw1AlNTa7hMxOMQ+6roqL+ZBBn36G+JnQ=; 
	b=g1dF3qzKNjywQ+iM3zPIuCRb+f/RYcGa7lTQFPEs6b6WB7VvgJXAXqM7qgx1l9frZhq+FZbONIj5EKMfJEHqYxAtuBczs0qkpXfJZl34OnTdjlSQJCOIYLFmXboi+34FNS6eyq4YxR1k9/OVunoqHjgt0OBbN7YQXcr4f7zUnbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742678969;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q83oIT0cBFEw1AlNTa7hMxOMQ+6roqL+ZBBn36G+JnQ=;
	b=Bzb8p2WHAc+9CedgTOqFDrYVwzoVr+pRI9CPz1FFyxdDEN7jsqbhgYaqeQLU0QQr
	A/G+Tk1I2Mr5SD9I1k4sl3Cdncq9VwFeNfhIHCp61qlzRMBkHRTDiLQdA9ICKcYm/Ok
	lZLpbHvbPjB8NUQe1Yw7jwwk6Q7NIv/n+rnS3EZA=
Received: by mx.zohomail.com with SMTPS id 1742678968659230.70139866836757;
	Sat, 22 Mar 2025 14:29:28 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v20 06/10] drm/shmem-helper: Remove obsoleted is_iomem test
Date: Sun, 23 Mar 2025 00:26:04 +0300
Message-ID: <20250322212608.40511-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
References: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Everything that uses the mapped buffer should be agnostic to is_iomem.
The only reason for the is_iomem test is that we're setting shmem->vaddr
to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
the obsoleted is_iomem test to clean up the code.

Acked-by: Maxime Ripard <mripard@kernel.org>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index a9e35a46e72b..277e792a0c5c 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -340,12 +340,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 	if (drm_gem_is_imported(obj)) {
 		ret = dma_buf_vmap(obj->dma_buf, map);
-		if (!ret) {
-			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
-				dma_buf_vunmap(obj->dma_buf, map);
-				return -EIO;
-			}
-		}
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
-- 
2.49.0


