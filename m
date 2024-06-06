Return-Path: <linux-kernel+bounces-203473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377E8FDBB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CDC1C22049
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216C15E86;
	Thu,  6 Jun 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dWkSFehK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B06EADB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635279; cv=none; b=ObEQo/uPTAmZhYHx674hBafWwiVT6qugtbssFQ17YkiX3EG9yvTwcYq5rQ3WTjc6nAiz0TXXFFPVjqN+3fuOGrkh59d0GYy4Qulb521UFWimfvRVgGUAeK6M2kfaI0A/GJmbyug0Kf2KnTa5yv/4XtPaaK9jx2azxAFhzLJBYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635279; c=relaxed/simple;
	bh=W6+fKkwiKj7jkrWNiLK7Di5xDu00iWwL2FcgQlq27e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXjxgUo5gfBRzfezJ9/TR9OhhjTn8oEUP9bNBRj8/BforZqbTazha+vSQjoU6LcbmfT0CCoE55LLLKiUETki2Qxi4s9k3As9gvpGqEwHzpqiNr+JbTZU+Wt6NfUuQwj9BHErnfaG4r/P7D7K1cluHELDIcAsa7EBJDKYBkBttnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dWkSFehK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717635276;
	bh=W6+fKkwiKj7jkrWNiLK7Di5xDu00iWwL2FcgQlq27e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWkSFehKMFUbMMKxfTSll4Ax1REogqR1FTHkqvOLQ7YAJMGaWkqsBqe1oEedGDsjC
	 E4iV4GHhHwD24rGRVayr0JQeMdrZesSsG7MMn9dUi/U7QhNfEn+eq1cIBCAgSrHbYy
	 u1hxPBjB1TM9o3pymi8+t8iUyS2sHSYck5uF8QbbOKIqheeB3tgy95XLS4pig2HNqn
	 pfZf9pxOYj0j2fgOE+xOhyLed6q5ZfNpXvNVfxW6wNb5FwxQ1Oud775b6SQ7EgDzoz
	 Vf4rDeAMYkEd0bfb2HJv7Dgm967b/BZKnFCpscnZn4VQwpJgCPxbmtcLITNYhGqE93
	 GLMVel8y0xTig==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E09C737821CF;
	Thu,  6 Jun 2024 00:54:35 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] drm/panthor: enable fdinfo for memory stats
Date: Thu,  6 Jun 2024 01:49:55 +0100
Message-ID: <20240606005416.1172431-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
References: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement drm object's status callback.

Also, we consider a PRIME imported BO to be resident if its matching
dma_buf has an open attachment, which means its backing storage had already
been allocated.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 38f560864879..c60b599665d8 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -145,6 +145,17 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
 	return drm_gem_prime_export(obj, flags);
 }
 
+static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
+{
+	struct panthor_gem_object *bo = to_panthor_bo(obj);
+	enum drm_gem_object_status res = 0;
+
+	if (bo->base.base.import_attach || bo->base.pages)
+		res |= DRM_GEM_OBJECT_RESIDENT;
+
+	return res;
+}
+
 static const struct drm_gem_object_funcs panthor_gem_funcs = {
 	.free = panthor_gem_free_object,
 	.print_info = drm_gem_shmem_object_print_info,
@@ -154,6 +165,7 @@ static const struct drm_gem_object_funcs panthor_gem_funcs = {
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = panthor_gem_mmap,
+	.status = panthor_gem_status,
 	.export = panthor_gem_prime_export,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
-- 
2.45.1


