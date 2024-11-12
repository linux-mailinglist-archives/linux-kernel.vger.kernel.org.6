Return-Path: <linux-kernel+bounces-406535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF39C6359
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB5FBA3154
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C11218D6B;
	Tue, 12 Nov 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J4NUoEcA"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB61217F47
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436469; cv=none; b=t2r0sU0vVCg3apSEyH2LnkAQeVLn2y4iUYxhZBDwyV/6d6OOFw3uOEV4Pg6SLCt1Qo8uN7xzIOCzC6zF4DGxIoP1RQgbmxJjztvCeytQEVuSLRNepyepNdf9FEDFQJASVDZTDvJoWiW7F72hshg5SCfT0NM+J1oJbNwogVvpu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436469; c=relaxed/simple;
	bh=ggkrDQamEbfGikQ2/25kOxpC8sUxK9EY9OaS4uOE/dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRVuDSrs+OQTT6UZtcTtcL8DSu0X8LTMB2WvCdf6YUFkzf1BX/tGc/pshQNnrwEZXRNzBG0rVSZd0Jdy1Iv1q0FwHTXOOePzDukO3ofI4Qz5HRm9DfwBoAXI/3XXnM47iDFAGsQweqtRI7FowupW+wfU0N8yanpDhRS5wx2BN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J4NUoEcA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436454;
	bh=ggkrDQamEbfGikQ2/25kOxpC8sUxK9EY9OaS4uOE/dU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J4NUoEcAdZeAt8taC6/Lj1BcPHirHx/vAyF+tQwxuxR2HVhovJCxuSTBf5LGKKeOI
	 YkwP+NF7fwQag0eTVkXLFPzVMyOtwd8DTGrvh5/0cd4UrIVELnnlSMdjWS09Wz+DBe
	 rplLcGr2bF1JQPA4HsrbOWrFJJ9wrjqU22rBwwqo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 12 Nov 2024 19:34:11 +0100
Subject: [PATCH v2 2/7] drm/amd/display: Remove EDID members of ddc_service
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-amdgpu-drm_edid-v2-2-1399dc0f0469@weissschuh.net>
References: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
In-Reply-To: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 jinzh <jinzh@github.amd.com>, Aric Cyr <Aric.Cyr@amd.com>, 
 Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436454; l=862;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ggkrDQamEbfGikQ2/25kOxpC8sUxK9EY9OaS4uOE/dU=;
 b=/iJkJN3erXCyOgDcpF8uIbF9tLE+ktHmsPCK/iB3Y2eVFH5wLWvMP7/bamfB90mvNxmRMI4a6
 3wdqYs8fAeLBAdEX62rQBxUAeen+hM2wqhEKK+L3mic5taogpoo2+9W
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All usages of these fields have been removed.

Fixes: 7c7f5b15be65 ("drm/amd/display: Refactor edid read.")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
index 428e3a9ab65afb2fd146253b7db08e0571a12983..7dd1cfb9ab763c1e37d1cf6e27bbe4790a732f5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
@@ -189,10 +189,6 @@ struct ddc_service {
 	enum display_dongle_type dongle_type;
 	struct dc_context *ctx;
 	struct dc_link *link;
-
-	uint32_t address;
-	uint32_t edid_buf_len;
-	uint8_t edid_buf[DC_MAX_EDID_BUFFER_SIZE];
 };
 
 #endif /* DC_DDC_TYPES_H_ */

-- 
2.47.0


