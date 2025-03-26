Return-Path: <linux-kernel+bounces-577022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571FA71770
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E2416C086
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346461F3BB6;
	Wed, 26 Mar 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WLTTIzNA"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276B1F37C3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995411; cv=none; b=jcJWasY4cL3IDKNtGNvQt+J43QK8DsEYr09k3tyUnBMmw1wTDmXvfjDBrBtdOgwFLV+wY/HYWzMlE82lOYu9hDC7WjdfE/AONJNo+VuNPXp8M26oByaqh0dgbbGqL/Aw5vrrTMZ6tT6sAzFflMvROxTgauRVm/vTjfaVfGGZckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995411; c=relaxed/simple;
	bh=jcF9TO4w0dmiNuHteMC+0VDVhFz7gX4DbHPqYH+9J6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrqzHeCnxxNxC0OABEs3t4n3H59aVLOttyr2qxTYM3vWqmsgBO+bM295ftYWNGBRZq3PFyAeVt6VWhDhkm/4DtIOC9pB1rTBD+d1sCrWJ0j+rQG+PRC5v75DHgZNtw4ZNzWPeQSUzxZ3OMc5u4AzUDduzAiyLZ1N5TV4MkJoSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WLTTIzNA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14C4D3A4;
	Wed, 26 Mar 2025 14:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995295;
	bh=jcF9TO4w0dmiNuHteMC+0VDVhFz7gX4DbHPqYH+9J6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WLTTIzNAdhu7DvJDB50Hue+//7gx//fikESz3rs93klbq4pgA7qcVUhpTkdHIH6IY
	 gZE3ExDVChGdN1Bb6apRqxnD/8vo22uqnH6Sx3TPgzaqeTbXqoCBgDVzJPmM5WmLBj
	 LMpwMZ8GeVFKOQY4txrrnJiV+ucB2sQ4qwfOwmC4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:50 +0200
Subject: [PATCH v4 07/11] drm: xlnx: zynqmp: Use drm helpers when
 calculating buffer sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-7-322a300c6d72@ideasonboard.com>
References: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
In-Reply-To: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=jcF9TO4w0dmiNuHteMC+0VDVhFz7gX4DbHPqYH+9J6g=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//CxwjQCxfCSYBd/57M8nhf1B6TSoA1vIgAw
 KG3PG88lXqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wgAKCRD6PaqMvJYe
 9cVeD/0d/pGBJTsHz/I3Ndq6vUJ4NHw057fP6nYmZPy1bX2FjRSjMzjBlUmqNcyQV1GkzfDm26L
 QI+HUNM/djIm7TQ2lgKi64TEw78vTLXCM6FKAWy0o4LBdgiJHoQlrb5MvzAnkCKaYhwiLBBTnMJ
 wk5ZtduxQ8JHWs0boUb9aZGKgtbW6UH9g0dxpU2SloU4uDHEwGiMlkHlDJuzQcs1uJse2NJWhFU
 ia+iJ2ogOhVL8h5tvdMa0aT3EQ1FBUtY8rU1KqvtwZgl9fuJQWGc2Un17+Wc4VUlkuqEY/v1HCi
 EI6Si+Th/pZ3uouFOL6MwIM5CBiacAghwqU//hjugrZ0Dj47p1zsgPfiAWADTdJAwpXZiKf6H/E
 LHKtBXXSvGFwVOFTkfscjaoUyI2fimViuxy9NmPE2LYjHfhiIwybxu8EG1NDGe5H4fkCTMhlyi+
 Zwwe8oNcizdS2bKZnLtXRbasyYnd37ew+Ey/jVndJbHwK+gR91LqYWrYJp6aPFW9hX85APL5lCk
 6z1e7aud/ISe1VXpSP/c5Cg6hcRnHtgyXAEp+qRqKhx5dEU/MOnLyukq8rVdueEnaPN326g4d6o
 2xLw9/8iXg/ciW7VAMVEVK9/uA8KX5CXTO6c7zYKgwTr9y3k/HHbC+n8kZ+F2CHBGf2znq+lF1D
 bhTfL90pN0YOiIQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use drm helpers, drm_format_info_plane_width(),
drm_format_info_plane_height() and drm_format_info_min_pitch() to
calculate sizes for the DMA.

This cleans up the code, but also makes it possible to support more
complex formats (like XV15, XV20).

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 80d1e499a18d..b9883ea2d03e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1116,16 +1116,19 @@ int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
 		return 0;
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = state->crtc_w / (i ? info->hsub : 1);
-		unsigned int height = state->crtc_h / (i ? info->vsub : 1);
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
 		struct dma_async_tx_descriptor *desc;
 		dma_addr_t dma_addr;
+		unsigned int width;
+		unsigned int height;
+
+		width = drm_format_info_plane_width(info, state->crtc_w, i);
+		height = drm_format_info_plane_height(info, state->crtc_h, i);
 
 		dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, i);
 
 		dma->xt.numf = height;
-		dma->sgl.size = width * info->cpp[i];
+		dma->sgl.size = drm_format_info_min_pitch(info, i, width);
 		dma->sgl.icg = state->fb->pitches[i] - dma->sgl.size;
 		dma->xt.src_start = dma_addr;
 		dma->xt.frame_size = 1;

-- 
2.43.0


