Return-Path: <linux-kernel+bounces-547145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79667A5036F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD755188B623
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8352500D0;
	Wed,  5 Mar 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGA5cfTu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3B24EF77
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188411; cv=none; b=B8axRIsN5UN2t6itLq8xA9kmJB9/ULNShjQf/0ZDZUYjtiAffJDClMloJkI1tn1MzhOJ1tQc6OoMOKZXY7/90YPjDKyWrGKgeBGGoZC87MKTEEP735Yc4l3bBgdHz/Qhdn7eZd+eALuampF6h2Y+kAVOrBGc4/xJM9QEfMRiS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188411; c=relaxed/simple;
	bh=WuSs0ccIERyzfHTV1tmUgRKBiDqHcxHRwmn33redAdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws925bOKqKXXoDTxLRtXum11DAD0aJTNyMIFyi2X8sM+/MEpVttzHx7ZirJhFHhhVNbzny0YFeBYfZnITPBY7OaruBhxCvfpWkFRYMJ4XHQHfTXRaME0RWsLmZolOB99Pqzu4sk+mAyd+0pGV+Vkdab36g/VMoe5D1XKcmGZ7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGA5cfTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741188409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPtUDuBhtdSX6GhOg+XQnbMK00oSmP61u2YCpHroymk=;
	b=PGA5cfTufMu9ErdAXhMTr6aDft8iXaw0NJM04gpCnnPieCxOzJIbeCWWo9836PUGbBbY8k
	x/i8LTSsqViyLsVh1j+Aiq4yA3r0stpjinOA8diOX8gGnjo1EXc8DmCCS0o0Oy5K92j9VT
	Lso59OjGMvqUTvFvmbfYaq4knXGEwe0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-aoXS06h0MXiJv1nWrJlrzw-1; Wed, 05 Mar 2025 10:26:47 -0500
X-MC-Unique: aoXS06h0MXiJv1nWrJlrzw-1
X-Mimecast-MFC-AGG-ID: aoXS06h0MXiJv1nWrJlrzw_1741188407
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2234bf13b47so132309655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188406; x=1741793206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPtUDuBhtdSX6GhOg+XQnbMK00oSmP61u2YCpHroymk=;
        b=B1LDbmw7wGY1rE26oldylPjH07Z4hIBrlWAqT6Jvj53SaU424jFl+WwP/i2ai/fdn6
         9hfQpfVHd8KvOPDbVRHstU1FDx21/c31NWo7ubE7VYsFWOMQo6L3r8uIvJzM671oWMYn
         +irCSfESyzns2l0axjjB4+PopDJpshpA/dBNBiYkTDfppzwCoaX2h3wVJARucDiBst7i
         WUcZWlQcTEFtdeJQQqCMS9la7Cv9IFERGtWTV/DRmuNJ3UnjAbEqidigiAFP7mhGYgcS
         EZkOB0/d3g3ffxf4r7xFzML/j+Kjz3/TT9+NyU6mUh6O8qkQK0fam1HtJfeSwDZoc6Cv
         ZdOg==
X-Forwarded-Encrypted: i=1; AJvYcCWyw0XGSHiSsAvoSrxglZpGZhId8wjb/wAc3Tn4aPOZ3/WOD/KSmzqi55XUemtNlr9aNIuOJQu+wcyz1ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyM1aiXxiE4PuKhG+g8x0GD4AXvnQqsnPskpIkonlPZtogfXU
	HSCzNFmmTp3snfw0Osz2m/cfb4G+1U/FZ84tnBvDNH5X7X6x9K4GWWiEAceLVgdJTo02FTRzMAr
	JlmSkpREcxS4mr2u02t9gM8VrMM8aa70BRWUU5AgH8fLyhM1aoOspX1L/zOreAA==
X-Gm-Gg: ASbGncswwZTw/+KP2nUE0IjY93E+UZysbWstLl0TWIdNjh/IbTAvDiUgTNfC92MY+Ct
	sZZvMh3bGacx05DsPvIC2LwIXsl+fRmiDZLXERGDRUYadm/vMKTgdjaAWHn708yjGforHtCqEsE
	E3TQzFR5hRRkew85tlazobTIXCgYh2VeAjRCb4OtSSsBtdR57teKjnewOUTKl1+oNJB0HY/II9f
	bOt93ncsHE826/HZ72C5YXVfFthAuEME2dO1DFhs2EM30ipxtD9lFDVLb0ytajS1Q/GpmiKCPpS
	bWNBJUTakCHkAcXO
X-Received: by 2002:a05:6a00:998:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73682b55144mr6706588b3a.3.1741188406436;
        Wed, 05 Mar 2025 07:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECYyXVd+Gb6leHDb5NO82ag7tQipklHOXKqXQqY4fydYrcJZzPu+CjaBp7aum4qt8U11Vpow==
X-Received: by 2002:a05:6a00:998:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73682b55144mr6706526b3a.3.1741188406066;
        Wed, 05 Mar 2025 07:26:46 -0800 (PST)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364b4eff66sm6983292b3a.83.2025.03.05.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:26:45 -0800 (PST)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	dmitry.osipenko@collabora.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH drm-next 2/2] drm/virtio: Use atomic_vmap to work drm_panic in GUI
Date: Thu,  6 Mar 2025 00:25:54 +0900
Message-ID: <20250305152555.318159-3-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305152555.318159-1-ryasuoka@redhat.com>
References: <20250305152555.318159-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio drm_panic supports only vmapped shmem BO because there is no
atomic vmap feature. Now atomic_vmap is supported, so drm_panic tries to
vmap addr if it is not mapped.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/drm_gem.c              | 51 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_gem_shmem_helper.c | 51 ++++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 14 +++++--
 include/drm/drm_gem.h                  |  1 +
 include/drm/drm_gem_shmem_helper.h     |  2 +
 5 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index ee811764c3df..eebfaef3a52e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -535,6 +535,57 @@ static void drm_gem_check_release_batch(struct folio_batch *fbatch)
 	cond_resched();
 }
 
+struct page **drm_gem_atomic_get_pages(struct drm_gem_object *obj)
+{
+	struct address_space *mapping;
+	struct page **pages;
+	struct folio *folio;
+	long i, j, npages;
+
+	if (WARN_ON(!obj->filp))
+		return ERR_PTR(-EINVAL);
+
+	/* This is the shared memory object that backs the GEM resource */
+	mapping = obj->filp->f_mapping;
+
+	/* We already BUG_ON() for non-page-aligned sizes in
+	 * drm_gem_object_init(), so we should never hit this unless
+	 * driver author is doing something really wrong:
+	 */
+	WARN_ON((obj->size & (PAGE_SIZE - 1)) != 0);
+
+	npages = obj->size >> PAGE_SHIFT;
+
+	pages = kmalloc_array(npages, sizeof(struct page *), GFP_ATOMIC);
+	if (pages == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	mapping_set_unevictable(mapping);
+
+	i = 0;
+	while (i < npages) {
+		long nr;
+
+		folio = shmem_read_folio_gfp(mapping, i,
+				GFP_ATOMIC);
+		if (IS_ERR(folio))
+			return ERR_PTR(-ENOMEM);
+		nr = min(npages - i, folio_nr_pages(folio));
+		for (j = 0; j < nr; j++, i++)
+			pages[i] = folio_file_page(folio, i);
+
+		/* Make sure shmem keeps __GFP_DMA32 allocated pages in the
+		 * correct region during swapin. Note that this requires
+		 * __GFP_DMA32 to be set in mapping_gfp_mask(inode->i_mapping)
+		 * so shmem can relocate pages during swapin if required.
+		 */
+		BUG_ON(mapping_gfp_constraint(mapping, __GFP_DMA32) &&
+				(folio_pfn(folio) >= 0x00100000UL));
+	}
+
+	return pages;
+}
+
 /**
  * drm_gem_get_pages - helper to allocate backing pages for a GEM object
  * from shmem
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 5ab351409312..789dfd726a36 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -186,6 +186,34 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
 
+static int drm_gem_shmem_atomic_get_pages(struct drm_gem_shmem_object *shmem)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	struct page **pages;
+
+	pages = drm_gem_atomic_get_pages(obj);
+	if (IS_ERR(pages)) {
+		drm_dbg_kms(obj->dev, "Failed to get pages (%ld)\n",
+			    PTR_ERR(pages));
+		shmem->pages_use_count = 0;
+		return PTR_ERR(pages);
+	}
+
+	/*
+	 * TODO: Allocating WC pages which are correctly flushed is only
+	 * supported on x86. Ideal solution would be a GFP_WC flag, which also
+	 * ttm_pool.c could use.
+	 */
+#ifdef CONFIG_X86
+	if (shmem->map_wc)
+		set_pages_array_wc(pages, obj->size >> PAGE_SHIFT);
+#endif
+
+	shmem->pages = pages;
+
+	return 0;
+}
+
 static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
@@ -317,6 +345,29 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL(drm_gem_shmem_unpin);
 
+int drm_gem_shmem_atomic_vmap(struct drm_gem_shmem_object *shmem,
+			      struct iosys_map *map)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	int ret = 0;
+
+	pgprot_t prot = PAGE_KERNEL;
+
+	ret = drm_gem_shmem_atomic_get_pages(shmem);
+	if (ret)
+		return -ENOMEM;
+
+	if (shmem->map_wc)
+		prot = pgprot_writecombine(prot);
+	shmem->vaddr = atomic_vmap(shmem->pages, obj->size >> PAGE_SHIFT,
+				   VM_MAP, prot);
+	if (!shmem->vaddr)
+		return -ENOMEM;
+	iosys_map_set_vaddr(map, shmem->vaddr);
+
+	return 0;
+}
+
 /*
  * drm_gem_shmem_vmap - Create a virtual mapping for a shmem GEM object
  * @shmem: shmem GEM object
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a6f5a78f436a..2a977c5cf42a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -500,11 +500,19 @@ static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
 
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
 
-	/* Only support mapped shmem bo */
-	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo->base.vaddr)
+	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
 		return -ENODEV;
 
-	iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
+	/* try to vmap it if possible */
+	if (!bo->base.vaddr) {
+		int ret;
+
+		ret = drm_gem_shmem_atomic_vmap(&bo->base, &sb->map[0]);
+		if (ret)
+			return ret;
+	} else {
+		iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
+	}
 
 	sb->format = plane->state->fb->format;
 	sb->height = plane->state->fb->height;
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index fdae947682cd..cfed66bc12ef 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -529,6 +529,7 @@ void drm_gem_free_mmap_offset(struct drm_gem_object *obj);
 int drm_gem_create_mmap_offset(struct drm_gem_object *obj);
 int drm_gem_create_mmap_offset_size(struct drm_gem_object *obj, size_t size);
 
+struct page **drm_gem_atomic_get_pages(struct drm_gem_object *obj);
 struct page **drm_gem_get_pages(struct drm_gem_object *obj);
 void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 		bool dirty, bool accessed);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index d22e3fb53631..86a357945f42 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -105,6 +105,8 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
+int drm_gem_shmem_atomic_vmap(struct drm_gem_shmem_object *shmem,
+			      struct iosys_map *map);
 int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 		       struct iosys_map *map);
 void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
-- 
2.48.1


