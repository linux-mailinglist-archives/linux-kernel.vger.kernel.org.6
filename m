Return-Path: <linux-kernel+bounces-563157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69517A6379C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A9516A5AA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641D1F4621;
	Sun, 16 Mar 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Jzmb8SO4"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08419995D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161988; cv=pass; b=UHKLlTfnthnSvEZSJOtPN03vDPc2cJw4JdQne99fhHZ1yR5y0+ussyyJB3bSHdv2IsGD1eLE2sQi/0OAT56SJ9mbGSCVc6vg2E3MlLyx01VXEps5P1LQkqpJMtb+jBygI0LyHP+w9abPvS3lARb+NCvrlb8zwhtNRUmIdQHRPUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161988; c=relaxed/simple;
	bh=Mt3lHxw/nvndQlZIRd0DEQ2FzxN8ZKa/CoMI9TV8xDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC03tqkh1jUf1EPwPbbvQigiSO/Ie75X/DN1Zuc1feMqFoqk2H+QnfbAsNLwwQ7SyUUTzhsaEzB+Y6kW/f5avh/uV/mYyG++EEkwDvKFrhfdzc7X09Un+qSpypjpqpCYYOt5a1plNZ7RmU5zwTxOY34JmPVblM+xc1bVXvqEO8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Jzmb8SO4; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742161960; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Kv2Cv4vpik/j+OEvF9mZ0YidfvENvnjzVEFCR5ufXdaoOdcgvbWXsn2DOHeYF3OEtjooSlbzwCaArB5Kh+o2y6Y2DmPkmWisi68nKLAwR9PflHb0DHOiTyvcSwljLf13yW1I6jwVvfBTCy9UmNfycr51lw+HtkhboHoyjV0EXBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742161960; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7d7KId3eYtW4KxggvAfj0Ppw7ovEqEyqSgz/eR3xla8=; 
	b=kH0jH7NZdKuuOncD3Q4ME5zBe+Pk6IjmXEnaF2QkQTxJuWTK+OFS49L2EWMDWHaY7fyUi7zKO6m94xi2Bif+cq1rolz5jrnbQTfLN44wDfeGAv9pGKeZVRMpYL/4rF5DAkWjoG6ufOUziPlhnAeNDSWZbMNtYDEKms3HRSWw9ZQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742161960;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7d7KId3eYtW4KxggvAfj0Ppw7ovEqEyqSgz/eR3xla8=;
	b=Jzmb8SO4HRmFqRQhMGwQk+G2MN082zroHITg6EUjjBMUohtzCryVDwy7hGnuYm65
	vYUdK7xOB9TycwHHNUD9021LAegaMyVnRaK0DYpmjNd+9dnRHZEmJzrfVCZqRe4LrdP
	SM6ZK+sUZz3YxPOR/67isuw7QzL+yr+ArE/7Hm5Q=
Received: by mx.zohomail.com with SMTPS id 1742161957836488.8141758461478;
	Sun, 16 Mar 2025 14:52:37 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/panthor: Display heap chunk entries in DebugFS GEMS file
Date: Sun, 16 Mar 2025 21:51:35 +0000
Message-ID: <20250316215139.3940623-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Expand the driver's DebugFS GEMS file to display entries for the heap
chunks' GEM objects, both those allocated at heap creation time through an
ioctl(), or in response to a tiler OOM event.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index db0285ce5812..520d1fcf5c36 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -139,6 +139,10 @@ static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
 	struct panthor_heap_chunk *chunk;
 	struct panthor_heap_chunk_header *hdr;
 	int ret;
+#ifdef CONFIG_DEBUG_FS
+	struct panthor_gem_object *obj;
+	const char *label;
+#endif
 
 	chunk = kmalloc(sizeof(*chunk), GFP_KERNEL);
 	if (!chunk)
@@ -180,6 +184,17 @@ static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
 	heap->chunk_count++;
 	mutex_unlock(&heap->lock);
 
+#ifdef CONFIG_DEBUG_FS
+	obj = to_panthor_bo(chunk->bo->obj);
+
+	mutex_lock(&ptdev->gems_lock);
+	list_add_tail(&obj->gems_node, &ptdev->gems);
+	mutex_unlock(&ptdev->gems_lock);
+
+	label = kstrdup_const("\"Tiler heap chunk\"", GFP_KERNEL);
+	panthor_gem_label_bo(chunk->bo->obj, label);
+#endif
+
 	return 0;
 
 err_destroy_bo:
-- 
2.48.1


