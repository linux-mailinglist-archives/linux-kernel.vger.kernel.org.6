Return-Path: <linux-kernel+bounces-365237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F099DF55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A221C20FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295CC1741DC;
	Tue, 15 Oct 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5RxPUCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18F4C7E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977481; cv=none; b=fM9BIZTzMqLVWSj76yEEeYzQI/m2F2PM50ZCbRer94MEby1E1xF8ZGge/vmAFyJPRKWq95z28zR5A29zPXhG9l8Uz6V67B4+Veb2TV54HEvrOHDtfX/1KPUnv5FNCRs9oUzgg55NNdwY/4/aEgcT7Ivo7gyHkxotnIGIfOgGxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977481; c=relaxed/simple;
	bh=Q9g8DeRx0E0haActJkNDnfZjJ2WLhwa/6Ap91qIZX7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTd2d+3ZcTWsRmqJ0XPs+T41a/7cv3vswwUmcc4fS7NqUJl77fRqdj38EcR41gtwGF0lTE3xL1EcW/hqY3HCZnb1hkvhQ+2d/2+VBT/XC5F98ELxW/gJHtN4nSluQxQwB34cc0WeWUHHWiGihHusE1rU/Yza7p8e01i/fD0RYBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5RxPUCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E8C4CEC7;
	Tue, 15 Oct 2024 07:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728977481;
	bh=Q9g8DeRx0E0haActJkNDnfZjJ2WLhwa/6Ap91qIZX7M=;
	h=From:To:Cc:Subject:Date:From;
	b=c5RxPUCreYGHsx0j/dGQl6LL7wZ+FBGyDJ3m+SJVfIjuxcL5IJSxhkVW/9n79cAyU
	 /dLhI0uvfp4UbECZ6JF7FmLB5lNrKbCyS5wueTrIyrUsVfe3Jj5x1gJ8rPt9DxNdP2
	 v9vQzRbheD1QYTC8mN2R4uP/L6HrvKNS8D0Iuf/s27HNYNTEzX18+tcvcokt8IWCkH
	 +/aniVFuzpCT4Vgd3xSo/xWzKC6x2SJ/YwVHNCf1cwotSTWkMT15DbPYJYRYx/Dhg+
	 7S6T0ONzw1hOrru5DkSlDF4oH/xmy/isQYFZ2M6/c0YEzCH016s/RUOrsJkxxL+S3w
	 ytOKF3BweUOHA==
From: Arnd Bergmann <arnd@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: s6e3ha8: select CONFIG_DRM_DISPLAY_DSC_HELPER
Date: Tue, 15 Oct 2024 07:30:50 +0000
Message-Id: <20241015073115.4128727-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new driver needs the dsc helper code to be available:

x86_64-linux-ld: vmlinux.o: in function `s6e3ha8_amb577px01_wqhd_prepare':
panel-samsung-s6e3ha8.c:(.text+0x16b1e65): undefined reference to `drm_dsc_pps_payload_pack'

Select it from Kconfig as we do for other similar drivers.

Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index ddfaa99ea9dd..ffe7eff71496 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -626,6 +626,7 @@ config DRM_PANEL_SAMSUNG_AMS639RQ08
 config DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01
 	tristate "Samsung AMS452EF01 panel with S6E88A0 DSI video mode controller"
 	depends on OF
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_MIPI_DSI
 	select VIDEOMODE_HELPERS
 
-- 
2.39.5


