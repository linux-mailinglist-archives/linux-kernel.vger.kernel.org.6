Return-Path: <linux-kernel+bounces-277802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4337D94A6AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C660A284FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27D1E487E;
	Wed,  7 Aug 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="RHiWTX6B"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761B1E4852;
	Wed,  7 Aug 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028934; cv=pass; b=EQPic9O3awWc6IrW6U3ww2K69hWzIPPDBUedTc1SV/3Xwm2OTE93G2R4+DcMJGoMnu31cgRo5IUIhAApm8Uu3FxEbR3xo0n5+xXieetsIy+cstyF7dm/3u7LLnvaXzuUVs63o8BJMH7J7hyYh5ToUieyEsWSWhr8QbSv7yvzCwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028934; c=relaxed/simple;
	bh=Kx/yVuM43mDepbPaRgEjqT5PC3uo3P95zYyHloI1AUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQ8hFAilScoxQ3MVE+D3z3XvDK3d3sVmr7glP+q26vE1XT2qIG1G0Gbri//QXSSWyWq3t21Zwn16bXYV965dJOxfvDkYB9AQKcEmWNGItrLmkjRyOUVBgY300r1TSpAkGVrTTcwLt8O6r5YGDcdEF6NMta716tiE0Ec5v+7QFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=RHiWTX6B; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723028896; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nwDcFS+XVFi0a4twvEviFIqeAstYMHzekutR5w2dKOp6Grj39TpvK9mnyMDq4j1af4Bg2jF0jiY92cOUPTQugVSCb48EDFs7ccEsxnu5BO8i9ypcPk5VQhh51V8/ReWN+1dYoNgPvcaC/ryP6JdwyPg7DRl17dfmDOqKi5xuGnI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723028896; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EkC4WSUbPnQOQmSPBmNPJYFUfUrufucZSvrElYLGaGU=; 
	b=lxDMw9dX9fvHF5QkwCf8CRFskdOG926owJw38dspYKOWdDXJUO5suvCjyd/RgZEyxCaQKSfKnuM2ULzmsriqQqsuvP0nE9QKNyf6bXCmSShaQCTttu65ae9Tr76wRXR2UwY3gI4JMt4R/57YaPt0SrdrTOwDgVgqpBdAnNZ1WNQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723028896;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=EkC4WSUbPnQOQmSPBmNPJYFUfUrufucZSvrElYLGaGU=;
	b=RHiWTX6B3JQkP6UmNE1AzOwuKuyZV9R7Ap1fziuSBIjogX0IMAgRbujv2nbF5L8W
	91SF76ffsGndBaeXnpX5IzAOSD0IM+ACs03mArUk6P9Ib1kUNxcX/yjSQKw05rQv1+/
	Rgbz6F9LKcZo3ttt2CwNPwlLChap4hhyi71lBv1o=
Received: by mx.zohomail.com with SMTPS id 1723028895968785.0625405019965;
	Wed, 7 Aug 2024 04:08:15 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 07 Aug 2024 14:07:26 +0300
Subject: [PATCH v3 4/5] drm/rockchip: Explicitly include bits header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-rk3588-bridge-upstream-v3-4-60d6bab0dc7c@collabora.com>
References: <20240807-b4-rk3588-bridge-upstream-v3-0-60d6bab0dc7c@collabora.com>
In-Reply-To: <20240807-b4-rk3588-bridge-upstream-v3-0-60d6bab0dc7c@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

Driver makes use of the BIT() macro, but relies on the bits header being
implicitly included.

Explicitly pull the header in to avoid potential build failures in some
configurations.

While at it, reorder include directives alphabetically.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index bbb9e0bf6804..8d566fcd80a2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -12,9 +12,10 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem.h>
 
+#include <linux/bits.h>
+#include <linux/component.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/component.h>
 
 #define ROCKCHIP_MAX_FB_BUFFER	3
 #define ROCKCHIP_MAX_CONNECTOR	2

-- 
2.45.2


