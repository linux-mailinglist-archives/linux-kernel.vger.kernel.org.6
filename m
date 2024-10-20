Return-Path: <linux-kernel+bounces-373497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C769A576E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34501B2128C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392D198842;
	Sun, 20 Oct 2024 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="THlPNNxE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A518E02D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729465716; cv=pass; b=LMVNY1bSe1h6Rh0UpcMjLRhJFe1dxnfQbDuwKhPTkqpNxkN1lg8YLqkb2Iylao8MSCwRMr05vwUkrvwVHJ8gBfYPlENbPiMWKVMK/w6foanMtjRZRDPp+WaDsc6BVdw4Tf48fokb+Vaf5IPLy/ejWKuNhVadX32iY6HlGYwUeo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729465716; c=relaxed/simple;
	bh=YfEgQmO1ikrRixC461fg1HqEnYdJAQdexiT4ReCHWaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1tlCo2GLnyrYddwNpMvViDRLxtNZh0NIXcVXZdwUeUDqCSI+In5wLHDcJsuGqDn3oleDnLbKEf879gclGYPuKO54LktXgM8vpOWI6m2t1v8gv2Tkh6/nD7kZ0xbS3NT1zBQJKkEI9TRiZUFUWi6nQmHCYViWACPYFVnh7ce9vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=THlPNNxE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729465702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D+1o7U874WpHlTXDCtqbOh+ssvMMgzgDE9PpmEQPKDl1mdkfbT2eJULemfy1TyoCdWAYleDKBZNJlyXdO6x7f+oWF3B6WES/PSa+Z11BLI3gXnlCPGkjIT23ZHkE4O/wKDhbZ2olraG8IHPEMXPOJwqN0w4LUFqet0zXk8SYj4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729465702; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QUkPTOlGyWw+AZuIDWbKQ0xAxO7TTNNP9+8fJZE01SU=; 
	b=fX5nxoK/Q1FUyhnBvXt38g1xKgqMT2pgzvYKUONgj/ujGMcQJ7DjZKY5fUQp2a9h3Do6iPcNu+CgrKdNAk8y1w0ruKX6Iz3MgHyzjlTe044zrpALHoY7aFEj2HkGHDSuo3o3lhs/FaDHHofHHNhA+JY4ByTPln4a5RLM3ROI48c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729465702;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QUkPTOlGyWw+AZuIDWbKQ0xAxO7TTNNP9+8fJZE01SU=;
	b=THlPNNxEHMA4uJhV+TrE6Uk2kmSyZV6PlTZoquzIK7+tXBhWYu8Xwr0SxkF3zgtc
	tZF+fuiBW+qssp5AggF7J+gRaIu/oV0e0KG1oLYqlm5OuNbCpqJXFt5zLUB2nTn/SJb
	I/Y6ElNEcFpazYWlTCORnIJn26B894oLv0JDiy8Q=
Received: by mx.zohomail.com with SMTPS id 1729465701126132.5895378723742;
	Sun, 20 Oct 2024 16:08:21 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Kim Dongwon <dongwon.kim@intel.com>,
	Kasireddy Vivek <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v3 1/2] drm/virtio: Use drm_gem_plane_helper_prepare_fb()
Date: Mon, 21 Oct 2024 02:08:02 +0300
Message-ID: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Dongwon Kim <dongwon.kim@intel.com>

Use drm_gem_plane_helper_prepare_fb() helper for explicit framebuffer
synchronization. We need to wait for explicit fences in a case of
Venus and native contexts when guest user space uses explicit fencing.

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
[dmitry.osipenko@collabora.com>: Edit commit message]
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a72a2dbda031..ab7232921cb7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -26,6 +26,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_gem_atomic_helper.h>
 
 #include "virtgpu_drv.h"
 
@@ -254,6 +255,9 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 
 	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+
+	drm_gem_plane_helper_prepare_fb(plane, new_state);
+
 	if (!bo || (plane->type == DRM_PLANE_TYPE_PRIMARY && !bo->guest_blob))
 		return 0;
 
-- 
2.47.0


