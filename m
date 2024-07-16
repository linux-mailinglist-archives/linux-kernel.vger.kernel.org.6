Return-Path: <linux-kernel+bounces-254399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22129332C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8261C2228F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF91A0AEB;
	Tue, 16 Jul 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xi7Yusg8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085E1A08B0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160799; cv=none; b=YiXSn4zZ0RxAHPOsxbUydtKh6CWVnSoVoW3OigssKY2DVIBt75o9NlJirn/Znv2j0WQGNSjeeALpL0458369dU5douivbcIltwl2SoQwcA4dXEbt7VE9fZn4jlLt86Sfgd6cZ1ZkSataNd/RNUGn/+efpS1m7B+y1jDqTsVlgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160799; c=relaxed/simple;
	bh=W6+fKkwiKj7jkrWNiLK7Di5xDu00iWwL2FcgQlq27e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NagQcfiwJbF+TJyqG9hSg++IT2aAh4BNo7vpm/rRsTIPP8YLh/3jIxYfUTEA9wNCmtHJWPL61tir10tevY+NrM95AgBpkPBhBCfttjFmK1y19nThI17siMhhiSMDdpryce6z78pdEQyFGoy9wvLfbCRp9iCoynxA8GGcYXqSnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xi7Yusg8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721160795;
	bh=W6+fKkwiKj7jkrWNiLK7Di5xDu00iWwL2FcgQlq27e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xi7Yusg8xaHYfx2kNeTxdyM6cgRA30064EioO8O45NGy6Cs3EU5o4NgITHeGZub42
	 UMRNfuJDIBHA170FyYMXqSujU+75f8XI340VuUAd/JvRKWedpBKvg+eCm/gbapGyhe
	 7whGSjgJg24BOT9YaiigzWkHbV52MR7CX6fNMrOIO3DZSSYjXeD3WIEAmuzYrQAK55
	 0ugRKWw4mTLzorVn2IiWLLjk7JX3MOn9hQgwtgXAtg8s3hmJxG4UdSLS9jF/0lxIVu
	 hfCPx5W7UN21tQe/Ap1JBoaW4fgmGQz8fABnMCjNaM79rSlUlUjM+DVZ+4aaErTpBc
	 d67EDlePlfJVg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3A91037821DF;
	Tue, 16 Jul 2024 20:13:15 +0000 (UTC)
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
Subject: [PATCH v4 3/4] drm/panthor: enable fdinfo for memory stats
Date: Tue, 16 Jul 2024 21:11:42 +0100
Message-ID: <20240716201302.2939894-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
References: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
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


