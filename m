Return-Path: <linux-kernel+bounces-394132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5669BAAEC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C94281B83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0B16190C;
	Mon,  4 Nov 2024 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="R21pVjKJ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57092F5A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687955; cv=none; b=PpNj7FeqGGt8Z+WBWmwAoRXwazCKXlY1SJCmxnq3wr/HgT4glQIu2eeNZ/+ktosQpERDXqdI5RRZkQfgyQs0p1Z6i3ZrSMbBxzkqdJou/6+VZPmiD6dFnRt1mBuvWjwswZH1ghhYtGS+hdiceTRm59BhbhIXIObuup0jACFw+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687955; c=relaxed/simple;
	bh=0pOKRHGMFpn1GMUxaEpdDr5c4f1N4toWzCFymdRfqK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6uM1fHsRRhl5cNaJ+KaOK3d3kklTxrzf6j3jxn1Vfm27IkxxIJTUoiQCUu9tfoUQCQE+Hk7yXfaZv0nPQJMfxJH4lUOkhOTqMrtliffT1pwX5v0jlrP0OWoBJYjN0j/H7ow4w6Y8j60Nnu3aI2aWIFXAU36jM0iDuVHv2h6WMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=R21pVjKJ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=X0uvyntT+nixWmfkfZaO+hewYcnx9FvDWP3oy6zAFw4=; b=R21pVjKJOa7pixZo
	6613J5exPmGrj/99v9eG6NRSLHGhXQSqpF7k+l7qCPy91ovUNztBlJX+rP9SrlRQjm2/h0eQbfuLS
	p46BVD7C0c9dIfHh9uBsz82TwWyVaLKVT29eljKH9d4SerQRO/JGKbgoMjM+4IkUqPclMmXo3nIPL
	VRHz5hy8OvdwohEpJioc2kj+cAkp/Eh3YN4T5V0B0xznWE5YQ7pf9n51qhHurPE//H8CMwDBctApN
	QZ+elVKat44BV4KuTHOn7io/8F6ydTXko5IyXWfoVbTEIvJqVoNgULNEy18LG+gu1USp/khM3gJ5C
	8r+jSvYUWNt0YTuV1Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7mzl-00FECw-14;
	Mon, 04 Nov 2024 02:39:09 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/5] drm/amd/display: Remove unused enable_surface_flip_reporting
Date: Mon,  4 Nov 2024 02:38:48 +0000
Message-ID: <20241104023852.492497-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104023852.492497-1-linux@treblig.org>
References: <20241104023852.492497-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

enable_surface_flip_reporting() has been unused since it was added by
commit 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 7 -------
 drivers/gpu/drm/amd/display/dc/inc/core_types.h  | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index ccbb15f1638c..3299684f9a4e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -83,13 +83,6 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane
 /*******************************************************************************
  * Public functions
  ******************************************************************************/
-void enable_surface_flip_reporting(struct dc_plane_state *plane_state,
-		uint32_t controller_id)
-{
-	plane_state->irq_source = controller_id + DC_IRQ_SOURCE_PFLIP1 - 1;
-	/*register_flip_interrupt(surface);*/
-}
-
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
 {
 	struct dc_plane_state *plane_state = kvzalloc(sizeof(*plane_state),
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index bfb8b8502d20..f241316aff82 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -45,9 +45,6 @@
 #define MAX_SVP_PHANTOM_STREAMS 2
 #define MAX_SVP_PHANTOM_PLANES 2
 
-void enable_surface_flip_reporting(struct dc_plane_state *plane_state,
-		uint32_t controller_id);
-
 #include "grph_object_id.h"
 #include "link_encoder.h"
 #include "stream_encoder.h"
-- 
2.47.0


