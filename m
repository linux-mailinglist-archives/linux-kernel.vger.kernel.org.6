Return-Path: <linux-kernel+bounces-511319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C2A32957
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F9B3A8A66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476FA21D5B8;
	Wed, 12 Feb 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qwXrG7ui"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346902135B7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372225; cv=none; b=syehgORuimmGBA0B6EjTcAi8+LgiqGXtJim6viPW9ckSlJpLsZaccefjGC83ryY0Amf5X1+0iJL6D+cRVNP9xKD9Yi+CSXE57yXkT1e28nMuI8HZLKjx+9ygawq8gZMOZVOw1lpmNKMvTE/ylNfC5kk/8ZO0LI1qazbVpe4S8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372225; c=relaxed/simple;
	bh=CRfYdoayFbIp4SyGxcS3wIpdPP0eZRvOi5wwLjCOvoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jy7eHqhDWh/e5zIfREB5RUuZIAfc4yhKxrxdjE81IOg4jeZTyC/Ptb6zLjKwFJKpkuNrKaohy4zdM1xnW19Mq4wygPxyKxCBT37sqIzXlJ5PXN8EUCIh7rhK+obYLL63cZ8uwBO5q3kmzhQctp21CRSw3r6zgWmMUnkq+vAOWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qwXrG7ui; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A661A198B;
	Wed, 12 Feb 2025 15:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739372134;
	bh=CRfYdoayFbIp4SyGxcS3wIpdPP0eZRvOi5wwLjCOvoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qwXrG7uiJBZxam5s89XlqQmlnbU8NQUxHri5R+3c9ofN5nBOYD2PzwV03xO/7w8tA
	 8PsRXxOggaRi2cTOFTK7c6auQjSahUpZC+sXzMnz6LAv0jTZxPFFPd0cfwmZXOG9H9
	 18caTxfuz2/gWyh901DTkP4tXJuKdF1aJP4mprJA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 12 Feb 2025 16:56:11 +0200
Subject: [PATCH v3 07/11] drm: xlnx: zynqmp: Use drm helpers when
 calculating buffer sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-xilinx-formats-v3-7-90d0fe106995@ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
In-Reply-To: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=CRfYdoayFbIp4SyGxcS3wIpdPP0eZRvOi5wwLjCOvoY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnrLaq+b90zO1HRXn8B2y8d733NS7mUJvL0COyx
 U1Uf6sENn+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ6y2qgAKCRD6PaqMvJYe
 9S1WD/93TM2J0i0Ao4HnmOCzbUagRtCb3RKRhvZ5DYtZ4oIj5ma0tSlqNNHQYaodWj8P24l8hCm
 cyvalkwyBpBm6xiIkBoN7mg2bCg8pL5R2og+JjiAzyABJ9HqiU3xbEFg6lP3lrXUxjg/FMmMElR
 Mw3f2MHGEaMNyLdrn6UnRgmpjLcBqeboXhi7rUP+NW4y/6FrhFfulGCkBqUi5m4I35FJWrz4C+E
 AzybIypjcyNOz9UDK3nmF3VIDK2JGxZkMWiMbaBebcUiRL7/GKSPI1fsAz93/x3djpOLxXkEVBB
 y0TbBjkVB6ZebvKqZMiSkTcu3E2HjwvOamg7g8BSWNVSXo0P2mITZReckmYWbEIQP8M51ytaXAC
 eALAAueYbYcED/5M/6Hz7DTvPbH0HO3q190dviTtrrE0gEvZusFVzIwlwZc0HtDmah9QmOxPdfS
 qULWIE7FiMK8eA9C3fUyA9GW4QaDqN2pmA8nm4bmg/591x0mSB0N3WRNOqJ/DbDL9bQZQMe1GOR
 OA6GeWSU+QHxg3KoljtdpyAaNYUxJKifNCIvHKaE86wke6xwIinzjyXM/pl2vOay8F9BnZD+Wx1
 MYCEHgz08G2sOGrNBOCwQTSOqgEbUEgYLZcYhYTGH3rREK/bZTq9/o7Upp1usfSxqa0U2M+1Ts7
 5eqtc+9e3RLmtxw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use drm helpers, drm_format_info_plane_width(),
drm_format_info_plane_height() and drm_format_info_min_pitch() to
calculate sizes for the DMA.

This cleans up the code, but also makes it possible to support more
complex formats (like XV15, XV20).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 80d1e499a18d..3d4ade571f0f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1116,16 +1116,18 @@ int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
 		return 0;
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = state->crtc_w / (i ? info->hsub : 1);
-		unsigned int height = state->crtc_h / (i ? info->vsub : 1);
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
 		struct dma_async_tx_descriptor *desc;
+		unsigned int width, height;
 		dma_addr_t dma_addr;
 
+		width = drm_format_info_plane_width(info, state->crtc_w, i);
+		height = drm_format_info_plane_height(info, state->crtc_h, i);
+
 		dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, i);
 
 		dma->xt.numf = height;
-		dma->sgl.size = width * info->cpp[i];
+		dma->sgl.size = drm_format_info_min_pitch(info, i, width);
 		dma->sgl.icg = state->fb->pitches[i] - dma->sgl.size;
 		dma->xt.src_start = dma_addr;
 		dma->xt.frame_size = 1;

-- 
2.43.0


