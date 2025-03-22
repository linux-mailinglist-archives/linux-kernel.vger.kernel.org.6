Return-Path: <linux-kernel+bounces-572652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1AA6CCB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B5E18964EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFB2356C3;
	Sat, 22 Mar 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="cJX8QWM2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2B23535E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678976; cv=pass; b=VFHNdNXpZaHVbGan+a89rtxjrbnkOgew2IwGytQ6ku5gT1s8LObYNpQJBKIjydgUvq/PaK8/nz8r9T1KtzaCl0zSVYrNJRgHrKiX4gg44s2XAyM13wIO+yTitskEMV5tTaq60A5W5KaHaGKjmjbk4stCTAERmCZbjJejugt1a0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678976; c=relaxed/simple;
	bh=Uh9RPQ87tYeVB1bi8SmQ5YEdI3HjH7dnQ/k0r4MKxtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHAavyqKhpfAQSRGVttddDfmlgj66KaSyWE7qomlfLfpE73/KEdiGNRw8zZjXDSJk8RHeaugtV4qqRpQoXPWt1FJktcZ7L3Kou6CHzSTreXH2Pmh5omuXjPFXxD+S+3ii7AcSOrh+tSJtJ4dg4e6oel23YIuFuScfTedDMjWOrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=cJX8QWM2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742678957; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PxmBOtoUQ1rdT24uVCjGSSfEHPsdKqi2aGZFFk1fnQgmup2R5/mxjL6vNn7+k76Jbt8pp8o9FfTIaNnzRYWDQ4I+Wbavqy89VryRuy7Nn9d+yD32ovpQ4rOtBzJO6jf4oYMvH/BfKzUpLVTIwBILrnmdTeOcuJHF7WoivAlgmOE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742678957; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fdyz8/DZzJvpb8TDk4Fb/UsrzBg8Xohwoz871V+3KR4=; 
	b=Kk5f9XbQFmuC3CW3fnM9xE0uUf5+J6hG8u3S7S+8PzLxKvWmxpQQJ5/VUDn2e5orJmz1sLYkSoDDxlg2DBLxbsX+jmVe+drLWSp0F2KocFPPIwdP8hIDzKJvWAx7OC5BsbeedEW/gmC0RJEEaXEzP2/nPOqbwkF/rPZEt85vc9E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742678957;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fdyz8/DZzJvpb8TDk4Fb/UsrzBg8Xohwoz871V+3KR4=;
	b=cJX8QWM2khneIW0/ZGr/a4js75Fvi903tqM5LrGDKlxr+MEiVS3y11bGLoBJu6JQ
	O6PsfQnHges5OnWNeuCpoUwoBu2lUyVYFzjzRgxXBRczC8+MPcXUbE9S45nmpnHhL82
	DKN1pIORw7EXgp1hFlYVAqKnsMutSwRUM8gvW558=
Received: by mx.zohomail.com with SMTPS id 1742678957017363.1392509416396;
	Sat, 22 Mar 2025 14:29:17 -0700 (PDT)
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
Subject: [PATCH v20 03/10] drm/gem: Document locking rule of vmap and evict callbacks
Date: Sun, 23 Mar 2025 00:26:01 +0300
Message-ID: <20250322212608.40511-4-dmitry.osipenko@collabora.com>
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

The vmap/vunmap/evict GEM callbacks are always invoked with a held GEM's
reservation lock. Document this locking rule for clarity.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/drm/drm_gem.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 43cf3c2c7ca0..9b71f7a9f3f8 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -159,7 +159,8 @@ struct drm_gem_object_funcs {
 	 * @vmap:
 	 *
 	 * Returns a virtual address for the buffer. Used by the
-	 * drm_gem_dmabuf_vmap() helper.
+	 * drm_gem_dmabuf_vmap() helper. Called with a held GEM reservation
+	 * lock.
 	 *
 	 * This callback is optional.
 	 */
@@ -169,7 +170,8 @@ struct drm_gem_object_funcs {
 	 * @vunmap:
 	 *
 	 * Releases the address previously returned by @vmap. Used by the
-	 * drm_gem_dmabuf_vunmap() helper.
+	 * drm_gem_dmabuf_vunmap() helper. Called with a held GEM reservation
+	 * lock.
 	 *
 	 * This callback is optional.
 	 */
@@ -192,7 +194,8 @@ struct drm_gem_object_funcs {
 	 * @evict:
 	 *
 	 * Evicts gem object out from memory. Used by the drm_gem_object_evict()
-	 * helper. Returns 0 on success, -errno otherwise.
+	 * helper. Returns 0 on success, -errno otherwise. Called with a held
+	 * GEM reservation lock.
 	 *
 	 * This callback is optional.
 	 */
-- 
2.49.0


