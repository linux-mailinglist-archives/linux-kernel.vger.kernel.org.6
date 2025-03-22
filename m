Return-Path: <linux-kernel+bounces-572660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA49A6CCBE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B53172E10
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283C23907E;
	Sat, 22 Mar 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="XZytbpnY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80385481A3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679005; cv=pass; b=o+RAYdBbyCGrIG8vjAdXxIkd1iMHVUVfKDwbwUtlEVy1YGUvHWoYiWe57lwiIybx4sL2r6zY/ovF2inuUopVMDKAN1AsD8QfnV4FvRa+h5iFlMpEO0uh5MfOu6K3/pM7iW56suUGQvkEPmAFbHIXjqXuAkOONPKBL1uIVmA6afM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679005; c=relaxed/simple;
	bh=IU+2xeAyIoWfDNw1+gmyJoWuDUbWBOrnfPEj/xjdAwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVAkSaWDLS6t1aV3FL/c6MHiIvCVqbhrMWC85I18HXKIFdkR986Hj+xfeTHgo3TUEhF/ejlDicv/4IF+k+QXQ+W1OcSyE80/Hw54JvVCdqzROw1aU6Zcc3Aw4N8CQI5nlSqKls84w1abJP+n26I4sg7MNCP1Zk35ax8cyUeTdPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=XZytbpnY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742678984; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SSq54ZSfhyVl0NZa6xQbAOU/zjdSvJkBbCCjNiNw888T3tBI1aIkDgu5gbb+PCGrYfwqh7b7w9/wFBjvCHNHWDBaG89Xv9BfVztEX4tR8WUNlm8Joy1iL30E0uq0T+DIz+Z0x5y0Fm0gVCTzVD4C0wCxRQGiUxxx/Yjgt3KGeCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742678984; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LZhuSt1JyOcqupf4blKAAjBgaNXocdvNqctALCAsuBY=; 
	b=EyomSBCuSAbzn0ze5ycGEcm8tqGYzCnxOV6A+a+ZuFkexIbwSmVKrPZkF58Ur4SfTB1IBRTrFtrTd+oMWtvRe8P3pOj8fsvQHKfi+qBFLPyohPv6dt1a6vzG22IhnwM5nqbMPO/cMawjQt47AWVkHSYosOKcIMlRhO5hOgt2l0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742678984;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LZhuSt1JyOcqupf4blKAAjBgaNXocdvNqctALCAsuBY=;
	b=XZytbpnYRD9qONDRZrySEHeLnDdAdOWzgiGkX5Aj1Wzst5Q46dGa7UNjwMWcJI84
	i2IyAz1/eA39Q4tSZsP/7huUFIUaqx3zTrx5fgs+/wRLoZcRszkFcTECR0pOxxsNjk0
	95u8XDeTiNObK5griP2mfYQSbBI0a6ojrDx0GXWc=
Received: by mx.zohomail.com with SMTPS id 1742678980476164.7530987685443;
	Sat, 22 Mar 2025 14:29:40 -0700 (PDT)
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
Subject: [PATCH v20 09/10] drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
Date: Sun, 23 Mar 2025 00:26:07 +0300
Message-ID: <20250322212608.40511-10-dmitry.osipenko@collabora.com>
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

The vmapped pages shall be pinned in memory and previously get/put_pages()
were implicitly hard-pinning/unpinning the pages. This will no longer be
the case with addition of memory shrinker because pages_use_count > 0 won't
determine anymore whether pages are hard-pinned (they will be soft-pinned),
while the new pages_pin_count will do the hard-pinning. Switch the
vmap/vunmap() to use pin/unpin() functions in a preparation of addition
of the memory shrinker support to drm-shmem.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 +++---
 include/drm/drm_gem_shmem_helper.h     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 6fb96e790abd..84a196bbe44f 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -360,7 +360,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 			return 0;
 		}
 
-		ret = drm_gem_shmem_get_pages_locked(shmem);
+		ret = drm_gem_shmem_pin_locked(shmem);
 		if (ret)
 			goto err_zero_use;
 
@@ -383,7 +383,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 err_put_pages:
 	if (!drm_gem_is_imported(obj))
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 err_zero_use:
 	shmem->vmap_use_count = 0;
 
@@ -420,7 +420,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 			return;
 
 		vunmap(shmem->vaddr);
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 	}
 
 	shmem->vaddr = NULL;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 3a4be433d5f0..8b9bba87ae63 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -130,7 +130,7 @@ int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv);
 static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem)
 {
 	return (shmem->madv > 0) &&
-		!shmem->vmap_use_count && shmem->sgt &&
+		!refcount_read(&shmem->pages_pin_count) && shmem->sgt &&
 		!shmem->base.dma_buf && !drm_gem_is_imported(&shmem->base);
 }
 
-- 
2.49.0


