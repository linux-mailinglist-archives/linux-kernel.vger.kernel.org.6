Return-Path: <linux-kernel+bounces-251629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1901930751
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8575D1F21BDA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9836144D1E;
	Sat, 13 Jul 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IyjD/S2o"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5743ADE;
	Sat, 13 Jul 2024 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904010; cv=none; b=GfQMK81z5AyIN5VtiIrmNlRpOM7EJa2CYvBp+2qSQ9LtRutag8avemW5xGhYkaqu9t6BHvaCYnktlz8SrixeTG+33VHzLaQyL6wfinFUKADDCmCuNw6W6kTuCQqTAjrg+TEcSs2CKAop5QSj8P1NsOQcEPfUlPXgUqejDiQo/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904010; c=relaxed/simple;
	bh=YqVnxkNyfwSobbp8/+AVaXFAHvFW7N/bW9TOpjeQweI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShfKa+/rlQYpYdFBsCeIHpIDg6puOdDAfoxrFHDcax7qpgL1TOKNyOnbWWUjEmZe2nO4YM+KKymi+HonpJfKdooYLG3HsT3XJBFZq5rh1DaTeY/mLV5vSToUM/NymA7yYST98zhquF4ZSNUiEDG/5ymF82VSBv36Ho6gv15ucCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IyjD/S2o; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Sjj0sHlkifWRDSjj0skR4R; Sat, 13 Jul 2024 22:52:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720903935;
	bh=36Mcqh3lrdshkqWXw2v9j64RRGuxk5wAxlhTZZIAi7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IyjD/S2oU8pPRrxH+yjP+hhUglsP21Gcv+wbpA++OzN7k/RsMVxtamHkyrwJ4JP5y
	 KyvF8Kx0851tEa71BvgfSYCGrxjq2yOJ9lRGocURvqQdpr6LpI3ZWyZaEc3nm7c7WX
	 7QvjgBbAnUhf4fVlGDXaNdPAHL4GQrz9Zd+XcifWQFnkBRtVPzOdXadI/XnfcitgZj
	 M4JIytkd+NMG8LobPW2w++poSRHJB5nY4QC1mPuYR2zoRVX+EKQN01EFVnG+PXOzEn
	 2eGd9qwtF3yQG0AzEpnP+rV/n5nbwK8jfGTyFHN43kxXOzrzYAa5+KXfRWyZ7DrvO5
	 t6GJoTVJ/48gQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Jul 2024 22:52:15 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] drm/rockchip: Constify struct drm_encoder_helper_funcs
Date: Sat, 13 Jul 2024 22:52:05 +0200
Message-ID: <128f9941aab3b1367eb7abca4ac26e2e5dd6ad21.1720903899.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct drm_encoder_helper_funcs' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   7458	    552	      0	   8010	   1f4a	drivers/gpu/drm/rockchip/analogix_dp-rockchip.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   7578	    424	      0	   8002	   1f42	drivers/gpu/drm/rockchip/analogix_dp-rockchip.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 362c7951ca4a..d3341edfe4f4 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -262,7 +262,7 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
-static struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
+static const struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
 	.mode_fixup = rockchip_dp_drm_encoder_mode_fixup,
 	.mode_set = rockchip_dp_drm_encoder_mode_set,
 	.atomic_enable = rockchip_dp_drm_encoder_enable,
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 2241e53a2946..44ce0f581062 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -545,7 +545,7 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
-static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
+static const struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.atomic_check	= inno_hdmi_encoder_atomic_check,
 	.atomic_enable	= inno_hdmi_encoder_enable,
 	.atomic_disable	= inno_hdmi_encoder_disable,
-- 
2.45.2


