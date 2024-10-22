Return-Path: <linux-kernel+bounces-377119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E789ABA17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C511F2425C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90E1CF5DD;
	Tue, 22 Oct 2024 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="OUIYYQbg"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0A1CDA2F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639791; cv=none; b=JoXmUvB3knPX723H9EnGG+y4wjei/8T3PvHbrjJ6boVdF25ng3lHsMUjhqdkuKo5QJPKCxC+EKmiGdE1X0zmnxs4v8CMpuj2RzbDupcLGrsDYQJjBGnpX3gRfXiWr6IoPRwH6jwItuQCLowux4JchBib0JFeG01N1warBsT+DEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639791; c=relaxed/simple;
	bh=yUlmEOi8he0CHjUDEoe0RYuVN90weGzbpTqC9SIDu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMOi2jVdAKFzarp+LPkRYitfaOPYhStmHsArdg01k/k0Do/kL/FlXOdlFMfFSEtIrXMz+xIw0Ig0A/IpaavZhUu5tvfDEsQP9cJcWxbZOQGldBESsdH0+u+6C3PyktVHj+ewcvRdU3brvA4BaDXg1uIjsLdda7CktT0Zb3915+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=OUIYYQbg; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=uJcBaImOo4siGqiQ+8KKjL3HddlpCKbwDdzxJEsT5x8=; b=OUIYYQbgjqSlig6k
	LCDpUXf/3m5d9Sm+jqdQJhaS757yJJcaVu/Yj3W89q1vH8qbib67jvqGNdF00VOTC/JCePt492lKh
	fvFcj3e9k77oRERqxezwxE3p3v3sChxywSnJZTxcr4r0qT2M6y/dvANCESWKIvwI/7uzhVGJUKydC
	MtW2NR3etRXq2NsN7B0qfx+01QTsIwtcIWmXIwxSgiwgU0Lk1f2RBabBWAV12vbFm134zzrbiYPDs
	RZWN3nCXB9pcvNX+IHjITJffJyhzl7UBaP+sksf92Czfx/4vy50tQynQf+t5sUPCRKmjbjW92QFBH
	gNHcigZwVbZ9t1UB1A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t3OJo-00CtGr-0a;
	Tue, 22 Oct 2024 23:29:40 +0000
From: linux@treblig.org
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 4/5] drm/client: Remove unused drm_client_framebuffer_flush
Date: Wed, 23 Oct 2024 00:29:33 +0100
Message-ID: <20241022232934.238124-5-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022232934.238124-1-linux@treblig.org>
References: <20241022232934.238124-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

drm_client_framebuffer_flush() was explicitly added in 2020
by
commit c9c03e3cf072 ("drm/client: Add drm_client_framebuffer_flush()")
but has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/drm_client.c | 33 ---------------------------------
 include/drm/drm_client.h     |  1 -
 2 files changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index bfedcbf516db..5d10ad3c2ca5 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -552,39 +552,6 @@ void drm_client_framebuffer_delete(struct drm_client_buffer *buffer)
 }
 EXPORT_SYMBOL(drm_client_framebuffer_delete);
 
-/**
- * drm_client_framebuffer_flush - Manually flush client framebuffer
- * @buffer: DRM client buffer (can be NULL)
- * @rect: Damage rectangle (if NULL flushes all)
- *
- * This calls &drm_framebuffer_funcs->dirty (if present) to flush buffer changes
- * for drivers that need it.
- *
- * Returns:
- * Zero on success or negative error code on failure.
- */
-int drm_client_framebuffer_flush(struct drm_client_buffer *buffer, struct drm_rect *rect)
-{
-	if (!buffer || !buffer->fb || !buffer->fb->funcs->dirty)
-		return 0;
-
-	if (rect) {
-		struct drm_clip_rect clip = {
-			.x1 = rect->x1,
-			.y1 = rect->y1,
-			.x2 = rect->x2,
-			.y2 = rect->y2,
-		};
-
-		return buffer->fb->funcs->dirty(buffer->fb, buffer->client->file,
-						0, 0, &clip, 1);
-	}
-
-	return buffer->fb->funcs->dirty(buffer->fb, buffer->client->file,
-					0, 0, NULL, 0);
-}
-EXPORT_SYMBOL(drm_client_framebuffer_flush);
-
 #ifdef CONFIG_DEBUG_FS
 static int drm_client_debugfs_internal_clients(struct seq_file *m, void *data)
 {
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index bc0e66f9c425..560aae47e06d 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -165,7 +165,6 @@ struct drm_client_buffer {
 struct drm_client_buffer *
 drm_client_framebuffer_create(struct drm_client_dev *client, u32 width, u32 height, u32 format);
 void drm_client_framebuffer_delete(struct drm_client_buffer *buffer);
-int drm_client_framebuffer_flush(struct drm_client_buffer *buffer, struct drm_rect *rect);
 int drm_client_buffer_vmap_local(struct drm_client_buffer *buffer,
 				 struct iosys_map *map_copy);
 void drm_client_buffer_vunmap_local(struct drm_client_buffer *buffer);
-- 
2.47.0


