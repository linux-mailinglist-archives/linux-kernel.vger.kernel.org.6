Return-Path: <linux-kernel+bounces-291019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD9955C40
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C5B281ED2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F8B146A63;
	Sun, 18 Aug 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CUloWEMS"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0F4DA04
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977830; cv=none; b=Cl6evhQX+YEYs9ID/oF5GwmZFOekHDFiwmumrvPAXZcCQ8/KP5liR98t9rkNAht1Mts5ukj5t3qxhl04kF3qFhK6sS5GOshQpOn/75EwPvQEdMmX/xqJIe9+BRhb55zs+2QlnOXUUQsDDdoUcvuR2JD5BCLkxERKHp4nU4ZTxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977830; c=relaxed/simple;
	bh=egW2yxJoVHO8L9Qj2nOkUgi3LPFo8IuMg/0XCAJcySs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ExTWcd7SN7EmQNt+xsYnmGaPTA8ka9NpG80Pa4PICR+q8w+eN0kwhBF5dpbLE7mWU/iFX15BtZYuy6zyC9nisuRSpWCQmatRvgbIAZpzTXjpl8nT639nxzjfrrYwBbaauQODPmYnjnhCdgI2bkCGAowezNtruKgujURZ6EjiVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CUloWEMS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=egW2yxJoVHO8L9Qj2nOkUgi3LPFo8IuMg/0XCAJcySs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CUloWEMSusPCYujVRg7X4GHX3L6Mhmj079byOzFcuXodqvWZKzAx+YN6znvXy/ExG
	 R4BJJs6PN4jDwxPeVddoShZvwhjMgCY/daRXJRG6+c9uQb3SKxKi7rKdqXst1ibg0R
	 Qb6CfLE7UndSOqpGnngeB+YijvYPzfsG3pFwnj3E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:29 +0200
Subject: [PATCH 05/12] drm/amd/display: Constify raw_edid handling in
 dm_helpers_parse_edid_caps()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-5-aea66c1f7cf4@weissschuh.net>
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
In-Reply-To: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=1803;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=egW2yxJoVHO8L9Qj2nOkUgi3LPFo8IuMg/0XCAJcySs=;
 b=KCJ5usCuvuNccDdqHeBOG4t930/Xd/jo/7BqqPm3k/nOSL83ZqBtJnbURJIG6Dt4l63PTB9Nz
 x+pjRj/R2w3C8ZE/Ki2FYJUEzb6eIl0dMEGLfq2E9cjC7XvsLrvZzUa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The argument edid is passed in as const.
Preserve this constness through the edid_buf variable and the used
helper functions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3cc0808f391a..98d1d5abafa7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -45,14 +45,14 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 
-static u32 edid_extract_panel_id(struct edid *edid)
+static u32 edid_extract_panel_id(const struct edid *edid)
 {
 	return (u32)edid->mfg_id[0] << 24   |
 	       (u32)edid->mfg_id[1] << 16   |
 	       (u32)EDID_PRODUCT_ID(edid);
 }
 
-static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
+static void apply_edid_quirks(const struct edid *edid, struct dc_edid_caps *edid_caps)
 {
 	uint32_t panel_id = edid_extract_panel_id(edid);
 
@@ -94,7 +94,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_connector *connector = &aconnector->base;
-	struct edid *edid_buf;
+	const struct edid *edid_buf;
 	struct cea_sad *sads;
 	int sad_count = -1;
 	int sadb_count = -1;
@@ -106,7 +106,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	if (!edid_caps || !edid)
 		return EDID_BAD_INPUT;
 
-	edid_buf = (struct edid *)edid->raw_edid;
+	edid_buf = (const struct edid *)edid->raw_edid;
 
 	if (!drm_edid_is_valid(edid_buf))
 		result = EDID_BAD_CHECKSUM;

-- 
2.46.0


