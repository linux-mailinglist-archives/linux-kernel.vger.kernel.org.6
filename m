Return-Path: <linux-kernel+bounces-269592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBEE94349E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B481F22C12
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4F1BD4EB;
	Wed, 31 Jul 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KDT8pI8E"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2151B140E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445256; cv=none; b=KfE/QyRsQIVvLMdYUXbck/KPFN1WgNGoBEAc6PCqSZuCyLNFIW2Y6ox18eDZQ9dMAD3EFrLUMiIDcYCkRVQmvlwI3kEasXCuJDqKdI4mnvPa4ylTpfIT+mPQR4YT3zuMZLB8e6IcbpUv2IE9QZK43Tyd5D6EkeOJuRX10lOy3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445256; c=relaxed/simple;
	bh=43fWu65ahIpq44m9rON/hw4CQ9V4doMziHt54yTlBJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pracKbG4om6Hx7d3q8iIe4/kOac2EMYA8oXqrfOOzkGsVUHUYpPlwlJqJejCzQCaX+IWwfwZd1CMTjsNr+RtEQeFM9NgKnI9yg1/j6sc9AbI/MpQz0a+GthGNDxBLV4hmBw06yGS6L/MMe9p+Ir0VjdyJrJV7WLSVmRoi3SrlGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KDT8pI8E; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722445249;
	bh=43fWu65ahIpq44m9rON/hw4CQ9V4doMziHt54yTlBJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KDT8pI8EDndfMwfy6JXzaMlNbU0ntozOhTxAe9Zb9JRmAAYQmIHresilA47UNmRn+
	 Ph9AgnOukvln8Rvv10azxNHwexz6IkngR3kvr4rOV3MVeKw78Ae8tgpzAN/UcBBNom
	 A+rCE3cGTS1WXrvvtrplNBcwehwrPjPX0lICsNHc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 31 Jul 2024 19:00:47 +0200
Subject: [PATCH v3 2/2] drm/amd/display: implement minimum brightness
 override
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-amdgpu-min-backlight-quirk-v3-2-46d40bb21a62@weissschuh.net>
References: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
In-Reply-To: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445249; l=1442;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=43fWu65ahIpq44m9rON/hw4CQ9V4doMziHt54yTlBJw=;
 b=mvJubKuaHtZBkENwO11yIlMdmHS9DFCZHAPoZXVILB1oIMee6smLON2xWexjvPUb4Av+LndQF
 QJ5vISGBRbuBA86TkoRc4QVhAqEzrITSdmfwpEC+8Wo+CiCbwMZW5DB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is useful if the minimum backlight as reported by machines VBT
does not match the user expectations.

As an example, the minimum backlight brightness on the Framework 13
matte panel is too high.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e7929f24ae4..ae15465cacfc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3330,6 +3330,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	struct drm_connector *conn_base;
 	struct amdgpu_device *adev;
 	struct drm_luminance_range_info *luminance_range;
+	int min_input_signal_override;
 
 	if (aconnector->bl_idx == -1 ||
 	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
@@ -3364,6 +3365,11 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		caps->aux_min_input_signal = 0;
 		caps->aux_max_input_signal = 512;
 	}
+
+	min_input_signal_override = drm_connector_get_cmdline_min_brightness_override(conn_base);
+	if (min_input_signal_override >= 0)
+		caps->min_input_signal = min_input_signal_override;
+
 }
 
 void amdgpu_dm_update_connector_after_detect(

-- 
2.46.0


